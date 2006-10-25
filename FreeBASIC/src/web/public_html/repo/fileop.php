<?php
/***************************************************************************
 *                                fileop.php
 *                            -------------------
 *   begin                : Tuesday', Aug 15', 2002
 *   copyright            : ('C) 2002 Bugada Andrea
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

function show_rename_file($filename, $owner_name, $description)
{
	global $bordercolor, $headercolor, $font, $headerfont, $headerfontcolor, $tablecolor,
		   $directory, $order, $direction, $normalfontcolor, $mess, $phpExt;

  echo "  <br>";
  echo "  <table class=\"tb_dir_list\">\n";
  echo "    <tr>\n";
  echo "      <th align=\"left\" bgcolor=\"$headercolor\" valign=\"middle\"><font size=\"2\" face=\"$font\" color=\"$headerfontcolor\">$mess[193]</font></th>\n";
  echo "    </tr>\n";
  echo "    <tr>\n";
  echo "        <td align=\"left\" bgcolor=\"$tablecolor\" valign=\"middle\">\n";
  echo "        <form name=\"rename\" action=\"index.$phpExt?".SID."\"  method=\"post\" style=\"margin: 0\">\n";
  echo "          <input type=\"hidden\" name=\"old_description\" value=\"$description\">\n";
  echo "          <input type=\"hidden\" name=\"filename\" value=\"$filename\">\n";
  echo "          <input type=\"hidden\" name=\"action\" value=\"rename\">\n";
  echo "          <input type=\"hidden\" name=\"directory\" value=\"$directory\">\n";
  echo "          <input type=\"hidden\" name=\"order\" value=\"$order\">\n";
  echo "          <input type=\"hidden\" name=\"direction\" value=\"$direction\">\n";
  echo "          <table border=\"0\" width=\"100%\" cellpadding=\"4\">\n";
  echo "            <tr>\n";
  echo "              <td align=\"left\" width=\"15%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[19]</font></td>\n";
  echo "              <td align=\"left\" width=\"90%\" colspan=\"2\">\n";
  echo "                <font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$owner_name</font>";
  echo "              </td>\n";
  echo "            </tr>\n";
  echo "            <tr>\n";
  echo "              <td align=\"left\" width=\"15%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[192]</font></td>\n";
  echo "              <td align=\"left\" width=\"90%\" colspan=\"2\">\n";
  echo "                <input type=\"text\" class=\"vform\" name=\"userfile\" size=\"62\" value=\"$filename\" />\n";
  echo "              </td>\n";
  echo "            </tr>\n";
  echo "            <tr> \n";
  echo "              <td align=\"left\" width=\"15%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[22]</font></td>\n";
  echo "              <td align=\"left\" width=\"70%\">\n";
  echo "                <input type=\"text\" name=\"new_description\" class=\"vform\" size=62 value=\"$description\">\n";
  echo "              </td>\n";
  echo "              <td align=\"right\" width=\"15%\">\n";
  echo "                <input type=\"submit\" class=\"vform\" value=\"$mess[191]\" />\n";
  echo "              </td>\n";
  echo "            </tr>\n";

  echo "          </table>\n";
  echo "        </form>\n";

  echo "        </td>\n";
  echo "    </tr>\n";
  echo "    </table>\n";
}

function show_rename_dir($filename)
{
	global $bordercolor, $headercolor, $font, $headerfont, $headerfontcolor, $tablecolor,
		   $directory, $order, $direction, $normalfontcolor, $mess, $phpExt;

  echo "  <br>";
  echo "  <table class=\"tb_dir_list\">\n";
  echo "    <tr>\n";
  echo "      <th align=\"left\" bgcolor=\"$headercolor\" valign=\"middle\"><font size=\"2\" face=\"$font\" color=\"$headerfontcolor\">$mess[193]</font></th>\n";
  echo "    </tr>\n";
  echo "    <tr>\n";
  echo "        <td align=\"left\" bgcolor=\"$tablecolor\" valign=\"middle\">\n";
  echo "        <form name=\"rename\" action=\"index.$phpExt?".SID."\" method=\"post\" style=\"margin: 0\">\n";
  echo "          <input type=\"hidden\" name=\"action\" value=\"rename\">\n";
  echo "          <input type=\"hidden\" name=\"order\" value=\"$order\">\n";
  echo "          <input type=\"hidden\" name=\"direction\" value=\"$direction\">\n";
  echo "          <table border=\"0\" width=\"100%\" cellpadding=\"4\">\n";
  echo "            <tr>\n";
  echo "              <td align=\"left\" width=\"15%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[187]</font></td>\n";
  echo "              <td align=\"left\" width=\"70%\" colspan=\"2\">\n";
  echo "                <input type=\"text\" class=\"vform\" name=\"userfile\" size=\"62\" value=\"$filename\" />\n";
  echo "              </td>\n";
  echo "              <td align=\"right\" width=\"15%\">\n";
  echo "                <input type=\"submit\" class=\"vform\" value=\"$mess[191]\" />\n";
  echo "              </td>\n";
  echo "            </tr>\n";
  echo "          </table>\n";
  echo "        </form>\n";

  echo "        </td>\n";
  echo "    </tr>\n";
  echo "    </table>\n";
}

//----------------------------------------------------------------------------
//      MAIN
//----------------------------------------------------------------------------

// Se l'utente non è loggato lo porto a index.php
if ($logged_user_name == '')
{
	header($header_location.'index.'.$phpExt.'?'.SID);
	exit;
}

switch($action)
{
	case 'rename';
	
		$filename = getGetVar('filename');
		$directory = getGetVar('directory');
		$order = getGetVar('order');
		$direction = getGetVar('direction');
	
		list($upl_user, $upl_ip, $activated, $contents) = get_file_description("$uploads_folder_name/$directory/$filename", 0, 0);
		place_message($mess[191], $mess[193], basename(__FILE__));

		if (!is_dir("$uploads_folder_name/$directory/$filename"))
			show_rename_file($filename, $upl_user, $contents);
		else
			show_rename_dir($filename);

		break;

	default;
		header($header_location.'index.'.$phpExt.'?'.SID);
		break;
}

show_footer_page();
?>