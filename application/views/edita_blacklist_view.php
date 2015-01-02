<div style="text-align: right; font-size: 13px; font-weight: bold; width: 100%">
    <a href="<?php echo site_url('opcoes'); ?>">&nbsp;Menu principal&nbsp;</a>
    &nbsp;&nbsp;|&nbsp;&nbsp;
    <a href="<?php echo site_url('sair'); ?>">&nbsp;Sair&nbsp;</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<h1>
    Editar número na blacklist
</h1>


    <form id="form_edititem" name="form_edititem" method="post" action="<?php echo site_url('edita_blacklist'); ?>">
        <?php
            if (validation_errors()) {
            ?>
            <div class="error" >  
                <?php if (validation_errors()) { echo validation_errors(); } ?>
            </div>
            <?php } ?>
            <table>
                <tr>
                    <td><b>Telefone:</b></td>
                    <td><?php echo $telefone; ?></td>
                </tr>
                <tr>
                    <td><b>É permitido receber chamadas desse número?</b></td>
                    <td>
                        <select name="entrada" id="entrada">
                            <option value="N" <?php if($entrada == 'N'){ echo 'selected';} ?>>NÃO</option>
                            <option value="S"  <?php if($entrada == 'S'){ echo 'selected';} ?>>SIM</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><b>É permitido realizar chamadas para esse número?</b></td>
                    <td>
                        <select name="saida" id="saida">
                            <option value="N"  <?php if($saida == 'N'){ echo 'selected';} ?>>NÃO</option>
                            <option value="S"  <?php if($saida == 'S'){ echo 'selected';} ?>>SIM</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><b>Observação:</b></td>
                    <td><input class="input-text" type="text" id="obs" name="obs" size="70" style="text-transform: uppercase" value="<?php echo $obs; ?>"/>
                    <input type="hidden" name="id" value="<?php echo $id; ?>"/></td>
                </tr>
                
            </table>
            
            <p style="text-align: left">
                <input type="submit" value="Salvar" class="btn" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="Voltar" class="btn" onclick="voltar()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="Deletar" class="btn" onclick="direciona_deletar()" />
                
            </p>

    </form>

<script type="text/javascript">
function voltar() {
        window.location='<?php echo site_url('blacklist'); ?>';
}

function direciona_deletar() {
    var op = confirm("Tem certeza que deseja excluir esse item?");
    if(op){
        window.location='<?php echo site_url('deleta_blacklist/index/'.$id); ?>';
    }
}
     
</script>