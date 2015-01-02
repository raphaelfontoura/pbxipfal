<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class cadastra_usuario extends MY_Controller {
    
    function __construct() {
        parent::__construct();
    }
	
    public function index($usuario = NULL)
    {
        $this->load->helper('form');
        $this->load->library('form_validation');
        $this->load->model('m_usuario');
        $this->form_validation->set_rules('nome', '<strong>"Nome"</strong>', 'required');
        $this->form_validation->set_rules('login', '<strong>"Login"</strong>', 'required');
        $this->form_validation->set_rules('email', '<strong>"E-mail"</strong>', '');
        $this->form_validation->set_rules('ativo', '<strong>"Ativo"</strong>', 'required');
        $this->form_validation->set_rules('perfil', '<strong>"Perfil"</strong>', 'required');
        $this->form_validation->set_rules('senha1', '<strong>"Senha"</strong>', 'required');
        $this->form_validation->set_rules('senha2', '<strong>"Digite novamente a senha"</strong>', 'required');
        if($this->form_validation->run() === FALSE){
            $data['perfis'] = $this->m_usuario->findPerfis();
            $output['content'] = $this->load->view('cadastra_usuario_view', $data, TRUE);
        }
        else{
            $nome = strtoupper($this->input->post('nome'));
            $login = strtolower($this->input->post('login'));
            $email = strtolower($this->input->post('email'));
            $ativo = $this->input->post('ativo');
            $perfil = $this->input->post('perfil');
            $senha1 = $this->input->post('senha1');
            $senha2 = $this->input->post('senha2');
            if($senha1 == $senha2){
                $this->m_usuario->insertUsuario($nome, $login, md5($senha1), $email, $ativo, $perfil);
                 $data['sucesso'] = 'Usuário cadastrado com sucesso.';
                 $output['content'] = $this->load->view('cadastra_usuario_view', $data, TRUE);
            }
            else{
                $data['error'] = "As duas senhas não coincidem.";
                $output['content'] = $this->load->view('cadastra_usuario_view', $data, TRUE);
            }
            
        }
        $this->load->view('layout', $output); 
    }

    
}
