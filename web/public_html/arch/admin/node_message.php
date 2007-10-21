<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

if( !defined( "IN_ACP" ) ) die( "Node can not be accessed directly" );

$kernel->clean_array( "_REQUEST", array( "referer_node" => V_STR, "referer_url" => V_STR, "redirect_seconds" => V_INT, "screen_data" => V_STR ) );

if( $kernel->config['admin_message_page_forward_mode'] == "0" )
{
	if( $kernel->config['admin_message_redirect_mode'] == 0 )
	{
		header( "Location: index.php?hash=" . $kernel->session['hash'] . "&amp;node=" . $kernel->vars['referer_node'] );
	}
	else
	{
		header( "Location: " . $kernel->format_input( $kernel->vars['referer_url'], T_URL_DEC ) . "" );
	}
}
else
{
	$messagedata = array(
		"message_subject" => $kernel->format_input( $kernel->vars['screen_data'], T_URL_DEC ),
		"message_redirect_seconds" => $kernel->vars['redirect_seconds'],
		"message_referer" => $kernel->vars['referer_url'],
		"message_node" => $page_array[ $kernel->vars['referer_node'] ],
		"message_linkback" => "index.php?hash=" . $kernel->session['hash'] . "&amp;node=" . $kernel->vars['referer_node']
	);
	
	if( $kernel->config['admin_message_redirect_mode'] == 0 )
	{
		$messagedata['message_selected_linkback'] = "index.php?hash=" . $kernel->session['hash'] . "&amp;node=" . $kernel->vars['referer_node'];
	}
	else
	{
		$messagedata['message_selected_linkback'] = $kernel->format_input( $kernel->vars['referer_url'], T_URL_DEC );
	}
	
	$kernel->ld['lang_b_report_redirect_message'] = sprintf( $kernel->ld['lang_b_report_redirect_message'], $node_array[ $kernel->vars['referer_node'] ], $kernel->vars['redirect_seconds'] );
	$kernel->ld['lang_b_report_return_node'] = sprintf( $kernel->ld['lang_b_report_return_node'], $node_array[ $kernel->vars['referer_node'] ] );
	
	$kernel->tp->call( "admin_message" );
	
	$kernel->tp->cache( $messagedata );
}

?>

