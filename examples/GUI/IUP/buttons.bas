 
#include once "IUP/iup.bi" 

#define NULL 0 

declare function ok_onclick cdecl (byval handler as Ihandle ptr) as long 
declare function close_onclick cdecl (byval handler as Ihandle ptr) as long 

	if( IupOpen( NULL, NULL ) = IUP_ERROR ) then
		end 1
	end if

	dim as Ihandle ptr ok_button, close_button
	dim as Ihandle ptr main_dlg 

  	ok_button = IupButton( "Open", "ok_act" ) 
  	close_button = IupButton( "Close", "close_act" ) 

  	main_dlg = IupDialog( _
  						  IupVbox( _
  								   IupHbox( IupLabel( "" ), NULL ), _  						  		   
  						  		   IupHbox( IupFill(), ok_button, IupFill(), close_button, IupFill(), NULL ), _
  						  		   IupHbox( IupLabel( "" ), NULL ), _
  						  		   NULL _
  						  		 ) _
  						) 

	IupSetAttributes( main_dlg, "TITLE=IupButton, DEFAULTENTER=ok_button, MAXBOX=NO, MINBOX=NO, RESIZE=NO" )
	
	IupSetFunction( "ok_act", @ok_onclick ) 
	IupSetFunction( "close_act", @close_onclick )
	
	IupSetHandle( "ok_button", ok_button )

	IupShowXY( main_dlg, IUP_CENTER, IUP_CENTER ) 

	IupMainLoop( ) 
	IupClose( ) 

	end 0

'' 
function ok_onclick cdecl (byval handler as Ihandle ptr) as long 
  
  IupMessage( "IupMessage", "Press OK" ) 
  
  function = IUP_DEFAULT 

end function 

'' 
function close_onclick cdecl (byval handler as Ihandle ptr) as long 
  
  function = IUP_CLOSE

end function 

