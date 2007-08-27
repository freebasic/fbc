''
'' this is a help module, don't compile as standalone app
''



#include once "common.bi"

''::::
function sm_create _
	( _
		byval rt_maxbytes as integer, _
		byval cx_stacksize as integer _
	) as sm ptr
	
    static as JSClass global_class = ( _
        @"global", 0, _
        @JS_PropertyStub, @JS_PropertyStub, @JS_PropertyStub, @JS_PropertyStub, _
        @JS_EnumerateStub, @JS_ResolveStub, @JS_ConvertStub, @JS_FinalizeStub  _
    )
    
    dim as sm ptr sm = allocate( len( sm ) )
    if( sm = NULL ) then
    	return NULL
    end if

    sm->rt = JS_NewRuntime( rt_maxbytes ) 
    sm->cx = JS_NewContext( sm->rt, cx_stacksize ) 
    sm->global = JS_NewObject( sm->cx, @global_class, NULL, NULL ) 
    JS_InitStandardClasses( sm->cx, sm->global )

	function = sm
	
end function

''::::
sub sm_destroy _
	( _
		byval sm as sm ptr _
	)

	if( sm = NULL ) then
		exit sub
	end if
	
	JS_DestroyContext( sm->cx )
	JS_DestroyRuntime( sm->rt )
	
	deallocate( sm )

end sub

''::::
function sm_eval _
	( _
		byval sm as sm ptr, _
		byval script as zstring ptr _
	) as zstring ptr
				  
    dim as jsval rval

	if( sm = NULL ) then
		return NULL
	end if

    if( JS_EvaluateScript( sm->cx, sm->global, script, len( *script ), "localhost", 1, @rval) = 0 ) then
		return NULL
	end if
    
    function = JS_GetStringBytes( JS_ValueToString( sm->cx, rval ) )
				  
end function

''::::
function sm_addfunction _
	( _
		byval sm as sm ptr, _
		byval funcname as zstring ptr, _
		byval funcaddr as JSNative, _
		byval params as integer, _
		byval attributes as integer = 0 _
	) as JSFunction ptr

	function = JS_DefineFunction( sm->cx, sm->global, funcname, funcaddr, params, attributes ) 
	
end function
    
''::::
function sm_load _
	( _
		byval filename as string _
	) as string
	
	dim as integer finp
	
	finp = freefile
	if( open( filename, for input, access read, as #finp )	<> 0 ) then
		return ""
	end if
	
	dim as string res, ln
	
	do until( eof( finp ) )
		line input #finp, ln
		res += ln
	loop
	
	close #finp
	
	function = res
	
end function
