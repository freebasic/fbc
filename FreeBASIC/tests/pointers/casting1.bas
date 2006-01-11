option explicit

const TEST_VAL = &hDeadC0de

type fluff as udttype

type funcudt
	field	as integer
end type

type functype as function( ) as funcudt ptr

type udttype
	fparray  as functype ptr
end type
	
declare function realfunc( ) as funcudt ptr
	
	dim as udttype t
	
	dim as any ptr p
	dim as any ptr ptr pptr
	
	p = @t
	pptr = @p
	
	t.fparray = cast( any ptr ptr, callocate( 11 * len( functype ) ) )
	
	t.fparray[10] = @realfunc
	
	assert( cast(udttype ptr, *cast(any ptr ptr, pptr))->fparray[10]()->field = TEST_VAL )
	

'':::::
function realfunc( ) as funcudt ptr
	static as funcudt t = ( TEST_VAL )

	function = @t

end function
