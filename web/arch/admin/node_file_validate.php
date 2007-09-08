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

$kernel->clean_array( "_REQUEST", array( "file_id" => V_INT, "mirror_id" => V_INT, "file_url" => V_STR ) );

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "verify" :
	{
		if( $kernel->vars['file_id'] > 0 )
		{
  		$check_file = $kernel->db->query( "SELECT f.file_dl_url, f.file_hash_data FROM " . TABLE_PREFIX . "files f WHERE f.file_id = {$kernel->vars['file_id']} LIMIT 1" );
  		
  		if( $kernel->db->numrows() == 0 )
  		{
  			$kernel->page_function->message_report( $kernel->ld['lang_b_file_no_exist'], M_ERROR, HALT_EXEC );
  		}
  		else
  		{
				$file = $kernel->db->data( $check_file );
				
				list( $file['file_hash_md5'], $file['file_hash_sha1'] ) = explode( ",", $file['file_hash_data'] );
				
				//Mirror specified? check it.
				if( $kernel->vars['mirror_id'] > 0 )
				{
					$check_mirror = $kernel->db->query( "SELECT m.mirror_file_url, m.mirror_file_hash_data FROM " . TABLE_PREFIX . "mirrors m WHERE m.mirror_id = {$kernel->vars['mirror_id']} LIMIT 1" );
					
					if( $kernel->db->numrows() > 0 )
          {
          	$mirror = $kernel->db->data( $check_mirror );
						
						list( $file['file_hash_md5'], $file['file_hash_sha1'] ) = explode( ",", $mirror['mirror_file_hash_data'] );
          }
				}
				
				if( is_array( $mirror ) AND !empty( $mirror['mirror_file_url'] ) )
				{
					$kernel->vars['file_url'] = $file['file_dl_url'] = trim( $mirror['mirror_file_url'] );
				}
				else
				{
					$kernel->vars['file_url'] = $file['file_dl_url'] = trim( $file['file_dl_url'] );
				}
				
				//if( empty( $file['file_hash_md5'] ) ) $file['file_hash_md5'] = $kernel->ld['lang_b_unknown'];
				//if( empty( $file['file_hash_sha1'] ) ) $file['file_hash_sha1'] = $kernel->ld['lang_b_unknown'];
  		}
		}
		else
		{
			$file['file_dl_url'] = $kernel->format_input( trim( $kernel->vars['file_url'] ), T_URL_DEC );
		}
		
  	//if( !@file( $file['file_dl_url'] ) )
		if( $kernel->url_exists( $file['file_dl_url'] ) != true )
  	{
  		$kernel->page_function->message_report( "File could not be located.", M_ERROR );
  	}
		else
		{
  		if( $kernel->vars['file_id'] > 0 )
			{
				$kernel->tp->call( "admin_file_verify_file" );
			}
			else
			{
				$kernel->tp->call( "admin_file_verify" );
			}
    	
    	//prep file data for updating
    	$file_info = $kernel->archive_function->file_url_info( $file['file_dl_url'] );
    	
    	//set_time_limit( 60 );
    	
    	$mt = explode( " ", microtime() );
    	$link_parse_start = $mt[1] + $mt[0];
    	
    	$filedata['file_size_raw'] = $kernel->archive_function->parse_url_size( $file['file_dl_url'], $kernel->config['system_parse_timeout'] );
    	
    	$mt = explode( " ", microtime() );
    	$link_parse_end = $mt[1] + $mt[0];
    	
    	$file['file_size'] = $kernel->archive_function->format_round_bytes( $filedata['file_size_raw'] );
    	$file['file_parse_time'] = round( $link_parse_end - $link_parse_start, 3 );
    	$file['file_parse_time_ms'] = ceil( round( $link_parse_end - $link_parse_start, 4 ) * 1000 );
			$file['file_parse_md5'] = $kernel->archive_function->exec_file_hash( $file['file_dl_url'] );
			$file['file_parse_sha1'] = $kernel->archive_function->exec_file_hash( $file['file_dl_url'], false );
    	$file['file_type'] = $file_info['file_type'];
    	$file['file_mime'] = $file_info['file_mime'];
			
    	if( $file['file_parse_time_ms'] <= 400 )
    	{
    		$file['file_response_remark'] = $kernel->page_function->string_colour( $kernel->ld['lang_b_excellent'], "#33CC33" );
    	}
    	elseif( $file['file_parse_time_ms'] > 400 AND $file['file_parse_time_ms'] <= 800 )
    	{
    		$file['file_response_remark'] = $kernel->page_function->string_colour( $kernel->ld['lang_b_good'], "#9FCC33" );
    	}
    	elseif( $file['file_parse_time_ms'] > 800 AND $file['file_parse_time_ms']	<= 1500 )
    	{
    		$file['file_response_remark'] = $kernel->page_function->string_colour( $kernel->ld['lang_b_ok'], "#CCBE33" );
    	}
    	elseif( $file['file_parse_time_ms'] > 1500 AND $file['file_parse_time_ms']	<= 3000 )
    	{
    		$file['file_response_remark'] = $kernel->page_function->string_colour( $kernel->ld['lang_b_poor'], "#CC8733" );
    	}
    	elseif( $file['file_parse_time_ms'] > 3000 )
    	{
    		$file['file_response_remark'] = $kernel->page_function->string_colour( $kernel->ld['lang_b_bad'], "#CC3333" );
    	}
    	
    	$kernel->ld['lang_b_file_url_response_time_seconds'] = sprintf( $kernel->ld['lang_b_file_url_response_time_seconds'], $file['file_parse_time'] );
    	
    	//filetype accepted for upload?
    	$file['file_type_valid'] = ( $file_info['file_type_exists'] == true ) ? $kernel->page_function->string_colour( $kernel->ld['lang_b_yes'], "#33cc33" ) : $kernel->page_function->string_colour( $kernel->ld['lang_b_no'], "red" );
    	
			//Empty file type, probably a directory or I just havn't got a clue..
			if( empty( $file_info['file_type'] ) ) $file['file_mime'] = $kernel->ld['lang_b_url_directory_or_unknown'];
			
			if( $kernel->vars['file_id'] > 0 )
			{
				//Hashes match parsed hashes?
				$file['file_hash_md5_match_result'] = ( $file['file_parse_md5'] == $file['file_hash_md5'] ) ? $kernel->page_function->string_colour( $kernel->ld['lang_b_yes'], "#33cc33" ) : $kernel->page_function->string_colour( $kernel->ld['lang_b_no'], "red" );
				$file['file_hash_sha1_match_result'] = ( $file['file_parse_sha1'] == $file['file_hash_sha1'] ) ? $kernel->page_function->string_colour( $kernel->ld['lang_b_yes'], "#33cc33" ) : $kernel->page_function->string_colour( $kernel->ld['lang_b_no'], "red" );
			
				if( empty( $file['file_hash_md5'] ) ) $file['file_hash_md5_match_result'] .= " " . $kernel->ld['lang_b_no_data'];
				if( empty( $file['file_hash_sha1'] ) ) $file['file_hash_sha1_match_result'] .= " " . $kernel->ld['lang_b_no_data'];
			}
			
    	$kernel->tp->cache( $file );
		}
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		break;
	}
}

$kernel->tp->call( "admin_file_verify_form" );

?>

