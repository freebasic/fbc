<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->clean_array( "_REQUEST", array( "action" => V_STR, "menucfg" => V_STR ) );

$check_menu_config = $kernel->db->query( "SELECT `datastore_value` FROM " . TABLE_PREFIX . "datastore WHERE `datastore_key` = 'menu_config_user:" . $kernel->session['adminsession_user_id'] . "'" );

//load in user config or default config
if( $kernel->db->numrows( $check_menu_config ) > 0 )
{
	define( "MCFG_EXISTS", true );
	
	$kernel->vars['open_menu_nodes'] = $kernel->db->item( "SELECT `datastore_value` FROM " . TABLE_PREFIX . "datastore WHERE `datastore_key` = 'menu_config_user:" . $kernel->session['adminsession_user_id'] . "'" );
}
else
{
	$kernel->vars['open_menu_nodes'] = $kernel->config['default_menu_config'];
}

//update menu config
if( $kernel->vars['action'] == "update" )
{
	if( defined( "MCFG_EXISTS" ) )
	{
		$kernel->db->update( "datastore", array( "datastore_value" => $kernel->vars['menucfg'], "datastore_timestamp" => UNIX_TIME ), "WHERE `datastore_key` = 'menu_config_user:" . $kernel->session['adminsession_user_id'] . "'" );
	}
	else
	{
		$kernel->db->insert( "datastore", array( "datastore_key" => "menu_config_user:" . $kernel->session['adminsession_user_id'], "datastore_value" => $kernel->vars['menucfg'], "datastore_timestamp" => UNIX_TIME ) );
	}
	
	$kernel->vars['open_menu_nodes'] = $kernel->vars['menucfg'];
}

//show menu
$kernel->tp->call( "admin_menu" );

?>

