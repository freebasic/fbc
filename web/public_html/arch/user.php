<?php

################################################################################
# PHCDownload (version 1.1.0) - Document Management & Manipulation System
################################################################################
# Copyright (c) 2005 - 2007 by Alex Gailey-White @ www.phpcredo.com
# PHCDownload is free to use. Please visit the website for futher licence
# information and details on re-distribution and its use.
################################################################################

require_once( "global.php" );
require_once( 'include/function.phpBB.php' );

$kernel->clean_array( "_REQUEST", array( "id" => V_INT, "node" => V_STR, "type" => V_STR, "action" => V_STR ) );

switch( $kernel->vars['node'] )
{
	#############################################################################
	# User login
	
	case "login" :
	{
		switch( $kernel->vars['type'] )
		{
			#############################################################################
			# Category password
		  
			case "category" :
			{
				if( $kernel->vars['id'] == 0 )
				{
					$kernel->page_function->message_report( $kernel->ld['lang_f_no_category'], M_ERROR );
				}
				else
				{
					$kernel->clean_array( "_REQUEST", array( "category_password" => V_MD5, "referer" => V_STR ) );
					
					if( $kernel->db->numrows( "SELECT `category_id` FROM " . TABLE_PREFIX . "categories WHERE category_id = {$kernel->vars['id']}" ) == 0 )
					{
						$kernel->page_function->message_report( $kernel->ld['lang_f_invalid_category'], M_ERROR );
					}
					else
					{
						$category = $kernel->db->row( "SELECT `category_id`, `category_name`, `category_password` FROM `" . TABLE_PREFIX . "categories` WHERE `category_id` = {$kernel->vars['id']}" );
						
						$kernel->vars['page_struct']['system_page_navigation_id'] = $kernel->vars['page_struct']['system_page_announcement_id'] = $category['category_id'];
						$kernel->vars['page_struct']['system_page_action_title'] = "";
						
						if( empty( $category['category_password'] ) )
						{
							$kernel->page_function->message_report( $kernel->ld['lang_f_no_password_category'], M_ERROR );
						}
						else
						{
							if( isset( $_POST['login'] ) )
							{
								if( $kernel->vars['category_password'] !== $category['category_password'] )
								{
									$kernel->page_function->message_report( $kernel->ld['lang_f_password_no_match'], M_ERROR );
								}
								else
								{
									$_SESSION['session_category_'.$category['category_id'] ] = $kernel->vars['category_password'];
									
									header( "Location: " . $kernel->format_input( $kernel->vars['referer'], T_URL_DEC ) );
								}
							}
							else
							{
								$kernel->tp->call( "category_login" );
							}
						}
					}
						
					$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );
				}
						
				break;
			}
			
			#############################################################################
			# Check user info
		  
			default :
			{
				if( !empty( $kernel->session['session_hash'] ) && $kernel->session['session_hash'] === $_SESSION['phcdl_session_hash'] )
				{
					$kernel->page_function->message_report( $kernel->ld['lang_f_logged_in'], M_NOTICE );
				}
				else
				{
					if( !isset( $_POST['do_login'] ) )
					{
						$kernel->session_function->construct_user_login( $kernel->ld['lang_f_disabled_register'] );
						exit();
					}

					$kernel->clean_array( "_POST", array( "password" => V_MD5, "username" => V_STR ) );
					
					$panel = $kernel->db->row( "SELECT u.user_name FROM " . TABLE_PREFIX . "users u WHERE u.user_name = '" . $kernel->vars['username'] . "'" );
					
					// no user found?
					if( !isset( $panel['user_name'] ) )
					{
						// try to import from the phpBB table
						$panel = phpBB_login( $kernel->vars['username'], $kernel->vars['password'], TRUE, $errmsg );
						if( is_null( $panel ) )
						{
							$kernel->session_function->construct_user_login( $errmsg );
							exit();
						}
					}

					if( ( $kernel->config['session_sensitive_username'] == "true" && $panel['user_name'] != $kernel->vars['username'] ) || 
							( $kernel->config['session_sensitive_username'] == "false" && strtolower( $panel['user_name'] ) != strtolower( $kernel->vars['username'] ) ) )
					{
						$kernel->session_function->construct_user_login( $kernel->ld['lang_f_bad_login_username'] );
						exit();
					}
					
					$panel = $kernel->db->row( "SELECT u.user_id, u.user_group_id, u.user_name, u.user_password, u.user_active, g.usergroup_archive_permissions, b.ban_userid" .
																		 " FROM " . TABLE_PREFIX . "users u" .
																		 " LEFT JOIN " . TABLE_PREFIX . "usergroups g ON ( u.user_group_id = g.usergroup_id )" .
																		 " LEFT JOIN " . phpBB_BANTABLE . " b ON ( u.user_id = b.ban_userid )" .
																		 " WHERE u.user_name = '" . $kernel->vars['username'] . "' AND u.user_password = '" . $kernel->vars['password'] . "'" );
						
					// wrong user or pwd?
					if( !isset( $panel['user_name'] ) )
					{
						// try to reimport from phpBB, in case the user changed his pwd..
						$panel = phpBB_login( $kernel->vars['username'], $kernel->vars['password'], FALSE, $errmsg );
						if( is_null( $panel ) )
						{
							$kernel->session_function->construct_user_login( $errmsg );
							exit();
						}
					}
							
					if( $panel['user_active'] == "N" )
					{
						$kernel->page_function->message_report( $kernel->ld['lang_f_user_account_inactive'], M_WARNING );
					}
					else
					{
						$kernel->db->query( "DELETE FROM " . TABLE_PREFIX . "sessions WHERE session_name = '" . $kernel->vars['username'] . "'" );
								
						$new_hash = md5( uniqid( rand() ) );
								
						$userdata = array( 
								"session_hash"					=> $new_hash,
								"session_group_id"			=> $panel['user_group_id'],
								"session_user_id"				=> $panel['user_id'],
								"session_ip_address"		=> IP_ADDRESS,
								"session_name"					=> $panel['user_name'],
								"session_password"			=> $kernel->vars['password'],
								"session_agent"					=> HTTP_AGENT,
								"session_timestamp"			=> UNIX_TIME,
								"session_run_timestamp"	=> UNIX_TIME,
								"session_permissions"		=> $panel['usergroup_archive_permissions']
							);
								
						$kernel->db->insert( "sessions", $userdata );
								
						$cachedata = array( 
							"cache_session_hash"		=> $new_hash,
							"cache_user_id"					=> $panel['user_id']
						);
								
						if( $kernel->db->numrows( "SELECT `cache_user_id` FROM `" . TABLE_PREFIX . "session_cache` WHERE `cache_user_id` = {$panel['user_id']}" ) > 0 )
						{
							$kernel->db->update( "session_cache", $cachedata, "WHERE `cache_user_id` = {$panel['user_id']}" );
						}
						else
						{
							$kernel->db->insert( "session_cache", $cachedata );
						}
								
						if( isset( $_POST['remember_cookie'] ) )
						{
							setcookie( "phcdl_session_hash", $new_hash, UNIX_TIME + ( 86400 * 365 ), "/", HTTP_HOST );
							setcookie( "phcdl_user_id", $panel['user_id'], UNIX_TIME + ( 86400 * 365 ), "/", HTTP_HOST );
							setcookie( "phcdl_user_password", $kernel->vars['password'], UNIX_TIME + ( 86400 * 365 ), "/", HTTP_HOST );
						}
								
						$_SESSION['phcdl_session_hash'] = $new_hash;
						$_SESSION['phcdl_user_id'] = $panel['user_id'];
						$_SESSION['phcdl_user_password'] = $kernel->vars['password'];
									
						header( "Location: index.php" );
					}
				}
				
				$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );
					
				break;
			}
		}
		
		break;
	}
	
	#############################################################################
	# Destroy cookie and logout
  
	case "logout" :
	{
		$kernel->session_function->clear_user_cache();
		
		header( "Location: index.php" );
		exit;
		
		break;
	}
	
	#############################################################################
	# Render verification image
  
	case "image" :
	{
		$kernel->clean_array( "_REQUEST", array( "verify_hash" => V_STR ) );
		
		if( empty( $kernel->vars['verify_hash'] ) )
		{
			exit;
		}
		else
		{
			$get_verification = $kernel->db->query( "SELECT `verify_key` FROM `" . TABLE_PREFIX . "users_verify` WHERE `verify_hash` = '" . $kernel->vars['verify_hash'] . "' AND `verify_ip_address` = '" . IP_ADDRESS . "'" );
			
			if( $kernel->db->numrows( $get_verification ) == 0 )
			{
				exit;
			}
			else
			{
				$kernel->image_function->construct_security_code_image( $kernel->db->data( $get_verification ) );
			}
		}
		
		break;
	}
	
	#############################################################################
	# User language
  
	case "language" :
	{
		$kernel->clean_array( "_POST", array( "default_language" => V_STR ) );
		
		if( !empty( $kernel->vars['default_language'] ) )
		{
			setcookie( "phcdl_user_lang", $kernel->vars['default_language'], UNIX_TIME - ( 86400 * 365 ), "/", HTTP_HOST );
		}
		
		header( "Location: index.php" );
		
		break;
	}
	
	#############################################################################
	# User activation
  
	case "activate" :
	{
		if( !empty( $activate_hash ) AND !empty( $activate_id ) AND !empty( $user_id ) )
		{
			if( $kernel->db->numrows( "SELECT `activate_id` FROM `" . TABLE_PREFIX . "users_activate` WHERE `activate_id` = {$activate_id} AND `activate_hash` = '{$activate_hash}' AND `activate_user_id` = {$user_id}" ) == 1 )
			{
				$kernel->db->update( "users", array( "user_active" => "Y" ), "WHERE `user_id` = {$user_id}" );
				
				$kernel->page_function->message_report( $kernel->ld['lang_f_user_activate_successful'], M_NOTICE );
			}
			else
			{
				$kernel->page_function->message_report( $kernel->ld['lang_f_invalid_activate_details'], M_ERROR );
			}
			
			$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );
		}
		else
		{
			header( "Location: index.php" );
		}
		
		break;
	}
	
	#############################################################################
  
	default :
	{
		#############################################################################
		# User panel
		
		if( !empty( $kernel->session['session_hash'] ) AND USER_LOGGED_IN == true )
		{
			$kernel->clean_array( "_REQUEST", array( "user_name" => V_STR, "user_password" => V_STR, "user_password_confirm" => V_STR, "user_email" => V_STR ) );
			
  		if( isset( $_POST['password_update'] ) )
  		{
  			//no, or short password
  			if( empty( $kernel->vars['user_password'] ) OR strlen( $kernel->vars['user_password'] ) < 4 )
  			{
  				$kernel->page_function->message_report( $kernel->ld['lang_f_register_invalid_password'], M_ERROR, HALT_EXEC );
  			}
  			
  			//password mismatch
  			if( $kernel->vars['user_password'] !== $kernel->vars['user_password_confirm'] )
  			{
  				$kernel->page_function->message_report( $kernel->ld['lang_f_register_bad_password'], M_ERROR, HALT_EXEC );
  			}
  			
  			$kernel->db->update( "users", array( "user_password" => md5( $kernel->vars['user_password'] ) ), "WHERE `user_id` = {$kernel->session['session_user_id']}" );
				
				$kernel->session_function->clear_user_cache();
				
				header( "Location: index.php" );
				exit;
  		}
  		
  		if( isset( $_POST['contact_update'] ) )
  		{
  			$user = $kernel->db->row( "SELECT `user_name`, `user_email` FROM `" . TABLE_PREFIX . "users` WHERE `user_id` = " . $kernel->session['session_user_id'] . "" );
  			
  			//invalid email address
  			if( !preg_match( "/^[\w-]+(\.[\w-]+)*@([0-9a-z][0-9a-z-]*[0-9a-z]\.)+([a-z]{2,4})$/i", strtolower( $kernel->vars['user_email'] ) ) )
  			{
  				$kernel->page_function->message_report( $kernel->ld['lang_f_register_invalid_email'], M_ERROR, HALT_EXEC );
  			}
  			
  			//no username specified
  			if( empty( $kernel->vars['user_name'] ) )
  			{
  				$kernel->page_function->message_report( $kernel->ld['lang_f_register_no_user'], M_ERROR, HALT_EXEC );
  			}
  			
  			//username already used
  			if( $kernel->db->numrows( "SELECT `user_name` FROM " . TABLE_PREFIX . "users WHERE `user_name` = '{$kernel->vars['user_name']}'" ) == 1 AND $user['user_name'] !== $kernel->vars['user_name'] )
  			{
  				$kernel->page_function->message_report( $kernel->ld['lang_f_register_user_taken'], M_ERROR, HALT_EXEC );
  			}
  			
  			//email already used
  			if( $kernel->db->numrows( "SELECT `user_email` FROM " . TABLE_PREFIX . "users WHERE `user_email` = '{$kernel->vars['user_email']}'" ) == 1 AND $user['user_email'] !== $kernel->vars['user_email'] )
  			{
  				$kernel->page_function->message_report( $kernel->ld['lang_f_register_email_taken'], M_ERROR, HALT_EXEC );
  			}
  			
  			$kernel->db->update( "users", array( "user_name" => $kernel->vars['user_name'], "user_email" => $kernel->vars['user_email'] ), "WHERE `user_id` = {$kernel->session['session_user_id']}" );
				
				$kernel->session_function->clear_user_cache();
				
				header( "Location: index.php" );
				exit;
  		}
			
			$user = $kernel->db->row( "SELECT `user_name`, `user_email` FROM `" . TABLE_PREFIX . "users` WHERE `user_id` = " . $kernel->session['session_user_id'] . "" );
			
			$userdata = $kernel->db->row( "SELECT c.cache_session_downloads, c.cache_session_bandwidth, u.user_downloads, u.user_bandwidth FROM " . TABLE_PREFIX . "session_cache c LEFT JOIN " . TABLE_PREFIX . "users u ON ( c.cache_user_id = u.user_id ) WHERE c.cache_session_hash = '" . $_SESSION['phcdl_session_hash'] . "' AND c.cache_user_id = " . $kernel->session['session_user_id'] . "" );
      
			$kernel->tp->call( "user_panel" );
			
			$userdata['cache_session_downloads'] = $kernel->format_input( $userdata['cache_session_downloads'], T_NUM );
			$userdata['cache_session_bandwidth'] = $kernel->archive_function->format_round_bytes( $userdata['cache_session_bandwidth'] );
			$userdata['user_downloads'] = $kernel->format_input( $userdata['user_downloads'], T_NUM );
			$userdata['user_bandwidth'] = $kernel->archive_function->format_round_bytes( $userdata['user_bandwidth'] );
			
			$kernel->tp->cache( $user );
			
			$kernel->tp->cache( $userdata );
		}
		else
		{
			// the phpBB reg system must be used instead
			if( (1==1) /*$kernel->config['allow_register'] == "false"*/ )
			{
				$kernel->page_function->message_report( $kernel->ld['lang_f_disabled_register'], M_NOTICE );
			}
			else
			{
				switch( $kernel->vars['action'] )
				{
					#############################################################################
					# Add user
					
					case "create" :
					{
						$kernel->clean_array( "_REQUEST", array( "user_verify_key" => V_STR, "user_verify_hash" => V_STR, "user_name" => V_STR, "user_password" => V_STR, "user_password_confirm" => V_STR, "user_email" => V_STR ) );
						
						// Check image security hash
						$kernel->page_function->verify_security_image_details( null );
						
						//invalid email address
						if( !preg_match( "/^[\w-]+(\.[\w-]+)*@([0-9a-z][0-9a-z-]*[0-9a-z]\.)+([a-z]{2,4})$/i", strtolower( $kernel->vars['user_email'] ) ) )
						{
							$kernel->page_function->message_report( $kernel->ld['lang_f_register_invalid_email'], M_ERROR );
						}
						
						//no username specified
						elseif( empty( $kernel->vars['user_name'] ) )
						{
							$kernel->page_function->message_report( $kernel->ld['lang_f_register_no_user'], M_ERROR );
						}
						
						//username already used
						elseif( $kernel->db->numrows( "SELECT `user_name` FROM " . TABLE_PREFIX . "users WHERE `user_name` = '{$kernel->vars['user_name']}'" ) == 1 )
						{
							$kernel->page_function->message_report( $kernel->ld['lang_f_register_user_taken'], M_ERROR );
						}
						
						//email already used
						elseif( $kernel->db->numrows( "SELECT `user_email` FROM " . TABLE_PREFIX . "users WHERE `user_email` = '{$kernel->vars['user_email']}'" ) == 1 )
						{
							$kernel->page_function->message_report( $kernel->ld['lang_f_register_email_taken'], M_ERROR );
						}
						
						//no, or short password
						elseif( empty( $kernel->vars['user_password'] ) OR strlen( $kernel->vars['user_password'] ) < 4 )
						{
							$kernel->page_function->message_report( $kernel->ld['lang_f_register_invalid_password'], M_ERROR );
						}
						
						//password mismatch
						elseif( $kernel->vars['user_password'] !== $kernel->vars['user_password_confirm'] )
						{
							$kernel->page_function->message_report( $kernel->ld['lang_f_register_bad_password'], M_ERROR );
						}
						else
						{
							$kernel->db->query( "DELETE FROM `" . TABLE_PREFIX . "users_verify` WHERE `verify_ip_address` = '" . IP_ADDRESS . "' AND `verify_hash` = '{$kernel->vars['user_verify_hash']}'" );
							
							$kernel->vars['user_name'] = $kernel->format_input( $kernel->vars['user_name'], T_STRIP );
							$kernel->vars['user_email'] = $kernel->format_input( $kernel->vars['user_email'], T_STRIP );
							
							$userdata = array(
								"user_name"						=> $kernel->vars['user_name'],
								"user_email"					=> $kernel->vars['user_email'],
								"user_password"				=> md5( $kernel->vars['user_password'] ),
								"user_group_id"				=> 2,
								"user_active"					=> "Y",
								"user_timestamp"			=> UNIX_TIME
							);
							
							if( $kernel->config['EMAIL_USER_ACTIVATION'] == 1 )
							{
								$userdata['user_active'] = "N";
								
								$kernel->db->insert( "users", $userdata );
								
								$user = $kernel->db->row( "SELECT `user_id` FROM `" . TABLE_PREFIX . "users` WHERE `user_name` = '{$kernel->vars['user_name']}'" );
								
								$new_activate_hash = md5( uniqid( rand() ) );
								
								$emaildata = array(
									"activate_hash"			=> $new_activate_hash,
									"activate_user_id"	=> $user['user_id'],
									"activate_time"			=> UNIX_TIME
								);
								
								$kernel->db->insert( "users_activate", $emaildata );
								
								$activation = $kernel->db->row( "SELECT `activate_id`, `activate_hash` FROM `" . TABLE_PREFIX . "users_activate` WHERE `activate_user_id` = '{$user['user_id']}'" );
								
								$emaildata = array(
									"user_name"					=> $kernel->vars['user_name'],
									"user_email"				=> $kernel->vars['user_email'],
									"email_activation_link"		=> $kernel->config['system_root_url_path'] . "/user.php?node=activate&amp;user_id={$user['user_id']}&amp;activate_id={$activation['activate_id']}&amp;activate_hash={$new_activate_hash}",
									"archive_title"			=> $kernel->config['archive_name']
								);
								
								$kernel->archive_function->construct_send_email( "user_register_activation", $kernel->vars['user_email'], $emaildata );
							}
							else
							{
								$kernel->db->insert( "users", $userdata );
							}
							
							if( $kernel->config['EMAIL_REG_NOTICE'] == 1 )
							{
								$useremaildata = array(
									"user_name"					=> $kernel->vars['user_name'],
									"user_email"				=> $kernel->vars['user_email'],
									"archive_title"			=> $kernel->config['archive_name']
								);
							
								$kernel->archive_function->construct_send_email( "user_register_notification", $kernel->config['mail_inbound'], $useremaildata );
							}
							
							$kernel->archive_function->update_database_counter( "users" );
							
							header( "Location: user.php?action=message" );
						}
						
						break;
					}
					
					#############################################################################
					# Add Success
				  
					case "message" :
					{
						$kernel->page_function->message_report( $kernel->ld['lang_f_submitted_user'], M_NOTICE );
								
						break;
					}
					
					#############################################################################
					# Reg form
					
					default :
					{
						$kernel->tp->call( "user_add" );
						
						//GD image security option
						$kernel->session_function->construct_session_security_form();
						
						break;
					}
				}
			}
		}
		
		$kernel->page_function->construct_output( R_HEADER, R_FOOTER, false, R_NAVIGATION );
		
		break;
	}
}

?>