' TEST_MODE : COMPILE_ONLY_FAIL

sub sub1( )
end sub

sub sub2( i as integer )
end sub

dim c as integer
print iif( c, @sub1, @sub2 )
