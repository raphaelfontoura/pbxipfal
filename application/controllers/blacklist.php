<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class blacklist extends MY_Controller {
    
    function __construct() {
        parent::__construct();
        
    }
	
    public function index()
    {
        $this->load->helper('form');
        $this->load->library('form_validation');
        $this->form_validation->set_rules('telefone', '<strong>"Telefone"</strong>', '');
        $this->load->model('m_blacklist');
        
        if($this->form_validation->run() === FALSE){
            $data['bloqueados'] = $this->m_blacklist->findBloqueados();
            $output['content'] = $this->load->view('blacklist_view', $data, TRUE);
        }
        else{
            $carac = array("(", ")","-"," ");
            $telefone = str_replace($carac, "", $this->input->post('telefone'));
            $data['bloqueados'] = $this->m_blacklist->findBloqueadosByTelefone($telefone);
            $output['content'] = $this->load->view('blacklist_view', $data, TRUE);
           
        }
         $this->load->view('layout', $output); 
    }

    
}
