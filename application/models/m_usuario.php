<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Description of m_extrato
 *
 * @author Danielle
 */
class m_usuario extends CI_Model{
    private $table = 'webpbxip_usuario';
    private $db;
    
    function __construct()
    {
	parent::__construct();
        $this->db = $this->load->database('default',TRUE);
    }
    
    function findLogin($login = NULL)
    {
        $sql = "SELECT id_usuario
                FROM $this->table
                WHERE login = '$login'";

        $query = $this->db->query($sql);
        return $query->num_rows();
        $query->free_result();
    }
    
    function findLoginSenha($login = NULL, $senha = NULL)
    {
        $sql = "SELECT *
                FROM $this->table
                WHERE login = '$login'
                AND senha = '$senha'";
        $query = $this->db->query($sql);
        return $query->result();
        $query->free_result();
    }
    
    function findPermissoesByUser($idUser = NULL)
    {
        $sql = "SELECT DISTINCT us.id_usuario, perm.descricao
                FROM  $this->table AS us
                INNER JOIN webpbxip_perfil  perf ON perf.id = us.id_perfil
                INNER JOIN webpbxip_perfil_permissoes perfperm ON perfperm.id_perfil = perf.id
                INNER JOIN webpbxip_permissao perm ON perm.id = perfperm.id_permissao
                WHERE us.id_usuario = $idUser 
                ORDER BY  perm.descricao ASC";
        $query = $this->db->query($sql);
        return $query->result();
        $query->free_result();
    }
    
    function findUsers()
    {
        $sql = "SELECT *
                FROM $this->table
                ORDER BY nome ASC";
        $query = $this->db->query($sql);
        return $query->result();
        $query->free_result();
    }
    
    function findPerfis()
    {
        $sql = "SELECT * 
                FROM `webpbxip_perfil`
                ORDER BY descricao ASC";
        $query = $this->db->query($sql);
        return $query->result();
    }
    
    function updateUsuario($idUser = NULL, $nome = NULL, $login = NULL, $ativo = NULL, $email = NULL, $id_perfil = NULL)
    {
        $sql = "UPDATE $this->table
                SET nome='$nome',login='$login',ativo=$ativo,email='$email',id_perfil=$id_perfil 
                WHERE id_usuario = $idUser";
        
        $this->db->query($sql);
    }
    
    function updateSenhaUsuario($idUser = NULL, $senha = NULL)
    {
        $sql = "UPDATE $this->table
                SET senha='$senha'
                WHERE id_usuario = $idUser";
        
        $this->db->query($sql);
    }
    
    function insertUsuario($nome = NULL, $login = NULL, $senha = NULL, $email = NULL, $ativo = NULL, $perfil = NULL)
    {
        $sql = "INSERT INTO $this->table(nome, login, senha, ativo, email, id_perfil) 
            VALUES ('$nome', '$login', '$senha', $ativo, '$email', $perfil)";
        $this->db->query($sql);
    }
    
    function deleteUser($idUser = NULL)
    {
        $sql = "DELETE FROM `webpbxip_usuario` 
                WHERE id_usuario = $idUser";

        $this->db->query($sql);
    }
    
    function findUserById($id = NULL)
    {
        $sql = "SELECT *
                FROM $this->table
                WHERE id_usuario = $id";

        $query = $this->db->query($sql);
        return $query->result();
        $query->free_result();
    }
    
    
        
}


?>
