''
'' to compile: fbc function_cb.bas common.bas
''

#include once "common.bi"

const script = "print( ucase( 'hello' ) );" 

''::::
private function print_cb cdecl _ 
   ( _ 
      byval cx as JSContext ptr, _ 
      byval obj as JSObject ptr, _ 
      byval argc as uintN, _ 
      byval argv as jsval ptr, _ 
      byval rval as jsval ptr _ 
   ) as JSBool 
    
   if( argc < 1 ) then 
      return 0 
   end if 
    
   print *JS_GetStringBytes( JS_ValueToString( cx, argv[0] ) ) 

   return 1 

end function 

''::::
private function ucase_cb cdecl _ 
   ( _ 
      byval cx as JSContext ptr, _ 
      byval obj as JSObject ptr, _ 
      byval argc as uintN, _ 
      byval argv as jsval ptr, _ 
      byval rval as jsval ptr _ 
   ) as JSBool 
    
   if( argc < 1 ) then 
      return 0 
   end if 
    
   '' get argument 1
   dim as zstring ptr arg1 = JS_GetStringBytes( JS_ValueToString( cx, argv[0] ) ) 
   
   '' alloc result (JS_NewString will reuse the buffer passed, not allocate a new one)
   dim as zstring ptr result = JS_malloc( cx, len( *arg1 )+1 )
   
   '' 
   *result = ucase( *arg1 )
   
   '' return it in rval
   *rval = STRING_TO_JSVAL( JS_NewString( cx, result, len( *result ) ) )

   return 1 

end function 

'' main
    dim as sm ptr sm = sm_create( )
    
    if( sm = 0 ) then
    	end 1
    end if

	sm_addfunction( sm, "print", @print_cb, 1 )
	sm_addfunction( sm, "ucase", @ucase_cb, 1 )
	
    sm_eval( sm, script )
    
    sm_destroy( sm )

