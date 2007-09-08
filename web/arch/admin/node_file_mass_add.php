<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 14 );

$kernel->clean_array( "_REQUEST", array( "current_directory" => V_STR, "file_cat_id" => V_INT ) );

switch( $kernel->vars['action'] )
{

	#############################################################################
	
	case "create" :
	{
		//@set_time_limit( 300 ); //5 minutes, parsing alot of files can take a while.
		
		if( empty( $kernel->vars['file_cat_id'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_category_selected'], M_WARNING );
		}
		elseif( !is_array( $_POST['files'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_files_selected_adding'], M_ERROR );
		}
		else
		{
			$count = 0;
			$last_file = "";
			
			//build URL to the specified upload folder, base upload folder url. add sub directories if applicable.
			$file_base_url = $kernel->config['system_root_url_upload'] . $kernel->vars['current_directory'] . DIR_STEP;
			$file_full_url = $kernel->config['system_root_url_upload'] . substr( $file_base_url, strlen( $kernel->config['system_root_url_upload'] ), strlen( $file_base_url ) );
			
			//conver backslashes into forward slashes for windows servers.
			$file_full_url = preg_replace( "/\\\\/", "/", $file_full_url );
			
			//add trailing slash if it doesnt exist.
			preg_match( "/\/$/", $file_full_url, $matches );
			
			if( !isset( $matches[0] ) ) $file_full_url .= "/";
			
			//Add the files
			foreach( $_POST['files'] AS $file )
			{
				$file_info = $kernel->archive_function->file_url_info( $file );
				
				//filetype not allowed
    		if( $kernel->config['allow_unknown_url_linking'] == 0 AND $file_info['file_type_exists'] == false AND $kernel->session['adminsession_group_id'] <> 1 ) continue;
				
				$file_name = $file_info['file_name'];
				
				if( $file_name == $last_file ) continue; //last file could be added twice without this, i still don't know why
				
				//$file_icon = $file_info['file_icon'];
				$file_icon = "0";
				
				$file_size = @filesize( $kernel->config['system_root_dir_upload'] . $kernel->vars['current_directory'] . DIR_STEP . $file );
				
				if( empty( $file_size ) )
				{					
					$file_size = 0;
				}
				
				$filedata = array(
					"file_cat_id" => $kernel->vars['file_cat_id'],
					"file_pinned" => 0,
					"file_icon" => $file_icon,
					"file_name" => $kernel->format_input( $file_name, T_DB ),
					"file_author" => $kernel->format_input( $kernel->session['adminsession_name'], T_DB ),
					"file_version" => "",
					"file_description" => "",
					"file_timestamp" => UNIX_TIME,
					"file_mark_timestamp" => UNIX_TIME,
					"file_rating" => 0,
					"file_votes" => 0,
					"file_downloads" => 0,
					"file_dl_limit" => 0,
					"file_size" => $file_size,
					"file_doc_id" => 0,
					"file_dl_url" => $kernel->format_input( $file_full_url . $file, T_DB )
				);
				
				$kernel->db->insert( "files", $filedata );
				
				$add_data[] = $file_name;
				
				$count++;
				$last_file = $file_name;
			}
			
			//resync categories and other bits
			$kernel->archive_function->update_category_file_total( $kernel->vars['file_cat_id'] );
			$kernel->archive_function->update_category_file_latest( $kernel->vars['file_cat_id'] );
			
			$kernel->archive_function->global_category_db_syncronisation( 0 );
			
			$kernel->archive_function->update_database_counter( "files" );
			$kernel->archive_function->update_database_counter( "data" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_mass_file_added", $count, $add_data );
		}
		break;
	}
	
	#############################################################################
	
	default :
	{
		if( !@opendir( $kernel->config['system_root_dir_upload'] . $kernel->vars['current_directory'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_unable_to_read_folder'], M_ERROR );
		}
		else
		{			
			$kernel->tp->call( "admin_file_mass_add" );
		
			$kernel->page_function->construct_category_list( 0 );
			
			//Get files
			$kernel->vars['html']['directory_list_options'] = "<option value=\"\">" . DIR_STEP . " {$kernel->ld['lang_b_upload_dir_root']}</option>\r\n";
			
			//build upload directory tree
			$kernel->admin_function->read_directory_tree( $kernel->config['system_root_dir_upload'], $kernel->vars['current_directory'] );
			
			//read current folder
			$kernel->admin_function->read_upload_directory_index( $kernel->config['system_root_dir_upload'] . $kernel->vars['current_directory'], 0 );
			
			$kernel->tp->cache( "current_directory", $kernel->vars['current_directory'] );
			$kernel->tp->cache( "system_root_dir_upload", $kernel->config['system_root_dir_upload'] );
		}
		break;
	}
}

?>

