#print "SELECT CONST with 64bit value, no warning (should use 64bit temp var):"
select case as const( &hFF00000000ull )
case 0
end select

dim as long l
select case as const( l )
#print "CASE with 64bit value, causes a warning because it's a SELECT CONST with 32bit value:"
case &hFF00000000ull
end select
