<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class cadastra_blacklist extends MY_Controller {
    
    function __construct() {
        parent::__construct();
    }
	
    public function index()
    {
        $this->load->helper('form');
        $this->load->library('form_validation');
        $this->load->model('m_blacklist');
        $this->form_validation->set_rules('telefone', '<strong>"Telefone"</strong>', 'required');
        $this->form_validation->set_rules('obs', '<strong>"Observação"</strong>', '');
        $this->form_validation->set_rules('entrada', '<strong>"Recebimento de chamadas"</strong>', 'required');
        $this->form_validation->set_rules('saida', '<strong>"Realização de chamadas"</strong>', 'required');
        if($this->form_validation->run() === FALSE){
            $output['content'] = $this->load->view('cadastra_blacklist_view', NULL, TRUE);
        }
        else{
            $carac = array("(", ")", "-", " ");
            $obs = strtoupper($this->input->post('obs'));
            $telefone = str_replace($carac, "", $this->input->post('telefone'));
            $entrada = $this->input->post('entrada');
            $saida = $this->input->post('saida');
            $user = $this->session->userdata("idUser");
            $this->m_blacklist->insertItem($telefone, $obs, $entrada, $saida, $user);
            $data['sucesso'] = 'Item cadastrado com sucesso.';
            $output['content'] = $this->load->view('cadastra_blacklist_view', $data, TRUE);
            
            
        }
        $this->load->view('layout', $output); 
    }

    
}
