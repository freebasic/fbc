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
		/' function fb_ProfileBeginCall ( byval procname as const zstring ptr ) as const any ptr '/ _
		( _
			@FB_RTL_PROFILEBEGINCALL, NULL, _
			typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' sub fb_ProfileEndCall ( byval call as const any ptr ) '/ _
		( _
			@FB_RTL_PROFILEENDCALL, NULL, _
			FB_DATATYPE_VOID, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					typeAddrOf( typeSetIsConst( FB_DATATYPE_VOID ) ), FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		/' function fb_EndProfile ( byval errlevel as integer ) as integer '/ _
		( _
			@FB_RTL_PROFILEEND, NULL, _
			FB_DATATYPE_INTEGER, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			1, _
			{ _
				( _
					FB_DATATYPE_INTEGER, FB_PARAMMODE_BYVAL, FALSE _
				) _
			} _
		), _
		( NULL ) _
	}

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
			NULL, FB_RTL_OPT_REQUIRED, _
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
	rtlAddIntrinsicProcs( @funcdata(0) )
end sub

sub rtlProfileModEnd( )
	'' procs will be deleted when symbEnd is called
end sub

'':::::
private function hGetProcName _
	( _
		byval proc as FBSYMBOL ptr _
	) as ASTNODE ptr static

	dim as FBSYMBOL ptr s = any
	dim as ASTNODE ptr expr = any
	dim as integer lgt

	if( proc = NULL ) then
		s = symbAllocStrConst( "(??)", -1 )

	else
		dim as string procname
		procname = *symbGetDBGName( proc )
		lgt = len( procname )
		s = symbAllocStrConst( procname, lgt )
	end if

	expr = astNewADDROF( astNewVAR( s, 0, FB_DATATYPE_CHAR ) )

	function = expr

end function

'':::::
function rtlProfileBeginCall _
	( _
		byval sym as FBSYMBOL ptr _
	) as ASTNODE ptr

	dim as ASTNODE ptr proc, expr

	function = NULL

	'' don't add profiling inside a ctor or dtor
	if( (symbGetStats( parser.currproc ) and _
		(FB_SYMBSTATS_GLOBALCTOR or FB_SYMBSTATS_GLOBALDTOR)) <> 0 ) then
		exit function
	end if

	proc = astNewCALL( PROCLOOKUP( PROFILEBEGINCALL ), NULL, FALSE )

	expr = hGetProcName( sym )
	if( astNewARG( proc, expr ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlProfileEndCall( ) as ASTNODE ptr
	dim as ASTNODE ptr proc = any, expr = any

	proc = astNewCALL( PROCLOOKUP( PROFILEENDCALL ), NULL, FALSE )

	'' place holder
	expr = astNewCONSTi( 0, typeAddrOf( FB_DATATYPE_VOID ) )

	if( astNewARG( proc, expr ) = NULL ) then
		exit function
	end if

	function = proc

end function

'':::::
function rtlProfileCall_mcount( ) as ASTNODE ptr
	function = astNewCALL( PROCLOOKUP( PROFILEMCOUNT ), NULL, FALSE )
end function

sub rtlProfileCall_monstartup( )
	'' on mingw monstartup has two flavours 'monstartup(2)' and '_monstartup(0)'
	'' we are using the _monstartup(0) taking 0 arguments.
	astAdd( astNewCALL( PROCLOOKUP( PROFILEMONSTARTUP ), NULL, FALSE ) )
end sub
