extern "windows"
	sub fWindows( byval i as integer )
	end sub
end extern

extern "windows-ms"
	sub fWindowsMs( byval i as integer )
	end sub
end extern

sub fStdcall stdcall( byval i as integer )
end sub

sub fCdecl cdecl( byval i as integer )
end sub

sub fDefault( byval i as integer )
end sub

dim pStdcall as sub stdcall( byval as integer )
dim pCdecl as sub cdecl( byval as integer )
dim pDefault as sub( byval as integer )

#print "no warnings:"
#print "stdcall:"
pStdcall = @fWindows
pStdcall = @fWindowsMs
pStdcall = @fStdcall

#print "cdecl:"
pCdecl = @fCdecl

#print "default:"
pDefault = @fDefault

#print
#print "but this should cause warnings (no matter what system):"
#print "1."
pCdecl = @fWindows
#print "2."
pCdecl = @fWindowsMs
#print "3."
pCdecl = @fStdcall
#print "4."
pStdcall = @fCdecl

#print "return byref:"
function f1( ) byref as integer
	static as integer x
	function = x
end function

function f2( ) as integer
	function = 123
end function

dim p1 as function( ) byref as integer
dim p2 as function( ) as integer

#print "no warnings:"
p1 = @f1
p2 = @f2

#print "two warnings:"
p1 = @f2
p2 = @f1
