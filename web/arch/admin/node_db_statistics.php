<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->admin_function->read_permission_flags( 0 );

switch( $kernel->vars['action'] )
{
	#############################################################################
	
	default :
	{
		$kernel->tp->call( "admin_db_statistics_header" );
		
		$get_statistics = $kernel->db->query( "SELECT `datastore_key`, `datastore_value` FROM `" . TABLE_PREFIX . "datastore`" );
		
		while( $statistic = $kernel->db->data( $get_statistics ) )
		{
			if( strstr( $statistic['datastore_key'], "count_total_" ) == false ) continue;
			
			$datastore[ $statistic['datastore_key'] ] = $statistic['datastore_value'];
		}
		@ksort( $datastore );
		
		foreach( $datastore AS $stat['count_name'] => $stat['count_total'] )
		{
			$kernel->tp->call( "admin_db_statistics_row" );
			
			if( $stat['count_name'] == "count_total_data" )
			{
				$stat['count_total'] = $kernel->archive_function->format_round_bytes( $stat['count_total'] ) . " <i>{$kernel->ld['lang_b_approximately']}</i>";
			}
			else
			{
				$stat['count_total'] = $kernel->format_input( $stat['count_total'], T_NUM );
			}
			
			$stat['count_name'] = $kernel->ld[ 'lang_b_' . substr( $stat['count_name'], 6, strlen( $stat['count_name'] ) - 1 ) ];
			
			$kernel->tp->cache( $stat );
		}
		
		$kernel->tp->call( "admin_db_statistics_footer" );
		
		break;
	}
}

?>

