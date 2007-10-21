<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( -1 );

switch( $kernel->vars['action'] )
{

	#############################################################################
	
	case "write" :
	{
		$kernel->admin_function->write_filetype_ini( null );
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$kernel->page_function->message_report( $kernel->ld['lang_b_filetypes_mime_tip'], M_NOTICE );
		
		$kernel->tp->call( "admin_filetype_header" );
		
		//get listed filetypes
		foreach( $kernel->filetype AS $key => $value )
		{
			$kernel->tp->call( "admin_filetype_row" );
			
			$kernel->tp->cache( array( "filetype_name" => $key, "filetype_image" => $value[0], "filetype_mime" => $value[1] ) );
		}
		
		//====================================
		// get file images
		//====================================
		
		$d = dir( "../images/filetype" );
		
		$image_list = "";
		
		while( false !== ( $image = $d->read() ) )
		{
			if( $image == "." OR $image == ".." ) continue;
			if( $image == "index.html" ) continue;
			
			$image_list .= "<div style=\"display: inline;text-align: left; margin: 10px 10px 0px 10px;\"><img style=\"margin: 10px 0px 10px 10px; vertical-align: middle;\" src=\"../images/icons/{$image}\" border=\"0\">&nbsp;{$image}</div>\r\n";
		}
		
		$kernel->tp->call( "admin_filetype_footer" );
		
		$kernel->tp->cache( "image_list_options", $image_list );
		
		break;
	}
}

?>

