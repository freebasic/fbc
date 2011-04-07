<?php

class TPL
{
	var $_keyTb = array( );
	var $_langTb = array( );
	var $_tplFile = NULL;
	var $_tplCache;
	var $_chgCnt;
	
	//
	function TPL( $filename )
	{
		$fd = fopen( $filename, 'rb' );
		if( $fd == NULL )
			return;
			
		$this->_tplFile = fread( $fd, filesize( $filename ) );
		
		fclose( $fd );
		
		$this->_chgCnt = 0;
		$this->_langTb = array( );
	}
	
	// 
	function &_replace( &$tpl, &$keyTb, $prefix = '{$', $suffix = '}' ) 
	{
		$searchTb = array( );
		$replaceTb = array( );
		
		foreach( $keyTb as $key => $value )
		{
			$searchTb[] =  $prefix . $key . $suffix;
			$replaceTb[] = $value;
		}
			
		return str_replace( $searchTb, $replaceTb, $tpl );	
		
	}
	
	//
	function assign( $key, $value )
	{
		$this->_keyTb[$key] = $value;
		++$this->_chgCnt;
	}

	//
	function assignRef( $key, &$value )
	{
		$this->_keyTb[$key] =& $value;
		++$this->_chgCnt;
	}

	//
	function loadLangFile( $filename )
	{
		$this->_langTb =& array_merge( $this->_langTb, parse_ini_file( $filename ) );
		if( count( $this->_langTb ) > 0 )
			$this->_tplFile = $this->applyLangTb( $this->_tplFile );
	}

	//
	function &applyLangTb( &$text )
	{
		if( count( $this->_langTb ) > 0 )
			return $this->_replace( $text, $this->_langTb, '{#', '}' );
		else
			return $text;
	}

	//
	function clear( )
	{
		$this->_keyTb = array( );
	}
	
	//
	function &fetch( )
	{
		if( $this->_tplFile == NULL )
			return '';
		
		if( count( $this->_keyTb ) == 0 )
			return $this->_tplFile;

		if( $this->_chgCnt == 0 )
			return $this->_tplFile;
		
		$this->_chgCnt = 0;
		
		$this->_tplCache =& $this->_replace( $this->_tplFile, $this->_keyTb, '{$', '}' );
		
		if( count( $this->_langTb ) > 0 )
			$this->_tplCache = $this->applyLangTb( $this->_tplCache );
		
		return $this->_tplCache;
	}
	
}

?>