<?php

print '<head><meta http-equiv="refresh" content="6"></head>';

// Converter timestamp para data: 	$data = date("d / m / Y - G : i" ,$valor);

queueStatus('localhost','provisioning','gsa2014','5038');


function queueStatus($server,$username,$secret,$port){
       	$socket = fsockopen($server,$port, $errno, $errstr, 1);
       	fputs($socket, "Action: Login\r\n");
       	fputs($socket, "UserName: $username\r\n");
       	fputs($socket, "Secret: $secret\r\n");
       	fputs($socket, "Event: Off\r\n\r\n");
       	fputs($socket, "Action: QueueStatus\r\n\r\n");
       	fputs($socket, "Action: Logoff\r\n\r\n");
       	while (!feof($socket)) {
		$conta = 0;
		$parar = 0;
		while (!feof($socket)) {
                     	$wrets = fgets($socket, 8192);
		     	list($opcao,$valor) = explode(":", $wrets);
			if($opcao == "Response"){
			}elseif($opcao == "Message"){
			}elseif(preg_match("/^Asterisk\ Call\ Manager/", $opcao)){
			}else{
				if($opcao == "Event"){
					$conta2 = 0;
					$conta++;
					#print "Var: teste[$conta][$conta2]<br />";
					#print "Line: $wrets<br />";
					$teste[$conta][$conta2] = $wrets;
				}else{
					$conta2++;
					#print "Var: teste[$conta][$conta2]<br />";
					#print "Line: $wrets<br />";
					$teste[$conta][$conta2] = $wrets;

				}
			}
			
			
		}

      	}
	$qtdarray = sizeof($teste);
	print "<table border=\"1\" style=\"font-size: 10px;\">";
	for($i = 0 ; $i < $qtdarray ; $i++){
		$usafila = 0;
		foreach($teste[$i] as $row){
			list($opcao,$valor) = explode(":", $row);
			//print "Valor: $valor<br />";
			if(preg_match("/QueueParams/", $valor)){
				print "<tr align=\"center\"><td colspan=\"10\">";
				$usafila = 1;
			}else{
				if(preg_match("/Queue/", $opcao)){
					$fila = $valor;
					if($usafila == "1"){
						print "Fila : $fila </td></tr><tr>";
					 	$usafila = "0";
						$fechalinha = 1;
					}
				}
				if(preg_match("/Max/", $opcao)){
					print "<td>Limite Chamadas: $valor</td>";

				}
				if(preg_match("/Calls$/", $opcao)){
					print "<td>Chamadas em fila: $valor</td>";
				}
				if(preg_match("/Holdtime$/", $opcao)){
					print "<td>Tempod e espera (segs): $valor</td>";
				}
				if(preg_match("/Completed$/", $opcao)){
					print "<td>Chamadas Completadas: $valor</td>";
				}
				if(preg_match("/Abandoned$/", $opcao)){
					print "<td>Chamadas Abandonadas: $valor</td></tr>";
				}

				next;
			}

			if(preg_match("/QueueMember$/",$valor)){
				print "<tr>";
			}else{
				if(preg_match("/Name$/", $opcao)){
					print "<td>Usuario: $valor</td>";
				}
				if(preg_match("/CallsTaken$/", $opcao)){
					print "<td>Chamadas Atendidas: $valor</td>";
				}
				if(preg_match("/LastCall/", $opcao)){
				        $valor_tmp = trim($valor); 
					if($valor_tmp == "0"){
						print "<td> Ultima Chamada: Sem Registro</td>";
					}else{
						$data = date("d / m / Y - G : i" ,$valor_tmp);
						print "<td>Ultima Chamada: $data</td>";
					}
				}
				if(preg_match("/Status/", $opcao)){
					if(preg_match("/3/", $valor)){
						print "<td>Status: <b><Font color=\"red\">ATENDENDO</font></b> </td>";
					}elseif(preg_match("/5/", $valor)){
						print "<td>Status: OFFLINE </td>";
					}elseif(preg_match("/1/", $valor)){
						print "<td>Status: <b><font color=\"green\">LIVRE</font></b> </td>";
					}
					print "</tr>";
				}
			}

			if(preg_match("/QueueEntry$/", $valor)){
				print "<tr>";
			}else{
				if(preg_match("/Position$/", $opcao)){
					print "<td>Posicao na fila: $valor</td>";
				}
				if(preg_match("/Channel$/", $opcao)){
					print "<td>Canal: $valor</td>";
				}
				if(preg_match("/CallerID$/", $opcao)){
					print "<td>Numero Origem: $valor</td>";
				}
				if(preg_match("/Wait$/", $opcao)){
					print "<td>Tempo em espera: $valor</td>";
					print "</tr>";
				}
			}

			


			
			
		}
	}


}

	


?>

