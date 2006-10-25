/*************************************************************
 *	SXBB - Select Expand BBcodes MOD v1.0.2
 *
 *	Copyright (C) 2004, Markus (http://www.phpmix.com)
 *	This script is released under GPL License.
 *	Feel free to use this script (or part of it) wherever you need
 *	it ...but please, give credit to original author. Thank you. :-)
 *	We will also appreciate any links you could give us.
 *
 *	Enjoy! ;-)
 *
 *************************************************************/

//
// ADVICE: Editor Settings -> TabSize 4 ;-)
//

function SXBB_IsIEMac()
{
	// Any better way to detect IEMac?
	var ua = String(navigator.userAgent).toLowerCase();
	if( document.all && ua.indexOf("mac") >= 0 )
		return true;
	return false;
}
function SXBB_IsOverflowAble()
{
	// Reliable overflow usage seems to require correct DOM support with some exceptions:
	// - Opera5/6 renders 'auto' as if it was 'visible'. Bang!
	// - IEMac seems to be buggy in some circumstances:
	//   http://sonofhans.net/mac_ie5_bug/
	//
	if( document.getElementById && document.childNodes && !SXBB_IsIEMac() )
		return true;
	return false;
}

function _SXBB(id)
{
	this.id = id;
	this.size = this.min = 75;	// --- Adjust MINIMUM_BLOCK_HEIGHT here :-)
	this.extra = 5;				// --- This is added to height when expanded
	this.margin = 20;			// --- Hide [expand] command if just a few pixels height when expanded.
	this.T = [];
}
_SXBB.prototype.genCmd = function(cmd, txt)
{
	return '&nbsp;‹&nbsp;<a class="genmed" style="text-decoration:none;" href="javascript:void(0)" onclick="SXBB[\''+this.id+'\'].'+cmd+'(\''+txt+'\');" onfocus="this.blur();"><b>'+txt+'</b></a>&nbsp;›';
}
_SXBB.prototype.writeCmd = function()
{
	var s='';
	if( (document.selection && !SXBB_IsIEMac()) || (document.createRange && (document.getSelection || window.getSelection)) )
	{
		s += this.genCmd('select', this.T['select']);
	}
	if( SXBB_IsOverflowAble() )
	{
		// Actually, the [expand] link will be placed by the onload event (if necessary) :-)
		s += '<span id="'+this.id+'x"></span>';
	}
	document.write(s);	// ‹Select› ‹Expand›
}
_SXBB.prototype.writeDiv = function()
{
	// Use 'overflow:auto;height:#px' only if 'overflow:auto' is supported...
	// Works on IE4+, Mozilla, Opera7, Safari
	// Fails on IEMac, NS4, Opera6-
	//
	var s = ( SXBB_IsOverflowAble() ? 'style="overflow:auto;height:'+this.min+'px;"' : '' );
	document.write('<div id="'+this.id+'" '+s+'>');
}
_SXBB.prototype.getObj = function(id)
{
	return ( document.getElementById ? document.getElementById(id) : null );
}
_SXBB.prototype.select = function()
{
	var o = this.getObj(this.id);
	if( !o ) return;
	var r, s;
	if( document.selection && !SXBB_IsIEMac() )
	{
		// Works on: IE5+
		// To be confirmed: IE4? / IEMac fails?
		r = document.body.createTextRange();
		r.moveToElementText(o);
		r.select();
	}
	else if( document.createRange && (document.getSelection || window.getSelection) )
	{
		// Works on: Netscape/Mozilla/Konqueror/Safari
		// To be confirmed: Konqueror/Safari use window.getSelection ?
		r = document.createRange();
		r.selectNodeContents(o);
		s = window.getSelection ? window.getSelection() : document.getSelection();
		s.removeAllRanges();
		s.addRange(r);
	}
}
_SXBB.prototype.resize = function(cmd)
{
	var o = this.getObj(this.id);
	if( !o ) return;
	var x = this.getObj(this.id+'x');
	if( !x ) return;

	// First, deal with requested command...
	if( cmd == 'onload' || cmd == 'onresize' )
	{
		if( o.scrollHeight <= this.min ) { x.innerHTML = ''; return; }
		if( x.innerHTML != '' ) return;
		if( cmd == 'onload' )
		{
			x.innerHTML = this.genCmd('resize', this.T['expand']);
			return;
		}
		cmd = this.T['contract'];
	}
	if( cmd == this.T['expand'] )
	{
		this.size = o.scrollHeight + this.extra;
		o.style.height = 'auto';
		o.style.overflow = 'visible';
		// Check to conditionally hide the [expand] link, if once expanded, adding [contract] is not really useful.
		x.innerHTML = ( (o.scrollHeight-this.margin) > this.min ? this.genCmd('resize', this.T['contract']) : '' );
	}
	else
	{
		this.size = this.min;
		o.style.height = this.size + 'px';
		o.style.overflow = 'auto';
		x.innerHTML = this.genCmd('resize', this.T['expand']);
	}
	if( cmd != 'onresize' )
	{
		// If necessary, adjust height of outer blocks...
		if( o.parentNode ) for( o = o.parentNode; o.parentNode; o = o.parentNode )
		{
			if( o.tagName && o.tagName == 'DIV' && o.id && o.id.indexOf('SXBB') == 0 )
			{
				if( !document.all ) SXBB[o.id].resize(this.T['contract']);
				SXBB[o.id].resize(this.T['expand']);
			}
		}
	}
	return false;
}

// --------------------------------------------------------------------------------
// Actually, this script is being included for every instance of a boxed BBCode,
// so... we MUST do something to ensure we only do the job just once!
//
if( typeof(SXBB) == 'undefined' ) {
// --------------------------------------------------------------------------------

var SXBB = [];

// --------------------------------------------------------------------------------
if( SXBB_IsOverflowAble() ) {	// The following is Not necessary on some browsers!
// --------------------------------------------------------------------------------

var SXBB_oldOnLoad = null;
var SXBB_oldOnResize = null;

function SXBB_onLoad()
{
	if( SXBB_oldOnLoad ) { SXBB_oldOnLoad(); SXBB_oldOnLoad = null; }
	SXBB_evalSize('onload');
}
function SXBB_onResize()
{
	if( SXBB_oldOnResize ) { SXBB_oldOnResize(); SXBB_oldOnResize = null; }
	SXBB_evalSize('onresize');
}
function SXBB_evalSize(cmd)
{
	for( var id in SXBB ) SXBB[id].resize(cmd);
}

if( window.addEventListener )
{
	// The DOM method
	window.addEventListener('load', SXBB_onLoad, false);
	window.addEventListener('resize', SXBB_onResize, false);
}
else if( window.attachEvent )
{
	// The IE Method
	window.attachEvent('onload', SXBB_onLoad);
	window.attachEvent('onresize', SXBB_onResize);
}
else
{
	// The 'legacy' method
	SXBB_oldOnLoad = window.onload;
	SXBB_oldOnResize = window.onresize;
	window.onload = SXBB_onLoad;
	window.onresize = SXBB_onResize;
}

// --------------------------------------------------------------------------------
}	// if( SXBB_IsOverflowAble() )
// --------------------------------------------------------------------------------
}	// if( typeof(SXBB) == 'undefined' )
// --------------------------------------------------------------------------------
