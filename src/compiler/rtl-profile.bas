'' intrinsic runtime lib profiling functions
''
'' chng: oct/2004 written [v1ctor]


#include once "fb.bi"
#include once "fbint.bi"
#include once "parser.bi"
#include once "ast.bi"
#include once "rtl.bi"

	'' On win32, dos, linux-x86 and linux-x86_64, it's called "mcount"
	dim shared as FB_RTL_PROCDEF dataMcountNormal(0 to 1) = _
	{ _
		/' sub mcount cdecl( ) '/ _
		( _
			@FB_RTL_PROFILEMCOUNT, @"mcount", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		( NULL ) _
	}

	'' but on win64, it's called "_mcount"
	dim shared as FB_RTL_PROCDEF dataMcountWin64(0 to 1) = _
	{ _
		/' sub _mcount cdecl( ) '/ _
		( _
			@FB_RTL_PROFILEMCOUNT, @"_mcount", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		( NULL ) _
	}

	dim shared as FB_RTL_PROCDEF dataMonstartup(0 to 1) = _
	{ _
		/' sub _monstartup cdecl( ) '/ _
		( _
			@FB_RTL_PROFILEMONSTARTUP, @"_monstartup", _
			FB_DATATYPE_VOID, FB_FUNCMODE_CDECL, _
			NULL, FB_RTL_OPT_NONE, _
			0 _
		), _
		( NULL ) _
	}

sub rtlProfileModInit( )
	if( (env.clopt.target = FB_COMPTARGET_WIN32) and fbIs64bit( ) ) then
		rtlAddIntrinsicProcs( @dataMcountWin64(0) )
	else
		rtlAddIntrinsicProcs( @dataMcountNormal(0) )
	end if
	rtlAddIntrinsicProcs( @dataMonstartup(0) )
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
