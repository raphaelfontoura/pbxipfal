<?php

function findUser($user = NULL)
{
    $conexao = conecta();
    $sql = "SELECT us.id_usuario, per.descricao 
            FROM webpbxip_usuario us
            INNER JOIN webpbxip_perfil_permissoes pp ON pp.id_perfil = us.id_perfil
            INNER JOIN webpbxip_permissao per ON per.id = pp.id_permissao
            WHERE id_usuario = '$user'";
    
    $resultado = mysql_query($sql,$conexao);
    return $resultado;
}

function conecta(){
        $servidor = "localhost";
        $usuario = "root";
        $senha = "gsa2014";
        $banco_dados = "pbxip";
        $con = mysql_connect($servidor,$usuario,$senha) or die ("Conexao falhou!");
        $db = mysql_select_db($banco_dados,$con);
        return $con;
}
?>
