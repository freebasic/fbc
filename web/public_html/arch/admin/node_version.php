<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->tp->call( "admin_version_check" );

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "version" :
	{
		if( !$fp = @fopen( "http://www.phpcredo.com/data/phcdl_vstring.php", "rb" ) )
		{
			$version_data = "<i>{$kernel->ld['lang_b_unknown']}</i>";
		}
		else
		{
			if( function_exists( "socket_set_timeout" ) )
			{
				socket_set_timeout( $fp, $kernel->config['system_parse_timeout'] );
			}
			
			$fp_data = @explode( ",", fread( $fp, 2048 ) );
			
			$version_date = $kernel->fetch_time( $fp_data[2], DF_SHORT );
			
			$version_data = "<a target=\"_blank\" href=\"{$fp_data[3]}\" title=\"Build: {$fp_data[1]}\">{$fp_data[0]}</a> ({$version_date})";
		}
		
		$kernel->tp->cache( "version_data", $version_data );
	}
	
	#############################################################################
	
	default :
	{
		if( !$fp = @fopen( "http://www.phpcredo.com/data/phcdl_vstring.php", "rb" ) )
		{
			$version_data = $kernel->config['short_version'];
		}
		else
		{
			if( function_exists( "socket_set_timeout" ) )
			{
				socket_set_timeout( $fp, $kernel->config['system_parse_timeout'] );
			}
			
			$fp_data = @explode( ",", fread( $fp, 2048 ) );
			
			if( FULL_VERSION >= $fp_data[1] )
			{
				$version_data = "<font color=\"#33cc33\">{$kernel->config['short_version']}</font> ({$kernel->ld['lang_b_status_up_to_date']})";
			}
			else
			{
				$version_data = "<font color=\"red\" title=\"Build: " . FULL_VERSION . "\">{$kernel->config['short_version']}</font> ({$kernel->ld['lang_b_status_out_dated']})";
			}
		}
		
		$kernel->tp->cache( "version_data", $version_data );
	}
}

?>

