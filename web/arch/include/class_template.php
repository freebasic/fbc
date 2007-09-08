<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

define( "CALL_DB",				0 );
define( "CALL_TO_PAGE",		1 );
define( "CALL_RESERVE",		2 );
define( "CALL_STRING",		3 );

class class_template
{
	var $template_cache;
	
	var $info = array();
	var $template_store = array();
	var $vars = array();
	
	/*
	 * Call a database or string item to the $template_cache
	 **/
	
	function call( $template_name, $mode = CALL_DB, $top_level = 0, $flush = false )
	{
		global $kernel;
		
		switch( $mode )
		{
			/**
			 * Call from database based on $template
			 */
			
			case CALL_DB:
			{
  			if( !isset( $this->template_store[ $template_name ] ) )
  			{
    			if( substr( $template_name, 0, 6 ) == "admin_" )
    			{
    				$template_data = $kernel->db->item( "SELECT `template_data` FROM `" . TABLE_PREFIX . "templates_admin` WHERE `template_name` = '{$template_name}' LIMIT 1" );
    			}
    			else
    			{
    				$template_data = $kernel->db->item( "SELECT `template_data` FROM `" . TABLE_PREFIX . "templates` WHERE `template_name` = '{$template_name}' AND `template_theme` = {$kernel->config['default_skin']} LIMIT 1" );
    			}
  				
      		if( isset( $template_data ) == false )
      		{
      			$kernel->page_function->message_report( "Could not load template: " . $template_name, M_CRITICAL_ERROR );
      		}
					
					$this->template_store[ $template_name ] = $template_data;
      		
  				if( $top_level == 1 )
  				{
  					$this->template_cache = $this->template_store[ $template_name ] . "\r\n" . $this->template_cache;
  				}
  				else
  				{
  					$this->template_cache .= "\r\n" . $this->template_store[ $template_name ];
  				}
  				
      		$this->info['total_loaded']++;
  			}
  			else
  			{
    			$this->template_cache .= "\r\n" . $this->template_store[ $template_name ];
  			}
				
				break;
  		}
			
  		/**
			 * Call from database based on $template and return
			 */
			
  		case CALL_TO_PAGE:
  		{
  			if( !isset( $this->template_store[ $template_name ] ) )
  			{
      		if( substr( $template_name, 0, 6 ) == "admin_" )
    			{
    				$template_data = $kernel->db->item( "SELECT `template_data` FROM `" . TABLE_PREFIX . "templates_admin` WHERE `template_name` = '{$template_name}' LIMIT 1" );
    			}
    			else
    			{
    				$template_data = $kernel->db->item( "SELECT `template_data` FROM `" . TABLE_PREFIX . "templates` WHERE `template_name` = '{$template_name}' AND `template_theme` = {$kernel->config['default_skin']} LIMIT 1" );
    			}
  				
      		if( isset( $template_data ) == false )
      		{
      			$kernel->page_function->message_report( "Could not load template: " . $template_name, M_CRITICAL_ERROR );
      		}
					
					$this->template_store[ $template_name ] = $template_data;
					
    			$this->info['total_loaded']++;
  			}
				
				return $this->template_store[ $template_name ];
				
				break;
  		}
			
  		/**
			 * Send string to template cache
			 */
			
  		case CALL_STRING:
  		{
				if( $top_level == 1 )
  			{
  				$this->template_cache = $template_name . "\r\n" . $this->template_cache;
  			}
  			else
  			{
  				$this->template_cache .= "\r\n" . $template_name;
  			}
  			
    		$this->info['total_loaded']++;
				
				break;
  		}
		}
	}
	
	/*
	 * Cache variables to the $template_cache
	 **/
	
	function cache( $variable, $string="", $source="" )
	{
		global $kernel;
		
		if( empty( $source ) )
		{
  		if( is_array( $variable ) )
  		{
  			foreach( $variable AS $key => $value )
  			{
  				$this->template_cache = str_replace( "{\$" . $key . "}", $value, $this->template_cache );
					
  				$this->info['total_variables']++;
  			}
				
  			$this->info['total_arrays']++;
			}
  		else
  		{
  			$this->template_cache = str_replace( "{\$" . $variable . "}", $string, $this->template_cache );
				
  			$this->info['total_variables']++;
  		}
		}
		else
		{
      if( is_array( $variable ) )
      {
      	$string_data = $source;
      	
      	foreach( $variable AS $key => $value )
      	{
      		$string_data = str_replace( "{\$" . $key . "}", $value, $string_data );
      		
      		$this->info['total_variables']++;
      	}
      	
      	$this->info['total_arrays']++;
      	
      	return $string_data;
      }
      else
      {
      	return str_replace( "{\$" . $variable . "}", $string, $source );
      	
      	$this->info['total_variables']++;
      }
		}
	}
	
	//===========================================================================
	
	function dump()
	{
		eval( "?>{$this->template_cache}" );
		
		unset( $this->template_cache );
		unset( $this->template_store );
	}
}

?>