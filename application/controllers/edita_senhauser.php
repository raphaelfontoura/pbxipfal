<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class edita_senhauser extends MY_Controller {
    
    function __construct() {
        parent::__construct();
    }
	
    public function index($usuario = NULL)
    {
        $this->load->helper('form');
        $this->load->library('form_validation');
        $this->load->model('m_usuario');
        $this->form_validation->set_rules('senha1', '<strong>"Senha"</strong>', 'required');
        $this->form_validation->set_rules('senha2', '<strong>"Repetição da senha"</strong>', 'required');
        if($this->form_validation->run() === FALSE){
            $data['user'] = $usuario;
            $dados = $this->m_usuario->findUserById($usuario);
            foreach ($dados as $row) {
                $data['nome'] = $row->nome;
            }
            $output['content'] = $this->load->view('edita_senhauser_view', $data, TRUE);
        }
        else{
            $senha1 = $this->input->post('senha1');
            $senha2 = $this->input->post('senha2');
            $user = $this->input->post('user');
            $dados = $this->m_usuario->findUserById($user);
            foreach ($dados as $row) {
                $data['nome'] = $row->nome;
            }
            if($senha1 == $senha2){
                $this->m_usuario->updateSenhaUsuario($user, md5($senha1));
                $data['sucesso'] = 'Senha alterada com sucesso.';
                $data['user'] = $user;
                $output['content'] = $this->load->view('edita_senhauser_view', $data, TRUE);
            }
            else{
                $data['user'] = $user;
                $data['error'] = "As senhas não coincidem.";
                $output['content'] = $this->load->view('edita_senhauser_view', $data, TRUE);
            }
            
            
        }
        $this->load->view('layout', $output); 
    }

    
}
