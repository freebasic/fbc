#define merge(seq) letter seq
#define letter(seq) #seq + letter
#define letter__ ""

	if( merge( (H)(e)(l)(l)(o)(.)(W)(o)(r)(l)(d)(!)__ ) <> "Hello.World!" ) then
		assert( 0 )
	end if



