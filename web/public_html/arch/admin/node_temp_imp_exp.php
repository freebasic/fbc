<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 28, 29 );

$kernel->clean_array( "_REQUEST", array( "theme_id" => V_INT ) );

switch( $kernel->vars['action'] )
{

	#############################################################################
	
	case "edit" :
	{
		$kernel->admin_function->read_permission_flags( 28 );
		
		//clean db associated vars
		$kernel->clean_array( "_POST", array( "theme_import_data" => V_STR ) );
		
		$kernel->page_function->verify_upload_details( null );
		
  	if( !empty( $_FILES['file_upload']['tmp_name'] ) )
  	{
  		//@set_time_limit( 300 ); //5 minutes.
  		$kernel->vars['theme_import_data'] = file_get_contents( $_FILES['file_upload']['tmp_name'] );
  	}
  	
  	if( empty( $kernel->vars['theme_import_data'] ) AND empty( $kernel->vars['theme_import_data'] ) OR empty( $_FILES ) )
  	{
  		$kernel->page_function->message_report( $kernel->ld['lang_b_theme_no_import_data'], M_ERROR );
  	}
  	else
  	{
  		$template_array = explode( "[newline]", $kernel->vars['theme_import_data'] );
  		
			//badly formatted or no theme data
  		if( !is_array( $template_array ) )
  		{
  			$kernel->page_function->message_report( $kernel->ld['lang_b_theme_no_import_templates'], M_ERROR );
  		}
			
			//construct data for preview and editing
  		else
  		{
  			$kernel->tp->call( "admin_temp_import_header" );
  			
  			$import_theme_item_list = array( "theme_name" => 0, "theme_description" => 0 );
  			$import_template_item_list = array( "template_name" => 0, "template_description" => 0, "template_data" => 0 );
  			
  			$line = 0;
				
  			foreach( $template_array AS $template_line )
  			{
    			$i = 0;
					
					preg_match_all( "#\[([^\]]+)\](.*?)\[\/[^\]]+\]#", $template_line, $matches );
					
					if( empty( $matches[0] ) )
					{
						//nothin'
					}
					else
					{
						foreach( $matches[1] as $item_key )
        		{
							if( $line > 0 )
							{
								if( !isset( $import_template_item_list[ $item_key ] ) ) continue;
								
								if( $item_key == "template_data" )
								{
									$template_data = htmlspecialchars( $matches[2][ $i ] );
									$template_data = str_replace( chr( 36 ), "&#36;", $template_data );
									
									$template[ $item_key ] = $kernel->format_input( $template_data, T_FORM );
								}
								else
								{
									$template[ $item_key ] = $kernel->format_input( $matches[2][ $i ], T_FORM );
								}
							}
							else
							{
								if( !isset( $import_theme_item_list[ $item_key ] ) ) continue;
								
								$theme[ $item_key ] = $kernel->format_input( $matches[2][ $i ], T_FORM );
							}
        			
        			$i++;
          	}
					
						if( $line > 0 )
						{
							$kernel->tp->call( "admin_temp_import_row" );
						}
						
        		$kernel->tp->cache( $template );
						$kernel->tp->cache( $theme );
						
					}
					
					$line++;
				}
				
				$kernel->tp->call( "admin_temp_import_footer" );
    	}
  	}
		
		break;
	}
	
	#############################################################################
	
	case "import" :
	{
		$kernel->admin_function->read_permission_flags( 28 );
		
		//clean db associated vars
		$kernel->clean_array( "_POST", array( "theme_name" => V_STR, "theme_description" => V_STR ) );
		
		if( empty( $kernel->vars['theme_name'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_theme_no_name'], M_WARNING );
		}
		else
		{
			//check theme name exists, or add a suffix
			if( $kernel->db->numrows( "SELECT `theme_name` FROM `" . TABLE_PREFIX . "themes` WHERE `theme_name` = '{$kernel->vars['theme_name']}'" ) > 0 )
			{
				$theme_match = true;
				$loop_count = 1;
				$extension_suffix = $kernel->config['file_rename_suffix'];
				
				while( $theme_match == true )
				{
					if( $kernel->db->numrows( "SELECT `theme_name` FROM `" . TABLE_PREFIX . "themes` WHERE `theme_name` = '{$kernel->vars['theme_name']}{$extension_suffix}{$loop_count}'" ) == 0 )
					{
						$kernel->vars['theme_name'] .= $extension_suffix . $loop_count;
						
						$theme_match = false;
						break;
					}
					
					$loop_count++;
				}
			}
			
			//prep new theme data
			$themedata = array(
				"theme_name" => $kernel->format_input( $kernel->vars['theme_name'], T_DB ),
				"theme_description" => $kernel->format_input( $kernel->vars['theme_description'], T_DB )
			);
		
			$kernel->db->insert( "themes", $themedata );
			
			$kernel->archive_function->update_database_counter( "themes" );
			
			$theme_id = $kernel->db->item( "SELECT t.theme_id FROM " . TABLE_PREFIX . "themes t ORDER BY t.theme_id DESC LIMIT 1" );
			
			$i = 0;
			
			//add new templates to theme
			foreach( $_POST['template_name'] AS $name )
			{
				$template_data_formatted = "";
				
				if( $name == $last_template )
				{
					//do nadda
				}
				else
				{
    			$template_data_formatted = str_replace( "&#36;", chr( 36 ), $_POST['template_data'][ $i ] );
    			
    			$templatedata = array(
    				"template_theme" => $theme_id,
    				"template_name" => $kernel->format_input( $name, T_DB ),
    				"template_description" => $kernel->format_input( $_POST['template_description'][ $i ], T_DB ),
    				"template_data" => addslashes( $template_data_formatted ),
    				"template_timestamp" => UNIX_TIME,
    				"template_author" => $kernel->format_input( $kernel->session['adminsession_name'], T_DB )
    			);
    			
    			$kernel->db->insert( "templates", $templatedata );
    			
    			$last_template = $name;
				}
				
				$i++;
			}
			
			$kernel->archive_function->update_database_counter( "templates" );

			$kernel->admin_function->message_admin_report( "lang_b_log_theme_added", $kernel->vars['theme_name'] );
		}
		
		break;
	}
	
	#############################################################################
	
	case "export" :
	{
		$kernel->admin_function->read_permission_flags( 29 );
		
		$theme = $kernel->db->data( "SELECT `theme_name`, `theme_description` FROM `" . TABLE_PREFIX . "themes` WHERE `theme_id` = {$kernel->vars['theme_id']}" );
		
		$file_date = date( "Y-m-d H:i:s" );
		$export_data = "";
		
		$file_theme_name = str_replace( " ", "_", $theme['theme_name'] );
		
		header( "Content-Type: text/x-delimtext; name=\"" . $file_theme_name . ".ptheme\"; charset=\"UTF-8\"" );
		header( "Content-disposition: attachment; filename=" . $file_theme_name . ".ptheme" );
		
		//export header
		print "# Exported by: PHCDownload {$kernel->config['short_version']}\r\n# Compiled On: {$file_date}\r\n# Theme Info: {$theme['theme_name']}\r\n\r\n";
		
		//theme data line
		print "[theme_name]{$theme['theme_name']}[/theme_name][theme_description]{$theme['theme_description']}[/theme_description][newline]\r\n\r\n";
		
		$get_templates = $kernel->db->query( "SELECT t.*, p.theme_id, p.theme_name, p.theme_description FROM " . TABLE_PREFIX . "templates t LEFT JOIN " . TABLE_PREFIX . "themes p ON( p.theme_id = t.template_theme ) WHERE t.template_theme = {$kernel->vars['theme_id']} ORDER BY t.template_name" );
		
		while( $template = $kernel->db->data( $get_templates ) )
		{
			$template['template_data'] = str_replace( chr( 10 ), "\\n", $template['template_data'] );
			$template['template_data'] = str_replace( chr( 13 ), "\\r", $template['template_data'] );
			
			//template data line
			$export_data .= "[template_name]{$template['template_name']}[/template_name][template_description]{$template['template_description']}[/template_description][template_data]{$template['template_data']}[/template_data][newline]\r\n";
		}
		
		$export_data = substr( $export_data, 0, strlen( $export_data ) - 11 );
		
		print $export_data;
		exit;
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$upload_size = $kernel->archive_function->format_round_bytes( MAX_UPLOAD_SIZE );
		
		$get_themes = $kernel->db->query( "SELECT t.theme_id, t.theme_name, t.theme_description FROM " . TABLE_PREFIX . "themes t ORDER BY t.theme_name" );
		
		$kernel->tp->call( "admin_temp_export_header" );
		
		while( $theme = $kernel->db->data( $get_themes ) )
		{
			$kernel->tp->call( "admin_temp_export_row" );
			
			$theme['theme_name'] = $kernel->format_input( $theme['theme_name'], T_HTML );
			
			//colour indicators
			if( $theme['theme_id'] == $kernel->config['default_skin'] AND $theme['theme_id'] == 1 )
			{
				$theme['theme_html_name'] = $kernel->page_function->string_colour( $theme['theme_name'], "orange" );
			}
			elseif( $theme['theme_id'] == $kernel->config['default_skin'] )
			{
				$theme['theme_html_name'] = $kernel->page_function->string_colour( $theme['theme_name'], "#33cc33" );
			}
			elseif( $theme['theme_id'] == 1 )
			{
				$theme['theme_html_name'] = $kernel->page_function->string_colour( $theme['theme_name'], "red" );
			}
			else
			{
				$theme['theme_html_name'] = $theme['theme_name'];
			}
			
			$theme['theme_description'] = $kernel->format_input( $theme['theme_description'], T_HTML );
			
			$kernel->tp->cache( $theme );
			$kernel->tp->cache( "upload_size", $upload_size );
		}
		
		$kernel->tp->call( "admin_temp_export_footer" );
	}
}

?>

