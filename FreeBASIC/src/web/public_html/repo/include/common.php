<?php
/***************************************************************************
 *                               common.php
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

if ( !defined('IN_PHPATM') )
{
	die("Hacking attempt");
}

// Alcuni include vitali, non cambiatene l'ordine!!!
include('include/functions.php');

// Impostazione dell'header location http/1.1 compliant
$header_location = ( @preg_match('/Microsoft|WebSTAR|Xitami/', getenv('SERVER_SOFTWARE')) ) ? 'Refresh: 0; URL=' : 'Location: ';
if (substr(dirname($HTTP_SERVER_VARS['PHP_SELF']), 0, 1) == '/')
{
	$header_location = $header_location."http://".$HTTP_SERVER_VARS['HTTP_HOST'].dirname($HTTP_SERVER_VARS['PHP_SELF'])."/";
}
else
{
	$header_location = $header_location."http://".$HTTP_SERVER_VARS['HTTP_HOST']."/".dirname($HTTP_SERVER_VARS['PHP_SELF'])."/";
}

// Utente con ip bloccato
if (is_ip_blocked(getenv('REMOTE_ADDR')))
{
	header($header_location.'ipblocked.'.$phpExt);
	exit;
}

// Registro la sessione o recupero quella attiva
session_start();

// Recupero la versione del php correntemente in uso
$version = phpversion();
$major = substr($version, 0, 1);
$release = substr($version, 2, 1);

// Le pagine non devono rimanere in cache..
header("Expires: Mon, 03 Jan 2000 00:00:00 GMT");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
header("Cache-Control: no-cache, must-revalidate");
header("Pragma: no-cache");

// Inizializzo alcune variabili essenziali

$action = getPostVar('action');
if (!isset($action))
	$action = getGetVar('action');
if (!isset($action))
	$action = '';

$logged_user_id = getSessionVar('logged_user_id');
$logged_user_name = getSessionVar('logged_user_name');
if (!isset($logged_user_name))
	$logged_user_name = '';

$language = getSessionVar('language');
if (!isset($language))
	$language = $dft_language;

$skinindex = getSessionVar('skinindex');
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


// Inizializzo alcune variabili
$activationcode = USER_DISABLED;
$user_status = ANONYMOUS;

// Carico le info sull'utente loggato
if ($logged_user_name != '' && !check_is_user_session_active($logged_user_name))
{
	$user_status = ANONYMOUS;
	$logged_user_name = '';
}

// L'utente non è loggato
if ($user_status == ANONYMOUS)
  $logged_user_name = '';

// L'utente loggato è disabilitato o non ha ancora attivato l'account
if ($activationcode != USER_ACTIVE)
{
  $user_status = ANONYMOUS;
  $logged_user_name = '';
}

// scrivo nella sessione le lingue disponibili, in modo da non dover leggere
// i file .lang ogni volta che una pagina viene richiamata
$languages = getSessionVar('languages');
if (!isset($languages) || !is_array($languages))
{
	$languages = available_languages($languages_folder_name);
	if ($major > 4 || $release > 0)
	{
		$_SESSION['languages'] = $languages;
	}
	else
	{
		$HTTP_SESSION_VARS['languages'] = $languages;
	}
}
$timeoffset = -$GMToffset + $languages[$language]['TimeZone'];

include("${languages_folder_name}/${language}.php");

?>
