<?php
/**
 *           			admin_spamwords.php
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
	$module['Spam_words']['Manage_words'] = "$file";
	return;
}

//
// Load default header
//
$phpbb_root_path = './../';
require($phpbb_root_path . 'extension.inc');
require('./pagestart.' . $phpEx);
include($phpbb_root_path . 'language/lang_' . $board_config['default_lang'] . '/lang_spamwords_admin.' . $phpEx);


if(isset($HTTP_GET_VARS['mode']) || isset($HTTP_POST_VARS['mode']))
{
	$mode = ($HTTP_GET_VARS['mode']) ? $HTTP_GET_VARS['mode'] : $HTTP_POST_VARS['mode'];
	$mode = htmlspecialchars($mode);
}
else
{
	if(isset($HTTP_POST_VARS['add']))
	{
		$mode = 'add';
	}
	else if(isset($HTTP_POST_VARS['save']))
	{
		$mode = 'save';
	}
	else
	{
		$mode = '';
	}
}

if($mode != '')
{
	if($mode == 'edit' || $mode == 'add')
	{
		$word_id = (isset($HTTP_GET_VARS['id'])) ? intval($HTTP_GET_VARS['id']) : 0;

		$template->set_filenames(array(
		'body' => 'admin/spamwords_edit_body.tpl')
		);

		$s_hidden_fields = '';

		if($mode == 'edit')
		{
			if($word_id)
			{
				$sql = "SELECT *
					FROM " . SPAM_WORDS_TABLE . "
					WHERE word_id = $word_id";
				if(!$result = $db->sql_query($sql))
				{
					message_die(GENERAL_ERROR, "Could not query words table", 'Error', __LINE__, __FILE__, $sql);
				}

				$word_info = $db->sql_fetchrow($result);
				$s_hidden_fields .= '<input type="hidden" name="id" value="' . $word_id . '" />';
			}
			else
			{
				message_die(GENERAL_MESSAGE, $lang['No_word_selected']);
			}
		}

		$template->assign_vars(array(
		"WORD" => $word_info['spam_word'],
		'L_WORDS_TITLE' => $lang['Spam_words_title'],
		'L_WORDS_TEXT' => $lang['Spam_words_explain'],
		'L_WORD_CENSOR' => $lang['Edit_spamwords'],
		'L_WORD' => $lang['Spam_word'],
		'L_SUBMIT' => $lang['Submit'],

		'S_WORDS_ACTION' => append_sid("admin_spamwords.$phpEx"),
		'S_HIDDEN_FIELDS' => $s_hidden_fields)
		);
	}
	else if($mode == 'save')
	{
		$word_id = (isset($HTTP_POST_VARS['id'])) ? intval($HTTP_POST_VARS['id']) : 0;
		$word = (isset($HTTP_POST_VARS['word'])) ? trim($HTTP_POST_VARS['word']) : '';

		if($word == '')
		{
			message_die(GENERAL_MESSAGE, $lang['Must_enter_spamword']);
		}

		if($word_id)
		{
			$sql = "UPDATE " . SPAM_WORDS_TABLE . "
				SET spam_word = '" . str_replace("\'", "''", $word) . "'
				WHERE word_id = $word_id";
			$message = $lang['Spam_word_updated'];
		}
		else
		{
			$sql = "INSERT INTO " . SPAM_WORDS_TABLE . " (spam_word)
				VALUES ('" . str_replace("\'", "''", $word) . "')";
			$message = $lang['Spam_word_added'];
		}

		if(!$result = $db->sql_query($sql))
		{
			message_die(GENERAL_ERROR, 'Could not insert data into words table', $lang['Error'], __LINE__, __FILE__, $sql);
		}

		$message .= '<br /><br />' . sprintf($lang['Click_return_spamwordadmin'], "<a href=\"" . append_sid("admin_spamwords.$phpEx") . "\">", "</a>") . "<br /><br />" . sprintf($lang['Click_return_admin_index'], "<a href=\"" . append_sid("index.$phpEx?pane=right") . "\">", "</a>");
		message_die(GENERAL_MESSAGE, $message);

	}
	else if($mode == 'delete')
	{
		if(isset($HTTP_POST_VARS['id']) ||  isset($HTTP_GET_VARS['id']))
		{
			$word_id = (isset($HTTP_POST_VARS['id'])) ? $HTTP_POST_VARS['id'] : $HTTP_GET_VARS['id'];
			$word_id = intval($word_id);
		}
		else
		{
			$word_id = 0;
		}

		if($word_id)
		{
			$sql = "DELETE FROM " . SPAM_WORDS_TABLE . "
				WHERE word_id = $word_id";

			if(!$result = $db->sql_query($sql))
			{
				message_die(GENERAL_ERROR, 'Could not remove data from words table', $lang['Error'], __LINE__, __FILE__, $sql);
			}

			$message = $lang['Spam_word_removed'] . '<br /><br />' . sprintf($lang['Click_return_spamwordadmin'], "<a href=\"" . append_sid("admin_spamwords.$phpEx") . "\">", "</a>") . "<br /><br />" . sprintf($lang['Click_return_admin_index'], "<a href=\"" . append_sid("index.$phpEx?pane=right") . "\">", "</a>");

			message_die(GENERAL_MESSAGE, $message);
		}
		else
		{
			message_die(GENERAL_MESSAGE, $lang['No_word_selected']);
		}
	}
}
else
{
	$template->set_filenames(array(
	'body' => 'admin/spamwords_list_body.tpl')
	);

	$sql = "SELECT *
		FROM " . SPAM_WORDS_TABLE . "
		ORDER BY spam_word";
	if(!$result = $db->sql_query($sql))
	{
		message_die(GENERAL_ERROR, 'Could not query words table', $lang['Error'], __LINE__, __FILE__, $sql);
	}

	$word_rows = $db->sql_fetchrowset($result);
	$word_count = count($word_rows);

	$template->assign_vars(array(
	'L_WORDS_TITLE' => $lang['Spam_words_title'],
	'L_WORDS_TEXT' => $lang['Spam_words_explain'],
	'L_WORD' => $lang['Spam_word'],
	'L_EDIT' => $lang['Edit'],
	'L_DELETE' => $lang['Delete'],
	'L_ADD_WORD' => $lang['Add_new_word'],
	'L_ACTION' => $lang['Action'],

	'S_WORDS_ACTIO' => append_sid("admin_spamwords.$phpEx"),
	'S_HIDDEN_FIELDS' => '')
	);

	for($i = 0; $i < $word_count; $i++)
	{
		$word = $word_rows[$i]['spam_word'];
		$word_id = $word_rows[$i]['word_id'];

		$row_color = (!($i % 2)) ? $theme['td_color1'] : $theme['td_color2'];
		$row_class = (!($i % 2)) ? $theme['td_class1'] : $theme['td_class2'];

		$template->assign_block_vars("words", array(
		'ROW_COLOR' => "#" . $row_color,
		'ROW_CLASS' => $row_class,
		'WORD' => $word,

		'U_WORD_EDIT' => append_sid("admin_spamwords.$phpEx?mode=edit&amp;id=$word_id"),
		'U_WORD_DELETE' => append_sid("admin_spamwords.$phpEx?mode=delete&amp;id=$word_id"))
		);
	}
}

$template->pparse('body');

include('./page_footer_admin.'.$phpEx);

?>