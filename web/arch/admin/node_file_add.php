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

switch( $kernel->vars['action'] )
{

	#############################################################################
	
	case "create" :
	{
		//error-check custom fields
		$kernel->archive_function->verify_custom_field_values( $_POST );
		
		//clean db associated vars
		$kernel->clean_array( "_POST", array(
			"file_doc_id" => V_INT, "file_dl_limit" => V_INT, "file_cat_id" => V_INT,
			"file_pinned" => V_INT, "file_gallery_id" => V_INT, "file_name" => V_STR,
			"file_icon" => V_STR, "file_author" => V_STR, "file_dl_url" => V_STR,
			"file_version" => V_STR, "file_description" => V_STR, "file_size" => V_INT,
			"file_disabled" => V_INT, "file_size" => V_INT, "file_rating" => V_INT,
			"file_votes" => V_INT, "file_downloads" => V_INT, "file_local_dl_url" => V_STR,
			"file_hash_data" => V_STR, "current_directory" => V_STR
		) );
		
		//file link method not provided
		if( $kernel->vars['file_dl_url'] == $kernel->config['system_root_url_upload'] . "/" AND empty( $_FILES['file_upload']['name'] ) AND empty( $kernel->vars['file_local_dl_url'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_url_local_file_upload'], M_ERROR, HALT_EXEC );
		}
		
		//Attempting to add a file outside/behind the upload URL folder.
  	if( strstr( $kernel->vars['file_dl_url'], $kernel->config['system_root_url_home'] ) == true AND strstr( $kernel->vars['file_dl_url'], $kernel->config['system_root_url_upload'] ) != true AND $kernel->session['adminsession_group_id'] <> 1 )
  	{
  		$kernel->page_function->message_report( $kernel->ld['lang_b_url_outside_upload_folder'], M_ERROR, HALT_EXEC );
  	}
		
		//Attempting to add a file outside/behind the upload DIR folder.
  	if( ( $kernel->vars['file_dl_url']{1} == ":" OR $kernel->vars['file_dl_url']{0} == "/" OR $kernel->vars['file_dl_url']{0} == "\\" ) AND $kernel->session['adminsession_group_id'] <> 1 )
  	{
  		$kernel->page_function->message_report( $kernel->ld['lang_b_url_outside_upload_folder'], M_ERROR, HALT_EXEC );
  	}
		
		//no category specified
		if( $kernel->vars['file_cat_id'] == 0 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_category_selected'], M_ERROR, HALT_EXEC );
		}
		
		//local uploaded file has been selected
		if( !empty( $kernel->vars['file_local_dl_url'] ) )
		{
			$kernel->vars['file_dl_url'] = $config['system_root_url_upload'] . "/" . $kernel->vars['file_local_dl_url'];
		}
		
		//prep file data for updating
		if( !empty( $_FILES['file_upload']['name'] ) )
		{
			$file_info = $kernel->archive_function->file_url_info( $_FILES['file_upload']['name'] );
		}
		elseif( !empty( $kernel->vars['file_local_dl_url'] ) )
		{
			$file_info = $kernel->archive_function->file_url_info( $kernel->vars['file_local_dl_url'] );
		}
		else
		{
			$file_info = $kernel->archive_function->file_url_info( $kernel->vars['file_dl_url'] );
		}
		
		//check for upload errors if applicable
		$kernel->page_function->verify_upload_details( null );
		
		//filetype not allowed
		if( $kernel->config['allow_unknown_url_linking'] == 0 AND $file_info['file_type_exists'] == false AND $kernel->session['adminsession_group_id'] <> 1 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_bad_filetype'], M_ERROR, HALT_EXEC );
		}
		
		//Flag for mirror construct to parse for hashes..
		$kernel->vars['form_resync_mirrors'] = "1";
		
		###########################################################################
		# Upload
		
  	if( !empty( $_FILES['file_upload']['name'] ) )
  	{
    	//build URL to the specified upload folder, base upload folder url. add sub directories if applicable. (DIR upload path)
    	$file_base_dir = $kernel->config['system_root_dir_upload'] . $kernel->vars['current_directory'] . DIR_STEP;
    	$file_full_dir = $kernel->config['system_root_dir_upload'] . substr( $file_base_dir, strlen( $kernel->config['system_root_dir_upload'] ), strlen( $file_base_dir ) );
			
			//build URL base upload folder url. add sub directories if applicable. (URL upload path)
    	$file_base_url = $kernel->config['system_root_url_upload'] . $kernel->vars['current_directory'] . DIR_STEP;
			$file_full_url = $kernel->config['system_root_url_upload'] . substr( $file_base_url, strlen( $kernel->config['system_root_url_upload'] ), strlen( $file_base_url ) );
			
			//conver backslashes into forward slashes for windows servers.
			$file_full_url = preg_replace( "/\\\\/", "/", $file_full_url );
			
			//add trailing slash if it doesnt exist.
			preg_match( "/\/$/", $file_full_url, $matches );
			
			if( !isset( $matches[0] ) ) $file_full_url .= "/";
			
  		//check for exisiting files under provided file name
  		$new_file_name = $kernel->page_function->construct_upload_file_name( $_FILES['file_upload']['name'], $file_full_url );
			
			//upload
  		if( !@move_uploaded_file( $_FILES['file_upload']['tmp_name'], $file_full_dir . $new_file_name ) )
  		{
  			$kernel->page_function->message_report( $kernel->ld['lang_b_could_not_move_upload_file'], M_CRITICAL_ERROR );
  		}
  		else
  		{
  			$kernel->vars['file_dl_url'] = $file_full_url . $new_file_name;
  			
  			if( empty( $kernel->vars['file_name'] ) )
  			{
  				$kernel->vars['file_name'] = $new_file_name;
  			}
  			
  			$kernel->vars['file_size'] = $_FILES['file_upload']['size'];
  		}
  	}
		
  	###########################################################################
  	# URL
		
  	else
  	{
  		if( empty( $kernel->vars['file_name'] ) )
  		{
  			$kernel->vars['file_name'] = $file_info['file_name'];
  		}
  		
  		if( $_POST['option_parse_file'] == "1" )
  		{
  			$kernel->vars['file_size'] = $kernel->archive_function->parse_url_size( $kernel->vars['file_dl_url'], $config['system_parse_timeout'] );
				
				$kernel->vars['file_hash_data'] = $kernel->archive_function->exec_file_hash( $kernel->vars['file_dl_url'] ) . "," . $kernel->archive_function->exec_file_hash( $kernel->vars['file_dl_url'], false );
  		}
  	}
  	
  	$filedata = array(
  		"file_cat_id" => $kernel->vars['file_cat_id'],
  		"file_gallery_id" => $kernel->vars['file_gallery_id'],
  		"file_pinned" => $kernel->vars['file_pinned'],
  		"file_icon" => $kernel->vars['file_icon'],
  		"file_name" => $kernel->format_input( $kernel->vars['file_name'], T_DB ),
  		"file_author" => $kernel->format_input( $kernel->vars['file_author'], T_DB ),
  		"file_version" => $kernel->format_input( $kernel->vars['file_version'], T_DB ),
  		"file_description" => $kernel->archive_function->string_word_length_slice( $kernel->format_input( $kernel->vars['file_description'], T_DB ), $kernel->config['string_max_word_length'] ),
  		"file_timestamp" => UNIX_TIME,
  		"file_mark_timestamp" => UNIX_TIME,
  		"file_rating" => 0,
  		"file_votes" => 0,
  		"file_downloads" => 0,
  		"file_dl_limit" => $kernel->vars['file_dl_limit'],
  		"file_size" => $kernel->vars['file_size'],
  		"file_doc_id" => $kernel->vars['file_doc_id'],
  		"file_dl_url" => $kernel->format_input( $kernel->vars['file_dl_url'], T_DB ),
			"file_hash_data" => $kernel->vars['file_hash_data']
  	);
  	
  	if( is_array( $_POST['images'] ) )
  	{
  		$filedata['file_image_array'] = implode( ",", $_POST['images'] );
  	}
  	
		//update file data
  	$kernel->db->insert( "files", $filedata );
		
		$file_id = $kernel->db->item( "SELECT `file_id` FROM	`" . TABLE_PREFIX . "files` ORDER BY `file_id` DESC LIMIT 1" );
  	
  	//write file mirrors	
  	$kernel->admin_function->construct_db_write_download_mirrors( $file_id, $_POST );
  	
		//write file custom fields
  	$kernel->archive_function->construct_db_write_custom_fields( $file_id, $_POST );
  	
  	//resync categories and other bits
  	$kernel->archive_function->update_category_file_total( $kernel->vars['file_cat_id'] );
  	$kernel->archive_function->update_category_file_latest( $kernel->vars['file_cat_id'] );
  	
  	$kernel->archive_function->global_category_db_syncronisation( 0 );
  	
  	$kernel->archive_function->update_database_counter( "files" );
  	$kernel->archive_function->update_database_counter( "fields_data" );
  	$kernel->archive_function->update_database_counter( "data" );
		
		//done
  	$kernel->admin_function->message_admin_report( "lang_b_log_file_added", $kernel->vars['file_name'] );
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		if( $kernel->config['system_file_add_form_type'] == "0" )
		{
			$kernel->tp->call( "admin_file_add_lofi" );
		}
		else
		{
			$kernel->tp->call( "admin_file_add" );
		}
		
		$kernel->page_function->construct_category_list();
		
		if( $kernel->config['system_file_add_form_type'] == "1" )
		{
			$kernel->archive_function->construct_list_options( 0, "document", $kernel->db->query( "SELECT `document_id`, `document_title` FROM `" . TABLE_PREFIX . "documents` ORDER BY `document_title`" ) );
			$kernel->archive_function->construct_list_options( 0, "gallery", $kernel->db->query( "SELECT `gallery_id`, `gallery_name` FROM `" . TABLE_PREFIX . "galleries` ORDER BY `gallery_name`" ) );
			$kernel->archive_function->construct_list_options( 0, "image", $kernel->db->query( "SELECT `image_id`, `image_name` FROM `" . TABLE_PREFIX . "images` ORDER BY `image_name`" ) );
			
			$kernel->archive_function->construct_file_icon_selector( null );
			
			$kernel->admin_function->read_upload_directory_index( $kernel->config['system_root_dir_upload'] . DIR_STEP );
			
			$kernel->archive_function->construct_file_custom_fields_form( 0 );
			
			$kernel->archive_function->construct_file_download_mirror_form( 0 );
		}
		
		$kernel->tp->cache( "upload_size", $kernel->archive_function->format_round_bytes( MAX_UPLOAD_SIZE ) );
		
		$kernel->tp->cache( "system_root_url_upload", $kernel->config['system_root_url_upload'] );
		
		$kernel->vars['html']['directory_list_options'] = "<option value=\"\">" . DIR_STEP . " {$kernel->ld['lang_b_upload_dir_root']}</option>\r\n";
		
		//build upload directory tree
		$kernel->admin_function->read_directory_tree( $kernel->config['system_root_dir_upload'] );
		
		break;
	}
}

?>

