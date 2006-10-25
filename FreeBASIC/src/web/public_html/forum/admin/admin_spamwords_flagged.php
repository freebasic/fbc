<?php
/**
 *           			admin_spamwords_flagged.php
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
	$module['Spam_words']['Flagged_posts'] = "$file";
	return;
}

$phpbb_root_path = './../';
require($phpbb_root_path . 'extension.inc');
require('./pagestart.' . $phpEx);
include($phpbb_root_path . 'language/lang_' . $board_config['default_lang'] . '/lang_spamwords_admin.' . $phpEx);
include($phpbb_root_path . 'includes/bbcode.'.$phpEx);

$start = (isset($HTTP_GET_VARS['start'])) ? intval($HTTP_GET_VARS['start']) : 0;

if(isset($HTTP_GET_VARS['mode']) || isset($HTTP_POST_VARS['mode']))
{
	$mode = ($HTTP_GET_VARS['mode']) ? $HTTP_GET_VARS['mode'] : $HTTP_POST_VARS['mode'];
	$mode = htmlspecialchars($mode);
}

$template->set_filenames(array(
	'body' => 'admin/spamwords_flagged_body.tpl')
);

$sql = "SELECT p.*, pt.*, u.user_id, u.username
	FROM " . POSTS_TABLE . " p, " . POSTS_TEXT_TABLE . " pt, " . USERS_TABLE . " u
	WHERE p.post_id = pt.post_id
	AND p.poster_id = u.user_id
	AND p.post_flagged = " . TRUE . "
	ORDER BY p.post_id DESC
	LIMIT " . $start . ", " . $board_config['topics_per_page'];
if(!($result = $db->sql_query($sql)))
{
	message_die(GENERAL_ERROR, 'Could not query posts', '', __LINE__, __FILE__, $sql);
}

$flagged_row = $db->sql_fetchrowset($result);
$row_count = count($flagged_row);

$template->assign_vars(array(
	'L_SUBJECT' => $lang['Subject'],
	'L_MESSAGE' => $lang['Message'],
	'L_USERNAME' => $lang['Username'],
	'L_TIME' => $lang['Time'],
	'L_ACTION' => $lang['Action'],
	'L_EDIT' => $lang['Edit'],
	'L_DELETE' => $lang['Delete'],
	'L_FLAGGED_POSTS' => $lang['Flagged_posts'],
	'L_FLAGGED_POSTS_EXPLAIN' => $lang['Flagged_posts_explain'],

	'S_FLAGGED_ACTION' => append_sid("admin_spamwords_flagged.$phpEx"),
	'S_HIDDEN_FIELDS' => '')
);


for ($i = 0; $i < $row_count; $i++)
{
	$bbcode_uid = $flagged_row[$i]['bbcode_uid'];
	$message = $flagged_row[$i]['post_text'];

	if ($bbcode_uid != '')
	{
		$message = ($board_config['allow_bbcode']) ? bbencode_second_pass($message, $bbcode_uid) : preg_replace("/\:$bbcode_uid/si", '', $message);
	}

	$row_color = (!($i % 2)) ? $theme['td_color1'] : $theme['td_color2'];
	$row_class = (!($i % 2)) ? $theme['td_class1'] : $theme['td_class2'];

	$poster = ($flagged_row[$i]['post_username'] && $flagged_row[$i]['user_id'] < 2) ? $flagged_row[$i]['post_username'] : (($flagged_row[$i]['user_id'] > 1) ? $flagged_row[$i]['username'] : $lang['Anonymous']);

	$template->assign_block_vars('flagged', array(
		'ROW_COLOR' => '#' . $row_color,
		'ROW_CLASS' => $row_class,
		'USERNAME' => $poster,
		'SUBJECT' => $flagged_row[$i]['post_subject'],
		'MESSAGE' => $message,
		'TIME' => create_date($board_config['default_dateformat'], $flagged_row[$i]['post_time'], $board_config['board_timezone']),
		'U_EDIT' => append_sid($phpbb_root_path . "posting.$phpEx?mode=editpost&amp;" . POST_POST_URL . "=" . $flagged_row[$i]['post_id']),
		'U_DELETE' => append_sid($phpbb_root_path . "posting.$phpEx?mode=delete&amp;" . POST_POST_URL . "=" . $flagged_row[$i]['post_id'] . "&amp;sid=" . $userdata['session_id']))
		);
}

//
// No flagged posts yet. Show a nice message...
//
if($row_count == 0)
{
	$template->assign_block_vars('no_flagged', array(
		'L_NO_FLAGGED_POSTS' => $lang['No_flagged_posts'])
	);
}

$sql = "SELECT count(*) AS total
   FROM " . POSTS_TABLE;

if (!($result = $db->sql_query($sql)))
{
	message_die(GENERAL_ERROR, 'Error getting total', '', __LINE__, __FILE__, $sql);
}

if ($total = $db->sql_fetchrow($result))
{
	$total_pag_items = $total['total'];
	$pagination = generate_pagination("admin_spamwords_flagged.$phpEx?$mode=$mode&order=$sort_order", $total_pag_items, $board_config['topics_per_page'], $start);
}

$template->assign_vars(array(
	'PAGINATION' => $pagination,
	'PAGE_NUMBER' => sprintf($lang['Page_of'], (floor($start / $board_config['topics_per_page']) + 1), ceil($total_pag_items / $board_config['topics_per_page']))
	)
);

$template->pparse('body');

include('./page_footer_admin.'.$phpEx);

?>