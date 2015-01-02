<?php
$tipo = $_POST['tipo'];

$combo = NULL;

if($tipo == '1'){
    exec(" sudo /bin/cat /etc/asterisk/queues.conf | grep \"\\[\" ", $resp) or die ("Erro na execucao do comando para capturar as filas!!");
    for($i = 0; $i < count($resp); $i++){
        $partes = explode("#$", $resp[$i]);
        $num_fila = str_replace(';', '', $partes[0]);
        $combo .= '<option value="'.$num_fila.'" >'.$num_fila.' - '.$partes[1].'</option>';
    }
}
else if($tipo == '2'){
    exec(" sudo /bin/cat /etc/asterisk/pbx/announcements.conf | grep \";#\" ", $resp) or die ("Erro na execucao do comando para capturar as filas!!");
    for($i = 0; $i < count($resp); $i++){
        $annonc = str_replace(';#', '', $resp[$i]);
        $combo .= '<option value="'.$annonc.'" >'.$annonc.'</option>';
    }
}
else if($tipo == '3'){
    exec(" sudo /bin/cat /etc/asterisk/pbx/ivrinput.conf | grep \";#\" ", $resp) or die ("Erro na execucao do comando para capturar os IVRs!!");
    for($i = 0; $i < count($resp); $i++){
        $ivr = str_replace(';#', '', $resp[$i]);
        $combo .= '<option value="'.$ivr.'" >'.$ivr.'</option>';
    }
}
else if($tipo == '4'){
    exec(" sudo /bin/cat /etc/asterisk/sip.conf | grep \"^\[....\]\" ", $resp) or die ("Erro na execucao do comando para capturar as extensões!!");
    for($i = 0; $i < count($resp); $i++){
        $par = explode('(', $resp[$i]);
        $combo .= '<option value="'.$par[0].'" >'.$par[0].'</option>';
    }
}
echo $combo;

?>
