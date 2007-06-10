<?php
/**
 *           			admin_spamwords_config.php
 *             			-------------------
 *   begin  			: Monday, Nov 22nd, 2005
 *   last update		: Tuesday, Dec 27th, 2005
 *   copyright  		: (C) 2006 Joe Belmaati
 *   email     			: belmaati@gmail.com
 *
 */

/**
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 */

define('IN_PHPBB', 1);

if(!empty($setmodules))
{
	$file = basename(__FILE__);
	$module['Spam_words']['Configuration'] = "$file";
	return;
}

$phpbb_root_path = "./../";
require($phpbb_root_path . 'extension.inc');
require('./pagestart.' . $phpEx);
include($phpbb_root_path . 'includes/functions_selects.'.$phpEx);
include($phpbb_root_path . 'language/lang_' . $board_config['default_lang'] . '/lang_spamwords_admin.' . $phpEx);

//
// Pull all config data
//
$sql = "SELECT *
	FROM " . SPAM_WORDS_CONFIG_TABLE;
if(!$result = $db->sql_query($sql))
{
	message_die(CRITICAL_ERROR, 'Could not query config information', '', __LINE__, __FILE__, $sql);
}
else
{
	while($row = $db->sql_fetchrow($result))
	{
		$config_name = $row['config_name'];
		$config_value = $row['config_value'];
		$default_config[$config_name] = isset($HTTP_POST_VARS['submit']) ? str_replace("'", "\'", $config_value) : $config_value;

		$new[$config_name] = (isset($HTTP_POST_VARS[$config_name])) ? $HTTP_POST_VARS[$config_name] : $default_config[$config_name];

		if(isset($HTTP_POST_VARS['submit']))
		{
			$sql = "UPDATE " . SPAM_WORDS_CONFIG_TABLE . " SET
				config_value = '" . str_replace("\'", "''", $new[$config_name]) . "'
				WHERE config_name = '$config_name'";
			if(!$db->sql_query($sql))
			{
				message_die(GENERAL_ERROR, "Failed to update spam words configuration for $config_name", '', __LINE__, __FILE__, $sql);
			}
		}
	}

	if(isset($HTTP_POST_VARS['submit']))
	{
		$message = $lang['Spam_config_updated'] . "<br /><br />" . sprintf($lang['Click_return_spam_config'], "<a href=\"" . append_sid("admin_spamwords_config.$phpEx") . "\">", "</a>") . "<br /><br />" . sprintf($lang['Click_return_admin_index'], "<a href=\"" . append_sid("index.$phpEx?pane=right") . "\">", "</a>");

		message_die(GENERAL_MESSAGE, $message);
	}
}

//
// Data below here
//
$disable_mod_yes = (!$new['enable_spam_words']) ? "checked=\"checked\"" : "";
$disable_mod_no = ($new['enable_spam_words']) ? "checked=\"checked\"" : "";

$flag_posts = ($new['flag_posts']) ? "checked=\"checked\"" : "";
$error_message = (!$new['flag_posts']) ? "checked=\"checked\"" : "";

$warn_user_pm_yes = ($new['warn_user_pm']) ? "checked=\"checked\"" : "";
$warn_user_pm_no = (!$new['warn_user_pm']) ? "checked=\"checked\"" : "";

$allow_admin_yes = ($new['allow_admin']) ? "checked=\"checked\"" : "";
$allow_admin_no = (!$new['allow_admin']) ? "checked=\"checked\"" : "";

$allow_mod_yes = ($new['allow_moderator']) ? "checked=\"checked\"" : "";
$allow_mod_no = (!$new['allow_moderator']) ? "checked=\"checked\"" : "";

$allow_reg_yes = ($new['allow_reg']) ? "checked=\"checked\"" : "";
$allow_reg_no = (!$new['allow_reg']) ? "checked=\"checked\"" : "";

$ban_ip_yes = ($new['ban_ip']) ? "checked=\"checked\"" : "";
$ban_ip_no = (!$new['ban_ip']) ? "checked=\"checked\"" : "";

$template->set_filenames(array(
"body" => "admin/spamwords_config_body.tpl")
);

//
// Escape any quotes in the site description for proper display in the text
// box on the admin page
//
$new['error_message'] = str_replace('"', '&quot;', $new['error_message']);
$new['error_message_sig'] = str_replace('"', '&quot;', $new['error_message_sig']);
$new['warn_user_pm_subject'] = str_replace('"', '&quot;', $new['warn_user_pm_subject']);
$new['warn_user_pm_message'] = str_replace('"', '&quot;', $new['warn_user_pm_message']);

$message = sprintf($lang['More_words'], "<a href=\"" . append_sid("admin_spamwords.$phpEx") . "\">", "</a>");

$template->assign_vars(array(
'S_CONFIG_ACTION' => append_sid("admin_spamwords_config.$phpEx"),

'L_SUBMIT' => $lang['Submit'],
'L_RESET' => $lang['Reset'],
'L_YES' => $lang['Yes'],
'L_NO' => $lang['No'],
'L_GENERAL_SETTINGS' => $lang['General_spam_settings'],
'L_CONFIGURATION_TITLE' => $lang['Spam_config'],
'L_CONFIGURATION_EXPLAIN' => $lang['Spam_config_explain'],
'L_DISABLE_MOD' => $lang['Disable_mod'],
'L_DISABLE_MOD_EXPLAIN' => $lang['Disable_mod_explain'],
'L_HANDLE_SPAM' => $lang['Handle_spam'],
'L_HANDLE_SPAM_EXPLAIN' => $lang['Handle_spam_explain'],
'L_FLAG_POSTS' => $lang['Flag_posts'],
'L_ERROR_MESSAGE' => $lang['Error_message'],
'L_WARN_USER_PM' => $lang['Warn_user_pm'],
'L_EXCEPTIONS' => $lang['Exceptions'],
'L_EXCEPTIONS_EXPLAIN' => $lang['Exceptions_explain'],
'L_ALLOW_ADMIN' => $lang['Allow_admin'],
'L_ALLOW_MOD' => $lang['Allow_mod'],
'L_ALLOW_REG' => $lang['Allow_reg'],
'L_USER_POST_COUNT' => $lang['User_post_count'],
'L_POSTS' => $lang['Posts'],
'L_OFFENSES' => $lang['Offenses'],
'L_OFFENSES_EXPLAIN' => $lang['Offenses_explain'],
'L_ERROR_MESSAGES' => $lang['Error_messages'],
'L_ERROR_MESSAGES_EXPLAIN' => $lang['Error_messages_explain'],
'L_ERROR_TEXT' => $lang['Error_text'],
'L_ERROR_SIG' => $lang['Error_sig'],
'L_PM_MESSAGES' => $lang['PM_messages'],
'L_PM_MESSAGES_EXPLAIN' => $lang['PM_messages_explain'],
'L_PM_MESSAGE' => $lang['PM_message'],
'L_PM_SUBJECT' => $lang['PM_subject'],
'L_BAN_IP' => $lang['Ban_ip'],
'L_CURRENT_WORDS' => $lang['Current_words'],
'L_MORE_WORDS' => $message,

'S_DISABLE_MOD_YES' => $disable_mod_yes,
'S_DISABLE_MOD_NO' => $disable_mod_no,
'S_FLAG_POSTS' => $flag_posts,
'S_ERROR_MESSAGE' => $error_message,
'S_WARN_USER_PM_YES' => $warn_user_pm_yes,
'S_WARN_USER_PM_NO' => $warn_user_pm_no,
'S_ALLOW_ADMIN_YES' => $allow_admin_yes,
'S_ALLOW_ADMIN_NO' => $allow_admin_no,
'S_ALLOW_MOD_YES' => $allow_mod_yes,
'S_ALLOW_MOD_NO' => $allow_mod_no,
'S_ALLOW_REG_YES' => $allow_reg_yes,
'S_ALLOW_REG_NO' => $allow_reg_no,

'S_BAN_IP_YES' => $ban_ip_yes,
'S_BAN_IP_NO' => $ban_ip_no,

'USER_POST_COUNT' => $new['allow_user_posts'],
'OFFENSES' => $new['user_warnings'],
'ERROR_TEXT' => $new['error_message'],
'ERROR_SIG' => $new['error_message_sig'],
'PM_SUBJECT' => $new['warn_user_pm_subject'],
'PM_MESSAGE' => $new['warn_user_pm_message'],
)
);

//
// Get current spam words
//
$sql = "SELECT spam_word
	FROM " . SPAM_WORDS_TABLE;
if(!$result = $db->sql_query($sql))
{
	message_die(CRITICAL_ERROR, 'Could not query spam words information', '', __LINE__, __FILE__, $sql);
}

$words = $db->sql_fetchrowset($result);
$count_words = count($words);

//
// No spam words entered yet
//
$no_words = ($count_words == 0) ? $lang['No_words'] : '';
$template->assign_vars(array(
'L_NO_WORDS' => $no_words)
);

//
// Loop it up, baby...
//
for ($i = 0; $i < $count_words; $i++)
{
	$template->assign_block_vars('words', array(
	'WORDS' => ($i == 0) ? $words[$i]['spam_word'] : ', ' . $words[$i]['spam_word'])
	);
}

$template->pparse('body');

include('./page_footer_admin.'.$phpEx);

?>
