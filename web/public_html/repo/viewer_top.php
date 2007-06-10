<?php
/***************************************************************************
 *                              viewer_top.php
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

define('IN_PHPATM', true);

$include_location = dirname($HTTP_SERVER_VARS['SCRIPT_FILENAME'])."/";
include($include_location.'include/conf.php');
include($include_location.'include/common.'.$phpExt);

$filename  = $HTTP_GET_VARS['file'];
$directory = $HTTP_GET_VARS['dir'];

$current_dir = $uploads_folder_name;
if ($directory != '')
{
	$current_dir.="/$directory";
}

$bodytag = $skins[$skinindex]["bodytag"];
echo "<html><head><title>$mess[26]: $filename</title>";
echo "<link rel=\"stylesheet\" href=\"styles.css\" type=\"text/css\">";

if ($charsetencoding != "")
	echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=$charsetencoding\">";

echo "<style type=\"text/css\"></style></head><body $bodytag>";

echo "<center>\n";
echo "<font face=\"$font\" color=\"$normalfontcolor\" size=\"2\">$mess[26] : ";
echo "<img src=\"images/".get_mimetype_img("$current_dir/$filename")."\" align=\"ABSMIDDLE\">\n";
echo "<b>".$filename."</b></font>\n";
echo "<img src=\"images/empty.gif\" width=\"20\" height=\"40\" border=\"0\" align=\"ABSMIDDLE\"></a>";
echo "<a href=\"javascript:window.print()\"><img src=\"images/imprimer.gif\" alt=\"$mess[27]\" border=\"0\" align=\"ABSMIDDLE\"></a>\n";
echo "<a href=\"index.${phpExt}?action=downloadfile&filename=".$filename."&directory=".$directory."&".SID."\"><img src=\"images/download.gif\" alt=\"$mess[23]\" width=\"20\" height=\"20\" border=\"0\" align=\"ABSMIDDLE\"></a>";
echo "</center>\n";
echo "</body>\n";
echo "</html>";