<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class opcoes extends MY_Controller {
    
    function __construct() {
        parent::__construct();
        
    }
	
    public function index()
    {
        $this->load->model('m_usuario');
        $user = $this->session->userdata('idUser');
        $data['permissoes'] = $this->m_usuario->findPermissoesByUser($user);
        if($data['permissoes'] == NULL){
            $data['erro'] = 'Esse usuário não possui permissões para acessar as páginas.';
        }
        $output['content'] = $this->load->view('opcoes_view', $data, TRUE);
        $this->load->view('layout', $output); 
    }

    
}
