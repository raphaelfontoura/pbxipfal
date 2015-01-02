<div style="text-align: right; font-size: 13px; font-weight: bold; width: 100%">
    <a href="<?php echo site_url('opcoes'); ?>">&nbsp;Menu principal&nbsp;</a>
    &nbsp;&nbsp;|&nbsp;&nbsp;
    <a href="<?php echo site_url('sair'); ?>">&nbsp;Sair&nbsp;</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<h1>
    Cadastrar número na blacklist
</h1>


    <form id="form_additem" name="form_additem" method="post" action="<?php echo site_url('cadastra_blacklist'); ?>">
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
                <?php if (validation_errors()) { echo validation_errors(); } ?>
            </div>
            <?php } ?>
            <table>
                <tr>
                    <td><b>Telefone:</b></td>
                    <td><input class="tel_mask" type="text" id="telefone" name="telefone" size="15" /></td>
                </tr>
                <tr>
                    <td><b>É permitido receber chamadas desse número?</b></td>
                    <td>
                        <select name="entrada" id="entrada">
                            <option value="N" selected="true">NÃO</option>
                            <option value="S" >SIM</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><b>É permitido realizar chamadas para esse número?</b></td>
                    <td>
                        <select name="saida" id="saida">
                            <option value="N" selected="true">NÃO</option>
                            <option value="S" >SIM</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><b>Observação:</b></td>
                    <td><input class="input-text" type="text" id="obs" name="obs" size="70" style="text-transform: uppercase"/></td>
                </tr>
                
            </table>
            
            <p style="text-align: left">
                <input type="submit" value="Salvar" class="btn" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" value="Voltar" class="btn" onclick="voltar()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                
            </p>

    </form>

<script type="text/javascript">
 function voltar() {
        window.location='<?php echo site_url('blacklist'); ?>';
    }
     
</script>