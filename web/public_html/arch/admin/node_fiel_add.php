<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 8 );

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "create" :
	{
		$kernel->clean_array( "_REQUEST", array( "field_type" => V_STR, "field_category_display" => V_INT,
		"field_file_display" => V_INT, "field_submit_display" => V_INT, "field_name" => V_STR,
		"field_description" => V_STR, "field_options" => V_STR, "field_data_rule" => V_STR ) );
		
		if( empty( $kernel->vars['field_name'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_custom_field_name'], M_ERROR );
		}
		else
		{
			$fielddata = array(
				"field_type" => $kernel->vars['field_type'],
				"field_category_display" => $kernel->vars['field_category_display'],
				"field_file_display" => $kernel->vars['field_file_display'],
				"field_submit_display" => $kernel->vars['field_submit_display'],
				"field_name" => $kernel->format_input( $kernel->vars['field_name'], T_DB ),
				"field_description" => $kernel->format_input( $kernel->vars['field_description'], T_DB ),
				"field_options" => $kernel->format_input( $kernel->vars['field_options'], T_DB ),
				"field_data_rule" => $kernel->vars['field_data_rule']
			);
			
			$kernel->db->insert( "fields", $fielddata );
			
			$kernel->archive_function->update_database_counter( "fields" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_custom_field_added", $kernel->vars['field_name'] );
		}
		break;
	}
	
	#############################################################################
	
	default :
	{
		$kernel->tp->call( "admin_fiel_add" );
	}
}

?>

