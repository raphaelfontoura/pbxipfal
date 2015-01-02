<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Description of m_extrato
 *
 * @author Danielle
 */
class m_log extends CI_Model{
    private $table = 'log_acesso';
    private $db;
    
    function __construct()
    {
	parent::__construct();
        $this->db = $this->load->database('default',TRUE);
    }
    
    function insertLog($acao = NULL, $user = NULL)
    {
        $ip = $_SERVER["REMOTE_ADDR"];
        $data_atual = date('Y-m-d H:i:s');
        $sql = "INSERT INTO $this->table(ip, data_acao, acao, id_usuario) 
            VALUES ('$ip', '$data_atual', '$acao', $user )";

        $this->db->query($sql);
    }
    
    
        
}


?>
