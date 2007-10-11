''
'' to compile: fbc callback.bas common.bas
''



#include once "common.bi"

const script = "alert('hello');" 

''::::
private function alert_cb cdecl _ 
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
    
   print "message: "; *JS_GetStringBytes( JS_ValueToString( cx, argv[0] ) ) 

   return 1 

end function 

'' main
    dim as sm ptr sm = sm_create( )
    
    if( sm = 0 ) then
    	end 1
    end if

	sm_addfunction( sm, "alert", @alert_cb, 1 )
	
    sm_eval( sm, script )
    
    sm_destroy( sm )

