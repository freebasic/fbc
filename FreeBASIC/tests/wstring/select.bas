

	dim w as wstring * 10 => "abc"
	
	
	select case w
	case "1" to "10"
		assert( 0 )
	
	case "def"		
		assert( 0 )
	
	case "abc"
		assert( -1 )
		
	case else
		assert( 0 )	
	
	end select