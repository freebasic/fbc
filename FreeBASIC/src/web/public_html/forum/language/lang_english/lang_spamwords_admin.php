<?php
/**
 *           			lang_spamwords_admin.php [English]
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

//
// Manage spam words
//
$lang['Spam_words_title'] = 'Spam Words';
$lang['Spam_words_explain'] = 'From this control panel you can add, edit, and remove spam words. Wildcards (*) are accepted in the word field. For example, *test* will match detestable, test* would match testing, *test would match detest. In the spam words configuration panel you can determine how the offending posts should be dealt with.';
$lang['Spam_word'] = 'Word';
$lang['Edit_spamwords'] = 'Edit spam words';
$lang['Add_new_word'] = 'Add new word';
$lang['Update_word'] = 'Update word censor';
$lang['Must_enter_spamword'] = 'You must enter a word';
$lang['Spam_word_updated'] = 'The selected spam word has been successfully updated';
$lang['Spam_word_added'] = 'The spam word has been successfully added';
$lang['Spam_word_removed'] = 'The selected spam word has been successfully removed';

//
// Configuration
//
$lang['Spam_config'] = 'Spam words configuration';
$lang['Spam_config_explain'] = 'In this control panel you can configure how posts that contain defined spam words are dealt with.';
$lang['General_spam_settings'] = 'General spam words settings';
$lang['Disable_mod'] = 'Disable Spam words filter';
$lang['Disable_mod_explain'] = 'If - for whatever reason - you need to bypass this MOD, then set this to "Yes".';
$lang['Spam_config_updated'] = 'Spam words configuration updated';
$lang['Flag_posts'] = 'Flag and hide posts';
$lang['Error_message'] = 'Error Message';
$lang['Handle_spam'] = 'How should posts that contain spam words be dealt with?';
$lang['Handle_spam_explain'] = 'Choose "Flag Posts" if you want to let the messages pass through the spam words filter. The posts will then be flagged as containing spam words, and will be hidden until either deleted or edited by Admin. If you don\'t want to let posts that contain spam words pass through the filter, then choose "Error Message". The posts will then be greeted with an error message that you can set below.';
$lang['Warn_user_pm'] = 'Send a PM to user to warn them when they submit a post that contains a spam word';
$lang['Exceptions'] = 'Exceptions';
$lang['Exceptions_explain'] = 'You can set exceptions for privileged members here. The members who meet these criteria will be permitted to post spam words.';
$lang['Allow_admin'] = 'Allow admin to post spam words';
$lang['Allow_mod'] = 'Allow moderators to post spam words';
$lang['Allow_reg'] = 'Allow registered members to post spam words';
$lang['User_post_count'] = 'Users that have posted more than this number of posts (set value to "0" to deactivate this function)';
$lang['Offenses'] = 'Number of offenses before user is automatically banned (Admins can\'t be banned)';
$lang['Offenses_explain'] = 'Every time a user posts a spam word the offense will be registered. Here you can set how many offenses you want to allow before a user is automatically banned. Set the value to "0" if you want to disable this function.';
$lang['Error_messages'] = 'Error Messages';
$lang['Error_messages_explain'] = 'If you choose to show error messages instead of flagging and hiding posts, you can configure the error messages here (max. 255 characters).';
$lang['Error_text'] = 'This is the error message that a user will see when they post a spam word';
$lang['Error_sig'] = 'This is the error message that a user will see when they make a post and they have a spam word in their signature';
$lang['PM_messages'] = 'Private message warning settings';
$lang['PM_messages_explain'] = 'Here you can define the text to PM your users if you choose to warn them via PM when they posts a spam word (max. 255 characters).';
$lang['PM_message'] = 'Private message text';
$lang['PM_subject'] = 'Private message subject';
$lang['Ban_ip'] = 'Ban IP as well?';
$lang['Flagged'] = 'Flagged';
$lang['Current_words'] = 'Currently activated spam words';
$lang['More_words'] = 'Click <b>%sHere%s</b> to add spam words.';
$lang['No_words'] = 'No spam words activated yet.';

//
// Log
//
$lang['Log'] = 'Spam words log';
$lang['Log_explain'] = 'This is the spam words log. It contains a record of all offenses committed. Some posts may have been deleted or edited in the meantime.';
$lang['No_log'] = 'No entries in log yet';
$lang['Browser'] = 'User Agent';
$lang['IP'] = 'User IP';
$lang['Confirm'] = 'Confirm';
$lang['Confirm_delete_log'] = 'Are you sure you want to delete the spam words log?';
$lang['Log_emptied'] = 'Spam words log succesfully deleted';

//
// Flagged Posts
//
$lang['Flagged_posts'] = 'Flagged posts';
$lang['Flagged_posts_explain'] = 'These posts have been flagged. That means that they are hidden and can not be viewed in your forum. Here you can view, edit, or delete them.';
$lang['Anonymous'] = 'Anonymous';
$lang['No_flagged_posts'] = 'No flagged posts.';

//
// Clicky, clicky
//
$lang['Click_return_spamwordadmin'] = 'Click %sHere%s to return to Spam Word Administration';
$lang['Click_return_spam_config'] = 'Click %sHere%s to return to Spam Word Configuration';
$lang['Click_return_spamwords_log'] = 'Click %sHere%s to return to Spam Word Log';
$lang['Click_return_spamwords_flagged'] = 'Click %sHere%s to return to Flagged spam words';

//
// That's all Folks!
// -------------------------------------------------

?>
