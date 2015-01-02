<?php

/**
 * Description of sairAreaAssinanteTel
 *
 * @author Danielle
 */
class sair extends MY_Controller{
    function __construct() {
        parent::__construct();
    }
    function index(){
      $this->session->unset_userdata('idUser');
      redirect('login');
    }
    
}

?>
