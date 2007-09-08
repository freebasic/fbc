/*
################################################################################
#	PHCDownload - Download Management System
################################################################################
# Copyright (c) 2005 by Alex G-White -- http://www.phpcredo.com
# PHCDL is free to use software. Please visit the website for futher licence
# information on distribution and use.
################################################################################
*/

	var node_config = new Array({$open_menu_nodes});
	
	img_expand = new Image( 16, 16 );
	img_collapse = new Image( 16, 16 );
	
	img_expand.src = "./images/arrow_down.gif";
	img_collapse.src = "./images/arrow_up.gif";
	
	//invert menu node state
	function toggle_node( id )
	{
		if( read_obj( "menu" + id ).style.display == "none" )
		{
			read_obj( "blurb" + id ).style.display = 'none';
			read_obj( "menu" + id ).style.display = 'block';
			document.images[ "img" + id ].src = eval( "img_collapse.src" );
		}
		else
		{
			document.images[ "img" + id ].src = eval( "img_expand.src" );
			read_obj( "menu" + id ).style.display = 'none';
			read_obj( "blurb" + id ).style.display = 'block';
		}
	}
	
	//menu toggle
	function toggle_node_all( state )
	{
		for ( var i = 1; i <= node_config.length; i++ )
		{
			if( state == 0 )
			{
				if( read_obj( "menu" + i ).style.display != "none" )
				{
					document.images[ "img" + i ].src = eval( "img_expand.src" );
					read_obj( "menu" + i ).style.display = 'none';
					read_obj( "blurb" + i ).style.display = 'block';
				}
			}
			else if( state == 1 )
			{
				if( read_obj( "menu" + i ).style.display == "none" )
				{
					read_obj( "blurb" + i ).style.display = 'none';
					read_obj( "menu" + i ).style.display = 'block';
					document.images[ "img" + i ].src = eval( "img_collapse.src" );
				}
			}
		}
	}
	
	//read config array flags
	function setup_node_config()
	{
		var count = 1;
		
		for ( var i = 0; i <= node_config.length; i++ )
		{
			if( node_config[i] == 1 )
			{
				read_obj( "menu" + count ).style.display = 'block';
				read_obj( "blurb" + count ).style.display = 'none';
			}
			count++;
		}
	}
	
	//save new config
	function save_menu_config()
	{
		var config = new Array();
		var count = 0;
		
		for ( var i = 1; i <= node_config.length; i++ )
		{
			var node = read_obj( "menu" + i );
			
			if( node.style.display != "none" )
			{
				config[count] = 1;
			}
			else
			{
				config[count] = 0;
			}
			count++;
		}
		
		window.location = "index.php?hash={$hash}&node=menu&action=update&menucfg=" + config.join( "," ) + "";
	 }