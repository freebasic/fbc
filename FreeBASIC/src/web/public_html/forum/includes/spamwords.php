<?php
/**
 *           			spamwords.php
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

if (!defined('IN_PHPBB'))
{
	die("Hacking attempt");
}

//
// Check spam words config
//
$sql = "SELECT *
	FROM " . SPAM_WORDS_CONFIG_TABLE;
if(!($result = $db->sql_query($sql)))
{
	message_die(CRITICAL_ERROR, 'Could not query spam words config information', '', __LINE__, __FILE__, $sql);
}

while ($row = $db->sql_fetchrow($result))
{
	$spam_config[$row['config_name']] = $row['config_value'];
}

//
// Declare functions
//
function insert_pm($to_id, $pm_message, $subject, $from_id, $html_on = 0, $bbcode_on = 1, $smilies_on = 1)
{
	global $db, $lang, $user_ip, $board_config, $userdata, $phpbb_root_path, $spam_config, $phpEx;

	if ($spam_config['warn_user_pm'] && $userdata['session_logged_in'])
	{
		if (!$from_id)
		{
			$from_id = $userdata['user_id'];
		}

		//get variables ready
		$to_id = intval($to_id);
		$from_id = intval($from_id);
		$msg_time = time();
		$attach_sig = $userdata['user_attachsig'];

		//get to users info
		$sql = "SELECT user_id, user_notify_pm, user_email, user_lang, user_active
		FROM " . USERS_TABLE . "
		WHERE user_id = '$to_id'
		AND user_id <> " . ANONYMOUS;
		if (!($result = $db->sql_query($sql)))
		{
			$error = TRUE;
			$error_msg = $lang['No_such_user'];
		}

		$to_userdata = $db->sql_fetchrow($result);

		$privmsg_subject = trim(strip_tags($subject));
		if (empty($privmsg_subject))
		{
			$error = TRUE;
			$error_msg .= ((!empty($error_msg)) ? '<br />' : '') . $lang['Empty_subject'];
		}

		if (!empty($pm_message))
		{
			if (!$error)
			{
				if ($bbcode_on)
				{
					$bbcode_uid = make_bbcode_uid();
				}

				$privmsg_message = prepare_message($pm_message, $html_on, $bbcode_on, $smilies_on, $bbcode_uid);
				$privmsg_message = str_replace('\\\n', '\n', $privmsg_message);

			}
		}
		else
		{
			$error = TRUE;
			$error_msg .= ((!empty($error_msg)) ? '<br />' : '') . $lang['Empty_message'];
		}

		$sql_info = "INSERT INTO " . PRIVMSGS_TABLE . " (privmsgs_type, privmsgs_subject, privmsgs_from_userid, privmsgs_to_userid, privmsgs_date, privmsgs_ip, privmsgs_enable_html, privmsgs_enable_bbcode, privmsgs_enable_smilies, privmsgs_attach_sig)
		VALUES (" . PRIVMSGS_NEW_MAIL . ", '" . str_replace("\'", "''", $privmsg_subject) . "', " . $from_id . ", " . $to_userdata['user_id'] . ", $msg_time, '$user_ip', $html_on, $bbcode_on, $smilies_on, $attach_sig)";

		if (!($result = $db->sql_query($sql_info, BEGIN_TRANSACTION)))
		{
			message_die(GENERAL_ERROR, "Could not insert/update private message sent info.", "", __LINE__, __FILE__, $sql_info);
		}

		$privmsg_sent_id = $db->sql_nextid();

		$sql = "INSERT INTO " . PRIVMSGS_TEXT_TABLE . " (privmsgs_text_id, privmsgs_bbcode_uid, privmsgs_text)
		VALUES ($privmsg_sent_id, '" . $bbcode_uid . "', '" . str_replace("\'", "''", $privmsg_message) . "')";

		if (!$db->sql_query($sql, END_TRANSACTION))
		{
			message_die(GENERAL_ERROR, "Could not insert/update private message sent text.", "", __LINE__, __FILE__, $sql);
		}

		//
		// Add to the users new pm counter
		//
		$sql = "UPDATE " . USERS_TABLE . "
		SET user_new_privmsg = user_new_privmsg + 1, user_last_privmsg = " . time() . "
		WHERE user_id = " . $to_userdata['user_id'];
		if (!$status = $db->sql_query($sql))
		{
			message_die(GENERAL_ERROR, 'Could not update private message new/read status for user', '', __LINE__, __FILE__, $sql);
		}

		if ($to_userdata['user_notify_pm'] && !empty($to_userdata['user_email']) && $to_userdata['user_active'])
		{
			$script_name = preg_replace('/^\/?(.*?)\/?$/', "\\1", trim($board_config['script_path']));
			$script_name = ($script_name != '') ? $script_name . '/privmsg.'.$phpEx : 'privmsg.'.$phpEx;
			$server_name = trim($board_config['server_name']);
			$server_protocol = ($board_config['cookie_secure']) ? 'https://' : 'http://';
			$server_port = ($board_config['server_port'] <> 80) ? ':' . trim($board_config['server_port']) . '/' : '/';

			include($phpbb_root_path . 'includes/emailer.'.$phpEx);
			$emailer = new emailer($board_config['smtp_delivery']);

			$emailer->from($board_config['board_email']);
			$emailer->replyto($board_config['board_email']);

			$emailer->use_template('privmsg_notify', $to_userdata['user_lang']);
			$emailer->email_address($to_userdata['user_email']);
			$emailer->set_subject($lang['Notification_subject']);

			$emailer->assign_vars(array(
			'USERNAME' => $to_username,
			'SITENAME' => $board_config['sitename'],
			'EMAIL_SIG' => (!empty($board_config['board_email_sig'])) ? str_replace('<br />', "\n", "-- \n" . $board_config['board_email_sig']) : '',

			'U_INBOX' => $server_protocol . $server_name . $server_port . $script_name . '?folder=inbox')
			);

			$emailer->send();
			$emailer->reset();
		}

		return;

		$msg = $lang['Message_sent'] . '<br /><br />' . sprintf($lang['Click_return_inbox'], '<a href="' . append_sid("privmsg.$phpEx?folder=inbox") . '">', '</a> ') . '<br /><br />' . sprintf($lang['Click_return_index'], '<a href="' . append_sid("index.$phpEx") . '">', '</a>');

		message_die(GENERAL_MESSAGE, $msg);
	}
}

function warn_user()
{
	global $db, $userdata;

	if ($userdata['session_logged_in'])
	{
		$sql = "UPDATE " . USERS_TABLE . " SET user_spam_warnings = user_spam_warnings + 1
			WHERE user_id = " . $userdata['user_id'];
		if(!($result = $db->sql_query($sql)))
		{
			message_die(GENERAL_ERROR, 'Could not get user warnings from database', '', __LINE__, __FILE__, $sql);
		}
	}
}

function update_log(&$subject, &$message)
{
	global $db, $userdata, $spam_config, $lang, $post_data;

	$flagged = ($spam_config['flag_posts']) ? 1 : 0;
	$current_time = time();
	$browser = (isset($HTTP_SERVER_VARS['HTTP_USER_AGENT'])) ? $HTTP_SERVER_VARS['HTTP_USER_AGENT'] : getenv('HTTP_USER_AGENT');
	$user_ip = (isset($HTTP_SERVER_VARS['REMOTE_ADDR'])) ? $HTTP_SERVER_VARS['REMOTE_ADDR'] : getenv('REMOTE_ADDR');

	$sql = "INSERT INTO " . SPAM_WORDS_LOG_TABLE . " (log_user_id, log_username, log_ip, log_timestamp, log_browser, log_flagged, log_message, log_subject, log_post_id)
		VALUES ('" . $userdata['user_id'] . "', '" . $userdata['username'] . "', '" . $user_ip . "', '" . $current_time . "', '" . $browser . "', '" . $flagged . "', '" . $message . "', '" . $subject . "', '" . $post_data['post_id'] . "')";

	if (!$db->sql_query($sql))
	{
		message_die(GENERAL_ERROR, 'Could not update log', '', __LINE__, __FILE__, $sql);
	}
}

function ban_user()
{
	global $db, $userdata, $spam_config;

	$user_ip = (isset($HTTP_SERVER_VARS['REMOTE_ADDR'])) ? $HTTP_SERVER_VARS['REMOTE_ADDR'] : getenv('REMOTE_ADDR');
	$user_ip = encode_ip($user_ip);

	if ($userdata['user_spam_warnings'] > $spam_config['user_warnings'] && $spam_config['user_warnings'] != 0 && $userdata['user_level'] != ADMIN)
	{
		if ($spam_config['ban_ip'])
		{
			$sql = "INSERT INTO " . BANLIST_TABLE . "(ban_userid, ban_ip)
			VALUES (" . $userdata['user_id'] . ", '$user_ip')";

			if(!($result = $db->sql_query($sql)))
			{
				message_die(GENERAL_ERROR, 'Could not update banlist', '', __LINE__, __FILE__, $sql);
			}
		}
		else
		{
			$sql = "INSERT INTO " . BANLIST_TABLE . "(ban_userid)
			VALUES (" . $userdata['user_id'] . ")";

			if(!($result = $db->sql_query($sql)))
			{
				message_die(GENERAL_ERROR, 'Could not update banlist', '', __LINE__, __FILE__, $sql);
			}
		}

		//
		// Log out the offender
		//
		$sql = "DELETE FROM " . SESSIONS_TABLE . "
		WHERE session_user_id = " . $userdata['user_id'];

		if(!($result = $db->sql_query($sql)))
		{
			message_die(GENERAL_ERROR, 'Could not update sessions table', '', __LINE__, __FILE__, $sql);
		}
	}
}

function check_spam($message, &$subject, &$signature)
{
	global $db, $spam_config, $userdata, $post_flagged;

	$sql = "SELECT spam_word
	FROM  " . SPAM_WORDS_TABLE;

	if(!($result = $db->sql_query($sql)))
	{
		message_die(GENERAL_ERROR, 'Could not get spam words from database', '', __LINE__, __FILE__, $sql);
	}

	$message = preg_replace("/\[.*?:$bbcode_uid:?.*?\]/si", '', $message);
	$message = preg_replace('/\[url\]|\[\/url\]/si', '', $message);

	if ($row = $db->sql_fetchrow($result))
	{
		do
		{
			if (preg_match('#\b(' . str_replace('\*', '\w*?', phpbb_preg_quote($row['spam_word'], '#')) . ')\b#i', $message) || preg_match('#\b(' . str_replace('\*', '\w*?', phpbb_preg_quote($row['spam_word'], '#')) . ')\b#i', $subject))
			{
				if ($spam_config['flag_posts'])
				{
					update_log($subject, $message);
					warn_user();
					ban_user();
					insert_pm($userdata['user_id'], $spam_config['warn_user_pm_message'], $spam_config['warn_user_pm_subject'], 2);
					$post_flagged = 1;
				}
				else
				{
					update_log($subject, $message);
					warn_user($user);
					ban_user($user);
					insert_pm($userdata['user_id'], $spam_config['warn_user_pm_message'], $spam_config['warn_user_pm_subject'], 2);
					$message = sprintf($spam_config['error_message'], $row['spam_word']);
					message_die(GENERAL_MESSAGE, $message);
				}
			}

			if (preg_match('#\b(' . str_replace('\*', '\w*?', phpbb_preg_quote($row['spam_word'], '#')) . ')\b#i', $userdata['user_sig']))
			{
				$message = sprintf($spam_config['error_message_sig'], $row['spam_word']);
				message_die(GENERAL_MESSAGE, $message);
			}

		}
		while ($row = $db->sql_fetchrow($result));
	}
}

//
// Let's define who gets to do what.
//
if ($spam_config['enable_spam_words'])
{
	if ($spam_config['allow_admin'] && $userdata['user_level'] == ADMIN)
	{
		// Admin
		return;
	}
	else if ($spam_config['allow_moderator'] && $userdata['user_level'] == MOD)
	{
		// Trusted member
		return;
	}
	else if ($spam_config['allow_reg'] && $userdata['session_logged_in'])
	{
		// Registered member
		return;
	}
	else if ($userdata['session_logged_in'] && $spam_config['allow_user_posts'] < $userdata['user_posts'] && $spam_config['allow_user_posts'] !=0)
	{
		// User with a lot of posts
		return;
	}
	else
	{
		// Look out...
		check_spam($message, $subject, $signature);
	}
}

?>
