' TEST_MODE : COMPILE_ONLY_OK

sub replace (byref subject as string, byref oldtext as string, byref newtext as string)
end sub

'' :::::
sub replace (byref subject as string, oldtext() as string, byref newtext as string)
end sub


'' :::::
sub replace (byref subject as string, oldtext() as string, newtext() as string)
end sub

'' :::::
sub replace (subject() as string, byref oldtext as string, byref newtext as string)
end sub

'' :::::
sub replace (subject() as string, oldtext() as string, byref newtext as string)
end sub

'' :::::
sub replace (subject() as string, oldtext() as string, newtext() as string)
end sub

