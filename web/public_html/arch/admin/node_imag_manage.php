<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 21, 22 );

$kernel->clean_array( "_REQUEST", array( "page" => V_PINT, "limit" => V_PINT, "sort" => V_STR, "order" => V_STR, "start" => V_PINT, "image_id" => V_INT ) );

$kernel->vars['page'] = ( $kernel->vars['page'] < 1 ) ? 1 : $kernel->vars['page'];
$kernel->vars['limit'] = ( $kernel->vars['limit'] < 1 ) ? $kernel->config['admin_display_default_limit'] : $kernel->vars['limit'];

if( empty( $kernel->vars['sort'] ) ) $kernel->vars['sort'] = "file_name";
if( empty( $kernel->vars['order'] ) ) $kernel->vars['order'] = "asc";

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	case "edit" :
	{
		$kernel->admin_function->read_permission_flags( 21 );
		
		$image = $kernel->db->row( "SELECT * FROM `" . TABLE_PREFIX . "images` WHERE `image_id` = {$kernel->vars['image_id']} LIMIT 1" );
		
		$kernel->tp->call( "admin_imag_edit" );
		
		$image['image_name'] = $kernel->format_input( $image['image_name'], T_FORM );
		$image['image_description'] = $kernel->format_input( $image['image_description'], T_FORM );
		$image['image_timestamp'] = $kernel->fetch_time( $image['image_timestamp'], DF_LONG );
		
		$image['image_file_url'] = ( file_exists( $kernel->config['system_root_dir_gallery'] . DIR_STEP . "thumbs" . DIR_STEP . $image['image_file_name'] ) ) ? $kernel->config['system_root_url_gallery'] . "/thumbs/" . $image['image_file_name'] : $kernel->config['system_root_url_path'] . "/images/no_thumbnail.gif";
		
		$image['image_thumbnail_status'] = ( $kernel->config['gd_thumbnail_feature'] != "true" ) ? "disabled=\"disabled\"" : "";
		
		$kernel->admin_function->read_directory_index( "image", $image['image_file_name'], "lang_b_menu_choose_images", $kernel->config['system_root_dir_gallery'] . DIR_STEP, LIST_FILE );
		
		$kernel->tp->cache( $image );
				
		break;
	}
	
	#############################################################################
	
	case "update" :
	{
		$kernel->admin_function->read_permission_flags( 21 );
		
		$kernel->clean_array( "_POST", array( "image_file_name" => V_STR, "image_name" => V_STR, "image_description" => V_STR ) );
		
		if( empty( $kernel->vars['image_file_name'] ) )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_file_selected'], M_ERROR );
		}
		else
		{
			if( empty( $kernel->vars['image_name'] ) )
			{
				$kernel->vars['image_name'] = $kernel->vars['image_file_name'];
			}
			
			$imagedata = array(
				"image_name" => $kernel->format_input( $kernel->vars['image_name'], T_DB ),
				"image_file_name" => $kernel->format_input( $kernel->vars['image_file_name'], T_DB ),
				"image_description" => $kernel->format_input( $kernel->vars['image_description'], T_DB ),
				"image_timestamp" => UNIX_TIME
			);
			
			if( $_POST['option_thumbnail_refresh'] == "1" )
			{
				$image_directory = $kernel->config['system_root_dir_gallery'] . DIR_STEP;
				
				$kernel->vars['image_file_name'] = $kernel->format_input( $kernel->vars['image_file_name'], T_URL_DEC );
				
				$image_dimensions = @getimagesize( $image_directory . $kernel->vars['image_file_name'] );
				$imagedata['image_dimensions'] = $kernel->format_input( $image_dimensions[0] . "x" . $image_dimensions[1], T_DB );
				
				if( $kernel->config['gd_thumbnail_feature'] == "true" )
				{
  				if( !is_writable( $image_directory . "thumbs" . DIR_STEP ) )
  				{
  					$kernel->page_function->message_report( "Cannot update thumbnail, check write permissions on the thumbnail file.", M_ERROR, HALT_EXEC );
  				}
  				else
  				{
  					$kernel->image_function->construct_thumbnail( $image_directory . $kernel->vars['image_file_name'], $image_directory . "thumbs" . DIR_STEP . $kernel->vars['image_file_name'], $image_dimensions );
  				}
				}
			}
			
			$kernel->db->update( "images", $imagedata, "WHERE `image_id` = {$kernel->vars['image_id']}" );
			
			$kernel->archive_function->update_database_counter( "images" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_image_edited", $kernel->vars['image_name'] );
		}
		
		break;
	}
	
	#############################################################################
	
	case "manage" :
	{
		$count = 0;
		
		if( isset( $_POST['form_delete'] ) OR $kernel->vars['image_id'] > 0 )
		{
			$kernel->admin_function->read_permission_flags( 22 );
			
			if( $kernel->vars['image_id'] > 0 )
			{
				if( $_POST['option_physical_delete'] == "1" )
				{
					$image = $kernel->db->row( "SELECT `image_file_name` FROM `" . TABLE_PREFIX . "images` WHERE `image_id` = {$kernel->vars['image_id']}" );
					
					@unlink( $kernel->config['system_root_dir_gallery'] . DIR_STEP . $image['image_file_name'] );
					@unlink( $kernel->config['system_root_dir_gallery'] . DIR_STEP . "thumbs" . DIR_STEP . $image['image_file_name'] );
				}
				
				$delete_data[] = $kernel->db->item( "SELECT `image_name` FROM `" . TABLE_PREFIX . "images` WHERE `image_id` = {$kernel->vars['image_id']}" );
				
				$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "images` WHERE `image_id` = {$kernel->vars['image_id']}" );
				$count++;
			}
			elseif( is_array( $_POST['checkbox'] ) )
			{
				$kernel->admin_function->read_permission_flags( 22 );
				
				foreach( $_POST['checkbox'] AS $image_id )
				{
					if( $option_physical_delete == "1" )
					{
						$image = $kernel->db->row( "SELECT `image_file_name` FROM `" . TABLE_PREFIX . "images` WHERE `image_id` = {$image_id}" );
						
						@unlink( $kernel->config['system_root_dir_gallery'] . DIR_STEP . $image['image_file_name'] );
						@unlink( $kernel->config['system_root_dir_gallery'] . DIR_STEP . "thumbs" . DIR_STEP . $image['image_file_name'] );
					}
					
					$delete_data[] = $kernel->db->item( "SELECT `image_name` FROM `" . TABLE_PREFIX . "images` WHERE `image_id` = {$image_id}" );
					
					$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "images` WHERE `image_id` = {$image_id}" );
					$count++;
				}
			}
			else
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_checkbox_none_selected'], M_ERROR, HALT_EXEC );
			}
			
			$kernel->archive_function->update_database_counter( "images" );
			
			$kernel->admin_function->message_admin_report( "lang_b_log_image_deleted", $count, $delete_data );
		}
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$check_images = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "images` ORDER BY `image_name`" );
		
		if( $kernel->db->numrows() == 0 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_no_images'], M_ERROR );
		}
		else
		{
			$kernel->archive_function->construct_pagination_vars( $kernel->db->numrows( $check_images ) );
			
			$kernel->tp->call( "admin_imag_header" );
			
			$get_images = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "images` ORDER BY `image_name` LIMIT {$kernel->vars['start']}, {$kernel->vars['limit']}" );
			
			$gallery_dir = $kernel->config['system_root_dir_gallery'] . DIR_STEP;
			$thumb_dir = $kernel->config['system_root_dir_gallery'] . DIR_STEP . "thumbs" . DIR_STEP;
			
			while( $image = $kernel->db->data( $get_images ) )
			{
				$kernel->tp->call( "admin_imag_row" );
				
				$image['image_name'] = $kernel->format_input( $image['image_name'], T_PREVIEW );

				$image['image_html_name'] = $kernel->admin_function->construct_icon( "picture_error.gif", $kernel->ld['lang_b_image_gallery_image_missing'], ( !file_exists( $gallery_dir . $image['image_file_name'] ) ) );
				$image['image_html_name'] .= $kernel->admin_function->construct_icon( "image.gif", $kernel->ld['lang_b_image_thumbnail_exists'], ( file_exists( $thumb_dir . $image['image_file_name'] ) ) );
				$image['image_html_name'] .= $image['image_name'];
				
				$image['image_description'] = $kernel->archive_function->return_string_words(	$kernel->format_input( $image['image_description'], T_PREVIEW ), $kernel->config['string_max_words'] );
				
				$kernel->tp->cache( $image );
			}
			
			$kernel->tp->call( "admin_imag_footer" );
			
			$kernel->page_function->construct_category_filters();
			
	 		$kernel->vars['pagination_urls'] = array(
				"nextpage" => "index.php?hash={$kernel->session['hash']}&node=imag_manage&limit={$kernel->vars['limit']}&page={\$nextpage}",
				"previouspage" => "index.php?hash={$kernel->session['hash']}&node=imag_manage&limit={$kernel->vars['limit']}&page={\$previouspage}",
				"span" => "index.php?hash={$kernel->session['hash']}&node=imag_manage&limit={$kernel->vars['limit']}&page={\$page}",
				"start" => "index.php?hash={$kernel->session['hash']}&node=imag_manage&limit={$kernel->vars['limit']}&page=1",
				"end" => "index.php?hash={$kernel->session['hash']}&node=imag_manage&limit={$kernel->vars['limit']}&page={$kernel->vars['total_pages']}",
			);
			
			$kernel->page_function->construct_pagination( $kernel->vars['pagination_urls'], $kernel->config['admin_pagination_page_proximity'] );
			
			$kernel->page_function->construct_category_list();
		}
		
		break;
	}
}

?>

