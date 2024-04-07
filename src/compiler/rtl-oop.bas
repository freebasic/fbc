'' intrinsic runtime lib OOP functions (is operator, dynamic cast, ...)
''
'' chng: apr/2011 written [v1ctor]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

	dim shared as FB_RTL_PROCDEF funcdata( 0 to 3 ) = _
	{ _
		/' function fb_IsTypeOf( byref obj as any, byref rtti as fb_RTTI$ ) as long '/ _
		( _
			@FB_RTL_ISTYPEOF, NULL, _
			FB_DATATYPE_LONG, FB_FUNCMODE_FBCALL, _
			NULL, FB_RTL_OPT_NONE, _
			2, _
			{ _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ), _
				( FB_DATATYPE_VOID, FB_PARAMMODE_BYREF, FALSE ) _
			} _
		), _
		/' EOL '/ _
		( _
			NULL _
		) _
	 }

'':::::
sub rtlOOPModInit( )

	rtlAddIntrinsicProcs( @funcdata(0) )

end sub

'':::::
sub rtlOOPModEnd( )

	'' procs will be deleted when symbEnd is called

end sub

'':::::
function rtlOOPIsTypeOf _
	( _
		byval inst as ASTNODE ptr, _
		byval rtti as ASTNODE ptr _
	) as ASTNODE ptr


	var proc = astNewCALL( PROCLOOKUP( ISTYPEOF ) )

	'' byref obj as any ptr
	if( astNewARG( proc, inst ) = NULL ) then
		exit function
	end if

	'' byref rtti as any ptr
	if( astNewARG( proc, rtti ) = NULL ) then
		exit function
	end if

	function = proc

end function
