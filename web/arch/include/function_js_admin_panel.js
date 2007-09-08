/*
################################################################################
#	PHCDownload - Download Management System
################################################################################
# Copyright (c) 2005 by Alex G-White -- http://www.phpcredo.com
# PHCDL is free to use software. Please visit the website for futher licence
# information on distribution and use.
################################################################################
*/

var element = "checkbox";

//=============================================================================
// Check element selection
//=============================================================================

function check_all()
{
	if( document.getElementById ) //DOM1
	{
		var boxArray = document.getElementsByName( "checkbox[]" );
		
    for ( var i = 0; i <= boxArray.length; i++ )
    {
			if( boxArray[i] )
			{
				boxArray[i].checked = true;
			}
    }
	}
}

//=============================================================================
// Check RANGE elements selection
//=============================================================================

function check_ranges()
{
	if( document.getElementById ) //DOM1
	{
		var points = new Array()
		var boxArray = document.getElementsByName( "checkbox[]" );
		
    for ( var i = 0; i <= boxArray.length; i++ )
    {
			if( boxArray[i] )
			{
				if( boxArray[i].checked == true )
				{
					points.push( i );
				}
			}
    }
		
  	for( var a = 0; a <= points.length; a += 2 )
    {
    	for( var p = points[a]; p <= points[ a + 1 ]; p++ )
    	{
    		boxArray[p].checked = true;
    	}
    }
	}
}

//=============================================================================
// Uncheck element selection
//=============================================================================

function uncheck_all( total_rows )
{
	if( document.getElementById ) //DOM1
	{
		var boxArray = document.getElementsByName( "checkbox[]" );
		
    for ( var i = 0; i <= boxArray.length; i++ )
    {
			if( boxArray[i] )
			{
				boxArray[i].checked = false;
			}
    }
	}
}

//=============================================================================
// Invert element selection
//=============================================================================

function invert_all( total_rows )
{
	if( document.getElementById ) //DOM1
	{
		var boxArray = document.getElementsByName( "checkbox[]" );
		
    for ( var i = 0; i <= boxArray.length; i++ )
    {
			if( boxArray[i] )
			{
				boxArray[i].checked = !boxArray[i].checked;
			}
    }
	}
}

//=============================================================================
// Invert column (usergroup perms)
//=============================================================================

function invert_column( element )
{
	if( document.getElementById ) //DOM1
	{
		var boxArray = document.getElementsByName( element + "[]" );
		
    for ( var i = 0; i <= boxArray.length; i++ )
    {
			if( boxArray[i] )
			{
				boxArray[i].checked = !boxArray[i].checked;
			}
    }
	}
}

//=============================================================================
// Popup template viewer
//=============================================================================

function init_preview()
{
  var data = document.template.template_data.value;
	
	preview = window.open( '', 'Preview', 'toolbar=0, scrollbars=1, location=0, statusbar=0, menubar=0, resizable=1, width=450, height=450' );
	
	preview.document.write( data );
}

//=============================================================================
// Popup
//=============================================================================

function init_window( window_url, width, height )
{
  window = window.open( window_url, 'Popup', 'toolbar=0, scrollbars=1, location=0, statusbar=0, menubar=0, resizable=1, width=' + width + ', height=' + height );
}

//=============================================================================
// This is an obvious one..
//=============================================================================

function delete_confirm( objname )
{
  var check = confirm( objname );
	
  if( !check ) return false;
}

//=============================================================================
// ...
//=============================================================================

function confirm_action( objname )
{
  var check = confirm( objname );
	
  if( !check ) return false;
}

