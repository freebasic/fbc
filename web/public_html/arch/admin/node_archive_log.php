<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( -1 );

$kernel->clean_array( "_REQUEST", array( "page" => V_PINT, "limit" => V_PINT, "sort" => V_STR, "order" => V_STR, "start" => V_PINT, "filter" => V_STR, "group_type" => V_INT, "allnoflag" => V_INT ) );

$kernel->vars['page'] = ( $kernel->vars['page'] < 1 ) ? 1 : $kernel->vars['page'];
$kernel->vars['limit'] = ( $kernel->vars['limit'] < 1 ) ? $kernel->config['admin_display_default_limit'] : $kernel->vars['limit'];

if( empty( $kernel->vars['sort'] ) ) $kernel->vars['sort'] = "file_name";
if( empty( $kernel->vars['order'] ) ) $kernel->vars['order'] = "asc";
if( empty( $kernel->vars['filter'] ) ) $kernel->vars['filter'] = "today";

$kernel->tp->call( "admin_logs" );

//build date filters
$kernel->archive_function->construct_date_list_options( $kernel->vars['filter'] );

$kernel->page_function->construct_config_options( "group_type", array( $kernel->ld['lang_b_download'] => 1, $kernel->ld['lang_b_leech'] => 2, $kernel->ld['lang_b_broken'] => 3, $kernel->ld['lang_b_modified'] => 4 ), $kernel->vars['group_type'] );

switch( $kernel->vars['action'] )
{
	#############################################################################

	case "update" :
	{
		if( isset( $_POST['form_toggle'] ) )
		{
			$count = 0;
			
			if( is_array( $_POST['checkbox'] ) )
			{
				foreach( $_POST['checkbox'] AS $log_id )
				{
					if( $log_id == 1 ) continue;
					
					$file_name = $kernel->db->item( "SELECT f.file_name FROM " . TABLE_PREFIX . "logs l LEFT JOIN " . TABLE_PREFIX . "files f ON ( l.log_file_id = f.file_id ) WHERE l.log_id = {$log_id}" );
					if( !isset( $toggle_data[ "$file_name" ] ) ) $toggle_data[ "$file_name" ] = $file_name;
					
					$log = $kernel->db->row( "SELECT `log_file_id`, `log_flag_done` FROM `" . TABLE_PREFIX . "logs` WHERE `log_id` = {$log_id}" );
					
					//Toggle!
					if( empty( $_POST['option_toggle_state'] ) )
					{
						$logdata['log_flag_done'] = ( $log['log_flag_done'] == "0" ) ? "1" : "0";
					}
					elseif( $_POST['option_toggle_state'] == "0" )
					{
						$logdata['log_flag_done'] = "0";
					}
					else
					{
						$logdata['log_flag_done'] = "1";
					}
					
					//Updating duplicates?
					if( $_POST['option_include_duplicate'] == "1" )
					{
						$update_syntax = "WHERE `log_file_id` = " . $log['log_file_id'] . "";
					}
					else
					{
						$update_syntax = "WHERE `log_id` = {$log_id}";
					}
					
					$kernel->db->update( "logs", $logdata, $update_syntax );
					
					$count++;
				}
				
				$kernel->admin_function->message_admin_report( "lang_b_log_log_flag_toggled", $count, $toggle_data );
			}
			else
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_checkbox_none_selected'], M_ERROR, HALT_EXEC );
			}
		}
		
		break;
	}
	
	#############################################################################

	case "view" :
	{
		$flag_filter_syntax = "";
		
		//filter setup
		$filter_query = $kernel->archive_function->construct_db_timestamp_filter( $kernel->vars['filter'] );
		
		if( $kernel->vars['filter'] == "today" OR intval( $kernel->vars['filter'] ) <> 0 AND strlen( intval( $kernel->vars['filter'] ) ) === strlen( $kernel->vars['filter'] ) )
		{
			$kernel->vars['html']['search_filter'] = date( "Y M d", $filter_query[1] );
		}
		else
		{
			$kernel->vars['html']['search_filter'] = date( "Y M d", $filter_query[1] ) . " to " . date( "Y M d", $filter_query[2] );
		}
		
		if( $kernel->vars['allnoflag'] == 1 )
		{
			$flag_filter_syntax = "l.log_flag_done = '0'";
		}
		else
		{
			$flag_filter_syntax = $filter_query[0];
		}
		
		$check_logs = $kernel->db->query( "SELECT l.* FROM " . TABLE_PREFIX . "logs l WHERE " . $flag_filter_syntax . " AND l.log_type = '{$kernel->vars['group_type']}' ORDER BY l.log_id DESC" );
		
		if( $kernel->db->numrows() == 0 )
		{
			$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_no_logs_found'], $kernel->vars['html']['search_filter'] ), M_ERROR );
		}
		else
		{
			$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_logs ) );
			
			if( $kernel->vars['group_type'] > 2 )
			{
				$kernel->tp->call( "admin_log_header_flaggable" );
			}
			else
			{
				$kernel->tp->call( "admin_log_header" );
			}
			
  		$get_log_entries = $kernel->db->query( "SELECT l.* FROM " . TABLE_PREFIX . "logs l WHERE " . $flag_filter_syntax . " AND l.log_type = '{$kernel->vars['group_type']}' ORDER BY l.log_id DESC LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
			
			while( $log = $kernel->db->data( $get_log_entries ) )
			{
				if( $kernel->vars['group_type'] > 2 )
				{
					$kernel->tp->call( "admin_log_row_flaggable" );
				}
				else
				{
					$kernel->tp->call( "admin_log_row" );
				}
				
				$log['log_data'] = "";
				$log['log_timestamp'] = $kernel->fetch_time( $log['log_timestamp'], DF_LONG );
				
				if( $kernel->vars['group_type'] > 2 )
				{
					//Set log flag
					$log['log_data'] .= ( $log['log_flag_done'] == 1 ) ? $kernel->admin_function->construct_icon( "light_green.gif", $kernel->ld['lang_b_log_flag_complete'], true ) : $kernel->admin_function->construct_icon( "light_red.gif", $kernel->ld['lang_b_log_flag_not_complete'], true );
				}
				
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
				
				if( $log['log_file_id'] > 0 )
				{
					$file = $kernel->db->row( "SELECT `file_name`, `file_cat_id`, `file_dl_url` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = " . $log['log_file_id'] . "" );
					
					$category = $kernel->db->row( "SELECT `category_name` FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = " . $file['file_cat_id'] . "" );
				}
				
				if( $log['log_mirror_id'] > 0 )
				{
					$mirror = $kernel->db->row( "SELECT `mirror_name`, `mirror_file_url` FROM `" . TABLE_PREFIX . "mirrors` WHERE `mirror_id` = " . $log['log_mirror_id'] . "" );
				}
				
				if( is_array( $file ) AND $log['log_file_id'] != 0 )
				{
					$log['log_data'] .= "<b>" . $file['file_name'] . "</b>";
					
					if( is_array( $mirror ) AND $log['log_mirror_id'] != 0 )
					{
						$log['log_data'] .= "&nbsp;( Mirror: <b>" . $mirror['mirror_name'] . "</b> )";
					}
					
					$log['log_data'] .= " - " . $category['category_name'] . "<br /><img width=\"100%\" height=\"15\" border=\"0\" src=\"../images/break.gif\" alt=\"\" /><br />";
				}
				else
				{
					$log['log_data'] = "";
				}
				
				$kernel->tp->cache( $log );
			}
			
			if( $kernel->vars['group_type'] > 2 )
			{
				$kernel->tp->call( "admin_log_footer_flaggable" );
			}
			else
			{
				$kernel->tp->call( "admin_log_footer" );
			}
		
	 		$kernel->vars['pagination_urls'] = array(
				"nextpage" => "index.php?hash={$kernel->session['hash']}&node=archive_log&action=view&filter={$kernel->vars['filter']}&group_type={$kernel->vars['group_type']}&limit={$kernel->vars['limit']}&page={\$nextpage}",
				"previouspage" => "index.php?hash={$kernel->session['hash']}&node=archive_log&action=view&filter={$kernel->vars['filter']}&group_type={$kernel->vars['group_type']}&limit={$kernel->vars['limit']}&page={\$previouspage}",
				"span" => "index.php?hash={$kernel->session['hash']}&node=archive_log&action=view&filter={$kernel->vars['filter']}&group_type={$kernel->vars['group_type']}&limit={$kernel->vars['limit']}&page={\$page}",
				"start" => "index.php?hash={$kernel->session['hash']}&node=archive_log&action=view&filter={$kernel->vars['filter']}&group_type={$kernel->vars['group_type']}&limit={$kernel->vars['limit']}&page=1",
				"end" => "index.php?hash={$kernel->session['hash']}&node=archive_log&action=view&filter={$kernel->vars['filter']}&group_type={$kernel->vars['group_type']}&limit={$kernel->vars['limit']}&page={$kernel->vars['total_pages']}",
			);
			
			$kernel->page_function->construct_pagination( $kernel->vars['pagination_urls'], $kernel->config['admin_pagination_page_proximity'] );
		}
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		break;
	}
}

?>

