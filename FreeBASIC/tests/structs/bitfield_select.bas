type ud  
   d:1 as uinteger 
end type 

type uc  
   c as ud 
end type 

type ub  
   b as uc ptr 
end type 

	dim a as ub ptr 

	a = callocate( len( ub ) ) 
	a->b = callocate( len( uc ) ) 
	
	assert( a->b->c.d = 0 )
	a->b->c.d = 1 
	assert( a->b->c.d = 1 )
	
	select case a->b->c.d 
	case 0
		assert( 0 )
	case 1
		'ok
	case else
		assert( 0 )
	end select
	
	deallocate a->b 
	deallocate a
