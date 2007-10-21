<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

###############################################################################
###############################################################################
# DO NOT USE THIS NODE, IT HAS NOT BEEN COMPLETED - THE INFO IS AVAILABLE ON THE CONTROL PANEL HOME
###############################################################################
###############################################################################

$kernel->admin_function->read_permission_flags( 23 );

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	default :
	{
		$dir_count = $file_count = $size = $depth = 0;
		
    function construct_directory_layout( $directory, $name = "", $depth = 0 )
    {
    	global $kernel, $depth;
    	
			$current_directory = $directory . DIR_STEP . $name;
			
    	$handle = opendir( $current_directory );
			
			$item_count = $file_count = $dir_count = $size = 0;
    	
    	while( ( $item = @readdir( $handle ) ) !== false )
    	{
    		if( $item == "." OR $item == ".." ) continue;
				
				if( $item_count == 0 )
				{
					//$kernel->tp->call( "admin_directory_row_break" );
					
					$kernel->tp->call( "admin_directory_row" );
					
      		$dirdata = array(
    				"total_files" => $file_count,
    				"total_directories" => $dir_count,
    				"directory_name" => $name,
						"directory_path" => $current_directory,
  					//"directory_depth_padding" => ( $depth * 40 )
    			);
      		
      		$kernel->tp->cache( $dirdata );
				}
    		
  			if( @chdir( $current_directory . DIR_STEP . $item ) )
  			{
					construct_directory_layout( $current_directory, $item, $depth++ );
  				$dir_count++;
  			}
      	else
    		{
					$size += @filesize( $current_directory . DIR_STEP . $item );
      		$file_count++;
    		}
				
				$item_count++;
    	}
			
			$depth--;
    }
		
		###########################################################################
		
		$directory = $kernel->config['system_root_dir_upload'];
		
  	$handle = opendir( $directory );
  	
  	$item_count = $file_count = $dir_count = $size = 0;
		$depth = 1;
		
		$kernel->tp->call( "admin_directory_header" );
    	
  	while( ( $item = @readdir( $handle ) ) !== false )
  	{
  		if( $item == "." OR $item == ".." ) continue;
			
			if( $item_count == 0 )
			{
				$row = "<ul>";
				
				$kernel->tp->call( "admin_directory_row" );
				
    		$dirdata = array(
  				"total_files" => $file_count,
  				"total_directories" => $dir_count,
  				"directory_name" => "",
  				"directory_path" => $directory . DIR_STEP,
					//"directory_depth_padding" => ( $depth * 40 )
  			);
    		
    		$kernel->tp->cache( $dirdata );
				
				$row .= "</ul>";
			}
  		
			if( @chdir( $directory . DIR_STEP . $item ) )
			{
				construct_directory_layout( $directory, $item, $depth++ );
				$dir_count++;
			}
    	else
  		{
				$size += @filesize( $directory . DIR_STEP . $item );
    		$file_count++;
  		}
  		
  		$item_count++;
    }
		
		$kernel->tp->call( "admin_directory_footer" );
			
		break;
	}
}

?>

