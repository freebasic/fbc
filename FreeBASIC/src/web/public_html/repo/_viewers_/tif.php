<?php
/***************************************************************************
 *                                  tif.php
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
// $directory:   contains the directory (relative to upload folder) of the file to be showed
// $filename:    contains the filename to be showed
//

//
// START OF VIEWER MAIN CODE
//
echo "<html>\n";
echo "<head><title></title></head>\n";
echo "<body>\n";
echo "<center>\n";
echo "<object classid=\"CLSID:106E49CF-797A-11D2-81A2-00E02C015623\">\n";
echo "<param name=\"src\" value=\"getimg.${phpExt}?image=$directory/$filename&".SID."\">\n";
echo "<param name=\"toolbar\" value=\"bottom\">\n";
echo "<embed src=\"getimg.${phpExt}?image=$directory/$filename&".SID."\" type=\"image/tiff\" toolbar=bottom>\n";
echo "</object>\n";
echo "<br><br><font size=\"-1\" face=\"Arial, Helvetica, sans-serif\">If you do not see an image above, please<br>visit
      <a href=\"http://www.alternatiff.com\" target=\"_blank\">this site</a> and install the AlternaTIFF Viewer.</font>";
echo "</center>\n";
echo "</body>\n";
echo "</html>\n";
?>