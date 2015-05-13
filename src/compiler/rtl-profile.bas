'' intrinsic runtime lib profiling functions
''
'' chng: oct/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to ... ) = _
	{ _
		/' mcount cdecl ( void ) as void'/ _
		( _
			@FB_RTL_PROFILEMCOUNT, @"mcount", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' _monstartup CDECL ( ) as void '/ _
		( _
			@FB_RTL_PROFILEMONSTARTUP, @"_monstartup", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	}

sub rtlProfileModInit( )
	rtlAddIntrinsicProcs( @funcdata(0) )
end sub

sub rtlProfileModEnd( )
	'' procs will be deleted when symbEnd is called
end sub

function rtlProfileCall_mcount( ) as ASTNODE ptr
	function = astNewCALL( PROCLOOKUP( PROFILEMCOUNT ), NULL )
end function

sub rtlProfileCall_monstartup( )
	'' on mingw monstartup has two flavours 'monstartup(2)' and '_monstartup(0)'
	'' we are using the _monstartup(0) taking 0 arguments.
	astAdd( astNewCALL( PROCLOOKUP( PROFILEMONSTARTUP ), NULL ) )
end sub
