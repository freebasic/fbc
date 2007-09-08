<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

/*
 * Define function flag constants
 **/

define( "CACHE_TO_TOP",			1 );

define( "V_ARRAY",					110 );
define( "V_BIN",						120 );
define( "V_INT",						130 );
define( "V_PINT",						140 );
define( "V_STR",						150 );
define( "V_TIME",						160 );
define( "V_BOOL",						170 );
define( "V_MD5",						180 );

define( "T_HTML",						210 );
define( "T_NUM",						220 );
define( "T_FORM",						230 );
define( "T_URL_ENC",				240 );
define( "T_URL_DEC",				250 );
define( "T_NOHTML",					260 );
define( "T_DB",							270 );
define( "T_PREVIEW",				280 );
define( "T_STRIP",					290 );
define( "T_DL_PARSE",				300 );

/*
 * Core Kernel class
 **/

class class_kernel
{
	/*
	 * Sub class vars
	 **/
	
	var $db;											//database sub-class
	var $ld = array();						//phrase list from loaded language
	var $tp;											//template sub-class
	var $vars = array();					//template vars
	var $config = array();				//config globals
	var $session = array();				//user session data
	
	var $html = array();					//template html cache
	
	var $session_function = "";		//session sub-class functions
	var $page_function = "";			//page sub-class functions
	var $archive_function = "";		//archive sub-class functions
	var $admin_function = "";			//admin sub-class functions
	var $image_function = "";			//GDLib extension sub-class functions
	
	/*
	 * Initialise constant needed through out the kernel.
	 **/
	
	function init_system_environment()
	{
		
  	/*
  	 * Define system states
  	 **/
		
		if( function_exists( "ini_get" ) )
		{
			define( "FUNC_INI_GET", true );
			define( "SAFE_MODE", @ini_get( "safe_mode" ) ? true : false );
		}
		
		if( SAFE_MODE == false )
		{
			@set_time_limit( defined( SCRIPT_EXEC_LIMIT ) ? SCRIPT_EXEC_LIMIT : 0 );
		}
		
		//Yes, your bored, but this feature isn't very exciting, it just disables things..
		define( "IN_DEMO_MODE", false );
		
  	/*
  	 * Define system constants
  	 **/
  	
  	define( "IP_ADDRESS", $_SERVER['REMOTE_ADDR'] );
		define( "HTTP_AGENT", $_SERVER['HTTP_USER_AGENT'] );
		define( "HTTP_HOST", $_SERVER['HTTP_HOST'] );
		define( "UNIX_TIME", time() );
		
		define( "DF_SHORT", $this->config['system_date_format_short'] );
		define( "DF_LONG", $this->config['system_date_format_long'] );
		
  	define( "SCRIPT_NAME", $this->fetch_script_name() );
		define( "SCRIPT_PATH", "http://" . $_SERVER['HTTP_HOST'] . $_SERVER['PHP_SELF'] . "?" . $_SERVER['QUERY_STRING'] );
		define( "SCRIPT_REFERER", $_SERVER['HTTP_REFERER'] );
		
		define( "MAX_UPLOAD_SIZE", ( FUNC_INI_GET == true ) ? ( 1024 * intval( @ini_get( "upload_max_filesize" ) ) * 1024 ) : 0 );
		
		define( "FULL_VERSION", $this->config['full_version'] );
		
		if( strtoupper( substr( PHP_OS, 0, 3 ) ) == "WIN" )
  	{
  		$line_break = "\\r\\n";
			$line_break_char = chr( 13 ) . chr( 10 );
			$directory_seperator = "\\";
  	}
  	elseif( strtoupper( substr( PHP_OS, 0, 3 ) ) == "MAC" )
  	{
  		$line_break = "\\r";
			$line_break_char = chr( 13 );
			$directory_seperator = "/";
  	}
		else //*NIX
  	{
  		$line_break = "\\n";
			$line_break_char = chr( 10 );
			$directory_seperator = "/";
  	}
		
		define( "LINE_BREAK", $line_break );
		define( "LINE_BREAK_CHR", $line_break_char );
		define( "DIR_STEP", $directory_seperator );
		define( "SAPI_TYPE", php_sapi_name() );
		
		/*
  	 * Define structure vars (need to clean this up, put somewhere tidy and logical)
  	 **/
		
		$this->vars['page_struct'] = array();
		
		$this->vars['page_struct']['system_page_title'] = $this->config['archive_name'];
		$this->vars['page_struct']['system_page_action_title'] = "";
		$this->vars['page_struct']['system_page_announcement_id'] = 0;
		$this->vars['page_struct']['system_page_navigation_id'] = 0;
		$this->vars['page_struct']['system_page_navigation_html'] = array();
		
		$this->vars['page_struct']['system_meta_keywords'] = $this->config['archive_meta_keywords'];
		$this->vars['page_struct']['system_meta_description'] = $this->config['archive_meta_description'];
		
		$this->vars['page_struct']['system_root_url'] = $this->config['system_root_url_path'];
		$this->vars['page_struct']['system_root_url_home'] = $this->config['system_root_url_home'];
		$this->vars['page_struct']['system_root_dir_upload'] = $this->config['system_root_dir_upload'];
		$this->vars['page_struct']['system_short_version'] = $this->config['short_version'];
		$this->vars['page_struct']['system_page_exec_time'] = 0;
		$this->vars['page_struct']['system_date_year'] = date( "Y", UNIX_TIME );
		
		$this->vars['page_struct']['total_rows'] = 0;
		
		/*
  	 * Define html template vars (need to clean this up)
  	 **/
		
		$this->vars['html']['system_announcements_data'] = "";
		$this->vars['html']['system_navigation_data'] = "";
		$this->vars['html']['system_session_data'] = "";
	}
	
	/*
	 * Clean $variables in $variable_group and store in $vars sub class
	 **/
	
	function clean_array( $variable_group, $variables )
	{
		if( !is_array( $variable_group ) )
		{
			$super_global = $GLOBALS[ "$variable_group" ];
		}
		else
		{
			$super_global =& $variable_group;
		}
		
		foreach( $variables AS $variable_name => $variable_type )
		{
			$this->vars[ "$variable_name" ] = $this->clean_input( $super_global[ "$variable_name" ], $variable_type, isset( $super_global[ "$variable_name" ] ) );
		}
	}
	
	/*
	 * Clean $variable_data based on $variable_type and return
	 **/
	
	function clean_input( $variable_data, $variable_type, $variable_exists = true )
	{
    if( $variable_exists )
    {
			switch( $variable_type )
  		{
				//Array
  			case V_ARRAY: $variable_data = ( is_array( $variable_data ) ) ? $variable_data : array(); break;
  			
  			//Binary
  			case V_BIN: $variable_data = strval( $variable_data ); break;
				
				//Bool
  			case V_BOOL: $variable_data = ( $variable_data == true ) ? true : false; break;
				
  			//Integer
  			case V_INT: $variable_data = intval( $variable_data ); break;
				
				//MD5 Hash
  			case V_MD5: $variable_data = md5( $variable_data ); break;
  			
  			//Positive Integer
  			case V_PINT: $variable_data = ( intval( $variable_data ) < 0 ) ? 0 : intval( $variable_data ); break;
  			
  			//String
  			//case V_STR: $variable_data = trim( strval( $variable_data ) ); break;
				case V_STR: $variable_data = stripslashes( trim( $variable_data ) ); break;
				
				//UNIX Time
  			case V_TIME: $variable_data = substr( intval( $variable_data ), 0, 10 ); break;
  			
  			//Nothin'
  			default: break;
  			
  			return $variable_data;
  		}
		}
		else
		{
  		switch( $variable_type )
  		{
        //Array
        case V_ARRAY: $variable_data = array(); break;
        
        //Binary
        case V_BIN: $variable_data = ""; break;
				
				//Bool
  			case V_BOOL: $variable_data = ( $variable_data == true ) ? true : false; break;
        
        //Integer
        case V_INT: $variable_data = 0; break;
				
				//MD5 Hash
  			case V_MD5: $variable_data = md5( uniqid( mt_rand() ) ); break;
        
        //Positive Integer
        case V_PINT: $variable_data = 0; break;
        
        //String
        case V_STR: $variable_data = ""; break;
        
        //UNIX Time
        case V_TIME: $variable_data = UNIX_TIME; break;
        
        //Nothin'
        default: break;
  		}
		}
		
    return $variable_data;
	}
	
	/*
	 * Format $variable_data based on $variable_type and return
	 **/
	
	function format_input( $variable_data, $variable_type )
	{
		switch( $variable_type )
		{
			//HTML clean #$this->page_function->postit_code#
			case T_HTML: $variable_data = nl2br( $variable_data ); break;
			
			//HTML remove
			case T_NOHTML: $variable_data = strip_tags( $variable_data, $this->config['system_allowed_html_tags'] ); break;
			
			//HTML remove
			case T_PREVIEW: $variable_data = strip_tags( $variable_data, null ); break;
			
			//HTML <form> element clean
			case T_FORM:
			{
				$original = array( '\\n', '\\r', '"', "<", ">" );
				$replaced = array( chr( 10 ), chr( 13 ), "&quot;", "&lt;", "&gt;" );
				
				$variable_data = str_replace( $original, $replaced, $variable_data );
				
				break;
			}
			
			//Clean for database entry
			case T_DB: $variable_data = strip_tags( $variable_data, $this->config['system_allowed_html_tags'] ); break;
			
			//Clean for database entry
			case T_STRIP: $variable_data = stripslashes( $variable_data ); break;
			
			//URL friendly
			case T_URL_ENC: $variable_data = urlencode( $variable_data ); break;
			
			//URL friendly
			case T_URL_DEC: $variable_data = urldecode( $variable_data ); break;
			
			//URL parsable for filesizes
			case T_DL_PARSE: $variable_data = str_replace( " ", "%20", $variable_data ); break;
			
			//Format based on locale
			case T_NUM: $variable_data = number_format( $variable_data ); break;
			
			//Nothin'
			default: break;
		}
		
    return $variable_data;
	}
	
	/*
	 * Stripslashes on $array
	 **/
	
	function stripslashes_array( $array )
	{
    foreach( $array AS $array_key => $array_variable )
    {
      if( is_string( $array_variable ) )
      {
      	$array[ "$array_key" ] = stripslashes( $array_variable );
      }
      elseif( is_array( $array_variable ) )
      {
      	$array[ "$array_key" ] = $this->stripslashes_array( $array_variable );
      }
    }
    return $array;
	}
	
	/*
	 * Returns the name of the script.
	 **/
	
	function fetch_script_name()
	{
		$script_name = $_SERVER['PHP_SELF'] ? $_SERVER['PHP_SELF'] : $_ENV['PHP_SELF'];
		
  	preg_match( "/[^\/]+$/", $script_name, $matches );
		
		return $matches[0];
	}
	
	/*
	 * INIT the DATABASE driver
	 **/
	
	function init_database_driver()
	{
		if( empty( $this->config['db_driver'] ) OR $this->config['db_driver'] == "mysql_improved" AND PHP_VERSION < 5 )
		{
			$this->config['db_driver'] = "mysql_standard";
		}
		
  	require_once( ROOT_PATH . "include/class_" . $this->config['db_driver'] . ".php" );
		
		$this->db = new class_database;
		
		$this->db->config['server']				= $this->config['db_server'];
		$this->db->config['username']			= $this->config['db_username'];
		$this->db->config['password']			= $this->config['db_password'];
		$this->db->config['table_prefix']	= $this->config['db_table_prefix'];
		$this->db->config['port']					= $this->config['db_port'];
		$this->db->config['database']			= $this->config['db_database'];
		
		define( "TABLE_PREFIX",						$this->config['db_table_prefix'] );
		
		$this->db->connect();
	}
	
	/*
	 * INIT the TEMPLATE driver
	 **/
	
	function init_template_driver()
	{
		if( empty( $this->config['default_skin'] ) )
		{
			$this->config['default_skin'] = 1;
		}
		
  	require_once( ROOT_PATH . "include/class_template.php" );
		
		$this->tp = new class_template;
	}
	
	/*
	 * Return time format
	 **/
	
	function fetch_time( $timestamp, $formatting )
	{
		return strftime( $formatting, $timestamp );
	}
	
	/*
	 * Replace $array_1 key values with $array_2 values
	 **/
	
	function array_set( $array_1, $array_2 )
	{
		foreach( $array_2 AS $value )
		{
			$array_1[ $value ] = $value;
		}
		
		return $array_1;
	}
	
	/*
	 * INIT the SESSION driver
	 **/
	
	function init_session_driver()
	{
		global $_SESSION, $_COOKIE;  //temp
		
		$this->session['session_user_id'] = 0;
		$this->session['session_name'] = "";
		$this->session['session_permissions'] = $this->db->item( "SELECT `usergroup_archive_permissions` FROM `" . TABLE_PREFIX . "usergroups` WHERE `usergroup_id` = -1" );
		
  	if( empty( $_SESSION['phcdl_session_hash'] ) AND empty( $_COOKIE['phcdl_session_hash'] ) )
  	{
			if( $this->config['archive_allow_user_registration'] == "true" AND $this->config['session_force_login'] == 1 AND SCRIPT_NAME != "user.php" AND SCRIPT_NAME != "contact.php" )
			{
				$this->session_function->construct_user_login( $this->ld['lang_f_no_session'] );
			}
  	}
		else
		{
			if( $this->config['archive_allow_user_registration'] == "true" )
  		{
  			$_SESSION['phcdl_session_hash'] = ( !empty( $_COOKIE['phcdl_session_hash'] ) ) ? $_COOKIE['phcdl_session_hash'] : $_SESSION['phcdl_session_hash'];
    		$_SESSION['phcdl_user_id'] = ( !empty( $_COOKIE['phcdl_user_id'] ) ) ? $_COOKIE['phcdl_user_id'] : $_SESSION['phcdl_user_id'];
    		$_SESSION['phcdl_user_password'] = ( !empty( $_COOKIE['phcdl_user_password'] ) ) ? $_COOKIE['phcdl_user_password'] : $_SESSION['phcdl_user_password'];
  			
  			$get_session = $this->db->query( "SELECT * FROM `" . TABLE_PREFIX . "sessions` WHERE `session_hash` = '{$_SESSION['phcdl_session_hash']}' AND `session_user_id` = '{$_SESSION['phcdl_user_id']}' AND `session_password` = '{$_SESSION['phcdl_user_password']}'" );
  			
  			if( $this->db->numrows( $get_session ) == 0 )
  			{
  				//$this->session_function->construct_user_login( $this->ld['lang_f_bad_session'] );
					
      		$this->session_function->clear_user_cache();
  			}
  			else
  			{
  				$this->session = $this->db->data( $get_session );
  				
  				if( $this->session['session_ip_address'] !== IP_ADDRESS AND $this->config['session_ip_check'] == 1 )
  				{
  					$this->session_function->construct_user_login( $this->ld['lang_f_bad_ip_address'] );
  				}
  				
  				if( $this->session['session_ip_address'] !== HTTP_AGENT AND $this->config['session_http_agent_check'] == 1 )
  				{
  					$this->session_function->construct_user_login( $this->ld['lang_f_bad_browser'] );
  				}
  				
  				$get_user = $this->db->query( "SELECT u.user_group_id, g.usergroup_archive_permissions FROM " . TABLE_PREFIX . "users u LEFT JOIN " . TABLE_PREFIX . "usergroups g ON ( u.user_group_id = g.usergroup_id ) WHERE u.user_id = {$this->session['session_user_id']} AND u.user_name = '{$this->session['session_name']}' AND u.user_password = '{$this->session['session_password']}'" );
  				
  				if( $this->db->numrows( $get_user ) == 0 )
  				{
  					$this->session_function->construct_user_login( $this->ld['lang_f_invalid_session'] );
  				}
  				else
  				{
  					$this->db->update( "sessions", array( "session_run_timestamp" => UNIX_TIME ), "WHERE `session_hash` = '{$this->session['session_hash']}'" );
  					
  					define( "USER_LOGGED_IN", true );
  					
            $this->db->update( "session_cache", array( "cache_timestamp" => UNIX_TIME, "cache_session_downloads" => 0, "cache_session_bandwidth" => 0 ), "WHERE `cache_timestamp` < ( " . UNIX_TIME . " - 86400 )" );
  				}
  			}
			}
		}
	}
	
	/*
	 * Load in language phrases
	 **/
	
	function fetch_language_phrases()
	{
		if( empty( $this->config['default_language'] ) )
		{
			$this->config['default_language'] = "English_ISO-8859-1";
		}
		
		if( !empty( $this->config['system_allowed_html_tags'] ) )
		{
			define( "ALLOWED_HTML_TAGS", htmlentities( str_replace( '><', ', ', strtoupper( substr( $this->config['system_allowed_html_tags'], 1, strlen( $this->config['system_allowed_html_tags'] ) - 2 ) ) ) ) );
		}
		
  	if( defined( "IN_ACP" ) )
		{
			require_once( ROOT_PATH . "lang/" . $this->config['default_language']. "/backend.php" );
		}
		else
		{
			require_once( ROOT_PATH . "lang/" . $this->config['default_language']. "/frontend.php" );
		}
		
		$this->ld =& $ld;
		
		if( isset( $this->ld['lang_locale'] ) OR isset( $this->ld['lang_language'] ) )
		{
			setlocale( LC_ALL, $this->ld['lang_locale'] ? $this->ld['lang_locale'] : $this->ld['lang_language'] );
		}
	}
	
	/*
	 * Format seconds into Days, Hours, Minutes, Seconds
	 **/
	
  function format_seconds( $total_seconds = 0 )
  {
  	global $kernel;
  	
    if( $total_seconds > 0 )
    {
			$printstring = "";
      $remaning_seconds = $total_seconds;
      
      //days
      $count = 0;
      while( $remaning_seconds >= 86400 )
      {
        $remaning_seconds -= 86400;
        $count++;
      }
      $days = ( $count > 0 ) ? floor( $count ) : 0;
      
      //hours
      $count = 0;
      while( $remaning_seconds >= 3600 )
      {
        $remaning_seconds -= 3600;
        $count++;
      }
      $hours = ( $count > 0 ) ? floor( $count ) : 0;
      
      //minutes
      $count = 0;
      while( $remaning_seconds >= 60 )
      {
        $remaning_seconds -= 60;
        $count++;
      }
      $minutes = ( $count > 0 ) ? floor( $count ) : 0;
      
			//seconds
      $seconds = floor( $remaning_seconds );
			
			//Write the stringy
      if( $days != 0 )
  		{
  			$printstring .= ( $days == 1 ) ? sprintf( $kernel->ld['lang_date_day'], $days ) : sprintf( $kernel->ld['lang_date_days'], $days );
  		}
			
      if( $hours != 0 )
  		{
  			$printstring .= ( $hours == 1 ) ? sprintf( $kernel->ld['lang_date_hour'], $hours ) : sprintf( $kernel->ld['lang_date_hours'], $hours );
  		}
  		
  		if( $minutes != 0 )
  		{
  			$printstring .= ( $minutes == 1 ) ? sprintf( $kernel->ld['lang_date_minute'], $minutes ) : sprintf( $kernel->ld['lang_date_minutes'], $minutes );
  		}
  		
  		if( $seconds != 0 )
  		{
  			$printstring .= ( $seconds == 1 ) ? sprintf( $kernel->ld['lang_date_second'], $seconds ) : sprintf( $kernel->ld['lang_date_seconds'], $seconds );
  		}
  		
  		return $printstring;
    }
    else
    {
      return sprintf( $kernel->ld['lang_date_seconds'], $total_seconds );
    }
  }
	
	/*
	 * Check external URL
	 **/
	
	function url_exists( $url = false )
	{
    global $kernel;
    
    return true;
		
    /*
    //Clean var for browser parsing, and IE whitespace fix.
		$url = $kernel->format_input( $url, T_DL_PARSE );
		
		if( @ini_get( "allow_url_fopen" ) == 1 )
		{
  		if( PHP_VERSION >= 5.1 AND @ini_get( "allow_url_include" ) == true )
  		{
  			return ( @file_get_contents( $url, false, null, 0, 50 ) ) ? true : false;
  		}
  		elseif( PHP_VERSION >= 5.0 AND @ini_get( "allow_url_include" ) == true )
  		{
  			return ( @file_get_contents( $url, false, stream_context_create( array( "http" => array( "header" => "Range: bytes=50-" ) ) ) ) ) ? true : false;
  		}
		}
		
		if( @function_exists( "curl_init" ) )
		{
			return ( @curl_init( $url ) ) ? true : false;
		}
		
  	return ( @file( $url ) ) ? true : false;
  	*/
	}
	
	/*
	 * Produce random chars based on available chars and length
	 **/
	
	function generate_random_code()
	{
    global $kernel;
    
    $key_array = $kernel->config['GD_CHAR_ARRAY'];
		$string = "";
    $key_length = strlen( $key_array ) -1;
    
    srand( ( double ) microtime() * 1000000 );
    
    for( $key = 0; $key < $kernel->config['GD_CHAR_LENGTH']; $key++ )
    {
    	$string .= $key_array{ mt_rand( 0, $key_length ) };
    }
    
    return $string;
	}
}

?>