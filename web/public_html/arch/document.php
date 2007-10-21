<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

require_once( "global.php" );

$kernel->clean_array( "_REQUEST", array( "file_id" => V_INT, "mirror_id" => V_INT, "id" => V_INT, "document_disagree" => V_BOOL, "document_agree" => V_BOOL ) );

//No ID ref
if( $kernel->vars['id'] == 0 )
{
	$kernel->page_function->message_report( $kernel->ld['lang_f_no_docu_specified'], M_ERROR );
}
else
{
	//Document not agreed to, back to file page
	if( $kernel->vars['document_disagree'] == true )
	{
		header( "Location: file.php?id=" . $kernel->vars['file_id'] . "" );
		exit;
	}
	
	if( $kernel->vars['document_agree'] == true )
	{
		$_SESSION['document_agree'] = true;
		
		//Back to direct download
		if( empty( $mirror_id ) AND $kernel->db->numrows( "SELECT `mirror_id` FROM `" . TABLE_PREFIX . "mirrors` WHERE `mirror_file_id` = {$kernel->vars['file_id']}" ) == 0 )
		{
			header( "Location: download.php?id=" . $kernel->vars['file_id'] . "" );
			exit;
		}
		
		//Back to mirror download
		else
		{
			header( "Location: mirror.php?id=" . $kernel->vars['mirror_id'] . "&file_id=" . $kernel->vars['file_id'] . "" );
			exit;
		}
	}

  $get_documents = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "documents` WHERE `document_id` = {$kernel->vars['id']}" );
  
	//Invalid ID ref
  if( $kernel->db->numrows() == 0 )
  {
  	$kernel->page_function->message_report( $kernel->ld['lang_f_docu_no_exists'], M_ERROR );
  }
  else
  {
  	$document = $kernel->db->data( $get_documents );
  	
  	$file = $kernel->db->row( "SELECT `file_id`, `file_name`, `file_cat_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$kernel->vars['file_id']} LIMIT 1" );
  	
		//Setup page vars
  	$kernel->vars['page_struct']['system_page_action_title'] = sprintf( $kernel->ld['lang_f_page_title_document'], $document['document_title'] );
  	$kernel->vars['page_struct']['system_page_navigation_id'] = $file['file_cat_id'];
  	$kernel->vars['page_struct']['system_page_navigation_html'] = array( "file.php?id={$kernel->vars['file_id']}" => $file['file_name'], SCRIPT_PATH => $document['document_title'] );
  	
		//Build document data
  	$kernel->tp->call( "document_box" );
  	
  	$document['document_title'] = $kernel->format_input( $document['document_title'], T_HTML );
  	$document['document_data'] = $kernel->format_input( $document['document_data'], T_HTML );
  	$document['document_timestamp'] = $kernel->fetch_time( $document['document_timestamp'], DF_SHORT );
  	
  	$kernel->tp->cache( $document );
  }
}

$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );

?>