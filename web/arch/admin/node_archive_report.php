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

$kernel->clean_array( "_REQUEST", array( "page" => V_PINT, "limit" => V_PINT, "sort" => V_STR, "order" => V_STR, "start" => V_PINT ) );

$kernel->vars['page'] = ( $kernel->vars['page'] < 1 ) ? 1 : $kernel->vars['page'];
$kernel->vars['limit'] = ( $kernel->vars['limit'] < 1 ) ? $kernel->config['admin_display_default_limit'] : $kernel->vars['limit'];

if( empty( $kernel->vars['sort'] ) ) $kernel->vars['sort'] = "file_name";
if( empty( $kernel->vars['order'] ) ) $kernel->vars['order'] = "asc";

switch( $kernel->vars['action'] )
{
	
	#############################################################################
	
	case "view" :
	{
		$kernel->clean_array( "_REQUEST", array( "report_id" => V_INT, "group_id" => V_INT, "group_type" => V_INT ) );
		
		if( $kernel->vars['report_id'] == 0 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_report_specified'], M_ERROR );
		}
		if( $kernel->vars['group_type'] == 0 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_group_type_specified'], M_ERROR );
		}
		else
		{
			if( $kernel->vars['report_id'] == "1" )
			{
				$report_query_syntax = "f.file_description = ''";
			}
			elseif( $kernel->vars['report_id'] == "2" )
			{
				$report_query_syntax = "f.file_size = 0";
			}
			elseif( $kernel->vars['report_id'] == "3" )
			{
				//no custom fields
			}
			elseif( $kernel->vars['report_id'] == "4" )
			{
				$report_query_syntax = "f.file_author = ''";
			}
			elseif( $kernel->vars['report_id'] == "5" )
			{
				$report_query_syntax = "";
				
				$get_administrators = $kernel->db->query( "SELECT `user_name` FROM `" . TABLE_PREFIX . "users` WHERE `user_group_id` = 1" );
				
				while( $admin = $kernel->db->data( $get_administrators ) )
				{
					$report_query_syntax .= "f.file_author = '{$admin['user_name']}' OR ";
				}				
				$report_query_syntax = preg_replace( "/OR $/", "", $report_query_syntax ); 
			}
			elseif( $kernel->vars['report_id'] == "6" )
			{
				$report_query_syntax = "f.file_doc_id = 0";
			}
			elseif( $kernel->vars['report_id'] == "7" )
			{
				$report_query_syntax = "( f.file_downloads >= f.file_dl_limit ) AND f.file_dl_limit <> 0";
			}
			elseif( $kernel->vars['report_id'] == "8" )
			{
				$report_query_syntax = "c.category_description = ''";
			}
			elseif( $kernel->vars['report_id'] == "9" )
			{
				$report_query_syntax = "c.category_file_total = 0";
			}
			
			#########################################################################
			# File Groups
			
			if( $kernel->vars['group_type'] == 1 )
			{
				$check_files = $kernel->db->query( "SELECT f.file_id FROM " . TABLE_PREFIX . "files f WHERE {$report_query_syntax}" );
				
				if( $kernel->db->numrows() == 0 )
				{
					$kernel->page_function->message_report( $kernel->ld['lang_b_no_files_in_category'], M_ERROR );
				}
				else
				{
					$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_files ) );
					
					$kernel->tp->call( "admin_file_header" );
					
					$get_files = $kernel->db->query( "SELECT f.file_id, f.file_cat_id, f.file_name, f.file_pinned, f.file_description FROM " . TABLE_PREFIX . "files f WHERE {$report_query_syntax} ORDER BY f.file_pinned DESC, f.file_name LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
					
					while( $file = $kernel->db->data( $get_files ) )
					{
						if( $last_filegroup == 1 AND $file['file_pinned'] == 0 )
						{
							$kernel->tp->call( "admin_file_row_break" );
						}
						$last_filegroup = $file['file_pinned'];
						
						$kernel->tp->call( "admin_file_row" );
						
						$file['file_description'] = $kernel->archive_function->return_string_words(	$kernel->format_input( $file['file_description'], T_PREVIEW ), $kernel->config['string_max_words'] );
						$file['file_name'] = $kernel->format_input( $file['file_name'], T_PREVIEW );
						
						$file['file_html_name'] = $kernel->admin_function->construct_icon( "shield.gif", $kernel->ld['lang_b_file_is_pinned_important'], ( $file['file_pinned'] == 1 ) );
						
						$file['file_html_name'] .= $file['file_name'];
						
						$kernel->tp->cache( $file );
					}
					
					$kernel->tp->call( "admin_report_file_footer" );
					
					$kernel->page_function->construct_category_filters();
					
					$kernel->vars['pagination_urls'] = array(
						"nextpage" => "index.php?hash={$kernel->session['hash']}&node=archive_report&action=view&group_type=1&report_id={$kernel->vars['report_id']}&limit={$kernel->vars['limit']}&page={\$nextpage}",
						"previouspage" => "index.php?hash={$kernel->session['hash']}&node=archive_report&action=view&group_type=1&report_id={$kernel->vars['report_id']}&limit={$kernel->vars['limit']}&page={\$previouspage}",
						"span" => "index.php?hash={$kernel->session['hash']}&node=archive_report&action=view&group_type=1&report_id={$kernel->vars['report_id']}&limit={$kernel->vars['limit']}&page={\$page}",
						"start" => "index.php?hash={$kernel->session['hash']}&node=archive_report&action=view&group_type=1&report_id={$kernel->vars['report_id']}&limit={$kernel->vars['limit']}&page=1",
						"end" => "index.php?hash={$kernel->session['hash']}&node=archive_report&action=view&group_type=1&report_id={$kernel->vars['report_id']}&limit={$kernel->vars['limit']}&page={$kernel->vars['total_pages']}",
					);
					
					$kernel->page_function->construct_pagination( $kernel->vars['pagination_urls'], $kernel->config['admin_pagination_page_proximity'] );
					
					$kernel->page_function->construct_category_list( $category_id );
				}
			}
			
			#########################################################################
			# Category Groups
			
			elseif( $kernel->vars['group_type'] == 2 )
			{
				$check_categories = $kernel->db->query( "SELECT c.category_id FROM " . TABLE_PREFIX . "categories c WHERE {$report_query_syntax}" );
				
				if( $kernel->db->numrows() == 0 )
				{
					$kernel->page_function->message_report( $kernel->ld['lang_b_no_categories'], M_ERROR );
				}
				else
				{
					$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_categories ) );
					
					$kernel->tp->call( "admin_cate_header" );
					
					$get_categories = $kernel->db->query( "SELECT c.category_id, c.category_name, c.category_description, c.category_password FROM " . TABLE_PREFIX . "categories c WHERE {$report_query_syntax} ORDER BY c.category_name LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
					
					while( $category = $kernel->db->data( $get_categories ) )
					{
						$kernel->tp->call( "admin_cate_row" );
						
						$category['category_name'] = $kernel->format_input( $category['category_name'], T_HTML );
						$category['category_description'] = $kernel->archive_function->return_string_words(	$kernel->format_input( $category['category_description'], T_PREVIEW ), $kernel->config['string_max_words'] );
						
						$category['category_html_name'] = $category['category_name'];
						
						$category['category_state_icon'] = $kernel->admin_function->construct_icon( "lock.gif", $kernel->ld['lang_b_category_password_protected'], ( !empty( $category['category_password'] ) ) );
						
						$kernel->tp->cache( $category );
					}
					
					$kernel->tp->call( "admin_cate_footer" );
					
					$kernel->page_function->construct_category_filters();
					
					$kernel->vars['pagination_urls'] = array(
						"nextpage" => "index.php?hash={$kernel->session['hash']}&node=archive_report&action=view&group_type=2&report_id={$kernel->vars['report_id']}&limit={$kernel->vars['limit']}&page={\$nextpage}",
						"previouspage" => "index.php?hash={$kernel->session['hash']}&node=archive_report&action=view&group_type=2&report_id={$kernel->vars['report_id']}&limit={$kernel->vars['limit']}&page={\$previouspage}",
						"span" => "index.php?hash={$kernel->session['hash']}&node=archive_report&action=view&group_type=2&report_id={$kernel->vars['report_id']}&limit={$kernel->vars['limit']}&page={\$page}",
						"start" => "index.php?hash={$kernel->session['hash']}&node=archive_report&action=view&group_type=2&report_id={$kernel->vars['report_id']}&limit={$kernel->vars['limit']}&page=1",
						"end" => "index.php?hash={$kernel->session['hash']}&node=archive_report&action=view&group_type=2&report_id={$kernel->vars['report_id']}&limit={$kernel->vars['limit']}&page={$kernel->vars['total_pages']}",
					);
					
					$kernel->page_function->construct_pagination( $kernel->vars['pagination_urls'], $kernel->config['admin_pagination_page_proximity'] );
					
					$kernel->page_function->construct_category_list();
				}
			}
		}
	
		break;
	}
	
	#############################################################################
	
	default :
	{
		$kernel->tp->call( "admin_report" );
		
		$total_files = $kernel->db->numrows( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files`" );
		$total_fields = $kernel->db->numrows( "SELECT `field_id` FROM `" . TABLE_PREFIX . "fields_data`" );
		
		//administrator list in query
		$admin_loop = "";
		
		$get_administrators = $kernel->db->query( "SELECT `user_name` FROM `" . TABLE_PREFIX . "users` WHERE `user_group_id` = '1'" );
		while( $admin = $kernel->db->data( $get_administrators ) )
		{
			$admin_loop .= "`file_author` = '{$admin['user_name']}' OR ";
		}
		$admin_loop = preg_replace( "/OR $/", "", $admin_loop );
		
		$reportdata = array (
			"files_no_desc" => $kernel->db->numrows( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_description` = ''" ),
			"files_no_size" => $kernel->db->numrows( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_size` = 0" ),
			"files_no_field" => $total_files - $total_fields,
			"files_no_author" => $kernel->db->numrows( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_author` = ''" ),
			"files_bad_author" => $kernel->db->numrows( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files` WHERE	{$admin_loop}" ),
			"files_no_document" => $kernel->db->numrows( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_doc_id` = 0" ),
			"files_dl_limit" => $kernel->db->numrows( "SELECT `file_id` FROM `" . TABLE_PREFIX . "files` WHERE ( `file_downloads` >= `file_dl_limit` ) AND `file_dl_limit` != 0" ),
			
			"cate_no_desc" => $kernel->db->numrows( "SELECT `category_id` FROM `" . TABLE_PREFIX . "categories` WHERE `category_description` = ''" ),
			"cate_no_files" => $kernel->db->numrows( "SELECT `category_id` FROM `" . TABLE_PREFIX . "categories` WHERE `category_file_total` = 0" ),
		);
		
		$kernel->tp->cache( $reportdata );
		
		break;
	}
}

?>

