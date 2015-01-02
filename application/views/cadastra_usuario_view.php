<div style="text-align: right; font-size: 13px; font-weight: bold; width: 100%">
    <a href="<?php echo site_url('opcoes'); ?>">&nbsp;Menu principal&nbsp;</a>
    &nbsp;&nbsp;|&nbsp;&nbsp;
    <a href="<?php echo site_url('sair'); ?>">&nbsp;Sair&nbsp;</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<h1>
    Cadastrar Usuário
</h1>


    <form id="form_adduser" name="form_adduser" method="post" action="<?php echo site_url('cadastra_usuario'); ?>">
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
            <table>
                <tr>
                    <td><b>Nome:</b></td>
                    <td><input class="input-text" type="text" id="nome" name="nome" size="45" style="text-transform: uppercase"/></td>
                </tr>
                <tr>
                    <td><b>Login:</b></td>
                    <td><input class="input-text" type="text" id="login" name="login" size="25" style="text-transform: lowercase"/></td>
                </tr>
                <tr>
                    <td><b>Senha:</b></td>
                    <td><input class="input-text" type="password" id="senha1" name="senha1" size="20" /></td>
                </tr>
                <tr>
                    <td style="width: 30%"><b>Digite novamente a senha:</b></td>
                    <td><input class="input-text" type="password" id="senha2" name="senha2" size="20" /></td>
                </tr>
                <tr>
                    <td><b>E-mail:</b></td>
                    <td><input class="input-text" type="text" id="email" name="email" size="25" style="text-transform: lowercase"/></td>
                </tr>
                <tr>
                    <td><b>Perfil:</b></td>
                    <td>
                        <select name="perfil" id="perfil">
                            <?php
                           foreach ($perfis as $row) { ?>
                                <option value="<?php echo $row->id ?>" ><?php echo $row->descricao ?></option>
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
                            <option value="1" >SIM</option>
                            <option value="0" >NÃO</option>
                       </select>
                    </td>
                </tr>
            </table>
            
            <p style="text-align: left">
                <input type="submit" value="Salvar" class="btn" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="Voltar" class="btn" onclick="voltar()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
            </p>

    </form>

<script type="text/javascript">
 function voltar() {
        window.location='<?php echo site_url('usuarios'); ?>';
    }
     
</script>