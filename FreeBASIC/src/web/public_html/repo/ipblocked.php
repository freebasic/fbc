<?php
/***************************************************************************
 *                               ipblocked.php
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

if ( !defined('IN_PHPATM') )
{
	die("Hacking attempt");
}

// Costante utilizzata in functions.php
define('SID', '');

// Alcuni include vitali, non cambiatene l'ordine!!!
include($include_location.'include/functions.'.$phpExt);

// Le pagine non devono rimanere in cache..
header("Expires: Mon, 03 Jan 2000 00:00:00 GMT");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
header("Cache-Control: no-cache, must-revalidate");
header("Pragma: no-cache");

require($include_location."${languages_folder_name}/${dft_language}.${phpExt}");

// Inizializzo alcune variabili essenziali
if (!isset($skinindex))
	$skinindex = 0;

if ($skinindex > count($skins))
  $skinindex = 0;

$bordercolor=$skins[$skinindex]["bordercolor"];
$headercolor = $skins[$skinindex]["headercolor"];
$tablecolor=$skins[$skinindex]["tablecolor"];
$lightcolor=$skins[$skinindex]["lightcolor"];
$headerfontcolor=$skins[$skinindex]["headerfontcolor"];
$normalfontcolor=$skins[$skinindex]["normalfontcolor"];
$selectedfontcolor=$skins[$skinindex]["selectedfontcolor"];

place_message($mess[207], $mess[207], basename(__FILE__));

echo "<BR><B><FONT SIZE=3 FACE=\"$font\" COLOR=#FF0000>";
echo $mess[208]."<BR>";
echo $mess[209]."<BR><A HREF=\"mailto:$admin_email\" STYLE=\"font-size:12pt;\">".$admin_email."</A>";
echo "</FONT></B><BR><BR>";

show_footer_page();
?>

