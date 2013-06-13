#lang "fblite"

dim i as integer

#print "SELECT CASE [AS CONST] with simple integer temp var, no warnings:"

goto select11
select case( 0 )
case 0
	select11:
end select

goto select12
select case( i )
case 0
	select12:
end select

goto select13
select case as const( 0 )
case 0
	select13:
end select

goto select14
select case as const( i )
case 0
	select14:
end select
