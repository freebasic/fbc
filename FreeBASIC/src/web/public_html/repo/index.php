<?php
/***************************************************************************
 *                                 index.php
 *                            -------------------
 *   begin                : Tuesday', Aug 15', 2002
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
include('include/conf.php');
include('include/common.php');

//
// Stampa la parte superiore dell'upload, comprensiva di titolo principale,
// titolo sezione, status bar e icone controlli utenti
//
function place_header($message)
{
	global $mess, $infopage, $font, $normalfontcolor, $selectedfontcolor, $homeurl;
	global $languages,$allow_choose_language;
	global $page_title,$uploadcentercaption,$uploadcentermessage;
	global $tablecolor,$bordercolor,$headercolor,$headerfontcolor;
	global $logged_user_name,$user_status, $include_location;

	place_message('', $message, basename(__FILE__));

	// Place info table if present
	$infopage_path = $include_location.$cfg_folder_name.'/'.$infopage;
	if ((file_exists($infopage_path)) && (filesize($infopage_path) != 0))
	{
echo <<<END
		<table class="tb_dir_list">
		<tr>
		  <td align="left" bgcolor="$headercolor" valign="middle">
		    <font size="2" face="$font">
		    <font color="$headerfontcolor"><b>$mess[51]</b> </font></font></td>
		</tr>
		<tr>
		  <td align="left" bgcolor="$tablecolor" valign="middle">
		    <font size="1" color="$normalfontcolor" face="$font">"
END;

		include($infopage_path);

		echo "</font></td></tr></table>";
		echo "<br>";
	}
}

//
// Ritorna la data in formato unix tenendo conto del fuso orario
//
function unix_time()
{
	global $timeoffset;
	$tmp = time() + 3600 * $timeoffset;
	return $tmp;
}

//
// Ritorna la data di un file tenendo conto del fuso orario impostato
//
function file_time($filename)
{
	global $timeoffset;
	$tmp = filemtime($filename) + 3600 * $timeoffset;
	return $tmp;
}

//
// Cancella un file e i suoi relativi file accessori (download counter e descrizione)
//
function delete_file($filename)
{
	if (file_exists($filename))
		unlink($filename);

	if (file_exists("$filename.desc"))
		unlink("$filename.desc");

	if (file_exists("$filename.dlcnt"))
		unlink("$filename.dlcnt");
}

//
// Ricerca ricorsivamente i file contenuti nella directory indicata ed
// in ogni subdirectory in essa contenuta
//
function scan_dir_for_digest($current_dir, &$message)
{
	global $timeoffset, $comment_max_caracters, $datetimeformat, $uploads_folder_name;
	global $hidden_dirs, $showhidden, $validation_enabled, $user_status, $grants;

	$currentdate = getdate();
	$time1 = mktime(0, 0, 0, $currentdate['mon'], $currentdate['mday']-1, $currentdate['year']);
	$time2 = $time1 + 86400;

	// Leggo la lista dei file uploadati nella directory
	list($liste, $totalsize) = listing($current_dir);

	$filecount = 0;
	if (is_array($liste))
	{
		while (list($filename, $mime) = each($liste))
		{
			if(is_dir("$current_dir/$filename"))
			{
		        // Non mostro le dir nascoste
		      	if (eregi($hidden_dirs, $filename) && !$showhidden)
		      	{
		      		continue;
		      	}

				$filecount += scan_dir_for_digest("$current_dir/$filename", $message);
				continue;
			}

			$file_modif_time = filemtime("$current_dir/$filename");
			// check if file uploaded in previous date
			if (($file_modif_time < $time1) || ($file_modif_time >= $time2))
				continue;

		    $filecount++;

			// Leggo la descrizione
			list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description("$current_dir/$filename", $comment_max_caracters);

			// Se il file non è validato non lo mostro
			if ($validation_enabled && $filestatus != VALIDATED)
			{
			   continue;
			}

			$message.="
			    <tr valign=\"top\">
			        <td align=\"left\" width=\"45%\">
			          <font size=3>$filename</font><BR>
			          <font size=2>$contents</font>
			        </td>
			        <td align=\"left\" width=\"30%\" valign=\"middle\">
			        	Home".ereg_replace($uploads_folder_name, '', $current_dir)."
			        </td>
			        <td align=\"right\"  nowrap valign=\"middle\">\n";
			$message.= get_filesize("$current_dir/$filename");
			$message.= "</td>
			 		<td align=\"left\"  nowrap valign=\"middle\">\n";
			$message.=date($datetimeformat, $file_modif_time - $timeoffset * 3600);
			$message.= "</td>
					<td align=\"left\"  valign=\"middle\">\n";

			if ($upl_user != "")
			$message.= "<b>$upl_user</b><br>";

			$message.= "
					</td>
				</tr>\n";
		}
	}

	return $filecount;
}

//
// Spedisce il resoconto giornaliero agli utenti che ne hanno fatto richiesta ed elimina
// eventuali utenti registrati da più di due giorni ma non confermati.
//
function send_digest_and_maintenance_accounts()
{
	global $uploads_folder_name, $users_folder_name, $user_wish_receive_digest, $admin_email, $use_smtp;
	global $mess, $timeoffset, $installurl, $mailinfopage, $digest_email_subject, $admin_name;
	global $mail_functions_enabled, $user_email, $activationcode, $mess, $user_account_creation_time;
	global $reserved_files, $include_location, $phpExt;

	if ($mail_functions_enabled)
	{
		$message = '';
		$mailinfo_path = $include_location.$cfg_folder_name.'/'.$mailinfopage;
		if (file_exists($mailinfo_path))
		{
			$max_caracters = filesize($mailinfo_path);
			$fp = @fopen($mailinfo_path, 'r');
			$message = fread($fp, $max_caracters);
			fclose($fp);
		}
		$message.="<html><body bgcolor=\"#FFFFFF\" text=\"#000000\">\n<table border=\"1\">\n";

		$filecount = scan_dir_for_digest($uploads_folder_name, $message);

		$message.= "</table><br>\n";
		$message.= "<br>\nWeb Page: $installurl\n";
		$message.= "</body></html>";
	}
	$time = time();

	// Controllo lo stato di ogni utente
	$handle = opendir($users_folder_name);
	while (false !== ($filename = readdir($handle)))
	{
		if (substr($filename, 0, 1) != '.' && !eregi($reserved_files, $filename))
		{
			if (!is_dir("$users_folder_name/$filename"))
			{
				load_user_profile($filename);

				// Elimino gli utenti registrati ma non confermati entro il termine previsto
				if (($activationcode != USER_ACTIVE) && ($activationcode != USER_DISABLED) && (floor($time - $user_account_creation_time)/86400 >= 2)) // 2 days
					delete_file("$users_folder_name/$filename");  // Delete unactivated account

				// Spedisco a chi lo ha richiesto il resoconto nuovi files uploadati
				if ($mail_functions_enabled && $user_wish_receive_digest && ($activationcode = USER_ACTIVE) && ($filecount > 0))
				{
					$body=$message;
					$from="$admin_name <$admin_email>";
					$headers="Content-Type: text/html; charset=iso-8859-1\n";
					$headers.="From: $from\nX-Mailer: System33r";

					if (!$use_smtp)
					{
						$result = @mail($user_email, $digest_email_subject, $body, $headers);
					}
					else
					{
						if (!defined('SMTP_INCLUDED'))
						{
							include($include_location.'include/smtp.'.$phpExt);
						}
						$result = smtpmail($user_email, $digest_email_subject, $body, $headers);
					}
				}
			}
		}
	}
	closedir($handle);
}

//
// Controlla quando è stato fatto l'ultima manutenzione e, se necessario, ne esegue una nuova
//
function do_maintenance()
{
	global $uploads_folder_name, $maintenance_time;
	$time = 0;

	// Leggo la data in cui è stato fatta l'ultima manutenzione
	if (file_exists("$uploads_folder_name/$$$.dlcnt"))
	{
		$fp = fopen("$uploads_folder_name/$$$.dlcnt", 'r');
		$time = fread($fp, 100);
		fclose($fp);
	}

	// Se è passato più di un giorno allora lancio la manutenzione
	if (floor((time() - $time)/86400) >= 1)
	{
		// Calcolo la nuova data
		$time = time();
		$currentdate = getdate($time);
		$time = mktime($maintenance_time, 0, 0, $currentdate['mon'], $currentdate['mday'], $currentdate['year']);

		// Scrivo la nuova data (se non riesco a scrivere non mando neppure la mail)
		$fp = @fopen("$uploads_folder_name/$$$.dlcnt", 'w+');
		if ($fp)
		{
			fwrite($fp, $time, 100);
			fclose($fp);
			send_digest_and_maintenance_accounts();
		}
	}
}

function increasebytecount($filename)
{
	if ($filename != '.' && $filename != '..')
        {
		$size = filesize($filename);

		// Increase the month count - RACE CONDITION HERE
		$monthsize = get_monthload();
		write_monthload($size+$monthsize);


		// Increase day count -- RACE CONDITION HERE
		$daysize = get_dayload();
		write_dayload($size+$daysize);
	}
}
//
// Incrementa il contatore di download, quando un file viene scaricato
//
function increasefiledownloadcount($filename)
{
	if ($filename != '.' && $filename != '..')
	{
		$count = count_file_download($filename);
		$count++;      							// number of downloads + 1
		$fp = fopen("$filename.dlcnt",'w+'); 	// write counter file
		@flock($fp, LOCK_EX);    				// Lock file in exclusive mode
		fwrite($fp, $count, 15); 				// write back
		@flock($fp, LOCK_UN);    				// Reset locking
		fclose($fp);
	}
}

//
// Esegue alcune operazioni preliminari prima di leggere
// il contenuto di una directory
//
function init($directory)
{
	global $uploads_folder_name, $direction, $mess, $font, $normalfontcolor, $phpExt;

	$direction = ($direction == DIRECTION_UP) ? DIRECTION_DOWN : DIRECTION_UP;

	$current_dir = $uploads_folder_name;
	if ($directory != '')
		$current_dir = "$current_dir/$directory";

	if (!is_dir($uploads_folder_name))
	{
		echo "<font face=\"$font\" size=\"2\">$mess[196]<br><br>
			  <a href=\"index.$phpExt?".SID."\">$mess[29]</a></font>\n";
		exit;
	}

	if (!is_dir($current_dir))
	{
		echo "<font face=\"$font\" color=\"$normalfontcolor\" size=\"2\">$mess[30]<br><br>
			  <a href=\"javascript:window.history.back()\">$mess[29]</a></font>\n";
		exit;
	}

	return $current_dir;
}

//
// Dati l'array dei file nella directory e l'array delle directory
// li unisce in un array unico
//
function assemble_tables($tab1, $tab2)
{
	global $direction;

	$liste = '';

	if (is_array($tab1))
	{
		while (list($cle, $val) = each($tab1))
			$liste[$cle] = $val;
	}

	if (is_array($tab2))
	{
		while (list($cle, $val) = each($tab2))
			$liste[$cle] = $val;
	}

	return $liste;
}



//
// Data una directory ritorna un array contente tutti i file e le directory
// presenti in tale directory secondo criteri ben precisi (ordine, file accettati, etc.)
//
function listing($current_dir)
{
	global $direction, $order, $reserved_files;

	$totalsize = 0;
	$handle = opendir($current_dir);
	$list_dir = '';
	$list_file = '';
	while (false !== ($filename = readdir($handle)))
    {
	    if ($filename != '.' && $filename != '..'
	    	&& !eregi($reserved_files, $filename)
	    	&& show_hidden_files($filename))
		{
			$filesize=filesize("$current_dir/$filename");
			$totalsize += $filesize;
			if (is_dir("$current_dir/$filename"))
			{
				if($order == 'mod')
					$list_dir[$filename] = filemtime("$current_dir/$filename");
				else
					$list_dir[$filename] = $filename;
            }
            else
            {
            	switch($order)
            	{
					case 'taille';
						$list_file[$filename] = $filesize;
						break;
					case 'mod';
						$list_file[$filename] = filemtime("$current_dir/$filename");
						break;
					case 'rating';
						$list_file[$filename] = count_file_download("$current_dir/$filename");
						break;
					default;
						$list_file[$filename] = get_mimetype_img("$current_dir/$filename");
						break;
				}
			}
		}
	}
    closedir($handle);

	if(is_array($list_file))
	{
       	switch($order)
    	{
			case 'taille':
			case 'rating':
				$direction == DIRECTION_DOWN ? asort($list_file) : arsort($list_file);
				break;
			case 'mod':
				$direction == DIRECTION_DOWN ? arsort($list_file) : asort($list_file);
				break;
			default:
				$direction == DIRECTION_DOWN ? ksort($list_file) : krsort($list_file);
				break;
		}
	}

	if(is_array($list_dir))
	{
		if ($order == "mod")
		{
			$direction == DIRECTION_UP ? arsort($list_dir) : asort($list_dir);
		}
		else
		{
			$direction == DIRECTION_UP ? krsort($list_dir) : ksort($list_dir);
		}
	}

	$liste = assemble_tables($list_dir, $list_file);

	if ($totalsize >= 1073741824)
		$totalsize = round($totalsize / 1073741824 * 100) / 100 . " Gb";
	elseif ($totalsize >= 1048576)
		$totalsize = round($totalsize / 1048576 * 100) / 100 . " Mb";
	elseif ($totalsize >= 1024)
		$totalsize = round($totalsize / 1024 * 100) / 100 . " Kb";
	else
		$totalsize = $totalsize . " b";

    return array($liste, $totalsize);
}

//
// Stampa la tabella contente i file e le directory trovate nella directory passata
//
function contents_dir($current_dir, $directory)
{
  global $font,$direction,$order,$totalsize,$mess,$tablecolor,$lightcolor;
  global $file_out_max_caracters,$normalfontcolor, $phpExt, $hidden_dirs, $showhidden;
  global $comment_max_caracters,$datetimeformat, $logged_user_name, $validation_enabled;
  global $user_status,$activationcode,$max_filesize_to_mail,$mail_functions_enabled, $timeoffset, $grants;

  // Read directory
  list($liste, $totalsize) = listing($current_dir);

  if(is_array($liste))
  {
    while (list($filename,$mime) = each($liste))
    {

	  $is_dir = is_dir("$current_dir/$filename");
	  $filesize = filesize("$current_dir/$filename");
	  $filemtime = filemtime("$current_dir/$filename");

      if ($is_dir)
      {

        // Non mostro le dir nascoste
      	if (eregi($hidden_dirs, $filename) && !$showhidden)
      	{
      		continue;
      	}

        $filenameandpath = "index.$phpExt?".SID."&direction=$direction&order=$order&directory=";

        if ($directory != '')
        	$filenameandpath .= "$directory/";

        $filenameandpath .= $filename;
      }
      else
      {
        $filenameandpath = '';
        if ($directory != '')
        {
        	$filenameandpath .= "$directory/";
        }

        $filenameandpath .= $filename;

      }

	 // Controllo la validazione del file. Se è una directory non richiede validazione (per ora).
	 if ($is_dir)
	 {
		$filestatus = VALIDATED;
	 }
	 else
	 {
     	list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description("$current_dir/$filename", $comment_max_caracters);
	 }

     if (!$validation_enabled ||
     	 $filestatus == VALIDATED ||
     	 ($upl_user == $logged_user_name) ||
	 	 ($filestatus == UNVALIDATED && $grants[$user_status][VALIDATE]))
     {
echo "
    <tr class=\"tb_dir_list_tr\">
      <td align=\"right\" width=\"95%\">
        <div align=\"left\">
        <table border=0>
       	  <tr>
	        <td>
    		  <img src=\"images/".get_mimetype_img("$current_dir/$filename")."\"align=\"ABSMIDDLE\" border=\"0\">\n
        	</td>
    		<td>
		        <font face=\"$font\" size=\"2\" color=\"$normalfontcolor\">";
		          if ($is_dir)
		          {
		          	echo "<a href=\"$filenameandpath\">";
		          }
		          else
		          {
		          	if (is_viewable($filename))
		            	{echo "<a href=\"javascript:popup('$filename', '$directory')\">";}
		          }
		echo      substr($filename,0,$file_out_max_caracters);
		          if(is_viewable($filename))
		            {echo "</a>\n";}

		// Load description
		list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description("$current_dir/$filename", $comment_max_caracters);

		echo "     <font face=\"$font\" size=\"1\" color=\"$normalfontcolor\">
				 	 <BR>$contents
				   </font>";
		echo "   </font></div>
			</td>
		  </tr>
		</table>
      </td>
      <td align=\"right\" width=\"95%\" valign=\"middle\" nowrap>
        <div align=\"left\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">";


// Se il file non è attivato mostro l'icona per l'attivazione
if ($validation_enabled && $grants[$user_status][VALIDATE])
{
	if ($filestatus == UNVALIDATED)
	{
		echo "&nbsp;
		      <a href=\"index.${phpExt}?action=validatefile&filename=$filename&directory=$directory&".SID."\">
		        <img src=\"images/validate.gif\" width=\"20\" height=\"20\" border=\"0\" alt=\"$mess[214]\"></a>";
	}
	else
	{
		echo "<img src=\"images/empty.gif\" width=\"20\" height=\"20\" border=\"0\">&nbsp;";
	}
}

// Se proprietario o abilitato, aggiungo link cancellazione file
if ($grants[$user_status][DELALL] || ($upl_user == $logged_user_name && $grants[$user_status][DELOWN]))
{
	if (!$is_dir)
	{
		echo "&nbsp;
			 <a href=\"javascript:delobj('deletefile', '$filename', '$directory');\">
		        <img src=\"images/delete.gif\" width=\"20\" height=\"20\" border=\"0\" alt=\"$mess[169]\"></a>";
    }
    else
    {
    	if ($grants[$user_status][DELALL])
    	{
		    echo "&nbsp;
		      <a href=\"javascript:delobj('deletedir', '$filename', '$directory');\">
		        <img src=\"images/delete.gif\" width=\"20\" height=\"20\" border=\"0\" alt=\"$mess[169]\"></a>";
		}
    }
}
else
{
	echo "&nbsp; <img src=\"images/empty.gif\" width=\"20\" height=\"20\" border=\"0\">";
}

//
// Se proprietario o abilitato aggiungo link modifica file
//
if ($grants[$user_status][MODALL] || ($upl_user == $logged_user_name && $grants[$user_status][MODOWN]))
{
	if (!$is_dir || $grants[$user_status][MODALL])
	{
		echo "<a href=\"fileop.${phpExt}?action=rename&filename=$filename&directory=$directory&order=$order&direction=$direction&".SID."\">
		<img src=\"images/rename.gif\" border=\"0\" alt=\"$mess[191]\"></a>";
    }
}
else
{
	echo "<img src=\"images/empty.gif\" width=\"20\" height=\"20\" border=\"0\">&nbsp;";
}


//
// Show mail file link
//
if (($grants[$user_status][MAIL] || $grants[$user_status][MAILALL]) && $mail_functions_enabled)
{
  if (($grants[$user_status][MAILALL] || ($filesize < $max_filesize_to_mail * 1024)) && (!$is_dir))
  {
echo "        <a href=\"javascript:popupmail('$filename', '$directory')\">
             <img src=\"images/mail.gif\"
             alt=\"$mess[68]\" width=\"20\" height=\"20\" border=\"0\"></a>";
  }
  else
	echo " <img src=\"images/empty.gif\" width=\"20\" height=\"20\" border=\"0\"> ";
}
else
{
	echo " <img src=\"images/empty.gif\" width=\"20\" height=\"20\" border=\"0\">";
}

//
// Mostro l'icona per il download
//
if ($grants[$user_status][DOWNLOAD] && !$is_dir)
{
echo "        <a href=\"index.${phpExt}?action=downloadfile&filename=$filename&directory=$directory&".SID."\">
             <img src=\"images/download.gif\"
             alt=\"$mess[23]\" width=\"20\" height=\"20\" border=\"0\"></a>";
echo       count_file_download("$current_dir/$filename");
}
else
	echo " <img src=\"images/empty.gif\" width=\"20\" height=\"20\" border=\"0\">";

echo "    </font></div>
      </td>
      <td align=\"right\" width=\"95%\" valign=\"middle\" nowrap>
        <div align=\"right\"><font size=\"1\" color=\"$normalfontcolor\" face=\"$font\">\n";

if ($is_dir)
	echo "directory";
else
	echo      format_filesize($filesize);


echo "    </font></div>
      </td>
      <td align=\"right\" width=\"95%\" valign=\"middle\" nowrap>
        <div align=\"left\"><font size=\"1\" color=\"$normalfontcolor\" face=\"$font\">\n";
$file_modif_time = $filemtime - $timeoffset * 3600;
echo      date($datetimeformat, $file_modif_time);

echo "  </font></div>
      </td>
      <td align=\"right\" width=\"95%\" valign=\"middle\">
        <div align=\"left\">
          <p><font size=\"1\" color=\"$normalfontcolor\" face=\"$font\">\n";

        if ($user_status == ADMIN) // If admin, show IP
          if ($upl_user != "")
            echo    "<b>$upl_user</b> - <b>$upl_ip</b><br>";
          else
            echo    "<b>$upl_ip</b><br>";
        else
        {
          if ($upl_user != "")
            echo    "<b>$upl_user</b><br>";
        }
echo "    </font></p>
        </div>
      </td>
    </tr>\n";
    }
    }  // list iterator
  }
}

//
// Crea la tabella con elencati i files e le directory
//
function list_dir($directory)
{
	global $mess,$direction,$uploads_folder_name;
	global $font,$order,$totalsize,$tablecolor,$headercolor,$bordercolor;
	global $headerfontcolor, $normalfontcolor, $phpExt;

	// Elimino eventuali '..' e '.'
	$directory = clean_path($directory);
	$current_dir = init($directory);
	$filenameandpath = ($directory != '') ? "&directory=".$directory : '';

	echo "<script language=\"javascript\">\n";
	echo "function popup(file, dir) {\n";
	echo "file=escape(file);dir=escape(dir); \n";
	echo "var fen=window.open('index.${phpExt}?action=view&filename='+file+'&directory='+dir+'&".SID."','filemanager','status=yes,scrollbars=yes,resizable=yes,width=500,height=400');\n";
	echo "}\n";

	echo "function delobj(action, file, dir) {\n";
	echo "   if (confirm('$mess[216] '+file+'?')) {\n";
	echo "      document.location = 'index.${phpExt}?action='+action+'&filename='+file+'&directory='+dir+'&".SID."'\n";
	echo "   }\n";
	echo "}\n";

	echo "function popupmail(file, dir) {\n";
	echo "var fen=window.open('index.${phpExt}?action=mailfile&filename='+file+'&directory='+dir+'&".SID."','filemanager','status=yes,scrollbars=yes,resizable=yes,width=500,height=400');\n";
	echo "}\n";
	echo "</script>\n";

	echo "
	  <table class=\"tb_dir_list\">
	    <tr>
	      <th align=\"right\" valign=\"middle\" width=\"95%\">
	        <div align=\"left\"><font color=\"$headerfontcolor\"><b><font face=\"$font\" size=\"2\">$mess[15]</font>
	          <a href=\"index.${phpExt}?order=nom&direction=$direction".$filenameandpath."&".SID."\">\n";
	          if ($order=="nom"||$order=="")
	            {echo "<img src=\"images/fleche${direction}.gif\" alt=\"$mess[197]\" width=\"10\" height=\"10\" border=\"0\"></a>\n";}
	          else
	            {echo "<img src=\"images/fleche.gif\" alt=\"$mess[197]\" width=\"10\" height=\"10\" border=\"0\"></a>\n";}
	echo "    </b></font></div>
	      </th>
	      <th align=\"right\" valign=\"middle\" width=\"95%\" nowrap>
	        <div align=\"left\"><font color=\"$headerfontcolor\"><b><font face=\"$font\" size=\"2\">$mess[16]</font><font color=\"$headerfontcolor\"><b>
	          <a href=\"index.${phpExt}?order=rating&direction=$direction".$filenameandpath."&".SID."\">\n";
	          if ($order=="rating")
	            {echo "<img src=\"images/fleche${direction}.gif\" alt=\"$mess[197]\" width=\"10\" height=\"10\" border=\"0\"></a>\n";}
	          else
	            {echo "<img src=\"images/fleche.gif\" alt=\"$mess[197]\" width=\"10\" height=\"10\" border=\"0\"></a>\n";}
	echo "    </b></font></b></font></div>
	      </th>
	      <th align=\"right\" valign=\"middle\" width=\"95%\" nowrap>
	        <div align=\"left\"><font color=\"$headerfontcolor\"><b><font face=\"$font\" size=\"2\">$mess[17]</font>
	          <a href=\"index.${phpExt}?order=taille&direction=$direction".$filenameandpath."&".SID."\">\n";
	          if ($order=="taille")
	            {echo "<img src=\"images/fleche${direction}.gif\" alt=\"$mess[197]\" width=\"10\" height=\"10\" border=\"0\"></a>\n";}
	          else
	            {echo "<img src=\"images/fleche.gif\" alt=\"$mess[197]\" width=\"10\" height=\"10\" border=\"0\"></a>\n";}
	echo "    </b></font></div>
	      </th>
	      <th align=\"right\" valign=\"middle\" width=\"95%\" nowrap>
	        <div align=\"left\"><font color=\"$headerfontcolor\"><b><font face=\"$font\" size=\"2\">$mess[18]</font>
	          <a href=\"index.${phpExt}?order=mod&direction=$direction".$filenameandpath."&".SID."\">\n";
	          if ($order=="mod")
	            {echo "<img src=\"images/fleche${direction}.gif\" alt=\"$mess[197]\" width=\"10\" height=\"10\" border=\"0\"></a>\n";}
	          else
	            {echo "<img src=\"images/fleche.gif\" alt=\"$mess[197]\" width=\"10\" height=\"10\" border=\"0\"></a>\n";}
	echo "    </b></font></div>
	      </th>
	      <th align=\"right\" valign=\"middle\" width=\"95%\">
	        <div align=\"left\"><font color=\"$headerfontcolor\"><b><font face=\"$font,\" size=\"2\">$mess[19]</font></b></font></div>
	      </th>
	    </tr>\n";

	    $direction = ($direction == DIRECTION_DOWN) ? DIRECTION_UP : DIRECTION_DOWN;
        contents_dir($current_dir, $directory);
echo "
    <tr bgcolor=\"$tablecolor\" valign=\"top\">
      <td align=\"right\" colspan=\"5\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">
        <b>$mess[43]</b>: $totalsize</font></td>
    </tr>
  </table>
	<br>
  <table class=\"tb_dir_list\">
    <tr>
      <td align=\"center\" bgColor=\"$tablecolor\">
      	<font size=\"2\" face=\"$font\" color=\"$normalfontcolor\">
      		[<a href=\"showrecent.$phpExt?".SID."\">$mess[199]</a>]
      		-
      		[<a href=\"showtophits.$phpExt?".SID."\">$mess[200]</a>]
	  	</font>
	  </td>
    </tr>
  </table>";
}

//
// Cancella una directory. Se non è vuota ne cancella ricorsivamente tutto
// il contenuto prima di cancellare la directory stessa.
//
function delete_dir($location)
{
	if(is_dir($location))
	{
		$all = opendir($location);
		while (false !== ($file = readdir($all)))
		{
			if (is_dir("$location/$file") && $file != '..' && $file != '.')
			{
				delete_dir("$location/$file");
			}
			elseif (is_file("$location/$file"))
			{
				unlink("$location/$file");
			}
			unset($file);
		}
		closedir($all);
		rmdir($location);
	}
	else
	{
		if (file_exists($location))
		{
			unlink($location);
		}
	}
}

//
// Elimina tutti i caratteri potenzialmente pericolosi (definiti in include/conf.php)
// e taglia la stringa sino al numero massimo di caratteri consentiti
//
function normalize_filename($name)
{
	global $file_name_max_caracters, $invalidchars;

	$name = stripslashes($name);

	reset($invalidchars);
	while (list($key, $value) = each($invalidchars))
	{
		$name = str_replace($value, '', $name);
	}

	$name = substr($name, 0, $file_name_max_caracters);
	return $name;
}

//
// Stampa la pagina intera
//
function show_contents()
{
global $current_dir,$directory,$uploads_folder_name,$mess,$direction,$timeoffset;
global $order,$totalsize,$font,$tablecolor,$bordercolor,$headercolor;
global $headerfontcolor,$normalfontcolor,$user_status, $grants, $phpExt;

echo "<center>\n";

// Non mostro la barra di navigazione se la directory passata non esiste

$directory = clean_path($directory);
if (!file_exists("$uploads_folder_name/$directory"))
{
	$directory = '';
}

// Mostro la barra di navigazione
if ($directory != '')
{

    $name = dirname($directory);
    if ($directory == $name || $name == '.')
    	$name = '';

	echo "  <table class=\"tb_dir_list\">\n";
	echo "    <tr>\n";
	echo "       <td align=\"left\" bgcolor=\"$tablecolor\" valign=\"middle\">\n";
	echo "			<table border = \"0\">\n";
	echo "    			<tr>\n";
	echo "       			<td align=\"left\" bgcolor=\"$tablecolor\" valign=\"middle\">\n";
    echo "     	 				<a href=\"index.${phpExt}?direction=$direction&order=$order&directory=$name&".SID."\">";
    echo "		 					<img src=\"images/parent.gif\" width=\"20\" height=\"20\" align=\"absmiddle\" border=\"0\">\n";
    echo "          			</a>\n";
	echo "       			</td>\n";
	echo "       			<td align=\"left\" bgcolor=\"$tablecolor\" valign=\"middle\" width=\"100%\">\n";
	echo split_dir("$directory");
	echo "       			</td>\n";
	echo "    			</tr>\n";
	echo "    		</table>\n";
	echo "       </td>\n";
	echo "    </tr>\n";
	echo "    </table>\n";
	echo "    <BR>\n";
}


if ($grants[$user_status][VIEW])
{
  list_dir($directory);
}

if ($grants[$user_status][UPLOAD])
{
  echo "  <br>";
  echo "  <table class=\"tb_dir_list\">\n";
  echo "    <tr>\n";
  echo "      <th align=\"left\" bgcolor=\"$headercolor\" valign=\"middle\"><font size=\"2\" face=\"$font\" color=\"$headerfontcolor\">$mess[20]</font></th>\n";
  echo "    </tr>\n";
  echo "    <tr>\n";
  echo "        <td align=\"left\" bgcolor=\"$tablecolor\" valign=\"middle\">\n";
  echo "        <form name=\"upload\" action=\"index.$phpExt?".SID."\" enctype=\"multipart/form-data\" method=\"post\" style=\"margin: 0\">\n";
  echo "          <input type=\"hidden\" name=\"action\" value=\"upload\">\n";
  echo "          <input type=\"hidden\" name=\"directory\" value=\"$directory\">\n";
  echo "          <input type=\"hidden\" name=\"order\" value=\"$order\">\n";
  echo "          <input type=\"hidden\" name=\"direction\" value=\"$direction\">\n";
  echo "          <table border=\"0\" width=\"100%\" cellpadding=\"4\">\n";
  echo "            <tr>\n";
  echo "              <td align=\"left\" width=\"15%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[21]</font></td>\n";
  echo "              <td align=\"left\" width=\"90%\" colspan=\"2\">\n";
  echo "                <input type=\"file\" class=\"vform\" name=\"userfile\" size=\"50\" />\n";
  echo "              </td>\n";
  echo "            </tr>\n";
  echo "            <tr> \n";
  echo "              <td align=\"left\" width=\"15%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[22]</font></td>\n";
  echo "              <td align=\"left\" width=\"70%\">\n";
  echo "                <input type=\"text\" name=\"description\" class=\"vform\" size=62>\n";
  echo "              </td>\n";
  echo "              <td align=\"right\" width=\"15%\">\n";
  echo "                <input type=\"submit\" class=\"vform\" value=\"$mess[20]\" />\n";
  echo "              </td>\n";
  echo "            </tr>\n";
  echo "          </table>\n";
  echo "        </form>\n";

  echo "        </td>\n";
  echo "    </tr>\n";
  echo "    </table>\n";
}

// Se l'utente è abilitato mostro il comando di copia via http
if ($grants[$user_status][WEBCOPY])
{
  echo "   <BR>\n";
  echo "  <table class=\"tb_dir_list\">\n";
  echo "    <tr>\n";
  echo "      <th>$mess[204]</th>\n";
  echo "    </tr>\n";
  echo "    <tr>\n";
  echo "        <td align=\"left\" bgcolor=\"$tablecolor\" valign=\"middle\">\n";
  echo "        <form name=\"webcpy\" action=\"index.$phpExt?".SID."\" method=\"post\" style=\"margin: 0\">\n";
  echo "          <input type=\"hidden\" name=\"action\" value=\"webcopy\">\n";
  echo "          <input type=\"hidden\" name=\"directory\" value=\"$directory\">\n";
  echo "          <input type=\"hidden\" name=\"order\" value=\"$order\">\n";
  echo "          <input type=\"hidden\" name=\"direction\" value=\"$direction\">\n";
  echo "          <table border=\"0\" width=\"100%\" cellpadding=\"4\">\n";
  echo "            <tr> \n";
  echo "              <td align=\"left\" width=\"15%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[203]</font></td>\n";
  echo "              <td align=\"left\" width=\"70%\">\n";
  echo "				<input type=\"text\" name=\"fileurl\" class=\"vform\" size=62 value=\"http://\">\n";
  echo "              </td>\n";
  echo "            </tr>\n";
  echo "            <tr> \n";
  echo "              <td align=\"left\" width=\"15%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[192]</font></td>\n";
  echo "              <td align=\"left\" width=\"70%\">\n";
  echo "				<input type=\"text\" name=\"filename\" class=\"vform\" size=62>\n";
  echo "              </td>\n";
  echo "            </tr>\n";
  echo "            <tr>\n";
  echo "              <td align=\"left\" width=\"15%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[22]</font></td>\n";
  echo "              <td align=\"left\" width=\"70%\">\n";
  echo "                <input type=\"text\" name=\"description\" class=\"vform\" size=62>\n";
  echo "              </td>\n";
  echo "              <td align=\"right\" width=\"15%\">\n";
  echo "                <input type=\"submit\" class=\"vform\" value=\"$mess[20]\" />\n";
  echo "              </td>\n";
  echo "            </tr>\n";
  echo "          </table>\n";
  echo "        </form>\n";
  echo "        </td>\n";
  echo "    </tr>\n";
  echo "    </table>\n";
}

// Se l'utente è abilitato mostro il comando creazione nuova directory remota
if ($grants[$user_status][MKDIR])
{
  echo "   <BR>\n";
  echo "  <table class=\"tb_dir_list\">\n";
  echo "    <tr>\n";
  echo "      <th>$mess[186]</th>\n";
  echo "    </tr>\n";
  echo "    <tr>\n";
  echo "        <td align=\"left\" bgcolor=\"$tablecolor\" valign=\"middle\">\n";
  echo "        <form name=\"newdir\" action=\"index.$phpExt?".SID."\" method=\"post\" style=\"margin: 0\">\n";
  echo "          <input type=\"hidden\" name=\"action\" value=\"createdir\">\n";
  echo "          <input type=\"hidden\" name=\"directory\" value=\"$directory\">\n";
  echo "          <input type=\"hidden\" name=\"order\" value=\"$order\">\n";
  echo "          <input type=\"hidden\" name=\"direction\" value=\"$direction\">\n";
  echo "          <table border=\"0\" width=\"100%\" cellpadding=\"4\">\n";
  echo "            <tr> \n";
  echo "              <td align=\"left\" width=\"15%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[187]</font></td>\n";
  echo "              <td align=\"left\" width=\"70%\">\n";
  echo "                <input type=\"text\" name=\"filename\" class=\"vform\" size=62>\n";
  echo "              </td>\n";
  echo "              <td align=\"right\" width=\"15%\">\n";
  echo "                <input type=\"submit\" class=\"vform\" value=\"$mess[188]\" />\n";
  echo "              </td>\n";
  echo "            </tr>\n";
  echo "          </table>\n";
  echo "        </form>\n";
  echo "        </td>\n";
  echo "    </tr>\n";
  echo "    </table>\n";
}


echo "</center>\n";
}

//
// Controlla, espandendo i percorsi, che il file risieda all'interno del ramo di upload
// Questo previene tentativi per visualizzare dei file in directory superiori (/users ad esempio)
// Inoltre controlla che il file non sia speciale (.htaccess, .desc, .dlcnt, index.html, etc.)
//
function is_path_safe(&$path, &$filename)
{
	global $uploads_folder_name, $reserved_files;

	$path = clean_path($path);
	$filename = clean_path($filename);



	if (!file_exists("$uploads_folder_name/$path")
		|| eregi($reserved_files, $filename)
		|| !show_hidden_files($filename)
	   )
	{
		return false;
	}

	return true;
}

//----------------------------------------------------------------------------
//      MAIN
//----------------------------------------------------------------------------

// Controllo se è ora di fare manutenzione
do_maintenance();

$userfile = getFilesVar('userfile');
$description = getPostVar('description');
$fileurl = getPostVar('fileurl');
$filename = getPostVar('filename');
$directory = getPostVar('directory');
$order = getPostVar('order');
$direction = getPostVar('direction');


switch($action)
{
	case 'deletefile';
		$filename = getGetVar('filename');
		$directory = getGetVar('directory');

		// Entro nella directory corretta
		$current_dir = $uploads_folder_name;
		if ($directory != '')
			$current_dir.="/$directory";

		// Mi assicuro di avere solo il nome del file
		$filename = basename($filename);

		// Mi assicuro che il file esista
		if (!file_exists("$current_dir/$filename"))
		{
			place_header($mess[125]);
			show_Contents();
			break;
		}

		// Controllo che il file risieda all'interno del ramo di upload
		if (is_path_safe($directory, $filename))
	    {
			// Carico la descrizione, l'ip e il proprietario del file
			list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description("$current_dir/$filename", $comment_max_caracters);

			// Controllo che il file sia validato
			if ($validation_enabled && $filestatus == UNVALIDATED && !$grants[$user_status][VALIDATE])
			{
				place_header($mess[180]);
			}
			else
			{
				// Cancello solo se l'utente è amministratore/superutente o il proprietario del file
				if ($grants[$user_status][DELALL] || ($upl_user == $logged_user_name && $grants[$user_status][DELOWN]))
				{
					delete_file("$current_dir/$filename");
					place_header($mess[180]);
				}
				else
				{
					place_header($mess[181]);
				}
			}
		}
		else
		{
			place_header($mess[181]);
		}

		// Aggiorno il contenuto dell'upload
		show_contents();
		break;

	case 'validatefile';

		$filename = getGetVar('filename');
		$directory = getGetVar('directory');

		// Entro nella directory corretta
		$current_dir = $uploads_folder_name;
			$current_dir.="/$directory";

		// Mi assicuro di avere solo il nome del file
		$filename = basename($filename);

		// Mi assicuro che il file esista
		if (!file_exists("$current_dir/$filename"))
		{
			place_header($mess[125]);
			show_contents();
			break;
		}

		// Valido solo se l'utente è abilitato a farlo
		if (!$grants[$user_status][VALIDATE])
		{
			place_header($mess[217]);
			break;
		}

		// Valido il file
		list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description("$current_dir/$filename", $comment_max_caracters);
		save_file_description("$current_dir/$filename".".desc", $contents, VALIDATED, $upl_user, $upl_ip);

		place_header($mess[215]);
		show_contents();
		break;

	case 'deletedir';

		$filename = getGetVar('filename');
		$directory = getGetVar('directory');

		// Entro nella directory corretta
		$current_dir = $uploads_folder_name;
		if ($directory != '')
			$current_dir.="/$directory";

		// Mi assicuro di avere solo l'ultima parte del nonme
		$filename = basename($filename);

		// Mi assicuro che la directory esista
		if (!file_exists("$current_dir/$filename"))
		{
			place_header($mess[125]);
			show_contents();
			break;
		}

		// Controllo che la directory da cancellare risieda all'interno del ramo di upload
		if (is_path_safe($directory, $filename))
	    {
			// Cancello solo se l'utente è abilitato
			if ($grants[$user_status][DELALL])
			{
				delete_dir("$current_dir/$filename");
				place_header($mess[182]);
			}
			else
			{
				place_header($mess[183]);
			}
		}
		else
		{
			place_header($mess[183]);
		}

		// Aggiorno il contenuto dell'upload
		show_contents();
		break;

	case 'createdir';

		$current_dir = $uploads_folder_name;
		if ($directory != '')
			$current_dir.="/$directory";

		// Mi assicuro di avere solo il nome del file
		$filename = basename($filename);

		// Controllo che il nome della directory sia accettabile
      	if (eregi($hidden_dirs, $filename) && !$showhidden)
      	{
      		place_header($mess[206]);
      		show_contents();
			break;
      	}

		// Controllo che la directory da creare risieda all'interno del ramo di upload
		if (is_path_safe($directory, $filename))
		{
			// Normalizzo il nome della directory
			$filename = normalize_filename($filename);

			// Controllo che sia stato specificato un nome per la directory
			if ($filename != '')
			{
				// Creo solo se l'utente è abilitato
				if ($grants[$user_status][MKDIR])
				{
					// Controllo che il file non esista
					if (!file_exists("$current_dir/$filename"))
					{
						// Creo la directory e ci copio index.html e .htaccess (per ragioni di sicurezza)
						mkdir("$current_dir/$filename", 0755);
						copy('include/index.html', "$current_dir/$filename/index.html");
						//copy('include/.htaccess', "$current_dir/$filename/.htaccess");
						place_header($mess[184]);
					}
					else
					{
						place_header($mess[189]);
					}
				}
				else
				{
					place_header($mess[185]);
				}
			}
			else
			{
				place_header($mess[190]);
			}
		}
		else
		{
			place_header($mess[185]);
		}

		// Aggiorno il contenuto dell'upload
		show_contents();
		break;

	case 'selectskin';
		setcookie("skinindex", $skinindex, time() + $cookievalidity * 3600);
		$bordercolor = $skins[$skinindex]['bordercolor'];
		$headercolor = $skins[$skinindex]['headercolor'];
		$tablecolor = $skins[$skinindex]['tablecolor'];
		$lightcolor = $skins[$skinindex]['lightcolor'];
		$headerfontcolor = $skins[$skinindex]['headerfontcolor'];
		$normalfontcolor = $skins[$skinindex]['normalfontcolor'];
		$selectedfontcolor = $skins[$skinindex]['selectedfontcolor'];
		place_header($mess[96]);
		show_contents();
		break;

	case 'downloadfile';

		$filename = getGetVar('filename');
		$directory = getGetVar('directory');

		// Entro nella directory corretta
		$current_dir = $uploads_folder_name;
		if ($directory != '')
			$current_dir.="/$directory";

		// Mi assicuro di avere solo il nome del file
		$filename = basename($filename);

		// Controllo l'utente sia abilitato al download
		if (!$grants[$user_status][DOWNLOAD])
		{
			place_header($mess[111]);
			show_Contents();
			break;
		}

		// Mi assicuro che il file esista
		if (!file_exists("$current_dir/$filename"))
		{
			place_header($mess[125]);
			show_Contents();
			break;
		}

		// Controllo che il file da scaricare risieda nel ramo di upload
		if (!is_path_safe($directory, $filename))
		{
			place_header($mess[111]);
			show_Contents();
			break;
		}

		// Controllo che il file sia validato
		list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description("$current_dir/$filename", $comment_max_caracters);
		if ($validation_enabled && $filestatus == UNVALIDATED && !$grants[$user_status][VALIDATE])
		{
			place_header($mess[111]);
			show_Contents();
			break;
		}


		// Controllo che non sia stato superato il limite giornaliero di download
		$size = filesize("$current_dir/$filename");
		$daily_size = get_daydownload();
		if (($max_daily_download_mb > 0) && (($size + $daily_size) > ($max_daily_download_mb * 1024 * 1024)))
		{
			place_header($mess[212]);
			show_Contents();
			break;
		}

		// Controllo che non sia stato superato il limite mensile di download
		$monthly_size = get_monthdownload();
		if (($max_monthly_download_mb > 0) && (($size+$monthly_size) > ($max_monthly_download_mb * 1024 * 1024)))
		{
			place_header($mess[213]);
			show_Contents();
			break;
		}
		increasefiledownloadcount("$current_dir/$filename");

		if (($user_status != ANONYMOUS) && ($logged_user_name != ''))  // Update user statistics
		{
		  list($files_uploaded, $files_downloaded, $files_emailed) = load_userstat($logged_user_name);
		  $files_downloaded++;
		  save_userstat($logged_user_name, $files_uploaded, $files_downloaded, $files_emailed, time());
		}

		//Forzo il salvataggio con un determinato nome
		header("Content-Type: application/force-download; name=\"$filename\"");
		header("Content-Transfer-Encoding: binary");
		header("Content-Length: $size");
		header("Content-Disposition: attachment; filename=\"$filename\"");
		header("Expires: 0");
		header("Cache-Control: no-cache, must-revalidate");
		header("Pragma: no-cache");

		// Decrypt file if encryption enabled
		if ($encrypt_filecontent) {
			decrypt_file("$current_dir/$filename", true);
		}
		else {
			readfile("$current_dir/$filename");
		}
		exit;
		break;

	case 'view';

		$filename = getGetVar('filename');
		$directory = getGetVar('directory');

		// Entro nella directory corretta
		$current_dir = $uploads_folder_name;
		if ($directory != '')
			$current_dir.="/$directory";

		$filename = basename($filename);

		// Controllo che l'utente abbia i permessi visualizzazione
		if (!$grants[$user_status][VIEW])
		{
			header("Status: 404 Not Found");
			exit;
		}

		// Controllo che il file risieda all'interno del ramo di upload e che il file esista
		if (!file_exists("$current_dir/$filename") || !is_path_safe($directory, $filename))
		{
			header("Status: 404 Not Found");
			exit;
		}

		// Controllo che il file sia validato
		list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description("$current_dir/$filename", $comment_max_caracters);
		if ($validation_enabled && $filestatus == UNVALIDATED && !$grants[$user_status][VALIDATE])
		{
			header("Status: 404 Not Found");
			exit;
		}

		echo "<html><head><title>$mess[219]</title></head>";
		echo "<frameset  rows=\"50,*,50\">\n";
		echo "    <frame name=\"viewer_top\" src=\"viewer_top.php?file=".$filename."&dir=".$directory."\" marginwidth=\"10\" marginheight=\"10\" scrolling=\"no\" frameborder=\"0\" noresize>\n";
		echo "    <frame name=\"viewer_content\" src=\"viewer_content.php?file=".$filename."&dir=".$directory."\" marginwidth=\"10\" marginheight=\"10\" scrolling=\"auto\" frameborder=\"0\">\n";
		echo "    <frame name=\"viewer_bottom\" src=\"viewer_bottom.php?file=".$filename."&dir=".$directory."\" marginwidth=\"10\" marginheight=\"10\" scrolling=\"no\" frameborder=\"0\" noresize>\n";
		echo "</frameset>\n";
		echo "</html>\n";
		exit();
		break;

	case 'mailfile';

		$filename = getGetVar('filename');
		$directory = getGetVar('directory');

		// Entro nella directory corretta
		$current_dir = $uploads_folder_name;
		if ($directory != '')
			$current_dir.="/$directory";

		$filename = basename($filename);

		// Controllo che l'utente abbia i permessi visualizzazione
		if (!$grants[$user_status][MAIL] && !$grants[$user_status][MAILALL])
		{
			header("Status: 404 Not Found");
			exit;
		}

		// Controllo che il file risieda all'interno del ramo di upload e che il file esista
		if (!is_path_safe($directory, $filename) || !file_exists("$current_dir/$filename"))
		{
			header("Status: 404 Not Found");
			exit;
		}

		// Controllo che il file sia validato
		list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description("$current_dir/$filename", $comment_max_caracters);
		if ($validation_enabled && $filestatus == UNVALIDATED && !$grants[$user_status][VALIDATE])
		{
			header("Status: 404 Not Found");
			exit;
		}

		page_header($mess[26].": ".$filename);

		echo "<center><font face=\"$font\" color=\"$normalfontcolor\" size=\"2\">$mess[26] : ";
		echo "<img src=\"images/".get_mimetype_img("$current_dir/$filename")."\" align=\"ABSMIDDLE\">\n";
		echo "<b>".$filename."</b></font><br><br><hr>\n";
		echo "<a href=\"javascript:window.close()\"><img src=\"images/back.gif\" alt=\"$mess[28]\" border=\"0\"></a>\n";
		echo "<br>\n";
		echo "<hr><br>";

		if (($user_status != ANONYMOUS) && ($activationcode == USER_ACTIVE))
		{
			if ($grants[$user_status][MAILALL] || ((filesize("$current_dir/$filename") < $max_filesize_to_mail * 1024) && $grants[$user_status][MAIL]))
			{
				$body = $sendfile_email_body;
				// Load file description
				list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description("$current_dir/$filename", 0, 0);

				if ($upl_user != '')
					$body .= sprintf($mess[70], $upl_user);
				$body .= "\n";
				if ($user_status == ADMIN) // If admin
					$body .= "IP: ".$upl_ip;
				$body .= "\n";
				$body .= $mess[92];
				$body .= get_filesize("$current_dir/$filename");
				$body .= "\n";
				$body .= $mess[90];
				$file_modif_time = file_time("$current_dir/$filename");
				$body .= date($datetimeformat, $file_modif_time);
				$body .= "\n\n";
				$body .= $mess[22].":\n";
				$body .= $contents;
				$body .= "\n
				$sendfile_email_end,
				$admin_name
				Email: mailto:$admin_email
				Web Page: $installurl";

				$mm = new MIME_MAIL("$admin_name <$admin_email>", $sendfile_email_subject, $body);
				$mm -> add_file("$current_dir/$filename");
				if ($mm -> send($user_email))
				{
					// Update statistics
					increasefiledownloadcount("$current_dir/$filename");
					if (($user_status != ANONYMOUS) && ($logged_user_name != ''))  // Update user statistics
					{
						list($files_uploaded, $files_downloaded, $files_emailed) = load_userstat($logged_user_name);
						$files_emailed++;
						save_userstat($logged_user_name, $files_uploaded, $files_downloaded, $files_emailed, time());
					}
					echo "<p><font face=\"$font\" size=\"3\" color=\"$normalfontcolor\">";
					echo sprintf($mess[69], "<b>".$user_email."</b>");
					echo "</font></p>";
				}
				else
				{
					echo "<p><font face=\"$font\" size=\"3\" color=\"$normalfontcolor\">";
					echo $mess[177]." ".$mess[179];
					echo "</font></p>";
				}
			}
		}

		echo "<hr>\n";
		echo "<a href=\"javascript:window.close()\"><img src=\"images/back.gif\" alt=\"$mess[28]\" border=\"0\"></a>\n";
		echo "<hr></center>\n";
		echo "</body>\n";
		echo "</html>\n";
		exit;
		break;


	case 'upload';
		$message = $mess[40];
		$userfile = $HTTP_POST_FILES['userfile'];
		$userfile_name = $userfile['name'];
		$userfile_size = $userfile['size'];
		$destination = $uploads_folder_name."/$directory";

		// Permetto l'upload solo se si hanno i privilegi necessari
		if (!$grants[$user_status][UPLOAD])
		{
			place_header(sprintf($mess[49], "<b>$userfile_name</b>"));
			show_contents();
			break;
		}

		// Non permetto l'upload di alcuni tipi di files nè al di fuori del ramo di upload
		if (!is_path_safe($directory, $userfile_name))
		{
			place_header(sprintf($mess[49], "<b>$userfile_name</b>"));
			show_contents();
			break;
		}

		// Controllo che sia stato scelto un file accettabile
		if ($userfile_name == '')
		{
			$message = $mess[34];
		}

		if ($userfile_size != 0)
		{
			$size_kb = $userfile_size/1024;
		}
		else
		{
			$message = $mess[34];
			$size_kb = 0;
		}

		// Get the daily amount of bytes written
		$day_size = get_dayload();

		// get the monthly amount of bytes written
		$month_size = get_monthload();

		if ($userfile_name != '' && $userfile_size !=0)
		{
			$userfile_name = normalize_filename($userfile_name);

			// Try if file exists Or file is script
			if (file_exists("$destination/$userfile_name") ||
			    preg_match($allowedfiles, $userfile_name) == 0 ||
			    ($size_kb > $max_allowed_filesize) ||
			    (($max_daily_mb > 0) && (($userfile_size+$day_size) > ($max_daily_mb*1024*1024))) ||
			    (($max_monthly_mb > 0) && (($userfile_size+$month_size) >($max_monthly_mb*1024*1024))))
			{
				if (($max_daily_mb > 0) && (($userfile_size+$day_size) > ($max_daily_mb*1024*1024)))
				{
					$message="$mess[210]";
				}
				else if (($max_monthly_mb > 0) && (($userfile_size+$month_size) >($max_monthly_mb*1024*1024)))
				{
					$message="$mess[211]";
				}
				else
				{
					if ($size_kb > $max_allowed_filesize)
						$message="$mess[38] <b>$userfile_name</b> $mess[50] ($max_allowed_filesize Kb)!";
					else
					{
						if (preg_match($allowedfiles, $userfile_name) == 0)  // If file is script
							$message=sprintf($mess[49], "<b>$userfile_name</b>");
						else
						{
							$message="$mess[38] <b>$userfile_name</b> $mess[39]";
						}
					}
				}
			}
			else
			{
				if (($user_status != ANONYMOUS) && ($logged_user_name != ''))  // Update user statistics
				{
					list($files_uploaded, $files_downloaded, $files_emailed) = load_userstat($logged_user_name);
					$files_uploaded++;
					save_userstat($logged_user_name, $files_uploaded, $files_downloaded, $files_emailed, time());
				}

				// Save description
				$ip = getenv('REMOTE_ADDR');
				$filestatus = ($validation_enabled) ? UNVALIDATED : VALIDATED;
				save_file_description("$destination/$userfile_name.desc", $description, $filestatus, $logged_user_name, $ip);

				if (!move_uploaded_file($userfile['tmp_name'], "$destination/$userfile_name"))
				{
					$message="$mess[33] $userfile_name";
				}
				else
				{
					if ($encrypt_filecontent) {
						encrypt_file("$destination/$userfile_name");
					}

					// Successful file upload.
					increasebytecount("$destination/$userfile_name");
					$message="$mess[36] <b>$userfile_name</b> $mess[37]";
					if ($filestatus == UNVALIDATED)
					{
						$message = $message.". ".$mess[218];
					}
				}
			}
		}
		place_header($message);
		show_contents();
		break;


	case 'webcopy';

		$message = $mess[40];

		$destination = $uploads_folder_name."/$directory";
		$filename = normalize_filename(basename($filename));

		// Permetto l'upload solo se si hanno i privilegi necessari
		if (!$grants[$user_status][WEBCOPY])
		{
			place_header(sprintf($mess[49], "<b>$filename</b>"));
			show_contents();
			break;
		}

		// Non permetto l'upload di alcuni tipi di files nè al di fuori del ramo di upload
		if (!is_path_safe($directory, $filename))
		{
			place_header(sprintf($mess[49], "<b>$filename</b>"));
			show_contents();
			break;
		}

		// Controllo che sia stato inserito un indirizzo http://
		if (!eregi("^http://|^ftp://", $fileurl))
		{
			place_header($mess[202]);
			show_contents();
			break;
		}

		// Controllo che sia stato scelto un file accettabile
		if ($filename == '')
		{
			place_header($mess[34]);
			show_contents();
			break;
		}

		// Controllo che il file esista
		if (file_exists("$destination/$filename"))
		{
			place_header("$mess[38] <b>$filename</b> $mess[39]");
			show_contents();
			break;

		}

		// Controllo che il fila sia uno script
		if (preg_match($allowedfiles, basename($filename)) == 0)
		{
			place_header(sprintf($mess[49], "<b>$filename</b>"));
			show_contents();
			break;
		}

		// Save description
		$ip = getenv('REMOTE_ADDR');
		$filestatus = $validation_enabled ? UNVALIDATED : VALIDATED;
		save_file_description("$destination/$filename.desc", $description, $filestatus, $logged_user_name, $ip);

		$fp = @fopen($fileurl, 'rb');
		if ($fp)
		{

			// Read remote file by packets. This should fix interrupted downloads
			$contents = "";
			do {
			    $data = fread($fp, 8192);
			    if (strlen($data) == 0) {
			        break;
			    }
			    $contents .= $data;
			} while (true);
			fclose($fp);

			if (strlen($contents <= ($max_allowed_filesize*1024)))
			{
				$tp = @fopen("$destination/$filename", 'wb');
				if ($tp)
				{
					// Scrivo il file

					if ($encrypt_filecontent) {
						require_once($include_location.'include/encdec.'.$phpExt);
						$contents = encrypt($contents, $encryption_key);
					}


					fwrite($tp, $contents);
					fclose($tp);
					$message = "$mess[36] <b>$filename</b> $mess[37]";
					if ($filestatus == UNVALIDATED)
					{
						$message = $message.". ".$mess[218];
					}

					// Aggiorno le statistiche utente
					if (($user_status != ANONYMOUS) && ($logged_user_name != ''))
					{
						list($files_uploaded, $files_downloaded, $files_emailed) = load_userstat($logged_user_name);
						$files_uploaded++;
						save_userstat($logged_user_name, $files_uploaded, $files_downloaded, $files_emailed, time());
					}
				}
				else
				{
					$message = "$mess[33] $filename";
				}
			}
			else
			{
				$message="$mess[38] <b>$filename</b> $mess[50]";
			}
		}
		else
		{
			$message = "$mess[33] $filename";
		}

		place_header($message);
		show_contents();
		break;


	case 'rename';

		$userfile = getPostVar('userfile');

		// Normalizzo il nome del file
		$userfile = normalize_filename($userfile);

		// Entro nella directory corretta
		$current_dir = $uploads_folder_name;
		if ($directory != '')
			$current_dir.="/$directory";

		// Controllo che il file da rinominare esista
		if (!file_exists("$current_dir/$filename"))
		{
			place_header($mess[125]);
			show_Contents();
			break;
		}

		// Controllo, se directory, che il nome sia accettabile
		if (is_dir("$current_dir/$filename"))
		{
	      	if (eregi($hidden_dirs, $userfile) && !$showhidden)
	      	{
	      		place_header($mess[206]);
	      		show_contents();
				break;
	      	}
      	}

		// Controllo che i parametri passati siano accettabili
		if (!is_path_safe($directory, $filename) || !is_path_safe($directory, $userfile))
		{
			place_header($mess[201]);
			show_contents();
			break;
		}

		// Carico la descrizione, l'ip e il proprietario del file
		list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description("$current_dir/$filename", $comment_max_caracters);

		// Controllo che il file sia validato
		if (!is_dir("$current_dir/$filename") && $validation_enabled && $filestatus == UNVALIDATED && !$grants[$user_status][VALIDATE])
		{
			place_header($mess[201]);
			show_contents();
			break;
		}

		// Se ho i privilegi necessari modifico il nome del file e la descrizione
		if ($grants[$user_status][MODALL] || ($upl_user == $logged_user_name && $grants[$user_status][MODOWN]))
		{
			// Controllo che il nuovo nome non sia fra quelli rejected
			if (preg_match($allowedfiles, $userfile) == 1)
			{
				// Controllo che il nome di destinazione non esista già
				if (!file_exists("$current_dir/$userfile") || $filename == $userfile)
				{
					// Se necessario rinomino il file e i file accessori (.desc e .dlcnt)
					if ($filename != $userfile)
					{
						if (file_exists("$current_dir/$filename"))
							rename("$current_dir/$filename", "$current_dir/$userfile");
						if (file_exists("$current_dir/$filename.dlcnt"))
							rename("$current_dir/$filename.dlcnt", "$current_dir/$userfile.dlcnt");
						if (file_exists("$current_dir/$filename.desc"))
							rename("$current_dir/$filename.desc", "$current_dir/$userfile.desc");
					}

					// Se necessario modifico la descrizione
					if (!is_dir("$current_dir/$userfile") && ($old_description != $new_description))
					{
						list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description("$current_dir/$userfile", 0, 0);
						save_file_description("$current_dir/$userfile.desc", $new_description, $filestatus, $upl_user, $upl_ip);
					}
					place_header($mess[194]); // rinomina ok
				}
				else
				{
					place_header($mess[198]); // nome file destinazione già esistente
				}
			}
			else
			{
				place_header($mess[201]); // nome file destinazione non consentito
			}
		}
		else
		{
			place_header($mess[195]); // impossibile rinominare, mancano i privilegi
		}

		show_Contents();
		break;

	default;
		$order = getGetVar('order');
		$direction = getGetVar('direction');
		$directory = getGetVar('directory');

		place_header($mess[42]);
		show_contents();
		break;
}

show_footer_page();
?>
