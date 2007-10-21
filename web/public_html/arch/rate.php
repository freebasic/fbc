<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

require_once( "global.php" );

$kernel->clean_array( "_REQUEST", array( "id" => V_INT, "action" => V_STR, "vote" => V_PINT ) );

//No ID ref
if( $kernel->vars['id'] == 0 )
{
	$kernel->page_function->message_report( $kernel->ld['lang_f_no_file_specified'], M_ERROR );
}
else
{
	$file = $kernel->db->row( "SELECT `file_name`, `file_cat_id`, `file_disabled` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$kernel->vars['id']} LIMIT 1" );
	
	//Set page vars
	$kernel->vars['page_struct']['system_page_navigation_id'] = $file['file_cat_id'];
	$kernel->vars['page_struct']['system_page_navigation_html'] = array( "file.php?id={$kernel->vars['id']}" => $file['file_name'], SCRIPT_PATH => $kernel->ld['lang_f_rating_file'] );
	$kernel->vars['page_struct']['system_page_action_title'] = sprintf( $kernel->ld['lang_f_page_title_rate'], $file['file_name'] );
	
	$check_votes = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "votes` WHERE `user_ip_address` = '" . IP_ADDRESS . "' AND `file_id` = {$kernel->vars['id']}" );
	
	//Check if user has voted
	if( $kernel->db->numrows( $check_votes ) > 0 )
	{
		$kernel->page_function->message_report( $kernel->ld['lang_f_already_voted'], M_NOTICE, HALT_EXEC );
	}

  //Check category password
  $kernel->page_function->read_category_permissions( $file['file_cat_id'], SCRIPT_PATH );
	
	//File disabled
	if( $file['file_disabled'] == 1 )
	{
		$kernel->page_function->message_report( $kernel->ld['lang_f_file_status_disabled'], M_NOTICE, HALT_EXEC );
	}
	
	switch( $kernel->vars['action'] )
	{
		#############################################################################
		# Add Vote
		
		case "vote" :
		{
			if( $kernel->session_function->read_permission_flag( 5, true ) == true )
			{
				$file = $kernel->db->row( "SELECT `file_rating`, `file_votes` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$kernel->vars['id']} LIMIT 1" );
				
				$total_votes = $file['file_votes'] += 1;
				$current_rating = ( $file['file_rating'] * $file['file_votes'] );
				
				//Update file rating
				$kernel->db->update( "files", array( "file_rating" => floor( ( $kernel->vars['vote'] + $current_rating ) / ( $total_votes ) ), "file_votes" => $total_votes ), "WHERE `file_id` = {$kernel->vars['id']}" );
				
				//Add vote to record
				$kernel->db->insert( "votes", array( "file_id" => $kernel->vars['id'], "user_ip_address" => IP_ADDRESS ) );
				
				$kernel->archive_function->update_database_counter( "votes" );
				
				header( "Location: file.php?id=" . $kernel->vars['id'] . "&amp;voted=true" );
				exit;
			}
				
			break;
		}
		
		#############################################################################
		# Vote form
		
		default :
		{
			//Check voting permissions
			if( $kernel->session_function->read_permission_flag( 5, true ) == true )
			{
				$get_file = $kernel->db->query( "SELECT f.* FROM " . TABLE_PREFIX . "files f WHERE f.file_id = {$kernel->vars['id']} LIMIT 1" );
				
				//Invalid ID ref
				if( $kernel->db->numrows() == 0 )
				{
					$kernel->page_function->message_report( $kernel->ld['lang_f_file_no_exists'], M_ERROR );
				}
				else
				{		
					while( $file = $kernel->db->data( $get_file ) )
					{
						$kernel->tp->call( "file_rate" );
						
						$file['file_rank'] = $kernel->archive_function->construct_file_rating( $file['file_rating'], $file['file_votes'] );
						$file['file_votes'] = $kernel->format_input( $file['file_votes'], T_NUM );
						$file['file_name'] = $kernel->format_input( $file['file_name'], T_HTML );
							
						$kernel->ld['lang_f_sent_rankvotes'] = sprintf( $kernel->ld['lang_f_sent_rankvotes'], $file['file_votes'] );
						
						$kernel->tp->cache( $file );
					}
				}
			}
			
			break;
		}
	}
}

$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );

?>