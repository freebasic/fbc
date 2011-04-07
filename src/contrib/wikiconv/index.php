<?php

	set_time_limit( 0 );

	require_once 'common.cfg.php';
	require_once 'DB.class.php';
	require_once 'FBDoc.class.php';

	print( '<font face="arial" size="3">' );
	
	$db = new DB( CFG_DB_NAME, CFG_DB_HOST, CFG_DB_USER, CFG_DB_PWD );
	if( $db == NULL )
		die( );
		
	$doc = new FBDoc( $db, CFG_PATH_HTML, 'html' );
	
	print( "<br><b>Loading Pages...</b><br>" );
	$doc->loadPages( );
	
	print( "<br><b>Finding Sections...</b><br>" );
	$doc->findSections( );
	
	print( "<br><b>Emitting Sub Sections...</b><br>" );
	$doc->emitSubSections( );
	
	print( "<br><b>Emitting Cross-ref Pages...</b><br>" );
	$doc->emitCrossRefPages( );
	
	print( "<br><b>Emitting CHM...</b><br>" );
	$doc->emitChm( 'manual', 'DocToc' );
	
?>