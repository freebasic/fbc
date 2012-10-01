'' threadcall AST transform
''
'' chng: oct/2011 written [jofers]

#include once "fb.bi"
#include once "fbint.bi"
#include once "ast.bi"
#include once "rtl.bi"

declare function hThreadCallPushType _
    ( _
        byval funcexpr as ASTNODE ptr, _
        byval tctype as FB_RTL_TCTYPES, _
        byval stype as FBSYMBOL ptr _
    ) as integer

'':::::
private function hThreadCallMapType _
    ( _
        byval sym as FBSYMBOL ptr, _
        byval udt as integer = FALSE _
    ) as FB_RTL_TCTYPES
    
    function = -1
    
    dim as FB_DATATYPE dtype = symbGetType( sym )
    dim as FBSYMBOL ptr stype = symbGetSubType( sym )
    
    '' arrays not supported inside udts
    if( symbIsArray( sym ) ) then 
        return iif( udt = TRUE, -1, FB_RTL_TCTYPES_PTR )
    end if
    
    '' pointers supported, but not obvious in dtype
    if( typeIsPtr( dtype ) ) then
        function = FB_RTL_TCTYPES_PTR
        exit function
    end if
    
    select case dtype
        case FB_DATATYPE_BYTE, FB_DATATYPE_CHAR
            function = FB_RTL_TCTYPES_BYTE
        case FB_DATATYPE_UBYTE
            function = FB_RTL_TCTYPES_UBYTE
        case FB_DATATYPE_SHORT, FB_DATATYPE_WCHAR
            function = FB_RTL_TCTYPES_SHORT
        case FB_DATATYPE_USHORT
            function = FB_RTL_TCTYPES_USHORT
        case FB_DATATYPE_INTEGER, FB_DATATYPE_ENUM
            function = FB_RTL_TCTYPES_INTEGER
        case FB_DATATYPE_UINT
            function = FB_RTL_TCTYPES_UINTEGER
        case FB_DATATYPE_LONGINT
            function = FB_RTL_TCTYPES_LONGINT
        case FB_DATATYPE_ULONGINT
            function = FB_RTL_TCTYPES_ULONGINT
        case FB_DATATYPE_SINGLE
            function = FB_RTL_TCTYPES_SINGLE
        case FB_DATATYPE_DOUBLE
            function = FB_RTL_TCTYPES_DOUBLE
        case FB_DATATYPE_STRING
            function = iif( udt = TRUE, -1, FB_RTL_TCTYPES_PTR )
        case FB_DATATYPE_STRUCT
            '' restrictions to simplify life
            if symbGetUDTIsUnion( stype ) then 
                exit function
            end if
            if symbGetUDTAlign( stype ) <> 0 then 
                exit function
            end if
            
            '' FB transforms type with 1 element to that element's type
            dim elems as integer = cint( symbGetUDTElements( stype ) )
            if elems = 1 then
                dim as FBSYMBOL ptr elem = symbGetUDTFirstElm( stype )
                function = hThreadCallMapType( elem, TRUE )
            else
                function = FB_RTL_TCTYPES_TYPE
            end if
        case else
            exit function
    end select
        
end function

'':::::
private function hThreadCallPushStruct _
    ( _
        byval funcexpr as ASTNODE ptr, _
        byval struct as FBSYMBOL ptr _
    ) as integer
    
    function = false
    
    '' push number of elements
    dim as integer elems
    dim as ASTNODE ptr elemexpr
    elems = symbGetUDTElements( struct )
    elemexpr = astNewCONSTi( elems, FB_DATATYPE_INTEGER )
    if( astNewArg( funcexpr, elemexpr ) = NULL ) then
        exit function
    end if
    
    '' push each element
    dim as FBSYMBOL PTR elem 
    elem = symbGetUDTFirstElm( struct )
    for i as integer = 1 to elems
        dim as FB_RTL_TCTYPES tctype = hThreadCallMapType( elem, TRUE )
        dim as FBSYMBOL ptr stype = symbGetSubType( elem )        
        if hThreadCallPushType( funcexpr, tctype, stype ) = FALSE then
            exit  function
        end if
        elem = symbGetUDTNextElm( elem, FALSE )
    next i
    
    function = true
end function
    
'':::::
private function hThreadCallPushType _
    ( _
        byval funcexpr as ASTNODE ptr, _
        byval tctype as FB_RTL_TCTYPES, _
        byval stype as FBSYMBOL ptr _
    ) as integer
    
    function = false
    
    '' Unsupported datatype
    if( tctype = -1 ) then
        errReport( FB_ERRMSG_UNSUPPORTEDFUNCTION )
        exit function
    end if
    
    '' push argument on stack
    dim as ASTNODE ptr typeexpr
    typeexpr = astNewCONSTi( tctype, FB_DATATYPE_INTEGER )
    if( astNewARG( funcexpr, typeexpr ) = NULL ) then
        exit function
    end if
    
    '' push type info to the stack
    if( tctype = FB_RTL_TCTYPES_TYPE ) then
        if( hThreadCallPushStruct( funcexpr, stype ) = FALSE ) then
            exit function
        end if
    end if
    
    function = true
end function

private function hGetExprRef( byval expr as ASTNODE ptr ) as ASTNODE ptr
	dim as FBSYMBOL ptr tmpvar = any, subtype = any
	dim as integer dtype = any

	if( astIsVAR( expr ) ) then
		'' already a variable? just get the address
		'' @expr
		function = astNewADDROF( expr )
	else
		'' copy expression to a variable, and get the address
		dtype = astGetDataType( expr )
		subtype = astGetSubType( expr )
		tmpvar = symbAddTempVar( dtype, subtype, FALSE )

		'' tmpvar = expr
		astAdd( astNewASSIGN( astNewVAR( tmpvar, 0, dtype, subtype ), _
		                      expr, AST_OPOPT_DONTCHKPTR ) )

		'' @tmpvar
		function = astNewADDROF( astNewVAR( tmpvar, 0, dtype, subtype ) )
	end if
end function

'':::::
function rtlThreadCall(byval callexpr as ASTNODE ptr) as ASTNODE ptr

    function = NULL

    dim as FBSYMBOL ptr proc, param
    dim as ASTNODE ptr procvarexpr, procvarptrexpr, procmodeexpr
    dim as ASTNODE ptr stacksizeexpr, argsexpr, ptrexpr
    
    proc = callexpr->sym
    
    '' copy off symbol and all the arguments
    dim args as integer = callexpr->call.args
    dim arg as ASTNODE ptr = callexpr->r
    dim argupper as integer = iif( args=0, 1, args )
    redim argexpr( 1 to argupper ) as ASTNODE ptr
    redim argmode( 1 to argupper ) as integer
    for i as integer = 1 to args
        if arg = 0 then
            exit function
        end if
        argexpr( args-i+1 ) = astCloneTREE( arg->l )
        argmode( args-i+1 ) = arg->arg.mode
        arg = arg->r
    next i
    
    '' delete call
    astDelTREE( callexpr )
    
    '' create new call
    dim as ASTNODE ptr expr = astNewCall( PROCLOOKUP( THREADCALL ) )

    '' push function argument
    procvarexpr = astNewVAR( proc, 0, FB_DATATYPE_FUNCTION, proc )
    procvarptrexpr = astNewADDROF( procvarexpr )
    if( astNewARG( expr, procvarptrexpr ) = NULL ) then
        exit function
    end if

    '' get calling convention
    dim as integer procmode, procmode_fb
    procmode_fb = symbGetProcMode( proc )
    if procmode_fb = FB_USE_FUNCMODE_FBCALL then procmode_fb = env.target.fbcall
    if( procmode_fb = FB_FUNCMODE_CDECL ) then
        procmode = FB_RTL_TCTYPES_CDECL
    elseif( procmode_fb = FB_FUNCMODE_STDCALL _
        and env.clopt.target = FB_COMPTARGET_WIN32 ) then
        procmode = FB_RTL_TCTYPES_STDCALL
    else
        errReport( FB_ERRMSG_UNSUPPORTEDFUNCTION )
        exit function
    end if

    '' push calling convention
    procmodeexpr = astNewCONSTi( procmode, FB_DATATYPE_INTEGER )
    if( astNewARG( expr, procmodeexpr ) = NULL ) then
        exit function
    end if
    
    '' push stack size (not in syntax)
    stacksizeexpr = astNewCONSTi( 0, FB_DATATYPE_INTEGER )
    if( astNewARG( expr, stacksizeexpr ) = NULL ) then
        exit function
    end if
    
    '' push number of arguments
    argsexpr = astNewCONSTi( args, FB_DATATYPE_INTEGER )
    if( astNewARG( expr, argsexpr ) = NULL ) then
        exit function
    end if
    
    '' push each argument type
    param = symbGetProcLastParam( proc )
    for i as integer = 1 to args
    
        '' allow byval and byref
        dim as FB_PARAMMODE mode
        dim as FB_RTL_TCTYPES tctype = -1
        mode = symbGetParamMode( param )
        
        tctype = hThreadCallMapType( param )
        select case mode
            case FB_PARAMMODE_BYVAL
            case FB_PARAMMODE_BYREF, FB_PARAMMODE_BYDESC
                if( tctype <> -1 ) then 
                    tctype = FB_RTL_TCTYPES_PTR
                end if
            case else
                tctype = -1
        end select
        
        '' push parameter type
        dim as FBSYMBOL ptr stype = symbGetSubType( param )
        if hThreadCallPushType( expr, tctype, stype ) = FALSE then
            exit function
        end if

        '' get pointer to argument
        ptrexpr = hGetExprRef( argexpr( i ) )

        ''byref
        dim isstring as integer
        isstring = typeGetDtOnly( astGetDataType( argexpr( i ) ) )
        if( mode = FB_PARAMMODE_BYREF and _
            argmode( i ) <> FB_PARAMMODE_BYVAL and _
            isstring = FALSE ) then
            ptrexpr = hGetExprRef( ptrexpr )
        end if
        
        if( ptrexpr = NULL ) then
            exit function
        end if
        
        '' push pointer to argument
        if( astNewARG( expr, ptrexpr ) = NULL ) then
            exit function
        end if
        
        param = symbGetProcPrevParam( proc, param )
    next

	function = expr
end function
