<?php
/**
 * Description of download_excel
 *
 * @author Danielle
 */
class download extends MY_Controller{
    
    function __construct() {
        parent::__construct();
        
    }
    
    function index($nome = NULL){
        $fullPath = NULL;
        $fullPath = $nome.".xls";
        header('Content-type: application/vnd.ms-excel');
        header('Content-Disposition: attachment; filename="'.$nome.'.xls"');
        readfile('downloads/'.$nome.'.xls');
//        unlink('downloads/'.$nome.'.xls'); apagar arquivo
        
    }
    
}

?>
