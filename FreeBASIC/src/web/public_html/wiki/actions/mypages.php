<?php

// actions/mypages.php
// written by Carlo Zottmann
// http://wakkawikki.com/CarloZottmann

if ($user = $this->GetUser())
{
	print("<strong>This is the list of pages you own.</strong><br /><br />\n");

	$my_pages_count = 0;

	if ($pages = $this->LoadAllPages())
	{
		foreach ($pages as $page)
		{
			if ($this->GetUserName() == $page["owner"]) {
				$firstChar = strtoupper($page["tag"][0]);
				if (!preg_match("/[A-Z,a-z]/", $firstChar)) {
					$firstChar = "#";
				}
	
				if ($firstChar != $curChar) {
					if ($curChar) print("<br />\n");
					print("<strong>$firstChar</strong><br />\n");
					$curChar = $firstChar;
				}
	
				print($this->Link($page["tag"])."<br />\n");
				
				$my_pages_count++;
			}
		}
		
		if ($my_pages_count == 0)
		{
			print("<em>You don't own any pages.</em>");
		}
	}
	else
	{
		print("<em>No pages found.</em>");
	}
}
else
{
	print("<em>You're not logged in, thus the list of your pages couldn't be retrieved.</em>");
}

?>