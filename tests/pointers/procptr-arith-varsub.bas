' TEST_MODE : COMPILE_ONLY_FAIL

sub sub1( )
end sub

sub sub2( )
end sub

dim as sub( ) p1 = @sub1, p2 = @sub2
print p1 - p2
