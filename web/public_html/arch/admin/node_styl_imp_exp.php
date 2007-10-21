<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 23, 24 );

$kernel->clean_array( "_REQUEST", array( "style_id" => V_INT ) );

switch( $kernel->vars['action'] )
{

	#############################################################################
	
	case "edit" :
	{
		$kernel->admin_function->read_permission_flags( 23 );
		
		//clean db associated vars
		$kernel->clean_array( "_POST", array( "style_import_data" => V_STR ) );
		
		$kernel->page_function->verify_upload_details( null );
		
  	if( !empty( $_FILES['style_import_upload']['tmp_name'] ) )
  	{
  		//@set_time_limit( 300 ); //5 minutes.
  		$kernel->vars['style_import_data'] = file_get_contents( $_FILES['style_import_upload']['tmp_name'] );
  	}
  	
		//badly formatted or no theme data
  	if( empty( $kernel->vars['style_import_data'] ) OR empty( $kernel->vars['style_import_data'] ) AND empty( $_FILES ) )
  	{
  		$kernel->page_function->message_report( $kernel->ld['lang_b_style_no_import_data'], M_ERROR );
  	}
		
		//construct data for preview and editing
  	else
  	{
  		preg_match_all( "#\[([^\]]+)\](.*?)\[\/[^\]]+\]#", $kernel->vars['style_import_data'], $matches );
  		
  		$import_item_list = array( "style_name" => 0, "style_description" => 0, "style_data" => 0 );
  		
  		$i = 0;
  		
  		foreach( $matches[1] AS $item_key )
  		{
  			if( !isset( $import_item_list[ $item_key ] ) ) continue;
  			
  			$item_key_formatted = htmlspecialchars( $matches[2][ $i ] );
  			$item_key_formatted = str_replace( chr( 36 ), "&#36;", $item_key_formatted );
  			
  			$style[ $item_key ] = stripslashes( $kernel->format_input( $item_key_formatted, T_FORM ) );
  			
  			$i++;
  		}
  		
  		$kernel->tp->call( "admin_styl_import_edit" );
  		
  		$kernel->tp->cache( $style );
  	}
		
		break;
	}
	
	#############################################################################
	
	case "import" :
	{
		$kernel->admin_function->read_permission_flags( 23 );
		
		//clean db associated vars
		$kernel->clean_array( "_POST", array( "style_name" => V_STR, "style_description" => V_STR, "style_data" => V_STR ) );
		
		if( empty( $kernel->vars['style_name'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_style_no_name'], M_WARNING );
		}
		else
		{
			if( $kernel->db->numrows( "SELECT `style_name` FROM `" . TABLE_PREFIX . "styles` WHERE `style_name` = '{$kernel->vars['style_name']}'" ) > 0 )
			{
				$file_match = true;
				$loop_count = 1;
				$extension_suffix = $kernel->config['file_rename_suffix'];
				
				while( $file_match == true )
				{
					if( $kernel->db->numrows( "SELECT `style_name` FROM `" . TABLE_PREFIX . "styles` WHERE `style_name` = '{$kernel->vars['style_name']}{$extension_suffix}{$loop_count}'" ) == 0 )
					{
						$kernel->vars['style_name'] .= $extension_suffix . $loop_count;
						
						$file_match = false;
						break;
					}
					
					$loop_count++;
				}
			}
			
			$style_data_formatted = str_replace( "&#36;", chr( 36 ), $kernel->vars['style_data'] );
			
			$styledata = array(
				"style_name" => $kernel->format_input( $kernel->vars['style_name'], T_DB ),
				"style_description" => $kernel->format_input( $kernel->vars['style_description'], T_DB ),
				"style_data" => addslashes( $style_data_formatted )
			);
			
			$kernel->db->insert( "styles", $styledata );
			
			$kernel->archive_function->update_database_counter( "styles" );

			$kernel->admin_function->message_admin_report( "lang_b_log_style_added", $kernel->vars['style_name'] );
		}
		
		break;
	}
	
	#############################################################################
	
	case "export" :
	{
		$kernel->admin_function->read_permission_flags( 24 );
		
		$style = $kernel->db->data( "SELECT `style_name`, `style_description`, `style_data`, `style_original` FROM `" . TABLE_PREFIX . "styles` WHERE `style_id` = {$kernel->vars['style_id']}" );
		
		$file_date = date( "Y-m-d H:i:s" );
		
		$file_style_name = str_replace( " ", "_", $style['style_name'] );
		
		header( "Content-Type: text/x-delimtext; name=\"" . $file_style_name . ".pstyle\"; charset=\"UTF-8\"" );
		header( "Content-disposition: attachment; filename=" . $file_style_name . ".pstyle" );
		
		//export header
		print "# Exported by: PHCDownload {$kernel->config['short_version']}\r\n# Compiled On: {$file_date}\r\n# Style Info: {$style['style_name']}\r\n\r\n";
		
		$style['style_data'] = str_replace( chr( 10 ), "\\n", $style['style_data'] );
		$style['style_data'] = str_replace( chr( 13 ), "\\r", $style['style_data'] );
		
		//style data line
		print "[style_name]{$style['style_name']}[/style_name][style_description]{$style['style_description']}[/style_description][style_data]{$style['style_data']}[/style_data]";
		exit;
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$upload_size = $kernel->archive_function->format_round_bytes( MAX_UPLOAD_SIZE );
		
		$get_styles = $kernel->db->query( "SELECT `style_id`, `style_name`, `style_description` FROM `" . TABLE_PREFIX . "styles` ORDER BY `style_name`" );
		
		$kernel->tp->call( "admin_style_export_header" );
		
		while( $style = $kernel->db->data( $get_styles ) )
		{
			$kernel->tp->call( "admin_style_export_row" );
			
			$style['style_name'] = $kernel->format_input( $style['style_name'], T_HTML );
			
			if( $style['style_id'] == $kernel->config['default_style'] AND $style['style_id'] == 1 )
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
			
			$kernel->tp->cache( $style );
			$kernel->tp->cache( "upload_size", $upload_size );
		}
		
		$kernel->tp->call( "admin_style_export_footer" );
	}
}

?>

