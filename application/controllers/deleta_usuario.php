<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class deleta_usuario extends MY_Controller {
    
    function __construct() {
        parent::__construct();
        
    }
	
    public function index($user = NULL)
    {
        $this->load->model('m_usuario');
        $this->m_usuario->deleteUser($user);
        redirect('usuarios');

    }

    
}
