<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

/*
error_reporting( E_ALL | E_STRICT );

// error handler function
function myErrorHandler($errno, $errstr, $errfile, $errline)
{
    //if( $errno == E_STRICT )
    	print( "$errstr, at $errfile($errline)<br/>\n" );

}

set_error_handler("myErrorHandler");
*/

//
function gzipit( )
{
	$useragent = (isset($_SERVER['HTTP_USER_AGENT'])) ?
				 $_SERVER['HTTP_USER_AGENT'] : @getenv('HTTP_USER_AGENT');

	$encoding = (isset($_SERVER['HTTP_ACCEPT_ENCODING'])) ?
				$_SERVER['HTTP_ACCEPT_ENCODING'] : @getenv('HTTP_ACCEPT_ENCODING');

	if( @extension_loaded( 'zlib' ) && strstr( $encoding, 'gzip' ) )
		if( strstr( $useragent, 'compatible' ) || strstr( $useragent, 'Gecko' ) )
			@ob_start( 'ob_gzhandler' );
}

    //
    session_start( );

	//
	gzipit( );

	//
    $pagesTb = array(
    	'news',
    	'about',
    	'aboutcred|about|CredPageCtrl',
    	'download',
    	'gallery',
    	'support',
    	'link',
    	'details',
    	'viewall',
    	'faq',
    	'chat',
    	'changelang',
    	'codelib',
    	'error'
    );

	require_once( 'FBSite.inc.php' );

	FBSite::startController( $pagesTb )

?>
