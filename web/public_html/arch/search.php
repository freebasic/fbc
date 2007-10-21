<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

require_once( "global.php" );

$kernel->clean_array( "_REQUEST", array( "page" => V_PINT, "limit" => V_PINT, "sort" => V_STR, "order" => V_STR, "start" => V_PINT, "category_id" => V_INT, "string" => V_STR ) );

if( $kernel->vars['page'] == 0 ) $kernel->vars['page'] = 1;
if( $kernel->vars['limit'] == 0 ) $kernel->vars['limit'] = $kernel->config['display_default_limit'];
if( empty( $kernel->vars['sort'] ) ) $kernel->vars['sort'] = $kernel->config['display_default_sort'];
if( empty( $kernel->vars['order'] ) ) $kernel->vars['order'] = $kernel->config['display_default_order'];

if( $kernel->vars['category_id'] > 0 )
{
	$kernel->vars['page_struct']['system_page_navigation_id'] = $kernel->vars['category_id'];
}

$kernel->vars['page_struct']['system_page_navigation_html'] = array( "search.php?string={$kernel->vars['string']}" => sprintf( $kernel->ld['lang_f_searching'], $kernel->vars['string'] ) );
$kernel->vars['page_struct']['system_page_action_title'] = sprintf( $kernel->ld['lang_f_page_title_search'], $kernel->vars['string'] );

//if( $kernel->session_function->read_permission_flag( 3, true ) == true )
{
	$kernel->tp->call( "search" );

	if( !empty( $kernel->vars['string'] ) )
	{
		$file_ranking_syntax = "";
		
    // Prepare search query
		if( $kernel->config['archive_search_mode'] == 1 )
		{
			$search_syntax = "MATCH( f.file_name, f.file_description, f.file_version, f.file_author ) AGAINST ( '*{$kernel->vars['string']}*' IN BOOLEAN MODE )";
		}
		else
		{
			$search_syntax = "MATCH( f.file_name, f.file_description, f.file_version, f.file_author ) AGAINST ( '*{$kernel->vars['string']}*' )";
		}
		
		if( $kernel->vars['category_id'] > 0 )
		{
			$search_category = "AND f.file_cat_id = {$kernel->vars['category_id']}";
		}
		
		if( $kernel->vars['sort'] == "file_ranking" )
		{
			$file_ranking_syntax = ", ( f.file_rating / f.file_votes ) AS file_ranking";
		}
		
		//Basic search query
		$check_files = $kernel->db->query( "SELECT f.* {$file_ranking_syntax} FROM " . TABLE_PREFIX . "files f WHERE {$search_syntax} {$search_category} AND f.file_disabled = 0" );
		
		//No results
		if( $kernel->db->numrows() == 0 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_f_search_no_files'], M_NOTICE );
		}
		else
		{
			$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_files ) );
			
			$kernel->vars['html']['file_custom_fields_headers'] = "";
			$total_fields = 0;
			$last_file_status = 0;
			
			$kernel->tp->call( "search_results_header" );
			
			// Run paginated search query
			$get_files = $kernel->db->query( "SELECT f.* {$file_ranking_syntax} FROM " . TABLE_PREFIX . "files f WHERE {$search_syntax} {$search_category} AND f.file_disabled = 0 ORDER BY f.file_pinned DESC, {$kernel->vars['sort']} {$kernel->vars['order']}, f.file_name LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
			
			// Check for custom fields
			$get_fields = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "fields` WHERE `field_category_display` = 1 ORDER BY `field_name`" );
			
			if( $kernel->db->numrows( $get_fields ) > 0 )
			{
				while( $field = $kernel->db->data( $get_fields ) )
				{
  				$kernel->vars['html']['file_custom_fields_headers'] .= $kernel->tp->call( "file_field_subheader", CALL_TO_PAGE );
					$kernel->vars['html']['file_custom_fields_headers'] = $kernel->tp->cache( "field_name", $field['field_name'], $kernel->vars['html']['file_custom_fields_headers'] );
  				
  				$total_fields++;
				}
			}
			
			// Manually alter the end value if any COLUMNS are manually added to the template
			$fields['file_total_columns'] = $total_fields + 5;
			
			$kernel->tp->call( "file_header" );
			
			$kernel->tp->cache( $fields );
			
			// fetch and display category files
			while( $file = $kernel->db->data( $get_files ) )
			{
				if( $last_file_status == 1 AND $file['file_pinned'] == 0 )
				{
					$kernel->tp->call( "file_row_break" );
				}
				$last_file_status = $file['file_pinned'];
				
				$kernel->tp->call( "file_row" );
				
				$file['file_icon'] = $kernel->archive_function->construct_file_icon( $file['file_dl_url'], $file['file_icon'] );
				$file['file_rank'] = $kernel->archive_function->construct_file_rating( $file['file_rating'], $file['file_votes'] );
				$file['file_description'] = $kernel->archive_function->return_string_words( $kernel->format_input( $file['file_description'], T_NOHTML ), $kernel->config['string_max_length'] );
				$file['file_custom_fields'] = $kernel->archive_function->construct_file_custom_fields( $file['file_id'] );
				
				$file['file_timestamp'] = $kernel->fetch_time( $file['file_timestamp'], DF_SHORT );
				$file['file_mark_timestamp'] = $kernel->fetch_time( $file['file_mark_timestamp'], DF_SHORT );
				
				$file['file_size'] = $kernel->format_input( $file['file_size'], T_NUM );
				$file['file_author'] = $kernel->format_input( $file['file_author'], T_HTML );
				$file['file_downloads'] = $kernel->format_input( $file['file_downloads'], T_NUM );
				$file['file_views'] = $kernel->format_input( $file['file_views'], T_NUM );
				$file['file_votes'] = $kernel->format_input( $file['file_votes'], T_NUM );
				$file['file_name'] = $kernel->format_input( $file['file_name'], T_NOHTML );
				
				$file['file_prefix'] = ( $file['file_pinned'] == 1 ) ? $kernel->ld['lang_f_title_pinned'] : "";
				
				$kernel->tp->cache( $file );
			}
			
			$kernel->tp->call( "file_footer" );
			
			// Print pagination
			$kernel->vars['pagination_urls'] = array(
				"nextpage" => "search.php?string={$kernel->vars['string']}&amp;category_id={$kernel->vars['category_id']}&amp;sort={$kernel->vars['sort']}&amp;order={$kernel->vars['order']}&amp;limit={$kernel->vars['limit']}&amp;page={\$nextpage}",
				"previouspage" => "search.php?string={$kernel->vars['string']}&amp;category_id={$kernel->vars['category_id']}&amp;sort={$kernel->vars['sort']}&amp;order={$kernel->vars['order']}&amp;limit={$kernel->vars['limit']}&amp;page={\$previouspage}",
				"span" => "search.php?string={$kernel->vars['string']}&amp;category_id={$kernel->vars['category_id']}&amp;sort={$kernel->vars['sort']}&amp;order={$kernel->vars['order']}&amp;limit={$kernel->vars['limit']}&amp;page={\$page}",
				"start" => "search.php?string={$kernel->vars['string']}&amp;category_id={$kernel->vars['category_id']}&amp;sort={$kernel->vars['sort']}&amp;order={$kernel->vars['order']}&amp;limit={$kernel->vars['limit']}&amp;page=1",
				"end" => "search.php?string={$kernel->vars['string']}&amp;category_id={$kernel->vars['category_id']}&amp;sort={$kernel->vars['sort']}&amp;order={$kernel->vars['order']}&amp;limit={$kernel->vars['limit']}&amp;page={$kernel->vars['total_pages']}",
			);
			
			$kernel->page_function->construct_pagination_menu( R_FILE, false, SCRIPT_NAME );
		}
	}
	
	$kernel->page_function->construct_category_list( $kernel->vars['category_id'] );
}

$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );

?>