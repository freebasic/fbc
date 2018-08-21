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
dim p1 as sub stdcall( )
dim p2 as sub cdecl  ( )
dim p3 as sub pascal ( )

#print "no warnings:"
pStdcall = @fWindows
pStdcall = @fWindowsMs
pStdcall = @fStdcall
pCdecl = @fCdecl
pDefault = @fDefault

'' The following should cause warnings even on x86_64 where calling
'' conventions have no effect, so that the user is notified of
'' mismatches that would become bugs on x86.
#print "2 warnings:"
pCdecl = @fWindows
#print "2 warnings:"
pCdecl = @fWindowsMs
#print "2 warnings:"
pCdecl = @fStdcall
#print "2 warnings:"
pStdcall = @fCdecl

#print "2 warnings:"
p1 = p2
#print "2 warnings:"
p1 = p3

#print "2 warnings:"
p2 = p1
#print "2 warnings:"
p2 = p3

#print "2 warnings:"
p3 = p1
#print "2 warnings:"
p3 = p2
