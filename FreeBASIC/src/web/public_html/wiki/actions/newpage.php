<?php
// author: costal martignier
// beschreibung: erstellt eine seite
// parameter: keine
// lizenz: GPL
// email: wakkaactions@martignier.net
// url: http://knowledge.martignier.net

// Modified by JsnX and JavaWoman 2005-1-17
//   Added check for posted page name,
//   Added check for valid CamelCase page names,
//   Modified to use FormOpen,
//   Removed hidden "submitted"

$showform = TRUE;

if (isset($_POST['pagename']))
{
	$pagename = $_POST['pagename'];

	if (!(preg_match("/^[A-ZÄÖÜ]+[a-zßäöü]+[A-Z0-9ÄÖÜ][A-Za-z0-9ÄÖÜßäöü]*$/s", $pagename))) 
	{
		echo '<em>The page name "'.$pagename.'" is invalid. Valid page names must start with a capital letter, contain only letters and numbers, and be in CamelCase format.</em>';
	}
	else 
	{
		$url = $this->config['base_url'];
		$this->redirect($url.$pagename.'/edit');
		$showform = FALSE;
	}
}

if ($showform)
{ ?>
	<br />
	<?php echo $this->FormOpen(); ?>
		<input type="text" name="pagename" size="50" value="<?php echo $pagename; ?>" />  
		<input type="submit" value="Create and Edit" />
	<?php echo $this->FormClose(); 
} 
?>