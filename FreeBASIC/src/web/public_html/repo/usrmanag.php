<?php
/***************************************************************************
 *                               usrmanag.php
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

function print_user_profile()
{
  global $phpExt;
  global $mess, $font, $normalfontcolor, $selectedfontcolor, $homeurl, $languages;
  global $uploadcentercaption,$logged_user_name,$mail_functions_enabled;
  global $tablecolor,$bordercolor,$headercolor,$headerfontcolor, $order, $letter, $accpage;
  global $user_wish_receive_digest, $user_email, $user_account_creation_time, $user_status, $activationcode;


  if (!isset($order))
  	$order = "name";

  $accountsperpage = 20;


  $users = userslist($order);
  $usercount = count($users);

echo "<br>
  <table class=\"tb_dir_list\">
    <tr>
      <td align=\"center\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\"><a href=\"usrmanag.$phpExt?".SID."\">$mess[57]</a></font></td>
      <td align=\"center\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\"><a href=\"usrmanag.${phpExt}?order=date&".SID."\">$mess[154]</a></font></td>
      <td align=\"center\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\"><a href=\"usrmanag.${phpExt}?order=access&".SID."\">$mess[155]</a></font></td>
      <td align=\"center\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\"><a href=\"usrmanag.${phpExt}?order=status&".SID."\">$mess[156]</a></font></td>
      <td align=\"center\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\"><a href=\"usrmanag.${phpExt}?order=activestatus&".SID."\">$mess[157]</a></font></td>
      <td rowspan=\"2\" align=\"right\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[160] $usercount $mess[161]</font></td>
    </tr>
    <tr>
      <td align=\"center\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\"><a href=\"usrmanag.${phpExt}?order=receivedigest&".SID."\">$mess[158]</a></font></td>
      <td align=\"center\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\"><a href=\"usrmanag.${phpExt}?order=email&".SID."\">$mess[159]</a></font></td>

      <td align=\"center\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\"><a href=\"usrmanag.${phpExt}?order=uploaded&".SID."\">$mess[151]</a></font></td>
      <td align=\"center\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\"><a href=\"usrmanag.${phpExt}?order=downloaded&".SID."\">$mess[152]</a></font></td>
      <td align=\"center\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\"><a href=\"usrmanag.${phpExt}?order=emailed&".SID."\">$mess[153]</a></font></td>
    </tr>
  </table>";

if ($usercount > $accountsperpage)
{
echo "<br>
  <table class=\"tb_dir_list\">
    <tr>
      <td align=\"center\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">";

      if (($order == "name") || ($order == "email"))
      {
        echo "<a href=\"usrmanag.${phpExt}?order=$order&letter=*&".SID."\">*</a> ";
        for ($i = 65; $i <= 90; $i++)
        {
          $lett = chr($i);
          echo "<a href=\"usrmanag.${phpExt}?order=$order&letter=$lett&".SID."\">$lett</a> ";
        }
        echo "<a href=\"usrmanag.${phpExt}?order=$order&letter=All&".SID."\">$mess[142]</a> ";
      }
      else
      {
        for ($i = 1; $i < $usercount/$accountsperpage + 1; $i++)
        {
          echo "<a href=\"usrmanag.${phpExt}?order=$order&accpage=$i&".SID."\">$i</a> ";
        }
        echo "<a href=\"usrmanag.${phpExt}?order=$order&accpage=0&".SID."\">$mess[142]</a> ";
      }
echo " </font></td>
    </tr>
  </table>";
}

  $shownaccounts = 0;
  $currentaccount = 0;
  while (list($filename, $filed) = each($users))
  {
    $currentaccount++;
    if ($usercount > $accountsperpage)
      if (($order == "name") || ($order == "email"))
      {
        if ($letter != "All")
        {
          $let = ucfirst(substr($filed,0,1));
          if ($letter == '*')
          {
            if (eregi("[A-Z]", $let))
              continue;
          }
          else
            if ($let != $letter)
              continue;
        }
      }
      else
        if ($accpage != 0)
          if ($accpage-1 != (int)($currentaccount/$accountsperpage))
            continue;

    $shownaccounts++;
    load_user_profile($filename);

    $account_date = getdate($user_account_creation_time);
    $month = $account_date['mon'];
    $mday = $account_date['mday'];
    $year = $account_date['year'];
    list($files_uploaded, $files_downloaded, $files_emailed, $last_acess_time) = load_userstat($filename);
    if ($last_acess_time == 0)
      $last_acess_time = $user_account_creation_time;
    $access_date = getdate($last_acess_time);
    $accessmonth = $access_date['mon'];
    $accessmday = $access_date['mday'];
    $accessyear = $access_date['year'];

echo "<br>
   <table class=\"tb_dir_list\">
     <tr>
       <th align=\"left\" bgcolor=\"$headercolor\" valign=\"middle\"><font size=\"2\" face=\"$font\" color=\"$headerfontcolor\">$currentaccount. $filename</font></th>
     </tr>
     <tr>
         <td align=\"left\" bgcolor=\"$tablecolor\" valign=\"middle\">
         <form name=\"useraccount\" action=\"usrmanag.$phpExt?".SID."\" method=\"post\" style=\"margin: 0\">
           <input type=\"hidden\" name=\"action\" value=\"".ACTION_PROFILE."\">
           <input type=\"hidden\" name=\"order\" value=\"$order\">
           <input type=\"hidden\" name=\"letter\" value=\"$letter\">
           <input type=\"hidden\" name=\"accpage\" value=\"$accpage\">
           <input type=\"hidden\" name=\"username\" value=\"$filename\">
           <table border=\"0\" width=\"100%\" cellpadding=\"4\">
             <tr>
               <td align=\"left\" width=\"30%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[154]/$mess[155]</font></td>
               <td align=\"left\" width=\"70%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">
               $mess[$month] $mday, $year / $mess[$accessmonth] $accessmday, $accessyear
               </font></td>
             </tr>";

       if ($files_uploaded)
         echo "
             <tr>
               <td align=\"left\" width=\"30%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[151]:</font></td>
               <td align=\"left\" width=\"70%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">
               $files_uploaded
               </font></td>
             </tr>";

       if ($files_downloaded)
         echo "
             <tr>
               <td align=\"left\" width=\"30%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[152]:</font></td>
               <td align=\"left\" width=\"70%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">
               $files_downloaded
               </font></td>
             </tr>";
       if ($files_emailed)
         echo "
             <tr>
               <td align=\"left\" width=\"30%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[153]:</font></td>
               <td align=\"left\" width=\"70%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">
               $files_emailed
               </font></td>
             </tr>";


     echo "  <tr>
               <td align=\"left\" width=\"30%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">E-mail</font></td>
               <td align=\"left\" width=\"70%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">
                 <input type=\"text\" class=\"vform\" name=\"typed_email\" value=\"$user_email\">
               </font></td>
             </tr>
             <tr>
               <td align=\"left\" width=\"30%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[156]</font></td>
               <td align=\"left\" width=\"70%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">
                 <select name=\"typed_status\" class=\"vform\" size=\"1\">";

                 if ($user_status == ADMIN)
                   echo "<option value=\"0\" selected>$mess[77]</option>";
                 else
                   echo "<option value=\"0\">$mess[77]</option>";
                 if ($user_status == POWER)
                   echo "<option value=\"1\" selected>$mess[76]</option>";
                 else
                   echo "<option value=\"1\">$mess[76]</option>";
                 if ($user_status == NORMAL)
                   echo "<option value=\"2\" selected>$mess[75]</option>";
                 else
                   echo "<option value=\"2\">$mess[75]</option>";
                 if ($user_status == VIEWER)
                   echo "<option value=\"3\" selected>$mess[138]</option>";
                 else
                   echo "<option value=\"3\">$mess[138]</option>";
                 if ($user_status == UPLOADER)
                   echo "<option value=\"4\" selected>$mess[139]</option>";
                 else
                   echo "<option value=\"4\">$mess[139]</option>";

         echo "  </select>
               </font></td>
             </tr>
             <tr>
               <td align=\"left\" width=\"30%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[157]</font></td>
               <td align=\"left\" width=\"70%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">
                 <select name=\"typed_activestatus\" class=\"vform\" size=\"1\">";

                 if ($activationcode == USER_DISABLED)
                   echo "<option value=\"0\" selected>$mess[175]</option>";
                 else
                   echo "<option value=\"0\">$mess[175]</option>";
                 if ($activationcode == USER_ACTIVE)
                   echo "<option value=\"1\" selected>$mess[174]</option>";
                 else
                   echo "<option value=\"1\">$mess[174]</option>";
                 if ($activationcode != USER_DISABLED && $activationcode != USER_ACTIVE)
                   echo "<option value=\"2\" selected>$mess[176]</option>";
                 else
                   echo "<option value=\"2\">$mess[176]</option>";

         echo "  </select>
               </font></td>
             </tr>
             <tr>
               <td align=\"left\" width=\"30%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[158]</font></td>
               <td align=\"left\" width=\"70%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">
                 <select name=\"typed_digest\" class=\"vform\" size=\"1\">";

                 if ($user_wish_receive_digest == 0)
                   echo "<option value=\"0\" selected>$mess[173]</option>";
                 else
                   echo "<option value=\"0\">$mess[173]</option>";
                 if ($user_wish_receive_digest == 1)
                   echo "<option value=\"1\" selected>$mess[172]</option>";
                 else
                   echo "<option value=\"1\">$mess[172]</option>";

         echo "  </select>
               </font></td>
             </tr>
             <tr>
               <td align=\"left\" width=\"40%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[162]</font></td>
               <td align=\"left\" width=\"50%\">
                 <input type=\"checkbox\" name=\"deleteaccountcheckbox\">
               </td>
               <td align=\"left\" width=\"10%\" colspan=\"2\">
                 <input type=\"submit\" class=\"vform\" name=\"Submit\" value=\"$mess[127]\" />
               </td>
             </tr>
             <tr>

             </tr>
           </table>
         </form>
         </td>
     </tr>
     </table>";
  }

echo "<br>
  <table class=\"tb_dir_list\">
    <tr>
      <td align=\"right\" bgColor=\"$tablecolor\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">";
  echo sprintf($mess[163], $shownaccounts, $usercount);
echo "</font></td>
    </tr>
  </table>";
}

function change_account_data()
{
  global $username, $typed_email, $typed_status, $typed_activestatus, $typed_digest, $deleteaccountcheckbox;
  global $users_folder_name, $enc_user_pass, $enc_logged_user_id, $user_email, $userstat_folder_name;
  global $user_status, $activationcode, $user_temp_info, $user_wish_receive_digest;
  global $user_account_creation_time;

  $userfilename = "$users_folder_name/$username";
  if (!file_exists($userfilename))
    return;
  if (isset($deleteaccountcheckbox))
  {
    if ($deleteaccountcheckbox == "on")
    {
      unlink("$users_folder_name/$username");                // Delete account file
      if (file_exists("$userstat_folder_name/$username.stat"))
        unlink("$userstat_folder_name/$username.stat");      // Delete account statistics file
      return;
    }
  }
  load_user_profile($username);
  $user_email = $typed_email;
  $user_status = $typed_status;
  if ($typed_activestatus < 2)
    $activationcode = $typed_activestatus;
  $user_wish_receive_digest = $typed_digest;
  save_user_profile($username);
}

function show_default($message)
{
  global $logged_user_name, $mess;

  if ($logged_user_name != "")
  {
    if (check_is_user_session_active($logged_user_name))
    {
      // If user already entered, show logout screen
      if ($message == "")
        $message = $mess[137];
      place_message($mess[137], $message, basename(__FILE__));
      print_user_profile();
      return;
    }
  }
  // Show default window
  if ($message == "")
    $message = $mess[42];
  place_message($mess[137], $message, basename(__FILE__));
}

//----------------------------------------------------------------------------
//      MAIN
//----------------------------------------------------------------------------

// Se l'utente non è loggato lo indirizzo al login
if ($logged_user_name == '')
{
	header($header_location.'login.'.$phpExt.'?'.SID);
	exit;
}

// Controllo che l'utente sia amministratore
if ($user_status != ADMIN)
{
	header($header_location.'index.'.$phpExt.'?'.SID);
	exit;
}

switch($action)
{
	case ACTION_SELECTSKIN;
		change_skin();
		show_default($mess[96]);
		break;

	case ACTION_PROFILE;
	
		$order = getPostVar('order');
		$letter = getPostVar('letter');
		$accpage = getPostVar('accpage');
		$typed_email = getPostVar('typed_email');
		$typed_status = getPostVar('typed_status');
		$typed_activestatus = getPostVar('typed_activestatus');
		$typed_digest = getPostVar('typed_digest');
		$username = getPostVar('username');
		$deleteaccountcheckbox = getPostVar('deleteaccountcheckbox');
	
		if (isset($username))
		{
			change_account_data();
			show_default(sprintf($mess[140], $username));
		}
		break;

	//----------------------------------------------------------------------------
	//      DEFAULT
	//----------------------------------------------------------------------------
	default;
	
		$order = getGetVar('order');
		$letter = getGetVar('letter');
		$accpage = getGetVar('accpage');
	
		show_default("");
		break;
}

show_footer_page();
?>
