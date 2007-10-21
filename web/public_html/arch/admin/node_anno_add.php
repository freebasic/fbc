<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 0 );

switch( $kernel->vars['action'] )
{
	#############################################################################

	case "create" :
	{
		$kernel->clean_array( "_REQUEST", array( "announcement_cat_id" => V_INT,
		"announcement_title" => V_STR, "announcement_data" => V_STR ) );
		
		if( empty( $kernel->vars['announcement_title'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_announcement_title'], M_ERROR );
		}
		else
		{
			$announcementdata = array(
				"announcement_cat_id" => $kernel->vars['announcement_cat_id'],
				"announcement_title" => $kernel->format_input( $kernel->vars['announcement_title'], T_DB ),
				"announcement_author" => $kernel->session['adminsession_name'],
				"announcement_data" => $kernel->archive_function->string_word_length_slice( $kernel->format_input( $kernel->vars['announcement_data'], T_DB ), $kernel->config['string_max_word_length'] ),
				"announcement_timestamp" => UNIX_TIME
			);
			
			$kernel->db->insert( "announcements", $announcementdata );
			
			$kernel->archive_function->update_database_counter( "announcements" );

			$kernel->admin_function->message_admin_report( "lang_b_log_announcement_added", $kernel->vars['announcement_title'] );
		}
		break;
	}
	
	#############################################################################
	
	default :
	{
		$kernel->tp->call( "admin_anno_add" );
		
		$kernel->page_function->construct_category_list( 0 );
		
		break;
	}
}

?>