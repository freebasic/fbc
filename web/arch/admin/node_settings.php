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

require_once( ROOT_PATH . "include/function_class_form_construct.php" );
$kernel->form_function = new class_form_construct;

$kernel->clean_array( "_REQUEST", array( "setting" => V_STR, "setting_id" => V_INT ) );

switch ( $kernel->vars['action'] )
{
	#############################################################################
	
	case "write" :
	{
		if( isset( $_POST['control_panel_session_timeout'] ) AND $_POST['control_panel_session_timeout'] < 60 ) $_POST['control_panel_session_timeout'] = 60;
		
		if( isset( $_POST['GD_CHAR_LENGTH'] ) AND $_POST['GD_CHAR_LENGTH'] < 1 ) $_POST['GD_CHAR_LENGTH'] = 1;
		if( isset( $_POST['GD_CHAR_LENGTH'] ) AND $_POST['GD_CHAR_LENGTH'] > 32 ) $_POST['GD_CHAR_LENGTH'] = 32;
		
		$kernel->admin_function->write_config_ini();
		
		break;
	}
	
	#############################################################################
	
	default :
	{
		if( !empty( $kernel->vars['setting'] ) )
		{
			$kernel->tp->call( "admin_sett_menu_sized" );
		}
		else
		{
			$kernel->tp->call( "admin_sett_menu" );
		}
		
		$items = 0;
		$setting_note = array();
		$kernel->vars['html']['setting_list_options'] = "";
    $kernel->vars['setting_menu'][ $kernel->vars['setting'] ] = "selected=\"selected\"";
		
		//archive
		$setting_node[] = array(
			$kernel->ld['lang_b_archive'], array(
				$kernel->ld['lang_b_menu_archive_settings'] => "archive",
				$kernel->ld['lang_b_menu_file_settings'] => "file",
				$kernel->ld['lang_b_menu_category_settings'] => "category",
				$kernel->ld['lang_b_menu_user_settings'] => "user"
			)
		);
		
		//control panel
		$setting_node[] = array(
			$kernel->ld['lang_b_node_control_panel'], array(
				$kernel->ld['lang_b_menu_control_panel_settings'] => "control"
			)
		);
		
		//system
		$setting_node[] = array(
			$kernel->ld['lang_b_menu_title_system'], array(
				$kernel->ld['lang_b_menu_system_settings'] => "system",
				$kernel->ld['lang_b_menu_smtp_email_settings'] => "mail"
			)
		);
		
		//build the menu options
		foreach( $setting_node AS $group )
		{
			$kernel->vars['html']['setting_list_options'] .= "<optgroup label=\"" . $group[0] . "\">\r\n";
			
			foreach( $group[1] AS $node => $node_id )
			{
				$kernel->vars['html']['setting_list_options'] .= "<option value=\"" . $node_id . "\"" . $kernel->vars['setting_menu'][ "$node_id" ] . ">" . $node . "</option>\r\n";
				$items++;
			}
			
			$kernel->vars['html']['setting_list_options'] .= "</optgroup>\r\n";
			$items++;
		}
		
		$kernel->vars['html']['setting_list_total_items'] += $items;
		
		switch( $kernel->vars['setting'] )
		{
			#########################################################################
			
			case "archive" :
			{
				$sort_fields = array(
    			"file_id" => "file_id",
    			"file_name" => "file_name",
    			"file_description" => "file_description",
    			"file_timestamp" => "file_timestamp",
    			"file_mark_timestamp" => "file_mark_timestamp",
    			"file_size" => "file_size",
    			"file_ranking" => "file_ranking",
    			"file_author" => "file_author",
    			"file_downloads" => "file_downloads"
    		);
				
				$kernel->archive_function->construct_list_options( $kernel->config['default_skin'], "default_skin", $kernel->db->query( "SELECT t.theme_id, t.theme_name FROM " . TABLE_PREFIX . "themes t ORDER BY t.theme_name" ), false );
				$kernel->archive_function->construct_list_options( $kernel->config['default_style'], "default_style", $kernel->db->query( "SELECT s.style_id, s.style_name FROM " . TABLE_PREFIX . "styles s ORDER BY s.style_name" ), false );
				
				$kernel->admin_function->read_directory_index( "default_language", $kernel->config['default_language'], false, ROOT_PATH . DIR_STEP . "lang" . DIR_STEP, LIST_DIR );
				
				$kernel->page_function->construct_config_options( "display_default_limit", $kernel->array_set( array_flip( explode( ",", $kernel->config['display_limit_options'] ) ), explode( ",", $kernel->config['display_limit_options'] ) ) );
				$kernel->page_function->construct_config_options( "archive_search_mode", array( $kernel->ld['lang_b_menu_fulltext'] => 0, $kernel->ld['lang_b_menu_fulltext_boolean'] => 1 ) );
				$kernel->page_function->construct_config_options( "display_default_sort", $sort_fields );
				$kernel->page_function->construct_config_options( "display_default_order", array( $kernel->ld['lang_b_menu_ascending'] => "asc", $kernel->ld['lang_b_menu_descending'] => "desc" ) );
				
				$kernel->form_function->construct_table( "lang_b_title_archive_display_configuration" );
				$kernel->form_function->add_field( F_TEXT, "archive_name", "lang_b_archive_title" );
				$kernel->form_function->add_field( F_SELECT, "default_skin", "lang_b_template_set" );
				$kernel->form_function->add_field( F_SELECT, "default_style", "lang_b_style_set" );
				$kernel->form_function->add_field( F_SELECT, "default_language", "lang_b_language_set" );
				$kernel->form_function->add_field( F_RADIO, "archive_offline", "lang_b_archive_status" );
				$kernel->form_function->add_field( F_TAREA, "archive_offline_message", "lang_b_archive_status_message" );
				
				$kernel->form_function->construct_table( "lang_b_title_search_configuration" );
				$kernel->form_function->add_field( F_SELECT, "archive_search_mode", "lang_b_search_mode" );
				
				$kernel->form_function->construct_table( "lang_b_title_archive_content_configuration" );
				$kernel->form_function->add_field( F_TEXT, "string_max_words", "lang_b_announcement_preview_length" );
				$kernel->form_function->add_field( F_TEXT, "archive_max_comment_on_page", "lang_b_comments_on_file_view" );
				$kernel->form_function->add_field( F_TEXT, "image_max_row_thumbnails", "lang_b_gallery_images_per_row" );
				$kernel->form_function->add_field( F_TAREA, "archive_meta_keywords", "lang_b_archive_meta_keywords", array( "rows" => 4 ) );
				$kernel->form_function->add_field( F_TAREA, "archive_meta_description", "lang_b_archive_meta_description", array( "rows" => 4 ) );
				
				$kernel->form_function->construct_table( "lang_b_title_pagination_configuration" );
				$kernel->form_function->add_field( F_TEXT, "archive_pagination_page_proximity", "lang_b_page_pagination" );
				$kernel->form_function->add_field( F_TEXT, "display_limit_options", "lang_b_result_per_page" );
				$kernel->form_function->add_field( F_SELECT, "display_default_limit", "lang_b_default_per_page_option" );
				$kernel->form_function->add_field( F_SELECT, "display_default_sort", "lang_b_page_sort_by_list" );
				$kernel->form_function->add_field( F_SELECT, "display_default_order", "lang_b_page_order_by_list" );
				
				$kernel->form_function->finish();
				
				break;
			}
			
			#########################################################################
			
			case "category" :
			{
				$kernel->page_function->construct_config_options( "category_file_count_mode", array( $kernel->ld['lang_b_menu_root_category'] => 0, $kernel->ld['lang_b_menu_root_category_subcategories'] => 1, $kernel->ld['lang_b_menu_root_category_subcategories_grouped'] => 2 ) );
				$kernel->page_function->construct_config_options( "category_new_file_construct_mode", array( $kernel->ld['lang_b_menu_root_category'] => 0, $kernel->ld['lang_b_menu_root_category_subcategories'] => 1 ) );
				$kernel->page_function->construct_config_options( "category_subcategory_mode", array( $kernel->ld['lang_b_menu_do_not_show'] => 0, $kernel->ld['lang_b_menu_show_first_page_only'] => 1, $kernel->ld['lang_b_menu_show_all_pages'] => 2 ) );
				$kernel->page_function->construct_config_options( "category_subcategory_links_mode", array( $kernel->ld['lang_b_menu_do_not_show'] => 0, $kernel->ld['lang_b_menu_show_index_only'] => 1, $kernel->ld['lang_b_menu_show_category_only'] => 2, $kernel->ld['lang_b_menu_show_both_pages'] => 3 ) );
				
				$kernel->form_function->construct_table( "lang_b_title_archive_display_configuration" );
				$kernel->form_function->add_field( F_SELECT, "category_subcategory_mode", "lang_b_subcategory_display_mode" );
				$kernel->form_function->add_field( F_SELECT, "category_subcategory_links_mode", "lang_b_subcategory_quicklink_display_mode" );
				$kernel->form_function->add_field( F_SELECT, "category_file_count_mode", "lang_b_file_counting_method" );
				$kernel->form_function->add_field( F_SELECT, "category_new_file_construct_mode", "lang_b_newest_file_method" );
				$kernel->form_function->add_field( F_RADIO, "archive_show_category_description", "lang_b_show_category_description" );
				
				$kernel->form_function->construct_table( "lang_b_title_pagination_configuration" );
				$kernel->form_function->add_field( F_TEXT, "string_max_length_file_name", "lang_b_file_name_length" );
				$kernel->form_function->add_field( F_TEXT, "string_max_length", "lang_b_file_preview_description_length" );
				$kernel->form_function->add_field( F_TEXT, "string_max_word_length", "lang_b_max_word_characters" );
				
				$kernel->form_function->finish();
				
				break;
			}
			
			#########################################################################
			
			case "control" :
			{
				$kernel->page_function->construct_config_options( "admin_display_default_limit", $kernel->array_set( array_flip( explode( ",", $kernel->config['admin_display_limit_options'] ) ), explode( ",", $kernel->config['admin_display_limit_options'] ) ) );
				$kernel->page_function->construct_config_options( "system_file_add_form_type", array( $kernel->ld['lang_b_menu_lofi_form'] => 0, $kernel->ld['lang_b_menu_advanced_form'] => 1 ) );
				$kernel->page_function->construct_config_options( "system_file_edit_form_type", array( $kernel->ld['lang_b_menu_lofi_form'] => 0, $kernel->ld['lang_b_menu_advanced_form'] => 1 ) );
				$kernel->page_function->construct_config_options( "system_file_mass_edit_form_type", array( $kernel->ld['lang_b_menu_lofi_form'] => 0, $kernel->ld['lang_b_menu_advanced_form'] => 1 ) );
				$kernel->page_function->construct_config_options( "admin_message_page_forward_mode", array( $kernel->ld['lang_b_menu_skip_messaging'] => 0, $kernel->ld['lang_b_menu_show_messaging'] => 1 ) );
				$kernel->page_function->construct_config_options( "admin_message_redirect_mode", array( $kernel->ld['lang_b_menu_node_main_only'] => 0, $kernel->ld['lang_b_menu_previous_page'] => 1 ) );
				
				$kernel->form_function->construct_table( "lang_b_title_session_configuration" );
				$kernel->form_function->add_field( F_TEXT, "control_panel_session_timeout", "lang_b_session_timeout" );
				$kernel->form_function->add_field( F_RADIO, "admin_session_sensitive_username", "lang_b_case_sensitive_username", array( "radio_mode" => 1 ) );
				$kernel->form_function->add_field( F_RADIO, "admin_session_ip_check", "lang_b_check_ip_address", array( "radio_mode" => 1 ) );
				$kernel->form_function->add_field( F_RADIO, "admin_session_http_check", "lang_b_check_http_browser", array( "radio_mode" => 1 ) );
				
				$kernel->form_function->construct_table( "lang_b_title_message_report_configuration" );
				$kernel->form_function->add_field( F_SELECT, "admin_message_page_forward_mode", "lang_b_message_display_mode" );
				$kernel->form_function->add_field( F_SELECT, "admin_message_redirect_mode", "lang_b_message_automatic_redirect" );
				$kernel->form_function->add_field( F_TEXT, "admin_message_refresh_seconds", "lang_b_message_display_time", false, ( $kernel->config['admin_message_page_forward_mode'] == 0 ) ? true : false );
				
				$kernel->form_function->construct_table( "lang_b_title_management_configuration" );
				$kernel->form_function->add_field( F_SELECT, "system_file_add_form_type", "lang_b_file_add_form" );
				$kernel->form_function->add_field( F_SELECT, "system_file_edit_form_type", "lang_b_file_edit_form" );
				$kernel->form_function->add_field( F_SELECT, "system_file_mass_edit_form_type", "lang_b_file_mass_edit_form" );
				$kernel->form_function->add_field( F_RADIO, "admin_allow_file_upload", "lang_b_file_uploading", array( "radio_mode" => 1 ) );
				$kernel->form_function->add_field( F_RADIO, "gd_thumbnail_feature", "lang_b_image_thumbnails", array( "radio_mode" => 1 ), ( !extension_loaded( "gd" ) ) ? true : false );
				$kernel->form_function->add_field( F_TEXT, "form_max_mirror_fields", "lang_b_download_mirrors_fields" );
				$kernel->form_function->add_field( F_TEXT, "gd_thumbnail_max_dimensions", "lang_b_thumbnail_max_size", false, ( !extension_loaded( "gd" ) ) ? true : false );
				
				$kernel->form_function->construct_table( "lang_b_title_pagination_configuration" );
				$kernel->form_function->add_field( F_TEXT, "admin_pagination_page_proximity", "lang_b_page_pagination" );
				$kernel->form_function->add_field( F_TEXT, "admin_display_limit_options", "lang_b_result_per_page" );
				$kernel->form_function->add_field( F_SELECT, "admin_display_default_limit", "lang_b_default_per_page_option" );
				
				$kernel->form_function->finish();
				
				break;
			}
			
			#########################################################################
			
			case "file" :
			{
				$kernel->page_function->construct_config_options( "display_file_list_mode", array( $kernel->ld['lang_b_menu_show_file_details'] => 0, $kernel->ld['lang_b_menu_download_file'] => 1 ) );
				$kernel->page_function->construct_config_options( "archive_file_hash_mode", array( $kernel->ld['lang_b_disabled'] => 0, $kernel->ld['lang_b_menu_hash_md5'] => 1, $kernel->ld['lang_b_menu_hash_sha1'] => 2, $kernel->ld['lang_b_menu_hash_both'] => 3 ) );
				$kernel->page_function->construct_config_options( "file_user_rating_mode", array( $kernel->ld['lang_b_menu_text_mode'] => 0, $kernel->ld['lang_b_menu_stars_mode'] => 1, $kernel->ld['lang_b_menu_stars_text_mode'] => 2 ) );
				$kernel->page_function->construct_config_options( "file_download_mode", array( $kernel->ld['lang_b_menu_standard_redirect_method'] => 0, $kernel->ld['lang_b_menu_masked_url_method'] => 1 ) );
				$kernel->page_function->construct_config_options( "file_download_size_mode", array( $kernel->ld['lang_b_disabled'] => 0, $kernel->ld['lang_b_menu_post_to_browser'] => 1 ) );
				
				$kernel->form_function->construct_table( "lang_b_title_file_upload_configuration" );
				$kernel->form_function->add_field( F_RADIO, "archive_allow_upload", "lang_b_file_uploading", array( "radio_mode" => 1 ) );
				$kernel->form_function->add_field( F_RADIO, "allow_unknown_url_linking", "lang_b_allow_foreign_url" );
				$kernel->form_function->add_field( F_RADIO, "admin_file_type_filter_enabled", "lang_b_filetype_filter", array( "radio_mode" => 1 ) );
				$kernel->form_function->add_field( F_RADIO, "archive_file_check_hash", "lang_b_file_hash_checking", array( "radio_mode" => 1 ) );
				$kernel->form_function->add_field( F_SELECT, "file_download_mode", "lang_b_download_method" );
				$kernel->form_function->add_field( F_SELECT, "file_download_size_mode", "lang_b_browser_post_file_size" );
				$kernel->form_function->add_field( F_TEXT, "system_parse_timeout", "lang_b_file_parse_timeout" );
				$kernel->form_function->add_field( F_RADIO, "email_notify_modified_url", "lang_b_file_url_broken_email_notice", array( "radio_mode" => 1 ) );
				$kernel->form_function->add_field( F_RADIO, "email_notify_broken_url", "lang_b_file_url_modified_email_notice", array( "radio_mode" => 1 ) );
				
				$kernel->form_function->construct_table( "lang_b_file_display_configuration" );
				$kernel->form_function->add_field( F_SELECT, "display_file_list_mode", "lang_b_file_listing_mode" );
				$kernel->form_function->add_field( F_SELECT, "archive_file_hash_mode", "lang_b_file_hash_mode" );
				$kernel->form_function->add_field( F_RADIO, "archive_show_empty_custom_fields", "lang_b_show_empty_fields" );
				$kernel->form_function->add_field( F_SELECT, "file_user_rating_mode", "lang_b_file_ranking_style" );
				
				$kernel->form_function->construct_table( "lang_b_title_submission_configuration" );
				$kernel->form_function->add_field( F_RADIO, "admin_file_submit_approval", "lang_b_moderator_approval", array( "radio_mode" => 1 ) );
				$kernel->form_function->add_field( F_RADIO, "EMAIL_FILE_SUBMIT", "lang_b_submission_email_notice", array( "radio_mode" => 1 ) );
				
				$kernel->form_function->construct_table( "lang_b_file_content_configuration" );
				$kernel->form_function->add_field( F_TAREA, "file_download_time_counters", "lang_b_download_time_calcuations" );
				$kernel->form_function->add_field( F_TAREA, "file_byte_rounders", "lang_b_byte_conversions" );
				
				$kernel->form_function->finish();
				
				break;
			}
			
			#########################################################################
			
			case "mail" :
			{
				$kernel->form_function->construct_table( "lang_b_title_smtp_email_configuration" );
				$kernel->form_function->add_field( F_TEXT, "mail_smtp_path", "lang_b_smtp_path", false, ( IN_DEMO_MODE == true ) );
				$kernel->form_function->add_field( F_TEXT, "mail_smtp_port", "lang_b_smtp_port", false, ( IN_DEMO_MODE == true ) );
				$kernel->form_function->add_field( F_TEXT, "mail_inbound", "lang_b_inward_email", false, ( IN_DEMO_MODE == true ) );
				$kernel->form_function->add_field( F_TEXT, "mail_outbound", "lang_b_outward_email", false, ( IN_DEMO_MODE == true ) );
				
				$kernel->form_function->finish();
				
				break;
			}
			
			#########################################################################
			
			case "system" :
			{
				$kernel->page_function->message_report( $kernel->ld['lang_b_database_details_hidden'], M_NOTICE );
				
				$kernel->page_function->construct_config_options( "debug_mode", array( $kernel->ld['lang_b_disabled'] => 0, $kernel->ld['lang_b_menu_debug_console'] => 1, $kernel->ld['lang_b_menu_debug_all'] => 2, $kernel->ld['lang_b_menu_debug_query_explain'] => 3 ) );
				
				$kernel->form_function->construct_table( "lang_b_title_path_configuration" );
				$kernel->form_function->add_field( F_TEXT, "system_root_url_home", "lang_b_title_home_url" );
				$kernel->form_function->add_field( F_TEXT, "system_root_url_path", "lang_b_title_archive_root_url", false, ( IN_DEMO_MODE == true ) );
				$kernel->form_function->add_field( F_TEXT, "system_root_dir", "lang_b_title_archive_root_dir", false, ( IN_DEMO_MODE == true ) );
				$kernel->form_function->add_field( F_TEXT, "system_root_url_upload", "lang_b_title_upload_url", false, ( IN_DEMO_MODE == true ) );
				$kernel->form_function->add_field( F_TEXT, "system_root_dir_upload", "lang_b_title_upload_dir", false, ( IN_DEMO_MODE == true ) );
				$kernel->form_function->add_field( F_TEXT, "system_root_url_gallery", "lang_b_title_gallery_url", false, ( IN_DEMO_MODE == true ) );
				$kernel->form_function->add_field( F_TEXT, "system_root_dir_gallery", "lang_b_title_gallery_dir", false, ( IN_DEMO_MODE == true ) );
				
				$kernel->form_function->construct_table( "lang_b_title_system_configuration" );
				$kernel->form_function->add_field( F_TEXT, "system_date_format_short", "lang_b_short_date_format" );
				$kernel->form_function->add_field( F_TEXT, "system_date_format_long", "lang_b_long_date_format" );
				$kernel->form_function->add_field( F_TEXT, "file_rename_suffix", "lang_b_file_rename_extension" );
				$kernel->form_function->add_field( F_TAREA, "system_allowed_html_tags", "lang_b_archive_allowed_html_tags", array( "rows" => 4 ) );
				$kernel->form_function->add_field( F_RADIO, "gzip_enabled", "lang_b_gzip_compression" );
				$kernel->form_function->add_field( F_SELECT, "debug_mode", "lang_b_debug_mode", false, ( IN_DEMO_MODE == true ) );
				
				$kernel->form_function->finish();
				
				break;
			}
			
			#########################################################################
			
			case "user" :
			{
				$kernel->form_function->construct_table( "lang_b_title_user_access_configuration" );
				$kernel->form_function->add_field( F_RADIO, "archive_allow_user_registration", "lang_b_user_login_registration", array( "radio_mode" => 1 ) );
				$kernel->form_function->add_field( F_RADIO, "session_force_login", "lang_b_force_login" );
				$kernel->form_function->add_field( F_RADIO, "EMAIL_USER_ACTIVATION", "lang_b_registration_activation" );
				$kernel->form_function->add_field( F_RADIO, "EMAIL_REG_NOTICE", "lang_b_register_email_notice" );
				$kernel->form_function->add_field( F_RADIO, "session_sensitive_username", "lang_b_case_sensitive_username", array( "radio_mode" => 1 ) );
				
				$kernel->form_function->construct_table( "lang_b_title_user_security_configuration" );
				$kernel->form_function->add_field( F_RADIO, "GD_POST_MODE_GUEST", "lang_b_use_gd_posting_guest", array( "radio_mode" => 1 ), ( !extension_loaded( "gd" ) ) ? true : false );
				$kernel->form_function->add_field( F_RADIO, "GD_POST_MODE_USER", "lang_b_use_gd_posting_user", array( "radio_mode" => 1 ), ( !extension_loaded( "gd" ) ) ? true : false );
				$kernel->form_function->add_field( F_RADIO, "GD_REGISTER_MODE", "lang_b_use_gd_register", array( "radio_mode" => 1 ), ( !extension_loaded( "gd" ) ) ? true : false );
				$kernel->form_function->add_field( F_TEXT, "GD_CHAR_ARRAY", "lang_b_gd_image_char_array" );
				$kernel->form_function->add_field( F_TEXT, "GD_CHAR_LENGTH", "lang_b_gd_image_char_length" );
				$kernel->form_function->add_field( F_TEXT, "archive_comment_grace_time", "lang_b_comment_grace_period" );
				
				$kernel->form_function->finish();
				
				break;
			}

			
			#########################################################################
			
			default :
			{
				break;
			}
		}
		
		break;
	}
}

?>

