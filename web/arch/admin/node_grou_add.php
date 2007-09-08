<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 34 );

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "create" :
	{
		$kernel->clean_array( "_REQUEST", array( "usergroup_id" => V_INT, "usergroup_title" => V_STR, "usergroup_session_downloads" => V_INT, "usergroup_session_baud" => V_INT ) );
		
		if( empty( $kernel->vars['usergroup_title'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_usergroup_title'], M_ERROR );
		}
		elseif( $kernel->db->numrows( "SELECT `usergroup_title` FROM `" . TABLE_PREFIX . "usergroups` WHERE `usergroup_title` = '" . $kernel->format_input( $kernel->vars['usergroup_title'], T_STRIP ) . "'" ) == 1 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_usergroup_title_in_use'], M_ERROR );
		}
		else
		{
			$usergroupdata = array(
				"usergroup_title" => $kernel->format_input( $kernel->vars['usergroup_title'], T_DB ),
				"usergroup_session_downloads" => $kernel->format_input( $kernel->vars['usergroup_session_downloads'], T_DB ),
				"usergroup_session_baud" => $kernel->format_input( $kernel->vars['usergroup_session_baud'], T_DB )
			);
			
			if( intval( $kernel->session['adminsession_group_id'] ) != 1 AND is_array( $_POST['panel_attrib'] ) )
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_create_update_administrators'], M_ERROR );
			}
			else
			{
				if( intval( $kernel->session['adminsession_group_id'] ) == 1 )
				{
					$panel_data = array(
						0 => 0,
						1 => 0,
						2 => 0,
						3 => 0,
						4 => 0,
						5 => 0,
						6 => 0,
						7 => 0,
						8 => 0,
						9 => 0,
						10 => 0,
						11 => 0,
						12 => 0,
						13 => 0,
						14 => 0,
						15 => 0,
						16 => 0,
						17 => 0,
						18 => 0,
						19 => 0,
						20 => 0,
						21 => 0,
						22 => 0,
						23 => 0,
						24 => 0,
						25 => 0,
						26 => 0,
						27 => 0,
						28 => 0,
						29 => 0,
						30 => 0,
						31 => 0,
						32 => 0,
						33 => 0,
						34 => 0,
						35 => 0,
						36 => 0,
						37 => 0,
						38 => 0,
						39 => 0
					);
					
					if( is_array( $_POST['panel_attrib'] ) )
					{
						foreach( $_POST['panel_attrib'] as $set_key => $set_value )
						{
							$panel_data[ $set_key ] = 1;
						}
					}
					
					$usergroupdata['usergroup_panel_permissions'] = implode( ",", $panel_data );
				}
			
				$usergroupdata['usergroup_archive_permissions'] = implode( ",", $_POST['archive_attrib'] );
				
				$kernel->db->insert( "usergroups", $usergroupdata );
				
				$kernel->archive_function->update_database_counter( "usergroups" );
				
				$kernel->admin_function->message_admin_report( "lang_b_log_user_group_added", $kernel->vars['usergroup_title'] );
			}
		}
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$kernel->tp->call( "admin_grou_add" );
		
		break;
	}
}

?>

