<?php

class DB
{
	var $db, $host, $usr, $pwd;
	var $id;
	
	/*:::::*/
	function DB( $db, $host, $usr, $pwd )
	{
		$this->db   = $db;
		$this->host = $host;
		$this->usr  = $usr;
		$this->pwd  = $pwd;
		$this->id	= NULL;
	}
	
	/*:::::*/
	function connect( )
	{
		$this->id = mysql_connect( $this->host, $this->usr, $this->pwd );
		if( $this->id == NULL )
			return FALSE;
			
		if( mysql_select_db( $this->db, $this->id ) === FALSE )
			return FALSE;
		
		return TRUE;
	}
	
	/*:::::*/
	function _getId( )
	{
		if( $this->id == NULL ) 
			$this->connect( );
			
		return $this->id;
	}
	
	/*:::::*/
	function _execute( $query ) 
	{
		$res = mysql_query( $query, $this->_getId( ) );
		if( $res === FALSE )
			return NULL;

		return $res;
	}

	/*:::::*/
	function &getRecords( $query ) 
	{
		$array = array( );
		
		$id = $this->_execute( $query );
		if( $id == NULL )
			return $array;

		while( is_array( $row =& mysql_fetch_assoc( $id ) ) ) 
			$array[] = $row;

		mysql_free_result( $id );
		
		return $array;
	}

	/*:::::*/
	function &getRecord( $query ) 
	{
		$id = $this->_execute( $query );
		if( $id == NULL )
			return NULL;

		$row =& mysql_fetch_assoc( $id );

		mysql_free_result( $id );
		
		return $row;
	}
	
}

?>