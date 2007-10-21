<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 12, 13 );

$kernel->clean_array( "_REQUEST", array( "page" => V_PINT, "limit" => V_PINT, "sort" => V_STR, "order" => V_STR, "start" => V_PINT, "document_id" => V_INT ) );

$kernel->vars['page'] = ( $kernel->vars['page'] < 1 ) ? 1 : $kernel->vars['page'];
$kernel->vars['limit'] = ( $kernel->vars['limit'] < 1 ) ? $kernel->config['admin_display_default_limit'] : $kernel->vars['limit'];

if( empty( $kernel->vars['sort'] ) ) $kernel->vars['sort'] = "file_name";
if( empty( $kernel->vars['order'] ) ) $kernel->vars['order'] = "asc";

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "edit" :
	{
		$kernel->admin_function->read_permission_flags( 12 );
		
		$kernel->tp->call( "admin_docu_edit" );
		
		$document = $kernel->db->row( "SELECT * FROM `" . TABLE_PREFIX . "documents` WHERE `document_id` = {$kernel->vars['document_id']} LIMIT 1" );
		
		$document['document_title'] = $kernel->format_input( $document['document_title'], T_FORM );
		$document['document_data'] = $kernel->format_input( $document['document_data'], T_FORM );
		
		$kernel->tp->cache( $document );
		
		break;
	}
	
	#############################################################################
	
	case "update" :
	{
		$kernel->admin_function->read_permission_flags( 12 );
		
		$kernel->clean_array( "_REQUEST", array( "document_title" => V_STR, "document_data" => V_STR ) );
		
		$documentdata = array(
			"document_title" => $kernel->format_input( $kernel->vars['document_title'], T_DB ),
			"document_data" => $kernel->archive_function->string_word_length_slice( $kernel->format_input( $kernel->vars['document_data'], T_DB ), $kernel->config['string_max_word_length'] ),
			"document_timestamp" => UNIX_TIME
		);

		$kernel->db->update( "documents", $documentdata, "WHERE `document_id` = {$kernel->vars['document_id']}" );
		
		$kernel->archive_function->update_database_counter( "documents" );
		
		$kernel->admin_function->message_admin_report( "lang_b_log_document_edited", $kernel->vars['document_title'] );
		
		break;
	}
	
	#############################################################################
	
	case "delete" :
	{
		$kernel->admin_function->read_permission_flags( 13 );
		
		$delete_count = 0;
		
		if( $kernel->vars['document_id'] > 0 )
		{
			$delete_data[] = $kernel->db->item( "SELECT `document_title` FROM `" . TABLE_PREFIX . "documents` WHERE `document_id` = {$kernel->vars['document_id']}" );
			
			$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "documents` WHERE `document_id` = {$kernel->vars['document_id']}" );
			$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "files` SET `file_doc_id` = '0' WHERE `file_doc_id` = {$kernel->vars['document_id']}" );
			$delete_count++;
		}
		elseif( is_array( $_POST['checkbox'] ) )
		{
			foreach( $_POST['checkbox'] AS $document )
			{
				$delete_data[] = $kernel->db->item( "SELECT `document_title` FROM `" . TABLE_PREFIX . "documents` WHERE `document_id` = {$document}" );
				
				$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "documents` WHERE `document_id` = {$document}" );
				$kernel->db->query( "UPDATE `" . TABLE_PREFIX . "files` SET `file_doc_id` = '0' WHERE `file_doc_id` = {$document}" );
				$delete_count++;
			}
		}
		else
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_checkbox_none_selected'], M_ERROR, HALT_EXEC );
		}
		
		$kernel->archive_function->update_database_counter( "documents" );
		
		$kernel->admin_function->message_admin_report( "lang_b_log_document_deleted", $delete_count, $delete_data );
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$check_documents = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "documents` ORDER BY `document_id`" );
		
		if( $kernel->db->numrows() == 0 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_documents'], M_ERROR );
		}
		else
		{
			$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_documents ) );
			
			$kernel->tp->call( "admin_docu_header" );
			
			$get_documents = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "documents` ORDER BY `document_id` LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
			
			while( $document = $kernel->db->data( $get_documents ) )
			{
				$kernel->tp->call( "admin_docu_row" );
				
				$document['document_title'] = $kernel->format_input( $document['document_title'], T_PREVIEW );
				$document['document_data'] = $kernel->archive_function->return_string_words( $kernel->format_input( $document['document_data'], T_PREVIEW ), $kernel->config['string_max_words'] );
				
				$kernel->tp->cache( $document );
			}
			
			$kernel->tp->call( "admin_docu_footer" );
			
			$kernel->page_function->construct_category_filters();
			
	 		$kernel->vars['pagination_urls'] = array(
				"nextpage" => "index.php?hash={$kernel->session['hash']}&node=docu_manage&limit={$kernel->vars['limit']}&page={\$nextpage}",
				"previouspage" => "index.php?hash={$kernel->session['hash']}&node=docu_manage&limit={$kernel->vars['limit']}&page={\$previouspage}",
				"span" => "index.php?hash={$kernel->session['hash']}&node=docu_manage&limit={$kernel->vars['limit']}&page={\$page}",
				"start" => "index.php?hash={$kernel->session['hash']}&node=docu_manage&limit={$kernel->vars['limit']}&page=1",
				"end" => "index.php?hash={$kernel->session['hash']}&node=docu_manage&limit={$kernel->vars['limit']}&page={$kernel->vars['total_pages']}",
			);
			
			$kernel->page_function->construct_pagination( $kernel->vars['pagination_urls'], $kernel->config['admin_pagination_page_proximity'] );
		}
		
		break;
	}
}

?>

