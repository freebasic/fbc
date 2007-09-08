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

$kernel->clean_array( "_REQUEST", array( "template_id" => V_INT ) );

switch( $kernel->vars['action'] )
{
	
	#############################################################################
	
	case "update" :
	{
		$kernel->clean_array( "_REQUEST", array( "template" => V_ARRAY ) );
		
		foreach( $kernel->vars['template'] AS $template_id => $template )
		{
			$edit_data[] = $template['template_name'];
			
			$template['template_data'] = str_replace( "&#36;", chr( 36 ), $template['template_data'] );
			
  		$templatedata = array(
  			"template_subject" => $kernel->format_input( $template['template_subject'], T_DB ),
  			"template_data" => $kernel->format_input( $template['template_data'], T_STRIP ),
  			"template_timestamp" => UNIX_TIME
  		);
  
  		$kernel->db->update( "templates_email", $templatedata, "WHERE `template_id` = {$template_id}" );
		}
		
		$kernel->archive_function->update_database_counter( "templates_email" );
		
		$kernel->admin_function->message_admin_report( "lang_b_log_email_templates_edited", 0, $edit_data );
		
		break;
	}
	
	#############################################################################
	
	default :
	{
  	$kernel->tp->call( "admin_email_header" );
  	
  	$get_templates = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "templates_email` ORDER BY `template_name`" );
  	
  	while( $template = $kernel->db->data( $get_templates ) )
  	{
  		$kernel->tp->call( "admin_email_row" );
  		
  		$template['template_subject'] = $kernel->format_input( $template['template_subject'], T_FORM );
			
			$template['template_data'] = htmlspecialchars( $template['template_data'] );
			$template['template_data'] = str_replace( chr( 36 ), "&#36;", $template['template_data'] );
  		
  		$kernel->tp->cache( $template );
  	}
		
  	$kernel->tp->call( "admin_email_footer" );
		
		break;
	}
}

?>

