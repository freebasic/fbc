<?php
if ($pages = $this->LoadAllPages())
{
	if (isset($_REQUEST["letter"])) $requested_letter = $_REQUEST["letter"]; else $requested_letter = '';
	if (!$requested_letter && isset($letter)) $requested_letter = strtoupper($letter); 
	$cached_username = $this->GetUserName();
	$user_owns_pages = false;
	$link = $this->href("", "", "letter=");
	$index_header = "<strong><a href='$link'>All </a></strong>&nbsp;\n";
	$index_output = "";
	$current_character = "";
	$character_changed = false;

	foreach ($pages as $page)
	{
		$page_owner = $page["owner"];
		// $this->CachePage($page);

		$firstChar = strtoupper($page["tag"][0]);
		if (!preg_match("/[A-Za-z]/", $firstChar)) $firstChar = "#";
		if ($firstChar != $current_character) {
			$index_header .= "<strong><a href='$link$firstChar'>$firstChar</a></strong>&nbsp;\n";
			$current_character = $firstChar;
			$character_changed = true;
		}
		if ($requested_letter == '' || $firstChar == $requested_letter) {
			if ($character_changed) {
				$index_output .= "<br />\n<strong>$firstChar</strong><br />\n";
				$character_changed = false;
			}
			$index_output .= $this->Link($page["tag"]);

			if ($cached_username == $page_owner) {                       
				$index_output .= "*";
				$user_owns_pages = true;
			} elseif ($page_owner != '(Public)' && $page_owner != '') {
				$index_output .= " . . . . Owner: ".$page_owner;
			}
		     	$index_output .= "<br />\n";    
		}
	}
	$index_header .= "<br />";
	if ($user_owns_pages) $index_output .= "<br />\n* Indicates a page that you own.<br />\n";    
	print $index_header.$index_output;
} else {
	print("<em>No pages found.</em>");
}
?>