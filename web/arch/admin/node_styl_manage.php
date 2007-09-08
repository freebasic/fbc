<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 24, 25 );

$kernel->clean_array( "_REQUEST", array( "style_id" => V_INT ) );

switch( $kernel->vars['action'] )
{
	
	#############################################################################
	
	case "edit" :
	{
		$kernel->admin_function->read_permission_flags( 24 );
		
		$style = $kernel->db->row( "SELECT s.style_id, s.style_name, s.style_data, s.style_cache, s.style_description FROM " . TABLE_PREFIX . "styles s WHERE s.style_id = {$kernel->vars['style_id']} LIMIT 1" );
		
		$kernel->tp->call( "admin_style_edit" );
		
		$style['style_name'] = $kernel->format_input( $style['style_name'], T_FORM );
		$style['style_description'] = $kernel->format_input( $style['style_description'], T_FORM );
		
		$style['style_data'] = htmlentities( $style['style_data'] );
		$style['style_data'] = str_replace( chr( 36 ), "&#36;", $style['style_data'] );
		
		$style['style_cache_checked'] = ( !empty( $style['style_cache'] ) ) ? " checked=\"checked\"" : "";
		
		$kernel->tp->cache( $style );
	
		break;
	}
	
	#############################################################################
	
	case "update" :
	{
		$kernel->admin_function->read_permission_flags( 24 );
		
		$kernel->clean_array( "_REQUEST", array( "style_name" => V_STR, "style_data" => V_STR, "style_description" => V_STR ) );
		
		$style = $kernel->db->row( "SELECT s.style_name, s.style_data FROM " . TABLE_PREFIX . "styles s WHERE s.style_id = {$kernel->vars['style_id']}" );
		
		//Original data backup
		$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "styles` SET `style_data_bak` = '" . addslashes( $style['style_data'] ) . "' WHERE `style_id` = {$kernel->vars['style_id']}" );
		
		$styledata = array(
			"style_name" => $kernel->format_input( $kernel->vars['style_name'], T_DB ),
			"style_data" => $kernel->format_input( $kernel->vars['style_data'], T_DB ),
			"style_description" => $kernel->format_input( $kernel->vars['style_description'], T_DB ),
			"style_author" => $kernel->format_input( $kernel->session['adminsession_name'], T_DB ),
			"style_timestamp" => UNIX_TIME
		);
		
		//new style? lets make what they add the original to revert to..
		$check_original = $kernel->db->row( "SELECT `style_original` FROM `" . TABLE_PREFIX . "styles` WHERE `style_id` = {$kernel->vars['style_id']}" );
		
		if( empty( $check_original['style_original'] ) )
		{
			$styledata['style_original'] = $kernel->format_input( $kernel->vars['style_data'], T_DB );
		}
		
		//Caching the data?
		if( $_POST['update_cache'] == "1" )
		{
			$styledata['style_cache'] = "style_" . sprintf( "%04s", $kernel->vars['style_id'] ) . "_" . UNIX_TIME . ".css";
			
			$style_save_path = ROOT_PATH . "include" . DIR_STEP . "css" . DIR_STEP;
			
			//check file accessability
  		if( is_readable( $style_save_path ) == false OR is_writable( $style_save_path ) == false )
  		{
  			clearstatcache();
  			
  			@chmod( $style_save_path, 0757 );
  			
  			if( is_readable( $style_save_path ) == false )
  			{
  				$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_chmod_file_reading'], $styledata['style_cache'], $style_save_path ), M_ERROR, HALT_EXEC );
  			}
  			clearstatcache();
  			
    		if( is_writable( $style_save_path ) == false )
    		{
    			$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_chmod_file_writing'], $styledata['style_cache'], $style_save_path ), M_ERROR, HALT_EXEC );
    		}
  			clearstatcache();
  		}
  		
  		//open, truncate and write
    	$fp = fopen( $style_save_path . $styledata['style_cache'], "w" );
  		
  		fwrite( $fp, $kernel->format_input( $kernel->vars['style_data'], T_STRIP ) );
		}
		else
		{
			$styledata['style_cache'] = "";
		}
		
		//Clean old cache files
		if( $_POST['delete_cache'] == "1" )
		{
			$style_file_name = "style_" . sprintf( "%04s", $kernel->vars['style_id'] );
			
			$directory = ROOT_PATH . "include" . DIR_STEP . "css" . DIR_STEP;
			
			$handle = opendir( $directory );
    	
    	while( ( $item = @readdir( $handle ) ) !== false )
    	{
  			if( substr( $style_file_name, 0, strlen( $style_file_name ) - 1 ) )
				{
					unlink( $directory . $item );
				}
    	}
		}
		
		$kernel->db->update( "styles", $styledata, "WHERE `style_id` = '{$kernel->vars['style_id']}'" );
		
		$kernel->archive_function->update_database_counter( "styles" );
		
		$kernel->admin_function->message_admin_report( "lang_b_log_style_edited", $kernel->vars['style_name'] );
		
		break;
	}
	
	#############################################################################
	
	case "delete" :
	{
		$kernel->admin_function->read_permission_flags( 25 );
		
		$delete_count = 0;
		
		if( $kernel->vars['style_id'] > 0 )
		{
			if( $kernel->vars['style_id'] == $kernel->config['default_style'] )
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_delete_archive_style'], M_NOTICE );
			}
			elseif( $kernel->vars['style_id'] == 1 )
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_delete_root_style'], M_NOTICE );
			}
			else
			{
				$delete_data[] = $kernel->db->item( "SELECT `style_name` FROM `" . TABLE_PREFIX . "styles` WHERE `style_id` = {$kernel->vars['style_id']}" );
				
				$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "styles` WHERE `style_id` = {$kernel->vars['style_id']}" );
				$delete_count++;
			}
		}
		elseif( is_array( $_POST['checkbox'] ) )
		{
			foreach( $_POST['checkbox'] AS $style )
			{
				if( $style == $kernel->config['default_style'] )
				{
					$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_delete_archive_style'], M_NOTICE );
				}
				elseif( $style == 1 )
				{
					$kernel->page_function->message_report( $kernel->ld['lang_b_cannot_delete_root_style'], M_NOTICE );
				}
				else
				{
					$delete_data[] = $kernel->db->item( "SELECT `style_name` FROM `" . TABLE_PREFIX . "styles` WHERE `style_id` = {$style}" );
					
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "styles` WHERE `style_id` = {$style}" );
					$delete_count++;
				}
			}
		}
		else
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_checkbox_none_selected'], M_ERROR, HALT_EXEC );
		}
		
		if( $delete_count > 0 )
		{
			$kernel->archive_function->update_database_counter( "styles" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_style_deleted", $delete_count, $delete_data );
		}
		
		break;
	}
	
	#############################################################################
	
	case "rollback" :
	{
		$kernel->admin_function->read_permission_flags( 24 );
		
		$style = $kernel->db->row( "SELECT `style_name`, `style_data`, `style_data_bak` FROM `" . TABLE_PREFIX . "styles` WHERE `style_id` = {$kernel->vars['style_id']}" );
		
		$styledata = array(
			"style_data" => addslashes( $style['style_data_bak'] ),
			"style_data_bak" => addslashes( $style['style_data'] )
		);
		
		$kernel->db->update( "styles", $styledata, "WHERE `style_id` = {$kernel->vars['style_id']}" );
		
		
		$kernel->admin_function->message_admin_report( "lang_b_log_style_rolled_back", $style['style_name'] );
		
		break;
	}
	
	#############################################################################
	
	case "revert" :
	{
		$kernel->admin_function->read_permission_flags( 24 );
		
		$style = $kernel->db->row( "SELECT `style_name`, `style_data`, `style_original` FROM `" . TABLE_PREFIX . "styles` WHERE `style_id` = {$kernel->vars['style_id']}" );
		
		$styledata = array(
			"style_data" => addslashes( $style['style_original'] ),
			"style_data_bak" => addslashes( $style['style_data'] )
		);
		
		$kernel->db->update( "styles", $styledata, "WHERE `style_id` = {$kernel->vars['style_id']}" );
		
		$kernel->admin_function->message_admin_report( "lang_b_log_style_reverted", $style['style_name'] );
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$get_styles = $kernel->db->query( "SELECT s.* FROM " . TABLE_PREFIX . "styles s ORDER BY s.style_name" );
		
		$kernel->tp->call( "admin_style_header" );
		
		while( $style = $kernel->db->data( $get_styles ) )
		{
			$kernel->tp->call( "admin_style_row" );
			
			$style['style_name'] = $kernel->format_input( $style['style_name'], T_HTML );
			
			if( $style['style_id'] == $kernel->config['default_style'] AND $style['style_id'] == "1" )
			{
				$style['style_html_name'] = $kernel->page_function->string_colour( $style['style_name'], "orange" );
			}
			elseif( $style['style_id'] == $kernel->config['default_style'] )
			{
				$style['style_html_name'] = $kernel->page_function->string_colour( $style['style_name'], "#33cc33" );
			}
			elseif( $style['style_id'] == 1 )
			{
				$style['style_html_name'] = $kernel->page_function->string_colour( $style['style_name'], "red" );
			}
			else
			{
				$style['style_html_name'] = $style['style_name'];
			}
			
			$style['style_description'] = $kernel->format_input( $style['style_description'], T_HTML );
			
			//setup user action button states
			$style['style_option_rollback'] = $kernel->admin_function->button_status_if( ( empty( $style['style_data_bak'] ) ), $style['style_name'], "rollback", $kernel->ld['lang_b_undo_changes'], "?hash={$kernel->session['hash']}&node=styl_manage&style_id={$style['style_id']}&action=rollback" );
			$style['style_option_revert'] = $kernel->admin_function->button_status_if( ( $style['style_data'] == $style['style_original'] ), $style['style_name'], "revert", $kernel->ld['lang_b_revert_original'], "?hash={$kernel->session['hash']}&node=styl_manage&style_id={$style['style_id']}&action=revert" );
			
			$kernel->tp->cache( $style );
		}
		
		$kernel->tp->call( "admin_style_footer" );
		
		break;
	}
}

?>

