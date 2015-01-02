<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Description of m_extrato
 *
 * @author Danielle
 */
class m_blacklist extends CI_Model{
    private $table = 'pbxip_blacklist';
    private $db;
    
    function __construct()
    {
	parent::__construct();
        $this->db = $this->load->database('default',TRUE);
    }
    
    function findBloqueados()
    {
        $sql = "SELECT *
                FROM $this->table ";

        $query = $this->db->query($sql);
        return $query->result();
        $query->free_result();
    }
    
    function findBloqueadosByTelefone($tel = NULL)
    {
        $sql = "SELECT *
                FROM $this->table 
                WHERE telefone like '%$tel%'";

        $query = $this->db->query($sql);
        return $query->result();
        $query->free_result();
    }
    
    function findBloqueioById($id = NULL)
    {
        $sql = "SELECT *
                FROM $this->table 
                WHERE id = $id";
        $query = $this->db->query($sql);
        return $query->result();
        $query->free_result();
    }
    
    function insertItem($telefone = NULL, $obs = NULL, $entrada = NULL, $saida = NULL,$user = NULL)
    {
        $data_atual = date('Y-m-d H:i:s');
        
        $sql = "INSERT INTO $this->table(telefone, data_cadastro, obs, id_usuario, entrada, saida ) 
            VALUES ('$telefone', '$data_atual', '$obs', $user, '$entrada', '$saida')";
        $this->db->query($sql);
    }
    
    function updateBloqueio($obs = NULL, $entrada = NULL, $saida = NULL, $user = NULL, $id = NULL)
    {
        $sql = "UPDATE $this->table
                SET obs = '$obs', id_usuario = $user, entrada = '$entrada', saida = '$saida' 
                WHERE id = $id";
        
        $this->db->query($sql);
    }
    
    function deleteBloqueio($id = NULL)
    {
        $sql = "DELETE FROM $this->table
                WHERE id = $id";

        $this->db->query($sql);
    }
    
    
    
        
}


?>
