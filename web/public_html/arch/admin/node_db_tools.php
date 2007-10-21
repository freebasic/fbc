<?php

################################################################################
#	PHCDownload - Download Management System
################################################################################
//Copyright (c) 2005 by Alex G-White -- http://www.phpcredo.com
//PHCDL is free to use software. Please visit the website for futher licence
//information on distribution and use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( -1 );

switch( $kernel->vars['action'] )
{

	#############################################################################
	
	case "prune" :
	{
		$count = 0;
		
		$kernel->clean_array( "_REQUEST", array( "category_id" => V_INT, "usergroup_id" => V_INT, "stamp" => V_INT ) );
		
		//delete orph files
		if( isset( $_POST['form_file_prune'] ) )
		{
			$get_files = $kernel->db->query( "SELECT `file_id`, `file_cat_id` FROM `" . TABLE_PREFIX . "files`" );
			while( $file = $kernel->db->data( $get_files ) )
			{
				if( $kernel->db->numrows( "SELECT `category_id` FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = {$file['file_cat_id']}" ) == 0 )
				{
					$prune_data[] = $kernel->db->item( "SELECT `file_name` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$file['file_id']}" );
					
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$file['file_id']}" );
					$count++;
				}
			}
			
			$kernel->archive_function->update_database_counter( "files" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_orphaned_files_deleted", $count, $prune_data );
		}
		
		//delete orph categories
		if( isset( $_POST['form_cate_prune'] ) )
		{
			$get_categories = $kernel->db->query( "SELECT `category_id`, `category_sub_id` FROM `" . TABLE_PREFIX . "categories` WHERE `category_sub_id` > 0" );
			while( $category = $kernel->db->data( $get_categories ) )
			{
				if( $kernel->db->numrows( "SELECT `category_id` FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = {$category['category_sub_id']}" ) == 0 )
				{
					$prune_data[] = $kernel->db->item( "SELECT `category_name` FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = {$category['category_sub_id']}" );
					
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = {$category['category_id']}" );
					$count++;
				}
			}
			
			$kernel->archive_function->update_database_counter( "categories" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_orphaned_categories_deleted", $count, $prune_data );
		}
		
		//delete orph comments
		if( isset( $_POST['form_comm_prune'] ) )
		{
			$get_comments = $kernel->db->query( "SELECT `comment_id`, `comment_file_id` FROM `" . TABLE_PREFIX . "comments`" );
			while( $comment = $kernel->db->data( $get_comments ) )
			{
				if( $kernel->db->numrows( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$comment['comment_file_id']}" ) == 0 )
				{
					$prune_data[] = $kernel->db->item( "SELECT `comment_title` FROM `" . TABLE_PREFIX . "comments` WHERE `comment_id` = {$comment['comment_id']}" );
					
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "comments` WHERE `comment_id` = {$comment['comment_id']}" );
					$count++;
				}
			}
			
			$kernel->archive_function->update_database_counter( "comments" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_orphaned_comments_deleted", $count, $prune_data );
		}
		
		//delete orph fields
		if( isset( $_POST['form_fiel_prune'] ) )
		{
			$get_fields = $kernel->db->query( "SELECT `field_id`, `field_file_id` FROM `" . TABLE_PREFIX . "fields_data`" );
			while( $field = $kernel->db->data( $get_fields ) )
			{
				if( $kernel->db->numrows( "SELECT `field_id` FROM `" . TABLE_PREFIX . "fields` WHERE `field_id` = {$field['field_id']}" ) == 0 )
				{
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "fields_data` WHERE `field_id` = {$field['field_id']}" );
					$count++;
				}
				
				if( $kernel->db->numrows( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$field['field_file_id']}" ) == 0 )
				{
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "fields_data` WHERE `field_id` = {$field['field_id']}" );
					$count++;
				}
			}
			
			$kernel->archive_function->update_database_counter( "fields_data" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_orphaned_fields_deleted", $count );
		}
		
		//delete orph votes
		if( isset( $_POST['form_vote_prune'] ) )
		{
			$get_votes = $kernel->db->query( "SELECT `vote_id`, `file_id` FROM `" . TABLE_PREFIX . "votes`" );
			while( $vote = $kernel->db->data( $get_votes ) )
			{
				if( $kernel->db->numrows( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$vote['file_id']}" ) == 0 )
				{				
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "votes` WHERE `vote_id` = {$vote['vote_id']}" );
					$count++;
				}
			}
			
			$kernel->archive_function->update_database_counter( "votes" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_orphaned_votes_deleted", $count );
		}
		
		//delete orph users
		if( isset( $_POST['form_user_prune'] ) )
		{
			$get_users = $kernel->db->query( "SELECT `user_id`, `user_group_id` FROM `" . TABLE_PREFIX . "users`" );
			while( $user = $kernel->db->data( $get_users ) )
			{
				if( $kernel->db->numrows( "SELECT `usergroup_id` FROM `" . TABLE_PREFIX . "usergroups` WHERE `usergroup_id` = {$user['user_group_id']}" ) == 0 )
				{
					$prune_data[] = $kernel->db->item( "SELECT `user_name` FROM `" . TABLE_PREFIX . "users` WHERE `user_id` = {$user['user_id']}" );
					
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "users` WHERE `user_id` = {$user['user_id']}" );
					$count++;
				}
			}
			
			$kernel->archive_function->update_database_counter( "users" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_orphaned_users_deleted", $count, $prune_data );
		}
		
		//delete old comments
		if( isset( $_POST['form_comm_prune_old'] ) )
		{
			$stamp = UNIX_TIME - ( intval( $_POST['form_comm_prune_old_days'] ) * 86400 );
			$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "comments` WHERE `comment_timestamp` < {$stamp}" );
			
			$kernel->archive_function->update_database_counter( "comments" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_old_comments_deleted", $_POST['form_comm_prune_old_days'] );
		}
		
		//delete old sys logs
		if( isset( $_POST['form_syslog_prune_old'] ) )
		{
			$stamp = UNIX_TIME - ( intval( $_POST['form_syslog_prune_old_days'] ) * 86400 );
			$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "logs_admin` WHERE `log_timestamp` < {$stamp}" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_old_system_deleted", $_POST['form_syslog_prune_old_days'] );
		}
		
		//delete old download logs
		if( isset( $_POST['form_dllog_prune_old'] ) )
		{
			$stamp = UNIX_TIME - ( intval( $_POST['form_dllog_prune_old_days'] ) * 86400 );
			$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "logs` WHERE `log_timestamp` < {$stamp} AND `log_type` = 1" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_old_download_deleted", $_POST['form_dllog_prune_old_days'] );
		}
		
		//delete old leech logs
		if( isset( $_POST['form_lelog_prune_old'] ) )
		{
			$stamp = UNIX_TIME - ( intval( $_POST['form_lelog_prune_old_days'] ) * 86400 );
			$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "logs` WHERE `log_timestamp` < {$stamp} AND `log_type` = 2" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_old_leech_deleted", $_POST['form_lelog_prune_old_days'] );
		}
				
		break;
	}
	
	#############################################################################
	
	case "clean" :
	{
		$kernel->clean_array( "_REQUEST", array( "category_id" => V_INT, "usergroup_id" => V_INT ) );
		
		if( $kernel->vars['category_id'] == 0 AND isset( $_POST['form_file_move'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_category_selected'], M_ERROR );
		}
		elseif( $kernel->vars['usergroup_id'] == 0 AND isset( $_POST['form_user_move'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_usergroup_selected'], M_ERROR );
		}
		else
		{
			//move orph files
			if( isset( $_POST['form_file_move'] ) )
			{
				$get_files = $kernel->db->query( "SELECT `file_id`, `file_cat_id` FROM `" . TABLE_PREFIX . "files`" );
				while( $file = $kernel->db->data( $get_files ) )
				{
					if( $kernel->db->numrows( "SELECT `category_id` FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = {$file['file_cat_id']}" ) == 0 )
					{
						$move_data[] = $kernel->db->item( "SELECT `file_name` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$file['file_id']}" );
						
						$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "files` SET `file_cat_id` = {$kernel->vars['category_id']} WHERE `file_id` = {$file['file_id']}" );
						$count++;
					}
				}
				
				$kernel->admin_function->message_admin_report( "lang_b_log_orphaned_files_moved", $count, $move_data );
			}
			
			//move orph categories
			if( isset( $_POST['form_cate_move'] ) )
			{
				$get_categories = $kernel->db->query( "SELECT `category_id`, `category_sub_id` FROM `" . TABLE_PREFIX . "categories` WHERE `category_sub_id` > 0" );
				while( $category = $kernel->db->data( $get_categories ) )
				{
					if( $kernel->db->numrows( "SELECT `category_id` FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = {$category['category_sub_id']}" ) == 0 )
					{
						$move_data[] = $kernel->db->item( "SELECT `category_name` FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = {$category['category_id']}" );
						
						$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "categories` SET `category_sub_id` = {$kernel->vars['category_id']} WHERE `category_id` = {$category['category_id']}" );
						$count++;
					}
				}
				
				$kernel->admin_function->message_admin_report( "lang_b_log_orphaned_categories_moved", $count, $move_data );
			}
			
			//move orph users
			if( isset( $_POST['form_user_move'] ) )
			{
				$get_users = $kernel->db->query( "SELECT `user_id`, `user_group_id` FROM `" . TABLE_PREFIX . "users` WHERE `user_group_id` > 2" );
				while( $user = $kernel->db->data( $get_users ) )
				{
					if( $kernel->db->numrows( "SELECT `usergroup_id` FROM `" . TABLE_PREFIX . "usergroups` WHERE `usergroup_id` = {$user['user_group_id']}" ) == 0 )
					{
						$move_data[] = $kernel->db->item( "SELECT `user_name` FROM `" . TABLE_PREFIX . "users` WHERE `user_id` = {$user['user_id']}" );
						
						$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "users` SET `user_group_id` = {$kernel->vars['usergroup_id']} WHERE `user_id` = {$user['user_id']}" );
						$count++;
					}
				}
				
				$kernel->admin_function->message_admin_report( "lang_b_log_orphaned_users_moved", $count, $move_data );
			}
		}
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$kernel->tp->call( "admin_db_prune" );
		
		$kernel->tp->call( "admin_db_clean" );
		
		$kernel->archive_function->construct_usergroup_options( 0, $kernel->db->query( "SELECT `usergroup_id`, `usergroup_title`, `usergroup_panel_permissions` FROM `" . TABLE_PREFIX . "usergroups` ORDER BY `usergroup_title`" ) );
		
		$kernel->page_function->construct_category_list();
		
		break;
	}
}

?>

