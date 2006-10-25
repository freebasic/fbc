<div class="page">
<?php

if ($this->UserIsOwner())
{
	if ($_POST)
	{

		$default_read_acl = $this->GetConfigValue("default_read_acl");
		$default_write_acl = $this->GetConfigValue("default_write_acl");
		$default_comment_acl = $this->GetConfigValue("default_comment_acl");
		$posted_read_acl = $_POST["read_acl"];			
		$posted_write_acl = $_POST["write_acl"];			
		$posted_comment_acl = $_POST["comment_acl"];	
		$message = "";	

		// store lists only if ACLs have previously been defined,
		// or if the posted values are different than the defaults

		$page = $this->LoadSingle("select * from ".$this->config["table_prefix"]."acls where page_tag = '".mysql_real_escape_string($this->GetPageTag())."' limit 1");
		if ($page || ($posted_read_acl != $default_read_acl || $posted_write_acl != $default_write_acl || $posted_comment_acl != $default_comment_acl ))
		{
			$this->SaveACL($this->GetPageTag(), "read", $this->TrimACLs($posted_read_acl));
			$this->SaveACL($this->GetPageTag(), "write", $this->TrimACLs($posted_write_acl));
			$this->SaveACL($this->GetPageTag(), "comment", $this->TrimACLs($posted_comment_acl));
			$message = "Access control lists updated.";		
		}

		// change owner?
		$newowner = $_POST["newowner"];
		if (($newowner <> "same") and ($this->GetPageOwner($this->GetPageTag()) <> $newowner))
		{
			if ($newowner == "") $newowner = "(Nobody)"; 
			$this->SetPageOwner($this->GetPageTag(), $newowner);
			$message .= "  Ownership changed to ".$newowner.".";
		}

		// redirect back to page
		$this->Redirect($this->Href(), $message);
	}
	else
	{
		// show form
		?>
		<h3>Access Control Lists for <?php echo $this->Link($this->GetPageTag()) ?></h3>
		<br />
		
		<?php echo $this->FormOpen("acls") ?>
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="top" style="padding-right: 20px">
					<strong>Read ACL:</strong><br />
					<textarea name="read_acl" rows="4" cols="20"><?php echo $this->ACLs["read_acl"] ?></textarea>
				<td>
				<td valign="top" style="padding-right: 20px">
					<strong>Write ACL:</strong><br />
					<textarea name="write_acl" rows="4" cols="20"><?php echo $this->ACLs["write_acl"] ?></textarea>
				<td>
				<td valign="top" style="padding-right: 20px">
					<strong>Comments ACL:</strong><br />
					<textarea name="comment_acl" rows="4" cols="20"><?php echo $this->ACLs["comment_acl"] ?></textarea>
				<td>
			</tr>
			<tr>
				<td colspan="3">
					<br />
					<input type="submit" value="Store ACLs" style="width: 120px" accesskey="s" />
					<input type="button" value="Cancel" onclick="history.back();" style="width: 120px" />
				</td>
				<td colspan="3">
					<strong>Set Page Owner:</strong><br />
					<select name="newowner">
						<option value="same"><?php echo $this->GetPageOwner() ?> (Current Owner)</option>
						<option value="(Public)">(Public)</option>
						<option value="">(Nobody - Set free)</option>
						<?php
						if ($users = $this->LoadUsers())
						{
							foreach($users as $user)
							{
								print("<option value=\"".$this->htmlspecialchars_ent($user["name"])."\">".$user["name"]."</option>\n");
							}
						}
						?>
					</select>
				<td>
			</tr>
			<tr>
				<td colspan="3">
				<br /><h4>Syntax:</h4><br />
					* = Everyone<br />
					+ = Registered users<br />
					Or enter individual user WikiNames, one per line<br />
					--------------------------------------<br />
					Note: Any of these items can be negated with a !<br />
					!* = No one<br />
					!+ = Anonymous users<br />
					!JohnDoe = JohnDoe will be denied access.<br />
					<br />
					<em>Be aware that the ACLs are tested in the order specified.</em>
					<br/ >So be sure to specify * on a separate line 
					<br /><b>after</b> negating any users--not before.
					<br/ >Otherwise, the * everyone condition will always give access 
					<br/ >before the list of users that should not have access is tested. 
				<td>
			</tr>
		</table>
		<?php
		print($this->FormClose());
	}
}
else
{
	print('<!-- <wiki-error>forbidden</wiki-error> --><em>You are not the owner of this page.</em>');
}

?>
</div>