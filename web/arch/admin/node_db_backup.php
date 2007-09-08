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

switch ( $kernel->vars['action'] )
{
	
	#############################################################################
	
	case "write" :
	{
		if( IN_DEMO_MODE == true )
		{
			$kernel->page_function->message_report( "Feature disabled in Demo Mode.", M_ERROR, HALT_EXEC );
		}
		
		//Number of tables in this PHCDL build. Affects naming convensions..
		$build_db_total = 28;
		$table_count = 0;
		$total_query_count = 0;
		
		if( sizeof( $_POST['table'] ) == 0 )
		{
			$kernel->page_function->message_report( $kernel->ld['lang_b_select_tables_notice'], M_ERROR );
		}
		else
		{
			$file_date = date( "Y-m-d H:i:s" );
			
			//Naming convensions..like you really care what its called anyways :p
			if( $_POST['export_structure'] == "1" )
			{
				if( empty( $_POST['export_data'] ) )
				{
  				$file = "structure_";
				}
			}
			else
			{
				$file = "data_";
			}
			
			$file .= ( sizeof( $_POST['table'] ) == 1 ) ? "backup_{$_POST['table'][0]}" : "backup";
			
			if( sizeof( $_POST['table'] ) == $build_db_total )
			{
				$file .= "_all";
			}
			
			$file .= "_" . date( "Y-m-d" );
			
			if( $_POST['export_data'] == "1" )
			{
  			switch( $_POST['mode'] )
  			{
  				case "INSERT" :		$file .= "_insert"; break;
  				case "UPDATE" :		$file .= "_update"; break;
  				case "REPLACE" :	$file .= "_replace"; break;
  			}
			}
			
			//Page headers
			header( "Content-Type: text/x-delimtext; name=\"" . $file . ".sql\"; charset=\"UTF-8\"" );
			header( "Content-disposition: attachment; filename=" . $file . ".sql" );
			
			//Used for schema build purposes. DO NOT USE.
			//$export_null_primary_key = 1;
      
			//Formats the schema for use with PHP scripts.
			//$export_parse_friendly = 1;
			
			//header table list
			foreach( $_POST['table'] AS $item )
			{
				$table_list .= "{$item}; ";
			}
			$table_list = preg_replace( "/; $/", "", $table_list );
			@reset( $_POST['table'] );
			
			//output schema header
			printf( "%'#-68s\r\n", "" );
			print "# Exported by: PHCDownload {$kernel->config['short_version']}\r\n# Compiled On: {$file_date}\r\n# Tables Exported: {$table_list}";
			printf( "\r\n%'#-68s\r\n", "" );
			
			//output table data
			while( list(, $tablename ) = each( $_POST['table'] ) )
			{
				//structure
				if( $_POST['export_structure'] == "1" )
				{
					$table_structure = $kernel->db->data( "SHOW CREATE TABLE `{$tablename}`" );
					
					printf( "\r\n\r\n%'#-68s\r\n", "" );
					print "# {$tablename} Table Structure";
					printf( "\r\n%'#-68s\r\n\r\n", "" );
					
					if( $export_parse_friendly == 1 )
					{
						$base_table_name = substr( $tablename, strlen( $kernel->config['db_table_prefix'] ), strlen( $tablename ) - 1 );
						
						$structure = str_replace( $tablename, "\" . TABLE_PREFIX . \"" . $base_table_name . "", $table_structure['Create Table'] );
						
						$structure = preg_replace( "/AUTO_INCREMENT=[0-9]{1,10}/i", "", $structure );
						
						print "\$TABLE['{$base_table_name}'] = \"{$structure};\";\r\n";
					}
					else
					{
						print "{$table_structure['Create Table']};\r\n";
					}
				}
				
				//data rows
				if( $_POST['export_data'] == "1" )
				{
					//tables we don't want
					if( $tablename == TABLE_PREFIX . "sessions" ) continue;
					
					$query_count = 1;
					
					printf( "\r\n\r\n%'#-68s\r\n", "" );
					print "# {$tablename} Table Data";
					printf( "\r\n%'#-68s\r\n\r\n", "" );
					
					$get_data = $kernel->db->query( "SELECT * FROM `{$tablename}`" );
					
					//primary keys
					$tablefield = array (
						TABLE_PREFIX . "announcements" => "announcement_id",
						TABLE_PREFIX . "categories" => "category_id",
						TABLE_PREFIX . "comments" => "comment_id",
						TABLE_PREFIX . "datastore" => "datastore_id",
						TABLE_PREFIX . "documents" => "document_id",
						TABLE_PREFIX . "fields" => "field_id",
						TABLE_PREFIX . "fields_data" => "field_id",
						TABLE_PREFIX . "files" => "file_id",
						TABLE_PREFIX . "galleries" => "gallery_id",
						TABLE_PREFIX . "images" => "image_id",
						TABLE_PREFIX . "logs" => "log_id",
						TABLE_PREFIX . "logs_admin" => "log_id",
						TABLE_PREFIX . "mirrors" => "mirror_id",
						TABLE_PREFIX . "session_cache" => "cache_id",
						TABLE_PREFIX . "sessions" => "session_id",
						TABLE_PREFIX . "sessions_admin" => "adminsession_id",
						TABLE_PREFIX . "sites" => "site_id",
						TABLE_PREFIX . "styles" => "style_id",
						TABLE_PREFIX . "submissions" => "submission_id",
						TABLE_PREFIX . "templates" => "template_id",
						TABLE_PREFIX . "templates_admin" => "template_id",
						TABLE_PREFIX . "templates_email" => "template_id",
						TABLE_PREFIX . "themes" => "theme_id",
						TABLE_PREFIX . "users" => "user_id",
						TABLE_PREFIX . "users_activate" => "activate_id",
						TABLE_PREFIX . "users_verify" => "user_id",
						TABLE_PREFIX . "usergroups" => "verify_id",
						TABLE_PREFIX . "votes" => "vote_id"
					);
					
					$tablefield_keys = array_flip( $tablefield );
					
					while( $tabledata = $kernel->db->data( $get_data ) )
					{
						//==============================
						// Open Query
						//==============================
						
						if( $_POST['mode'] == "INSERT" AND $export_parse_friendly == 1 )
						{
							print "\$SQL[" . $table_count . "][" . $total_query_count . "] = \"INSERT INTO `\" . TABLE_PREFIX . \"" . substr( $tablename, strlen( $kernel->config['db_table_prefix'] ), strlen( $tablename ) - 1 ) . "` VALUES ( ";
							
							if( $total_query_count >= 50 )
							{
								$table_count++;
								$total_query_count = 0;
							}
						}
						elseif( $_POST['mode'] == "INSERT" AND !isset( $export_parse_friendly ) )
						{
							print "INSERT INTO `{$tablename}` VALUES ( ";
						}
						elseif( $_POST['mode'] == "UPDATE" )
						{
							print "UPDATE `{$tablename}` SET ";
						}
						elseif( $_POST['mode'] == "REPLACE" )
						{
							print "REPLACE INTO `{$tablename}` VALUES ( ";
						}
						
						$row = "";
						
						//==============================
						// Query data
						//==============================
						
						foreach( $tabledata AS $key => $value )
						{
							if( $export_parse_friendly == 1 )
							{
								$value = $kernel->db->escape_string( $value );
								$value = str_replace( chr( 36 ), "\\" . chr( 36 ), $value );
								$value = str_replace( "\\'", "''", $value );
							}
							else
							{
								$value = str_replace( chr( 10 ), "\\n", $value );
								$value = str_replace( chr( 13 ), "\\r", $value );
								//$value = str_replace( "\\'", "''", $value );
								$value = str_replace( "'", "''", $value );
							}
							
							if( $_POST['mode'] == "INSERT" )
							{
								if( $export_null_primary_key == 1 AND isset( $tablefield_keys[ $key ] ) )
								{
									$row .= "NULL, ";
								}
								elseif( $export_parse_friendly == 1 AND isset( $tablefield_keys[ $key ] ) )
								{
									$row .= "" . $query_count . ", ";
								}
								else
								{
									if( intval( $value ) <> 0 AND strlen( intval( $value ) ) === strlen( $value ) )
									{
										$row .= "{$value}, ";
									}
									else
									{
										$row .= "'{$value}', ";
									}
								}
							}
							elseif( $_POST['mode'] == "REPLACE" )
							{
								if( intval( $value ) <> 0 AND strlen( intval( $value ) ) === strlen( $value ) )
								{
									$row .= "{$value}, ";
								}
								else
								{
									$row .= "'{$value}', ";
								}
							}
							elseif( $_POST['mode'] == "UPDATE" )
							{
								if( intval( $value ) <> 0 AND strlen( intval( $value ) ) === strlen( $value ) )
								{
									$row .= "`{$key}` = {$value}, ";
								}
								else
								{
									$row .= "`{$key}` = '{$value}', ";
								}
							}
						}
						
						//==============================
						// Close Query
						//==============================
										
						$row = preg_replace( "/, $/", "", $row );
						
						if( $_POST['mode'] == "INSERT" AND $export_parse_friendly == 1 )
						{
							$row = "{$row} );\";\r\n";
						}
						elseif( $_POST['mode'] == "INSERT"  AND !isset( $export_parse_friendly ) OR $_POST['mode'] == "REPLACE" )
						{
							$row = "{$row} );\r\n";
						}
						elseif( $_POST['mode'] == "UPDATE" )
						{
							$row = "{$row}	WHERE `{$tablefield[ $tablename ]}` = '{$tabledata[ $tablefield[ $tablename ] ]}';\r\n";
						}
						
						print $row;
						
						flush();
						ob_flush();
						
						$query_count++;
						$total_query_count++;
					}
					
					unset( $table_structure, $tabledata );
				}
			}
			
			//Stop output
			exit;
		}
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		$kernel->tp->call( "admin_backup" );
		
		$tablefield = array (
			TABLE_PREFIX . "announcements" => 0,
			TABLE_PREFIX . "categories" => 0,
			TABLE_PREFIX . "comments" => 0,
			TABLE_PREFIX . "datastore" => 0,
			TABLE_PREFIX . "documents" => 0,
			TABLE_PREFIX . "fields" => 0,
			TABLE_PREFIX . "fields_data" => 0,
			TABLE_PREFIX . "files" => 0,
			TABLE_PREFIX . "galleries" => 0,
			TABLE_PREFIX . "images" => 0,
			TABLE_PREFIX . "logs" => 0,
			TABLE_PREFIX . "logs_admin" => 0,
			TABLE_PREFIX . "mirrors" => 0,
			TABLE_PREFIX . "session_cache" => 0,
			TABLE_PREFIX . "sessions" => 0,
			TABLE_PREFIX . "sessions_admin" => 0,
			TABLE_PREFIX . "sites" => 0,
			TABLE_PREFIX . "styles" => 0,
			TABLE_PREFIX . "submissions" => 0,
			TABLE_PREFIX . "templates" => 0,
			TABLE_PREFIX . "templates_admin" => 0,
			TABLE_PREFIX . "themes" => 0,
			TABLE_PREFIX . "usergroups" => 0,
			TABLE_PREFIX . "users" => 0,
			TABLE_PREFIX . "users_activate" => 0,
			TABLE_PREFIX . "users_verify" => 0,
			TABLE_PREFIX . "votes" => 0
		);
		
		$table_list = "";
		
		$kernel->db->query( "SHOW TABLE STATUS" );
		
		while( $tableinfo = $kernel->db->data() )
		{
			$tablefield[ $tableinfo['Name'] ] = $kernel->archive_function->format_round_bytes( ( $tableinfo['Data_length'] + $tableinfo['Index_length'] ) );
		}
		
		$kernel->vars['html']['table_list_options'] = "";
		
		$get_tables = $kernel->db->query( "SHOW TABLES" );
		
		while( $tabledata = $kernel->db->data( $get_tables ) )
		{
			foreach( $tabledata AS $key => $value )
			{
 				if( isset( $tablefield[ "$value" ] ) )
				{
					$kernel->vars['html']['table_list_options'] .= "<option value=\"" . $value . "\">" . $value . " (" . $tablefield[ "$value" ] . ")</option>";
				}
			}
		}
	}
}

?>

