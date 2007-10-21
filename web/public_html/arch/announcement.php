<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

require_once( "global.php" );

$kernel->clean_array( "_REQUEST", array( "id" => V_PINT ) );

// No ID ref
if( $kernel->vars['id'] == 0 )
{
	$kernel->page_function->message_report( $kernel->ld['lang_f_no_anno_specified'], M_ERROR );
}
else
{
	$get_announcements = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "announcements` WHERE `announcement_id` = " . $kernel->vars['id'] );
  
	// Invalid ID ref
	if( $kernel->db->numrows( $get_announcements ) == 0 )
	{
		$kernel->page_function->message_report( $kernel->ld['lang_f_anno_no_exists'], M_ERROR );
	}
	else
	{
		$announcement = $kernel->db->data( $get_announcements );
		
		// Setup page vars
		$kernel->vars['page_struct']['system_page_action_title'] = sprintf( $kernel->ld['lang_f_page_title_announcement'], $announcement['announcement_title'] );
		$kernel->vars['page_struct']['system_page_navigation_html'] = array( SCRIPT_PATH => sprintf( $kernel->ld['lang_f_page_title_announcement'], $announcement['announcement_title'] ) );
		if( $announcement['announcement_cat_id'] > 0 ) $kernel->vars['page_struct']['system_page_navigation_id'] = $announcement['announcement_cat_id'];
		
		// Build announcement data and template
		$kernel->tp->call( "announcement_box_list" );

		$announcement['announcement_title'] = $kernel->format_input( $announcement['announcement_title'], T_HTML );
		$announcement['announcement_data'] = $kernel->format_input( $announcement['announcement_data'], T_HTML );
		$announcement['announcement_timestamp'] = $kernel->fetch_time( $announcement['announcement_timestamp'], DF_SHORT );
		$announcement['announcement_author'] = $kernel->format_input( $announcement['announcement_author'], T_HTML );
		$announcement['announcement_post_data'] = sprintf( $kernel->ld['lang_f_posted_by'], $announcement['announcement_author'], $announcement['announcement_timestamp'] );

		$kernel->tp->cache( $announcement );
	}
}

$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );

?>