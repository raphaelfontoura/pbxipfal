<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class edita_usuario extends MY_Controller {
    
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
        $this->form_validation->set_rules('email', '<strong>"E-mail"</strong>', 'required');
        $this->form_validation->set_rules('ativo', '<strong>"Ativo"</strong>', 'required');
        $this->form_validation->set_rules('perfil', '<strong>"Perfil"</strong>', 'required');
        if($this->form_validation->run() === FALSE){
            $data['perfis'] = $this->m_usuario->findPerfis();
            $dados = $this->m_usuario->findUserById($usuario);
            foreach ($dados as $row) {
                $data['nome'] = $row->nome;
                $data['login'] = $row->login;
                $data['email'] = $row->email;
                $data['ativo'] = $row->ativo;
                $data['perfil'] = $row->id_perfil;
                $data['id_user'] = $row->id_usuario;
            }
            $output['content'] = $this->load->view('edita_usuario_view', $data, TRUE);
        }
        else{
            $data['nome'] = strtoupper($this->input->post('nome'));
            $data['login'] = strtolower($this->input->post('login'));
            $data['email'] = strtolower($this->input->post('email'));
            $data['ativo'] = $this->input->post('ativo');
            $data['perfil'] = $this->input->post('perfil');
            $data['id_user'] = $this->input->post('id_user');
            $this->m_usuario->updateUsuario($data['id_user'], $data['nome'], $data['login'], $data['ativo'], $data['email'], $data['perfil']);
            $data['sucesso'] = 'Usuário alterado com sucesso.';
            $output['content'] = $this->load->view('edita_usuario_view', $data, TRUE);
            
        }
        $this->load->view('layout', $output); 
    }

    
}
