<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class login extends CI_Controller {
    
    function __construct() {
        parent::__construct();
        
    }
	
    public function index()
    {
        $this->load->helper('form');
        $this->load->library('form_validation');
        $this->load->model('m_usuario');
        $this->form_validation->set_rules('user', '<strong>"Usuário"</strong>', 'required');
        $this->form_validation->set_rules('pass', '<strong>"Senha"</strong>', 'required');
        if($this->form_validation->run() === FALSE){
            $output['content'] = $this->load->view('login_view', NULL, TRUE);
            $this->load->view('layout', $output); 
        }
        else{
            $user = $this->input->post('user');
            $pass = strtolower($this->input->post('pass'));
            $numResult = $this->m_usuario->findlogin($user);
            if($numResult >= 1){
                $resultado = $this->m_usuario->findLoginSenha($user, md5($pass));
                if($resultado != NULL){
                    foreach ($resultado as $row) {
                        $idUser = $row->id_usuario;
                        if($row->ativo == 1){
                            $this->session->set_userdata('idUser', $idUser);
                            redirect('opcoes');
                        }
                    }
                }
                else{
                    $data['error'] = 'Senha incorreta';
                    $output['content'] = $this->load->view('login_view', $data, TRUE);
                    $this->load->view('layout', $output); 
                }
            }
            else{
                $data['error'] = 'Login incorreto';
                $output['content'] = $this->load->view('login_view', $data, TRUE);
                $this->load->view('layout', $output); 
            }

        }
         
    }

    
}
