<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Description of m_extrato
 *
 * @author Danielle
 */
class m_psa extends CI_Model{
    private $table = 'pbxip_psa';
    private $db;
    
    function __construct()
    {
	parent::__construct();
        $this->db = $this->load->database('default',TRUE);
    }
    
    function findPSAByAttr($dados = NULL)
    {
        $cond = '';
        $item = '';
        if($dados['tipo_ramal'] == 0){
            $cond = 'ramal like';
            $item = "%".$dados['ramal']."%";
        }
        else if($dados['tipo_ramal'] == 1){
            $cond = 'ramal like';
            $item = $dados['ramal']."%";
        }
        else if($dados['tipo_ramal'] == 2){
            $cond = 'ramal like';
            $item = "%".$dados['ramal'];
        }
        else{
            $cond = 'ramal =';
            $item = $dados['ramal'];
        }
        $this->db->select("*");
        
        if($dados['id_chamada'] != NULL && $dados['id_chamada'] != ''){
            $this->db->where('id_chamada =', $dados['id_chamada']);
        }
        
        if($dados['ramal'] != NULL && $dados['ramal'] != ''){
            $this->db->where($cond, $item);
        }
        if($dados['servico'] != NULL && $dados['servico'] != ''){
            $this->db->where('servico like', '%'.$dados['servico'].'%');
        }
        if($dados['nt_servico'] != 0){
            $this->db->where('nota2 =', $dados['nt_servico']);
        }
        if($dados['nt_ramais'] != 0){
            $this->db->where('nota1 =', $dados['nt_ramais']);
        }
        if(($dados['data1'] != NULL && $dados['data1'] != '') && ($dados['data2'] != NULL && $dados['data2'] != '')){
            $this->db->where('calldate >=', $dados['data1'].' 00:00:00');
            $this->db->where('calldate <=', $dados['data2'].' 23:59:59');
        }
        else if(($dados['data1'] == NULL || $dados['data1'] == '') && ($dados['data2'] != NULL && $dados['data2'] != '')){
            $this->db->where('calldate <=', $dados['data2'].' 23:59:59');
        }
        else if(($dados['data1'] != NULL && $dados['data1'] != '') && ($dados['data2'] == NULL || $dados['data2'] == '')){
            $this->db->where('calldate >=', $dados['data1'].' 00:00:00');
        }
                
        $this->db->order_by($this->table.".calldate DESC");
        
        $query =  $this->db->get($this->table);
        return $query->result();
        $query->free_result();
    }
    
        
}


?>
