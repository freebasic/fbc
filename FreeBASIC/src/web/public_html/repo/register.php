<?php
/***************************************************************************
 *                               register.php
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

function print_default()
{
global $mess, $font, $normalfontcolor, $selectedfontcolor, $homeurl, $languages;
global $uploadcentercaption,$require_email_confirmation, $mail_functions_enabled;
global $tablecolor,$bordercolor,$headercolor,$headerfontcolor,$allow_choose_language;
global $phpExt, $dft_language;

echo "
	<br>
   <table class=\"tb_dir_list\">
     <tr>
       <th align=\"left\" bgcolor=\"$headercolor\" valign=\"middle\"><font size=\"2\" face=\"$font\" color=\"$headerfontcolor\">$mess[99]</font></th>
     </tr>
     <tr>
         <td align=\"left\" bgcolor=\"$tablecolor\" valign=\"middle\">
         <form name=\"register\" action=\"register.$phpExt?".SID."\" method=\"post\" style=\"margin: 0\">
           <input type=\"hidden\" name=\"action\" value=\"".ACTION_REGISTER."\">
           <table border=\"0\" width=\"100%\" cellpadding=\"4\">
             <tr>
               <td align=\"left\" width=\"40%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[57]</font></td>
               <td align=\"left\" width=\"60%\" colspan=2>
                 <input type=\"text\" name=\"user_name\" class=\"vform\" size=25>
               </td>
             </tr>
             <tr>
               <td align=\"left\" width=\"40%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[83]</font></td>
               <td align=\"left\" width=\"60%\" colspan=2>
                 <input type=\"password\" name=\"user_pass\" class=\"vform\" size=25>
               </td>
             </tr>
             <tr>
             <tr>
               <td align=\"left\" width=\"40%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[105]</font></td>
               <td align=\"left\" width=\"60%\" colspan=2>
                 <input type=\"password\" name=\"user_pass1\" class=\"vform\" size=25>
               </td>
             </tr>
             <tr>
               <td align=\"left\" width=\"40%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[88]
";
if ($require_email_confirmation)
  echo " $mess[89]";
echo "
               </font></td>
               <td align=\"left\" width=\"60%\">
                 <input type=\"text\" name=\"typed_email\" class=\"vform\" size=25>
               </td>
             </tr>";

if ($allow_choose_language)
{
	echo "
             <tr>
               <td align=\"left\" width=\"30%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[84]</font></td>
               <td align=\"left\" width=\"70%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">
                 <select name=\"language\" class=\"vform\" size=\"1\">";

		while (list($langid, $langdata) = each($languages))
		{
			if ($langid == $dft_language)
		 		echo "<option value=\"$langid\" selected>".$langdata['LangName']."</option>";
			else
				echo "<option value=\"$langid\">".$langdata['LangName']."</option>";
		}


         echo "  </select>
               </font></td>
             </tr>";
}

if ($mail_functions_enabled)
{
	echo "
             <tr>
               <td align=\"left\" width=\"40%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[119]</font></td>
               <td align=\"left\" width=\"50%\">
                 <input type=\"checkbox\" name=\"digestcheckbox\">
               </td>
             </tr>";
}
echo "
	         <tr>
	           <td align=\"left\" width=\"40%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[205]</font></td>
	           <td align=\"left\" width=\"50%\">
	             <input type=\"checkbox\" name=\"user_always_logged\">
	           </td>
	          <td align=\"right\" width=\"10%\" colspan=\"2\">
	             <input type=\"submit\" value=\"$mess[58]\" class=\"vform\" />
	           </td>
	         </tr>
           </table>
         </form>
         </td>
     </tr>
     </table>
 </div>";
}

//----------------------------------------------------------------------------
//      MAIN
//----------------------------------------------------------------------------

// Se l'utente è già loggato mostro il profilo
if ($logged_user_name != '')
{
    header($header_location.'login.'.$phpExt.'?'.SID);
    exit;
}

switch($action)
{
	case ACTION_SELECTSKIN;
		change_skin();
		place_message($mess[59], $mess[96], basename(__FILE__));
		print_default();
		break;

	case ACTION_REGISTER;
	
		$user_name = getPostVar('user_name');
		$user_pass = getPostVar('user_pass');
		$user_pass1 = getPostVar('user_pass1');
		$typed_email = getPostVar('typed_email');
		$language = getPostVar('language');
		$digestcheckbox = getPostVar('digestcheckbox');
		$user_always_logged = getPostVar('user_always_logged');
		
		$userfilename = "$users_folder_name/$user_name";

		// User name can contain only latin and number spases,
		// and space, "_", "-" symbols inside the name
		if (!eregi("^[a-z0-9][a-z0-9 _-]{0,10}[a-z0-9]$", $user_name))
		{
			place_message($mess[59], $mess[103]." ".sprintf($mess[101], "<a href=\"register.$phpExt?".SID."\" style=\"font-size:10px;\">", "</a>"), basename(__FILE__));
			break;
		}

		// Se l'utente esiste già ritorno un errore
		if (file_exists($userfilename))
		{
			place_message($mess[59], sprintf($mess[104], $user_name)." ".sprintf($mess[101], "<a href=\"register.$phpExt?".SID."\" style=\"font-size:10px;\">", "</a>"), basename(__FILE__));
			break;
		}

		// Se le password non coincidono ritorno un errore
		if ($user_pass != $user_pass1)
		{
			place_message($mess[59], $mess[106]." ".sprintf($mess[101], "<a href=\"register.$phpExt?".SID."\" style=\"font-size:10px;\">", "</a>"), basename(__FILE__));
			break;
		}

		// Se l'indirizzo e-mail non è valido ritorno un errore
		if (!eregi( "^([a-z0-9_]|\\-|\\.)+@(([a-z0-9_]|\\-)+\\.)+[a-z]{2,4}$", $typed_email))
		{
			place_message($mess[59], $mess[107]." ".sprintf($mess[101], "<a href=\"register.$phpExt?".SID."\" style=\"font-size:10px;\">", "</a>"), basename(__FILE__));
			break;
		}

		// Avvio a registrazione dell'utente
		if ($require_email_confirmation && $mail_functions_enabled)
		{
			$enc_user_pass = md5($user_pass);
			srand((double)microtime()*1000000);
			$enc_logged_user_id = 0;
			$activationcode = rand() + 100;
		}
		else
		{
			$logged_user_name = $user_name;
			$enc_user_pass = md5($user_pass);
			srand((double)microtime()*1000000);
			$logged_user_id = md5(rand().microtime());
			$enc_logged_user_id = md5($logged_user_id);
			$user_status = $default_user_status;
			$user_temp_info = "";
			$user_wish_receive_digest = 0;
			$activationcode = USER_ACTIVE;

			// scrivo i dati nella sessione corrente
			if ($major > 4 || $release > 0)
			{
				$_SESSION['logged_user_name'] = $logged_user_name;
				$_SESSION['logged_user_id'] = $logged_user_id;
			}
			else
			{
				$HTTP_SESSION_VARS['logged_user_name'] = $logged_user_name;
				$HTTP_SESSION_VARS['logged_user_id'] = $logged_user_id;
			}

			// scrivo i dati nel cookie, se richiesto
			if (isset($user_always_logged))
			{
				if ($user_always_logged == 'on')
				{
					setcookie("logged_user_name", $logged_user_name, time() + $cookievalidity * 3600, $cookiepath, $cookiedomain, $cookiesecure);
					setcookie("logged_user_id", $logged_user_id, time() + $cookievalidity * 3600, $cookiepath, $cookiedomain, $cookiesecure);
		 		}
			}
		}

		$user_status = $default_user_status;
		$user_temp_info = "";
		$user_wish_receive_digest = 0;
		$user_account_creation_time = time();
		if ($mail_functions_enabled)
		{
			if (isset($digestcheckbox))
			{
				if ($digestcheckbox == "on")
				$user_wish_receive_digest = 1;
			}
		}

		// Send mail if needed
		if ($require_email_confirmation && $mail_functions_enabled)
		{ // Send e-mail
			$body = sprintf($register_email_body, $user_name, $activationcode, "$installurl/activate.$phpExt");
			$body .= $confirm_email_end."\n";
			$body .= $admin_name."\n";
			$body .= "Email: $admin_email";

			$from="$admin_name <$admin_email>";
			if ($charsetencoding != "")
				$headers="Content-Type: text; charset=$charsetencoding\n";
			else
				$headers="Content-Type: text; charset=iso-8859-1\n";
			$headers.="From: $from\nX-Mailer: System33r";

			if (!$use_smtp)
			{
				$result = @mail($typed_email,$register_email_subject,$body,$headers);
			}
			else
			{
				if (!defined('SMTP_INCLUDED'))
				{
					include($include_location.'include/smtp.'.$phpExt);
				}
				$result = smtpmail($typed_email,$register_email_subject,$body,$headers);
			}

			if ($result)
			{
				// Create user account file
				$user_email = $typed_email;
				save_user_profile($user_name);
				place_message($mess[59], $mess[108].' '.$mess[110], basename(__FILE__));
			}
			else
			{
				place_message($mess[59], $mess[177].' '.$mess[178], basename(__FILE__));
			}
		}
		else
		{
			// Create user account file
			$user_email = $typed_email;
			save_user_profile($user_name);
			place_message($mess[59], $mess[108].' '.sprintf($mess[109], "<a href=\"index.$phpExt?".SID."\" style=\"font-size:10px;\">", "</a>"), basename(__FILE__));
		}
		break;

	default;
		place_message($mess[59], $mess[59], basename(__FILE__));
		print_default();
		break;
}

show_footer_page();
?>
