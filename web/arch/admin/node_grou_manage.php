<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 35, 36 );

$kernel->clean_array( "_REQUEST", array( "page" => V_PINT, "limit" => V_PINT, "sort" => V_STR, "order" => V_STR, "start" => V_PINT, "usergroup_id" => V_INT ) );

$kernel->vars['page'] = ( $kernel->vars['page'] < 1 ) ? 1 : $kernel->vars['page'];
$kernel->vars['limit'] = ( $kernel->vars['limit'] < 1 ) ? $kernel->config['admin_display_default_limit'] : $kernel->vars['limit'];

if( empty( $kernel->vars['sort'] ) ) $kernel->vars['sort'] = "file_name";
if( empty( $kernel->vars['order'] ) ) $kernel->vars['order'] = "asc";

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "edit" :
	{
		$kernel->admin_function->read_permission_flags( 35 );
		
		if( $kernel->vars['usergroup_id'] == 1 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_edit_administrator'], M_NOTICE );
		}
		else
		{
			if( $kernel->vars['usergroup_id'] != -1 )
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_session_clear_warning'], M_WARNING );
			}
			
			if( $kernel->vars['usergroup_id'] == -1 OR $kernel->vars['usergroup_id'] == 2 )
			{
				$kernel->tp->call( "admin_grou_edit_lo" );
			}
			else
			{
				$kernel->tp->call( "admin_grou_edit" );
			}
			
			$usergroup = $kernel->db->row( "SELECT * FROM `" . TABLE_PREFIX . "usergroups` WHERE `usergroup_id` = {$kernel->vars['usergroup_id']} LIMIT 1" );
			
			$panel_data = explode( ",", $usergroup['usergroup_panel_permissions'] );
			$archive_data = explode( ",", $usergroup['usergroup_archive_permissions'] );
			
			foreach( $panel_data AS $set_key => $set_value )
			{
				$panel_permissions_data[ $set_key . "panel_attrib" ] = ( $set_value == "1" ) ? "checked" : "";
			}
			$kernel->tp->cache( $panel_permissions_data );
			
			foreach( $archive_data AS $set_key => $set_value )
			{
				$archive_permissions_data[ $set_key . "archive_attrib_yes" ] = ( $set_value == "1" ) ? "checked" : "";
				$archive_permissions_data[ $set_key . "archive_attrib_no" ] = ( $set_value == "0" ) ? "checked" : "";
			}
			$kernel->tp->cache( $archive_permissions_data );
			
			$usergroup['usergroup_title'] = $kernel->format_input( $usergroup['usergroup_title'], T_HTML );
			
			$kernel->tp->cache( $usergroup );
		}
		
		break;
	}
	
	#############################################################################
	
	case "update" :
	{
		$kernel->admin_function->read_permission_flags( 35 );
		
		$kernel->clean_array( "_POST", array( "usergroup_title" => V_STR, "usergroup_session_downloads" => V_INT, "usergroup_session_baud" => V_INT ) );
		
		if( empty( $kernel->vars['usergroup_title'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_usergroup_title'], M_WARNING );
		}
		else
		{
			$usergroup = $kernel->db->row( "SELECT `usergroup_title` FROM `" . TABLE_PREFIX . "usergroups` WHERE `usergroup_id` = '{$kernel->vars['usergroup_id']}'" );
			
			$kernel->vars['usergroup_title'] = $kernel->format_input( $kernel->vars['usergroup_title'], T_DB );
			
			if( $kernel->db->numrows( "SELECT `usergroup_title` FROM `" . TABLE_PREFIX . "usergroups` WHERE `usergroup_title` = '{$kernel->vars['usergroup_title']}'" ) == 1 AND $usergroup['usergroup_title'] != $kernel->vars['usergroup_title'] )
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_usergroup_title_in_use'], M_ERROR );
			}
			else
			{
				$usergroupdata = array(
					"usergroup_title" => $kernel->vars['usergroup_title'],
					"usergroup_session_downloads" => $kernel->vars['usergroup_session_downloads'],
					"usergroup_session_baud" => $kernel->vars['usergroup_session_baud']
				);
				
				//Check for bad mods and build permissions string
				if( $kernel->session['adminsession_group_id'] > 1 AND $kernel->vars['usergroup_id'] == 1 )
				{
					$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_create_update_administrators'], M_ERROR );
				}
				else
				{
					if( $kernel->session['adminsession_group_id'] == 1 )
					{
						$panel_data = array(
							0 => 0,
							1 => 0,
							2 => 0,
							3 => 0,
							4 => 0,
							5 => 0,
							6 => 0,
							7 => 0,
							8 => 0,
							9 => 0,
							10 => 0,
							11 => 0,
							12 => 0,
							13 => 0,
							14 => 0,
							15 => 0,
							16 => 0,
							17 => 0,
							18 => 0,
							19 => 0,
							20 => 0,
							21 => 0,
							22 => 0,
							23 => 0,
							24 => 0,
							25 => 0,
							26 => 0,
							27 => 0,
							28 => 0,
							29 => 0,
							30 => 0,
							31 => 0,
							32 => 0,
							33 => 0,
							34 => 0,
							35 => 0,
							36 => 0,
							37 => 0,
							38 => 0,
							39 => 0
						);
						
						if( is_array( $_POST['panel_attrib'] ) )
						{
							foreach( $_POST['panel_attrib'] AS $set_key => $set_value )
							{
								$panel_data[ $set_key ] = 1;
							}
						}
						
						if( $kernel->vars['usergroup_id'] > 1 )
						{
							$usergroupdata['usergroup_panel_permissions'] = implode( ",", $panel_data );
						}
					}
					
					if( $kernel->vars['usergroup_id'] <> 1 )
					{
						$usergroupdata['usergroup_archive_permissions'] = implode( ",", $_POST['archive_attrib'] );
					}
					
					$kernel->db->update( "usergroups", $usergroupdata, "WHERE `usergroup_id` = {$kernel->vars['usergroup_id']}" );
					
					//logout everyone associated with this group, exclude the executing user if asociated.
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "sessions` WHERE `session_group_id` = {$kernel->vars['usergroup_id']} AND `session_user_id` != {$kernel->session['adminsession_user_id']}" );
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "sessions_admin` WHERE `adminsession_group_id` = {$kernel->vars['usergroup_id']} AND `adminsession_user_id` != {$kernel->session['adminsession_user_id']}" );
					
					$kernel->archive_function->update_database_counter( "usergroups" );
					
					//done
					$kernel->admin_function->message_admin_report( "lang_b_log_user_group_edited", $kernel->vars['usergroup_title'] );
				}
			}
		}
		
		break;
	}
	
	#############################################################################
	
	case "manage" :
	{
		if( isset( $_POST['form_delete'] ) OR $kernel->vars['usergroup_id'] > 0 )
		{
			$kernel->clean_array( "_POST", array( "usergroup_move_id" => V_INT ) );
			
			if( $kernel->vars['usergroup_move_id'] > 0 )
			{
				$kernel->admin_function->read_permission_flags( 35 );
				
				if( is_array( $_POST['checkbox'] ) )
				{
					foreach( $_POST['checkbox'] AS $usergroup )
					{
						if( $usergroup == $kernel->vars['usergroup_move_id'] ) continue;
						if( $usergroup == 1 ) continue;
						
						$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "users` SET `user_group_id` = {$kernel->vars['usergroup_move_id']} WHERE `user_group_id` = {$usergroup}" );
						$count++;
					}
				}
				else
				{
					$kernel->page_function->message_report( $kernel->ld['lang_b_checkbox_none_selected'], M_ERROR, HALT_EXEC );
				}
				
				$kernel->archive_function->update_database_counter( "usergroups" );
			}
			
			$delete_count = 0;
			
			$kernel->admin_function->read_permission_flags( 36 );
			
			//single item
			if( $kernel->vars['usergroup_id'] > 0 )
			{
				if( $kernel->vars['usergroup_id'] == $kernel->session['adminsession_group_id'] )
				{
					$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_delete_own_usergroup'], M_ERROR );
				}
				elseif( $kernel->vars['usergroup_id'] == 1 OR $kernel->vars['usergroup_id'] == 2 )
				{
					$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_delete_root_usergroup'], M_ERROR );
				}
				elseif( $kernel->vars['usergroup_id'] == -1 )
				{
					$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_delete_guest_usergroup'], M_ERROR );
				}
				else
				{
					$delete_data[] = $kernel->db->item( "SELECT `usergroup_title` FROM `" . TABLE_PREFIX . "usergroups` WHERE `usergroup_id` = {$kernel->vars['usergroup_id']}" );
					
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "usergroups` WHERE `usergroup_id` = {$kernel->vars['usergroup_id']}" );
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "sessions` WHERE `session_group_id` = {$kernel->vars['usergroup_id']}" );
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "sessions_admin` WHERE `adminsession_group_id` = {$kernel->vars['usergroup_id']}" );
					$delete_count++;
				}
			}
			
			//array items
			elseif( is_array( $_POST['checkbox'] ) )
			{
				foreach( $_POST['checkbox'] AS $usergroup )
				{
					if( $usergroup == $kernel->session['adminsession_group_id'] )
					{
						$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_delete_own_usergroup'], M_ERROR );
					}
					elseif( $usergroup == 1 OR $usergroup == 2 )
					{
						$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_delete_root_usergroup'], M_ERROR );
					}
					elseif( $usergroup == -1 )
					{
						$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_delete_guest_usergroup'], M_ERROR );
					}
					else
					{
						$delete_data[] = $kernel->db->item( "SELECT `usergroup_title` FROM `" . TABLE_PREFIX . "usergroups` WHERE `usergroup_id` = {$usergroup}" );
						
						$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "usergroups` WHERE `usergroup_id` = {$usergroup}" );
						$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "sessions` WHERE `session_group_id` = {$usergroup}" );
						$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "sessions_admin` WHERE `adminsession_group_id` = {$usergroup}" );
						$delete_count++;
					}
				}
			}
			else
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_checkbox_none_selected'], M_ERROR, HALT_EXEC );
			}
			
			if( $delete_count > 0 )
			{
				$kernel->archive_function->update_database_counter( "usergroups" );
				
				$kernel->admin_function->message_admin_report( "lang_b_log_user_group_deleted", $delete_count, $delete_data );
			}
		}
		
		###########################################################################
		
		elseif( isset( $_POST['form_move'] ) )
		{
			$kernel->admin_function->read_permission_flags( 35 );
			
			$kernel->clean_array( "_POST", array( "usergroup_move_id" => V_INT ) );
			
			if( is_array( $_POST['checkbox'] ) )
			{
				foreach( $_POST['checkbox'] AS $usergroup )
				{
					if( $usergroup == $kernel->vars['usergroup_move_id'] ) continue;
					
					$get_users = $kernel->db->query( "SELECT `user_name` FROM `" . TABLE_PREFIX . "users` WHERE `user_group_id` = {$usergroup}" );
					while( $user = $kernel->db->data( $get_users ) )
					{
						$move_data[] = $user['user_name'];
					}
					
					$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "users` SET `user_group_id` = {$kernel->vars['usergroup_move_id']} WHERE `user_group_id` = {$usergroup}" );
					
					$count = $kernel->db->affectrows();
				}
			}
			else
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_checkbox_none_selected'], M_ERROR, HALT_EXEC );
			}
			
			$kernel->archive_function->update_database_counter( "usergroups" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_user_moved", $count, $move_data );
		}
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$check_usergroups = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "usergroups` ORDER BY `usergroup_id`" );
		
		$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_usergroups ) );
		$current_group_id = -1;
		
		$kernel->tp->call( "admin_grou_header" );
		
		$get_usergroups = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "usergroups` ORDER BY `usergroup_id` LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
		
		while( $usergroup = $kernel->db->data( $get_usergroups ) )
		{
			$kernel->tp->call( "admin_grou_row" );
			
			$usergroup['usergroup_title'] = $kernel->format_input( $usergroup['usergroup_title'], T_DB );
			
			//setup user action button states
			$usergroup['usergroup_edit_button'] = $kernel->admin_function->button_status_if( ( $usergroup['usergroup_id'] == 1 ), $usergroup['usergroup_title'], "edit", $kernel->ld['lang_b_delete'], "?hash={$kernel->session['hash']}&node=grou_manage&usergroup_id={$usergroup['usergroup_id']}&action=edit" );
			$usergroup['usergroup_delete_button'] = $kernel->admin_function->button_status_if( ( $usergroup['usergroup_id'] == -1 OR $usergroup['usergroup_id'] == 1 OR $usergroup['usergroup_id'] == 2 ), $usergroup['usergroup_title'], "delete", $kernel->ld['lang_b_delete'], "?hash={$kernel->session['hash']}&node=grou_manage&usergroup_id={$usergroup['usergroup_id']}&action=manage" );
			
			//icons - user levels
			if( strpos( $usergroup['usergroup_panel_permissions'], "1" ) !== false )
			{
				$usergroup['usergroup_html_title'] = $kernel->admin_function->construct_icon( "user_mod.gif", $kernel->ld['lang_b_moderator'], true );
			}
			elseif( $usergroup['usergroup_id'] == 1 )
			{
				$usergroup['usergroup_html_title'] = $kernel->admin_function->construct_icon( "user_admin.gif", $kernel->ld['lang_b_administrator'], true );
			}
			elseif( $usergroup['usergroup_id'] == -1 )
			{
				$usergroup['usergroup_html_title'] = $kernel->admin_function->construct_icon( "user_guest.gif", $kernel->ld['lang_b_alt_guest'], true );
			}
			else
			{
				$usergroup['usergroup_html_title'] = $kernel->admin_function->construct_icon( "user_regular.gif", $kernel->ld['lang_b_user'], true );
			}
			
			//colour indicators
			if( $usergroup['usergroup_id'] == $kernel->session['adminsession_group_id'] AND $usergroup['usergroup_id'] == 1 )
			{
				$usergroup['usergroup_html_title'] .= $kernel->page_function->string_colour( $usergroup['usergroup_title'], "orange" );
			}
			elseif( $usergroup['usergroup_id'] == $kernel->session['adminsession_group_id'] )
			{
				$usergroup['usergroup_html_title'] .= $kernel->page_function->string_colour( $usergroup['usergroup_title'], "#33cc33" );
			}
			elseif( $usergroup['usergroup_id'] == 1 )
			{
				$usergroup['usergroup_html_title'] .= $kernel->page_function->string_colour( $usergroup['usergroup_title'], "red" );
			}
			else
			{
				$usergroup['usergroup_html_title'] .= $usergroup['usergroup_title'];
			}
			
			$kernel->tp->cache( $usergroup );
		}
		
		$kernel->tp->call( "admin_grou_footer" );
		
		$kernel->archive_function->construct_usergroup_options( 0, $kernel->db->query( "SELECT `usergroup_id`, `usergroup_title`, `usergroup_panel_permissions` FROM `" . TABLE_PREFIX . "usergroups` ORDER BY `usergroup_title`" ) );
		
		$kernel->page_function->construct_category_filters();
		
 		$kernel->vars['pagination_urls'] = array(
			"nextpage" => "index.php?hash={$kernel->session['hash']}&node=grou_manage&limit={$kernel->vars['limit']}&page={\$nextpage}",
			"previouspage" => "index.php?hash={$kernel->session['hash']}&node=grou_manage&limit={$kernel->vars['limit']}&page={\$previouspage}",
			"span" => "index.php?hash={$kernel->session['hash']}&node=grou_manage&limit={$kernel->vars['limit']}&page={\$page}",
			"start" => "index.php?hash={$kernel->session['hash']}&node=grou_manage&limit={$kernel->vars['limit']}&page=1",
			"end" => "index.php?hash={$kernel->session['hash']}&node=grou_manage&limit={$kernel->vars['limit']}&page={$kernel->vars['total_pages']}",
		);
		
		$kernel->page_function->construct_pagination( $kernel->vars['pagination_urls'], $kernel->config['admin_pagination_page_proximity'] );
		
		break;
	}
}

?>

