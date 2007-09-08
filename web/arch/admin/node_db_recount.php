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
	
	case "update" :
	{
		#=========================================
		# Recount total files per category
		#=========================================
		
		if( isset( $_POST['form_category_total_files'] ) )
		{
			$get_categories = $kernel->db->query( "SELECT `category_id`, `category_name` FROM " . TABLE_PREFIX . "categories" );
			while( $category = $kernel->db->data( $get_categories ) )
			{
				$subcat_files = 0;
				$total_files = 0;
				
				$sync_data[] = $category['category_name'];
				
				$kernel->archive_function->update_category_file_total( $category['category_id'] );
				
				$kernel->archive_function->construct_db_category_top_file_count( $category['category_id'] );
			}
			
			$kernel->archive_function->update_database_counter( "files" );
			$kernel->archive_function->update_database_counter( "categories" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_category_recount", 0, $sync_data );
		}
		
		#=========================================
		# Resync newest file per category
		#=========================================
		
		if( isset( $_POST['form_category_new_file'] ) )
		{
			$get_categories = $kernel->db->query( "SELECT `category_id`, `category_name` FROM " . TABLE_PREFIX . "categories" );
			while( $category = $kernel->db->data( $get_categories ) )
			{
				$newest_file_id = 0;
				$root_category = $category['category_id'];
				
				$sync_data[] = $category['category_name'];
				
				$kernel->archive_function->update_category_file_latest( $category['category_id'] );
				
				$kernel->archive_function->construct_db_category_top_new_file( $category['category_id'] );
			}
			
			$kernel->archive_function->update_database_counter( "files" );
			$kernel->archive_function->update_database_counter( "categories" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_category_resync", 0, $sync_data );
		}
		
		#=========================================
		# Recount all database statistic totals
		#=========================================
		
		if( isset( $_POST['form_recount_all_totals'] ) )
		{
			$kernel->archive_function->update_database_counter( "announcements" );
			$kernel->archive_function->update_database_counter( "categories" );
			$kernel->archive_function->update_database_counter( "comments" );
			$kernel->archive_function->update_database_counter( "documents" );
			$kernel->archive_function->update_database_counter( "fields" );
			$kernel->archive_function->update_database_counter( "fields_data" );
			$kernel->archive_function->update_database_counter( "files" );
			$kernel->archive_function->update_database_counter( "galleries" );
			$kernel->archive_function->update_database_counter( "images" );
			$kernel->archive_function->update_database_counter( "mirrors" );
			$kernel->archive_function->update_database_counter( "sites" );
			$kernel->archive_function->update_database_counter( "styles" );
			$kernel->archive_function->update_database_counter( "submissions" );
			$kernel->archive_function->update_database_counter( "templates" );
			$kernel->archive_function->update_database_counter( "themes" );
			$kernel->archive_function->update_database_counter( "users" );
			$kernel->archive_function->update_database_counter( "usergroups" );
			$kernel->archive_function->update_database_counter( "votes" );
			
			$kernel->archive_function->update_database_counter( "downloads" );
			$kernel->archive_function->update_database_counter( "data" );
			$kernel->archive_function->update_database_counter( "views" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_database_statistics_recount", 0 );
		}
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$kernel->tp->call( "admin_recount" );
		
		break;
	}
}

?>

