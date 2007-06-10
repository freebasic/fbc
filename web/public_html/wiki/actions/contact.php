<?php
/**
 * Print a spam-safe mailto: link to the administrator's email address. 
 * 
 * Note: plain mailto links are a common source of spam.
 */

$email = $this->GetConfigValue("admin_email");

// print spam-safe mailto link
$patterns = array("'@'", "'\.'");
$replace = array("[at]", "[dot]"); 
echo "<a href=\"mailto:".preg_replace($patterns, $replace, $email)."\" title=\"Send us your feedback\">Contact</a>"; #i18n

// print plain mailto link
//echo "<a href=\"mailto:".$email."\" title=\"Send us your feedback\">Contact</a>"; #i18n

// print contact link only to registered users
// echo ($this->GetUser()) ? "<a href=\"mailto:".$email."\" title=\"Send us your feedback\">Contact</a>" : ""; #i18n

?>