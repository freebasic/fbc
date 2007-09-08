<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 28 );

$kernel->clean_array( "_REQUEST", array( "theme_name" => V_STR, "theme_description" => V_STR, "theme_id" => V_INT ) );

switch( $kernel->vars['action'] )
{

	#############################################################################
	
	case "create" :
	{		
		if( empty( $kernel->vars['theme_name'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_theme_no_name'], M_WARNING );
		}
		elseif( $kernel->vars['theme_id'] == 0 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_theme_no_source_theme'], M_WARNING );
		}
		else
		{
			$themedata = array(
				"theme_name" => $kernel->format_input( $kernel->vars['theme_name'], T_DB ),
				"theme_description" => $kernel->format_input( $kernel->vars['theme_description'], T_DB )
			);
			
			$kernel->db->insert( "themes", $themedata );
			
			$theme = $kernel->db->row( "SELECT t.theme_id FROM " . TABLE_PREFIX . "themes t ORDER BY t.theme_id DESC LIMIT 1" );
			
			//populate templates
			$get_base_templates = $kernel->db->query( "SELECT t.template_name, t.template_data, t.template_description, t.template_original, t.template_author FROM " . TABLE_PREFIX . "templates t WHERE t.template_theme = {$kernel->vars['theme_id']} ORDER BY t.template_theme" );
			
			while( $template = $kernel->db->data( $get_base_templates ) )
			{
				$templatedata = array(
					"template_theme" => $theme['theme_id'],
					"template_name" => $kernel->format_input( $template['template_name'], T_DB ),
					"template_data" => $kernel->format_input( $template['template_data'], T_STRIP ),
					"template_description" => $kernel->format_input( $template['template_description'], T_DB ),
					"template_original" => $kernel->format_input( $template['template_data'], T_STRIP ),
					"template_timestamp" => UNIX_TIME,
					"template_author" => $kernel->format_input( $kernel->session['adminsession_name'], T_DB )
				);
				
				$kernel->db->insert( "templates", $templatedata );
			}
			
			$kernel->archive_function->update_database_counter( "templates" );
			$kernel->archive_function->update_database_counter( "themes" );

			$kernel->admin_function->message_admin_report( "lang_b_log_theme_added", $kernel->vars['theme_name'] );
		}
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$kernel->tp->call( "admin_temp_add" );
		
		$kernel->archive_function->construct_list_options( 0, "theme", $kernel->db->query( "SELECT t.theme_id, t.theme_name FROM " . TABLE_PREFIX . "themes t ORDER BY t.theme_name" ) );
		
		break;
	}
}

?>

