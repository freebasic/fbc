<?php

################################################################################
#	PHCDownload - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDL is free to use. Please visit the website for futher licence
# information and details on re-distribution and use.
################################################################################

  class class_image_function
{
	/*
	 * Replace exisiting thumbnail
	 **/
	
	function construct_thumbnail( $image_dir, $image_thumb_dir, $image_dimensions )
	{
		global $kernel;
  	
  	if( $kernel->config['gd_thumbnail_feature'] == "true" )
  	{
  		if( !function_exists( "imagecreatetruecolor" ) && !function_exists( "imagecreate" ) )
  		{
  			$kernel->page_function->message_report( $kernel->ld['lang_b_could_not_create_thumbnail_canvas'], M_ERROR, HALT_EXEC );
  		}
  		elseif( !function_exists( "imagecopyresampled" ) && !function_exists( "imagecopyresized" ) )
  		{
  			$kernel->page_function->message_report( $kernel->ld['lang_b_could_not_create_rescale_original_image'], M_ERROR, HALT_EXEC );
  		}
  		else
			{
				//get orig dimensions and re-scale
      	$max_dimensions = explode( "x", $kernel->config['gd_thumbnail_max_dimensions'] );
      	
      	$scale = min( $max_dimensions[0] / $image_dimensions[0], $max_dimensions[1] / $image_dimensions[1] );
      	
      	$new_width = floor( $scale * $image_dimensions[0] );
      	$new_height = floor( $scale * $image_dimensions[1] );
				
				$file_info = $kernel->archive_function->file_url_info( $image_dir );
      	
      	//check image type
      	if( $file_info['file_type'] == "GIF" && @imagetypes() & IMG_GIF )
      	{
      		if( !$image_source = @imagecreatefromgif( $image_dir ) )
      		{
      			$error_image_import = true;
      		}
      	}
      	elseif( $file_info['file_type'] == "PNG" && @imagetypes() & IMG_PNG )
      	{
      		if( !$image_source = @imagecreatefrompng( $image_dir ) )
      		{
      			$error_image_import = true;
    			}
    		}
    		elseif( $file_info['file_type'] == "JPEG" && @imagetypes() & IMG_JPG || $file_info['file_type'] == "JPG" && @imagetypes() & IMG_JPG )
    		{
    			if( !$image_source = @imagecreatefromjpeg( $image_dir ) )
    			{
    				$error_image_import = true;
    			}
    		}
    		elseif( $file_info['file_type'] == "BMP" && @imagetypes() & IMG_WBMP )
    		{
    			if( !$image_source = @imagecreatefromwbmp( $image_dir ) )
    			{
    				$error_image_import = true;
    			}
    		}
    		else
    		{
    			$kernel->page_function->message_report( $kernel->ld['lang_b_image_type_not_supported'], M_ERROR, HALT_EXEC );
    		}
    		
    		//create thumbnail canvas at rescaled dimensions
    		if( function_exists( "imagecreatetruecolor" ) )
    		{
    			if( !$image_thumb = @imagecreatetruecolor( $new_width, $new_height ) )
    			{
    				$error_image_create = true;
    			}
    		}
    		elseif( function_exists( "imagecreate" ) )
    		{
    			if( !$image_thumb = @imagecreate( $new_width, $new_height ) )
    			{
    				$error_image_create = true;
    			}
    		}
    		
    		//copy, size down original to thumbnail canvas
    		if( function_exists( "imagecopyresampled" ) )
    		{
    			if( !@imagecopyresampled( $image_thumb, $image_source, 0, 0, 0, 0, $new_width, $new_height, $image_dimensions[0], $image_dimensions[1] ) )
    			{
    				$error_image_copy = true;
    			}
    		}
    		elseif( function_exists( "imagecopyresized" ) )
    		{
    			if( !@imagecopyresized( $image_thumb, $image_source, 0, 0, 0, 0, $new_width, $new_height, $image_dimensions[0], $image_dimensions[1] ) )
    			{
    				$error_image_copy = true;
    			}
    		}
    		
    		$colour_black = @imagecolorallocate( $image_thumb, 0, 0, 0 );
    		$colour_white = @imagecolorallocate( $image_thumb, 255, 255, 255 );
    		
  			//phcdl watermark copyright notice with shadow - purchase copyright removal rights to remove this.
    		@imagestring( $image_thumb, 1, $new_width - 29, $new_height - 13, "PHCDL", $colour_black );
    		@imagestring( $image_thumb, 1, $new_width - 30, $new_height - 14, "PHCDL", $colour_white );
				//----------------------------------------------------------------------------------------------
    		
    		//finish off, and save locally
    		if( $file_info['file_type'] == "GIF" && @imagetypes() & IMG_GIF )
    		{
    			if( !@imagegif( $image_thumb, $image_thumb_dir ) )
    			{
    				$error_image_write = true;
    			}
    		}
    		elseif( $file_info['file_type'] == "PNG" && @imagetypes() & IMG_PNG )
    		{
    			if( !@imagepng( $image_thumb, $image_thumb_dir ) )
    			{
    				$error_image_write = true;
    			}
    		}
    		elseif( $file_info['file_type'] == "JPEG" && @imagetypes() & IMG_JPG || $file_info['file_type'] == "JPG" && @imagetypes() & IMG_JPG )
    		{
    			if( !@imagejpeg( $image_thumb, $image_thumb_dir ) )
    			{
    				$error_image_write = true;
    			}
    		}
    		elseif( $file_info['file_type'] == "BMP" && @imagetypes() & IMG_WBMP )
    		{
    			if( !@imagewbmp( $image_thumb, $image_thumb_dir ) )
    			{
    				$error_image_write = true;
    			}
    		}
    	}
    	
    	//error checking
    	if( $error_image_import )
    	{
    		$kernel->page_function->message_report( $kernel->ld['lang_b_could_not_open_source'], M_ERROR, HALT_EXEC );
    	}
    	elseif( $error_image_create )
    	{
    		$kernel->page_function->message_report( $kernel->ld['lang_b_could_not_create_thumbnail_canvas'], M_ERROR, HALT_EXEC );
    	}
    	elseif( $error_image_copy )
    	{
    		$kernel->page_function->message_report( $kernel->ld['lang_b_could_not_copy_rescaled_image_to_thumbnail'], M_ERROR, HALT_EXEC );
    	}
    	elseif( $error_image_write )
    	{
    		$kernel->page_function->message_report( $kernel->ld['lang_b_could_not_save_thumbnail'], M_ERROR, HALT_EXEC );
    	}
    	else
    	{
    		return true;
    	}
  	}
  	else
  	{
  		return true;
  	}
	}
	
	/*
	 * Generates the secuirty image based on the provided code.
	 **/
	
	function construct_security_code_image( &$verify )
	{
		$image_original_width = ( ( ( strlen( $verify['verify_key'] ) * 6 ) + 6 ) + strlen( $verify['verify_key'] ) );
		$image_finish_width = $image_original_width * 3;
		$image_vert_line_count = ( $image_finish_width - 28 ) / 10;
		
		$image_original = imagecreate( $image_original_width, 18 );
		$image_finish = imagecreate( $image_finish_width, 54 );
		
		$colour_black = imagecolorallocate( $image_original, 0, 0, 0 );
		$colour_white = imagecolorallocate( $image_original, 255, 255, 255 );
		
		$colour_line_black = imagecolorallocate( $image_original, 0, 0, 0 );
		
		imagefill( $image_original, 0, 0, $colour_white );
		
		$char_hori_padding = 3;
		
		//char - random vertical padding
		for( $char = 0; $char < strlen( $verify['verify_key'] ); $char++ )
		{
			$char_vert_spacing = rand( 0, 4 );
			imagestring( $image_original, 3, $char_hori_padding, $char_vert_spacing, $verify['verify_key']{ $char }, $colour_black );
			
			$char_hori_padding += 7;
		}
		
		imagecopyresized( $image_finish, $image_original, 0, 0, 0, 0, $image_finish_width, 54, $image_original_width, 18 );
		
		$last_used[0] = 0;
		
		//horizontal random point "distort" lines
		for( $line = 0; $line < 10; $line++ )
		{
			$y_axis = 0;
			
			while( isset( $last_used[ $y_axis ] ) )
			{
				$y_axis = rand( 15, 39 );
			}
			
			$last_used[ $y_axis ] = $y_axis;
			
			imageline( $image_finish, 0, $y_axis, $image_finish_width, $y_axis, $colour_line_black );
		}
		
		//vertical fixed grid lines
		for( $line = 0; $line < $image_vert_line_count; $line++ )
		{
			$x_axis = 10 * ( $line + 1 ) + 5;
			
			imageline( $image_finish, $x_axis, 0, $x_axis, 54, $colour_line_black );
		}
		
		imagejpeg( $image_finish );
	}
}

?>