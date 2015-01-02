<?php 

if(isset($_REQUEST["agente"]))
{
	$agente=$_REQUEST["agente"];
	$tmp=split("/",$agente);
	$agentenum=$tmp[1];
}
else
{
	echo("Error: Agente en blanco");
	//exit();
}
//$agentenum="1001";
$socket=0;

function login()
{
	// Me conecto al Manager Api
	global $socket;
    $socket = fsockopen("192.168.2.15","5038", $errno, $errstr, $timeout);
    //echo "############### Me logueo  ###############<br>";
	
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
			   echo("Pass o Usr Incorrectos.");
			   exit();
		   }
	   }
	}    
}

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
       			//echo("Respuesta a '".$comando."' completa<br><br>");       	
       			return $respuesta;
       			break;
       		}
       		elseif(stristr($data,"Error")) //detectamos una respueta de error al comnado
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
	
//##### aca se ejecutan los comnados ######
if($accion=="agentlogoff")
{
	global $socket;
	//echo "############### Ejecuto comando: Logoff  ###############<br>";
	login();
	
    $comando = "action: agentlogoff\r\n";
    $comando .= "agent: ".$agentenum."\r\n";
    
    $respuesta=exec_cmd($comando,$socket,"Message: Agent logged out");
    fclose($socket);
    if(stristr($respuesta["eventos"][0]["Response"],"Error")) //detectamos una respueta de error al comnado
    {
    			echo("Error al ejecutar comando.");
    }
    else
    {
    	header("Location: mapi.php");	
    }
    
    
}

?>
<html>
<head>
<link rel="stylesheet" href="mapi.css">
</head>
<title></title>
<body>
<?php echo($agente."<br>") ?>
<?php echo($agentenum."<br>") ?>
<table>
	<tr>
		<td><a href="agente.php?accion=agentlogoff&agente=<?php echo($agente) ?>&number=<?php echo($agentenum) ?>">Desloguearlo</a></td>
	</tr>
	<tr>
		<td><a href="mapi.php">Volver</a></td>
	</tr>
</table>

</body>
</html>
