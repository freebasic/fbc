<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

error_reporting( E_ALL &~ E_NOTICE );

define( "ROOT_PATH", dirname( __FILE__ ) . "/" );

// Start Kernel
require( ROOT_PATH . "include/class_kernel.php" );
$kernel = new class_kernel;

require( ROOT_PATH . "include/config.ini.php" );
$kernel->config =& $config;

require( ROOT_PATH . "include/filetype.ini.php" );
$kernel->filetype =& $filetypes;

// Setup constants etc
$kernel->init_system_environment();

// Start database
$kernel->init_database_driver();

// Start template engine
$kernel->init_template_driver();

// Load language phrases
$kernel->fetch_language_phrases();

// Start
if( $kernel->config['gzip_enabled'] == 1 AND SCRIPT_NAME !== "download.php" AND SCRIPT_NAME !== "mirror.php" )
{
	ob_start( "ob_gzhandler" );
}

if( get_magic_quotes_gpc() == 1 )
{
	$_REQUEST = $kernel->stripslashes_array( $_REQUEST );
}
set_magic_quotes_runtime( 0 );

//At some point i'll sort out calling class functions on the pages they are needed..
require_once( ROOT_PATH . "include/function_class_page.php" );
$kernel->page_function = new class_page_function;

require_once( ROOT_PATH . "include/function_class_session.php" );
$kernel->session_function = new class_session_function;

require_once( ROOT_PATH . "include/function_class_archive.php" );
$kernel->archive_function = new class_archive_function;

require_once( ROOT_PATH . "include/function_class_image.php" );
$kernel->image_function = new class_image_function;

$microtime = explode( " ", microtime() );
define( "PAGE_EXEC_START", $microtime[1] + $microtime[0] );

if( defined( "IN_ACP" ) )
{
	require_once( ROOT_PATH . "include/function_class_admin.php" );
	$kernel->admin_function = new class_admin_function;
}
else
{
	session_start();
	$kernel->init_session_driver();
	
	if( $kernel->config['archive_offline'] == 1 )
	{
		if( $kernel->session['session_group_id'] <> 1 AND SCRIPT_NAME !== "user.php" AND SCRIPT_NAME !== "contact.php" )
		{
			$kernel->page_function->message_report( $kernel->config['archive_offline_message'], M_MAINTENANCE );
		}
	}
}

//Archive count semi-croned syncing
if( $kernel->db->numrows( "SELECT `datastore_timestamp` FROM `" . TABLE_PREFIX . "datastore` WHERE `datastore_key` = 'last_file_archive_sync' AND `datastore_timestamp` < ( " . UNIX_TIME . " - 3600 ) LIMIT 1" ) == 1 )
{
	$kernel->archive_function->update_database_counter( "views" );
	$kernel->archive_function->update_database_counter( "downloads" );
	
	$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "datastore` SET `datastore_timestamp` = " . UNIX_TIME . " WHERE `datastore_key` = 'last_file_archive_sync'" );
}

?>