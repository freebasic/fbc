<?php
/***************************************************************************
 *                                  swf.php
 *                            -------------------
 *   begin                : Saturday', Mar 28', 2004
 *   copyright            : ('C) 2004 MrScripto
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
// $directory: contains the directory (relative to upload folder) of the file to be showed
// $filename: contains the filename to be showed
//

//
// START OF VIEWER MAIN CODE
//
echo "<html>\n";
echo "<head><title></title></head>\n";
echo "<body>\n";
echo "<center>\n";

echo "<OBJECT classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\"
codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0\" width=\"100%\" height=\"100%\">
<PARAM NAME=movie VALUE=\"".$installurl."/".$uploads_folder_name."/".$directory."/".$filename."\">
<PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=#ffffff>
<EMBED src=\"".$installurl."/".$uploads_folder_name."/".$directory."/".$filename."\"
width=\"450\"quality=high bgcolor=#FFFFFF TYPE=\"application/x-shockwave-flash\"
PLUGINSPAGE=\"http://www.macromedia.com/go/getflashplayer\"></EMBED>
</OBJECT>";

echo "</center>\n";
echo "</body>\n";
echo "</html>\n";

?>