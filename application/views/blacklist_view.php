<div style="text-align: right; font-size: 13px; font-weight: bold; width: 100%">
    <a href="<?php echo site_url('opcoes'); ?>">&nbsp;Menu principal&nbsp;</a>
    &nbsp;&nbsp;|&nbsp;&nbsp;
    <a href="<?php echo site_url('sair'); ?>">&nbsp;Sair&nbsp;</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>

<h1>Blacklist</h1>
<br/>

<div class="painel" >
    <form id="form_conblack" name="form_conblack" method="post" action="<?php echo site_url('blacklist'); ?>">
    Filtrar por:<br/><br/>
        <table  cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>Telefone:&nbsp;&nbsp;</td>
                <td><input type="text" id="telefone" name="telefone" class="input-text" size="20" /></td>
                
            </tr>
            
        </table>
        <br/><br/>
         <input type="submit" value="Consultar" class="btn" />   
         &nbsp;&nbsp;&nbsp;
         <input type="button" value="Voltar" onclick="voltar()"  class="btn"/>
         &nbsp;&nbsp;&nbsp;
         <input type="button" value="Novo" onclick="direciona_novo()" class="btn"/>
    </form>
</div>


<br/><br/>
<?php
    if (isset($bloqueados)) {
        if(count($bloqueados) < 1){
            echo '<p style="color:red"><b>Não há itens na blacklist.</b></p>';
        }
        else{
        ?>
    <div style="width: 1000px; height: 500px; overflow: auto;">
        <table border="0" cellpadding="5" cellspacing="0" class="table-resultado" style="width: 1000px;">
                
                <thead>
                    <tr>
                        <td>ID</td>
                        <td>Telefone</td>
                        <td>Data do cadastro</td>
                        <td>Recebe chamdas desse número?</td>
                        <td>Realiza chamadas para esse número?</td>
                        <td>Observação</td>
                        <td></td>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    foreach ($bloqueados as $row) {
                        $entrada = 'NÃO';
                        $saida = 'NÃO';
                        if($row->entrada == 'S'){
                            $entrada = 'SIM';
                        }
                        if($row->saida == 'S'){
                            $saida = 'SIM';
                        }
                        ?>
                    <tr>
                        <?php
                        echo "<td>$row->id</td><td> ";
                        ?>
                <a href="<?php echo site_url('edita_blacklist/index/'.$row->id); ?>" style="text-decoration: underline"><?php echo $row->telefone; ?></a>
                        <?php
                        echo "</td><td>".strftime("%d/%m/%Y", strtotime($row->data_cadastro))."</td>
                            <td>$entrada</td>
                            <td>$saida</td>
                            <td>$row->obs</td>";
                        ?>
                    </tr>
                    <?php
                    }
                    ?>
                </tbody>
            </table>
        </div>
    <?php 
        }
    }
    ?>
<br/><br/>


<script type="text/javascript">
function direciona_novo() {
    window.location='<?php echo site_url('cadastra_blacklist'); ?>';
}

function voltar() {
    window.location='<?php echo site_url('opcoes'); ?>';
}
      
</script>