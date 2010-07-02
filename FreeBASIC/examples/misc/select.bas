''
'' select example, comparing the ordinary one with select as const
'' 

const inter = 50000000

	dim as double t = timer
	dim as integer j = 0, i
	for i = 1 to inter		
		select case i
		case 1, 3, 5, 7, 9
			j += 1
		case 2, 4, 6, 8, 10
			j -= 1
		case 11 to 20
			j += 1
		case 21 to 30
			j -= 1
		case is >= 31
			j = j
		case else
			print "can't happen"
		end select
	next i
	print using "normal select_, secs taken: ##.###"; timer - t
	
	print "0 ="; j
	

	t = timer
	j = 0
	for i = 1 to inter
		select case as const i
		case 1, 3, 5, 7, 9
			j += 1
		case 2, 4, 6, 8, 10
			j -= 1
		case 11 to 20
			j += 1
		case 21 to 30
			j -= 1
		case else
			if( i >= 31 ) then
				j = j
			else
				print "can't happen"
			end if
		end select
	next i
	print using "as const select_, secs taken: ##.###"; timer - t
	
	print "0 ="; j
	
	sleep
