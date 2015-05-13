' TEST_MODE : COMPILE_ONLY_FAIL

dim psub1 as sub( )
dim psub2 as sub( i as integer )
dim c as integer
print iif( c, psub1, psub2 )
