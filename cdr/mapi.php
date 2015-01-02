<?PHP
//exemplo
//
//$assunto = "nene";
//$patrao  = 'tche';

//Valores de Status do evento QueueMember, 
//mostra o estado do dispositivo
		/// <dt>AST_DEVICE_UNKNOWN (0)</dt>
		/// <dd>Operador esta disponivel</dd>
		/// <dt>AST_DEVICE_NOT_INUSE (1)</dt>
		/// <dd>?</dd>
		/// <dt>AST_DEVICE_INUSE (2)</dt>
		/// <dd>?</dd>
		/// <dt>AST_DEVICE_BUSY (3)</dt>
		/// <dd>?</dd>
		/// <dt>AST_DEVICE_INVALID (4)</dt>
		/// <dd>?</dd>
		/// <dt>AST_DEVICE_UNAVAILABLE (5)</dt>
	$queueStatusStatus=array(
		0 => 'DESCONHECIDO',
		1 => 'NAO ESTA EM USO',
		2 => 'EM USO',
		3 => 'OCUPADO',
		4 => 'INVALIDO',
		5 => 'NAO DISPONIVEL',
		6 => 'RING'
	);

//valores de estado para o evento Agents, este e o que mais me interesa
//de todas maneras o evento me devolve literalmente o evento
		/// <dt>"AGENT_LOGGEDOFF"</dt>
		/// <dd>Agent isn't logged in</dd>
		/// <dt>"AGENT_IDLE"</dt>
		/// <dd>Agent is logged in, and waiting for call</dd>
		/// <dt>"AGENT_ONCALL"</dt>
		/// <dd>Agent is logged in, and on a call</dd>
		/// <dt>"AGENT_UNKNOWN"</dt>
		/// <dd>Don't know anything about agent. Shouldn't ever get this.</dd>
	$agentStatus=array(
		'AGENT_LOGGEDOFF' => 'NAO LOGADO', //nao tive outra ideia de como traduzir
		'AGENT_IDLE' => 'DISPONIVEL', //Esta logado
		'AGENT_ONCALL' => 'EM CHAMADA', //Em chamada
		'AGENT_UNKNOWN' => 'DESCONHECIDO' //Nao esta disponivel 
		);
//Para ver os estados que estao em portas
	$ExtensionStatus=array(
		-1 => 'NAO REGISTRADO',	
		0 => 'REGISTRADO',
		1 => 'EM CHAMADA',
		2 => 'ESTADO 2',
		3 => 'ESTADO 3',
		4 => 'ESTADO 4',
		5 => 'ESTADO 5',
		6 => 'ESTADO 6',
		7 => 'ESTADO 7',
		8 => 'EM CHAMADA'
	);

    // Faco aqui conexao com o AMI do Asterisk 
    $socket = fsockopen("127.0.0.1","5038", $errno, $errstr, $timeout);
    //echo "############### Estou Logado  ###############<br>";
	
    fwrite($socket, "action: login\r\n");
    fwrite($socket, "username: provisioning\r\n");
    fwrite($socket, "secret: gsa2014\r\n");
    $actionid=rand(000000000,9999999999);
    fwrite($socket, "actionid: ".$actionid."\r\n\r\n");

	if ($socket) {
	   while (!feof($socket)) {
	       $bufer=fgets($socket);
	       if(stristr($bufer,"Authentication accepted"))
	       {	
	       		break;
		    }
			elseif(stristr($bufer,"Authentication failed"))
			{
			   fclose ($socket);
			   echo("Senha do Usuario Incorreto.");
			   exit();
		   }
	   }
	}    
    
    //echo "############### Executo comando: Agents  ###############<br>";
    $comando = "action: agents\r\n";
    $respuesta = exec_cmd($comando,$socket,"Event: AgentsComplete");
    $agentes=ArmaArrayAgentes($respuesta);
    //echo "############### Executo comando: Queues  ###############<br>";
    $comando = "action: queuestatus\r\n";
    $respuesta = exec_cmd($comando,$socket,"Event: QueueStatusComplete");
    $colas=ArmaArrayColas($respuesta);
    //echo "#### Executo comando: ExtensionState para cada agente ###<br>";
    //Isto para ver o estado interno do agente
    //Para melhor performance podemos comentar isto de pronto
    foreach($agentes as $agente)
    {
	$tmp=split('@',$agente['LoggedInChan']);
	//echo "#".$tmp[0];
	$comando = "action: extensionstate\r\n";
	$comando .= "context: internos\r\n";
	$comando .= "exten: ".$tmp[0]."\r\n";
        $respuesta = exec_cmd($comando,$socket,"Response: Success");
	//echo($respuesta['eventos'][0]['Status']);
	$agentes['Agent/'.$agente['Agent']]['ExtensionState']=$respuesta['eventos'][0]['Status'];
	
    }
    //echo "############### Ejecuto comando: Logoff  ###############<br>";
    $comando = "action: logoff\r\n";
    exec_cmd($comando,$socket,"Message: Thanks for all the fish.");
    fclose($socket);
/*
	$db = mysql_connect('localhost','root','gsa2014');
	
	$sql="select agent,count(*) as cant from cdr join "
		."(select agent,substring(info1,1,4) as src,max(fecha) as tim "
		."from csr_queue "
		."where action = 'AGENTCALLBACKLOGIN' " 
		."group by agent,substring(info1,1,4)) as pp "
		."on pp.tim<=calldate "
		."where pp.src=cdr.src and substring(upper(dstchannel),1,3)='ZAP' "
		."group by agent ";
	$result = mysql_db_query("asterisk",$sql);
//	echo mysql_error();
//	echo($sql);
	while($row = mysql_fetch_array($result)) {
		$agentes[$row["agent"]]["llamadas_salientes"]=$row["cant"];
	}
	mysql_free_result($result);
	mysql_close($db);
*/	
function exec_cmd($comando,$socket,$evento_fin)
{
	$actionid=rand(000000000,9999999999);
	$actionid="actionid: ".$actionid."\r\n";
	$comando .= $actionid."\r\n";	
	$paquete_mio=false;
	$data="";
	$respuesta=array();
		
    fwrite($socket, $comando);
	
   while (!feof($socket)) {
       $bufer=fgets($socket);
    	$data .= $bufer;
		//echo $bufer."<br>";		
    	
       if(strtolower($bufer)==strtolower($actionid))
       {
       		$paquete_mio=true;
       }
       if(strtolower($bufer)=="\r\n" && $paquete_mio==true)
       {
       		$paquete_mio=false;
       		$respuesta['eventos'][]=arma_paquete($data);
       		if(stristr($data,$evento_fin))
       		{
       			$data="";
       			//echo("Resposta a '".$comando."' completa<br><br>");       	
       			return $respuesta;
       			break;
       		}
       		elseif(stristr($data,"Error")) //detectamos uma resposta de erro do comnado
       		{
       			return $respuesta;
       			break;
       		}       		
       		else
       		{
       			$data="";
       		}
       }
       //else
       //{
       //		$data .= $bufer;
       //}
   }
}

function arma_paquete($data)
{
	
	$items=split("\r\n",$data);
	foreach ($items as $item)
	{
		if( strlen($item) >0 )
		{
			$tmp=split(": ",$item);
			$clave=$tmp[0];
			$valor=$tmp[1];
			$evento[$clave]=$valor;
		}
	}
	return $evento;
	//echo "evento".var_dump($evento)."<br>";
}

function ArmaArrayColas($qs_response)
{
	$result=array();
	foreach ($qs_response['eventos'] as $item)
	{
		//Testo se e um item da fila
		if($item['Event'] == "QueueParams")
		{
			//si es miembro creo la cola
			$result[$item['Queue']]['Queue']=$item['Queue'];
			$result[$item['Queue']]['Max']=$item['Max'];
			$result[$item['Queue']]['Calls']=$item['Calls'];
			$result[$item['Queue']]['Holdtime']=$item['Holdtime'];
			$result[$item['Queue']]['Completed']=$item['Completed'];
			$result[$item['Queue']]['Abandoned']=$item['Abandoned'];
			$result[$item['Queue']]['ServiceLevel']=$item['ServiceLevel'];
			$result[$item['Queue']]['ServicelevelPerf']=$item['ServicelevelPerf'];
			$result[$item['Queue']]['Weight']=$item['Weight'];
		}
		elseif ($item['Event'] == "QueueMember")//Testo se e um item da fila
		{
			$i=count($result[$item['Queue']]['Membros']);//indice do proximo membro
			$result[$item['Queue']]['Membros'][$i]['Location']=$item['Location'];
			$result[$item['Queue']]['Membros'][$i]['Membership']=$item['Membership'];
			$result[$item['Queue']]['Membros'][$i]['Penalty']=$item['Penalty'];
			$result[$item['Queue']]['Membros'][$i]['CallsTaken']=$item['CallsTaken'];
			$result[$item['Queue']]['Membros'][$i]['LastCall']=$item['LastCall'];
			$result[$item['Queue']]['Membros'][$i]['Status']=$item['Status'];
			$result[$item['Queue']]['Membros'][$i]['Paused']=$item['Paused'];

		}
	}
	return $result;
}

function ArmaArrayAgentes($qs_response)
{
	$result=array();
	foreach ($qs_response['eventos'] as $item)
	{
		//me fijo si es un agente
		if($item['Event'] == "Agents")
		{
			//si es miembro
			$result['Agent/'.$item['Agent']]['Agent']=$item['Agent'];
			$result['Agent/'.$item['Agent']]['LoggedInChan']=$item['LoggedInChan'];
			$result['Agent/'.$item['Agent']]['LoggedInTime']=$item['LoggedInTime'];
			$result['Agent/'.$item['Agent']]['Name']=$item['Name'];
			$result['Agent/'.$item['Agent']]['Status']=$item['Status'];
			$result['Agent/'.$item['Agent']]['TalkingTo']=$item['TalkingTo'];
		}
	}
	return $result;
}

$colaHead_1='	<table width="100%" >
	    	<caption>Nome da Fila: ';
$colaHead_2='
	</caption>
		<thead>
		  <tr>
		    <th width="18%">Max</th>
		    <th width="38%">Calls</th>
		    <th width="38%">HoldTime</th>
		    <th width="44%">Completed</th>
		    <th width="44%">Abandonded</th>
		    <th width="44%">ServiceLevel</th>
		    <th width="44%">ServiceLevelPerf</th>
		    <th width="44%">Weight</td>
		  </tr>
		</thead>
		<tbody>';
$colaBotom='</tbody>		
				</table>';
$miembroHead='		<table width="100%" >
		<thead>
		  <tr>
		    <th colspan="11" style="background: #CAE8EA url(images/bg_header.jpg) no-repeat;">Miembros</th>
		  </tr>
		  <tr>
		    <th width="19%">Agente</th>
		    <th width="19%">Nome</th>
		    <th width="19%">Exten</th>
		    <th width="19%">Ingreso</th>
		 <!--   <th width="16%">Tipo</th>
		    <th width="12%">Penalty</th> -->
		    <th width="16%">Recebidas</th>
		    <th width="16%">Feitas</th>
		    <th width="13%">Ultima</th>
		    <th width="11%">Est. Disp</th>
		    <th width="11%">Est. Exten</th>
		    <th width="11%">Estado</th>
		    <th width="13%">Pausado</th>
		  </tr>
		</thead>
		<tbody>';
$miembroBotom='	</tbody>	
					</table>';

?>


<!--##################### Aqui eu armo o HTML para mostrar o mapa #############-->
<head>

<meta http-equiv="refresh" content="5; URL=mapi.php">

<link rel="stylesheet" href="mapi.css">
</head>
	<body>

	<?php
		foreach($colas as $cola)
		{
			
			echo($colaHead_1);
			echo($cola['Queue']);
			echo($colaHead_2);

			echo('<tr>');
			  
			  echo('<td>&nbsp;'.$cola['MAXIMO'].'</td>');
			  echo('<td>&nbsp;'.$cola['CHAMADAS'].'</td>');
			  echo('<td>&nbsp;'.$cola['TEMPO DE ESPERA'].'</td>');
			  echo('<td>&nbsp;'.$cola['COMPLETADAS'].'</td>');
			  echo('<td>&nbsp;'.$cola['ABANDONADAS'].'</td>');
			  echo('<td>&nbsp;'.$cola['NIVEL DE SERVICO'].'</td>');
			  echo('<td>&nbsp;'.$cola['NIVEL DE SERVICO %'].'</td>');
			  echo('<td>&nbsp;'.$cola['PESO'].'</td>');
			echo('</tr>');
		
		  //Aqui mostro os membros das filas
		  
		  echo($miembroHead);
		  foreach ($cola['Membros'] as $miembro)
		  {

			  	$estado=$agentes[$miembro['Location']]['Status'];	
			  	$extensionestado=$agentes[$miembro['Location']]['ExtensionState'];	
			  	if($estado=='AGENT_LOGGEDOFF') $clase='class="loggedoff"';
			  	if($estado=='AGENT_IDLE') $clase='class="idle"';
			  	if($estado=='AGENT_ONCALL') $clase='class="oncall"';
			  	if($estado=='AGENT_UNKNOWN') $clase='class="unknown"';
			  	if($miembro['Paused']) $clase='class="paused"';
			  	if($extensionestado==1 || $extensionestado==8) $clase='class="oncallout"'; //8-ringin 1-oncall

				echo('<tr '.$clase.'>');
				  echo('<td><a href="agente.php?agente='.$miembro['Location'].'">&nbsp;'.$miembro['Location'].'</a></td>');
				  echo('<td>&nbsp;'.$agentes[$miembro['Location']]['Name'].'</td>');
				  echo('<td>&nbsp;'.$agentes[$miembro['Location']]['LoggedInChan'].'</td>');
				  if($agentes[$miembro['Location']]['LoggedInTime']==0)
				  {
				    $tiempo='';
				  }
				  else
				  {
				    $timepo=date('d/m/Y H:i:s',$agentes[$miembro['Location']]['LoggedInTime']);
				  }
				  echo('<td>&nbsp;'.$timepo.'</td>');
				  //echo('<td>&nbsp;'.$miembro['Membership'].'</td>');
				  //echo('<td>&nbsp;'.$miembro['Penlaty'].'</td>');
				  echo('<td>&nbsp;'.$miembro['CallsTaken'].'</td>');
				  echo('<td>&nbsp;'.$agentes[$miembro['Location']]['llamadas_salientes'].'</td>');
				  echo('<td>&nbsp;'.$miembro['LastCall'].'</td>');
				  echo('<td>&nbsp;'.$queueStatusStatus[$miembro['Status']].'</td>');
				  echo('<td>&nbsp;'.$ExtensionStatus[$agentes[$miembro['Location']]['ExtensionState']].'</td>');
				  echo('<td>&nbsp;'.$agentStatus[$agentes[$miembro['Location']]['Status']].'</td>');
				  echo('<td>&nbsp;'.$miembro['Paused'].'</td>');
				echo('</tr>');		  	
		  	
		  }
		  echo($miembroBotom);
		  echo('<br>');
		}
	?>


	</body>
</head>
