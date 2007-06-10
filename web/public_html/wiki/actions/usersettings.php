<?php
if (isset($_REQUEST["action"]) && ($_REQUEST["action"] == "logout"))
{
	$this->LogoutUser();
	$this->Redirect($this->href(), "You are now logged out.");
}
else if ($user = $this->GetUser())
{
	
	// is user trying to update?
	if (isset($_REQUEST["action"]) && ($_REQUEST["action"] == "update"))
	{
		$this->Query("update ".$this->config["table_prefix"]."users set ".
			"email = '".mysql_real_escape_string($_POST["email"])."', ".
			"doubleclickedit = '".mysql_real_escape_string($_POST["doubleclickedit"])."', ".
			"show_comments = '".mysql_real_escape_string($_POST["show_comments"])."', ".
			"revisioncount = '".mysql_real_escape_string($_POST["revisioncount"])."', ".
			"changescount = '".mysql_real_escape_string($_POST["changescount"])."' ".
			"where name = '".$user["name"]."' limit 1");
		
		$this->SetUser($this->LoadUser($user["name"]));
		
		// forward
		$this->Redirect($this->href(), "User settings stored!");
	}
	
	if (isset($_REQUEST["action"]) && ($_REQUEST["action"] == "changepass"))
	{
			// check password
			$password = $_POST["password"];			
                        if (preg_match("/ /", $password)) $passerror = "Sorry, blanks are not permitted in the password.";
			else if (strlen($password) < 5) $passerror = "Tsk tsk, the password is much too short...";
			else if (($user["password"] == md5($_POST["oldpass"])) || ($user["password"] == $_POST["oldpass"]))
			{
				$this->Query("update ".$this->config["table_prefix"]."users set "."password = md5('".mysql_real_escape_string($password)."') "."where name = '".$user["name"]."'");				
				$user["password"]=md5($password);
				$this->SetUser($user);
				$this->Redirect($this->href(), "Password changed.");
			}
			else
			{
				$passerror = "The old password you entered is wrong.";
			}
	}

	print "<script type=\"text/javascript\"><!-- \nfunction hov(loc,cls){ \n    if(loc.className) loc.className=cls;\n}\n //-->\n</script>\n";
	// user is logged in; display config form
	print($this->FormOpen());
	?>
	<input type="hidden" name="action" value="update" />
	<table>
		<tr>
			<td align="right"></td>
			<td>Hello, <?php echo $this->Link($user["name"]) ?>!</td>
		</tr>
		<tr>
			<td align="right">Your email address:</td>
			<td><input name="email" value="<?php echo $this->htmlspecialchars_ent($user["email"]) ?>" size="40" /></td>
		</tr>
		<tr>
			<td align="right">Doubleclick Editing:</td>
			<td><input type="hidden" name="doubleclickedit" value="N"><input type="checkbox" name="doubleclickedit" value="Y" <?php echo $user["doubleclickedit"] == "Y" ? "checked=\"checked\"" : "" ?> /></td>
		</tr>
		<tr>
			<td align="right">Show comments by default:</td>
			<td><input type="hidden" name="show_comments" value="N"><input type="checkbox" name="show_comments" value="Y" <?php echo $user["show_comments"] == "Y" ? "checked=\"checked\"" : "" ?> /></td>
		</tr>
		<tr>
			<td align="right">RecentChanges display limit:</td>
			<td><input name="changescount" value="<?php echo $this->htmlspecialchars_ent($user["changescount"]) ?>" size="40" /></td>
		</tr>
		<tr>
			<td align="right">Page revisions list limit:</td>
			<td><input name="revisioncount" value="<?php echo $this->htmlspecialchars_ent($user["revisioncount"]) ?>" size="40" /></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" value="Update Settings" /> <input type="button" value="Logout" onclick="document.location='<?php echo $this->href("", "", "action=logout"); ?>'" /></td>
		</tr>
	</table>
	<?php
	print($this->FormClose());

	print($this->FormOpen());
	?>
	<input type="hidden" name="action" value="changepass" />
	<table>
		<tr>
			<td align="left"><b>Change your password:</b></td>
			<td><br /><br />&nbsp;</td>
		</tr>
		<?php
		if (isset($passerror))
		{
			print('<!-- <wiki-error>invalid username or pwd</wiki-error> --><tr><td></td><td><div class="error">'.$this->Format($passerror)."</div></td></tr>\n");
		}
		?>
		<tr>
			<td align="left">Your current password:</td>
			<td><input type="password" name="oldpass" size="40" /></td>
		</tr>
		<tr>
			<td align="left">Your new password:</td>
			<td><input type="password" name="password" size="40" /></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" value="Change" size="40" /></td>

		</tr>
	</table>
	<br />
	See a list of pages you own (<a href="<?php echo $this->href("", "MyPages"); ?>">MyPages</a>) and pages you've edited (<a href="<?php echo $this->href("", "MyChanges"); ?>">MyChanges</a>).<br />
	<?php
	print($this->FormClose());
}
else
{
	// user is not logged in

	print "<script type=\"text/javascript\"><!-- \nfunction hov(loc,cls){ \n    if(loc.className) loc.className=cls;\n}\n //-->\n</script>\n";

	// is user trying to log in or register?
	if (isset($_REQUEST["action"]) && ($_REQUEST["action"] == "login"))
	{
		// if user name already exists, check password
		if ($existingUser = $this->LoadUser($_POST["name"]))
		{
			// check password
			if ($existingUser["password"] == md5($_POST["password"]))
			{
				$this->SetUser($existingUser);
				$this->Redirect($this->href());
			}
			else
			{
				$error = "Wrong password!";
			}
		}
		// otherwise, create new account
		else
		{
			$name = trim($_POST["name"]);
			$email = trim($_POST["email"]);
			$password = $_POST["password"];
			$confpassword = $_POST["confpassword"];

			// check if name is WikiName style
			if( isset( $this->config["accept_new_users"] ) && ($this->config["accept_new_users"] == '0') )
				$error = 'Sorry, no new users are been accepted, please post a message in the Documentation forum requesting for an account, thanks.';
			elseif ($this->ExistsPage($name)) 
				$error = 'Sorry, this ""WikiName"" is reserved for a page. Please choose a different name.';
			elseif (!$this->IsWikiName($name)) 
				$error = "User name must be WikiName formatted!";
			elseif (!$email) 
				$error = "You must specify an email address.";
			elseif (!preg_match("/^.+?\@.+?\..+$/", $email)) 
				$error = "That doesn't quite look like an email address.";
			elseif ($confpassword != $password) 
				$error = "Passwords didn't match.";
			elseif (preg_match("/ /", $password)) 
				$error = "Spaces aren't allowed in passwords.";
			elseif (strlen($password) < 5) 
				$error = "Password too short.";
			else
			{
				$this->Query("insert into ".$this->config["table_prefix"]."users set ".
					"signuptime = now(), ".
					"name = '".mysql_real_escape_string($name)."', ".
					"email = '".mysql_real_escape_string($email)."', ".
					"password = md5('".mysql_real_escape_string($_POST["password"])."')");

				// log in
				$this->SetUser($this->LoadUser($name));

				// forward
				$this->Redirect($this->href());
			}
		}
	}
	elseif  (isset($_REQUEST["action"]) && ($_REQUEST["action"] == "updatepass"))
	{
        	// check if name is WikkiName style
        	$name = trim($_POST["yourname"]);
        	if (!$this->IsWikiName($name)) $newerror = "You have entered an incorrect or non-existent wikiname. The wikiname must be written in wikistyle, e.g: \"\"WikkaName.\"\"";
   
        	// if user name already exists, check password
        	elseif ($existingUser = $this->LoadUser($_POST["yourname"]))   
           	// updatepassword
                if ($existingUser["password"] == $_POST["temppassword"])
                {
                       	$this->SetUser($existingUser, $_POST["remember"]);
                        $this->Redirect($this->href());
                }
                else
               {
                      	$newerror = "Sorry, you entered the wrong password.";
               }
    }
	
	print($this->FormOpen());
	?>
	<input type="hidden" name="action" value="login" />
	<table>
		<tr>
			<td align="right"></td>
			<td><?php echo $this->Format("If you're already a registered user, log in here!"); ?></td>
		</tr>
		<?php
		if (isset($error))
		{
			print('<!-- <wiki-error>invalid username or pwd</wiki-error> --><tr><td></td><td><div class="error">'.$this->Format($error)."</div></td></tr>\n");
		}
		?>
		<tr>
			<td align="right">Your WikiName:</td>
			<td><input name="name" size="40" value="<?php if (isset($name)) echo $name; ?>" /></td>
		</tr>
		<tr>
			<td align="right">Password (5+ chars):</td>
			<td><input type="password" name="password" size="40" /></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" value="Login" size="40" /></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td width="500"><?php echo $this->Format("Stuff you only need to fill in when you're logging in for the first time (and thus signing up as a new user on this site)."); ?></td>
		</tr>
		<tr>
			<td align="right">Confirm password:</td>
			<td><input type="password" name="confpassword" size="40" /></td>
		</tr>
		<tr>
			<td align="right">Email address:</td>
			<td><input name="email" size="40" value="<?php if (isset($email)) echo $email; ?>" /></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" value="Register" size="40" /></td>
		</tr>
	</table>
	<?php
	print($this->FormClose());
	print($this->FormOpen());
	?>
	<input type="hidden" name="action" value="updatepass" />
	<table>
      	<tr> 
         		<td colspan="2"><br /><hr /><h4>Forget your password?</h4></td><td></td>
         	</tr>
		<tr>
			<td align="left"></td>
			<td>Log in here with the temporary password. <br />If you need a temporary password, click <?php echo $this->Format("[[PasswordForgotten here]]") ?></td>
		</tr>
            <?php   
            if (isset($newerror))
            {	
            	print('<!-- <wiki-error>invalid username or pwd</wiki-error> --><tr><td></td><td><div class="error">'.$this->Format($newerror)."</div></td></tr>\n");
		}	
            ?>
		<tr>
			<td align="left">Your WikiName:</td>
			<td><input name="yourname" value="<?php if (isset($_POST["yourname"])) echo $_POST["yourname"]; ?>" size="40" /></td>
		</tr>
		<tr>
			<td align="left">Your temp password:</td>
			<td><input name="temppassword" size="40" /></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit" value="Login" size="40" /></td>
		</tr>
	   </table>
	   <?php
	   print($this->FormClose());
}
?>