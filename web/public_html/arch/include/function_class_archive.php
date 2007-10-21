<?php

################################################################################
#	PHCDownload - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDL is free to use. Please visit the website for futher licence
# information and details on re-distribution and use.
################################################################################

define( "R_TYPE_STR",			1 );
define( "R_TYPE_MIME",		2 );

define( "OPT_USER_ID",		0 );
define( "OPT_USER_NAME",	1 );

class class_archive_function
{
	/*
	 * Return file name (with suffix), file suffix, file mime, file icon
	 **/
	
	function file_url_info( $file_url )
	{
		global $kernel;
		
    $file_url = str_replace( "\\", "/", $file_url );
		
		preg_match( "/[^.]+$/", $file_url, $matches );
		
		$file_info['file_name'] = ( substr( $file_url, -1 ) == "/" ) ? "" : array_shift( explode( "?", basename( $file_url ) ) );
		
		$file_info['file_type'] = ( substr( $file_url, -1 ) == "/" ) ? "" : strtoupper( $matches[0] );
		if( strstr( $file_info['file_type'], "/" ) ) $file_info['file_type'] = "";
		
  	$file_info['file_icon'] = ( isset( $kernel->filetype[ $file_info['file_type'] ] ) ) ? $kernel->filetype[ $file_info['file_type'] ][0] : $kernel->filetype[""][0];
		
		$file_info['file_mime'] = ( isset( $kernel->filetype[ $file_info['file_type'] ] ) ) ? $kernel->filetype[ $file_info['file_type'] ][1] : $kernel->filetype[""][1];
		
		$file_info['file_type_exists'] = ( !empty( $file_info['file_type'] ) AND isset( $kernel->filetype[ $file_info['file_type'] ] ) ) ? true : false;
		
		return $file_info;
	}
	
	/*
	 * Parse supplied URL and return the headers char length
	 **/
	
  function parse_url_size( $url, $timeout = 5 )
  {
		global $kernel;
		
		$fname = $kernel->config['system_root_dir_upload'] . '/' . basename( $url );
		if( @file_exists( $fname ) )
			return filesize( $fname );
		else
			return 0;
		
		/*
		if( @ini_get( "allow_url_fopen" ) == 0 ) return 0;
		
		$url = $kernel->format_input( $url, T_DL_PARSE );
		
    $parse = @parse_url( $url );
		
    $host = $parse['host'];
    $path = $parse['path'];
  	$port = empty( $parse['port'] ) ? 80 : $parse['port'];
		$string = "Content-length: ";
		$parse_bytes = 0;
		
		$headers = "HEAD " . $url . " HTTP/1.1\r\n";
		$headers .= "Host: " . HTTP_HOST . "\r\n";
		$headers .= "Connection: close\r\n\r\n";
    
    if( !$fp = @fsockopen( $host, $port, $errno, $errstr, $kernel->config['system_parse_timeout'] ) ) 
    {
			return 0;
		}
		else
		{
      fputs( $fp, $headers );
  		
      while( !feof( $fp ) )
      {
      	$data_length .= fgets( $fp, 128 );
      }
    }
		
    @fclose( $fp );
  	
    $data_array = explode( "\n", $data_length );
		
    foreach( $data_array AS $data_line )
    {
      if( substr( strtolower( $data_line ), 0, strlen( $string ) ) == strtolower( $string ) )
      {
        $parse_bytes = substr( $data_line, strlen( $string ) );
        break;
      }
    }
    
  	return $parse_bytes;
  	*/
  }
	
	/*
	 * Return a specific number of words from a string
	 **/
	
  function return_string_words( $string, $max_length = "" )
  {
    $string_words = explode( " ", str_replace( "&nbsp;", " ", $string ) );
		
    if( sizeof( $string_words ) > $max_length )
    {
      $string = implode( " ", array_slice( $string_words, 0, $max_length ) ) . " ...";
    }
		
    return $string;
  }
	
	/*
	 * Return a specific number of characters from a string
	 **/
	
  function return_string_chars( $string, $max_length = "" )
  {
    if( preg_match_all( "/\&\#[0-9a-z]+?\;/i", $string, $matches ) )
    {
    	$string_length = sizeof( $matches[0] );
    	
      if( $string_length <= $max_length )
      {
      	return $string;
      }
      else
      {
        for( $char = 0; $char <= $string_length; $char++ )
        {
          if( $char >= $max_length )
          {
          	break;
          }
          else
          {
          	$string .= $matches[0][ $char ];
          }
      	}
    		
        if( $string_length > $max_length )
        {
        	$string .= "..";
        }
    	}
    }
    else
    {
      if( strlen( $string ) > $max_length )
      {
      	$string = substr( $string, 0, $max_length ) . "..";
      }
    }
    
    return $string;
  }
	
	/*
	 * Return over length words hyphenated for auto line-breaking. (only seems to work with IE)
	 **/
	
  function string_word_length_slice( $string, $max_length )
  {
  	$word_array = explode( " ", $string );
  	$words = 0;
  	
  	foreach( $word_array AS $word )
  	{
  		if( strlen( $word ) > $max_length )
  		{
  			$word_section = "";
  			$word_formatted = "";
  			
    		if( preg_match_all( "/\&\#[0-9a-z]+?\;/i", $word, $matches ) )
    		{
    			if( sizeof( $matches[0] ) < $max_length )
    			{
    				$word_formatted = $word;
    			}
    			else
    			{
  					$char = 0;
  					
    				for( $l = 0; $l <= sizeof( $matches[0] ); $l++ )
    				{
    					$word_section .= $matches[0][ $l ];
    					
    					if( $char > $max_length )
  						{
  							$word_section .= "-\r\n";
  							
  							$char = 0;
  						}
  						
  						$char++;
    				}
    				
    				$word_formatted = $word_section;
    			}
    		}
    		else
    		{
    			for( $i = 0; $i <= strlen( $word ); $i += $max_length )
    			{
      			$word_section .= substr( $word, $i, $max_length );
      			
      			if( ( $i + $max_length ) < strlen( $word ) ) $word_section .= "-\r\n";
      			
      			$word_formatted = $word_section;
    			}
  			}
  			
  			$word_array[ $words ] = $word_formatted; 
  		}
  		
  		$words++;
  	}
  	
  	$string = implode( " ", $word_array );
  	
  	return $string;
  }
	
	/*
	 * Round integer for every 1024 until round or integer end
	 **/
	
  function format_round_bytes( $bytes = 0 )
  {
  	global $kernel;
		
		if( $bytes == 0 ) return ( $kernel->ld['lang_b_unknown'] ) ? "<i>" . $kernel->ld['lang_b_unknown'] . "</i>" : "<i>" . $kernel->ld['lang_f_unknown'] . "</i>";
	
		$round_loop = 0;
		
		$round_set = explode( LINE_BREAK, $kernel->config['file_byte_rounders'] );
		
		foreach( $round_set AS $round_line )
		{
			if( empty( $round_line ) ) continue;
			
			$round_line_section = explode( "=", $round_line );
			$round_group[] = $round_line_section[0];
			$round_round[] = $round_line_section[1];
			
			if( $bytes >= 1024 )
      {
				if( $round_loop > 0 )
				{
  				$bytes = $bytes / 1024;
				}
				$round_loop++;
			}
		}
		$use_round_set = $round_loop - 1;
		
		if( $round_loop == 0 )
		{
			return ceil( $bytes ) . $round_group[0];
		}
		else
		{
			return round( $bytes, $round_round[ $use_round_set ] ) . $round_group[ $use_round_set ];
		}
  }
	
	/*
	 * Construct file hash strings
	 **/
	
  function construct_file_hash_fields( $string = 0 )
  {
  	global $kernel;
    
		$kernel->vars['html']['file_hash_fields'] = "";
		$file_hash_data = "";
		
		if( $kernel->config['archive_file_hash_mode'] != 0 AND !empty( $string ) )
		{
			$kernel->vars['html']['file_hash_fields'] .= $kernel->tp->call( "file_view_hash_row", CALL_TO_PAGE );
			
			list( $file_hash_md5, $file_hash_sha1 ) = explode( ",", $string );
			
			if( !empty( $file_hash_md5 ) AND $kernel->config['archive_file_hash_mode'] == 1 OR $kernel->config['archive_file_hash_mode'] == 3 )
			{
				$file_hash_data .= "<b>MD5:</b> <i>" . $file_hash_md5 . "</i>";
			}
			
			if( !empty( $file_hash_md5 ) AND !empty( $file_hash_sha1 ) AND $kernel->config['archive_file_hash_mode'] == 3 )
			{
				$file_hash_data .= "&nbsp;&middot;&nbsp;";
			}
			
			if( !empty( $file_hash_sha1 ) AND $kernel->config['archive_file_hash_mode'] == 2 OR $kernel->config['archive_file_hash_mode'] == 3 )
			{
				$file_hash_data .= "<b>SHA1:</b> <i>" . $file_hash_sha1 . "</i>";
			}
			
			$kernel->vars['html']['file_hash_fields'] = $kernel->tp->cache( "file_hash_data", $file_hash_data, $kernel->vars['html']['file_hash_fields'] );
		}
		
		return;
  }
	
	/*
	 * Construct file download time counters
	 **/
	
  function construct_download_counters( $bytes = 0 )
  {
  	global $kernel;
    
  	$kernel->vars['html']['file_download_counters'] = "";
  	$download_times = "";
		$current_counter = 1;
		
		$counter_set = explode( LINE_BREAK, $kernel->config['file_download_time_counters'] );
		
		$total_counters = sizeof( $counter_set );
		
    foreach( $counter_set as $round_line )
    {
			if( empty( $round_line ) ) continue;
			
      $part = explode( "=", $round_line );
			
			$download_times = array(
				"file_speed_title" => $kernel->format_input( $part[0], T_HTML ),
				"file_speed_time" => $kernel->format_seconds( ceil( $bytes / ( $part[1] / 8 ) ) )
			);
			
			$kernel->vars['html']['file_download_counters'] .= $kernel->tp->call( "download_time_item", CALL_TO_PAGE );
			$kernel->vars['html']['file_download_counters'] = $kernel->tp->cache( $download_times, 0, $kernel->vars['html']['file_download_counters'] );
			
			if( $current_counter !== $total_counters )
			{
				$kernel->vars['html']['file_download_counters'] .= $kernel->tp->call( "download_time_item_spacer", CALL_TO_PAGE );
			}
			
			$current_counter++;
    }
  }
	
	/*
	 * Construct pagination variables
	 **/
	
  function construct_pagination_vars( $total_rows = 0 )
  {
		global $kernel;
		
    $kernel->vars['pagination_menu'] = array(
    	$kernel->vars['limit'] => "selected=\"selected\"",
    	$kernel->vars['order'] => "selected=\"selected\"",
    	$kernel->vars['sort'] => "selected=\"selected\""
    );
    
    $kernel->vars['total_rows'] = $total_rows;
    $kernel->vars['total_pages'] = ceil( $kernel->vars['total_rows'] / $kernel->vars['limit'] );
		
    if( $kernel->vars['page'] > $kernel->vars['total_pages'] )
    {
    	$kernel->vars['page'] = $kernel->vars['total_pages'];
    }
    $kernel->vars['start'] = ( $kernel->vars['page'] * $kernel->vars['limit'] ) - $kernel->vars['limit'];
	}
	
	/*
	 * Construct file icon
	 **/
	
  function construct_file_icon( $file_url = "", $file_icon = "" )
  {
		global $kernel;
		
		if( $file_icon == "0" )
    {
    	$file_info = $kernel->archive_function->file_url_info( $file_url );
    	
    	return "<img src=\"" . $kernel->config['system_root_url_path'] . "/images/filetype/" . $file_info['file_icon'] . "\" border=\"0\" alt=\"" . $file_info['file_type'] . "\" />";
    }
    elseif( !empty( $file_icon ) )
    {
    	return "<img src=\"" . $kernel->config['system_root_url_path'] . "/images/icons/" . $file_icon . "\" border=\"0\" alt=\"\" />";
    }
    else
    {
    	return "&nbsp;";
    }
	}
	
	/*
	 * Construct file icon
	 **/
	
  function construct_file_custom_fields( $file_id = 0 )
  {
		global $kernel;
		
		$html = "";
		
		$get_fields = $kernel->db->query( "SELECT `field_id`, `field_name` FROM `" . TABLE_PREFIX . "fields` WHERE `field_category_display` = 1 ORDER BY `field_name`" );
    if( $kernel->db->numrows() > 0 )
    {			
      while( $field = $kernel->db->data( $get_fields ) )
      {
        $field_data = $kernel->db->row( "SELECT `field_file_data` FROM `" . TABLE_PREFIX . "fields_data` WHERE `field_id` = {$field['field_id']} AND `field_file_id` = {$file_id}" );
        
        if( !empty( $field_data['field_file_data'] ) )
        {
        	$field_data['field_file_data'] = $kernel->format_input( $field_data['field_file_data'], T_HTML );
        }
        else
        {
        	$field_data['field_file_data'] = "&nbsp;";
        }
        
        $html .= $kernel->tp->call( "file_field_cell", CALL_TO_PAGE );
				
        $html = $kernel->tp->cache( $field_data, 0, $html );
      }
    }
		
		return $html;
	}
	
	/*
	 * Construct file custom field HTML forms
	 **/
	
	function construct_file_custom_fields_form( $file_id = 0 )
	{
		global $kernel;
		
		$field_submit_syntax = ( SCRIPT_NAME == "submit.php" ) ? "WHERE `field_submit_display` = 1" : ""; 
		
    $get_fields = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "fields` {$field_submit_syntax}" );
		
		$kernel->vars['html']['custom_fields'] = "";
    
    if( $kernel->db->numrows() > 0 )
    {
      if( SCRIPT_NAME != "submit.php" )
			{
				$kernel->vars['html']['custom_fields'] .= $kernel->tp->call( "admin_file_fiel_header", CALL_TO_PAGE );
				$lang_menu_choose_option = $kernel->ld['lang_b_menu_choose_option'];
			}
			else
			{
				$table_col_span = " colspan=\"2\"";
				$lang_menu_choose_option = $kernel->ld['lang_f_menu_choose_option'];
			}
			
			$field_group = ( $kernel->vars['node'] == "file_sub_manage" ) ? "submission" : "file";
			
      while( $field = $kernel->db->data( $get_fields ) )
      {
      	$field_data = $kernel->format_input( $kernel->db->item( "SELECT `field_file_data` FROM `" . TABLE_PREFIX . "fields_data` WHERE `field_id` = {$field['field_id']} AND `field_" . $field_group . "_id` = {$file_id}" ), T_FORM );
				
				$field_required_phrase = "";
				
				if( $field['field_data_rule'] == 1 )
				{
					$field_required_phrase = defined( "IN_ACP" ) ? $kernel->ld['lang_b_field_value_required'] : $kernel->ld['lang_f_field_value_required'];
				}
				elseif( $field['field_data_rule'] == 2 )
				{
					$field_required_phrase = defined( "IN_ACP" ) ? $kernel->ld['lang_b_field_value_required_numeric'] : $kernel->ld['lang_f_field_value_required_numeric'];
				}
				
        $kernel->vars['html']['custom_fields'] .= "<tr><td class=\"subheader\"" . $table_col_span . "><strong>{$field['field_name']}</strong>&nbsp;{$field['field_description']}</td></tr>";
				
				if( $kernel->vars['action'] == "manage" )
  			{
  				$html_tag_name = "files[" . $file_id . "][field_" . $field['field_id'] . "]";
  			}
  			else
  			{
  				$html_tag_name = "field_" . $field['field_id'] . "";
  			}
        
        if( $field['field_type'] == 0 )
        {
					if( $file_id > 0 )
					{
        		$kernel->vars['html']['custom_fields'] .= "<tr><td class=\"row\"" . $table_col_span . "><input type=\"text\" name=\"" . $html_tag_name . "\" value=\"" . $field_data . "\" size=\"50\" maxlength=\"255\"> <span style=\"color: red;font-size: 11px;\">" . $field_required_phrase . "</span></td></tr>\r\n";
					}
					else
					{
						$kernel->vars['html']['custom_fields'] .= "<tr><td class=\"row\"" . $table_col_span . "><input type=\"text\" name=\"" . $html_tag_name . "\" value=\"\" size=\"50\" maxlength=\"255\"> <span style=\"color: red;font-size: 11px;\">" . $field_required_phrase . "</span></td></tr>\r\n";
					}
        }
        elseif( $field['field_type'] == 2 )
        {
          $menu_options = explode( LINE_BREAK_CHR, $field['field_options'] );
          
          $options = "<option value=\"\"></option>\r\n<optgroup label=\"" . $lang_menu_choose_option . "\">\r\n";
          
          foreach( $menu_options AS $item )
          {
            if( empty( $item ) ) continue;
            
            $item = explode( "=", $item );
            
            foreach( $item AS $item_id => $item_data )
            {
            	$item[ $item_id ] = $kernel->format_input( $item_data, T_FORM );
            }
            
            if( $field_data == $item[1] )
            {
            	$options .= "<option value=\"{$item[1]}\" selected=\"selected\">{$item[0]}</option>\r\n";
            }
            else
            {
            	$options .= "<option value=\"{$item[1]}\">{$item[0]}</option>\r\n";
            }
          }
        	
        	$options .= "</optgroup>\r\n";
        	
        	$kernel->vars['html']['custom_fields'] .= "<tr><td class=\"row\"" . $table_col_span . "><select name=\"" . $html_tag_name . "\">{$options}</select> <span style=\"color: red;font-size: 11px;\">" . $field_required_phrase . "</span></td></tr>\r\n";
        }
        else
        {
					if( $file_id > 0 )
					{
        		$kernel->vars['html']['custom_fields'] .= "<tr><td class=\"row\"" . $table_col_span . "><textarea name=\"" . $html_tag_name . "\" cols=\"60\" rows=\"8\">" . $field_data . "</textarea> <span style=\"color: red;font-size: 11px;\">" . $field_required_phrase . "</span></td></tr>\r\n";
					}
					else
					{
						$kernel->vars['html']['custom_fields'] .= "<tr><td class=\"row\"" . $table_col_span . "><textarea name=\"" . $html_tag_name . "\" cols=\"60\" rows=\"8\"></textarea> <span style=\"color: red;font-size: 11px;\">" . $field_required_phrase . "</span></td></tr>\r\n";
					}
        }
      }
			
      if( SCRIPT_NAME != "submit.php" ) $kernel->vars['html']['custom_fields'] .= $kernel->tp->call( "admin_file_fiel_footer", CALL_TO_PAGE );
    }
	}
	
	/*
	 * Construct file download mirror HTML forms
	 **/
	
	function construct_file_download_mirror_form( $file_id = 0 )
	{
		global $kernel;
		
    $kernel->vars['html']['download_mirrors'] = $kernel->tp->call( "admin_file_mirror_header", CALL_TO_PAGE );
    
    $mirror_order = 0;
    
    if( $file_id > 0 )
		{
  		$get_mirrors = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "mirrors` WHERE `mirror_file_id` = {$file_id} ORDER BY `mirror_order`, `mirror_name`" );
      if( $kernel->db->numrows() > 0 )
      {
        while( $mirror = $kernel->db->data( $get_mirrors ) )
        {
          //$kernel->vars['html']['download_mirrors'] .= "<tr><td class=\"row\"><input type=\"hidden\" name=\"mirror_id[]\" value=\"{$mirror['mirror_id']}\"><input type=\"text\" name=\"mirror_order[]\" value=\"{$mirror['mirror_order']}\" size=\"3\"></td><td class=\"row\"><input type=\"text\" name=\"mirror_name[]\" value=\"{$mirror['mirror_name']}\" size=\"40\"></td><td class=\"row\"><input type=\"text\" name=\"mirror_file_url[]\" value=\"{$mirror['mirror_file_url']}\" style=\"width: 99%;\"></td></tr>\r\n";
          $kernel->vars['html']['download_mirrors'] .= $kernel->tp->call( "admin_file_mirror_row_edit", CALL_TO_PAGE );
					
					list( $mirror['mirror_file_hash_md5'], $mirror['mirror_file_hash_sha1'] ) = explode( ",", $mirror['mirror_file_hash_data'] );
					if( empty( $mirror['mirror_file_hash_md5'] ) ) $mirror['mirror_file_hash_md5'] = $kernel->ld['lang_b_unknown'];
					if( empty( $mirror['mirror_file_hash_sha1'] ) ) $mirror['mirror_file_hash_sha1'] = $kernel->ld['lang_b_unknown'];
					
					$mirror['mirror_url_check'] = $kernel->admin_function->return_verify_file_url( $mirror['mirror_file_url'], $file_id, $mirror['mirror_id'] );
					
          $kernel->vars['html']['download_mirrors'] = $kernel->tp->cache( $mirror, 0, $kernel->vars['html']['download_mirrors'] );
          
          $mirror_order = $mirror['mirror_order'];
        }
        
        if( $kernel->config['form_max_mirror_fields'] != "0" )
        {
        	$kernel->vars['html']['download_mirrors'] .= $kernel->tp->call( "admin_file_mirror_break", CALL_TO_PAGE );
        }
      }
      
      $mirror_order++;
    }
		
    for( $i = 0; $i <= intval( $kernel->config['form_max_mirror_fields'] - 1 ); $i++ )
    {
      $kernel->vars['html']['download_mirrors'] .= $kernel->tp->call( "admin_file_mirror_row", CALL_TO_PAGE );
      $kernel->vars['html']['download_mirrors'] = $kernel->tp->cache( "mirror_order", $mirror_order, $kernel->vars['html']['download_mirrors'] );
      
      $mirror_order++;
    }
    
    $kernel->vars['html']['download_mirrors'] .= $kernel->tp->call( "admin_file_mirror_footer", CALL_TO_PAGE );
	}
	
	/*
	 * Construct file star rating
	 **/
	
	function construct_file_rating( $rating_points = 0, $total_votes = 0 )
	{
		global $kernel;
		
		$star_rank = 0;
		
		if( $total_votes == 0 )
		{
			return $kernel->ld['lang_f_no_votes'];
		}
		
		if( $rating_points < 0 OR $rating_points > 5 )
		{
			$star_rank = ( $rating_points < 0 ) ? 0 : 5;
		}
		else
		{
			$star_rank = $rating_points;
		}
		
		if( $kernel->config['file_user_rating_mode'] == 1 OR $kernel->config['file_user_rating_mode'] == 2 )
		{
			$html = "<img src=\"./images/star_" . $star_rank . ".gif\" style=\"vertical-align: middle;\" alt=\"" . $star_rank . "/5\" />";
			
			if( $kernel->config['file_user_rating_mode'] == 2 )
  		{
  			$html .= "&nbsp;" . $star_rank . "/5";
  		}
		}
		else
		{
			return $star_rank . "/5";
		}
		
		return $html;
	}
	
	/*
	 * Construct file icon selector
	 **/
	
	//Needs expanding for file_mass_edit vars
	
  function construct_file_icon_selector( $icon_info = false, $file_id = 0 )
  {
  	global $kernel;
		
		$kernel->vars['html']['icon_list_options'] = "";
  	
  	$handle = opendir( $kernel->config['system_root_dir'] . DIR_STEP . "images" . DIR_STEP . "icons" . DIR_STEP );
		
		if( $file_id > 0 )
		{
			$html_tag_name = "files[" . $file_id . "][file_icon]";
		}
		else
		{
			$html_tag_name = "file_icon";
		}
		
    $file_icon_none = ( empty( $icon_info ) ) ? " checked=\"checked\"" : "";
    
		$kernel->vars['html']['icon_list_options'] .= "<div style=\"margin: 10px;\"><input type=\"radio\" value=\"\" name=\"" . $html_tag_name . "\"" . $file_icon_none . ">&nbsp;<b>{$kernel->ld['lang_b_no_icon']}</b></div>\r\n";
    
    $file_icon_auto = ( $icon_info == "0" OR $icon_info == false ) ? " checked=\"checked\"" : "";
    
    $kernel->vars['html']['icon_list_options'] .= "<div style=\"margin: 10px;\"><input type=\"radio\" value=\"0\" name=\"" . $html_tag_name . "\"" . $file_icon_auto . ">&nbsp;<b>{$kernel->ld['lang_b_filetype_icon']}</b></div>\r\n";
  	
  	while( ( $item = readdir( $handle ) ) !== false )
  	{
  		if( $item == "." OR $item == ".." OR $item == "index.htm" OR $item == "index.html" ) continue;
			
  		if( $icon_info == $item )
  		{
  			$kernel->vars['html']['icon_list_options'] .= "<div style=\"display: inline;text-align: center; margin: 10px;\"><input type=\"radio\" value=\"{$item}\" name=\"" . $html_tag_name . "\" checked=\"checked\"><img src=\"../images/icons/{$item}\" border=\"0\"></div>\r\n";
  		}
  		else
  		{
  			$kernel->vars['html']['icon_list_options'] .= "<div style=\"display: inline;text-align: center; margin: 10px;\"><input type=\"radio\" value=\"{$item}\" name=\"" . $html_tag_name . "\"><img src=\"../images/icons/{$item}\" border=\"0\"></div>\r\n";
  		}
  	}
  }
	
	/*
	 * Construct <select> options list, Fields must be selected in right order! (id, name)
	 **/
	
	function construct_list_options( $select_id = "", $list_group, $get_items, $phrase = true )
	{
		global $kernel;
		
		$list_group_array = array(
			"gallery" => "lang_b_menu_choose_gallery",
			"image" => "lang_b_menu_choose_images",
			"document" => "lang_b_menu_choose_document",
			"theme" => "lang_b_menu_choose_a_theme",
			"style" => "lang_b_menu_choose_a_style",
		);
		
		$html = ( $phrase == true ) ? "<option value=\"\"></option>\r\n<optgroup label=\"" . $kernel->ld[ $list_group_array[ "$list_group" ] ] . "\">\r\n" : "";
		
		if( $kernel->db->numrows( $get_items ) > 0 )
		{
      while( $item = $kernel->db->data( $get_items, MYSQL_NUM ) )
      {
				$item[1] = $kernel->format_input( $item[1], T_HTML );
				
				if( $select_id == $item[0] )
				{
      		$html .= "<option value=\"" . $item[0] . "\" selected=\"selected\">" . $item[1] . "</option>\r\n";
				}
				else
				{
  				if( is_array( $select_id ) )
  				{
						$match_found = false;
						
  					foreach( $select_id AS $item_id )
  					{
  						if( $item_id == $item[0] )
  						{
        				$html .= "<option value=\"" . $item[0] . "\" selected=\"selected\">" . $item[1] . "</option>\r\n";
								$match_found = true; break;
  						}
  					}
						
						if( $match_found == false )
						{
							$html .= "<option value=\"" . $item[0] . "\">" . $item[1] . "</option>\r\n";
						}
						
						@reset( $select_id );
  				}
  				else
  				{
  					$html .= "<option value=\"" . $item[0] . "\">" . $item[1] . "</option>\r\n";
  				}
				}
      }
    }
		else
		{
			//$html .= "<option value=\"0\" disabled=\"disabled\">No Items</option>\r\n";
		}
		
    $html .= ( $phrase == true ) ? "</optgroup>\r\n" : "\r\n";
		
		$kernel->vars['html'][ $list_group . "_list_options" ] = $html;
	}
	
	/*
	 * Construct <select> options list for usergroups, Fields must be selected in right order! (id, name)
	 **/
	
	function construct_usergroup_options( $select_id = "", $get_items, $hide_empty = false )
	{
		global $kernel;
		
		$html = ( $hide_empty == false ) ? "<option value=\"\"></option>\r\n" : "";
		
		$html = "<optgroup label=\"" . $kernel->ld['lang_b_user_filter_list_groups'] . "\">\r\n";
		
    while( $item = $kernel->db->data( $get_items, MYSQL_NUM ) )
    {
      if( $item[0] < 0 ) continue;
			
      if( $kernel->session['adminsession_group_id'] <> 1 AND $item[0] == 1 OR $kernel->session['adminsession_group_id'] <> 1 AND strpos( $item[2], "1" ) !== false ) continue;
			
  		$item[1] = $kernel->format_input( $item[1] , T_FORM );
  		
  		if( $select_id == $item[0] )
  		{
				$html .= "<option value=\"" . $item[0] . "\" selected=\"selected\">" . $item[1] . "</option>\r\n";
  		}
  		else
  		{
				$html .= "<option value=\"" . $item[0] . "\">" . $item[1] . "</option>\r\n";
  		}
    }
		
    $html .= "</optgroup>\r\n";
		
		$kernel->vars['html'][ "usergroup_list_options" ] = $html;
	}
	
	/*
	 * Construct <select> options list for specific groups of users.
	 **/
	
	function construct_user_options( $select_id = "", $usergroups = "", $option_value_mode = 0 )
	{
		global $kernel;
		
		$html = "<option value=\"\">{$kernel->ld['lang_b_menu_all_users']}</option>\r\n";
		
		$usergroup_query_syntax = "";
		$last_usergroup_id = 0;
		
		//build usergroup id's into query syntax
		if( is_array( $usergroups ) )
		{
			$usergroup_query_syntax = "WHERE ";
			
			foreach( $usergroups AS $usergroup_id )
			{
				$usergroup_query_syntax .= "`user_group_id` = " . $usergroup_id . " OR ";
			}
			
			$usergroup_query_syntax = preg_replace( "/OR $/", "", $usergroup_query_syntax );
		}
		
		//run query
		$get_items = $kernel->db->query( "SELECT u.user_id, u.user_name, u.user_group_id, g.usergroup_title FROM " . TABLE_PREFIX . "users u LEFT JOIN " . TABLE_PREFIX . "usergroups g ON ( u.user_group_id = g.usergroup_id ) {$usergroup_query_syntax} ORDER BY `user_group_id`, `user_name`" );
		
		while( $item = $kernel->db->data( $get_items, MYSQL_NUM ) )
    {
			if( $last_usergroup_id != $item[2] )
			{
				if( $last_usergroup_id > 0 )
				{
					$html .= "</optgroup>\r\n";
				}
				
				$html .= "<optgroup label=\"" . $item[3] . "\">\r\n";
			}
			$last_usergroup_id = $item[2];
			
			$option_value = ( $option_value_mode == 0 ) ? $item[0] : $kernel->format_input( $item[1] , T_URL_ENC );
			
			$item[1] = $kernel->format_input( $item[1] , T_FORM );
			
  		if( $select_id == $option_value )
  		{
				$html .= "<option value=\"" . $option_value . "\" selected=\"selected\">" . $item[1] . "</option>\r\n";
  		}
  		else
  		{
				$html .= "<option value=\"" . $option_value . "\">" . $item[1] . "</option>\r\n";
  		}
    }
		
    $html .= "</optgroup>\r\n";
		
		$kernel->vars['html'][ "user_list_options" ] = $html;
	}
	
	/*
	 * Update the database counter for the specified item
	 **/
	
  function update_database_counter( $string, $script_name="", $script_line=0 )
  {
  	global $kernel;
  	
    $tablefield = array (
      "announcements" => "announcement_id",
      "categories" => "category_id",
      "comments" => "comment_id",
      "documents" => "document_id",
      "fields" => "field_id",
  		"fields_data" => "field_id",
      "files" => "file_id",
      "galleries" => "gallery_id",
      "images" => "image_id",
      "mirrors" => "mirror_id",
      "sites" => "site_id",
      "styles" => "style_id",
      "submissions" => "submission_id",
      "templates" => "template_id",
      "themes" => "theme_id",
      "users" => "user_id",
      "usergroups" => "usergroup_id",
      "votes" => "vote_id"
    );
  	
  	if( $string == "comments" )
  	{
  		$new_count = $kernel->db->item( "SELECT SUM( `file_total_comments` ) AS `value` FROM `" . TABLE_PREFIX . "files` WHERE `file_disabled` = 0", MYSQL_NUM, $script_name, $script_line );
  	}
  	elseif( $string == "downloads" )
  	{
  		$new_count = $kernel->db->item( "SELECT SUM( `file_downloads` ) AS `value` FROM `" . TABLE_PREFIX . "files` WHERE `file_disabled` = 0", MYSQL_NUM, $script_name, $script_line );
  	}
  	elseif( $string == "data" )
  	{
  		$new_count = $kernel->db->item( "SELECT SUM( `file_size` ) AS `value` FROM `" . TABLE_PREFIX . "files` WHERE `file_disabled` = 0", MYSQL_NUM, $script_name, $script_line );
  	}
  	elseif( $string == "files" )
  	{
  		$new_count = $kernel->db->item( "SELECT COUNT( `file_id` ) AS `value` FROM `" . TABLE_PREFIX . "files` WHERE `file_disabled` = 0", MYSQL_NUM, $script_name, $script_line );
  	}
  	elseif( $string == "views" )
  	{
  		$new_count = $kernel->db->item( "SELECT SUM( `file_views` ) AS `value` FROM `" . TABLE_PREFIX . "files` WHERE `file_disabled` = 0", MYSQL_NUM, $script_name, $script_line );
  	}
  	elseif( !empty( $tablefield[ $string ] ) )
  	{
  		$new_count = $kernel->db->numrows( "SELECT `" . $tablefield[ $string ] . "` FROM `" . TABLE_PREFIX . $string . "`", $script_name, MYSQL_NUM, $script_line );
  	}
  	
  	$kernel->db->update( "datastore", array( "datastore_value" => $new_count, "datastore_timestamp" => UNIX_TIME ), "WHERE `datastore_key` = 'count_total_{$string}'", $script_name, $script_line );
  }
	
	/*
	 * Check supplied vars for fields and there data against the field data rule
	 **/
	
	function verify_custom_field_values( $field_data )
	{
		global $kernel;
		
		$get_fields = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "fields`" );
		
		if( $kernel->db->numrows() > 0 )
		{
			while( $field = $kernel->db->data( $get_fields ) )
			{
				if( isset( $field_data[ 'field_'.$field['field_id'] ] ) )
				{
					if( $field['field_data_rule'] == 1 AND empty( $field_data[ 'field_'.$field['field_id'] ] ) )
					{
						$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_field_bad_value_alphanumeric'], $field['field_name'] ), M_ERROR, HALT_EXEC );
					}
					
					if( $field['field_data_rule'] == 2 AND strlen( intval( $field_data[ 'field_'.$field['field_id'] ] ) ) !== strlen( $field_data[ 'field_'.$field['field_id'] ] ) )
					{
						$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_field_bad_value_numeric'], $field['field_name'] ), M_ERROR, HALT_EXEC );
					}
				}
			}
		}
	}
	
	/*
	 * Construct and execute db queries for custom fields based on _POST vars
	 **/
	
	function construct_db_write_custom_fields( $file_id = 0, $field_data )
	{
		global $kernel, $file;
		
		$field_group = ( $kernel->vars['node'] == "file_sub_manage" OR SCRIPT_NAME == "submit.php" ) ? "submission" : "file";
		
		if( $file_id > 0 )
		{
    	$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "fields_data` WHERE `field_" . $field_group . "_id` = {$file_id}" );
		}
    
    $get_fields = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "fields`" );
		
    if( $kernel->db->numrows() > 0 )
    {
      while( $field = $kernel->db->data( $get_fields ) )
      {
				if( isset( $field_data[ 'field_'.$field['field_id'] ] ) )
        {
          if( $field['field_data_rule'] == 1 AND empty( $field_data[ 'field_'.$field['field_id'] ] ) )
          {
          	$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_field_bad_value_alphanumeric'], $field['field_name'] ), M_ERROR, M_ERROR );
          }
          elseif( $field['field_data_rule'] == 2 AND !is_int( $field_data[ 'field_'.$field['field_id'] ] ) )
          {
          	$kernel->page_function->message_report( sprintf( $kernel->ld['lang_b_field_bad_value_numeric'], $field['field_name'] ), M_ERROR, M_ERROR );
          }
          else
          {
            $fielddata = array(
            	"field_id" => $field['field_id'],
            	"field_" . $field_group . "_id" => $file_id,
            	"field_file_data" => $kernel->format_input( $field_data[ 'field_'.$field['field_id'] ], T_DB )
          	);
          	
          	$kernel->db->insert( "fields_data", $fielddata );
					}
        }
      }
    }
	}
	
	/*
	 * Return STRTIME period converted to UNIXTIME for query use
	 **/
  
  function construct_db_timestamp_filter( $filter = "today" )
  {	
  	//today
  	if( $filter == "today" )
  	{
			$start = strtotime( date( "Y", UNIX_TIME ) . "-" . date( "m", UNIX_TIME ) . "-" . date( "d", UNIX_TIME ) . " 00:00:00" );
			$end = ( $start + 86399 );
			
  		return array( "( l.log_timestamp >= " . $start . " )", $start, $end );
  	}
  	
  	//entire day
  	elseif( ( $filter >= 1 AND $filter <= 7 ) )
  	{
			$time = ( UNIX_TIME - ( 86400 * ( $filter ) ) );
			
			$start = strtotime( date( "Y", $time ) . "-" . date( "m", $time ) . "-" . date( "d", $time ) . " 00:00:00" );
			$end = ( $start + 86399 );
			
  		return array( "( l.log_timestamp >= " . $start . " ) AND ( l.log_timestamp <= " . $end . " )", $start, $end );
  	}
		
  	//this week, based on todays date
  	elseif( $filter == "week" )
  	{
			$time = ( UNIX_TIME - ( 86400 * ( date( "w", UNIX_TIME ) ) ) );
			
			$start = strtotime( date( "Y", $time ) . "-" . date( "m", $time ) . "-" . date( "d", $time ) . " 00:00:00" );
			$end = ( $start + 604799 );
			
  		return array( "( l.log_timestamp >= " . $start . " )", $start, $end );
  	}
		
  	//entire week
  	elseif( substr( $filter, 0, 4 ) == "week" )
  	{
			$flag = explode( ":", $filter );
			
			$time = ( UNIX_TIME - ( ( 604800 * $flag[1] ) + ( 86400 * date( "w", UNIX_TIME ) ) ) );
			
			$start = strtotime( date( "Y", $time ) . "-" . date( "m", $time ) . "-" . date( "d", $time ) . " 00:00:00" );
			$end = ( $start + 604799 );
  		
			return array( "( l.log_timestamp >= " . $start . " ) AND ( l.log_timestamp <= " . $end . " )", $start, $end );
  	}
  	
  	//entire month
  	elseif( substr( $filter, 0, 5 ) == "month" )
  	{
  		$flag = explode( ":", $filter );
			
  		$start = strtotime( $flag[1] . "-" . $flag[2] . "-01 00:00:00" );
			$end = ( $start + ( 86400 * date( "t", $start ) ) - 1 );
			
  		return array( "( l.log_timestamp >= " . $start . " ) AND ( l.log_timestamp <= " . $end . " )", $start, $end );
  	} 
  }
	
	/*
	 * Construct date list options to todays date from archive start time (soo...messy..)
	 **/
	
	function construct_date_list_options( $selected_time = "" )
  {
  	global $kernel;
  	
  	$menu_selected[ 'date_' . $selected_time ] = " selected=\"selected\"";
		$log_break = false;
  	
		//day options
  	$kernel->vars['html']['filter_list_options'] = "<optgroup label=\"{$kernel->ld['lang_b_days']}\">\r\n";
		
		$kernel->vars['html']['filter_list_options'] .= "<option value=\"today\"" . $menu_selected['date_today'] . ">{$kernel->ld['lang_b_menu_sort']}{$kernel->ld['lang_b_today']}</option>\r\n";
  	
  	for( $i = 1; $i <= 7; $i++ )
  	{
			$time = ( UNIX_TIME - ( 86400 * $i ) );
			$stamp = strtotime( date( "Y", $time ) . "-" . date( "m", $time ) . "-" . date( "d", $time ) . " 00:00:00" );
  			
  		$selected_day = $i;
  		$display_day = date( "l", $stamp );
  		
  		if( $i == 1 )
  		{
  			$kernel->vars['html']['filter_list_options'] .= "<option value=\"" . $selected_day . "\"" . $menu_selected['date_' . $selected_day . '' ] . ">{$kernel->ld['lang_b_menu_sort']}{$kernel->ld['lang_b_yesterday']}</option>\r\n";
  		}
			elseif( $i == 7 )
  		{
  			$kernel->vars['html']['filter_list_options'] .= "<option value=\"" . $selected_day . "\"" . $menu_selected['date_' . $selected_day . '' ] . ">{$kernel->ld['lang_b_menu_sort']}{$kernel->ld['lang_b_last_menu_day']}{$display_day}</option>\r\n";
  		}
  		else
  		{
  			$kernel->vars['html']['filter_list_options'] .= "<option value=\"" . $selected_day . "\"" . $menu_selected['date_' . $selected_day . '' ] . ">{$kernel->ld['lang_b_menu_sort']}{$display_day}</option>\r\n";
  		}
  	}
  	
		//week options
  	$kernel->vars['html']['filter_list_options'] .= "</optgroup><optgroup label=\"{$kernel->ld['lang_b_weeks']}\">\r\n<option value=\"week:0\"" . $menu_selected['date_week:0'] . ">{$kernel->ld['lang_b_menu_sort']}{$kernel->ld['lang_b_this_week']}</option>\r\n<option value=\"week:1\"" . $menu_selected['date_week:1'] . ">{$kernel->ld['lang_b_menu_sort']}{$kernel->ld['lang_b_last_week']}</option>\r\n<option value=\"week:2\"" . $menu_selected['date_week:2'] . ">{$kernel->ld['lang_b_menu_sort']}2 Weeks ago</option>\r\n<option value=\"week:3\"" . $menu_selected['date_week:3'] . ">{$kernel->ld['lang_b_menu_sort']}3 Weeks ago</option>\r\n<option value=\"week:4\"" . $menu_selected['date_week:4'] . ">{$kernel->ld['lang_b_menu_sort']}4 Weeks ago</option>\r\n";
  	
		//month options
  	$i = 0;
		$current_year = date( "Y", UNIX_TIME );
		$current_month = date( "n", UNIX_TIME );
  	
  	$kernel->vars['html']['filter_list_options'] .= "</optgroup><optgroup label=\"{$kernel->ld['lang_b_months']}\">\r\n";
		
  	while( $log_break == false )
  	{
  		$stamp = strtotime( $current_year . "-" . $current_month . "-01 00:00:00" );
  		
  		$selected_mnt = date( "M", $stamp );
  		$display_mnt = $kernel->fetch_time( $stamp, "%B" );
  		$mnt_year = $current_year;
  		
  		if( $i == 0 )
  		{
  			$kernel->vars['html']['filter_list_options'] .= "<option value=\"month:" . $current_year . ":" . $current_month . "\"" . $menu_selected[ 'date_month:' . $current_year . ':' . $current_month ] . ">{$kernel->ld['lang_b_menu_sort']}{$kernel->ld['lang_b_this_month']}</option>\r\n";
  		}
  		else
  		{
  			$kernel->vars['html']['filter_list_options'] .= "<option value=\"month:" . $current_year . ":" . $current_month . "\"" . $menu_selected[ 'date_month:' . $current_year . ':' . $current_month ] . ">{$kernel->ld['lang_b_menu_sort']}{$display_mnt} {$mnt_year}</option>\r\n";
  		}
			
			$current_year = ( $current_month == 1 ) ? ( $current_year - 1 ) : $current_year;
			$current_month = ( ( $current_month - 1 ) < 1 ) ? 12 : ( $current_month - 1 );
  		
  		if( $kernel->config['archive_start'] >= $stamp )
  		{
  			$log_break = true; break;
  		}
  		
  		$i++;
  	}
  	
  	$kernel->vars['html']['filter_list_options'] .= "</optgroup>";
  }
	
/*
	 * Construct and update category "New File" for specified category, only really called with global_category_db_syncronisation() only.
	 **/
	
  function construct_db_category_top_new_file( $id )
  {
    global $kernel, $newest_file_id, $root_category;
  	
  	if( $kernel->config['category_new_file_construct_mode'] == 1 )
  	{
      $get_sub_cats = $kernel->db->query( "SELECT `category_id`, `category_newfile_id` FROM `" . TABLE_PREFIX . "categories` WHERE `category_sub_id` = {$id}" );  
      while( $subcategory = $kernel->db->data( $get_sub_cats ) )
      {
    		if( $subcategory['category_newfile_id'] > $newest_file_id )
  			{
  				$newest_file_id = $subcategory['category_newfile_id'];
  			}
    		
        $this->construct_db_category_top_new_file( $subcategory['category_id'] );
      }
  	}
		
  	//base cat new file check
    $category_new_file = $kernel->db->row( "SELECT `category_newfile_id` FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = {$root_category}" );
    if( $category_new_file['category_newfile_id'] > $newest_file_id )
  	{
  		$newest_file_id = $category_new_file['category_newfile_id'];
  	}
		
  	$kernel->db->update( "categories", array( "category_newfile_id" => $newest_file_id ), "WHERE `category_id` = {$root_category}" );
  }
	
	/*
	 * Construct and update category "File Count" for specified category, only really called with global_category_db_syncronisation() only.
	 **/
	
  function construct_db_category_top_file_count( $id )
  {
    global $kernel, $subcat_files;
  	
  	if( $kernel->config['category_file_count_mode'] == 1 || $kernel->config['category_file_count_mode'] == 2 )
  	{
      $get_sub_cats = $kernel->db->query( "SELECT `category_id`, `category_file_total` FROM `" . TABLE_PREFIX . "categories` WHERE `category_sub_id` = {$id}" );  
      while( $subcategory = $kernel->db->data( $get_sub_cats ) )
      {
    		$subcat_files += $subcategory['category_file_total'];
				
        $this->construct_db_category_top_file_count( $subcategory['category_id'] );
      }
  	}
  	
  	//base cat count to total
    $category_count = $kernel->db->row( "SELECT `category_file_total` FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = {$id}" );
    $total_files = $category_count['category_file_total'];
  	
  	$kernel->db->update( "categories", array( "category_file_total" => $total_files, "category_file_subtotal" => $subcat_files ), "WHERE `category_id` = {$id}" );
  }
	
	/*
	 * Wrapper function for global category syncronisation
	 **/
	
	function global_category_db_syncronisation()
	{
		global $kernel, $subcat_files, $newest_file_id, $total_files, $root_category;
		
		$get_categories = $kernel->db->query( "SELECT `category_id` FROM `" . TABLE_PREFIX . "categories`" );
		
		while( $category = $kernel->db->data( $get_categories ) )
		{
			$subcat_files = 0;
			$total_files = 0;
			$newest_file_id = 0;
			$root_category = $category['category_id'];
			
			$this->construct_db_category_top_new_file( $category['category_id'] );
			
			$this->construct_db_category_top_file_count( $category['category_id'] );
		}
	}
	
	/*
	 * Setup management action button based on statement
	 **/
	
  function update_category_file_total( $id )
  {
  	global $kernel;
  	
  	$get_file_count = $kernel->db->row( "SELECT COUNT(*) AS `count` FROM `" . TABLE_PREFIX . "files` WHERE `file_cat_id` = {$id} AND `file_disabled` = 0" );
  		
  	$categorydata = array( "category_file_total" => $get_file_count['count'] );
  	
    $kernel->db->update( "categories", $categorydata, "WHERE `category_id` = {$id}" );
  	
  	return true;
  }
  
	/*
	 * Setup management action button based on statement
	 **/
	
  function update_category_file_latest( $id )
  {
  	global $kernel;
  	
  	$latest_file_id = 0;
  	
    $get_new_file = $kernel->db->row( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_cat_id` = {$id} AND `file_disabled` = 0 ORDER BY `file_id` DESC LIMIT 1" );
    if( $get_new_file['file_id'] > 0 )
    {
    	$latest_file_id = $get_new_file['file_id'];
    }
    
    $categorydata = array( "category_newfile_id" => $latest_file_id );
    
    $kernel->db->update( "categories", $categorydata, "WHERE `category_id` = {$id}" );
  	
  	return true;
  }
	
	/*
	 * Retrieve file MD5 or SHA1 hash
	 **/
	
	function exec_file_hash( $url, $return_md5 = true )
	{
		global $kernel;
		
		if( PHP_VERSION >= 5.1 )
		{
			$url = $kernel->format_input( $url, T_DL_PARSE );
			
			if( $return_md5 == false )
			{
				$hash = @sha1_file( $url );
			}
			elseif( $return_md5 == true )
			{
				$hash = @md5_file( $url );
			}
			
			return ( $hash == false ) ? "" : $hash;
		}
		
		if( PHP_VERSION >= 4.2 )
		{
  		if( $url{1} == ":" OR $url{0} == "/" OR $url{0} == "\\" )
  		{
  			if( $return_md5 == false AND PHP_VERSION >= 4.3 )
  			{
  				$hash = @sha1_file( $url );
  			}
  			elseif( $return_md5 == true )
  			{
  				$hash = @md5_file( $url );
  			}
  			
  			return ( $hash == false ) ? "" : $hash;
  		}
			
			if( strstr( $url, $kernel->config['system_root_url_upload'] ) == true )
			{
				if( $url = str_replace( $kernel->config['system_root_url_upload'], $kernel->config['system_root_dir_upload'], $url ) )
				{
    			if( $return_md5 == false AND PHP_VERSION >= 4.3 )
    			{
    				$hash = @sha1_file( $url );
    			}
    			elseif( $return_md5 == true )
    			{
    				$hash = @md5_file( $url );
    			}
    			
    			return ( $hash == false ) ? "" : $hash;
				}
			}
		}
		
		return "";
	}
	
	/*
	 * Prepare and exec file download
	 **/
	
  function exec_file_download( $details, $user_baud = 0 )
  {
  	global $kernel, $_SERVER;
  	
		$file_info = $kernel->archive_function->file_url_info( $details['url'] );
		
		//Hash checking enabled?
		if( $kernel->config['archive_file_check_hash'] == "true" AND !empty( $details['hash'] ) )
		{
			list( $file_hash_md5, $file_hash_sha1 ) = explode( ",", $details['hash'] );
			
			$md5 = $this->exec_file_hash( $details['url'] );
			$sha1 = $this->exec_file_hash( $details['url'], false );
			
			if( ( $file_hash_md5 != $md5 AND !empty( $md5 ) ) OR ( $file_hash_sha1 != $sha1 AND !empty( $sha1 ) ) )
			{
				//Log hash difference and continue..
				$kernel->db->insert( "logs", array( "log_type" => 4, "log_file_id" => $details['id'], "log_user_id" => $kernel->session['session_user_id'], "log_mirror_id" => $details['mirror_id'], "log_user_agent" => HTTP_AGENT, "log_timestamp" => UNIX_TIME, "log_ip_address" => IP_ADDRESS ) );
			
  			if( $kernel->config['email_notify_modified_url'] == "true" )
  			{
  				$emaildata = array(
						"file_name" => $details['name'],
						"user_name" => ( !empty( $kernel->session['session_name'] ) AND USER_LOGGED_IN == true ) ? $kernel->session['session_name'] : $kernel->ld['lang_f_guest'],
						"category_name" => $kernel->db->item( "SELECT c.category_name FROM " . TABLE_PREFIX . "files f LEFT JOIN " . TABLE_PREFIX . "categories c ON ( f.file_cat_id = c.category_id ) WHERE f.file_id = " . $details['id'] . "" ),
						"archive_title" => $kernel->config['archive_name']
  				);
  				
  				$kernel->archive_function->construct_send_email( "file_modified_url_notification", $kernel->config['mail_inbound'], $emaildata );
  			}
			}
		}
		
		//URL is not a server link
		if( $details['url']{1} != ":" AND $details['url']{0} != "/" AND $details['url']{0} != "\\" )
		{
  		//Clean var for browser parsing, and IE whitespace fix.
  		$details['url'] = $kernel->format_input( $details['url'], T_DL_PARSE );
			
  		//Masked download mode and URL is indirect
  		if( $kernel->config['file_download_mode'] == 1 )
  		{
  			header( "Location: " . $details['url'] . "" );
  			exit;
  		}
  		//Direct link download mode
  		if( $kernel->config['file_download_mode'] == 0 )
  		{  			
  			if( $kernel->url_exists( $details['url'] ) != true AND SAFE_MODE == false )
  			{
  				$kernel->db->insert( "logs", array( "log_type" => 3, "log_file_id" => $details['id'], "log_user_id" => $kernel->session['session_user_id'], "log_mirror_id" => $details['mirror_id'], "log_user_agent" => HTTP_AGENT, "log_timestamp" => UNIX_TIME, "log_ip_address" => IP_ADDRESS ) );
  				
  				if( $kernel->config['email_notify_broken_url'] == "true" )
    			{
    				$emaildata = array(
  						"file_name" => $details['name'],
							"user_name" => ( !empty( $kernel->session['session_name'] ) AND USER_LOGGED_IN == true ) ? $kernel->session['session_name'] : $kernel->ld['lang_f_guest'],
							"category_name" => $kernel->db->item( "SELECT c.category_name FROM " . TABLE_PREFIX . "files f LEFT JOIN " . TABLE_PREFIX . "categories c ON ( f.file_cat_id = c.category_id ) WHERE f.file_id = " . $details['id'] . "" ),
  						"archive_title" => $kernel->config['archive_name']
    				);
    				
    				$kernel->archive_function->construct_send_email( "file_broken_url_notification", $kernel->config['mail_inbound'], $emaildata );
    			}
					
  				$kernel->page_function->message_report( $kernel->ld['lang_f_file_no_download'], M_ERROR, HALT_EXEC );
  			}
  			else
  			{
      		header( "Content-type: " . $file_info['file_mime'] . "; name=" . $file_info['file_name'] . "" );
      		header( "Content-disposition: attachment; filename=" . $file_info['file_name'] . "" );
      		
      		if( $details['size'] > 0 AND $kernel->config['file_download_size_mode'] == 1 )
      		{
      			header( "Content-length: " . $details['size'] . "" );
      		}
      		
      		header( "Location: " . $details['url'] . "" );
  				exit;
  			}
  		}
		}
		
		@ob_end_clean();
		
		//Masked download, with resume support
  	if( isset( $_SERVER['HTTP_RANGE'] ) )
  	{
      list( , $server_range ) = explode( "=", $_SERVER['HTTP_RANGE'] );
      str_replace( $server_range, "-", $server_range );
  		
      header( "HTTP/1.1 206 Partial Content" );
  		
  		if( $details['size'] > 0 )
  		{
      	header( "Content-Length: " . ( $details['size'] - $server_range ) . "" );
  		}
  		
      header( "Content-Range: bytes " . $server_range . "" . ( $details['size'] - 1 ) . "/" . $details['size'] . "" );
  	}
  	
    header( "Last-Modified: " . date( "D, d M Y H:i:s \G\M\T" , $details['timestamp'] ) );
    header( "Accept-Ranges: bytes" );
    header( "Cache-control: public" );
    header( "Pragma: public" );
		
		if( $details['size'] > 0 AND $config['file_download_size_mode'] == 1 )
		{
			header( "Content-length: " . $details['size'] . "" );
		}
  	
  	$chunk_send_size = ( $user_baud > 0 ) ? ( $user_baud * 1024 ) : ( 8 * 1024 );
  	
		// URL is not a server link
		if( $details['url']{1} != ":" AND $details['url']{0} != "/" AND $details['url']{0} != "\\" )
		{
			//Clean var for browser parsing, and IE whitespace fix.
			$details['url'] = $kernel->format_input( $details['url'], T_DL_PARSE );
			
  		$parse = @parse_url( $details['url'] );
  		if( empty( $parse['port'] ) ) $parse['port'] = 80;
			
			$fp = @fsockopen( $parse['host'] . $parse['path'], $parse['port'], $errno, $errstr, $kernel->config['system_parse_timeout'] );
		}
		
		// Server link
		else
		{
			$fp = @fopen( $details['url'], "rb" );
		}
		
		if( $fp == true )
  	{
  		header( "Content-type: " . $file_info['file_mime'] . "; name=" . $file_info['file_name'] . "" );
    	header( "Content-disposition: attachment; filename=" . $file_info['file_name'] . "" );
  		
      if( isset( $_SERVER['HTTP_RANGE'] ) )
  		{
      	@fseek( $fp, $server_range );
  		}
  		
  		while( !feof( $fp ) AND connection_status() == 0 )
      {
        echo fread( $fp, $chunk_send_size );
				
        @flush();
  			@ob_flush();
  			
        if( $user_baud > 0 ) sleep( 1 );
      }
  		
      fclose( $fp );
			
			exit;
  	}
  	else
  	{
			$kernel->db->insert( "logs", array( "log_type" => 3, "log_file_id" => $details['id'], "log_user_id" => $kernel->session['session_user_id'], "log_mirror_id" => $details['mirror_id'], "log_user_agent" => HTTP_AGENT, "log_timestamp" => UNIX_TIME, "log_ip_address" => IP_ADDRESS ) );
			
			if( $kernel->config['email_notify_broken_url'] == "true" )
			{
				$emaildata = array(
					"file_name" => $details['name'],
					"user_name" => ( !empty( $kernel->session['session_name'] ) AND USER_LOGGED_IN == true ) ? $kernel->session['session_name'] : $kernel->ld['lang_f_guest'],
					"category_name" => $kernel->db->item( "SELECT c.category_name FROM " . TABLE_PREFIX . "files f LEFT JOIN " . TABLE_PREFIX . "categories c ON ( f.file_cat_id = c.category_id ) WHERE f.file_id = " . $details['id'] . "" ),
					"archive_title" => $kernel->config['archive_name']
				);
				
				$kernel->archive_function->construct_send_email( "file_broken_url_notification", $kernel->config['mail_inbound'], $emaildata );
			}
			
  		$kernel->page_function->message_report( $kernel->ld['lang_f_file_no_download'], M_ERROR, HALT_EXEC );
  	}
  }
	
	/*
	 * Construct and send out an email
	 **/
	
	function construct_send_email( $template_name, $recipient, $data )
	{
  	global $kernel;
  	
  	$get_template = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "templates_email` WHERE `template_name` = '" . $template_name . "'" );
  	
		if( $kernel->db->numrows() > 0 )
		{
			$template = $kernel->db->data( $get_template );
			
			//$kernel->config['mail_outbound']
    	$headers = "From: " . $kernel->config['archive_name'] . " <" . $kernel->config['mail_outbound'] . ">\r\n";
    	$headers .= "MIME-Version: 1.0\r\n";
    	$headers .= "Content-type: text/html; charset=" . $kernel->ld['lang_charset'] . "\r\n";
			
			$template['template_data'] = $kernel->format_input( $template['template_data'], T_HTML );
			
			$template['template_subject'] = $kernel->tp->cache( $data, 0, $template['template_subject'] );
			$template['template_data'] = $kernel->tp->cache( $data, 0, $template['template_data'] );
			
			if( FUNC_INI_GET == true )
			{
				if( !empty( $kernel->config['mail_smtp_path'] ) ) @ini_set( "SMTP", $kernel->config['mail_smtp_path'] );
				if( !empty( $kernel->config['mail_smtp_port'] ) ) @ini_set( "smtp_port", $kernel->config['mail_smtp_port'] );
				
				@ini_set( "sendmail_from", $kernel->config['mail_outbound'] );
			}
			
			if( @mail( $recipient, $template['template_subject'], $template['template_data'], $headers ) )
			{
				return true;
			}
		}
		
		return false;
	}
}

?>