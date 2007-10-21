<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

define( "F_TEXT",			0 );
define( "F_TAREA",		1 );
define( "F_SELECT",		2 );
define( "F_RADIO",		3 );

class class_form_construct
{
	var $table_open = false;
	
	/*
	 * Construct and add a form field to the table
	 **/
	
	function add_field( $field_type = F_TEXT, $config_key, $phrase, $custom_data = false, $is_disabled = false )
	{
		global $kernel;
		
		$element = array(
			"size" => 50,
			"columns" => 60,
			"rows" => 8,
			"value" => "",
			"radio_mode" => 0,
			"select_size" => 1,
			"select_multi" => false
		);
		
		if( is_array( $custom_data ) )
		{
			foreach( $custom_data AS $arg => $value )
			{
				$element[ "$arg" ] = $value;
			}
		}
		
		$disabled_html = ( $is_disabled == true OR $kernel->session['adminsession_group_id'] != 1 ) ? " disabled=\"true\"" : "";
		
		$mutliple_html = ( $element['select_multi'] == true ) ? " multiple=\"true\"" : "";
		
		$field_value = ( !empty( $element['value'] ) ) ? $kernel->format_input( $element['value'], T_FORM ) : $kernel->format_input( $kernel->config[ "$config_key" ], T_FORM );
		
		// Start field row
		$html = "<tr><td class=\"subheader\"><strong>" . $kernel->ld[ "$phrase" ] . "</strong>&nbsp;" . $kernel->ld[ $phrase . "_desc" ] . "</td></tr>\r\n<tr><td class=\"row\">";
		
		/*
		 * Single line text box
		 **/
		
		if( $field_type == F_TEXT )
		{
			$html .= "<input type=\"text\" name=\"" . $config_key . "\" value=\"" . $field_value . "\" size=\"" . $element['size'] . "\"" . $disabled_html . ">";
		}
		
		/*
		 * Multiline text box
		 **/
		
		if( $field_type == F_TAREA )
		{
			$html .= "<textarea cols=\"" . $element['columns'] . "\" rows=\"" . $element['rows'] . "\" name=\"" . $config_key . "\"" . $disabled_html . ">" . $field_value . "</textarea>";
		}
		
		/*
		 * Drop menu selector. Options should to be built with construct_config_options() under the page_function class, or have the var set manually with the config name and "_list_options" suffix.
		 **/
		
		if( $field_type == F_SELECT )
		{
			$html .= "<select name=\"" . $config_key . "\" size=\"" . $element['select_size'] . "\"" . $multiple_html . "" . $disabled_html . ">" . $kernel->vars['html'][ $config_key . "_list_options" ] . "</select>";
		}
		
		/*
		 * Choice selector, (true/false or 1/0)
		 **/
		
		if( $field_type == F_RADIO )
		{
  		$phrase_state_true = ( $element['radio_mode'] == 0 ) ? "lang_b_yes" : "lang_b_enabled";
  		$phrase_state_false = ( $element['radio_mode'] == 0 ) ? "lang_b_no" : "lang_b_disabled";
  		
  		$value_state_true = ( $element['radio_mode'] == 0 ) ? 1 : "true";
  		$value_state_false = ( $element['radio_mode'] == 0 ) ? 0 : "false";
  		
  		if( $value_state_true == $kernel->config[ "$config_key" ] )
  		{
  			$checked_state_true = " checked=\"checked\"";
  		}
			
  		if( $value_state_false == $kernel->config[ "$config_key" ] )
  		{
  			$checked_state_false = " checked=\"checked\"";
  		}
			
			$html .= "<label for=\"" . $config_key . "_true\"" . $disabled_html . ">" . $kernel->ld[ "$phrase_state_true" ] . "&nbsp;&nbsp;</label><input type=\"radio\" name=\"" . $config_key . "\" id=\"" . $config_key . "_true\" value=\"" . $value_state_true . "\"" . $checked_state_true . "" . $disabled_html . ">&nbsp;";
			
			$html .= "&nbsp;<input type=\"radio\" name=\"" . $config_key . "\" id=\"" . $config_key . "_false\" value=\"" . $value_state_false . "\"" . $checked_state_false . "" . $disabled_html . "><label for=\"" . $config_key . "_false\"" . $disabled_html . ">&nbsp;&nbsp;" . $kernel->ld[ "$phrase_state_false" ] . "</label>";
		}
		
		// Finish field row
		$html .= "</td></tr>\r\n";
		
		$kernel->tp->call( $html, CALL_STRING );
	}
	
	/*
	 * Construct a new settings table, close any open tables in the process
	 **/
	
	function construct_table( $phrase )
	{
		global $kernel;
		
		if( $this->table_open == false )
		{
			$html = "\r\n<form method=\"post\" action=\"?hash=" . $kernel->session['hash'] . "&node=settings&setting=" . $kernel->vars['setting'] . "&action=write\">";
			
			$this->table_open = true;
		}
		else
		{
			$html = "</table>\r\n";
		}
		
		$html .= "\r\n<table width=\"100%\" class=\"table\" cellspacing=\"1\"><tr><td class=\"header\"><strong>" . $kernel->ld[ "$phrase" ] . "</strong></td></tr>";
		
		$kernel->tp->call( $html, CALL_STRING );
	}
	
	/*
	 * Close table and add form submit line
	 **/
	
	function finish()
	{
		global $kernel;
		
		$kernel->tp->call( "</table>\r\n<div id=\"buttons\"><input type=\"reset\" name=\"reset\" onclick=\"window.location='?hash=" . $kernel->session['hash'] . "&node=panel'\" value=\"" . $kernel->ld['lang_b_button_cancel'] . "\"><input type=\"submit\" name=\"form\" value=\"" . $kernel->ld['lang_b_button_update_settings'] . "\"></div></form>\r\n", CALL_STRING );
	}
}

?>