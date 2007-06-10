<?php
/**
 *           			admin_spamwords_log.php
 *             			-------------------
 *   begin  				: Monday, Nov 22nd, 2005
 *   last update			: Tuesday, Dec 27th, 2005
 *   copyright  			: (C) 2006 Joe Belmaati
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
	$module['Spam_words']['Log'] = "$file";
	return;
}

$phpbb_root_path = './../';
require($phpbb_root_path . 'extension.inc');
$no_page_header = (!empty($cancel)) ? TRUE : FALSE;
require('./pagestart.' . $phpEx);
include($phpbb_root_path . 'language/lang_' . $board_config['default_lang'] . '/lang_spamwords_admin.' . $phpEx);

$confirm = (isset($HTTP_POST_VARS['confirm'])) ? TRUE : FALSE;
$cancel = (isset($HTTP_POST_VARS['cancel'])) ? TRUE : FALSE;
$delete = (isset($HTTP_POST_VARS['delete'])) ? TRUE : FALSE;
$start = (isset($HTTP_GET_VARS['start'])) ? intval($HTTP_GET_VARS['start']) : 0;

if (isset($HTTP_GET_VARS['mode']) || isset($HTTP_POST_VARS['mode']))
{
	$mode = (isset($HTTP_POST_VARS['mode'])) ? htmlspecialchars($HTTP_POST_VARS['mode']) : htmlspecialchars($HTTP_GET_VARS['mode']);
}
else
{
	$mode = 'log_time';
}

if(isset($HTTP_POST_VARS['order']))
{
	$sort_order = ($HTTP_POST_VARS['order'] == 'ASC') ? 'ASC' : 'DESC';
}
else if(isset($HTTP_GET_VARS['order']))
{
	$sort_order = ($HTTP_GET_VARS['order'] == 'ASC') ? 'ASC' : 'DESC';
}
else
{
	$sort_order = 'DESC';
}

//
// Sort method
//
$mode_types_text = array($lang['Username'], $lang['Subject'], $lang['Message'], $lang['Flagged'], $lang['Time'], $lang['IP'], $lang['Browser']);
$mode_types = array('log_username', 'log_subject', 'log_message', 'log_flagged','log_time', 'log_ip', 'log_browser');

$select_sort_mode = '<select name="mode">';
for($i = 0; $i < count($mode_types_text); $i++)
{
	$selected = ($mode == $mode_types[$i]) ? ' selected="selected"' : '';
	$select_sort_mode .= '<option value="' . $mode_types[$i] . '"' . $selected . '>' . $mode_types_text[$i] . '</option>';
}
$select_sort_mode .= '</select>';

$select_sort_order = '<select name="order">';
if($sort_order == 'ASC')
{
	$select_sort_order .= '<option value="ASC" selected="selected">' . $lang['Sort_Ascending'] . '</option><option value="DESC">' . $lang['Sort_Descending'] . '</option>';
}
else
{
	$select_sort_order .= '<option value="ASC">' . $lang['Sort_Ascending'] . '</option><option value="DESC" selected="selected">' . $lang['Sort_Descending'] . '</option>';
}
$select_sort_order .= '</select>';

$template->set_filenames(array(
'body' => 'admin/spamwords_log_body.tpl')
);

if ($delete)
{
	if(!$confirm)
	{
		$hidden_fields = '<input type="hidden" name="delete" value="delete" /><input type="hidden" name="cancel" value="cancel" />';

		$template->set_filenames(array(
		'confirm' => 'confirm_body.tpl')
		);

		$template->assign_vars(array(
			'MESSAGE_TITLE' => $lang['Confirm'],
			'MESSAGE_TEXT' => $lang['Confirm_delete_log'],
			'L_YES' => $lang['Yes'],
			'L_NO' => $lang['No'],

			'S_CONFIRM_ACTION' => append_sid("admin_spamwords_log.$phpEx"),
			'S_HIDDEN_FIELDS' => $hidden_fields)
		);

		if ($cancel)
		{
			redirect('admin/' . append_sid("admin_spamwords_log.$phpEx", true));
		}

		$template->pparse('confirm');
	}
	else
	{

		$sql = "DELETE FROM " . SPAM_WORDS_LOG_TABLE;
		if (!$db->sql_query($sql))
		{
			message_die(GENERAL_ERROR, 'Could not delete log entries', '', __LINE__, __FILE__, $sql);
		}

		$message = $lang['Log_emptied'] . "<br /><br />" . sprintf($lang['Click_return_spamwords_log'], "<a href=\"" . append_sid("admin_spamwords_log.$phpEx") . "\">", "</a>") . "<br /><br />" . sprintf($lang['Click_return_admin_index'], "<a href=\"" . append_sid("index.$phpEx?pane=right") . "\">", "</a>");
		message_die(GENERAL_MESSAGE, $message);

	}
	exit;
}

$template->assign_vars(array(
	'L_SELECT_SORT_METHOD' => $lang['Select_sort_method'],
	'L_ORDER' => $lang['Order'],
	'L_SORT' => $lang['Sort'],
	'L_SUBMIT' => $lang['Sort'],
	'L_DELETE' => $lang['Delete'],
	'L_LOG' => $lang['Log'],
	'L_LOG_EXPLAIN' => $lang['Log_explain'],
	'L_BROWSER' => $lang['Browser'],
	'L_SUBJECT' => $lang['Subject'],
	'L_FLAGGED' => $lang['Flagged'],
	'L_TIME' => $lang['Time'],
	'L_IP' => $lang['IP'],
	'L_USER' => $lang['Username'],
	'L_MESSAGE' => $lang['Message'],

	'S_MODE_SELECT' => $select_sort_mode,
	'S_ORDER_SELECT' => $select_sort_order,
	'S_MODE_ACTION' => append_sid("admin_spamwords_log.$phpEx"))
);

switch($mode)
{
	case 'log_username':
		$order_by = "log_username $sort_order LIMIT $start, " . $board_config['topics_per_page'];
		break;

	case 'log_subject':
		$order_by = "log_subject $sort_order LIMIT $start, " . $board_config['topics_per_page'];
		break;

	case 'log_message':
		$order_by = "log_message $sort_order LIMIT $start, " . $board_config['topics_per_page'];
		break;

	case 'log_flagged':
		$order_by = "log_flagged $sort_order LIMIT $start, " . $board_config['topics_per_page'];
		break;

	case 'log_timestamp':
		$order_by = "log_timestamp $sort_order LIMIT $start, " . $board_config['topics_per_page'];
		break;

	case 'log_ip':
		$order_by = "log_ip $sort_order LIMIT $start, " . $board_config['topics_per_page'];
		break;

	case 'log_browser':
		$order_by = "log_browser $sort_order LIMIT $start, " . $board_config['topics_per_page'];
		break;

	case 'log_action':
		$order_by = "log_action $sort_order LIMIT $start, " . $board_config['topics_per_page'];
		break;

	default:
		$order_by = "log_id $sort_order LIMIT $start, " . $board_config['topics_per_page'];
		break;
}

/**
 * Obtain list of spam words for highlighting in log entries
 */
$sql = "SELECT spam_word
FROM  " . SPAM_WORDS_TABLE;

if(!($result = $db->sql_query($sql)))
{
	message_die(GENERAL_ERROR, 'Could not get spam words from database', '', __LINE__, __FILE__, $sql);
}

$spamwords = array();
while ($row = $db->sql_fetchrow($result))
{
	$spamwords[] = $row['spam_word'];
}

/**
 * Obtain logged posts information
 */
$sql = "SELECT *
		FROM " . SPAM_WORDS_LOG_TABLE . "
		ORDER BY $order_by";
if (!$result = $db->sql_query($sql))
{
	message_die(GENERAL_ERROR, 'Could not query log information', '', __LINE__, __FILE__, $sql);
}
$log_count = $db->sql_numrows($result);
$log_row = array();
$log_row = $db->sql_fetchrowset($result);

for ($i = 0; $i < $log_count; $i++)
{
	$message = $log_row[$i]['log_message'];
	$message = preg_replace("/\[.*?:$bbcode_uid:?.*?\]/si", '', $message);
	$message = preg_replace('/\[url\]|\[\/url\]/si', '', $message);

	/**
	 * Split the message into single words and highlight the offending words
	 */
	$single_words = explode(' ', $message);
	$words = '';
	for ($j = 0; $j < count($single_words); $j++)
	{
		$words .= (in_array($single_words[$j], $spamwords)) ? '<span style="color: red; font-weight: bold;">' . $single_words[$j] . '</span>' : $single_words[$j];
		$words .= ' ';
	}

	$message = $words;
	$row_color = (!($i % 2)) ? $theme['td_color1'] : $theme['td_color2'];
	$row_class = (!($i % 2)) ? $theme['td_class1'] : $theme['td_class2'];
	$flagged = ($log_row[$i]['log_flagged']) ? $lang['Yes'] : $lang['No'];

	$template->assign_block_vars('log_row', array(
		'USER' => $log_row[$i]['log_username'],
		'MESSAGE' => $message,
		'SUBJECT' => $log_row[$i]['log_subject'],
		'IP' => '<a href="http://www.dnsstuff.com/tools/whois.ch?ip="' . $log_row[$i]['log_ip'] . '" />' . $log_row[$i]['log_ip'] . '</a>',
		'TIME' => create_date($board_config['default_dateformat'], $log_row[$i]['log_timestamp'], $board_config['board_timezone']),
		'BROWSER' => $log_row[$i]['log_browser'],
		'FLAGGED' => $flagged,
		'ROW_NUMBER' => $i + ($start + 1),
		'ROW_COLOR' => '#' . $row_color,
		'ROW_CLASS' => $row_class
		)
	);
}

// No action yet
if ($log_count == 0)
{
	$template->assign_block_vars('no_log', array(
	'L_NO_LOG' => $lang['No_log'])
	);
}

$sql = "SELECT count(*) AS total
		FROM " . SPAM_WORDS_LOG_TABLE;
if (!($result = $db->sql_query($sql)))
{
	message_die(GENERAL_ERROR, 'Error getting total log entries', '', __LINE__, __FILE__, $sql);
}

if ($total = $db->sql_fetchrow($result))
{
	$total_log_entries = $total['total'];
	$pagination = generate_pagination("admin_spamwords_log.$phpEx?mode=$mode&amp;order=$sort_order", $total_log_entries, $board_config['topics_per_page'], $start). '&nbsp;';
}

$template->assign_vars(array(
	'PAGINATION' => $pagination,
	'PAGE_NUMBER' => sprintf($lang['Page_of'], (floor($start / $board_config['topics_per_page']) + 1), ceil($total_log_entries / $board_config['topics_per_page'])),
	'L_GOTO_PAGE' => $lang['Goto_page'])
);

$template->pparse('body');

include($phpbb_root_path . 'includes/page_tail.'.$phpEx);

?>
