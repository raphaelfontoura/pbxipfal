<?php

/**
 * Description of Funcoes_gerais
 *
 * @author Danielle
 */
class funcoes {
    
    
    function converteNomeMes ($mes){
            if($mes == 01 || $mes == 1){
                $nome = 'Jan';
            }
            else if($mes == 02 || $mes == 2){
                $nome = 'Fev';
            }
            else if($mes == 03 || $mes == 3){
                $nome = 'Mar';
            }
            else if($mes == 04 || $mes == 4){
                $nome = 'Abr';
            }
            else if($mes == 05 || $mes == 5){
                $nome = 'Mai';
            }
            else if($mes == 06 || $mes == 6){
                $nome = 'Jun';
            }
            else if($mes == 07 || $mes == 7){
                $nome = 'Jul';
            }
            else if($mes == 08 || $mes == 8){
                $nome = 'Ago';
            }
            else if($mes == 09 || $mes == 9){
                $nome = 'Set';
            }
            else if($mes == 10){
                $nome = 'Out';
            }
            else if($mes == 11){
                $nome = 'Nov';
            }
            else if($mes == 12){
                $nome = 'Dez';
            }
            return $nome;
        }
        
       
}

?>
