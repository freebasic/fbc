<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

require_once( "global.php" );

$kernel->clean_array( "_REQUEST", array( "id" => V_INT ) );

//No ID ref
if( $kernel->vars['id'] == 0 )
{
	$kernel->page_function->message_report( $kernel->ld['lang_f_no_file_specified'], M_ERROR );
}
else
{
  $get_file = $kernel->db->query( "SELECT `file_id`, `file_cat_id`, `file_name`, `file_image_array`, `file_gallery_id` FROM `" . TABLE_PREFIX . "files` WHERE `file_id` = {$kernel->vars['id']}" );
	
	//Invalid ID ref
  if( $kernel->db->numrows() == 0 )
  {
  	$kernel->page_function->message_report( $kernel->ld['lang_f_file_no_exists'], M_ERROR );
  }
  else
  {
  	$file = $kernel->db->data( $get_file );
  	
		//Setup base page vars
    $kernel->vars['page_struct']['system_page_action_title'] = sprintf( $kernel->ld['lang_f_page_title_file'], $file['file_name'] );
    $kernel->vars['page_struct']['system_page_navigation_id'] = $file['file_cat_id'];
    $kernel->vars['page_struct']['system_page_navigation_html'] = array( "file.php?id={$kernel->vars['id']}" => $file['file_name'], SCRIPT_PATH => sprintf( $kernel->ld['lang_f_page_title_file'], $file['file_name'] ) );
		
		//Check gallery viewing permissions
  	if( $kernel->session_function->read_permission_flag( 4, true ) == true )
  	{
			//Check category permissions
  		$kernel->page_function->read_category_permissions( $file['file_cat_id'], SCRIPT_PATH );
  		
			//No Images
  		if( empty( $file['file_image_array'] ) AND empty( $file['file_gallery_id'] ) )
  		{
  			$kernel->page_function->message_report( $kernel->ld['lang_f_image_no_exists'], M_ERROR );
  		}
  		else
  		{
  			$check_images = $kernel->db->query( "SELECT * FROM `" . TABLE_PREFIX . "galleries` WHERE `gallery_id` = {$file['file_gallery_id']}" );
  			
  			$gallery = $kernel->db->data( $check_images );
  			
				//Check if custom selected images exist
  			if( empty( $gallery['gallery_image_array'] ) AND empty( $file['file_image_array'] ) )
  			{
  				$kernel->page_function->message_report( $kernel->ld['lang_f_image_no_exists'], M_ERROR );
  			}
  			else
  			{
          $image_count = 0;
          
          $gallery_dir = $kernel->config['system_root_dir_gallery'] . DIR_STEP;
					
					$thumb_dir = $gallery_dir . "thumbs" . DIR_STEP;
					
  				if( empty( $gallery['gallery_description'] ) )
  				{
  					$gallery['gallery_description'] = "&nbsp;";
  				}
  				else
  				{
  					$gallery['gallery_description'] = $kernel->format_input( $gallery['gallery_description'], T_HTML );
  				}
  				
					//Set the size of cells based on max images per row
  				$kernel->vars['image_cell_width'] = floor( 100 / $kernel->config['image_max_row_thumbnails'] ) . "%";
					
					//Assigned gallery set images
  				if( $kernel->db->numrows( $check_images ) > 0 AND !empty( $gallery['gallery_image_array'] ) )
  				{
						//Setup page vars
						$kernel->vars['page_struct']['system_page_action_title'] = sprintf( $kernel->ld['lang_f_page_title_gallery'], $gallery['gallery_name'] );
						$kernel->vars['page_struct']['system_page_navigation_id'] = $file['file_cat_id'];
						$kernel->vars['page_struct']['system_page_navigation_html'] = array( "file.php?id={$kernel->vars['id']}" => $file['file_name'], SCRIPT_PATH => sprintf( $kernel->ld['lang_f_page_title_gallery'], $gallery['gallery_name'] ) );
  					
  					$image_array = explode( ",", $gallery['gallery_image_array'] );
  					
						//Get images
  					foreach( $image_array AS $image_id )
  					{
  						$image = $kernel->db->row( "SELECT * FROM `" . TABLE_PREFIX . "images` WHERE `image_id` = {$image_id}" );
  						
  						if( empty( $image['image_file_name'] ) ) continue;
  						
  						$kernel->vars['html']['gallery_images'] .= ( $image_count % $kernel->config['image_max_row_thumbnails'] == 0 AND $image_count > 0 ) ? $kernel->tp->call( "gallery_row_break", CALL_TO_PAGE ) : "";
  						
  						$kernel->vars['html']['gallery_images'] .= $kernel->tp->call( "gallery_item", CALL_TO_PAGE );
  						
  						$image['image_name'] = $kernel->format_input( $image['image_name'], T_HTML );
  						$image['image_file_name'] = $kernel->format_input( $image['image_file_name'], T_HTML );
  						$image['image_description'] = $kernel->format_input( $image['image_description'], T_HTML );
  						
							//Check for thumbnail of gallery image
  						if( file_exists( $thumb_dir . $image['image_file_name'] ) )
  						{
  							$image['image_dimension_width'] = "";
  							$image['image_dimension_width'] = "";
  							$image['image_thumbnail_url'] = $kernel->config['system_root_url_gallery'] . "/thumbs/" . $image['image_file_name'];
  						}
							
							//Display rescaled view of the original image
  						else
  						{
  							$max_dimensions = explode( "x", $kernel->config['gd_thumbnail_max_dimensions'] );
  							$image_dimensions = explode( "x", $image['image_dimensions'] );
  							$scale = min( $max_dimensions[0] / $image_dimensions[0], $max_dimensions[1] / $image_dimensions[1] );
  							
  							$image['image_dimension_width'] = floor( $scale * $image_dimensions[0] );
  							$image['image_dimension_width'] = floor( $scale * $image_dimensions[1] );
  							$image['image_thumbnail_url'] = $kernel->config['system_root_url_gallery'] . "/" . $image['image_file_name'];
  						}
  						
  						$kernel->vars['html']['gallery_images'] = $kernel->tp->cache( $image, 0, $kernel->vars['html']['gallery_images'] );
  						
  						$image_count++;
  					}
  				}
  				
					//Custom assigned images
  				if( !empty( $file['file_image_array'] ) )
  				{
						//Setup page vars
						$kernel->vars['page_struct']['system_page_action_title'] = sprintf( $kernel->ld['lang_f_page_title_images'], $file['file_name'] );
						$kernel->vars['page_struct']['system_page_navigation_id'] = $file['file_cat_id'];
						$kernel->vars['page_struct']['system_page_navigation_html'] = array( "file.php?id={$kernel->vars['id']}" => $file['file_name'], SCRIPT_PATH => sprintf( $kernel->ld['lang_f_page_title_gallery'], $gallery['gallery_name'] ) );
  					
  					$image_array = explode( ",", $file['file_image_array'] );
  					
						//Get images
  					foreach( $image_array AS $image_id )
  					{
							if( empty( $image_id ) ) continue;
							
  						$image = $kernel->db->row( "SELECT * FROM `" . TABLE_PREFIX . "images` WHERE `image_id` = {$image_id}" );
  						
  						if( empty( $image['image_file_name'] ) ) continue;
  						
  						$kernel->vars['html']['gallery_images'] .= ( $image_count % $kernel->config['image_max_row_thumbnails'] == 0 AND $image_count > 0 ) ? $kernel->tp->call( "gallery_row_break", CALL_TO_PAGE ) : "";
  						
  						$kernel->vars['html']['gallery_images'] .= $kernel->tp->call( "gallery_item", CALL_TO_PAGE );
  						
  						$image['image_name'] = $kernel->format_input( $image['image_name'], T_HTML );
  						$image['image_file_name'] = $kernel->format_input( $image['image_file_name'], T_HTML );
  						$image['image_description'] = $kernel->format_input( $image['image_description'], T_HTML );
  						
							//Check for thumbnail of gallery image
  						if( file_exists( $thumb_dir . $image['image_file_name'] ) )
  						{
								$image_dimensions = getimagesize( $thumb_dir . $image['image_file_name'] );
								
  							$image['image_dimension_width'] = $image_dimensions[0];
  							$image['image_dimension_height'] = $image_dimensions[1];
  							$image['image_url'] = $kernel->config['system_root_url_gallery'] . "/" . $image['image_file_name'];
								$image['image_thumbnail_url'] = $kernel->config['system_root_url_gallery'] . "/thumbs/" . $image['image_file_name'];
  						}
							
							//Display rescaled view of the original image
  						else
  						{
  							$max_dimensions = explode( "x", $kernel->config['gd_thumbnail_max_dimensions'] );
  							$image_dimensions = explode( "x", $image['image_dimensions'] );
  							$scale = min( $max_dimensions[0] / $image_dimensions[0], $max_dimensions[1] / $image_dimensions[1] );
  							
  							$image['image_dimension_width'] = floor( $scale * $image_dimensions[0] );
  							$image['image_dimension_height'] = floor( $scale * $image_dimensions[1] );
  							$image['image_thumbnail_url'] = $image['image_url'] = $kernel->config['system_root_url_gallery'] . "/" . $image['image_file_name'];
  						}
  						
  						$kernel->vars['html']['gallery_images'] = $kernel->tp->cache( $image, 0, $kernel->vars['html']['gallery_images'] );
  						
  						$image_count++;
  					}
  				}
  				
					//Images are missing
  				if( $image_count == 0 )
  				{
  					$kernel->page_function->message_report( $kernel->ld['lang_f_images_missing'], M_ERROR );
  				}
  				else
  				{
						//Adjust spacing between cells of less images than max per row limit
  					if( $image_count < $kernel->config['image_max_row_thumbnails'] )
  					{
  						$kernel->vars['image_per_row'] = $image_count;
  					}
  					else
  					{
  						$kernel->vars['image_per_row'] = $kernel->config['image_max_row_thumbnails'];
  					}
						
						//Fill in the blanks with empty cells to avoid page defacing
  					while( $image_count % $kernel->config['image_max_row_thumbnails'] != 0 AND $image_count >= $kernel->config['image_max_row_thumbnails'] )
  					{
  						$kernel->vars['html']['gallery_images'] .= $kernel->tp->call( "gallery_empty_item", CALL_TO_PAGE );
  						$image_count++;
  					}
  					
						//Cache
  					$kernel->tp->call( "gallery_view" );
						
						$kernel->tp->cache( "gallery_images", $kernel->vars['html']['gallery_images'] );
						
  					$kernel->tp->cache( $gallery );
  					$kernel->tp->cache( $file );
  				}
  			}
  		}
  	}
  }
}

$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );

?>