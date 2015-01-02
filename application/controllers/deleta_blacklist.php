<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class deleta_blacklist extends MY_Controller {
    
    function __construct() {
        parent::__construct();
        
    }
	
    public function index($id = NULL)
    {
        
        $this->load->model('m_blacklist');
        $this->m_blacklist->deleteBloqueio($id);
        redirect('blacklist');

    }

    
}
