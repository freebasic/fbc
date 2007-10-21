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

$kernel->clean_array( "_REQUEST", array( "page" => V_PINT, "limit" => V_PINT, "sort" => V_STR, "order" => V_STR, "start" => V_PINT, "filter" => V_STR, "log_author" => V_STR, "log_group" => V_STR ) );

$kernel->vars['page'] = ( $kernel->vars['page'] < 1 ) ? 1 : $kernel->vars['page'];
$kernel->vars['limit'] = ( $kernel->vars['limit'] < 1 ) ? $kernel->config['admin_display_default_limit'] : $kernel->vars['limit'];

if( empty( $kernel->vars['sort'] ) ) $kernel->vars['sort'] = "file_name";
if( empty( $kernel->vars['order'] ) ) $kernel->vars['order'] = "asc";
if( empty( $kernel->vars['filter'] ) ) $kernel->vars['filter'] = "today";

$kernel->tp->call( "admin_sys_logs" );

//build date filters
$kernel->archive_function->construct_date_list_options( $kernel->vars['filter'] );

//build usergroup list
$kernel->db->query( "SELECT `usergroup_id`, `usergroup_title`, `usergroup_panel_permissions` FROM `" . TABLE_PREFIX . "usergroups` ORDER BY `usergroup_title`" );

$usergroups[] = 1;

while( $usergroup = $kernel->db->data() )
{
	//moderator usergroup, add to array for user filter list
	if( strpos( $usergroup['usergroup_panel_permissions'], "1" ) !== false )
	{
		$usergroups[] = $usergroup['usergroup_id'];
	} 
}

//return user list options with user_name as the value, not id (hence the OPT_USER_NAME flag)
$kernel->archive_function->construct_user_options( $kernel->vars['log_author'], $usergroups, OPT_USER_NAME );

//build node group list
$menu_selected[ 'group_' . $kernel->vars['log_group'] ] = " selected=\"selected\"";

$kernel->tp->cache( "node_list_options", "<option value=\"\">{$kernel->ld['lang_b_menu_all_groups']}</option>\r\n<optgroup label=\"{$kernel->ld['lang_b_menu_choose_user_group']}\">\r\n<option value=\"anno\" {$menu_selected['group_anno']}>{$kernel->ld['lang_b_menu_title_announcements']}</option>\r\n<option value=\"comm\" {$menu_selected['group_comm']}>{$kernel->ld['lang_b_menu_title_comments']}</option>\r\n<option value=\"fiel\" {$menu_selected['group_fiel']}>{$kernel->ld['lang_b_menu_title_custom_fields']}</option>\r\n<option value=\"cate\" {$menu_selected['group_cate']}>{$kernel->ld['lang_b_menu_title_categories']}</option>\r\n<option value=\"docu\" {$menu_selected['group_docu']}>{$kernel->ld['lang_b_menu_title_documents']}</option>\r\n<option value=\"file\" {$menu_selected['group_file']}>{$kernel->ld['lang_b_menu_title_files']}</option>\r\n<option value=\"gall\" {$menu_selected['group_gall']}>{$kernel->ld['lang_b_menu_title_galleries']}</option>\r\n<option value=\"imag\" {$menu_selected['group_imag']}>{$kernel->ld['lang_b_menu_title_images']}</option>\r\n<option value=\"main\" {$menu_selected['group_main']}>{$kernel->ld['lang_b_menu_title_maintenance']}</option>\r\n<option value=\"temp\" {$menu_selected['group_temp']}>{$kernel->ld['lang_b_menu_title_themes']}</option>\r\n<option value=\"styl\" {$menu_selected['group_styl']}>{$kernel->ld['lang_b_menu_title_styles']}</option>\r\n<option value=\"user\" {$menu_selected['group_user']}>{$kernel->ld['lang_b_menu_title_users']}</option>\r\n<option value=\"grou\" {$menu_selected['group_grou']}>{$kernel->ld['lang_b_menu_title_usergroups']}</option>\r\n" );

switch( $kernel->vars['action'] )
{
	#############################################################################

	case "view" :
	{
		$filter_query = $kernel->archive_function->construct_db_timestamp_filter( $kernel->vars['filter'] );
		
		if( $kernel->vars['filter'] == "today" OR intval( $kernel->vars['filter'] ) <> 0 AND strlen( intval( $kernel->vars['filter'] ) ) === strlen( $kernel->vars['filter'] ) )
		{
			$kernel->vars['html']['search_filter'] = date( "Y M d", $filter_query[1] );
		}
		else
		{
			$kernel->vars['html']['search_filter'] = date( "Y M d", $filter_query[1] ) . " to " . date( "Y M d", $filter_query[2] );
		}
		
		if( !empty( $kernel->vars['log_author'] ) )
		{
			$user_code = "AND l.log_author = '{$kernel->vars['log_author']}'";
		}
		
		if( !empty( $kernel->vars['log_group'] ) )
		{
			$group_code = "AND l.log_node LIKE '%{$kernel->vars['log_group']}%'";
		}
		
		$check_logs = $kernel->db->query( "SELECT l.* FROM " . TABLE_PREFIX . "logs_admin l WHERE {$filter_query[0]} {$user_code} {$group_code} ORDER BY l.log_id DESC" );
		
		if( $kernel->db->numrows() == 0 )
		{
			$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_no_logs_found'], $kernel->vars['html']['search_filter'] ), M_ERROR );
		}
		else
		{
			$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_logs ) );
			
			$kernel->tp->call( "admin_sys_log_header" );
			
			$get_log_entries = $kernel->db->query( "SELECT l.* FROM " . TABLE_PREFIX . "logs_admin l WHERE {$filter_query[0]} {$user_code} {$group_code} ORDER BY l.log_id DESC LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
			
			while( $log = $kernel->db->data( $get_log_entries ) )
			{
				$kernel->tp->call( "admin_sys_log_row" );
				
				$log['log_timestamp'] = $kernel->fetch_time( $log['log_timestamp'], DF_LONG );
				$log['log_phrase'] = sprintf( $kernel->ld[ $log['log_phrase'] ], $log['log_reference'] );
				$log['log_node'] = isset( $node_array[ $log['log_node'] ] ) ? $node_array[ $log['log_node'] ] : $log['log_node'];
				
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
				
				if( $log['log_data'] != $log['log_reference'] AND $log['log_data'] != "0" )
				{
					$log['log_data'] = "<br /><img width=\"100%\" height=\"15\" border=\"0\" src=\"../images/break.gif\" alt=\"\" /><br /><b>" . $log['log_data'] . "</b>";
				}
				else
				{
					$log['log_data'] = "";
				}
				
				$kernel->tp->cache( $log );
			}
			
			$kernel->tp->call( "admin_sys_log_footer" );
			
	 		$kernel->vars['pagination_urls'] = array(
				"nextpage" => "index.php?hash={$kernel->session['hash']}&node=system_log&action=view&filter={$kernel->vars['filter']}&log_author={$kernel->vars['log_author']}&log_group={$kernel->vars['log_group']}&limit={$kernel->vars['limit']}&page={\$nextpage}",
				"previouspage" => "index.php?hash={$kernel->session['hash']}&node=system_log&action=view&filter={$kernel->vars['filter']}&log_author={$kernel->vars['log_author']}&log_group={$kernel->vars['log_group']}&limit={$kernel->vars['limit']}&page={\$previouspage}",
				"span" => "index.php?hash={$kernel->session['hash']}&node=system_log&action=view&filter={$kernel->vars['filter']}&log_author={$kernel->vars['log_author']}&log_group={$kernel->vars['log_group']}&limit={$kernel->vars['limit']}&page={\$page}",
				"start" => "index.php?hash={$kernel->session['hash']}&node=system_log&action=view&filter={$kernel->vars['filter']}&log_author={$kernel->vars['log_author']}&log_group={$kernel->vars['log_group']}&limit={$kernel->vars['limit']}&page=1",
				"end" => "index.php?hash={$kernel->session['hash']}&node=system_log&action=view&filter={$kernel->vars['filter']}&log_author={$kernel->vars['log_author']}&log_group={$kernel->vars['log_group']}&limit={$kernel->vars['limit']}&page={$kernel->vars['total_pages']}",
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

