#print "SELECT:"
select case as const( &hFF00000000ull )
case 0
end select

#print "CASE:"
select case as const( 0 )
case &hFF00000000ull
end select
