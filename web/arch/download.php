<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

require_once( "global.php" );

$kernel->clean_array( "_REQUEST", array( "id" => V_INT, "forced" => V_INT ) );

if( $kernel->vars['id'] == 0 )
{
	$kernel->page_function->message_report( $kernel->ld['lang_f_no_file_specified'], M_ERROR );
}
else
{
	// Read session cache info
  if( !empty( $kernel->session['session_hash'] ) AND USER_LOGGED_IN == true )
  {
  	$usergroupdata = $kernel->db->row( "SELECT g.usergroup_session_downloads, g.usergroup_session_baud FROM " . TABLE_PREFIX . "usergroups g LEFT JOIN " . TABLE_PREFIX . "users u ON ( g.usergroup_id = u.user_group_id ) WHERE u.user_id = '{$kernel->session['session_user_id']}'" );
  	
  	$cachedata = $kernel->db->row( "SELECT c.cache_user_id, c.cache_timestamp, c.cache_session_downloads, c.cache_session_bandwidth FROM " . TABLE_PREFIX . "session_cache c WHERE c.cache_session_hash = '{$kernel->session['session_hash']}' AND c.cache_user_id = '{$kernel->session['session_user_id']}'" );
  }
	
	// Download limit reached for the user
  if( $cachedata['cache_session_downloads'] >= $usergroupdata['usergroup_session_downloads'] AND $usergroupdata['usergroup_session_downloads'] != 0 )
  {
  	$kernel->page_function->message_report( sprintf( $kernel->ld['lang_f_download_limit_reached'], $kernel->format_seconds( ( $cachedata['cache_timestamp'] + 86400 ) - UNIX_TIME ) ), M_WARNING, HALT_EXEC );
  }
	
	$file = $kernel->db->row( "SELECT f.file_name, f.file_cat_id, f.file_downloads, f.file_dl_limit, f.file_doc_id, f.file_dl_url, f.file_size, f.file_disabled, f.file_hash_data FROM " . TABLE_PREFIX . "files f WHERE f.file_id = {$kernel->vars['id']} LIMIT 1" );
	
	// Set page vars
	$kernel->vars['page_struct']['system_page_navigation_id'] = $file['file_cat_id'];
	$kernel->vars['page_struct']['system_page_navigation_html'] = array( "file.php?id={$id}" => sprintf( $kernel->ld['lang_f_downloading_file'], $file['file_name'] ) );
	$kernel->vars['page_struct']['system_page_action_title'] = sprintf( $kernel->ld['lang_f_page_title_download'], $file['file_name'] );
	
	// Check category permissions
	$kernel->page_function->read_category_permissions( $kernel->vars['id'], SCRIPT_PATH );
	
	// File disabled?
	if( $file['file_disabled'] == 1 )
	{
		$kernel->page_function->message_report( $kernel->ld['lang_f_file_status_disabled'], M_ERROR, HALT_EXEC );
	}
  
  // User has permission to download?
  if( $kernel->session_function->read_permission_flag( 2, true ) == true )
  {
  	if( $file['file_dl_limit'] > 0 AND $file['file_downloads'] >= $file['file_dl_limit'] )
  	{
  		$kernel->page_function->message_report( $kernel->ld['lang_f_download_limit'], M_ERROR, HALT_EXEC );
  	}
  	
  	// Check for leeching
  	$leech_flag = $kernel->config['session_anti_leech_mode'];
  	
  	$kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "sites`" );
  	
  	while( $site = $kernel->db->data() )
  	{
  		if( strstr( SCRIPT_PATH, $site['site_name'] ) == true ) $leech_flag = ( $kernel->config['session_anti_leech_mode'] == 1 ) ? 0 : 1;
  	}
  	
  	if( strstr( SCRIPT_PATH, str_replace( "www.", "", $_SERVER['HTTP_HOST'] ) ) == true ) $leech_flag = 1;
  	
  	if( $leech_flag == 0 )
  	{
  		$kernel->db->insert( "logs", array( "log_type" => 2, "log_file_id" => $kernel->vars['id'], "log_user_id" => $kernel->session['session_user_id'], "log_mirror_id" => 0, "log_user_agent" => HTTP_AGENT, "log_timestamp" => UNIX_TIME, "log_ip_address" => IP_ADDRESS ) );
  		
  		$kernel->page_function->message_report( $kernel->ld['lang_f_no_leeching'], M_WARNING, HALT_EXEC );
  	}
  	
  	$category_doc_id = $kernel->db->item( "SELECT `category_doc_id` FROM " . TABLE_PREFIX . "categories WHERE category_id = {$file['file_cat_id']}" );
  	
  	// File document exists, has not been agreed to
  	if( !isset( $_SESSION['document_agree'] ) AND $file['file_doc_id'] > 0 )
  	{
  		header( "Location: document.php?id=" . $file['file_doc_id'] . "&file_id=" . $kernel->vars['id'] . "" );
  		exit;
  	}
  	
  	// Category document exists, has not been agreed to
  	if( !isset( $_SESSION['document_agree'] ) AND $category_doc_id > 0 )
  	{
  		header( "Location: document.php?id=" . $category_doc_id . "&file_id=" . $kernel->vars['id'] . "" );
  		exit;
  	}
  	
  	// Mirrors available, none selected
  	if( $kernel->db->numrows( "SELECT `mirror_id` FROM `" . TABLE_PREFIX . "mirrors` WHERE `mirror_file_id` = " . $kernel->vars['id'] . "" ) > 0 AND $kernel->vars['forced'] != 1 )
  	{
  		header( "Location: mirror.php?file_id=" . $kernel->vars['id'] . "" );
  		exit;
  	}
  	
		// Increment download counter
		$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "files` SET `file_downloads` = `file_downloads` + 1 WHERE `file_id` = " . $kernel->vars['id'] . "" );
		
		// Add to download log
		$kernel->db->insert( "logs", array( "log_type" => 1, "log_file_id" => $kernel->vars['id'], "log_user_id" => $kernel->session['session_user_id'], "log_mirror_id" => 0, "log_user_agent" => HTTP_AGENT, "log_timestamp" => UNIX_TIME, "log_ip_address" => IP_ADDRESS ) );
		
		// Update session cache info
		if( !empty( $kernel->session['session_hash'] ) AND USER_LOGGED_IN == true )
		{
			$kernel->db->update( "session_cache", array( "cache_session_downloads" => $cachedata['cache_session_downloads'] + 1, "cache_session_bandwidth" => $cachedata['cache_session_bandwidth'] + $file['file_size'] ), "WHERE `cache_user_id` = " . $kernel->session['session_user_id'] . "" );
			
			$user = $kernel->db->row( "SELECT `user_downloads`, `user_bandwidth` FROM `" . TABLE_PREFIX . "users` WHERE `user_id` = '{$kernel->session['session_user_id']}'" );
			
			$kernel->db->update( "users", array( "user_downloads" => $user['user_downloads'] + 1, "user_bandwidth" => $user['user_bandwidth'] + $file['file_size'] ), "WHERE `user_id` = '{$kernel->session['session_user_id']}'" );
		}
		
		// Start file download
		$kernel->archive_function->exec_file_download( array( "name" => $file['file_name'], "url" => $file['file_dl_url'], "timestamp" => $file['file_timestamp'], "size" => $file['file_size'], "id" => $kernel->vars['id'], "mirror_id" => 0, "hash" => $file['file_hash_data'] ), $usergroupdata['usergroup_session_baud'] );
  }
}

$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );

?>