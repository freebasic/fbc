<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

require_once( "global.php" );

$kernel->clean_array( "_REQUEST", array( "id" => V_INT, "voted" => V_BOOL, "posted" => V_BOOL ) );

//No ID ref
if( $kernel->vars['id'] == 0 )
{
	$kernel->page_function->message_report( $kernel->ld['lang_f_no_file_specified'], M_ERROR );
}
else
{
	$get_file = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$kernel->vars['id']}" );
	
	//Invalid ID ref
	if( $kernel->db->numrows() == 0 )
	{
		$kernel->page_function->message_report( $kernel->ld['lang_f_file_no_exists'], M_ERROR );
	}
	else
	{
		//Skip the small talk, get down to business!
  	if( $kernel->config['display_file_list_mode'] == 1 )
  	{
  		header( "Location: download.php?id={$kernel->vars['id']}" );
  		exit;
  	}
  	
  	$file = $kernel->db->data( $get_file );
  	
		//Setup page vars
  	$kernel->vars['page_struct']['system_page_action_title'] = sprintf( $kernel->ld['lang_f_page_title_file'], $file['file_name'] );
  	$kernel->vars['page_struct']['system_page_navigation_id'] = $file['file_cat_id'];
  	$kernel->vars['page_struct']['system_page_navigation_html'] = array( SCRIPT_PATH => $file['file_name'] );
  	
		//Check category permissions
  	$kernel->page_function->read_category_permissions( $file['file_cat_id'], SCRIPT_PATH );
  	
		//File disabled
		if( $file['file_disabled'] == 1 )
		{
  		$kernel->page_function->message_report( $kernel->ld['lang_f_file_status_disabled'], M_NOTICE );
		}
		else
		{
			//Submitted vote notice
		  if( $kernel->vars['voted'] == true )
		  {
		  	$kernel->page_function->message_report( $kernel->ld['lang_f_vote_submitted'], M_NOTICE );
		  }
		  
			//Submitted comment notice
		  if( $kernel->vars['posted'] == true )
		  {
		  	$kernel->page_function->message_report( $kernel->ld['lang_f_comment_submitted'], M_NOTICE );
		  }
		  
			//Increment file views counter
		  $kernel->db->query( "UPDATE `" . TABLE_PREFIX . "files` SET `file_views` = file_views + 1 WHERE `file_id` = {$kernel->vars['id']}" );
			
		  $kernel->tp->call( "file_view" );
  		
			//Get URL file info
  		$file_info = $kernel->archive_function->file_url_info( $file['file_dl_url'] );
			
			//Setup file page data
			$kernel->archive_function->construct_download_counters( $file['file_size'] );
			
			//Setup file hashes
			$kernel->archive_function->construct_file_hash_fields( $file['file_hash_data'] );
			
		  $file['file_size'] = $kernel->archive_function->format_round_bytes( $file['file_size'] );
		  $file['file_rank'] = $kernel->archive_function->construct_file_rating( $file['file_rating'], $file['file_votes'] );
			
		  $file['file_type'] = $file_info['file_type'];
		  $file['file_timestamp'] = $kernel->fetch_time( $file['file_timestamp'], DF_LONG );
		  $file['file_downloads'] = $kernel->format_input( $file['file_downloads'], T_NUM );
		  $file['file_votes'] = $kernel->format_input( $file['file_votes'], T_NUM );
		  $file['file_name'] = $kernel->format_input( $file['file_name'], T_HTML );
		  $file['file_html_author'] = $kernel->format_input( $file['file_author'], T_URL_ENC );
		  $file['file_views'] = $kernel->format_input( $file['file_views'], T_NUM );
			
		  if( empty( $file['file_description'] ) )
		  {
		  	$file['file_description'] = $kernel->ld['lang_f_no_file_description'];
		  }
			
		  $kernel->ld['lang_f_sent_rankvotes'] = sprintf( $kernel->ld['lang_f_sent_rankvotes'], $file['file_votes'] );
			
			//Setup custom fields and file data
		  $file['file_custom_fields'] = "";
  		
			$get_fields = $kernel->db->query( "SELECT `field_id`, `field_name` FROM `" . TABLE_PREFIX . "fields` WHERE `field_file_display` = 1 ORDER BY `field_name`" );
			
			if( $kernel->db->numrows() > 0 )
			{
				while( $field = $kernel->db->data( $get_fields ) )
				{
					$field_data = $kernel->db->row( "SELECT `field_file_data` FROM `" . TABLE_PREFIX . "fields_data` WHERE `field_id` = {$field['field_id']} AND `field_file_id` = {$kernel->vars['id']}" );
					
					if( $kernel->config['archive_show_empty_custom_fields'] == 0 AND empty( $field_data['field_file_data'] ) ) continue;
					
					if( !empty( $field_data['field_file_data'] ) )
					{
						$fielddata['field_file_data'] = $kernel->format_input( $field_data['field_file_data'], T_HTML );
					}
					else
					{
						$fielddata['field_file_data'] = "&nbsp;";
					}
					
					$file['file_custom_fields'] .= $kernel->tp->call( "file_custom_field", CALL_TO_PAGE );
					
					$file['file_custom_fields'] = $kernel->tp->cache( "field_name", $field['field_name'], $file['file_custom_fields'] );
					$file['file_custom_fields'] = $kernel->tp->cache( "field_file_data", $fielddata['field_file_data'], $file['file_custom_fields'] );
				}
			}

			$file['file_icon'] = $kernel->archive_function->construct_file_icon( $file['file_dl_url'], $file['file_icon'] );
						
			$kernel->tp->cache( $file );
		}
  	
		//Check and sort permissions for hiding inaccessible feature links
		if( $kernel->session_function->read_permission_flag( 2 ) == false ) 
			$kernel->ld['lang_f_download_now'] = "";
		else
			$kernel->ld['lang_f_download_notlogged'] = '';
		//if( $kernel->session_function->read_permission_flag( 3 ) == false ) $kernel->ld['lang_f_more_from_developer'] = "";
		//if( $kernel->session_function->read_permission_flag( 5 ) == false ) $kernel->ld['lang_f_rate_file'] = "";
		if( ( $kernel->session_function->read_permission_flag( 0 ) AND $kernel->session_function->read_permission_flag( 1 ) ) == false ) $kernel->ld['lang_f_view_comments'] = "";
		if( $kernel->session_function->read_permission_flag( 4 ) == false ) $kernel->ld['lang_f_view_gallery'] = "";
		
		//Check comment view permissions
		if( $kernel->session_function->read_permission_flag( 1 ) )
		{
			$get_comments = $kernel->db->query( "SELECT c.comment_file_id, c.comment_title, c.comment_data, c.comment_timestamp, u.user_name FROM " . TABLE_PREFIX . "comments c LEFT JOIN " . TABLE_PREFIX . "users u ON( c.comment_author_id = u.user_id ) WHERE c.comment_file_id = {$kernel->vars['id']} ORDER BY c.comment_id DESC LIMIT {$kernel->config['archive_max_comment_on_page']}" );
			
  		if( $kernel->db->numrows( $get_comments ) > 0 )
			{
				$kernel->tp->call( "comment_header" );
				
				while( $comment = $kernel->db->data( $get_comments ) )
				{
					$kernel->tp->call( "comment_row" );
					
					$comment['user_name'] = empty( $comment['user_name'] ) ? $kernel->ld['lang_f_guest'] : $comment['user_name'];
					$comment['comment_title'] = $kernel->format_input( $comment['comment_title'], T_HTML );
					$comment['comment_data'] = $kernel->format_input( $comment['comment_data'], T_HTML );
					$comment['user_name'] = $kernel->format_input( $comment['user_name'], T_HTML );
					$comment['comment_timestamp'] = $kernel->fetch_time( $comment['comment_timestamp'], DF_SHORT );
					$comment['comment_post_data'] = sprintf( $kernel->ld['lang_f_posted_by'], $comment['user_name'], $comment['comment_timestamp'] );
  				
					$kernel->tp->cache( $comment );
				}
  			
				$kernel->tp->call( "comment_footer" );
			}
		}
	}
}

$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );

?>