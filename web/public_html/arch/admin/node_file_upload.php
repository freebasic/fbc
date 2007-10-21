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

$kernel->clean_array( "_REQUEST", array( "current_directory" => V_STR ) );

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "create" :
	{
		//file link method not provided
		if( empty( $_FILES['file_upload']['name'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_url_local_file_upload'], M_ERROR, HALT_EXEC );
		}
		
		//prep file data for updating
		$file_info = $kernel->archive_function->file_url_info( $_FILES['file_upload']['name'] );
		
		//check for upload errors
		$kernel->page_function->verify_upload_details( null );
		
		//filetype not allowed
		if( $kernel->config['allow_unknown_url_linking'] == 0 AND $file_info['file_type_exists'] == false AND $kernel->session['adminsession_group_id'] <> 1 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_bad_filetype'], M_ERROR, HALT_EXEC );
		}
		
  	//build URL to the specified upload folder, base upload folder url.
  	$kernel->vars['current_directory'] = $kernel->config['system_root_dir_upload'] . $kernel->vars['current_directory'] . DIR_STEP;
  	
  	//add sub directories if applicable.
  	$file_base_url = $kernel->config['system_root_dir_upload'] . substr( $kernel->vars['current_directory'], strlen( $kernel->config['system_root_dir_upload'] ), strlen( $kernel->vars['current_directory'] ) );
		
		//check for exisiting files under provided file name
		$new_file_name = $kernel->page_function->construct_upload_file_name( $_FILES['file_upload']['name'], $file_base_url );
		
		//upload
		if( !move_uploaded_file( $_FILES['file_upload']['tmp_name'], $file_base_url . $new_file_name ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_could_not_move_upload_file'], M_CRITICAL_ERROR );
		}
		
		$kernel->admin_function->message_admin_report( "lang_b_log_file_uploaded", $new_file_name );
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$kernel->tp->call( "admin_file_upload" );
		
		$kernel->tp->cache( "upload_size", $kernel->archive_function->format_round_bytes( MAX_UPLOAD_SIZE ) );
		
		$kernel->vars['html']['directory_list_options'] = "<option value=\"\">" . DIR_STEP . " {$kernel->ld['lang_b_upload_dir_root']}</option>\r\n";
		
		//build upload directory tree
		$kernel->admin_function->read_directory_tree( $kernel->config['system_root_dir_upload'] );
		
		break;
	}
}

?>

