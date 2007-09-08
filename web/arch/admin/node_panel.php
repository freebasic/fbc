<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$size = $file_count = $dir_count = $current_group_id = 0;

//------------------------------------------
// Update Notes
//------------------------------------------

if( $kernel->vars['action'] == "update" )
{
	$kernel->db->update( "datastore", array( "datastore_value" => $kernel->format_input( $_POST['notepad_data'], T_FORM ) ), "WHERE `datastore_key` = 'note_pad'" );
}

//------------------------------------------
# Check MySQL Search compatibility mode
//------------------------------------------

$mysql_version = $kernel->db->item( "SELECT VERSION()" );

$version = explode( ".", $mysql_version );
$mysql_patch = explode( "-", $version[2] ); $version[2] = $mysql_patch[0];

if( $version[0] >= 4 AND $version[1] >= 0 AND $version[2] >= 1 AND $kernel->config['archive_search_mode'] == "0" ) //>= 4.0.1
{
	$kernel->page_function->message_report( $kernel->ld['lang_b_mysql_boolean_compatible'], M_NOTICE );
}

if( $version[0] < 4 AND $version[1] < 0 AND $version[2] < 1 AND $kernel->config['archive_search_mode'] == "1" ) //< 4.0.1
{
	$kernel->page_function->message_report( $kernel->ld['lang_b_mysql_not_boolean_compatible'], M_WARNING );
}

//------------------------------------------
# Archive notices
//------------------------------------------

$limited_files = $kernel->db->numrows( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files` WHERE ( `file_downloads` >= `file_dl_limit` ) AND `file_dl_limit` != 0" );
$broken_files = $kernel->db->item( "SELECT COUNT(*) FROM `" . TABLE_PREFIX . "logs` WHERE `log_type` = 3 AND `log_flag_done` = '0'" );
$modified_files = $kernel->db->item( "SELECT COUNT(*) FROM `" . TABLE_PREFIX . "logs` WHERE `log_type` = 4 AND `log_flag_done` = '0'" );

if( $limited_files > 0 )
{
	$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_files_reached_dl_limit'], $limited_files, "?hash={$kernel->session['hash']}&node=archive_report&action=view&group_type=1&report_id=7" ), M_ALERT );
}

if( $broken_files > 0 )
{
	$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_files_alert_broken_files'], $broken_files, "?hash={$kernel->session['hash']}&node=archive_log&action=view&group_type=3&allnoflag=1" ), M_WARNING );
}

if( $modified_files > 0 )
{
	$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_files_alert_modified_files'], $modified_files, "?hash={$kernel->session['hash']}&node=archive_log&action=view&group_type=4&allnoflag=1" ), M_ALERT );
}

if( @ini_get( "allow_url_fopen" ) == 0 )
{
	$kernel->page_function->message_report( "PHP fopen() Wrapper functions have been disabled on this server.", M_WARNING );
}

$kernel->tp->call( "admin_panel" );

//------------------------------------------
# Notepad
//------------------------------------------

$kernel->tp->cache( "notepad_data", $kernel->db->item( "SELECT `datastore_value` FROM `" . TABLE_PREFIX . "datastore` WHERE `datastore_key` = 'note_pad'" ) );

//------------------------------------------
# Statistics
//------------------------------------------

$kernel->db->query( "SHOW TABLE STATUS" );
while( $dbdata = $kernel->db->data() )
{
	$configdata['total_dbsize'] += $dbdata['Data_length'];
	$configdata['total_dbsize'] += $dbdata['Index_length'];
}

$total_files = $kernel->format_input( $kernel->db->item( "SELECT `datastore_value` FROM `" . TABLE_PREFIX . "datastore` WHERE `datastore_key` = 'count_total_files'" ), T_NUM );
$total_submissions = $kernel->format_input( $kernel->db->item( "SELECT `datastore_value` FROM `" . TABLE_PREFIX . "datastore` WHERE `datastore_key` = 'count_total_submissions'" ), T_NUM );

$configdata['total_files'] = "{$total_files} <b>[<a style=\"color: #40596A;\" title=\"{$kernel->ld['lang_b_menu_title_submissions']}\" href=\"?hash={$kernel->session['hash']}&node=file_sub_manage\">{$total_submissions}</a>]</b>";
$configdata['total_comments'] = $kernel->format_input( $kernel->db->item( "SELECT `datastore_value` FROM `" . TABLE_PREFIX . "datastore` WHERE `datastore_key` = 'count_total_comments'" ), T_NUM );
$configdata['total_downloads'] = $kernel->format_input( $kernel->db->item( "SELECT `datastore_value` FROM `" . TABLE_PREFIX . "datastore` WHERE `datastore_key` = 'count_total_downloads'" ), T_NUM );
$configdata['total_data'] = $kernel->archive_function->format_round_bytes( $kernel->db->item( "SELECT `datastore_value` FROM `" . TABLE_PREFIX . "datastore` WHERE `datastore_key` = 'count_total_data'" ) );
$configdata['total_views'] = $kernel->format_input( $kernel->db->item( "SELECT `datastore_value` FROM `" . TABLE_PREFIX . "datastore` WHERE `datastore_key` = 'count_total_views'" ), T_NUM );

//------------------------------------------
# Server Info
//------------------------------------------

$configdata['phpversion'] = phpversion() . " <b>[<a style=\"color: #40596A;\" href=\"?hash={$kernel->session['hash']}&node=phpinfo\">{$kernel->ld['lang_b_info']}</a>]</b>";
$configdata['sqlversion'] = $mysql_version;

$configdata['maxuploadsize'] = $kernel->archive_function->format_round_bytes( MAX_UPLOAD_SIZE );
$configdata['maxpostsize'] = $kernel->archive_function->format_round_bytes( ( 1024 * intval( ini_get( "post_max_size" ) ) * 1024 ) );
$configdata['total_dbsize'] = $kernel->archive_function->format_round_bytes( $configdata['total_dbsize'] );

$upload_folderinfo = $kernel->admin_function->read_directory_size( $kernel->config['system_root_dir_upload'] );
$configdata['total_uploadsize'] = $kernel->archive_function->format_round_bytes( $upload_folderinfo[0] ) . " <i>(" . sprintf( $kernel->ld['lang_b_x_files'], $kernel->format_input( $upload_folderinfo[1], T_NUM ) ) . ", " . $kernel->format_input( $upload_folderinfo[2], T_NUM ) . " folders)</i>";

$kernel->tp->cache( $configdata );

//------------------------------------------
# Active admins
//------------------------------------------

$get_session_entries = $kernel->db->query( "SELECT s.adminsession_user_id, s.adminsession_name, s.adminsession_group_id, s.adminsession_timestamp, s.adminsession_run_timestamp FROM " . TABLE_PREFIX . "sessions_admin s ORDER BY s.adminsession_group_id, s.adminsession_name" );

$kernel->vars['html']['controlpanel_sessions'] = $kernel->tp->call( "admin_session_header", CALL_TO_PAGE );

while( $session = $kernel->db->data( $get_session_entries ) )
{
	if( $session['adminsession_group_id'] != $current_group_id AND $current_group_id > 0 )
	{
		$kernel->vars['html']['controlpanel_sessions'] .= $kernel->tp->call( "admin_session_break", CALL_TO_PAGE );
	}
	$current_group_id = $session['adminsession_group_id'];
	
	$kernel->vars['html']['controlpanel_sessions'] .= $kernel->tp->call( "admin_session_row", CALL_TO_PAGE );
	
	if( $session['adminsession_group_id'] == 1 )
	{
		$session['adminsession_group_id'] = $kernel->admin_function->construct_icon( "user_admin.gif", $kernel->ld['lang_b_administrator'], true, "center" );
	}
	else
	{
		$session['adminsession_group_id'] = $kernel->admin_function->construct_icon( "user_mod.gif", $kernel->ld['lang_b_moderator'], true, "center" );
	}
	
	if( $session['adminsession_user_id'] == $kernel->session['adminsession_user_id'] )
	{
		$session['adminsession_name'] = "<b>{$session['adminsession_name']}</b>";
	}
	
	$session['adminsession_timestamp'] = $kernel->format_seconds( UNIX_TIME - $session['adminsession_timestamp'] );
	$session['adminsession_run_timestamp'] = $kernel->format_seconds( UNIX_TIME - $session['adminsession_run_timestamp'] );
	$session['adminsession_timestamp'] = sprintf( $kernel->ld['lang_b_time_ago'], $session['adminsession_timestamp'] );
	$session['adminsession_name'] = $kernel->format_input( $session['adminsession_name'], T_HTML );
	$session['adminsession_run_timestamp'] = sprintf( $kernel->ld['lang_b_time_ago'], $session['adminsession_run_timestamp'] );
	
	$kernel->vars['html']['controlpanel_sessions'] = $kernel->tp->cache( $session, 0, $kernel->vars['html']['controlpanel_sessions'] );
}

$kernel->vars['html']['controlpanel_sessions'] .= $kernel->tp->call( "admin_session_footer", CALL_TO_PAGE );

//------------------------------------------
# Last 10 log entries
//------------------------------------------

$get_log_entries = $kernel->db->query( "SELECT l.* FROM " . TABLE_PREFIX . "logs_admin l ORDER BY l.log_id DESC LIMIT 5" );

$kernel->vars['html']['controlpanel_logs'] = "";

if( $kernel->db->numrows() > 0 )
{
	$kernel->vars['html']['controlpanel_logs'] .= $kernel->tp->call( "admin_panel_log_header", CALL_TO_PAGE );

	while( $log = $kernel->db->data( $get_log_entries ) )
	{
		$kernel->vars['html']['controlpanel_logs'] .= $kernel->tp->call( "admin_panel_log_row", CALL_TO_PAGE );
		
		$log['log_timestamp'] = $kernel->fetch_time( $log['log_timestamp'], DF_LONG );
		$log['log_phrase'] = sprintf( $kernel->ld[ $log['log_phrase'] ], $log['log_reference'] );
		$log['log_node'] = isset( $node_array[ $log['log_node'] ] ) ? $node_array[ $log['log_node'] ] : $log['log_node'];
		
		if( $log['log_user_id'] == 0 )
		{
			$log['log_author'] = $kernel->ld['lang_b_guest'];
		}
		else
		{
			$log['log_author'] = $kernel->db->item( "SELECT `user_name` FROM `" . TABLE_PREFIX . "users` WHERE `user_id` = " . $log['log_user_id'] . "" );
		}
		
		if( $kernel->session['adminsession_group_id'] != 1 AND $log['log_user_id'] != $kernel->session['adminsession_user_id'] )
		{
			$log['log_ip_address'] = "0.0.0.0";
		}
		
		$kernel->vars['html']['controlpanel_logs'] = $kernel->tp->cache( $log, 0, $kernel->vars['html']['controlpanel_logs'] );
	}
	
	$kernel->vars['html']['controlpanel_logs'] .= $kernel->tp->call( "admin_panel_log_footer", CALL_TO_PAGE );
}

?>

