<center>

    <h1>
        Login de acesso
    </h1>
    <br/>
    <div class="painel_login" >
    
        <?php
        if (isset($error)) { ?>
            <div class="error" style="height: 20px">  
            <?php echo $error; ?>
            </div> 
       <?php }
        if (validation_errors()) { ?>
         <div class="error" >  
            <?php echo validation_errors(); ?>
        </div> 
       <?php     
        }
        ?>
<br/>
    <form id="form_login" name="form_login" method="post" action="<?php echo site_url('login'); ?>">
        <table  cellpadding="0" cellspacing="0"  >
            <tr>
                <td>Usuário:&nbsp;&nbsp;</td>
                <td><input type="text" id="user" name="user" class="input-login" size="20"/><br /></td>
            </tr>
            <tr>
                <td colspan="2"><br/></td>
            </tr>
            <tr>
                <td>Senha:</td>
                <td><input type="password" id="pass" name="pass" class="input-pass" size="20"/></td>
            </tr>
            <tr align="center">
                <td colspan="2"><br/>
                    <input type="submit" value="Entrar" class="btn" /></td>
            </tr>
        </table>
        <br />

    </form>

        </div>
        
</center>
