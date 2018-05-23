#print "SELECT CONST with 64bit value, no warning (should use 64bit temp var):"
select case as const( &hFF00000000ull )
case 0
end select

#print "also no warning for CASE value > 32bit:"
select case as const( &hFF00000000ull )
case &hFF00000000ull
end select

#ifndef __FB_64BIT__

dim as long l
select case as const( l )
#print "CASE with 64bit value, causes a warning because it's a SELECT CONST with 32bit value:"
case &hFF00000000ull
#print "SELECT CONST with 64bit expression, causes a warning because it's used with 32bit value:"
end select

#endif
