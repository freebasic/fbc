<?php
/***************************************************************************
 *                                 txt.php
 *                            -------------------
 *   begin                : Saturday', Mar 08', 2003
 *   copyright            : ('C) 2002-03 Bugada Andrea
 *   email                : phpATM@free.fr
 *
 *   $Id$
 *
 *
 ***************************************************************************/

/***************************************************************************
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License', or
 *   ('at your option) any later version.
 *
 ***************************************************************************/

//
// VIEWER VARIABLES SET
// ------------------------------------------------------------------------------------------
// $current_dir: contains the directory (absolute path) of the file to be showed
// $filename: contains the filename to be showed
//

//
// Converte alcuni caratteri nel buffer in entità html
//
function txt_vers_html($text)
{
	$text = str_replace('&', '&amp;', $text);
	$text = str_replace('<', '&lt;', $text);
	$text = str_replace('>', '&gt;', $text);
	$text = str_replace('\"', '&quot;', $text);
	return $text;
}

//
// START OF VIEWER MAIN CODE
//
echo "<html>\n";
echo "<head><title></title></head>\n";
echo "<body>\n";
$fp=@fopen("$current_dir/$filename", "r");
if ($fp)
{
	echo "<font face=\"$font\" color=\"$normalfontcolor\" size=\"1\">\n";

	while(!feof($fp))
	{
		$buffer=fgets($fp,4096);
		$buffer=txt_vers_html($buffer);
		$buffer=str_replace("\t","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",$buffer);
		echo $buffer."<br>";
	}
	fclose($fp);
	echo "</font>\n";
}
else
{
	echo "<font face=\"$font\" color=\"$normalfontcolor\" size=\"2\">$mess[31] : $current_dir/$filename</font>";
}
echo "</body>\n";
echo "</html>\n";

?>