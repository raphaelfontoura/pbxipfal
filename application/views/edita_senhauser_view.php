<div style="text-align: right; font-size: 13px; font-weight: bold; width: 100%">
    <a href="<?php echo site_url('opcoes'); ?>">&nbsp;Menu principal&nbsp;</a>
    &nbsp;&nbsp;|&nbsp;&nbsp;
    <a href="<?php echo site_url('sair'); ?>">&nbsp;Sair&nbsp;</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<h1>
    Alterar senha do usuário <?php echo $nome; ?>
</h1>

    <form id="form_editapass" name="form_editapass" method="post" action="<?php echo site_url('edita_senhauser'); ?>">
        <?php
            if(isset($sucesso)){
                ?>
                <div class="sucess" >  
                   <?php echo $sucesso;?>
                </div>
            <br/>
            <?php
            }
            if (validation_errors()) { 
            ?>
            <div class="error" >  
                <?php echo validation_errors(); ?>
            </div>
            <?php } 
            if (isset($error)) {
            ?>
            <div class="error" >  
                <?php echo $error;  ?>
            </div>
            <?php } ?>
            
            <input type="hidden" id="user" name="user" value="<?php echo $user; ?>" />
            <table>
                <tr>
                    <td width="30%">
                        <b>Nova senha:</b>
                    </td>
                    <td>
                        <input class="input-text" type="password" id="senha1" name="senha1" size="20" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Digite novamente a nova senha:</b>
                    </td>
                    <td>
                        <input class="input-text" type="password" id="senha2" name="senha2" size="20" />
                    </td>
                </tr>
            </table>
            
            <p style="text-align: left">
                <input type="submit" value="Salvar" class="btn" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="Voltar" class="btn" onclick="voltar()" />
                
            </p>

    </form>

<script type="text/javascript">
 function voltar() {
        window.location='<?php echo site_url('edita_usuario/index/'.$user); ?>';
    }

      
</script>