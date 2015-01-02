<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class MY_Controller extends CI_Controller {
    
    function __construct() {
        parent::__construct();
        
        $user = $this->session->userdata('idUser');
        if (!isset($user) || $user == NULL){
            redirect('login');
        }
    }
    
}
