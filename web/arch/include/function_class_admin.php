<?php

################################################################################
#	PHCDownload - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDL is free to use. Please visit the website for futher licence
# information and details on re-distribution and use.
################################################################################

define( "LIST_ALL",		0 );
define( "LIST_FILE",	1 );
define( "LIST_DIR",		2 );

class class_admin_function
{
	/*
	 * INIT exisiting ACP session
	 **/
	
  function message_admin_report( $phrase = "lang_b_log_settings_updated", $screen_data = "", $log_data = "" )
  {
  	global $kernel;
		
		if( is_array( $log_data ) )
		{
			$log_data = implode( ", ", str_replace( ",", "", $log_data ) ); 
		}
		elseif( empty( $log_data ) )
		{
			$log_data = $screen_data;
		}
  	
    $logdata = array(
			"log_user_id" => $kernel->session['adminsession_user_id'],
    	"log_node" => $kernel->vars['node'],
			"log_reference"	=> $kernel->format_input( $screen_data, T_DB ),
    	"log_data"	=> $kernel->format_input( $log_data, T_DB ),
			"log_phrase" => $phrase,
    	"log_timestamp" => UNIX_TIME,
			"log_ip_address" => IP_ADDRESS
    );
		
		$kernel->db->insert( "logs_admin", $logdata );
		
		$urldata = array(
			"referer_node" => $kernel->vars['node'],
			"referer_url" => SCRIPT_REFERER,
			"screen_data" => sprintf( $kernel->ld[ "$phrase" ], $screen_data ),
			"redirect_seconds" => $kernel->config['admin_message_refresh_seconds'],
		);
		
		//Construct message data strings
		foreach( $urldata AS $arg => $value )
		{
			$message_string .= "&" . $arg . "=" . $kernel->format_input( $value, T_URL_ENC ) . "";
		}
		
  	header( "Location: index.php?hash=" . $kernel->session['hash'] . "&node=message" . $message_string . "" );
  }
	
	/*
	 * INIT exisiting ACP session
	 **/
	
	function init_acp_session_driver()
	{
		global $kernel;
		
  	if( !isset( $kernel->vars['hash'] ) OR empty( $kernel->vars['hash'] ) )
  	{
			$this->construct_user_login( $kernel->ld['lang_b_no_session'] );
  	}
		else
		{
			$get_session = $kernel->db->query( "SELECT s.adminsession_user_id, s.adminsession_group_id, s.adminsession_hash, s.adminsession_name, s.adminsession_password, s.adminsession_agent, s.adminsession_ip_address, s.adminsession_permissions FROM " . TABLE_PREFIX . "sessions_admin s WHERE s.adminsession_hash = '" . $kernel->vars['hash'] . "'" );
			
			if( $kernel->db->numrows( $get_session ) == 0 )
			{
  			$this->construct_user_login( $kernel->ld['lang_b_bad_session'] );
			}
			else
			{
				$session = $kernel->db->data( $get_session );
				$kernel->session =& $session;
				
				if( $kernel->session['adminsession_ip_address'] != IP_ADDRESS )
				{
					$this->construct_user_login( $kernel->ld['lang_b_bad_ip_address'] );
				}
				
				if( $kernel->session['adminsession_agent'] != HTTP_AGENT )
				{
					$this->construct_user_login( $kernel->ld['lang_b_bad_browser'] );
				}
				
				$get_permissions = $kernel->db->query( "SELECT u.user_group_id, g.usergroup_panel_permissions FROM " . TABLE_PREFIX . "users u LEFT JOIN " . TABLE_PREFIX . "usergroups g ON ( u.user_group_id = g.usergroup_id ) WHERE u.user_id =  " . $kernel->session['adminsession_user_id'] . " AND u.user_name = '" . $kernel->session['adminsession_name'] . "' AND u.user_password = '" . $kernel->session['adminsession_password'] . "'" );
				
				if( $kernel->db->numrows( $get_permissions ) == 0 )
				{
					$this->construct_user_login( $kernel->ld['lang_b_invalid_session'] );
				}
				
				$user = $kernel->db->data( $get_permissions );
				
				if( $user['user_group_id'] != 1 AND strpos( $user['usergroup_panel_permissions'], "1" ) === false AND $kernel->session['adminsession_permissions'] === $user['usergroup_panel_permissions'] )
				{
					$this->construct_user_login( $kernel->ld['lang_b_no_access'] );
				}
				else
				{
					$kernel->db->update( "sessions_admin", array( "adminsession_run_timestamp" => UNIX_TIME ), "WHERE `adminsession_hash` = '" . $kernel->session['adminsession_hash'] . "'" );
					
					$kernel->session['hash'] = $kernel->session['adminsession_hash']; //This is temp until var is integrated into a _SESSION's
					
					return true;
				}
			}
		}
		
		return false;
	}
	
	/*
	 * Build login form
	 **/
	
	function construct_user_login( $html_message )
	{
		global $kernel;
		
  	$kernel->tp->call( "admin_login" );
		$kernel->tp->cache( array( "login_error_message" => $html_message, "phcdl_acp_user_name" => $_COOKIE['phcdl_acp_user_name'] ) );
		
		$kernel->vars['page_struct']['system_page_action_title'] = $kernel->ld['lang_b_title_control_panel_login'];
		
		$kernel->page_function->construct_output( false, R_FOOTER );
		
		exit;
	}
	
	/*
	 * Re-write the config.ini.php with new $_POST values
	 **/
	
  function write_config_ini()
  {
  	global $kernel, $_POST;
  		
  	$settings_array = array(
  		"settings"	=> "lang_b_log_settings_updated",
  		"archive"		=> "lang_b_log_archive_settings_updated",
  		"category"	=> "lang_b_log_category_settings_updated",
  		"control"		=> "lang_b_log_control_panel_settings_updated",
			"mail"			=> "lang_b_log_email_settings_updated",
  		"file"			=> "lang_b_log_file_settings_updated",
			"filter"		=> "lang_b_log_anti_leech_settings_updated",
  		"system"		=> "lang_b_log_system_settings_updated",
  		"user"			=> "lang_b_log_user_settings_updated"
  	);
  	
  	//current values
  	while( list( $config_key, $config_value ) = each( $kernel->config ) )
  	{
  		$config_original[ "$config_key" ] = addslashes( $config_value );
  	}
		
		//replacement values
  	foreach( $_POST AS $config_key => $config_value )
  	{
  		if( empty( $config_key ) OR $config_key == "form" ) continue;
			
			$original = array( "\\", chr( 10 ), chr( 13 ), "\\\\'" );
			$replaced = array( '\\\\', '\\\\n', '\\\\r', '\\' );
			
			$config_original[ "$config_key" ] = str_replace( $original, $replaced, $config_value );
  	}
  	ksort( $config_original );
		
		//write template
  	$new_config_ini = "<" . "?php\r\n\r\n";
  	
  	foreach( $config_original AS $config_key => $config_value )
  	{
			if( intval( $config_value ) <> 0 AND strlen( intval( $config_value ) ) === strlen( $config_value ) )
			{
  			$new_config_ini .= "\$config['" . $config_key . "']\t\t\t\t=\t" . $config_value . ";\r\n"; //String
			}
			else
			{
				$new_config_ini .= "\$config['" . $config_key . "']\t\t\t\t=\t\"" . $config_value . "\";\r\n"; //Int
			}
  	}
  	
  	$new_config_ini .= "\r\n?" . ">";
		
		//check file accessability
		if( is_readable( ROOT_PATH . "include/config.ini.php" ) == false OR is_writable( ROOT_PATH . "include/config.ini.php" ) == false )
		{
			clearstatcache();
			
			@chmod( ROOT_PATH . "include/config.ini.php", 0757 );
			
			if( is_readable( ROOT_PATH . "include/config.ini.php" ) == false )
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_chmod_config_open_editing'], M_ERROR, HALT_EXEC );
			}
			clearstatcache();
			
  		if( is_writable( ROOT_PATH . "include/config.ini.php" ) == false )
  		{
  			$kernel->page_function->message_report( $kernel->ld['lang_b_chmod_config_write_editing'], M_ERROR, HALT_EXEC );
  		}
			clearstatcache();
		}
		
		//open, truncate and write
  	$fp = fopen( ROOT_PATH . "include/config.ini.php", "w" );
		
		fwrite( $fp, $new_config_ini );
		
		unset( $config_original, $new_config_ini );
		
		$kernel->admin_function->message_admin_report( $settings_array[ $kernel->vars['setting'] ], 0 );
  }
	
	/*
	 * Re-write the filetype.ini.php with new $_POST values
	 **/
	
  function write_filetype_ini()
  {
  	global $kernel, $_POST;
		
		$count = 0;
  	
		//write template
  	$new_filetype_ini = "<" . "?php\r\n\r\n\$filetypes\t=\tarray(\r\n";
		
		for( $i = 0; $i <= sizeof( $_POST['filetype_name'] ); $i++ )
		{
			if( empty( $_POST['filetype_mime'][ $i ] ) OR empty( $_POST['filetype_image'][ $i ] ) ) continue;
			
			$_POST['filetype_name'][ $i ] = strtoupper( $_POST['filetype_name'][ $i ] );
			
			$filetype_array[ $_POST['filetype_name'][ $i ] ] = "\t\"" . $_POST['filetype_name'][ $i ] . "\"\t\t=>\tarray( \"" . $_POST['filetype_image'][ $i ] . "\", \"" . $_POST['filetype_mime'][ $i ] . "\" ),\r\n";
			
			$count++;
		}
		sort( $filetype_array );
		
		foreach( $filetype_array AS $filetype )
		{
			$new_filetype_ini .= $filetype;
		}
		
		$new_filetype_ini = preg_replace( "/,\r\n$/", "", $new_filetype_ini ); 
		
		$new_filetype_ini .= "\r\n);\r\n\r\n?" . ">";
		
		//check file accessability
		if( is_readable( ROOT_PATH . "include/filetype.ini.php" ) == false OR is_writable( ROOT_PATH . "include/filetype.ini.php" ) == false )
		{
			clearstatcache();
			
			@chmod( ROOT_PATH . "include/filetype.ini.php", 0757 );
			
			if( is_readable( ROOT_PATH . "include/filetype.ini.php" ) == false )
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_chmod_filetype_open_editing'], M_ERROR, HALT_EXEC );
			}
			clearstatcache();
			
  		if( is_writable( ROOT_PATH . "include/filetype.ini.php" ) == false )
  		{
  			$kernel->page_function->message_report( $kernel->ld['lang_b_chmod_filetype_write_editing'], M_ERROR, HALT_EXEC );
  		}
			clearstatcache();
		}
		
		//open, truncate and write
  	$fp = fopen( ROOT_PATH . "include/filetype.ini.php", "w" );
		
		fwrite( $fp, $new_filetype_ini );
		
		unset( $filetype_original, $new_filetype_ini );
		
		$kernel->db->update( "datastore", array( "datastore_value" => $count ), "WHERE `datastore_key` = 'count_total_filetypes'" );
		
		//done
		$kernel->admin_function->message_admin_report( "lang_b_log_filetypes_updated", 0 );
  }
	
	/*
	 * Builds the full directory tree of a specified directory into <select> options.
	 **/
	
  function read_directory_tree( $directory, $open_directory = "" )
  {
  	global $kernel;
  	
  	$short_directory = substr( $directory, strlen( $kernel->config['system_root_dir_upload'] ), strlen( $directory ) );
		
  	$handle = opendir( $directory );
  	
  	while( ( $item = @readdir( $handle ) ) !== false )
  	{
  		if( $item == "." OR $item == ".." ) continue;
			
  		if( @chdir( $directory . DIR_STEP . $item ) )
  		{
  			//check if is open category and select
				if( $short_directory . DIR_STEP . $item == $open_directory )
  			{
					$option_display_value = "{$short_directory}" . DIR_STEP . "{$item} {$kernel->ld['lang_b_upload_dir_current_location']}";
					
  				$kernel->vars['html']['directory_list_options'] .= "<option value=\"{$short_directory}" . DIR_STEP . "{$item}\" selected=\"selected\">" . $option_display_value . "</option>\r\n";
  			}
  			else
  			{
					$option_display_value = "{$short_directory}" . DIR_STEP . "{$item}";
					
  				$kernel->vars['html']['directory_list_options'] .= "<option value=\"{$short_directory}" . DIR_STEP . "{$item}\">" . $option_display_value . "</option>\r\n";
  			}
  			
  			$this->read_directory_tree( $directory . DIR_STEP . $item, $open_directory );
  		}
  	}
  }
	
	/*
	 * Returns the file size of all files in a given directory.
	 **/
	
  function read_directory_size( $directory )
  {
  	global $kernel, $size, $dir_count, $file_count;
  	
  	$handle = opendir( $directory );
  	
  	while( ( $item = @readdir( $handle ) ) !== false )
  	{
  		if( $item == "." OR $item == ".." ) continue;
  		
  		//check for dir
			if( @chdir( $directory . DIR_STEP . $item ) )
			{
				$this->read_directory_size( $directory . DIR_STEP . $item );
				$dir_count++;
			}
    	else
  		{
    		$size += @filesize( $directory . DIR_STEP . $item );
    		$file_count++;
  		}
  	}
  	
  	return array( $size, $file_count, $dir_count );
  }
	
	/*
	 * Return directory index of image folder. (expand for subs maybe?..uh no?..aww com'on)
	 **/
	
	function read_image_directory_index( $directory, $return_optgroup = 1 )
  {
		global $kernel;
		
    $handle = opendir( $directory );
    
    $kernel->vars['html']['image_list_options'] = ( $return_optgroup == 1 ) ? "<option value=\"\"></option>\r\n<optgroup label=\"{$kernel->ld['lang_b_menu_choose_local_file']}\">\r\n" : "";
    
    while( ( $item = @readdir( $handle ) ) !== false )
    {
      if( $item == "." OR $item == ".." ) continue;
  		
    	//check for dir
    	if( @chdir( $directory . DIR_STEP . $item ) ) continue;
      
      $file_info = $kernel->archive_function->file_url_info( $directory . $item );
  		
      if( $kernel->config['allow_unknown_url_linking'] == 1 OR $file_info['file_type_exists'] == true OR $kernel->session['adminsession_group_id'] == 1 )
      {
        if( $total_rows = $kernel->db->numrows( "SELECT `image_id` FROM `" . TABLE_PREFIX . "images` WHERE `image_file_name` = '{$item}'" ) > 0 )
        {
        	$kernel->vars['html']['image_list_options'] .= "<option style=\"color: #999999;\" value=\"{$item}\">{$item}</option>\r\n";
        }
        else
        {
        	$kernel->vars['html']['image_list_options'] .= "<option value=\"{$item}\">{$item}</option>\r\n";
        }
      }
		}
    
    $kernel->vars['html']['image_list_options'] .= ( $return_optgroup == 1 ) ? "</optgroup>\r\n" : "";
	}
	
	/*
	 * Return directory index of upload folder. (expand for subs maybe?..uh no?..aww com'on)
	 **/
	
	function read_upload_directory_index( $directory, $return_optgroup = 1 )
  {
		global $kernel;
		
    $handle = opendir( $directory );
    
    $kernel->vars['html']['file_list_options'] = ( $return_optgroup == 1 ) ? "<option value=\"\"></option>\r\n<optgroup label=\"{$kernel->ld['lang_b_menu_choose_local_file']}\">\r\n" : "";
    
    while( ( $item = @readdir( $handle ) ) !== false )
    {
      if( $item == "." OR $item == ".." ) continue;
  		
    	//check for dir
    	if( @chdir( $directory . DIR_STEP . $item ) ) continue;
      
      $file_info = $kernel->archive_function->file_url_info( $directory . $item );
  		
      if( $kernel->config['allow_unknown_url_linking'] == 1 OR $file_info['file_type_exists'] == true OR $kernel->session['adminsession_group_id'] == 1 )
      {
        if( $total_rows = $kernel->db->numrows( "SELECT `file_id` FROM " . TABLE_PREFIX . "files f WHERE MATCH( f.file_name, f.file_description, f.file_version, f.file_author ) AGAINST ('*" . addslashes( $item ) . "*')" ) > 0 )
        {
        	$kernel->vars['html']['file_list_options'] .= "<option style=\"color: #999999;\" value=\"{$item}\">{$item}</option>\r\n";
        }
        else
        {
        	$kernel->vars['html']['file_list_options'] .= "<option value=\"{$item}\">{$item}</option>\r\n";
        }
      }
		}
    
    $kernel->vars['html']['file_list_options'] .= ( $return_optgroup == 1 ) ? "</optgroup>\r\n" : "";
	}
	
	/*
	 * Return directory index of a folder.
	 **/
	
	function read_directory_index( $key_name, $flag = false, $phrase = false, $directory = DIR_STEP, $list_option = 0 )
  {
		global $kernel;
		
    $handle = opendir( $directory );
    
		$kernel->vars['html'][ $key_name . "_list_options" ] = ( $phrase == false ) ? "" : "<option value=\"\"></option>\r\n<optgroup label=\"" . $kernel->ld[ "$phrase" ] . "\">\r\n";
    
    while( ( $item = @readdir( $handle ) ) !== false )
    {
      if( $item == "." OR $item == ".." ) continue;
			if( $list_option == 2 AND $item == "index.html" OR $item == "index.htm" ) continue;
    	if( $list_option == 1 AND @chdir( $directory . $item ) ) continue;
      
      if( $item == $flag AND $flag != false )
      {
        $kernel->vars['html'][ $key_name . "_list_options" ] .= "<option value=\"{$item}\" selected=\"selected\">{$item}</option>\r\n";
      }
      else
      {
        $kernel->vars['html'][ $key_name . "_list_options" ] .= "<option value=\"{$item}\">{$item}</option>\r\n";
      }
		}
    
    $kernel->vars['html'][ $key_name . "_list_options" ] .= "</optgroup>\r\n";
	}
	
	/*
	 * Return state of a permissions flag
	 **/
	
  function read_permission_flags( $key_1 = "", $key_2 = "", $key_3 = "" )
  {
  	global $kernel;
  	
  	$attributes = explode( ",", $kernel->session['adminsession_permissions'] );	
  	
  	if( $kernel->session['adminsession_group_id'] <> 1 )
  	{
  		if( intval( $attributes[ $key_1 ] ) == 0 AND intval( $attributes[ $key_2 ] ) == 0 AND intval( $attributes[ $key_3 ] ) == 0 )
  		{
  			$kernel->page_function->message_report( $kernel->ld['lang_b_access_denied_to_node'], M_CRITICAL_ERROR, HALT_EXEC );
  		}
			elseif( ( intval( $attributes[ $key_1 ] ) == 0 AND !empty( $key_1 ) ) OR ( intval( $attributes[ $key_2 ] ) == 0 AND !empty( $key_2 ) ) OR ( intval( $attributes[ $key_3 ] ) == 0 AND !empty( $key_3 ) ) )
			{
				$kernel->page_function->message_report( "Some features are not available to you because you have limited permissions within this node.", M_ALERT );
			}
  	}
  }
	
	/*
	 * Return integrity of file url
	 **/
	
	function return_verify_file_url( $file_url, $file_id, $mirror_id = 0 )
	{
		global $kernel, $_SERVER;
		
		$file_url = $kernel->format_input( $file_url, T_DL_PARSE );
		
		$file_info = $kernel->archive_function->file_url_info( $file_url );
		
		if( ereg( $_SERVER['HTTP_HOST'], $file_url ) )
		{
			if( $kernel->url_exists( $file_url ) == true )
			{
				return "<a href=\"javascript:init_window( '{$kernel->config['system_root_url_path']}/admin/index.php?hash={$kernel->session['hash']}&node=file_validate&file_id={$file_id}&mirror_id={$mirror_id}&action=verify', 600, 600 )\"><img border=\"0\" src=\"./images/checked.gif\" alt=\"{$kernel->ld['lang_b_file_valid_url']}\"></a>";
			}
			else
			{
				return "<a href=\"javascript:init_window( '{$kernel->config['system_root_url_path']}/admin/index.php?hash={$kernel->session['hash']}&node=file_validate&file_id={$file_id}&mirror_id={$mirror_id}&action=verify', 600, 600 )\"><img border=\"0\" src=\"./images/alert.gif\" alt=\"{$kernel->ld['lang_b_file_invalid_url']}\"></a>";
			}
		}
		else
		{
			if( empty( $file_info['file_name'] ) )
			{
				return "<a href=\"javascript:init_window( '{$kernel->config['system_root_url_path']}/admin/index.php?hash={$kernel->session['hash']}&node=file_validate&file_id={$file_id}&mirror_id={$mirror_id}&action=verify', 600, 600 )\"><img border=\"0\" src=\"./images/alert.gif\" alt=\"{$kernel->ld['lang_b_file_unknown_location']}\"></a>";
			}
			else
			{
				return "<a href=\"javascript:init_window( '{$kernel->config['system_root_url_path']}/admin/index.php?hash={$kernel->session['hash']}&node=file_validate&file_id={$file_id}&mirror_id={$mirror_id}&action=verify', 600, 600 )\"><img border=\"0\" src=\"./images/information.gif\" alt=\"{$kernel->ld['lang_b_file_external_file']}\"></a>";
			}
		}
	}
	
	/*
	 * Construct and execute db queries for download mirrors based on _POST vars
	 **/
	
	function construct_db_write_download_mirrors( $file_id = 0, $mirror_data )
	{
		global $kernel;
		
		if( $kernel->config['form_max_mirror_fields'] != "0" )
		{
			$mirror_count = count( $mirror_data['mirror_id'] );
			
			$mirror_seq_count = 1;
			$last_domain = "";
			$used_mirror_names = array();
			$loop_count = 1;
			
			//Delete first so we can refresh and make available any used mirror names for naming mode if it has been selected.
			for( $i = 0; $i <= $mirror_count; $i++ )
			{
				if( empty( $mirror_data['mirror_file_url'][ $i ] ) AND intval( $mirror_data['mirror_id'][ $i ] ) > 0 AND $kernel->vars['node'] == "file_manage" )
				{
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "mirrors` WHERE `mirror_id` = {$mirror_data['mirror_id'][ $i ]}" );
					
					unset( $mirror_data[ $i ] );
				}
			}
			@reset( $mirror_data );
			
			$mirror_count = count( $mirror_data['mirror_id'] );
			
			//Add, update etc
			for( $i = 0; $i <= $mirror_count; $i++ )
			{
				if( !empty( $mirror_data['mirror_file_url'][ $i ] ) )
				{
					if( empty( $mirror_data['mirror_order'][ $i ] ) ) $mirror_data['mirror_order'][ $i ] = 0;
					
					if( empty( $mirror_data['mirror_name'][ $i ] ) )
					{
						$mirror_match = 1;
						$mirror_name_template = "";
						
						//Sequential mirrors
						if( $mirror_data['mirror_name_mode'] == 1 )
						{
							while( $mirror_match == 1 )
							{
								$mirror_name_template = sprintf( $kernel->ld['lang_b_mirror_name_sequential_template'], $loop_count );
								
								//Check for existing mirrors, and use next available mirror increment.
								if( $kernel->db->numrows( "SELECT `mirror_name` FROM `" . TABLE_PREFIX . "mirrors` WHERE `mirror_name` = '{$mirror_name_template}' AND `mirror_file_id` = '{$file_id}'" ) == 0 )
								{
									$mirror_match = 0; break;
								}
								
								$loop_count++;
							}
							
							$mirror_data['mirror_name'][ $i ] = sprintf( $kernel->ld['lang_b_mirror_name_sequential_template'], $loop_count );
						}
						
						//Domain name tied sequential mirrors
						elseif( $mirror_data['mirror_name_mode'] == 2 )
						{
							$mirror_data['mirror_file_domain'] = preg_match( "@^(?:http://)?([^/]+)@i", strtolower( $mirror_data['mirror_file_url'][ $i ] ), $matches );
							
							if( ereg( "www.", $matches[0] ) OR ereg( "http://", $matches[0] ) )
							{
								$domain_name = str_replace( array( "http://", "www." ), "", $matches[0] );
							}
							else
							{
								$domain_name = $matches[0];
							}
							
							while( $mirror_match == 1 )
  						{
  							$mirror_name_template = sprintf( $kernel->ld['lang_b_mirror_name_domain_template'], $domain_name, $loop_count );
  							
  							//Check to see if a domain and mirror id combo has been assigned to another mirror being added.
  							if( $loop_count > $used_mirror_names[ "$domain_name" ] )
  							{
  								//Check for existing mirrors, and use next available mirror increment.
  								if( $kernel->db->numrows( "SELECT `mirror_name` FROM `" . TABLE_PREFIX . "mirrors` WHERE `mirror_name` = '{$mirror_name_template}' AND `mirror_file_id` = {$file_id}" ) == 0 )
  								{
  									$used_mirror_names[ "$domain_name" ] = $loop_count;
  									
  									$mirror_match = 0; break;
  								}
  							}
  							
  							$loop_count++;
  						}
							
							$mirror_data['mirror_name'][ $i ] = sprintf( $kernel->ld['lang_b_mirror_name_domain_template'], $domain_name, $loop_count );
							
							$last_domain = $domain_name;
						}
					}
					
					if( $kernel->vars['node'] == "file_add" )
					{
						$mirror_data['mirror_id'][ $i ] = 0;
					}
					
					$mirror_list[] = array( $mirror_data['mirror_id'][ $i ], $mirror_data['mirror_name'][ $i ], $mirror_data['mirror_file_url'][ $i ], $mirror_data['mirror_order'][ $i ] );
				}
				$loop_count = 1;
				$mirror_seq_count++;
			}
			
			if( count( $mirror_list ) > 0 )
			{
				foreach( $mirror_list AS $mirror )
				{
					$mirrordata = array(
						"mirror_file_id" => $file_id,
						"mirror_name" => $kernel->format_input( $mirror[1], T_DB ),
						"mirror_file_url" => $kernel->format_input( $mirror[2], T_DB ),
						"mirror_order" => $mirror[3]
					);
					
					if( $kernel->vars['form_resync_mirrors'] == "1" )
					{
						$mirrordata['mirror_file_hash_data'] = $kernel->archive_function->exec_file_hash( $mirror[2] ) . "," . $kernel->archive_function->exec_file_hash( $mirror[2], false );
					}
					
					if( intval( $mirror[0] ) != 0 )
					{
						$kernel->db->update( "mirrors", $mirrordata, "WHERE `mirror_id` = {$mirror[0]}" );
					}
					else
					{
						$kernel->db->insert( "mirrors", $mirrordata );
					}
				}
			}
			
			$kernel->archive_function->update_database_counter( "mirrors" );
		}
	}
	
	/*
	 * Construct and write category list to datastore
	 **/
	
	function write_category_list()
	{
  	global $kernel, $category_list;
  	
    $category_list = "<option value=\"\"></option>\r\n<optgroup label=\"{\$lang_f_menu_choose_category}\">\r\n";
    
    $get_root_cats = $kernel->db->query( "SELECT category_id, category_name FROM " . TABLE_PREFIX . "categories WHERE category_sub_id = 0 ORDER BY category_order ASC" );
    while( $category = $kernel->db->data( $get_root_cats ) )
    {
      $padding = "&nbsp;+";
  		
  		$category_list .= "<option value=\"{$category['category_id']}\">{$category['category_name']}</option>\r\n";
  		
      $this->construct_category_branch( $category['category_id'], $padding . "&ndash;", $select_id );
    }
    
    $category_list .= "</optgroup>";
  	
  	$datastoredata = array( "datastore_value" => $category_list );
  	
  	$kernel->db->update( "datastore", $datastoredata, "WHERE `datastore_key` = 'category_dropmenu'" );
	}
	
	/*
	 * Construct category branch and stores for write_category_list()
	 **/
	
  function construct_category_branch( $id, $padding = "", $select_id = -1 )
  {
    global $kernel, $category_list;
    
    $get_sub_cats = $kernel->db->query( "SELECT category_id, category_name FROM " . TABLE_PREFIX . "categories WHERE category_sub_id = {$id} ORDER BY category_name DESC" );  
    while( $subcategory = $kernel->db->data( $get_sub_cats ) )
    {
    	$category_list .= "<option value=\"{$subcategory['category_id']}\">{$padding} {$subcategory['category_name']}</option>\r\n";
    	
    	$this->construct_category_branch( $subcategory['category_id'], $padding . "&ndash;", $select_id );
    }
    
    $padding = substr( $padding, 0, strlen( $padding ) - 7 );
  }
	
	/*
	 * Setup management action button based on statement
	 **/
	
	function button_status_if( $statement = false, $item_name, $image_base_name, $image_phrase, $image_url )
	{
		global $kernel;
		
		$html_delete_button = "";
		
		if( $image_base_name == "delete" )
		{
			$javascript_state = " onclick=\"return delete_confirm( '" . $kernel->ld['lang_b_are_you_sure_delete'] . " " . $item_name . "');\"";
		}
		
		if( $image_base_name == "revert" )
		{
			$javascript_state = " onclick=\"return confirm('" . $kernel->ld['lang_b_revert_template'] . " " . $item_name . "');\"";
		}
		
		if( $image_base_name == "rollback" )
		{
			$javascript_state = " onclick=\"return confirm('" . $kernel->ld['lang_b_confirm_rollback_template'] . " " . $item_name . "');\"";
		}
		
		if( $statement == true )
		{
			return "<img src=\"./images/" . $image_base_name . "_disabled.gif\" alt=\"Disabled: " . $image_phrase . "\" border=\"0\" />";
		}
		else
		{
			return "<a href=\"" . $image_url . "\"" . $javascript_state . "><img src=\"./images/" . $image_base_name . ".gif\" alt=\"" . $image_phrase . "\" border=\"0\" /></a>";
		}
	}
	
	/*
	 * Construct basic icon image
	 **/
	
	function construct_icon( $image_name, $image_phrase = "Icon", $statement = false, $alignment = "right" )
	{
		if( $statement == true )
		{
			return "<img border=\"0\" align=\"" . $alignment . "\" alt=\"" . $image_phrase . "\" src=\"./images/" . $image_name . "\" />";
		}
		else
		{
			return "";
		}
	}
}

?>