<?php
/***************************************************************************
 *                               showtophits.php
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

//
// Ricerca ricorsivamente i file contenuti nella directory indicata ed
// in ogni subdirectory in essa contenuta e ritorna un array contentente
// i dieci files più recentri trovati fino a quel momento
//
function find_files($current_dir, $lastfiles = array())
{
	global $max_topdownloaded_files, $hidden_dirs, $showhidden, $reserved_files;

	// Leggo il contenuto della directory passata come primo argomento
	$handle = opendir($current_dir);
	while (false !== ($filename = readdir($handle)))
    {
    	// Scarto i file da non visualizzare o non accettabili
	    if ($filename != '.' && $filename != '..'
	    	&& !eregi($reserved_files, $filename)
	    	&& show_hidden_files($filename))
		{
			// Se è una dir lancio ricursivamente la funzione
			if(is_dir("$current_dir/$filename"))
			{
		        // Non controllo le dir nascoste
		      	if (eregi($hidden_dirs, $filename) && !$showhidden)
		      	{
		      		continue;
		      	}

				$lastfiles = find_files("$current_dir/$filename", $lastfiles);
				continue;
			}

			// Inserisco il file trovato nell'array
			$hits = count_file_download("$current_dir/$filename");
			$lastfiles["$current_dir/$filename"] = $hits;
		}
	}
	closedir($handle);

	// Ordino l'array trovato in base alla data d'invio e
	// mantengo solo i primi '$max_topdownloaded_files' valori (definito in conf.php)
	arsort($lastfiles, SORT_NUMERIC);
	array_splice($lastfiles, $max_topdownloaded_files);

	return $lastfiles;
}

//
// Stampa l'intera pagina
//
function show_contents()
{
	global $mess, $grants, $user_status, $phpExt;
	global $font,$tablecolor,$headercolor,$bordercolor;
	global $headerfontcolor, $normalfontcolor;

	echo "<script language=\"javascript\">\n";
	echo "function popup(file, dir) {\n";
	echo "var fen=window.open('index.${phpExt}?action=view&filename='+file+'&directory='+dir+'&".SID."','filemanager','status=yes,scrollbars=yes,resizable=yes,width=500,height=400');\n";
	echo "}\n";
	echo "</script>\n";

	echo "
	  <BR>
	  <table class=\"tb_dir_list\">
	    <tr>";

    // Se abilitato mostro download
	if ($grants[$user_status][DOWNLOAD])
	{
		echo "
	      <th align=\"right\" valign=\"middle\">
	        <div align=\"left\"><font color=\"$headerfontcolor\"><b><font face=\"$font\" size=\"2\">$mess[23]</font></b></font></div>
	      </th>";
	}
		echo "
	      <th align=\"right\" valign=\"middle\" width=\"95%\">
	        <div align=\"left\"><font color=\"$headerfontcolor\"><b><font face=\"$font\" size=\"2\">$mess[15]</font></b></font></div>
	      </th>
	      <th align=\"right\" valign=\"middle\" width=\"95%\" nowrap>
	        <div align=\"left\"><font color=\"$headerfontcolor\"><b><font face=\"$font\" size=\"2\">$mess[48]</font><font color=\"$headerfontcolor\"><b></b></font></b></font></div>
	      </th>
	      <th align=\"right\" valign=\"middle\" width=\"95%\" nowrap>
	        <div align=\"left\"><font color=\"$headerfontcolor\"><b><font face=\"$font\" size=\"2\">$mess[17]</font></b></font></div>
	      </th>
	      <th align=\"right\" valign=\"middle\" width=\"95%\" nowrap>
	        <div align=\"left\"><font color=\"$headerfontcolor\"><b><font face=\"$font\" size=\"2\">$mess[18]</font></b></font></div>
	      </th>
	    </tr>\n";

        show_files();
echo "
  </table>
\n";
}

//
// Stampa l'elenco dei file ordinati in base al numero di download
//
function show_files()
{
  global $font,$mess,$tablecolor,$lightcolor, $grants, $phpExt;
  global $file_out_max_caracters,$normalfontcolor,$uploads_folder_name;
  global $comment_max_caracters,$datetimeformat, $logged_user_name;
  global $user_status,$activationcode,$max_filesize_to_mail;
  global $mail_functions_enabled, $timeoffset, $validation_enabled;

	$lastfiles = find_files($uploads_folder_name);
	while (list($filename, $filedate) = each($lastfiles))
	{
		$directory = ereg_replace($uploads_folder_name, '', dirname($filename));
		if (strchr($directory, '/') == 0)
			$directory = substr($directory, 1);


		// Load description
		list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description($filename, $comment_max_caracters);

		if (!$validation_enabled || $filestatus == VALIDATED ||
		($filestatus == UNVALIDATED && $grants[$user_status][VALIDATE])) {
		echo " <tr class=\"tb_dir_list_tr\">";

    // Se abilitato mostro download
	if ($grants[$user_status][DOWNLOAD])
	{
		echo "
	      <td align=\"center\" valign=\"middle\">
	      	<font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">
			<a href=\"index.${phpExt}?action=downloadfile&filename=".basename($filename)."&directory=$directory&".SID."\">
				<img src=\"images/download.gif\" alt=\"$mess[23]\" width=\"20\" height=\"20\" border=\"0\"></a>
			".count_file_download($filename)."
			</font>
	      </td>";
	}

	echo "
      <td align=\"right\" width=\"95%\">
        <div align=\"left\">
        <table border=0>
       	  <tr>
	        <td>
    		  <img src=\"images/".get_mimetype_img($filename)."\" align=\"ABSMIDDLE\" border=\"0\">\n
        	</td>
    		<td>
		        <font face=\"$font\" size=\"2\" color=\"$normalfontcolor\">";
	          	if (is_viewable($filename))
	            	{echo "<a href=\"javascript:popup('".basename($filename)."', '".$directory."')\">";}
		echo      substr(basename($filename),0,$file_out_max_caracters);
		          if(is_viewable($filename) || is_dir($filename))
		            {echo "</a>\n";}
		// Load description
		list($upl_user, $upl_ip, $filestatus, $contents) = get_file_description($filename, $comment_max_caracters);

		echo "     <font face=\"$font\" size=\"1\" color=\"$normalfontcolor\">
				 	 <BR>$contents
				   </font>";
		echo "   </font></div>
			</td>
		  </tr>
		</table>
      </td>
      <td valign=\"middle\">
      	<table border=0>
      		<tr>
	      	    <td>
	    		  <img src=\"images/dossier.gif\" align=\"ABSMIDDLE\" border=\"0\">\n
	        	</td>
		      <td align=\"right\" width=\"95%\" valign=\"middle\" nowrap>
		        <div align=\"left\"><font size=\"2\" face=\"$font\" color=\"$normalfontcolor\">
		        	<a href=\"index.${phpExt}?directory=$directory&".SID."\">
					Home/$directory
					</a>
			    </font></div>
		      </td>
 	     </tr>
      	</table>
      </td>
      <td align=\"right\" width=\"95%\" valign=\"middle\" nowrap>
        <div align=\"right\"><font size=\"1\" color=\"$normalfontcolor\" face=\"$font\">\n
			".get_filesize($filename)."
	  </font></div>
      </td>
      <td align=\"right\" width=\"95%\" valign=\"middle\" nowrap>
        <div align=\"left\"><font size=\"1\" color=\"$normalfontcolor\" face=\"$font\">\n";
$file_modif_time = filemtime($filename) - $timeoffset * 3600;
echo      date($datetimeformat, $file_modif_time);

echo "  </font></div>
      </td>
    </tr>\n";
    }
    }         // While loop
}

//----------------------------------------------------------------------------
//      MAIN
//----------------------------------------------------------------------------

// In caso non sia abilitata la visione anonima, reindirizzo a index.php
if (!$grants[$user_status][VIEW])
{
	header($header_location.'index.'.$phpExt.'?'.SID);
	exit;
}

place_message($mess[200], $mess[200], basename(__FILE__));
show_contents();

show_footer_page();
?>