<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

include('PHPExcel.php');
include('PHPExcel/IOFactory.php');

class relatorio_psa extends MY_Controller {
    
    function __construct() {
        parent::__construct();
        
    }
	
    public function index()
    {
        $this->load->helper('form');
        $this->load->library('form_validation');
        $this->form_validation->set_rules('id_chamada', '<strong>"ID da chamada"</strong>', '');
        $this->form_validation->set_rules('ramal', '<strong>"Ramal"</strong>', 'numeric');
        $this->form_validation->set_rules('servico', '<strong>"Serviço"</strong>', '');
        $this->form_validation->set_rules('nt_ramais', '<strong>"Nota dos ramais"</strong>', '');
        $this->form_validation->set_rules('nt_servico', '<strong>"Nota dos serviços"</strong>', '');
        $this->form_validation->set_rules('data1', '<strong>"Data inicial do período"</strong>', '');
        $this->form_validation->set_rules('data2', '<strong>"Data inicial do período"</strong>', '');
        $this->form_validation->set_rules('tipo_ramal', '<strong>"Tipo ramal"</strong>', '');
        if($this->form_validation->run() === FALSE){
            $output['content'] = $this->load->view('relatorio_psa_view', NULL, TRUE);
        }
        else{
            $dt1 = implode('-',array_reverse(explode('/',$this->input->post('data1'))));
            $dt2 = implode('-',array_reverse(explode('/',$this->input->post('data2'))));
            $data['data2'] = $this->input->post('data2');
            $data['data1'] = $this->input->post('data1');
            $data['id_chamada'] = $this->input->post('id_chamada');
            $data['ramal'] = $this->input->post('ramal');
            $data['servico'] = $this->input->post('servico');
            $data['nt_servico'] = $this->input->post('nt_servico');
            $data['nt_ramais'] = $this->input->post('nt_ramais');
            $data['tipo_ramal'] = $this->input->post('tipo_ramal');
            $dados = array(
                'id_chamada' => trim($data['id_chamada']),
                'ramal' => trim($data['ramal']),
                'servico' => trim($data['servico']),
                'nt_servico' => $data['nt_servico'],
                'nt_ramais' => $data['nt_ramais'],
                'tipo_ramal' => $data['tipo_ramal'],
                'data1' => $dt1,
                'data2' => $dt2
            );
            $data['notas'] = $this->m_psa->findPSAByAttr($dados);
       
            $this->session->set_userdata('export', $data['notas'] );
            $output['content'] = $this->load->view('relatorio_psa_view', $data, TRUE);

        }
        $this->load->view('layout', $output); 
    }

    
}
