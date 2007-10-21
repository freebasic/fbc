<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 1, 2 );

$kernel->clean_array( "_REQUEST", array( "page" => V_PINT, "limit" => V_PINT, "sort" => V_STR, "order" => V_STR, "start" => V_PINT, "announcement_id" => V_INT ) );

$kernel->vars['page'] = ( $kernel->vars['page'] < 1 ) ? 1 : $kernel->vars['page'];
$kernel->vars['limit'] = ( $kernel->vars['limit'] < 1 ) ? $kernel->config['admin_display_default_limit'] : $kernel->vars['limit'];

if( empty( $kernel->vars['sort'] ) ) $kernel->vars['sort'] = "file_name";
if( empty( $kernel->vars['order'] ) ) $kernel->vars['order'] = "asc";

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "edit" :
	{
		$kernel->admin_function->read_permission_flags( 1 );
		
		$kernel->tp->call( "admin_anno_edit" );
		
		$announcement = $kernel->db->row( "SELECT * FROM `" . TABLE_PREFIX . "announcements` WHERE `announcement_id` = {$kernel->vars['announcement_id']} LIMIT 1" );
		
		$kernel->page_function->construct_category_list( $announcement['announcement_cat_id'] );
		
		$announcement['announcement_title'] = $kernel->format_input( $announcement['announcement_title'], T_FORM );
		$announcement['announcement_data'] = $kernel->format_input( $announcement['announcement_data'], T_FORM );
		
		$kernel->tp->cache( $announcement );
		
		break;
	}
	
	#############################################################################
	
	case "update" :
	{
		$kernel->admin_function->read_permission_flags( 1 );
		
		$kernel->clean_array( "_POST", array( "announcement_cat_id" => V_INT, "announcement_title" => V_STR, "announcement_data" => V_STR ) );
		
		$announcementdata = array(
			"announcement_cat_id" => $kernel->vars['announcement_cat_id'],
			"announcement_author" => $kernel->format_input( $kernel->session['adminsession_name'], T_DB ),
			"announcement_title" => $kernel->format_input( $kernel->vars['announcement_title'], T_DB ),
			"announcement_data" => $kernel->archive_function->string_word_length_slice( $kernel->format_input( $kernel->vars['announcement_data'], T_DB ), $kernel->config['string_max_word_length'] ),
			"announcement_timestamp" => UNIX_TIME
		);

		$kernel->db->update( "announcements", $announcementdata, "WHERE announcement_id = {$kernel->vars['announcement_id']}" );
		
		$kernel->archive_function->update_database_counter( "announcements" );
		
		$kernel->admin_function->message_admin_report( "lang_b_log_announcement_edited", $kernel->vars['announcement_title'] );
		
		break;
	}
	
	#############################################################################
	
	case "delete" :
	{
		$kernel->admin_function->read_permission_flags( 2 );
		
		$delete_count = 0;
		
		if( $kernel->vars['announcement_id'] != "" )
		{
			$delete_data = $kernel->db->item( "SELECT `announcement_title` FROM `" . TABLE_PREFIX . "announcements` WHERE `announcement_id` = {$kernel->vars['announcement_id']}" );
			
			$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "announcements` WHERE `announcement_id` = {$kernel->vars['announcement_id']}" );
			$delete_count++;
		}
		elseif( is_array( $_POST['checkbox'] ) )
		{
			foreach( $_POST['checkbox'] AS $announcement )
			{
				$delete_data[] = $kernel->db->item( "SELECT `announcement_title` FROM `" . TABLE_PREFIX . "announcements` WHERE `announcement_id` = {$announcement}" );
				
				$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "announcements` WHERE `announcement_id` = {$announcement}" );
				$delete_count++;
			}
		}
		else
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_checkbox_none_selected'], M_ERROR, HALT_EXEC );
		}
		
		$kernel->archive_function->update_database_counter( "announcements" );
		
		$kernel->admin_function->message_admin_report( "lang_b_log_announcement_deleted", $delete_count, $delete_data );
		
		break;
	}
	
	#############################################################################
	
	default :
	{		
		$check_announcements = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "announcements` ORDER BY `announcement_id`" );
		
		if( $kernel->db->numrows( $check_announcements ) == 0 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_announcements'], M_ERROR );
		}
		else
		{
			$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_announcements ) );
			
			$kernel->tp->call( "admin_anno_header" );
			
			$get_announcements = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "announcements` ORDER BY `announcement_id` LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
			
			while( $announcement = $kernel->db->data( $get_announcements ) )
			{
				$kernel->tp->call( "admin_anno_row" );
				
				$category = $kernel->db->row( "SELECT `category_name` FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = {$announcement['announcement_cat_id']}" );
				
				$announcement['announcement_title'] = $kernel->format_input( $announcement['announcement_title'], T_PREVIEW );
				$announcement['announcement_data'] = $kernel->archive_function->return_string_words( $kernel->format_input( $announcement['announcement_data'], T_PREVIEW ), $kernel->config['string_max_words'] );
				$announcement['announcement_cat_id'] = ( $announcement['announcement_cat_id'] == 0 ) ? $kernel->ld['lang_b_global'] : $category['category_name'] ;
				
				$kernel->tp->cache( $announcement );
			}
			
			$kernel->tp->call( "admin_anno_footer" );
			
			$kernel->page_function->construct_category_filters();
			
	 		$kernel->vars['pagination_urls'] = array(
				"nextpage" => "index.php?hash={$kernel->session['hash']}&node=anno_manage&limit={$kernel->vars['limit']}&page={\$nextpage}",
				"previouspage" => "index.php?hash={$kernel->session['hash']}&node=anno_manage&limit={$kernel->vars['limit']}&page={\$previouspage}",
				"span" => "index.php?hash={$kernel->session['hash']}&node=anno_manage&limit={$kernel->vars['limit']}&page={\$page}",
				"start" => "index.php?hash={$kernel->session['hash']}&node=anno_manage&limit={$kernel->vars['limit']}&page=1",
				"end" => "index.php?hash={$kernel->session['hash']}&node=anno_manage&limit={$kernel->vars['limit']}&page={$kernel->vars['total_pages']}",
			);
			
			$kernel->page_function->construct_pagination( $kernel->vars['pagination_urls'], $kernel->config['admin_pagination_page_proximity'] );
		}
		
		break;
	}
}

?>

