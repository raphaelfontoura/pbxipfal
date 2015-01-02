<div style="text-align: right; font-size: 13px; font-weight: bold; width: 100%">
    <a href="<?php echo site_url('opcoes'); ?>">&nbsp;Menu principal&nbsp;</a>
    &nbsp;&nbsp;|&nbsp;&nbsp;
    <a href="<?php echo site_url('sair'); ?>">&nbsp;Sair&nbsp;</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<h1>
    Editar dados do usuário <?php echo $nome; ?>
</h1>
<br/>

    <form id="form_editauser" name="form_editauser" method="post" action="<?php echo site_url('edita_usuario'); ?>">
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
            <?php } ?>
            <table>
                <tr>
                    <td><b>Nome:</b></td>
                    <td><input class="input-text" type="text" id="nome" name="nome" value="<?php echo $nome; ?>" size="45" style="text-transform: uppercase"/></td>
                </tr>
                <tr>
                    <td><b>Login:</b></td>
                    <td><input class="input-text" type="text" id="login" name="login" value="<?php echo $login; ?>" size="25" style="text-transform: lowercase"/></td>
                </tr>
                <tr>
                    <td><b>E-mail:</b></td>
                    <td><input class="input-text" type="text" id="email" name="email" value="<?php echo $email; ?>" size="25" style="text-transform: lowercase"/></td>
                </tr>
                <tr>
                    <td><b>Perfil:</b></td>
                    <td>
                        <select name="perfil" id="perfil">
                            <?php
                           foreach ($perfis as $row) { ?>
                                <option value="<?php echo $row->id ?>" <?php if($row->id == $perfil){ echo "selected='true'"; } ?> ><?php echo $row->descricao ?></option>
                            <?php
                            }
                            ?>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><b>Ativo:</b></td>
                    <td>
                        <select name="ativo" id="ativo">
                            <option value="1" <?php if($ativo == 1){ echo "selected='true'"; } ?> >SIM</option>
                            <option value="0" <?php if($ativo == 0){ echo "selected='true'"; } ?> >NÃO</option>
                       </select>
                    </td>
                </tr>
            </table>
            <input type="hidden" id="id_user" name="id_user" value="<?php echo $id_user; ?>" />
            
            <p style="text-align: left">
                <input type="submit" value="Salvar" class="btn" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="Voltar" class="btn" onclick="voltar()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="Alterar senha" class="btn" onclick="direciona_alterar_senha()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="Deletar" class="btn" onclick="direciona_deletar()" />
                
            </p>

    </form>

<script type="text/javascript">
function voltar() {
    window.location='<?php echo site_url('usuarios'); ?>';
}

function direciona_deletar() {
    var op = confirm("Tem certeza que deseja excluir esse usuário?");
    if(op){
        window.location='<?php echo site_url('deleta_usuario/index/'.$id_user); ?>';
    }
}

 function direciona_alterar_senha() {
    window.location='<?php echo site_url('edita_senhauser/index/'.$id_user); ?>';
}

      
</script>