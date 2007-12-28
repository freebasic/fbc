' TEST_MODE : COMPILE_ONLY_OK

sub replace overload (byref subject as string, byref oldtext as string, byref newtext as string)
end sub

'' :::::
sub replace overload (byref subject as string, oldtext() as string, byref newtext as string)
end sub


'' :::::
sub replace overload (byref subject as string, oldtext() as string, newtext() as string)
end sub

'' :::::
sub replace overload (subject() as string, byref oldtext as string, byref newtext as string)
end sub

'' :::::
sub replace overload (subject() as string, oldtext() as string, byref newtext as string)
end sub

'' :::::
sub replace overload (subject() as string, oldtext() as string, newtext() as string)
end sub

