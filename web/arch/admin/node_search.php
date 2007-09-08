<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->clean_array( "_REQUEST", array( "term" => V_STR ) );

if( empty( $kernel->vars['term'] ) )
{
	header( "Location: index.php?hash={$kernel->session['adminsession_hash']}&node=panel" );
	exit;
}

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "file" :
	{
		$get_files = $kernel->db->query( "SELECT f.file_id, f.file_cat_id, f.file_name, c.category_name FROM " . TABLE_PREFIX . "files f LEFT JOIN " . TABLE_PREFIX . "categories c ON ( f.file_cat_id = c.category_id ) WHERE f.file_name LIKE '%{$kernel->vars['term']}%' ORDER BY f.file_cat_id, f.file_name" );
		
		if( $kernel->db->numrows( $get_files ) == 0 )
		{
			$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_no_files_found_term'], $kernel->vars['term'] ), M_ERROR );
		}
		elseif( $kernel->db->numrows( $get_files ) == 1 )
		{
			$file = $kernel->db->data( $get_files );
			
			header( "Location: ?hash={$kernel->session['hash']}&node=file_manage&file_id={$file['file_id']}&action=edit" );
		}
		else
		{
			$current_category = 0;
			$kernel->vars['html']['search_list_options'] = "<select name=\"file_id[]\" size=\"15\" multiple=\"multiple\">\r\n";
			
			$kernel->tp->call( "admin_search_file" );
			
			while( $file = $kernel->db->data( $get_files ) )
			{
				if( $current_category != $file['file_cat_id'] )
				{
					if( $current_category > 0 ) $kernel->vars['html']['search_list_options'] .= "</optgroup>\r\n";
					
					$kernel->vars['html']['search_list_options'] .= "<optgroup label=\"{$file['category_name']}\">\r\n";
				}
				
				$kernel->vars['html']['search_list_options'] .= "<option value=\"{$file['file_id']}\">{$file['file_name']}</option>\r\n";
				
				$current_category = $file['file_cat_id'];
			}
			
			$kernel->vars['html']['search_list_options'] .= "</select>\r\n";
		}
		
		break;
	}
	
	#############################################################################
	
	case "category" :
	{
		$get_categories = $kernel->db->query( "SELECT c.category_id, c.category_name FROM " . TABLE_PREFIX . "categories c WHERE c.category_name LIKE '%{$kernel->vars['term']}%' ORDER BY c.category_name" );
		
		if( $kernel->db->numrows( $get_categories ) == 0 )
		{
			$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_no_categories_found_term'], $kernel->vars['term'] ), M_ERROR );
		}
		elseif( $kernel->db->numrows( $get_categories ) == 1 )
		{
			$category = $kernel->db->data( $get_categories );
			
			header( "Location: ?hash={$kernel->session['hash']}&node=cate_manage&category_id={$category['category_id']}&action=edit" );
		}
		else
		{
			$kernel->vars['html']['search_list_options'] = "<select name=\"category_id\">\r\n";
			
			$kernel->tp->call( "admin_search_category" );
			
			while( $category = $kernel->db->data( $get_categories ) )
			{
				$kernel->vars['html']['search_list_options'] .= "<option value=\"{$category['category_id']}\">{$category['category_name']}</option>\r\n";
			}
			
			$kernel->vars['html']['search_list_options'] .= "</select>\r\n";
		}
		
		break;
	}
	
	#############################################################################
	
	case "comment" :
	{
		$get_comments = $kernel->db->query( "SELECT c.comment_id, c.comment_file_id, c.comment_title, f.file_name FROM " . TABLE_PREFIX . "comments c LEFT JOIN " . TABLE_PREFIX . "files f ON ( c.comment_file_id = f.file_id ) WHERE c.comment_title LIKE '%{$kernel->vars['term']}%' ORDER BY c.comment_file_id, c.comment_title" );
		
		if( $kernel->db->numrows( $get_comments ) == 0 )
		{
			$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_no_comments_found_term'], $kernel->vars['term'] ), M_ERROR );
		}
		elseif( $kernel->db->numrows( $get_comments ) == 1 )
		{
			$comment = $kernel->db->data( $get_comments );
			
			header( "Location: ?hash={$kernel->session['hash']}&node=comm_manage&comment_id={$comment['comment_id']}&action=edit" );
		}
		else
		{
			$current_file = 0;
			$kernel->vars['html']['search_list_options'] = "<select name=\"comment_id\">\r\n";
			
			$kernel->tp->call( "admin_search_file_comm" );
			
			while( $comment = $kernel->db->data( $get_comments ) )
			{
				if( $current_file != $comment['comment_file_id'] )
				{
					if( $current_file > 0 ) $kernel->vars['html']['search_list_options'] .= "</optgroup>\r\n";
					
					$kernel->vars['html']['search_list_options'] .= "<optgroup label=\"{$comment['file_name']}\">\r\n";
				}
				
				$kernel->vars['html']['search_list_options'] .= "<option value=\"{$comment['comment_id']}\">{$comment['comment_title']}</option>\r\n";
				
				$current_file = $comment['comment_file_id'];
			}
			
			$kernel->vars['html']['search_list_options'] .= "</select>\r\n";
		}
		
		break;
	}
	
	#############################################################################
	
	case "user" :
	{
		$get_users = $kernel->db->query( "SELECT u.user_id, u.user_group_id, u.user_name, g.usergroup_title FROM " . TABLE_PREFIX . "users u LEFT JOIN " . TABLE_PREFIX . "usergroups g ON ( u.user_group_id = g.usergroup_id ) WHERE u.user_name LIKE '%{$kernel->vars['term']}%' ORDER BY u.user_group_id, u.user_name" );
		
		if( $kernel->db->numrows( $get_users ) == 0 )
		{
			$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_no_users_found_term'], $kernel->vars['term'] ), M_ERROR );
		}
		elseif( $kernel->db->numrows( $get_users ) == 1 )
		{
			$user = $kernel->db->data( $get_users );
			
			header( "Location: ?hash={$kernel->session['hash']}&node=user_manage&user_id={$user['user_id']}&action=edit" );
		}
		else
		{
			$kernel->tp->call( "admin_search_user" );
			
			$current_group = 0;
			
			$kernel->vars['html']['search_list_options'] = "<select name=\"user_id\">\r\n";
			
			while( $user = $kernel->db->data( $get_users ) )
			{
				if( $user['user_group_id'] == 1 AND $kernel->session['adminsession_group_id'] <> 1 ) continue;
				
				if( $current_group != $user['user_group_id'] )
				{
					if( $current_group > 0 ) $kernel->vars['html']['search_list_options'] .= "</optgroup>\r\n";
					
					$kernel->vars['html']['search_list_options'] .= "<optgroup label=\"{$user['usergroup_title']}\">\r\n";
				}
				
				$kernel->vars['html']['search_list_options'] .= "<option value=\"{$user['user_id']}\">{$user['user_name']}</option>\r\n";
				
				$current_group = $user['user_group_id'];
			}
			
			$kernel->vars['html']['search_list_options'] .= "</select>\r\n";
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

