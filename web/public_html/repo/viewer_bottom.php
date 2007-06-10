<?php
/***************************************************************************
 *                             viewer_bottom.php
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

$include_location = "./";
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

show_footer_page();

?>
