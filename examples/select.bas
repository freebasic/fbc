dim as integer x = 5
dim as integer y = -1

'' Sequential checks (shorter notation for IF statements)
select case x
case 1
	print "it's 1"
case 2, 3, 4
	print "it's one of 2, 3 or 4"
case is >= 5
	print "it's >= 5"
case y
	print "same as y"
case else
	print "something else"
end select

'' Using a jump table (faster if there are lots of checks, but can only be used
'' to check against constants):
select case as const x
case 1
	print "it's 1"
case 2, 3, 4
	print "it's one of 2, 3 or 4"
case 5
	print "it's 5"
case else
	print "something else"
end select
