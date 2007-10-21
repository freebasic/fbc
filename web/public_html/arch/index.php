<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

require_once( "global.php" );

$get_categories = $kernel->db->query( "SELECT c.category_id, c.category_name, c.category_description, c.category_file_total, c.category_file_subtotal, c.category_newfile_id, f.file_id, f.file_name, f.file_downloads, f.file_timestamp, f.file_mark_timestamp FROM " . TABLE_PREFIX . "categories c LEFT JOIN " . TABLE_PREFIX . "files f ON ( f.file_id = c.category_newfile_id ) WHERE c.category_sub_id = 0 ORDER BY c.category_order, category_name" );

// No categories in archive
if( $kernel->db->numrows() == 0 )
{
  $kernel->page_function->message_report( $kernel->ld['lang_f_no_categories'], M_NOTICE );
}
else
{
	// Setup page vars
	$kernel->vars['page_struct']['system_page_action_title'] = $kernel->ld['lang_f_page_title_index'];
	
	$kernel->tp->call( "category_header" );
	
	// Get categories
	while( $category = $kernel->db->data( $get_categories ) )
	{
		$kernel->tp->call( "category_row" );
		
		$category['category_files'] = $kernel->page_function->format_category_file_count( $category['category_file_total'], $category['category_file_subtotal'] );
		$category['category_name'] = $kernel->format_input( $category['category_name'], T_HTML );
		
		if( !empty( $category['category_description'] ) )
		{
			$category['category_description'] = $kernel->format_input( $category['category_description'], T_HTML ) . "<br />";
		}
		
		$category['category_sub_cats'] = $kernel->page_function->construct_sub_category_list( $category['category_id'] );
		
    // Show latest file added in category branch
		if( $category['category_newfile_id'] != 0 )
		{
			$category['category_newfile'] = $kernel->tp->call( "category_newfile", CALL_TO_PAGE );
			
			$category['file_timestamp'] = $kernel->fetch_time( $category['file_timestamp'], DF_SHORT );
			$category['file_mark_timestamp'] = $kernel->fetch_time( $category['file_mark_timestamp'], DF_SHORT );
			$category['file_name'] = $kernel->archive_function->return_string_chars( $kernel->format_input( $category['file_name'], T_HTML ), $kernel->config['string_max_length_file_name'] );
			$category['file_downloads'] = $kernel->format_input( $category['file_downloads'], T_NUM );
			
			$category['category_newfile'] = $kernel->tp->cache( $category, 0, $category['category_newfile'] );
		}
		else
		{
			$category['category_newfile'] = $kernel->tp->call( "category_no_newfile", CALL_TO_PAGE );
		}
		
		$kernel->tp->cache( $category );
	}
	
	$kernel->tp->call( "category_footer" );
	
	$kernel->page_function->construct_pagination_menu( false, R_CATEGORY, "category.php" );
	
	$kernel->page_function->construct_category_list( 0 );
}

$kernel->page_function->construct_output( R_HEADER, R_FOOTER, R_ANNOUNCEMENTS, R_NAVIGATION );

?>