<div style="text-align: right; font-size: 13px; font-weight: bold; width: 100%">
    <a href="<?php echo site_url('sair'); ?>">&nbsp;Sair&nbsp;</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>

<h1>Op&ccedil;&otilde;es </h1>
<?php
if (isset($error)) {
    echo '<br/>'.$error;
}
$user = $this->session->userdata('idUser');
?>

 <ul>
        <?php
        foreach ($permissoes as $row) {
            $descricao = str_replace("_", " ", $row->descricao);
            $link = 'index.php';
            if ($row->descricao == 'RELATORIO_CDR'){ 
                $link = base_url()."cdr/cdr.php?u=".$user;
            }
            else if ($row->descricao == 'USUARIOS'){ 
                $link = site_url('usuarios');
            }
            else if ($row->descricao == 'AVALIACAO_PSA'){ 
                $link = site_url('relatorio_psa');
            }
            else if ($row->descricao == 'BLACKLIST'){ 
                $link = site_url('blacklist');
            }
            else{
                $link = NULL;
            }
            if($link != NULL){
            ?>
            <li ><a href="<?php echo $link; ?>">&nbsp;<?php echo $descricao; ?>&nbsp;</a></li>
            
            <?php
            }
        }
            ?>
        </ul> 
