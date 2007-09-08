<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

define ( "IN_ACP", true );

require_once( "../global.php" );

$kernel->clean_array( "_REQUEST", array( "hash" => V_STR, "node" => V_STR, "link" => V_STR, "action" => V_STR ) );

$kernel->db->query( "DELETE FROM " . TABLE_PREFIX . "sessions_admin WHERE adminsession_run_timestamp < ( " . UNIX_TIME . " - " . $kernel->config['control_panel_session_timeout'] . " )" );

if( !empty( $kernel->vars['hash'] ) )
{
	if( $kernel->admin_function->init_acp_session_driver( 0 ) == true )
	{
	
	#############################################################################
		
		if( !empty( $kernel->vars['node'] ) )
		{
			$node_array = array(
				"menu" => $kernel->ld['lang_b_node_menu'],
				"panel" => $kernel->ld['lang_b_node_control_panel'],
				"logout" => $kernel->ld['lang_b_node_logout'],
				"message" => $kernel->ld['lang_b_node_system_message'],
				"settings" => $kernel->ld['lang_b_node_setting_management'],
				"filetypes" => $kernel->ld['lang_b_node_filetype_management'],
				"search" => $kernel->ld['lang_b_node_quick_edit_search'],
				"anno_add" => $kernel->ld['lang_b_node_add_announcement'],
				"anno_manage" => $kernel->ld['lang_b_node_announcement_management'],
				"archive_report" => $kernel->ld['lang_b_node_archive_reports'],
				"archive_log" => $kernel->ld['lang_b_node_logs_management'],
				"db_backup" => $kernel->ld['lang_b_node_database_backup'],
				"db_recount" => $kernel->ld['lang_b_node_database_recount'],
				"db_console" => $kernel->ld['lang_b_node_database_console'],
				"db_tools" => $kernel->ld['lang_b_node_database_pruning_cleaning'],
				"db_statistics" => $kernel->ld['lang_b_node_database_statistics'],
				//"dir_info" => $kernel->ld['lang_b_node_database_statistics'], //Incomplete, don't uncomment
				"email" => $kernel->ld['lang_b_node_email_templates'],
				"file_add" => $kernel->ld['lang_b_node_add_file'],
				"file_mass_add" => $kernel->ld['lang_b_node_mass_add_file'],
				"file_manage" => $kernel->ld['lang_b_node_file_management'],
				"file_sub_manage" => $kernel->ld['lang_b_node_file_submission_management'],
				"file_validate" => $kernel->ld['lang_b_node_file_link_validity'],
				"file_upload" => $kernel->ld['lang_b_node_upload_file'],
				"fiel_add" => $kernel->ld['lang_b_node_add_field'],
				"fiel_manage" => $kernel->ld['lang_b_node_field_management'],
				"filt_add" => $kernel->ld['lang_b_node_add_filters'],
				"filt_manage" => $kernel->ld['lang_b_node_filters_management'],
				"filters" => $kernel->ld['lang_b_node_access_filer_management'],
				"grou_add" => $kernel->ld['lang_b_node_add_a_usergroup'],
				"grou_manage" => $kernel->ld['lang_b_node_usergroup_management'],
				"docu_add" => $kernel->ld['lang_b_node_add_document'],
				"docu_manage" => $kernel->ld['lang_b_node_document_management'],
				"cate_add" => $kernel->ld['lang_b_node_create_a_category'],
				"cate_manage" => $kernel->ld['lang_b_node_category_management'],
				"cate_order" => $kernel->ld['lang_b_node_category_order_management'],
				"comm_manage" => $kernel->ld['lang_b_node_comment_management'],
				"gall_add" => $kernel->ld['lang_b_node_add_gallery'],
				"gall_manage" => $kernel->ld['lang_b_node_gallery_management'],
				"imag_add" => $kernel->ld['lang_b_node_add_image'],
				"imag_manage" => $kernel->ld['lang_b_node_image_management'],
				"imag_mass_add" => $kernel->ld['lang_b_node_mass_add_image'],
				"temp_add" => $kernel->ld['lang_b_node_mass_create_a_theme'],
				"temp_manage" => $kernel->ld['lang_b_node_theme_management'],
				"temp_imp_exp" => $kernel->ld['lang_b_node_theme_import_export'],
				"styl_add" => $kernel->ld['lang_b_node_create_a_style'],
				"styl_manage" => $kernel->ld['lang_b_node_style_management'],
				"styl_imp_exp" => $kernel->ld['lang_b_node_style_import_export'],
				"system_log" => $kernel->ld['lang_b_node_system_logs'],
				"user_add" => $kernel->ld['lang_b_node_add_a_user'],
				"user_manage" => $kernel->ld['lang_b_node_user_management'],
				"version" => $kernel->ld['lang_b_node_version'],
				"" => $kernel->ld['lang_b_node_unknown']
			);
			
			if( is_dir( "./../install" ) AND $kernel->vars['node'] != "menu" AND $kernel->vars['node'] != "version" AND $kernel->vars['node'] != "message" AND $kernel->vars['node'] != "file_validate" )
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_delete_install_folder'], M_WARNING );
			}
			
			if( !is_dir( $kernel->config['system_root_dir_upload'] ) AND $kernel->vars['node'] != "menu" AND $kernel->vars['node'] != "version" AND $kernel->vars['node'] != "message" )
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_invalid_upload_folder'], M_ERROR );
			}
			
	#############################################################################
			
			if( $kernel->vars['node'] == "phpinfo" )
			{
				$kernel->admin_function->read_permission_flags( -1 );
				
				if( IN_DEMO_MODE == true )
				{
					$kernel->page_function->message_report( "Feature disabled in Demo Mode.", M_ERROR, HALT_EXEC );
				}
				
				phpinfo(); exit;
			}
			elseif( isset( $node_array[ $kernel->vars['node'] ] ) )
			{
				if( ( file_exists( ROOT_PATH . "admin/node_" . $kernel->vars['node'] . ".php" ) AND SAFE_MODE == false ) OR is_file( ROOT_PATH . "admin/node_" . $kernel->vars['node'] . ".php" ) )
				{
					require( ROOT_PATH . "admin/node_" . $kernel->vars['node'] . ".php" );
				}
				else
				{
					$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_node_missing'], $kernel->vars['node'] ), M_ERROR );
				}
			}
			else
			{
				$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_node_non_existant'], $kernel->vars['node'] ), M_ERROR );
			}
		}
		
	#############################################################################
		
		elseif( !empty( $kernel->vars['link'] ) )
		{
			$link_array = array(
				"archive" 		=> $kernel->config['system_root_url_path'] . "/index.php",
				"phpcredo" 		=> "http://www.phpcredo.com/index.php"
			);
			
			if( isset( $link_array[ $kernel->vars['link'] ] ) )
			{
				header( "Location: " . $link_array[ $kernel->vars['link'] ] ); exit;
			}
			else
			{
				$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_link_non_existant'], $kernel->vars['link'] ), M_ERROR );
			}
		}
		else
		{
			$kernel->tp->call( "admin_cp_frames" );
			
			$kernel->page_function->construct_output( false, false, false, false );
		}
	}
}

	#############################################################################

elseif( $_POST['login'] )
{
	$kernel->clean_array( "_POST", array( "password" => V_MD5, "username" => V_STR ) );
	
	$panel = $kernel->db->row( "SELECT u.user_name FROM " . TABLE_PREFIX . "users u WHERE u.user_name = '" . $kernel->vars['username'] . "'" );
	
	if( ( $kernel->config['admin_session_sensitive_username'] == "true" AND $panel['user_name'] != $kernel->vars['username'] ) OR ( $kernel->config['admin_session_sensitive_username'] == "false" AND strtolower( $panel['user_name'] ) != strtolower( $kernel->vars['username'] ) ) )
	{
		$kernel->admin_function->construct_user_login( $kernel->ld['lang_b_bad_login_username'] );
	}
	else
	{
		$check_user_data = $kernel->db->query( "SELECT u.user_id, u.user_group_id, u.user_name, g.usergroup_panel_permissions, g.usergroup_archive_permissions FROM " . TABLE_PREFIX . "users u LEFT JOIN " . TABLE_PREFIX . "usergroups g ON ( u.user_group_id = g.usergroup_id ) WHERE u.user_name = '" . $kernel->vars['username'] . "' AND u.user_password = '" . $kernel->vars['password'] . "'" );
		
		if( $kernel->db->numrows() == 0 )
		{
			$kernel->admin_function->construct_user_login( $kernel->ld['lang_b_bad_login_password'] );
		}
		else
		{
			$panel = $kernel->db->data( $check_user_data );
			
			if( $panel['user_group_id'] != 1 AND strpos( $panel['usergroup_panel_permissions'], "1" ) === false )
			{
				$kernel->admin_function->construct_user_login( $kernel->ld['lang_b_no_access'] );
			}
			else
			{
				$kernel->db->query( "DELETE FROM " . TABLE_PREFIX . "sessions_admin WHERE adminsession_name = '" . $kernel->vars['username'] . "'" );
				
				$new_cp_hash = md5( uniqid( rand() ) );
				
				$paneldata = array( 
					"adminsession_hash"						=> $new_cp_hash,
					"adminsession_group_id"				=> $panel['user_group_id'],
					"adminsession_user_id"				=> $panel['user_id'],
					"adminsession_ip_address"			=> IP_ADDRESS,
					"adminsession_name"						=> $panel['user_name'],
					"adminsession_password"				=> $kernel->vars['password'],
					"adminsession_agent"					=> HTTP_AGENT,
					"adminsession_timestamp"			=> UNIX_TIME,
					"adminsession_run_timestamp"	=> UNIX_TIME,
					"adminsession_permissions"		=> $panel['usergroup_panel_permissions']
				);
				
				$kernel->db->insert( "sessions_admin", $paneldata );
				
				//user name for login screen
				setcookie( "phcdl_acp_user_name", $panel['user_name'], UNIX_TIME + ( 86400 * 365 ), "/", HTTP_HOST );
				
				//show login success screen and redirect
				$kernel->tp->call( "admin_login_notice" );
				
				$kernel->session['hash'] = $new_cp_hash;
				$kernel->session['user_name'] = $panel['user_name'];
			}
		}
	}	
}
else
{
	$kernel->admin_function->construct_user_login( $kernel->ld['lang_b_no_session'] );
}

	#############################################################################

$return_header = $return_footer = false;

if( !empty( $kernel->vars['node'] ) AND !isset( $_POST['login'] ) AND $kernel->vars['node'] != "version" AND $kernel->vars['node'] != "menu" )
{
	$return_header = R_HEADER;
	
	if( isset( $node_array[ $kernel->vars['node'] ] ) AND $kernel->vars['node'] != "message" )
	{
		$kernel->vars['page_struct']['system_page_action_title'] = $node_array[ $kernel->vars['node'] ];
	}
	
	$kernel->vars['page_struct']['system_page_title'] = $kernel->config['archive_name'];
}

if( $kernel->vars['node'] != "version" AND $kernel->vars['node'] != "menu" )
{
	$return_footer = R_FOOTER;
}

$kernel->page_function->construct_output( $return_header, $return_footer, false, false );

?>