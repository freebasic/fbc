<?php

//
// phpBB user table integration
// copyleft 2007 av1ctor[@]yahoo.com.br
//

	define( 'phpBB_TABLE', 'phpbb_users' );
	define( 'phpBB_BANTABLE', 'phpbb_banlist' );
	define( 'phpBB_FIELDS', 'u.user_id,u.username,u.user_password,u.user_level,u.user_email,u.user_posts,b.ban_userid' );

	define( 'phpBB_USERPERM_SUBMIT', 1 );

//
//
//
function phpBB_login( $username, $password, $do_insert, &$errmsg )
{
	global $kernel;
	
	// try to find an user in the phpBB table
	
	$data = $kernel->db->row( 'SELECT ' . phpBB_FIELDS . 
					 ' FROM ' . phpBB_TABLE . ' u' .
					 ' LEFT JOIN ' . phpBB_BANTABLE . ' b ON (b.ban_userid = u.user_id)' .
			     " WHERE username='{$username}' AND user_password='{$password}'" );
			     
	if( !isset( $data['username'] ) )
	{
		$errmsg = $kernel->ld['lang_f_bad_login_username'];
		return NULL;
	}
		
	// banned?
	if( isset( $data['ban_userid'] ) )
	{
		$errmsg = $kernel->ld['lang_f_login_banned'];
		return NULL;
	}
		
	$userdata['user_password'] = $data['user_password'];
	$userdata['user_group_id'] = ($data['user_level'] == 1? 1: 2);

	// import a new user
	if( $do_insert )
	{
		$userdata['user_id']				= $data['user_id'];
		$userdata['user_name']			= $data['username'];
		$userdata['user_email']			= $data['user_email'];
		$userdata['user_active']		= 'Y';
		$userdata['user_timestamp']	= time();

		$kernel->db->insert( 'users', $userdata );
		$kernel->archive_function->update_database_counter( "users" );
	}
	// just update the pwd
	else
	{
		$kernel->db->update( 'users', $userdata, 'WHERE user_id = ' . $data['user_id'] );
	}
	
	// load the permissions
	$row =& $kernel->db->row( 'SELECT usergroup_archive_permissions FROM ' . TABLE_PREFIX . 'usergroups WHERE usergroup_id = ' . $userdata['user_group_id'] );	

	$userdata['usergroup_archive_permissions'] = $row['usergroup_archive_permissions'];
	
	return $userdata;
}

//
//
//
function phpBB_checkPermission( $perm )
{
	global $kernel;
	
	if( empty( $kernel->session['session_permissions'] ) )
		return false;
		
	$id = $kernel->session['session_user_id'];

	// try to find an user in the phpBB table
	$kernel->db->query( 'SELECT u.user_level,u.user_posts' . 
											' FROM ' . phpBB_TABLE . ' u' .
			    						' WHERE u.user_id = ' . $id );

	if( $kernel->db->numrows() == 0 )
		return false;
		
	$data =& $kernel->db->data();
	
	// admin? anything allowed..
	if( $data['user_level'] != 0 )
		return true;

	switch( $perm )
	{
	case phpBB_USERPERM_SUBMIT:
		// part of the community? (keep the bots away)
		return ( $data['user_posts'] <= 10? false: true );
	
	default:
		return false;
	}
}

?>