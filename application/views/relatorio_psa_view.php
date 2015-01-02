<div style="text-align: right; font-size: 13px; font-weight: bold; width: 100%">
    <a href="<?php echo site_url('opcoes'); ?>">&nbsp;Menu principal&nbsp;</a>
    &nbsp;&nbsp;|&nbsp;&nbsp;
    <a href="<?php echo site_url('sair'); ?>">&nbsp;Sair&nbsp;</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<h1>
    Relatórios PSA
</h1>
<br/>
<div class="painel" >
    <form id="form_relpsa" name="form_relpsa" method="post" action="<?php echo site_url('relatorio_psa'); ?>">
    Filtros:<br/><br/>
   
       
        <?php if (validation_errors()) { ?>
     <div class="error" >  <?php
            echo validation_errors(); ?>
            </div> 
     <?php   } ?>
    
        <table  cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>ID da chamadas:</td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>Ramal: </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>Serviço:</td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td></td>
            </tr>
            <tr>
                <td><input type="text" id="id_chamada" name="id_chamada" class="input-text" value="<?php if(isset($id_chamada)){echo $id_chamada;}?>"/></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td><select name="tipo_ramal">
                        <option value="0" <?php if(isset($tipo_ramal) && $tipo_ramal == 0){echo "selected = 'true'";}?>>CONTÉM</option>
                        <option value="1" <?php if(isset($tipo_ramal) && $tipo_ramal == 1){echo "selected = 'true'";}?>>COMEÇA COM</option>
                        <option value="2" <?php if(isset($tipo_ramal) && $tipo_ramal == 2){echo "selected = 'true'";}?>>TERMINA COM</option>
                        <option value="3" <?php if(isset($tipo_ramal) && $tipo_ramal == 3){echo "selected = 'true'";}?>>IGUAL</option>
                    </select>
                    &nbsp;&nbsp;
                    <input type="text" id="ramal" name="ramal" class="input-text" value="<?php if(isset($ramal)){echo $ramal;}?>"/></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td><input type="text" id="servico" name="servico" class="input-text" value="<?php if(isset($servico)){echo $servico;}?>"/></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td></td>
            </tr>
            <tr>
                <td colspan="7"><br/></td>
            </tr>
            <tr>
                <td>Nota dos ramais:</td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>Nota dos serviços: </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>Período:</td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <select name="nt_ramais">
                        <option value="0" <?php if(isset($nt_ramais) && $nt_ramais == 0){echo "selected = 'true'";}?>>TODAS</option>
                        <option value="1" <?php if(isset($nt_ramais) && $nt_ramais == 1){echo "selected = 'true'";}?>>1</option>
                        <option value="2" <?php if(isset($nt_ramais) && $nt_ramais == 2){echo "selected = 'true'";}?>>2</option>
                        <option value="3" <?php if(isset($nt_ramais) && $nt_ramais == 3){echo "selected = 'true'";}?>>3</option>
                        <option value="4" <?php if(isset($nt_ramais) && $nt_ramais == 4){echo "selected = 'true'";}?>>4</option>
                        <option value="5" <?php if(isset($nt_ramais) && $nt_ramais == 5){echo "selected = 'true'";}?>>5</option>
                    </select>
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>
                    <select name="nt_servico">
                        <option value="0" <?php if(isset($nt_servico) && $nt_servico == 0){echo "selected = 'true'";}?>>TODAS</option>
                        <option value="1" <?php if(isset($nt_servico) && $nt_servico == 1){echo "selected = 'true'";}?>>1</option>
                        <option value="2" <?php if(isset($nt_servico) && $nt_servico == 2){echo "selected = 'true'";}?>>2</option>
                        <option value="3" <?php if(isset($nt_servico) && $nt_servico == 3){echo "selected = 'true'";}?>>3</option>
                        <option value="4" <?php if(isset($nt_servico) && $nt_servico == 4){echo "selected = 'true'";}?>>4</option>
                        <option value="5" <?php if(isset($nt_servico) && $nt_servico == 5){echo "selected = 'true'";}?>>5</option>
                    </select>
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>
                    <input type="text" class="datepicker" name="data1" id="data1" size=10" value="<?php if(isset($data1)){echo $data1;}?>"/>
                    até
                    <input type="text" class="datepicker" name="data2" id="data2" size=10" value="<?php if(isset($data2)){echo $data2;}?>"/>
                </td>
            </tr>
            

        </table>
        <br/><br/>
         <input type="submit" value="Consultar" class="btn" />   
         &nbsp;&nbsp;&nbsp;
         <input type="button" value="Limpar" onclick="limpar()"  class="btn"/>
    </form>
</div>

    <br /><br />
    <?php
    if (isset($notas)) {
        if(count($notas) < 1){
            echo '<p style="color:red"><b>Não há registros com as características selecionadas.</b></p>';
        }
        else{
        ?>
        <div style="text-align: right; width: 950px">
            <a href="<?php echo site_url('gera_excel'); ?>"><img src="<?php echo base_url(); ?>includes/imagens/icon-excel.png"/></a> &nbsp;&nbsp; 
        </div>
        <i> Número de registros:<b> <?php echo count($notas); ?></b></i>
        <div style="width: 970px; height: 500px; overflow: auto;">
            <table border="0" cellpadding="5" cellspacing="0" class="table-resultado" style="width: 950px;">
                <thead>
                    <tr>
                        <td >ID da chamada</td>
                        <td >Data da chamada</td>
                        <td >Cód. do agente</td>
                        <td >Ramal</td>
                        <td >Nota do ramal</td>
                        <td >Serviço</td>
                        <td >Nota do serviço</td>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    foreach ($notas as $row) {
                        ?>
                    <tr>
                        <td><?php echo $row->id_chamada; ?></td>
                        <td><?php echo strftime("%d/%m/%Y %H:%M", strtotime($row->calldate)); ?></td>
                        <td><?php echo $row->agent_code; ?></td>
                        <td><?php echo $row->ramal; ?></td>
                        <td><?php echo $row->nota1; ?></td>
                        <td><?php echo $row->servico; ?></td>
                        <td><?php echo $row->nota2; ?></td>
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
        
    
    
    
    
    
<br /><br /><br />

<script type='text/javascript' >  
    function limpar() {
        window.location='<?php echo site_url('relatorio_psa'); ?>';
    }  

</script>

