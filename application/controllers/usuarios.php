<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class usuarios extends MY_Controller {
    
    function __construct() {
        parent::__construct();
        
    }
	
    public function index()
    {
        $this->load->model('m_usuario');
        $data['users'] = $this->m_usuario->findUsers();
        if(count ($data['users']) < 1){
            $data['error'] = 'Não existem usuários cadastrados.';
            $output['content'] = $this->load->view('usuarios_view', $data, TRUE);
        }
        else{
            $output['content'] = $this->load->view('usuarios_view', $data, TRUE);
        }
        
        $this->load->view('layout', $output);

    }

    
}
