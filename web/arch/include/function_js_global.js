/*
################################################################################
#	PHCDownload - Download Management System
################################################################################
# Copyright (c) 2005 by Alex G-White -- http://www.phpcredo.com
# PHCDL is free to use software. Please visit the website for futher licence
# information on distribution and use.
################################################################################
*/

/*
 * Fetch an object from the page
 **/
 
function read_obj( obj )
{
	if( document.getElementById )
	{
		return document.getElementById( obj );
	}
	else if( document.all )
	{
		return document.all[ obj ];
	}
	else if( document.layers )
	{
		return document.layers[ obj ];
	}
	else
	{
		return null;
	}
}

/*
 * Form field focus/blur notations
 **/

function init_obj_focus( element, objvalue )
{
	if( document.getElementById( element ).value == objvalue )
	{
		document.getElementById( element ).value = "";
		document.getElementById( element ).style.color = "#000000";
	}
}

function init_obj_blur( element, objvalue )
{
	if( document.getElementById( element ).value == "" )
	{
		document.getElementById( element ).value = objvalue;
		document.getElementById( element ).style.color = "#c0c0c0";
	}
}
