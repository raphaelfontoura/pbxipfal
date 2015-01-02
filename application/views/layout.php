<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        
        
        <link rel="shortcut icon" href="<?php echo base_url(); ?>includes/imagens/favicon.ico" />
        
        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>includes/css/master.css" />
        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>includes/css/estilo_geral.css" />
        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>includes/css/jquery-ui.css" />
        <link rel="stylesheet" type="text/css" href="<?php echo base_url(); ?>includes/css/jquery.ui.theme.css" />
        
        <script type="text/javascript" src="<?php echo base_url(); ?>includes/js/jquery.js"></script>
        <script type="text/javascript" src="<?php echo base_url(); ?>includes/js/jquery.maskedinput.js"></script>
        <script type="text/javascript" src="<?php echo base_url(); ?>includes/js/jquery-1.9.1.js"></script>
        <script type="text/javascript" src="<?php echo base_url(); ?>includes/js/jquery-ui-1.10.3.custom.js"></script>
        <script type="text/javascript" src="<?php echo base_url(); ?>includes/js/jquery-ui-1.10.3.custom.min.js"></script>
        <script type="text/javascript" src="<?php echo base_url(); ?>includes/js/jquery.ui.datepicker-pt-BR.js"></script>
        
        <script type="text/javascript">

            $(document).ready(function(){
                $.datepicker.setDefaults( $.datepicker.regional[ "pt-BR" ]);
                $( "#data1" ).datepicker({
                    defaultDate: "+1w",
                    changeMonth: true,
                    onSelect: function( selectedDate ) {
                        $( "#data2" ).datepicker( "option", "minDate", selectedDate );
                    }
                });
                $( "#data2" ).datepicker({
                    defaultDate: "+1w",
                    changeMonth: true
                
                
                });
            });
            
            
        
        </script>
        
        <title>PbxIPFal</title>
        
    </head>


   
    <body>
        <div class="conteudo">
            <div id="header">
                <img src="<?php echo base_url(); ?>includes/imagens/logo.png"/>
            </div>
             
            <?php if (isset($content)) { echo $content; } ?>
        
           
        </div>
        
        <div id="footer">
            
                <p>
                    Central de Relacionamento com o Cliente PbxIPFal - suporte@delphini.com.br (Conselheiro Lafaiete, MG, Brasil)
                </p>
        </div>         
    </body>
</html>
