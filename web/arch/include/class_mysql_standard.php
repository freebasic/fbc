<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

class class_database
{
	var $query = ""; //Raw query string of most recent query
	var $resource = ""; //Executed query resource of most recent query
	
	var $config = array(); //Connection details
	var $info = array(); //Debugging data
	
	var $server_link = false;
  var $server_persistent = false;
  
	var $array = array();
  
  /*
	 * Establish a connection to a MySQL server
	 **/

  function connect()
	{
		if( !@function_exists( "mysql_connect" ) )
		{
			if( !@dl( "mysql" ) )
			{
				die( "Cannot load <b>MySQL</b> PHP extension." );
			}
		}
		
		if( $this->server_link == false )
		{
      if( $this->server_persistent == true )
      {
        $this->server_link = @mysql_pconnect( $this->config['server'] . ":" . $this->config['port'], $this->config['username'], $this->config['password'] );
      }
      else
      {
        $this->server_link = @mysql_connect( $this->config['server'] . ":" . $this->config['port'], $this->config['username'], $this->config['password'] );
      }
			
      if( !$this->server_link )
			{
			  $this->error_db_report( "Could not make a connection to the server" );
			}
			
			if( !@mysql_select_db( $this->config['database'], $this->server_link ) )
			{
			  $this->error_db_report( "Could not select the database" );
			}
		}
		
		return true;
	}
  
  /*
	 * Execute a basic manual SQL query
	 **/
	
	function query( $query = "" )
	{
		global $kernel;
    
		if( $this->server_link == false )
			return false;
    		
    if( !empty( $query ) )
    {
			if( !is_resource( $query ) )
      {
				$this->query = $query;
				
				if( $kernel->config['debug_mode'] >= 2 )
        {
					$mt = explode( " ", microtime() );
					$query_start = $mt[1] + $mt[0];
				}
				
				$this->resource = mysql_query( $query, $this->server_link );
				
				if( $kernel->config['debug_mode'] >= 2 )
        {
 					$mt = explode( " ", microtime() );
 					$query_time = round( $mt[1] + $mt[0] - $query_start, 4 );
        }
				
				if( $this->resource == false )
 		    {
 		      $this->error_db_report( "Invalid SQL Query" );
 		    }
         
        $this->info['total_executed']++;
				
        if( $kernel->config['debug_mode'] == 3 AND substr( trim( strtoupper( $this->query ) ), 0, 6 ) == "SELECT" )
 		    {
					$explain = @mysql_query( "EXPLAIN " . $this->query, $this->server_link );
					
 		      $this->info['query_string'][] = array( $this->query, $query_time, @mysql_fetch_assoc( $explain ) );
 		    }
				
				if( $kernel->config['debug_mode'] == 2 )
        {
					$this->info['query_string'][] = array( $this->query, $query_time );
				}
				
				return $this->resource;
      }
      else
      {
         if( $query == false )
         {
	        $this->error_db_report( "Invalid SQL Query" );
         }
         
				$this->resource = $query;
				
				return $this->resource;
      }
		}
    elseif( !empty( $this->resource ) )
    {
			if( $this->resource == false )
	    {
	     $this->error_db_report( "Invalid SQL Query" );
	    }
			
			return $this->resource;
		}
		else
    {
      $this->error_db_report( "No Query" );
      return false;
    }
	}
  
  /*
	 * Execute a basic manual SQL query and return the first row
	 **/
	
	function row( $query = "", $mode = MYSQL_ASSOC )
	{
  	global $kernel;
    
    $this->query( $query );
		
		if( !$this->resource )
			return NULL;
			
		$this->array = mysql_fetch_assoc( $this->resource );
		
		return $this->array;
	}
	
	/*
	 * Execute a basic manual SQL query and return the first row item
	 **/
	
	function item( $query = "", $mode = MYSQL_NUM )
	{
  	global $kernel;
    
    $this->query( $query );
		
  	$this->array = @mysql_fetch_array( $this->resource, MYSQL_NUM );
		
		return $this->array[0];
	}
  
  /*
	 * Construct and execute an INSERT query
	 **/
	
	function insert( $table = "", $query )
	{
		global $kernel;
		
    if( $this->server_link != false )
    {
			if( !is_array( $query ) )
			{
				$this->error_db_report( "No Query" );
			}
			
			if( empty( $table ) )
			{
				$this->error_db_report( "No Table Set" );
			}
			
			$keys = "";
			$values = "";
			
			foreach( $query AS $key => $value )
			{
				$keys .= "`{$key}`,";
				$values .= "'" . addslashes( $value ) . "',";
			}
			
			$values = preg_replace( "/,$/", "", $values );
			$keys = preg_replace( "/,$/", "", $keys );
			
			$this->query( "INSERT INTO `" . TABLE_PREFIX . "{$table}` ({$keys}) VALUES({$values})" );
    }
	}
  
  /*
	 * Construct and execute an UPDATE query
	 **/
	
	function update( $table = "", $query, $code = "" )
	{
		global $kernel;
		
    if( $this->server_link != false )
    {
      if( !is_array( $query ) )
      {
        $this->error_db_report( "No Query" );
      }
      
      if( empty( $table ) )
      {
        $this->error_db_report( "No Table Set" );
      }
      
      $values = "";
      
      foreach( $query AS $key => $value )
      {
        //$value = preg_replace( "/'/", "\\'", $value );
        $values .= "`{$key}` = '" . addslashes( $value ) . "',";
      }
      
      $values = preg_replace( "/,$/", "", $values );
      
      $this->query( "UPDATE `" . TABLE_PREFIX . "{$table}` SET {$values} {$code}" );
    }
	}
  
  /*
	 * Return rows from a query
	 **/
	
	function data( $query = "", $mode = MYSQL_ASSOC )
	{
  	global $kernel;
    
  	$this->query( $query );
		
		if( !$this->resource )
			return NULL;

  	$this->array = @mysql_fetch_array( $this->resource, $mode );
		
		return $this->array;
	}
  
  /*
	 * Return number of rows affected by INSERT, UPDATE, REPLACE or DELETE queries.
	 **/
	
  function affectrows( $query = "" )
	{
  	global $kernel;
    
		$this->query( $query );
		
  	$this->array = @mysql_affected_rows( $this->server_link );
		
		return $this->array;
	}
	
  /*
	 * Return number of rows from a query result
	 **/
	
  function numrows( $query = "" )
	{
  	global $kernel;
    
		$this->query( $query );
		
		$this->array = @mysql_numrows( $this->resource );
		
		return $this->array;
	}
	
  /*
	 * Return number of fields from a query result row.
	 **/
	
  function numfields( $query = "" )
	{
  	global $kernel;
    
  	$this->query( $query );
		
		$this->array = @mysql_num_fields( $this->resource );
		
		return $this->array;
	}
	
  /*
	 * Return a specific field from a query result row.
	 **/
	
  function data_field( $query = "" )
	{
  	global $kernel;
    
  	$this->query( $query );
		
		$this->array = @mysql_fetch_field( $this->resource );
		
		return $this->array;
	}
	
	/*
	 * Return the last INSERT query ID
	 **/
	
  function insert_id( $query = "" )
	{
  	global $kernel;
    
  	$this->query( $query );
		
		$this->array = @mysql_insert_id( $this->server_link );
		
		return $this->array;
	}
	
	/*
	 * Return a specific field from a query result row.
	 **/
	
	function escape_string( $string )
	{
		return mysql_real_escape_string( $string );
	}
	
	/*
	 * Construct and execute a database error and halt_exec on the script.
	 **/
	
	function error_db_report( $message, $script_name = "", $script_line = "" )
  {
		global $kernel;
		
		@ob_end_clean();
		
    if( $kernel->config['gzip_enabled'] == 1 )
    {
    	ob_start( "ob_gzhandler" );
    }
		
		echo "<span style=\"font-size: 28px; font-family: Arial;\">PHCDownload Database Error</span><br />";
		echo "<span style=\"font-size: 21px; font-family: Arial;\">{$message}</span>";
		echo "<p><div style=\"padding: 10px; border: 1px solid #000000;\"><span style=\"font-size: 14px;font-family: 'Courier New', Courier;\">" . mysql_error() . " (MySQL error no; " . mysql_errno() . ")</span></div></p>";
		
		if( !empty( $this->query ) )
		{
			echo "<p><div style=\"padding: 10px; border: 1px solid #000000;\"><span style=\"font-size: 14px;font-family: 'Courier New', Courier;\">SQL query; " . htmlentities( $this->query ) . "</span></div></p>";
		}
		
		echo "<span style=\"font-size: 14px; font-family: Arial;\">Please contact the <a href=\"mailto:{$kernel->config['mail_inbound']}\">administrator</a> if this is a recurring message.</span>";
		
		@$kernel->page_function->exec_debug_console( null );
		
		exit;
  }
}

?>