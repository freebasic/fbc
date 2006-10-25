<?php
/***************************************************************************
 *                                  mov.php
 *                            -------------------
 *   begin                : Saturday', Mar 28', 2004
 *   copyright            : ('C) 2004 Peter R Theis
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
echo "<object codeBase=http://www.apple.com/qtactivex/qtplugin.cab classid=\"clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B\" id=\"AdView\" width=100% height=100%>";
echo "<PARAM name=\"autoplay\" value=\"true\">\n";
echo "<PARAM NAME=name=\"controller\" value=\"false\">\n";
echo "<PARAM NAME=\"SRC\" VALUE=\"$current_dir/$filename\"> ";
echo "<PARAM NAME=\"ViewerParams\" VALUE=\"?backcolor='12500670'&amp;layersoff='()'&amp;layerson='()'&amp;notifymissingfonts='true'&amp;papervisible='true'&amp;view=''\"> ";
echo "<EMBED SRC=\"$current_dir/$filename\" HEIGHT=100% WIDTH=100% autoplay=\"true\" CONTROLLER=\"false\" PLUGINSPAGE=\"http://www.apple.com/quicktime/download/\">";
echo "<NOEMBED> Your browser does not support embedded DWF files. </NOEMBED> </EMBED></OBJECT>";
echo "</center>\n";
echo "</body>\n";
echo "</html>\n";
?>