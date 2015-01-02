<div style="text-align: right; font-size: 13px; font-weight: bold; width: 100%">
    <a href="<?php echo site_url('opcoes'); ?>">&nbsp;Menu principal&nbsp;</a>
    &nbsp;&nbsp;|&nbsp;&nbsp;
    <a href="<?php echo site_url('sair'); ?>">&nbsp;Sair&nbsp;</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<h1>
    Usuários
</h1>
<br/>
<?php
if (isset($error)) {
?>
<div class="error" >  
       <?php echo $error; ?>
</div>
<?php
}
?>
<ul>
    <?php
    foreach ($users as $row) {
       ?>
        <li >
            <a href="<?php echo site_url('edita_usuario/index/'.$row->id_usuario); ?>">&nbsp;<?php echo $row->nome; ?>&nbsp;</a>
        </li>

    <?php
    }
    ?>
</ul> 

<br/><br/><input type="button" value="Novo usuário" onclick="direciona_novo()" class="btn"/>&nbsp;


<script type="text/javascript">
     function direciona_novo() {
        window.location='<?php echo site_url('cadastra_usuario'); ?>';
    }
 
</script>