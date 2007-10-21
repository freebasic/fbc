<?php

################################################################################
#	PHCDownload - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDL is free to use. Please visit the website for futher licence
# information and details on re-distribution and use.
################################################################################

if( FUNC_INI_GET == true )
{
  @ini_set( "session.name", "session" );
  @ini_set( "session.gc_maxlifetime", ( 3600 * 2 ) );
  @ini_set( "session.gc_probability", 1 );
  @ini_set( "session.gc_divisor", 1 );
}

class class_session_function
{
	/*
	 * Build login form
	 **/
	
	function construct_user_login( $html_message, $is_notice = FALSE )
	{
		global $kernel, $_COOKIE, $_SESSION;
		
		$this->clear_user_cache();
				
		define( "LOGIN_FORM", true );
		
  	$kernel->tp->call( "user_login" );
		
		if( $is_notice )
		{
    	$kernel->tp->cache( 'message_title', $kernel->ld['lang_f_title_notice'] );
  		$kernel->tp->cache( 'message_class', 'notice' );
  	}
  	else
  	{
    	$kernel->tp->cache( 'message_title', $kernel->ld['lang_f_title_error'] );
  		$kernel->tp->cache( 'message_class', 'error' );
  	}
  	
  	$kernel->tp->cache( "login_error_message", $html_message );
  	
  	$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );
  	
  	exit;
	}
	
	/*
	 * Build login form
	 **/
	
	function construct_category_login( $category_id, $http_referer )
	{
		global $kernel;
		
		$kernel->tp->call( "category_login" );
		
		$kernel->vars['referer'] = $kernel->format_input( $http_referer, T_URL_ENC );
		$kernel->vars['id'] = $category_id;
		
		$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );
		
		exit;
	}
	
	/*
	 * return state of a permissions flag
	 **/
	
	function read_permission_flag( $permission_flag = -1, $halt_exec = false )
	{
  	global $kernel;
		
  	$permissions = explode( ",", $kernel->session['session_permissions'] );
		
  	if( $kernel->session['session_group_id'] == 1 AND isset( $permissions[ "$permission_flag" ] ) )
  	{
  		return true;
  	}
  	else
  	{
  		if( intval( $permissions[ "$permission_flag" ] ) == 1 )
  		{
				return true;
			}
			else
			{
  			if( $halt_exec == true )
  			{
  				$kernel->page_function->message_report( $kernel->ld['lang_f_no_permission'], M_ERROR, HALT_EXEC );
  			}
  		}
  	}
	}
	
	/*
	 * Construct anti-spam secuirty image and throw into cache
	 **/
	
	function construct_session_security_form()
	{
		global $kernel;
		
		$kernel->vars['html']['table_security_code_row'] = "";
		
		if( function_exists( "imagecreate" )
		AND ( ( $kernel->config['GD_POST_MODE_GUEST'] == "true" AND empty( $kernel->session['session_user_id'] ) )
		OR ( $kernel->config['GD_POST_MODE_USER'] == "true" AND !empty( $kernel->session['session_user_id'] ) )
		OR ( $config['GD_REGISTER_MODE'] == "true" ) ) )
		{
  		$user_id = empty( $kernel->session['session_user_id'] ) ? 0 : $kernel->session['session_user_id'];
      $rand_hash = md5( uniqid( mt_rand() ) );
      
  		$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "users_verify` WHERE `verify_ip_address` = '" . IP_ADDRESS . "' OR `verify_timestamp`  < ( " . UNIX_TIME . " - 1800 )" );
      
      $imagedata = array(
        "verify_hash"		=> $rand_hash,
        "verify_key"		=> $kernel->generate_random_code(),
        "verify_timestamp"	=> UNIX_TIME,
        "verify_ip_address"	=> IP_ADDRESS,
        "verify_user_id"	=> $user_id
      );
      
      $kernel->db->insert( "users_verify", $imagedata );
      
      $kernel->vars['html']['table_security_code_row'] = $kernel->tp->call( "form_security_code", CALL_TO_PAGE );
      $kernel->vars['html']['table_security_code_row'] = $kernel->tp->cache( "user_verify_hash", $rand_hash, $kernel->vars['html']['table_security_code_row'] );
		}
	}
	
	/*
	 * Destroy a user session (logout)
	 **/
	
	function clear_user_cache()
	{
		global $kernel;
		
    $kernel->db->query( "DELETE FROM " . TABLE_PREFIX . "sessions WHERE `session_user_id` = '{$kernel->session['session_user_id']}'" );
    
    $_SESSION = array();
		
		header( 'Set-Cookie: phcdl_session_hash=; Max-Age=1000;' );
		header( 'Set-Cookie: phcdl_user_id=; Max-Age=1000;' );
		header( 'Set-Cookie: phcdl_user_password=; Max-Age=1000;' );
	}
}

?>