<?php
/***************************************************************************
 *                               functions.php
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

//
// Dato un percorso ne elimina (non li interpreta!) i
// '.' e i '..' potenzialmente pericolosi
//
function clean_path($path)
{

	$path = str_replace("\\", "/", stripslashes($path));
	$path = explode('/', $path);

	$del = 0;
	if (true==true)
	{
		reset($path);
		while (list($key, $value) = each($path))
		{
			if ($value == "." || $value == "..")
			{
				array_splice($path, $key - $del, 1);
				$del++;
			}
		}
	}
	else
	{
		if ($path == "." || $path == "..")
		{
			$path = '';
		}
	}

	$path = implode('/', $path);

	return $path;
}
//
// Ritorna se un tipo di file è visualizzabile o meno
//
function is_viewable($filename)
{
	global $include_location, $viewers_folder_name, $phpExt, $encrypt_filecontent;

	if ($encrypt_filecontent)
		return false;
	
	$path_parts = pathinfo($filename);
	if (isset($path_parts["extension"]))
	{
		$extension = strtolower($path_parts["extension"]);
		$viewer_path = $include_location.$viewers_folder_name."/".$extension.".".$phpExt;

		if (file_exists($viewer_path))
			return true;
	}
	return false;
}

//
// Accede al file contatore di download e ritorna il numero di volte che un
// determinto file è stato scaricato
//
function count_file_download($filename)
{
	if (file_exists("$filename.dlcnt"))
	{
		$fp = fopen("$filename.dlcnt",'r');
		$count = fread($fp, 15);
		fclose($fp);
		return $count;
	}

	return 0;
}

//
// Dato un none di file ne ritorna l'immagine corrispondente al tipo,
// oppure l'immagine di default
//
function get_mimetype_img($filename)
{
	global $mimetypes;

	// Se è una directory prendo l'icona adeguata
	// altrimenti cerco il tipo giusto
	if (is_dir($filename))
	{
		return $mimetypes['directory']['img'];
	}
	else
	{
		reset($mimetypes);
		while (list($key, $value) = each($mimetypes))
		{
			if (eregi($key.'$', $filename))
			{
				return $value['img'];
			}
		}
	}

	// Non ho trovato nulla, quindi metto l'icona di default
	return $mimetypes['default']['img'];
}

//
// Dato un none di file ne ritorna il mimetype corrispondente al tipo,
// oppure il mimetype di default
//
function mime_type($filename)
{
	global $mimetypes;

	reset($mimetypes);
	while (list($key, $value) = each($mimetypes))
	{
		if (eregi($key.'$', $filename))
		{
			return $value['mime'];
		}
	}

	// Non ho trovato nulla, quindi metto l'icona di default
	return $mimetypes['default']['mime'];
}

//
// Ritorna la dimensione del file con relativa unità di misura
//
function format_filesize($size)
{

	if ($size >= 1073741824)
		$size = round($size / 1073741824 * 100) / 100 . ' Gb';
	elseif ($size >= 1048576)
		$size = round($size / 1048576 * 100) / 100 . ' Mb';
	elseif ($size >= 1024)
		$size = round($size / 1024 * 100) / 100 . ' Kb';
	elseif ($size > 0)
		$size = $size . ' b';
	else
		$size = '-';

	return $size;
}

//
// Ritorna la dimensione del file con relativa unità di misura
//
function get_filesize($filename)
{
	$size = filesize($filename);

	if ($size >= 1073741824)
		$size = round($size / 1073741824 * 100) / 100 . ' Gb';
	elseif ($size >= 1048576)
		$size = round($size / 1048576 * 100) / 100 . ' Mb';
	elseif ($size >= 1024)
		$size = round($size / 1024 * 100) / 100 . ' Kb';
	elseif ($size > 0)
		$size = $size . ' b';
	else
		$size = '-';

	return $size;
}

//
// Costruisce il percorso per le statistiche traffico
//
function get_monthstatpath()
{
   global $stats_folder_name;
   return $stats_folder_name."/".date('Y')."/".date('m');
}

//
// Ritorna il file per le statistiche traffico mensile
//
function get_monthstatfile()
{
	$retval =  get_monthstatpath();
	$retval = $retval."/month.stats";
	return $retval;
}

//
// Ritorna il file per le statistiche traffico giornaliero
//
function get_daystatfile()
{
    return get_monthstatpath()."/".date('d');
}

//
// Crea il percorso per le statisitiche di traffico
//
function make_monthpath()
{
	global $stats_folder_name;
	$year = date('Y');
	$month = date('m');

	mkdir($stats_folder_name."/".$year, 0755);
	mkdir($stats_folder_name."/".$year."/".$month, 0755);
}

//
// Ritorna il totale di bytes uploadati nella giornata
//
function get_dayload()
{
	$dayfile = get_daystatfile();
	if (!file_exists(get_monthstatpath()))
           make_monthpath();

	if (file_exists($dayfile))
	{
		$fp = fopen("$dayfile",'r');
		$count = fread($fp, 15);
		fclose($fp);
		return $count;
	}
	return 0;
}

//
// Ritorna il totale di bytes downloadati nella giornata
//
function get_daydownload()
{
	$dayfile = get_daystatfile().".download";
	if (!file_exists(get_monthstatpath()))
           make_monthpath();

	if (file_exists($dayfile))
	{
		$fp = fopen("$dayfile",'r');
		$count = fread($fp, 15);
		fclose($fp);
		return $count;
	}
	return 0;
}

//
// Ritorna il totale di bytes downloadati nel mese
//
function get_monthdownload()
{
	$monthfile = get_monthstatfile().".download";
	if (!file_exists(get_monthstatpath()))
           make_monthpath();

	if (file_exists($monthfile))
	{
		$fp = fopen("$monthfile",'r');
		$count = fread($fp, 15);
		fclose($fp);
		return $count;
	}
	return 0;
}

//
// Scrive il totale di bytes uploadati nella giornata
//
function write_dayload($count)
{
	$dayfile = get_daystatfile();

	$fp = fopen("$dayfile", "w+");
	@flock($fp, LOCK_EX);    // Lock file in exclusive mode
	fwrite($fp, $count, 15);
	@flock($fp, LOCK_UN);
	fclose($fp);
}

//
// Scrive il totale di bytes downloadati nella giornata e nel mese
//
function write_download_bytecount($size)
{
	// Write the day download out.
	$dayfile = get_daystatfile().".download";
	$count = 0;
	if (file_exists($dayfile))
	{
		$tmpfp = fopen("$dayfile",'r');
		$count = fread($tmpfp, 15);
		fclose($tmpfp);
	}
	$count = $count + $size;
	$fp = fopen("$dayfile", "w+");
	@flock($fp, LOCK_EX);    // Lock file in exclusive mode
	fwrite($fp, $count, 15);
	@flock($fp, LOCK_UN);
	fclose($fp);

	// Write the month download out.
	$count = 0;
	$monthfile = get_monthstatfile().".download";
	if (file_exists($monthfile))
	{
		$tmpfp = fopen("$monthfile",'r');
		$count = fread($tmpfp, 15);
		fclose($tmpfp);
	}
	$count = $count + $size;
	$fp = fopen("$monthfile", "w+");
	@flock($fp, LOCK_EX);    // Lock file in exclusive mode
	fwrite($fp, $count, 15);
	@flock($fp, LOCK_UN);
	fclose($fp);
}

//
// Ritorna il totale di bytes uploadati nel mese
//
function get_monthload()
{
	$monthfile = get_monthstatfile();

	if (!file_exists(get_monthstatpath()))
           make_monthpath();

	if (file_exists("$monthfile"))
        {
	    $fp = fopen("$monthfile", 'r');
	    $count = fread($fp, 15);
	    fclose($fp);
	    return $count;
        }
	return 0;
}

//
// Scrive il totale di bytes uploadati nel mese
//
function write_monthload($count)
{
	$monthfile = get_monthstatfile();
	$fp = fopen($monthfile, "w+");
	@flock($fp, LOCK_EX);    // Lock file in exclusive mode
	fwrite($fp, $count, 15);
	@flock($fp, LOCK_UN);
	fclose($fp);
}

//
// Dato un file ritorna se è un file nascosto (da non mostrare) o meno
// E' influenzato dal valore della variabile di configurazione '$showhidden'
// definita in 'conf.php'
//
function show_hidden_files($filename)
{
	global $showhidden;

	if (substr($filename, 0, 1) == '.' && $showhidden == false)
		return false;

	return true;
}

//
// Salva su file le informazioni riguardanti il file specificato in upload
//
function save_file_description($filename, $description, $activated, $logged_user_name, $ip)
{
	$description = stripslashes($description);

	$fp=fopen($filename, 'w+');
	fputs($fp, $logged_user_name."\n");
	fputs($fp, $ip."\n");
	fputs($fp, $activated."\n");
	fputs($fp, $description);
	fclose($fp);
}

//
// Legge da file le informazioni riguardanti il file specificato in upload
//
function get_file_description($filename, $max_caracters = 0, $replacecharacters = 1)
{
	if (!file_exists("$filename.desc"))
		return array('','','');

	if ($max_caracters == 0)
		$max_caracters = filesize("$filename.desc");

	$fp = @fopen("$filename.desc",'r');

	$upl_user = rtrim(fgets($fp, 255));
	$upl_ip = rtrim(fgets($fp, 255));
	$activated = rtrim(fgets($fp,255));

	$contents = fread ($fp, $max_caracters);
	fclose($fp);
	if ($replacecharacters)
	{
		$contents = str_replace('&',    '&amp;',  $contents);
		$contents = str_replace('<',    '&lt;',   $contents);
		$contents = str_replace('>',    '&gt;',   $contents);
		$contents = str_replace('\"',   '&quot;', $contents);
		$contents = str_replace('\x0D', '',       $contents);
		$contents = str_replace('\x0A', ' ',      $contents);
		$contents = str_replace('_',    ' ',      $contents);
	}

	return array($upl_user, $upl_ip, $activated, $contents);
}

//
// Stampa l'intestazione della pagina, incluso il file 'header.htm' configurabile
// dall'amministratore nel pannello di configurazione
//
function page_header($title)
{
echo <<<END
  <html>
  <head>
  	<title>$title</title>
	<link rel="stylesheet" href="styles.css" type="text/css">
	<style type="text/css"></style>
  </head>
  <body bgcolor="#efefe7" background="images/horse_bg.gif" color="#000000" link="#000000" vlink="#000000">
  <table bgcolor="#ffffff" width="730px" align="center" border="0" cellpadding="8px" cellspacing="0">
  <tr><td align="center" width="100%">
END;
}

//
// Stampa titolo prinicpale del sito, nome sezione
// barra di stato e icone strumenti utente
//
function place_message($title, $message, $link)
{
	global $phpExt;
	global $mess, $font, $normalfontcolor, $selectedfontcolor, $homeurl;
	global $uploadcentercaption, $logged_user_name, $user_status, $page_title;
	global $tablecolor, $bordercolor, $headercolor, $headerfontcolor;

	// Controllo se l'utente è loggato o meno
	if ($logged_user_name == '' || !check_is_user_session_active($logged_user_name))
	{
		$logged_user_name = '';
		$user_status = ANONYMOUS;
	}

	page_header($page_title);

	echo "
	  <table class=\"tb_top\">
	    <tr><th>
	        <table width=\"100%\" border=0><tr>
	        <td align=\"left\" valign=\"middle\" width=64>
	        	<a href=\"http://www.freebasic.net/\"><img src=\"images\logo.gif\" border=0></a>
	        </td>
	        <td align=\"left\" valign=\"middle\"><font class=\"font_big\">FreeBASIC Files Repository</font></td>
	        </tr></table>
	    </th></tr>
	  </table>

	  <table class=\"tb_bar\">
	    <tr>
	      <td align=\"left\" valign=\"middle\">
	        <table border=\"0\" width=\"100%\">
	          <tr>
	            <td align=\"right\" valign=\"middle\" width=\"100%\">
	              <a href=\"$homeurl\"><img src=\"images/home.gif\"  align=\"ABSMIDDLE\" alt=\"$mess[25]\" border=\"0\" /></a>&nbsp;
	              <a href=\"$link?".SID."\"><img src=\"images/refresh.gif\"  align=\"ABSMIDDLE\" alt=\"$mess[97]\" border=\"0\" /></a>&nbsp;";
	if ($user_status == ADMIN)
	{
		echo "    <a href=\"configure.".$phpExt."?".SID."\"><img src=\"images/config.gif\"  align=\"ABSMIDDLE\" alt=\"$mess[132]\" border=\"0\" /></a>&nbsp;
				  <a href=\"usrmanag.".$phpExt."?".SID."\"><img src=\"images/users.gif\"  align=\"ABSMIDDLE\" alt=\"$mess[137]\" border=\"0\" /></a>&nbsp;";
	}
	if ($user_status != ANONYMOUS)
	{
		echo "    <a href=\"login.".$phpExt."?".SID."\"><img src=\"images/user.gif\"  align=\"ABSMIDDLE\" alt=\"$mess[81]\" border=\"0\" /></a>&nbsp;";
	}
	echo "       </td>
	             <td align=\"right\" valign=\"middle\" width=\"10%\">";

	// Show login/logout message
	if ($user_status == ANONYMOUS)
	{
		echo "<a href=\"login.".$phpExt."?".SID."\">".$mess[71]."</a>";
	}
	else
	{
		echo "<a href=\"login.${phpExt}?".SID."&action=logout\">".$mess[72]."</a>";
	}

	echo '
	            </td>
	          </tr>
	        </table>
	      </td>
	   </tr>
	</table>
	<br>
	';
}

function load_user_profile($username)
{
  global $users_folder_name, $enc_user_pass, $enc_logged_user_id, $user_email;
  global $user_status, $activationcode, $user_temp_info, $user_wish_receive_digest;
  global $default_user_status,$user_account_creation_time, $language, $dft_language;

  $enc_user_pass = '';
  $enc_logged_user_id = 0;
  $user_email = '';
  $user_status = ANONYMOUS;
  $activationcode = USER_DISABLED;
  $user_temp_info = '';
  $user_wish_receive_digest = 0;
  $user_account_creation_time = 0;
  $language = $dft_language;

  $userfilename = "$users_folder_name/$username";
  if (!file_exists($userfilename))
  {
    return;
  }

  $fp=@fopen($userfilename,"r");
  if($fp)
  {
    if(!feof($fp))
      $enc_user_pass=rtrim(fgets($fp, 255));
    if(!feof($fp))
      $enc_logged_user_id=rtrim(fgets($fp, 255));
    if(!feof($fp))
      $user_email=rtrim(fgets($fp, 255));
    if(!feof($fp))
      $user_status=rtrim(fgets($fp, 255));
    if(!feof($fp))
      $activationcode=rtrim(fgets($fp, 255));
    if(!feof($fp))
      $user_temp_info=rtrim(fgets($fp, 255));
    if(!feof($fp))
      $user_wish_receive_digest=rtrim(fgets($fp, 255));
    if(!feof($fp))
      $user_account_creation_time=rtrim(fgets($fp, 255));
    if(!feof($fp))
      $language=rtrim(fgets($fp, 255));
  }

  fclose($fp);

  if ($language == '')
  	$language = $dft_language;
}


function save_user_profile($username)
{
  global $users_folder_name, $enc_user_pass, $enc_logged_user_id, $user_email;
  global $user_status, $activationcode, $user_temp_info, $user_wish_receive_digest;
  global $user_account_creation_time, $language;

  $userfilename = "$users_folder_name/$username";
  $fp = fopen($userfilename, "w+"); // File named as User Name
  fwrite($fp, $enc_user_pass);      // 1st line: Encrypted user password
  fwrite($fp, "\n");
  fwrite($fp, $enc_logged_user_id); // 2nd line: Encrypted user session ID, 0 - if user logged out
  fwrite($fp, "\n");
  fwrite($fp, $user_email);         // 3rd line: User E-Mail address
  fwrite($fp, "\n");
  fwrite($fp, $user_status);    // 4 line: account status: 0 - Administrator, 1 - Power User, 2 - Normal User, 3 - Viewer (view only), 4 - Uploader (upload only)
  fwrite($fp, "\n");
  fwrite($fp, $activationcode); // 5 line: 1 - if account active, 0 - if disabled, other value - activation code
  fwrite($fp, "\n");
  fwrite($fp, $user_temp_info); // 6 line: any temporary information
  fwrite($fp, "\n");
  fwrite($fp, $user_wish_receive_digest);  // 7 line: User wish to receive files digest via e-mail
  fwrite($fp, "\n");
  fwrite($fp, $user_account_creation_time);  // 8 line: The time when user account created
  fwrite($fp, "\n");
  fwrite($fp, $language);  // 9 line: Lingua selezionata
  fwrite($fp, "\n");
  fclose($fp);
}

function check_is_user_session_active($username)
{
  global $logged_user_id, $enc_logged_user_id;

  // Check user session id
  load_user_profile($username);
  if (!empty($enc_logged_user_id) && (md5($logged_user_id) == $enc_logged_user_id))
  	return true;

  return false;
}

function check_user_password($username, $password)
{
  global $users_folder_name,$enc_user_pass;
  // Check user session id
  $userfilename = "$users_folder_name/$username";
  load_user_profile($username);
  return (md5($password) == $enc_user_pass);
}

function change_skin()
{
  global $HTTP_GET_VARS, $skinindex, $skins, $bordercolor, $headercolor, $tablecolor;
  global $lightcolor, $headerfontcolor, $normalfontcolor, $selectedfontcolor;
  global $cookiepath, $cookiedomain, $cookievalidity;

  $skinindex=$HTTP_GET_VARS["skinindex"];
  if ($skinindex > count($skins))
    $skinindex = 0;
  setcookie("skinindex",$skinindex,time() + $cookievalidity * 3600);
  $bordercolor=$skins[$skinindex]["bordercolor"];
  $headercolor = $skins[$skinindex]["headercolor"];
  $tablecolor=$skins[$skinindex]["tablecolor"];
  $lightcolor=$skins[$skinindex]["lightcolor"];
  $headerfontcolor=$skins[$skinindex]["headerfontcolor"];
  $normalfontcolor=$skins[$skinindex]["normalfontcolor"];
  $selectedfontcolor=$skins[$skinindex]["selectedfontcolor"];
}

function generate_password()
{
  // Generate new password
  $consonants="BCDFGHJKLMNPQRSTWXVZ";
  $vowels="AEIOUY";
  mt_srand((double)microtime()*1000000);
  $leng=mt_rand(3,5);
  $newpass="";
  for ($i = 0; $i < $leng; $i++)
  {
    mt_srand((double)microtime()*1000000);
    $newpass.=$consonants[mt_rand(0,19)].$vowels[mt_rand(0,5)];
  }
  return $newpass;
}

function userslist($order = "name")
{
  global $users_folder_name, $user_account_creation_time, $user_status, $activationcode;
  global $user_wish_receive_digest, $user_email, $reserved_files;

  $userslist = "";
  // Browse each user
  $handle=opendir($users_folder_name);
  while (false !== ($filename = readdir($handle)))
  {
    if (substr($filename,0,1) != '.' && !eregi($reserved_files, $filename))
    {
      if (!is_dir("$users_folder_name/$filename"))
      {
        if ($order == "name")
          $userslist[$filename] = $filename;
        else
        {
          if (($order == "uploaded") || ($order == "downloaded") || ($order == "emailed") || ($order == "access"))
          {
            list($files_uploaded, $files_downloaded, $files_emailed, $last_acess_time) = load_userstat($filename);
            if ($order == "uploaded")
              $userslist[$filename] = $files_uploaded;
            if ($order == "downloaded")
              $userslist[$filename] = $files_downloaded;
            if ($order == "emailed")
              $userslist[$filename] = $files_emailed;
            if ($order == "access")
              $userslist[$filename] = $last_acess_time;
          }
          else
          {
            load_user_profile($filename);
            if ($order == "date")
              $userslist[$filename] = $user_account_creation_time;
            if ($order == "status")
              $userslist[$filename] = $user_status;
            if ($order == "activestatus")
              $userslist[$filename] = $activationcode;
            if ($order == "receivedigest")
              $userslist[$filename] = $user_wish_receive_digest;
            if ($order == "email")
              $userslist[$filename] = $user_email;
          }
        }
      }
    }
  }
  closedir($handle);
  if (($order == "uploaded") || ($order == "downloaded") || ($order == "emailed"))
    arsort($userslist);
  else
    asort($userslist);
  return $userslist;
}

function load_userstat($username)
{
  global $userstat_folder_name;
  $files_uploaded = 0;
  $files_downloaded = 0;
  $files_emailed = 0;
  $last_acess_time = 0;

  $userfilename = "$userstat_folder_name/$username.stat";
  if (file_exists($userfilename))
  {
    $fp=@fopen($userfilename,"r");
    if($fp)
    {
      if(!feof($fp))
        $files_uploaded=rtrim(fgets($fp, 255));
      if(!feof($fp))
        $files_downloaded=rtrim(fgets($fp, 255));
      if(!feof($fp))
        $files_emailed=rtrim(fgets($fp, 255));
      if(!feof($fp))
        $last_acess_time=rtrim(fgets($fp, 255));
    }
    fclose($fp);
  }
  return array($files_uploaded, $files_downloaded, $files_emailed, $last_acess_time);
}

function save_userstat($username, $files_uploaded, $files_downloaded, $files_emailed, $last_acess_time)
{
  global $userstat_folder_name;

  $userfilename = "$userstat_folder_name/$username.stat";
  $fp=fopen($userfilename,"w+");
  if($fp)
  {
    fwrite($fp, $files_uploaded);
    fwrite($fp, "\n");
    fwrite($fp, $files_downloaded);
    fwrite($fp, "\n");
    fwrite($fp, $files_emailed);
    fwrite($fp, "\n");
    fwrite($fp, $last_acess_time);
    fwrite($fp, "\n");
  }
  fclose($fp);
}

class MIME_MAIL {
  var $attachments = array();
  var $from = "";
  var $subject = "";
  var $body = "";
  var $charset = "";

  function MIME_MAIL($from = "", $subject = "", $body = "", $charset = "")
  {
    $this->from = $from;
    $this->subject = $subject;
    $this->body = $body;
    $this->charset = $charset;
  }

  function attachment($name = "", $contents = "",
                      $type = "application/octet-stream", $encoding = "base64")
  {
    $this->attachments[] = array("filename" => $name,
                                 "type" => $type,
                                 "encoding" => $encoding,
                                 "data" => $contents);
  }


  function _build()
  {
    mt_srand((double)microtime()*1000000);
    $boundary = '--b'.md5(uniqid(mt_rand())) . getmypid();

    if ($this->from != "")
      $ret = "From: " . $this->from . "\n";
    else
      $ret = "";

    $ret .= "MIME-Version: 1.0\n";
    $ret .= "Content-Type: multipart/mixed; ";
    $ret .= "boundary=\"$boundary\"\n\n";


    $ret .= "This is a MIME encoded message. \n\n";
    $ret .= "--$boundary\n";

    $ret .= "Content-Type: text/plain";
    if ($this->charset != "")
      $ret .= "; charset=$this->charset";

    $ret .= "\n";
    $ret .= "Content-Transfer-Encoding: 8bit\n\n";
    $ret .= $this->body . "\n--$boundary";

    foreach($this->attachments as $attachment)
    {
      $attachment["data"] = base64_encode($attachment["data"]);
      $attachment["data"] = chunk_split($attachment["data"]);
      $data =
        "Content-Type: $attachment[type]";
        if ($attachment["filename"] != "")
          $data .= "; name = \"$attachment[filename]\"";
        else
          $data .= "";
        $data .= "\n" .
        "Content-Transfer-Encoding: $attachment[encoding]" .
        "\n\n$attachment[data]\n";
      $ret .= "\n$data\n--$boundary";
    }
    $ret .= "--\n";
    return($ret);
  }

  function send($to)
  {
  	global $use_smtp, $phpExt;

  	if (!$use_smtp)
	{
		$result = @mail($to, $this->subject, ' ', $this->_build());
	}
	else
	{
		if (!defined('SMTP_INCLUDED'))
		{
			include('include/smtp.'.$phpExt);
		}
		$result = smtpmail($to, $this->subject, ' ', $this->_build());
	}

	return $result;

  }


  function add_html($html_message)
  {
    $this->attachment("", $html_message, "text/html");
  }


function add_file($filename)
{	
	global $encrypt_filecontent;
	
	if (!file_exists($filename))
      return;
	
	if ($encrypt_filecontent)
		$file_content = decrypt_file($filename, false);
	else {
	    $fp=@fopen($filename,"rb");
	    $file_content = fread($fp, filesize($filename));
	    fclose($fp);		
	}
	
    $this->attachment(basename($filename), $file_content, mime_type($filename));
  }

} // Enc of class MIME_MAIL

//
// Dato un percorso in input, lo spezza creando la barra di naviagazione
//
function split_dir($directory)
{
	global $uploads_folder_name, $direction, $order, $phpExt;

	$directory = clean_path($directory);
	if (!file_exists("$uploads_folder_name/$directory"))
	{
		$directory = '';
	}

	$arr = explode("/", $directory);

	$address = '';
	$nav="<a href=\"index.${phpExt}?direction=$direction&order=$order&".SID."\">Home</a>";
	foreach ($arr as $value)
	{
		if ($address == '')
			$address.="$value";
		else
			$address.="/$value";
		$nav.=" / <a href=\"index.${phpExt}?direction=$direction&order=$order&directory=$address&".SID."\">$value</a>";
	}

	return($nav);
}

function show_footer_page()
{
	global $footerpage, $include_location, $cfg_folder_name;

echo <<<END
	<br />
	<div align="center">
	<a href="http://phpatm.free.fr" target=_blank><span class="copy_text">Powered by PHP Advanced Transfer Manager - @2002-2005 Andrea Bugada</span></a>
	<br>

	<br />
	<br />
	<br />
	<a href="http://sourceforge.net"><img src="http://sourceforge.net/sflogo.php?group_id=122342&amp;type=1" width="88" height="31" border="0"/></a>
	<a href="http://www.phatcode.net/"><img src="images/phatcode-logo.gif" border=0></a>
	<p class="copy_text"><img src="images/logo-mini.gif" border=0><br>Copyright &copy; 2004-2006 Andre Victor <small>(av1ctor[@]yahoo.com.br)</small><br/><br/></p>
	</div>

	</td></tr></table>
	</body></html>
END;
}

//
// Entra nella directory languages e ritorna l'array delle lingue trovate
//
function available_languages($folder)
{
	$languages = array();
	$handle = opendir($folder);
	while (false !== ($filename = readdir($handle)))
	{
		if (eregi('\.lang$', $filename))
		{
			$fp = @fopen("$folder/$filename", "r");
	  		if ($fp)
	  		{
	    		if (!feof($fp))
	      			$lang_id = rtrim(fgets($fp, 255));
	    		if (!feof($fp))
	      			$lang_name = rtrim(fgets($fp, 255));
	    		if (!feof($fp))
	      			$lang_time = rtrim(fgets($fp, 255));
			}
			fclose($fp);
			$languages[$lang_id]['LangName'] = $lang_name;
			$languages[$lang_id]['TimeZone'] = $lang_time;
		}
	}
	closedir($handle);
	asort($languages);
	return $languages;
}

function is_ip_blocked($user_ip)
{
	global $ip_black_list;

	if (is_array($ip_black_list))
	{
		reset($ip_black_list);
		while (list(, $value) = each($ip_black_list))
		{
			if (ereg($value, $user_ip))
			{
				return true;
			}
		}
	}
	return false;
}

function getGetVar($var_name) {
	global $major, $release;
	
	if ($major > 4 || ($major == 4 && $release > 0))
		return $_GET[$var_name];
	else
		return $HTTP_GET_VARS[$var_name];	
}

function getPostVar($var_name) {
	global $major, $release;
	
	if ($major > 4 || ($major == 4 && $release > 0))
		return $_POST[$var_name];
	else
		return $HTTP_POST_VARS[$var_name];	
}

function getSessionVar($var_name) {
	global $major, $release;
	
	if ($major > 4 || ($major == 4 && $release > 0))
		return $_SESSION[$var_name];
	else
		return $HTTP_SESSION_VARS[$var_name];	
}

function getFilesVar($var_name) {
	global $major, $release;
	
	if ($major > 4 || ($major == 4 && $release > 0))
		return $_FILES[$var_name];
	else
		return $HTTP_FILES_VARS[$var_name];	
}

function decrypt_file($filename, $on_stdout) {
	global $include_location, $encryption_key, $phpExt;
	
	$handle = fopen($filename, "rb");
	$contents = "";
	do {
	    $data = fread($handle, 8192);
	    if (strlen($data) == 0) {
	        break;
	    }
	    
		require_once($include_location.'include/encdec.'.$phpExt);
		$data = decrypt($data, $encryption_key);			
	    
		if ($on_stdout)
			echo $data;
		else
			$contents .= $data;
	} while (true);
	
	fclose($handle);	
	return $contents;
}

function encrypt_file($filename) {
	global $include_location, $encryption_key, $phpExt;
	
	$handle = fopen($filename, "rb");
	$contents = "";
	do {
	    $data = fread($handle, 8192);
	    if (strlen($data) == 0) {
	        break;
	    }
	    
		require_once($include_location.'include/encdec.'.$phpExt);
		$data = encrypt($data, $encryption_key);				    
		$contents .= $data;
	} while (true);		
	fclose($handle);
	
	$handle = fopen($filename, "wb");
	fwrite($handle, $contents);
	fclose($handle);
}

function encrypt_filename($filename) {
	global $include_location, $encryption_key, $phpExt;
	
	require_once($include_location.'include/encdec.'.$phpExt);				    
	return base64_encode($filename);
	return$filename;
}
?>
