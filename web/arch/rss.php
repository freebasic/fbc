<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

require_once( "global.php" );

//if( $kernel->session_function->read_permission_flag( 7 ) == true )
{
  $kernel->clean_array( "_REQUEST", array( "limit" => V_PINT, "feed" => V_STR ) );
  
  if( $kernel->vars['limit'] == 0 OR $kernel->vars['limit'] > 100 ) $kernel->vars['limit'] = $kernel->config['display_default_limit'];
  if( empty( $kernel->vars['feed'] ) ) $kernel->vars['feed'] = "new";

	//new files
	if( $kernel->vars['feed'] == "new" )
	{
		$query = "SELECT `file_id`, `file_name`, `file_description`, `file_timestamp` FROM `" . TABLE_PREFIX . "files` ORDER BY `file_id` DESC LIMIT " . $kernel->vars['limit'] . "";
		
		$title = sprintf( $kernel->ld['lang_f_title_rss_new'], $kernel->vars['limit'] );
		$description = $kernel->ld['lang_f_rss_new'];
	}

	//top download files
	elseif( $kernel->vars['feed'] == "top" )
	{
		$query = "SELECT `file_id`, `file_name`, `file_description`, `file_downloads` FROM `" . TABLE_PREFIX . "files` ORDER BY `file_downloads` DESC LIMIT " . $kernel->vars['limit'] . "";
		
		$title = sprintf( $kernel->ld['lang_f_title_rss_top'], $kernel->vars['limit'] );
		$description = $kernel->ld['lang_f_rss_top'];
	}

	//top rating files
	elseif( $kernel->vars['feed'] == "rank" )
	{
		$query = "SELECT `file_id`, `file_name`, `file_description`, ( file_rating / file_votes ) AS `file_rank` FROM `" . TABLE_PREFIX . "files` ORDER BY `file_rank` DESC LIMIT " . $kernel->vars['limit'] . "";
		
		$title = sprintf( $kernel->ld['lang_f_title_rss_rank'], $kernel->vars['limit'] );
		$description = $kernel->ld['lang_f_rss_rank'];
	}
  
	//Build RSS feed
	header( "Content-Type: application/xml; charset=" . $kernel->ld['lang_charset'] . "" );
	
	echo "<" . "?xml version=\"1.0\" encoding=\"" . $kernel->ld['lang_charset'] . "\" ?" . ">";
	
	$kernel->tp->call( "rss_header" );
	
	$rssdata = array(
		"rss_title" => $kernel->format_input( $title, T_PREVIEW ),
		"rss_description" => $kernel->format_input( $description, T_PREVIEW ),
		"rss_link" => $kernel->config['system_root_url_path'] . "/index.php",
	);
	
	$kernel->tp->cache( $rssdata );
	
	$get_data = $kernel->db->query( $query );
	
	while( $rss = $kernel->db->data( $get_data ) )
	{
		$kernel->tp->call( "rss_item" );
		
		$rss['rss_item_title'] = $kernel->format_input( $rss['file_name'], T_PREVIEW );
		
		if( empty( $rss['file_description'] ) )
		{
			$rss['rss_item_description'] = "";
		}
		else
		{
			$rss['rss_item_description'] = $kernel->archive_function->return_string_words( htmlentities( $kernel->format_input( $rss['file_description'], T_PREVIEW ) ), 10 );
		}
		
		$rss['rss_item_link'] = $kernel->config['system_root_url_path'] . "/file.php?id=" . $rss['file_id'] . "";
		
		$kernel->tp->cache( $rss );
	}
	
	$kernel->tp->call( "rss_footer" );
}
/*else
{
	//No perms or files, empty RSS feed.
	header( "Content-Type: application/xml; charset=" . $kernel->ld['lang_charset'] . "" );
	
	echo "<" . "?xml version=\"1.0\" encoding=\"" . $kernel->ld['lang_charset'] . "\" ?" . ">";
	
	$kernel->tp->call( "rss_empty_feed" );
}*/

$kernel->page_function->construct_output( false, false, false, false );

?>