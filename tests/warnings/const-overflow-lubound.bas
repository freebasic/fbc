dim array1(0 to 1) as integer
print ubound( array1, &hFF00000000ull )
print lbound( array1, &hFF00000000ull )

dim array2() as integer
print ubound( array2, &hFF00000000ull )
print lbound( array2, &hFF00000000ull )
