<?php

// author: costal martignier
// beschreibung: ermöglicht es bei einem vergessenen passwort ein neues bzw. temporäres per mail zu schicken lassen
// description: makes it possible to send a temporary password by mail for users who have forgotten their password
// parameter: keine
// parameter:  none
// lizenz: http://comawiki.martignier.net/LizenzenUndBedingungen
// license:  http://comawiki.martignier.net/LizenzenUndBedingungen
// email: actions@martignier.net
// url: http://comawiki.martignier.net

if (!$_POST["wikiname"] == "")
{
  $user = $_POST["wikiname"];
  if (($user = $this->LoadUser($_POST["wikiname"])) && ($this->IsWikiName($_POST["wikiname"])))
  {
	$email = $this->Format($user['email']);
	$md5pass = $this->Format($user['password']);
	$reference = "Change of password for ".$this->config['base_url'];

	$header = "From: ".$this->config['wakka_name']." <".$this->config['admin_email'].">";

	$message  = "Hi, ".$user['name'].".\n\nYou or someone else requested that we send a temporary password to login to ".$this->config['wakka_name'].".\n\n";
	$message .= "If you did not request this, disregard this email. -- No action is necessary. -- Your password will stay the same.\n\n";
	$message .= "Your wikiname: ".$user['name']." \n";
	$message .= "Temporary password: ".$md5pass."\n";
	$message .= $this->config['base_url']."\n\n";
	$message .= "Do not forget to change the password immediately after logging in.\n";

	mail($email,$reference,$message,$header);

	echo "<br />A temporary password was sent to the registered email address of ".$user['name'].". <br /><br />";
  }
  else
  {
  echo "<font color=\"red\">You entered a non-existent user,<br />";
  echo "or you did not write the user name as a proper WikiName with capital letters. <br /><br />";
  echo "Try again:<br /><br /></font>";

	$form  = "<form name=\"getwikiname\" action=\"\" method=\"post\">";
	$form .= "<input type=\"text\" name=\"wikiname\" value=\"\"><br />";
	$form .= "<input type=\"submit\" value=\"Send password\" /></form>";
	echo $form;
  }
}
else
{
	echo "Enter your WikiName and a temporary password will be sent to the registered email address.<br /><br />";

	$form  = "<form name=\"getwikiname\" action=\"\" method=\"post\">";
	$form .= "<input type=\"text\" name=\"wikiname\" value=\"\"><br />";
	$form .= "<input type=\"submit\" value=\"Send password\" /></form>";
	echo $form;
}
?>