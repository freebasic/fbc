<?php
/***************************************************************************
 *                               activate.php
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
global $uploadcentercaption, $phpExt;
global $tablecolor,$bordercolor,$headercolor,$headerfontcolor;

echo "
	<br>
   <table class=\"tb_dir_list\">
     <tr>
       <th align=\"left\" bgcolor=\"$headercolor\" valign=\"middle\"><font size=\"2\" face=\"$font\" color=\"$headerfontcolor\">$mess[113]</font></th>
     </tr>
     <tr>
         <td align=\"left\" bgcolor=\"$tablecolor\" valign=\"middle\">
         <form name=\"userlogin\" action=\"activate.$phpExt?".SID."\"  method=\"post\" style=\"margin: 0\">
           <input type=\"hidden\" name=\"action\" value=\"".ACTION_CONFIRM."\">
           <table border=\"0\" width=\"100%\" cellpadding=\"4\">
             <tr>
               <td align=\"left\" width=\"20%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[57]</font></td>
               <td align=\"left\" width=\"80%\" colspan=2>
                 <input type=\"text\" class=\"vform\" name=\"user_name\" size=25>
               </td>
             </tr>
             <tr>
               <td align=\"left\" width=\"20%\"><font size=\"1\" face=\"$font\" color=\"$normalfontcolor\">$mess[114]</font></td>
               <td align=\"left\" width=\"70%\">
                 <input type=\"text\" class=\"vform\" name=\"code\" size=25>
               </td>
               <td align=\"right\" width=\"10%\" colspan=\"2\">
                 <input type=\"submit\" class=\"vform\" name=\"Submit\" value=\"$mess[112]\" />
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

$user_name = getPostVar('user_name');
$code = getPostVar('code');

switch($action)
{
	case ACTION_SELECTSKIN;
		change_skin();
		place_message($mess[59], $mess[96], basename(__FILE__));
		print_default();
		break;


	case ACTION_CONFIRM;
		if (($user_name != '') && ($code != ''))
		{
			$userfilename = "$users_folder_name/$user_name";
			// Check the user name
			if (file_exists($userfilename))
			{
				load_user_profile($user_name);
		        if ($activationcode == USER_ACTIVE || $activationcode == USER_DISABLED)  // If account already activated
		        {
		          place_message($mess[112], $mess[118]." ".sprintf($mess[116], "<a href=\"login.$phpExt?".SID."\" style=\"font-size:10px;\">", "</a>"), basename(__FILE__));
		          show_footer_page();
		          exit;
		        }
		        if ($activationcode == $code)
		        {
		          $activationcode = USER_ACTIVE;
		          save_user_profile($user_name);
		          place_message($mess[112], $mess[115]." ".sprintf($mess[116], "<a href=\"login.$phpExt?".SID."\" style=\"font-size:10px;\">", "</a>"), basename(__FILE__));
		          show_footer_page();
		          exit;
		        }
			}
			// Show invalid activation code message
			place_message($mess[112], $mess[117]." ".sprintf($mess[101], "<a href=\"confirm.$phpExt?".SID."\" style=\"font-size:10px;\">", "</a>"), basename(__FILE__));
		}
		else
			place_message($mess[112], $mess[117]." ".sprintf($mess[101], "<a href=\"confirm.$phpExt?".SID."\" style=\"font-size:10px;\">", "</a>"), basename(__FILE__));
		break;

	default;
		place_message($mess[112], $mess[113], basename(__FILE__));
		print_default();
		break;
}

show_footer_page();
?>
