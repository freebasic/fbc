<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

require_once( "global.php" );

$kernel->clean_array( "_REQUEST", array(
	"page" => V_PINT, "limit" => V_PINT, "sort" => V_STR, "order" => V_STR,
	"start" => V_PINT, "id" => V_INT, "action" => V_STR
) );

$kernel->vars['page'] = ( $kernel->vars['page'] < 1 ) ? 1 : $kernel->vars['page'];
$kernel->vars['limit'] = ( $kernel->vars['limit'] < 1 ) ? $kernel->config['display_default_limit'] : $kernel->vars['limit'];

//No ID ref
if( $kernel->vars['id'] == 0 )
{
	$kernel->page_function->message_report( $kernel->ld['lang_f_no_file_specified'], M_ERROR );
}
else
{
	$get_file = $kernel->db->query( "SELECT `file_id`, `file_name`, `file_cat_id`, `file_total_comments`, `file_disabled` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$kernel->vars['id']} LIMIT 1" );
	
	//Invalid ID ref
	if( $kernel->db->numrows() == 0 )
	{
		$kernel->page_function->message_report( $kernel->ld['lang_f_file_no_exists'], M_ERROR );
	}
	else
	{
		$file = $kernel->db->data( $get_file );
		
		// Setup page vars
		$kernel->vars['page_struct']['system_page_action_title'] = sprintf( $kernel->ld['lang_f_page_title_comment'], $file['file_name'] );
		
		$kernel->page_function->read_category_permissions( $file['file_cat_id'], SCRIPT_PATH );
		
		//File disabled
		if( $file['file_disabled'] == 1 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_f_file_status_disabled'], M_NOTICE );
		}
		else
		{
			switch( $kernel->vars['action'] )
			{
				########################################################################
				# Add comment
				
				case "add" :
				{
					$kernel->clean_array( "_POST", array( "comment_data" => V_STR, "comment_title" => V_STR, "user_verify_key" => V_STR, "user_verify_hash" => V_STR ) );
					
					//Check permissions
					if( $kernel->session_function->read_permission_flag( 0, true ) == true )
					{
						// Check image secuirty hash
						$kernel->page_function->verify_security_image_details( null );
						
						//No comment
						if( empty( $kernel->vars['comment_data'] ) )
						{
							$kernel->page_function->message_report( $kernel->ld['lang_f_no_comment_specified'], M_ERROR );
						}
						
						//Posting too quickly
						elseif( !empty( $_SESSION['phcdl_last_post'] ) AND $_SESSION['phcdl_last_post'] > ( UNIX_TIME - $kernel->config['archive_comment_grace_time'] ) )
						{
							$kernel->page_function->message_report( sprintf( $kernel->ld['lang_f_fast_comment'], $kernel->config['archive_comment_grace_time'] ), M_WARNING );
						}
						else
						{
							$commentdata = array( 
								"comment_file_id" => $kernel->vars['id'],
								"comment_author_id" => ( empty( $kernel->session['session_user_id'] ) ) ? 0 : $kernel->session['session_user_id'],
								"comment_author_ip" => IP_ADDRESS,
								"comment_title" => stripslashes( $kernel->archive_function->string_word_length_slice( $kernel->vars['comment_title'], $kernel->config['string_max_word_length'] ) ),
								"comment_data" => stripslashes( $kernel->archive_function->string_word_length_slice( $kernel->vars['comment_data'], $kernel->config['string_max_word_length'] ) ),
								"comment_timestamp" => UNIX_TIME,
							);
							
							$kernel->db->insert( "comments", $commentdata );
							
							//Update comments counter
							$kernel->db->update( "files", array( "file_total_comments" => $file['file_total_comments'] + 1 ), "WHERE `file_id` = {$kernel->vars['id']}" );
							
							$kernel->archive_function->update_database_counter( "comments" );
							
							//Set post time for anti-spam
							$_SESSION['phcdl_last_post'] = UNIX_TIME;
							
							//Back to file page
							header( "Location: file.php?id={$kernel->vars['id']}&posted=true" );
							exit;
						}
					}
					
					break;
				}
				
				########################################################################
				# View, post comments
				
				default :
				{
					$file = $kernel->db->row( "SELECT `file_name`, `file_cat_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$kernel->vars['id']} LIMIT 1" );
					
					//Setup page vars
					$kernel->vars['page_struct']['system_page_navigation_id'] = $file['file_cat_id'];
					$kernel->vars['page_struct']['system_page_navigation_html'] = array( "file.php?id={$kernel->vars['id']}" => $file['file_name'], SCRIPT_PATH => $kernel->ld['lang_f_viewing_comments'] );
					
					//Check permission to read comments
					if( $kernel->session_function->read_permission_flag( 1, true ) == true )
					{
						$check_comments = $kernel->db->query( "SELECT c.comment_file_id, c.comment_title, c.comment_data, c.comment_timestamp, u.user_name FROM " . TABLE_PREFIX . "comments c LEFT JOIN " . TABLE_PREFIX . "users u ON( c.comment_author_id = u.user_id ) WHERE c.comment_file_id = {$kernel->vars['id']}" );
						
						//No comments
						if( $kernel->db->numrows() == 0 )
						{
							$kernel->page_function->message_report( $kernel->ld['lang_f_no_comments'], M_NOTICE );
						}
						else
						{
							//Setup pagination vars
							$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_comments ) );
							
							$kernel->tp->call( "comment_header" );
							
							$get_comments = $kernel->db->query( "SELECT c.comment_file_id, c.comment_title, c.comment_data, c.comment_timestamp, u.user_name FROM " . TABLE_PREFIX . "comments c LEFT JOIN " . TABLE_PREFIX . "users u ON( c.comment_author_id = u.user_id ) WHERE c.comment_file_id = {$kernel->vars['id']} ORDER BY c.comment_id DESC LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
							
							//Get comments
							while( $comment = $kernel->db->data( $get_comments ) )
							{
								$kernel->tp->call( "comment_row" );
								
								if( empty( $comment['user_name'] ) )
								{
									$comment['user_name'] = $kernel->ld['lang_f_guest'];
								}
								
								$comment['comment_title'] = $kernel->format_input( $comment['comment_title'], T_HTML );
								$comment['comment_data'] = $kernel->format_input( $comment['comment_data'], T_HTML );
								$comment['comment_timestamp'] = $kernel->fetch_time( $comment['comment_timestamp'], DF_SHORT );
								$comment['comment_post_data'] = sprintf( $kernel->ld['lang_f_posted_by'], $comment['user_name'], $comment['comment_timestamp'] );
								
								$kernel->tp->cache( $comment );
							}
							
							//Finalise pagination setup
        			$kernel->vars['pagination_urls'] = array(
        				"nextpage" => "comment.php?id={$kernel->vars['id']}&amp;limit={$kernel->vars['limit']}&amp;page={\$nextpage}",
        				"previouspage" => "comment.php?id={$kernel->vars['id']}&amp;limit={$kernel->vars['limit']}&amp;page={\$previouspage}",
        				"span" => "comment.php?id={$kernel->vars['id']}&amp;limit={$kernel->vars['limit']}&amp;page={\$page}",
        				"start" => "comment.php?id={$kernel->vars['id']}&amp;limit={$kernel->vars['limit']}&amp;page=1",
        				"end" => "comment.php?id={$kernel->vars['id']}&amp;limit={$kernel->vars['limit']}&amp;page={$kernel->vars['total_pages']}",
        			);
							
							$kernel->tp->call( "comment_footer" );
							
							//Output pagination bar
							$kernel->page_function->construct_pagination( $kernel->vars['pagination_urls'] );
						}
					}
					
					/*
					//Check permission to post comments
					if( $kernel->session_function->read_permission_flag( 0, true ) == true )
					{
						$file = $kernel->db->row( "SELECT `file_id`, `file_name`, `file_cat_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$kernel->vars['id']} LIMIT 1" );
						
						$kernel->tp->call( "comment_add" );
						
						//GD image security option
  					$kernel->session_function->construct_session_security_form();
					}
					*/
					
					$kernel->tp->cache( $file );
					
					break;
				}
			}
		}
	}
}

$kernel->page_function->construct_output( R_HEADER, R_FOOTER, R_ANNOUNCEMENTS, R_NAVIGATION );

?>