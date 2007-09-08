<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 23 );

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "create" :
	{
		$kernel->clean_array( "_REQUEST", array( "style_name" => V_STR, "style_description" => V_STR, "style_data" => V_STR ) );
		
		if( empty( $kernel->vars['style_name'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_style_no_name'], M_ERROR );
		}
		else
		{
			$styledata = array(
				"style_name" => $kernel->format_input( $kernel->vars['style_name'], T_DB ),
				"style_description" => $kernel->format_input( $kernel->vars['style_description'], T_DB ),
				"style_data" => $kernel->format_input( $kernel->vars['style_data'], T_DB ),
				"style_original" => $kernel->format_input( $kernel->vars['style_data'], T_DB )
			);
			
			$kernel->db->insert( "styles", $styledata );
			
			$kernel->archive_function->update_database_counter( "styles" );

			$kernel->admin_function->message_admin_report( "lang_b_log_style_added", $kernel->vars['style_name'] );
		}
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$kernel->tp->call( "admin_style_add" );
		
		break;
	}
}

?>

