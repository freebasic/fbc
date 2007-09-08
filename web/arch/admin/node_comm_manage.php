<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 6, 7 );

$kernel->clean_array( "_REQUEST", array( "page" => V_PINT, "limit" => V_PINT, "sort" => V_STR, "order" => V_STR, "start" => V_PINT, "comment_id" => V_INT ) );

$kernel->vars['page'] = ( $kernel->vars['page'] < 1 ) ? 1 : $kernel->vars['page'];
$kernel->vars['limit'] = ( $kernel->vars['limit'] < 1 ) ? $kernel->config['admin_display_default_limit'] : $kernel->vars['limit'];

if( empty( $kernel->vars['sort'] ) ) $kernel->vars['sort'] = "file_name";
if( empty( $kernel->vars['order'] ) ) $kernel->vars['order'] = "asc";

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "edit" :
	{
		$kernel->admin_function->read_permission_flags( 6 );
		
		$kernel->tp->call( "admin_comm_edit" );
		
		$comment = $kernel->db->row( "SELECT c.* FROM " . TABLE_PREFIX . "comments c WHERE c.comment_id = {$kernel->vars['comment_id']} LIMIT 1" );
		
		$kernel->tp->cache( $comment );
		
		break;
	}
	
	#############################################################################
	
	case "update" :
	{
		$kernel->admin_function->read_permission_flags( 6 );
		
		$kernel->clean_array( "_POST", array( "comment_title" => V_STR, "comment_data" => V_STR ) );
		
		$commentdata = array(
			"comment_title" => $kernel->archive_function->string_word_length_slice( $kernel->format_input( $kernel->vars['comment_title'], T_DB ), $kernel->config['string_max_word_length'] ),
			"comment_data" => $kernel->archive_function->string_word_length_slice( $kernel->format_input( $kernel->vars['comment_data'], T_DB ), $kernel->config['string_max_word_length'] ),
		);
		
		$kernel->db->update( "comments", $commentdata, "WHERE `comment_id` = {$kernel->vars['comment_id']}" );
		
		$kernel->archive_function->update_database_counter( "comments" );
		
		$kernel->admin_function->message_admin_report( "lang_b_log_comment_edited", $kernel->vars['comment_title'] );
		
		break;
	}
	
	#############################################################################
	
	case "manage" :
	{
		$count = 0;
		
		if( isset( $_POST['form_delete'] ) OR $kernel->vars['comment_id'] > 0 )
		{
			$kernel->admin_function->read_permission_flags( 7 );
			
			if( $kernel->vars['comment_id'] > 0 )
			{
				$delete_data[] = $kernel->db->item( "SELECT `comment_title` FROM `" . TABLE_PREFIX . "comments` WHERE `comment_id` = {$kernel->vars['comment_id']}" );
				
				$comment = $kernel->db->row( "SELECT `comment_file_id` FROM `" . TABLE_PREFIX . "comments` WHERE `comment_id` = {$kernel->vars['comment_id']} LIMIT 1" );
				$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "files` SET `file_total_comments` = file_total_comments - 1 WHERE `file_id` = {$comment['comment_file_id']}" );
				
				$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "comments` WHERE `comment_id` = {$kernel->vars['comment_id']}" );
				$count++;
			}
			elseif( is_array( $_POST['checkbox'] ) )
			{
				foreach( $_POST['checkbox'] AS $comment_id )
				{
					$delete_data[] = $kernel->db->item( "SELECT `comment_title` FROM `" . TABLE_PREFIX . "comments` WHERE `comment_id` = {$comment_id}" );
					
					$comment = $kernel->db->row( "SELECT `comment_file_id` FROM `" . TABLE_PREFIX . "comments` WHERE `comment_id` = {$comment_id} LIMIT 1" );
					$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "files` SET `file_total_comments` = file_total_comments - 1 WHERE `file_id` = {$comment['comment_file_id']}" );
					
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "comments` WHERE `comment_id` = {$comment_id}" );
					$count++;
				}
			}
			else
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_checkbox_none_selected'], M_ERROR, HALT_EXEC );
			}
			
			$kernel->archive_function->update_database_counter( "comments" );
			
			//done
			$kernel->admin_function->message_admin_report( "lang_b_log_comment_deleted", $count, $delete_data );
		}
		
		break;
	}
	
	#############################################################################
	
	case "view2" :
	{
		$kernel->clean_array( "_REQUEST", array( "file_id" => V_INT ) );
		
		$check_comments = $kernel->db->query( "SELECT c.comment_id FROM " . TABLE_PREFIX . "comments c WHERE c.comment_file_id = {$kernel->vars['file_id']} ORDER BY c.comment_id DESC" );
		
		if( $kernel->db->numrows() == 0 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_comments_for_file'], M_ERROR );
		}
		else
		{
			$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_comments ) );
			
			$kernel->tp->call( "admin_comm_header" );
			
			$get_comments = $kernel->db->query( "SELECT c.*, u.user_name FROM " . TABLE_PREFIX . "comments c LEFT JOIN " . TABLE_PREFIX . "users u ON( c.comment_author_id = u.user_id ) WHERE c.comment_file_id = {$kernel->vars['file_id']} ORDER BY c.comment_id DESC LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
			
			$kernel->tp->cache( "total_rows", $kernel->db->numrows( $get_comments ) );
			
			while( $comment = $kernel->db->data( $get_comments ) )
			{
				$kernel->tp->call( "admin_comm_row" );
				
				$comment['comment_description'] = $kernel->archive_function->return_string_words(	$kernel->format_input( $comment['comment_description'], T_PREVIEW ), $kernel->config['string_max_words'] );
				$comment['comment_name'] = $kernel->format_input( $comment['comment_name'], T_PREVIEW );
				$comment['comment_timestamp'] = $kernel->fetch_time( $comment['comment_timestamp'], DF_LONG );
				
				if( empty( $comment['user_name'] ) ) $comment['user_name'] = $kernel->ld['lang_b_guest'];
				
				$kernel->tp->cache( $comment );
			}
			
			$kernel->tp->call( "admin_comm_footer" );
			
			$kernel->page_function->construct_category_filters();
			
	 		$kernel->vars['pagination_urls'] = array(
				"nextpage" => "index.php?hash={$kernel->session['hash']}&node=comm_manage&action=view2&file_id={$kernel->vars['file_id']}&limit={$kernel->vars['limit']}&page={\$nextpage}",
				"previouspage" => "index.php?hash={$kernel->session['hash']}&node=comm_manage&action=view2&file_id={$kernel->vars['file_id']}&limit={$kernel->vars['limit']}&page={\$previouspage}",
				"span" => "index.php?hash={$kernel->session['hash']}&node=comm_manage&action=view2&file_id={$kernel->vars['file_id']}&limit={$kernel->vars['limit']}&page={\$page}",
				"start" => "index.php?hash={$kernel->session['hash']}&node=comm_manage&action=view2&file_id={$kernel->vars['file_id']}&limit={$kernel->vars['limit']}&page=1",
				"end" => "index.php?hash={$kernel->session['hash']}&node=comm_manage&action=view2&file_id={$kernel->vars['file_id']}&limit={$kernel->vars['limit']}&page={$kernel->vars['total_pages']}",
			);
			
			$kernel->page_function->construct_pagination( $kernel->vars['pagination_urls'], $kernel->config['admin_pagination_page_proximity'] );
		}
		
		break;
	}
	
	#############################################################################
	
	case "view" :
	{
		$kernel->clean_array( "_REQUEST", array( "category_id" => V_INT ) );
		
		//categories
 		$get_categories = $kernel->db->query( "SELECT c.category_id, c.category_name, c.category_description, c.category_password, c.category_file_total, c.category_file_subtotal FROM " . TABLE_PREFIX . "categories c WHERE c.category_sub_id = {$kernel->vars['category_id']} ORDER BY c.category_order, c.category_name" );
 		
 		if( $kernel->db->numrows() > 0 )
 		{
			$category_comments = 0;
			
 			$kernel->tp->call( "admin_comm_cate_header" );
 			
 			while( $category = $kernel->db->data( $get_categories ) )
	 		{
				$kernel->tp->call( "admin_comm_cate_row" );
				
				$cat_files = $kernel->db->query( "SELECT f.file_id FROM " . TABLE_PREFIX . "files f WHERE f.file_cat_id = {$category['category_id']}" );
 				
				$category['category_file_total'] = $kernel->page_function->format_category_file_count( $category['category_file_total'], $category['category_file_subtotal'] );
	 			$category['category_name'] = $kernel->format_input( $category['category_name'], T_PREVIEW );
	 			$category['category_description'] = $kernel->archive_function->return_string_words(	$kernel->format_input( $category['category_description'], T_PREVIEW ), 15 );
				
				$category['category_state_icon'] = $kernel->admin_function->construct_icon( "lock.gif", $kernel->ld['lang_b_category_password_protected'], ( !empty( $category['category_password'] ) ) );
				
				//count total comments per file
 				while( $file = $kernel->db->data( $cat_files ) )
				{
					$category_comments += $file['file_total_comments'];
				}
 				
 				$category['category_file_comments'] = $kernel->format_input( $category_comments, T_NUM );
 				
 				unset( $category_comments );
 				
 				$kernel->tp->cache( $category );
	 		}
			
			$kernel->page_function->construct_category_list( $kernel->vars['category_id'] );
 			
 			$kernel->tp->call( "admin_comm_cate_footer" );
 		}
		
		//category files		 
		$check_files = $kernel->db->query( "SELECT f.file_id FROM " . TABLE_PREFIX . "files f WHERE f.file_cat_id = {$kernel->vars['category_id']}" );
		
		if( $kernel->db->numrows( $check_files ) == 0 )
		{
			if( $kernel->db->numrows( $get_categories ) == 0 )
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_no_files_in_category'], M_ERROR );
			}
		}
		else
		{
			$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_files ) );
			
			$kernel->tp->call( "admin_comm_file_header" );
			
			$get_files = $kernel->db->query( "SELECT f.file_id, f.file_cat_id, f.file_name, f.file_pinned, f.file_icon, f.file_description, f.file_dl_url, f.file_total_comments, f.file_disabled FROM " . TABLE_PREFIX . "files f WHERE f.file_cat_id = {$kernel->vars['category_id']} ORDER BY f.file_pinned DESC, f.file_name LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
			
			$kernel->tp->cache( "total_rows", $kernel->db->numrows( $get_files ) );
			
			while( $file = $kernel->db->data( $get_files ) )
			{
				if( $last_filegroup == 1 AND $file['file_pinned'] == 0 )
				{
					$kernel->tp->call( "admin_file_row_break" );
				}
				$last_filegroup = $file['file_pinned'];
				
				$kernel->tp->call( "admin_comm_file_row" );
				
				$file['file_icon'] = $kernel->archive_function->construct_file_icon( $file['file_dl_url'], $file['file_icon'] );
				$file['file_description'] = $kernel->archive_function->return_string_words(	$kernel->format_input( $file['file_description'], T_PREVIEW ), $kernel->config['string_max_words'] );
				$file['file_name'] = $kernel->format_input( $file['file_name'], T_PREVIEW );
				$file['file_comments'] = $kernel->format_input( $file['file_total_comments'], T_NUM );
				
				$file['file_state_icon'] = $kernel->admin_function->construct_icon( "shield.gif", $kernel->ld['lang_b_file_is_pinned_important'], ( $file['file_pinned'] == 1 ) );
				
				if( $file['file_disabled'] == 1 )
				{
					$file['file_html_name'] .= $kernel->page_function->string_colour( $file['file_name'], "#999999" );
				}
				else
				{
					$file['file_html_name'] .= $file['file_name'];
				}
				
				$kernel->tp->cache( $file );
			}
			
			$kernel->tp->call( "admin_comm_file_footer" );
			
			$kernel->page_function->construct_category_filters();
			
	 		$kernel->vars['pagination_urls'] = array(
				"nextpage" => "index.php?hash={$kernel->session['hash']}&node=comm_manage&action=view&category_id={$kernel->vars['category_id']}&limit={$kernel->vars['limit']}&page={\$nextpage}",
				"previouspage" => "index.php?hash={$kernel->session['hash']}&node=comm_manage&action=view&category_id={$kernel->vars['category_id']}&limit={$kernel->vars['limit']}&page={\$previouspage}",
				"span" => "index.php?hash={$kernel->session['hash']}&node=comm_manage&action=view&category_id={$kernel->vars['category_id']}&limit={$kernel->vars['limit']}&page={\$page}",
				"start" => "index.php?hash={$kernel->session['hash']}&node=comm_manage&action=view&category_id={$kernel->vars['category_id']}&limit={$kernel->vars['limit']}&page=1",
				"end" => "index.php?hash={$kernel->session['hash']}&node=comm_manage&action=view&category_id={$kernel->vars['category_id']}&limit={$kernel->vars['limit']}&page={$kernel->vars['total_pages']}",
			);
			
			$kernel->page_function->construct_pagination( $kernel->vars['pagination_urls'], $kernel->config['admin_pagination_page_proximity'] );
		}
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$get_categories = $kernel->db->query( "SELECT c.category_id, c.category_name, c.category_description, c.category_password, c.category_file_total, c.category_file_subtotal FROM " . TABLE_PREFIX . "categories c WHERE c.category_sub_id = 0 ORDER BY c.category_order, c.category_name" );
		
		if( $kernel->db->numrows() == 0 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_category_files_comments'], M_ERROR );
		}
		else
		{
			$category_comments = 0;
			
			$kernel->tp->call( "admin_comm_cate_header" );
			
			while( $category = $kernel->db->data( $get_categories ) )
			{
				$kernel->tp->call( "admin_comm_cate_row" );
				
				$cat_files = $kernel->db->query( "SELECT f.file_id, f.file_total_comments FROM " . TABLE_PREFIX . "files f WHERE f.file_cat_id = {$category['category_id']}" );
				
				$category['category_file_total'] = $kernel->page_function->format_category_file_count( $category['category_file_total'], $category['category_file_subtotal'] );
				$category['category_name'] = $kernel->format_input( $category['category_name'], T_PREVIEW );
				$category['category_description'] = $kernel->archive_function->return_string_words(	$kernel->format_input( $category['category_description'], T_PREVIEW ), 15 );
				
				$category['category_state_icon'] = $kernel->admin_function->construct_icon( "lock.gif", $kernel->ld['lang_b_category_password_protected'], ( !empty( $category['category_password'] ) ) );
				
				//count total comments
				while( $file = $kernel->db->data( $cat_files ) )
				{
					$category_comments += $file['file_total_comments'];
				}
				
				$category['category_file_comments'] = $kernel->format_input( $category_comments, T_NUM );
				
				unset( $category_comments );
				
				$kernel->tp->cache( $category );
			}
			
			$kernel->page_function->construct_category_list( $kernel->vars['category_id'] );
			
			$kernel->tp->call( "admin_comm_cate_footer" );
		}
		
		break;
	}
}

?>

