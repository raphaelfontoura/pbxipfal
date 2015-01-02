<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class edita_blacklist extends CI_Controller {
    
    function __construct() {
        parent::__construct();
        
    }
	
    public function index($id = NULL)
    {
        $this->load->model('m_blacklist');
        $this->load->helper('form');
        $this->load->library('form_validation');
        $this->form_validation->set_rules('obs', '<strong>"Observação"</strong>', '');
        $this->form_validation->set_rules('entrada', '<strong>"Recebimento de chamadas"</strong>', 'required');
        $this->form_validation->set_rules('saida', '<strong>"Realização de chamadas"</strong>', 'required');
        
        if($this->form_validation->run() === FALSE){
            $bloqueio = $this->m_blacklist->findBloqueioById($id);
            foreach ($bloqueio as $row) {
                $data['telefone'] = $row->telefone;
                $data['obs'] = $row->obs;
                $data['entrada'] = $row->entrada;
                $data['saida'] = $row->saida;
                $data['id'] = $row->id;
            }
            $output['content'] = $this->load->view('edita_blacklist_view', $data, TRUE);
        }
        else{
            $obs = strtoupper($this->input->post('obs'));
            $entrada = $this->input->post('entrada');
            $saida = $this->input->post('saida');
            $id = $this->input->post('id');
            $user = $this->session->userdata("idUser");
            $this->m_blacklist->updateBloqueio($obs, $entrada, $saida, $user, $id);
            
            redirect('blacklist');
//            $data['sucesso'] = 'Portabilidade alterada com sucesso.';
//            $output['content'] = $this->load->view('edita_portabilidade_view', $data, TRUE);

        }
        $this->load->view('layout', $output); 
    }

    
}
