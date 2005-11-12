option private

enum RESULT	
	RESULT_INT
	RESULT_UINT
	RESULT_SNG
	RESULT_DBL
	RESULT_LNG
	RESULT_INTPTR
	RESULT_UINTPTR
	RESULT_SNGPTR
	RESULT_DBLPTR
	RESULT_LNGPTR
	RESULT_BARENUM
	RESULT_BARENUMPTR
	RESULT_BAZENUM
	RESULT_BAZENUMPTR
end enum

enum barenum
	enum0, enum1, enum2
end enum

enum bazenum
	enum3, enum4, enum5
end enum

declare function foo overload ( byval bar as integer ) as RESULT
declare function foo 		 ( byval bar as uinteger ) as RESULT
declare function foo 		 ( byval bar as single ) as RESULT
declare function foo 		 ( byval bar as double ) as RESULT
declare function foo 		 ( byval bar as longint ) as RESULT
declare function foo 		 ( byval bar as barenum ) as RESULT
declare function foo 		 ( byval bar as bazenum ) as RESULT
declare function foo 		 ( byval bar as integer ptr ) as RESULT
declare function foo 		 ( byval bar as uinteger ptr ) as RESULT
declare function foo 		 ( byval bar as single ptr ) as RESULT
declare function foo 		 ( byval bar as double ptr ) as RESULT
declare function foo 		 ( byval bar as longint ptr ) as RESULT
declare function foo 		 ( byval bar as barenum ptr ) as RESULT
declare function foo 		 ( byval bar as bazenum ptr ) as RESULT

	dim intvar as integer
	dim uintvar as uinteger
	dim fltvar as single
	dim dblvar as double
	dim lngvar as longint
	dim barvar as barenum
	dim bazvar as bazenum
	
	assert( foo( intvar ) = RESULT_INT )
	assert( foo( uintvar ) = RESULT_UINT )
	assert( foo( fltvar ) = RESULT_SNG )
	assert( foo( dblvar ) = RESULT_DBL )
	assert( foo( lngvar ) = RESULT_LNG )
	assert( foo( barvar ) = RESULT_BARENUM )
	assert( foo( bazvar ) = RESULT_BAZENUM )
	
	dim intptrvar as integer ptr
	dim uintptrvar as uinteger ptr
	dim fltptrvar as single ptr
	dim dblptrvar as double ptr
	dim lngptrvar as longint ptr
	dim barptrvar as barenum ptr
	dim bazptrvar as bazenum ptr
	
	assert( foo( intptrvar ) = RESULT_INTPTR )
	assert( foo( uintptrvar ) = RESULT_UINTPTR )
	assert( foo( fltptrvar ) = RESULT_SNGPTR )
	assert( foo( dblptrvar ) = RESULT_DBLPTR )
	assert( foo( lngptrvar ) = RESULT_LNGPTR )
	assert( foo( barptrvar ) = RESULT_BARENUMPTR )
	assert( foo( bazptrvar ) = RESULT_BAZENUMPTR )
	
	assert( foo( cdbl( intvar ) ) = RESULT_DBL )
	assert( foo( intvar + dblvar ) = RESULT_DBL )
	
'':::::
function foo ( byval bar as integer ) as RESULT

	function = RESULT_INT

end function

'':::::
function foo ( byval bar as uinteger ) as RESULT

	function = RESULT_UINT

end function

'':::::
function foo ( byval bar as single ) as RESULT

	function = RESULT_SNG

end function

'':::::
function foo ( byval bar as double ) as RESULT

	function = RESULT_DBL

end function

'':::::
function foo ( byval bar as longint ) as RESULT

	function = RESULT_LNG

end function
		

'':::::
function foo ( byval bar as integer ptr ) as RESULT

	function = RESULT_INTPTR

end function

'':::::
function foo ( byval bar as uinteger ptr ) as RESULT

	function = RESULT_UINTPTR

end function

'':::::
function foo ( byval bar as single ptr ) as RESULT

	function = RESULT_SNGPTR

end function

'':::::
function foo ( byval bar as double ptr ) as RESULT

	function = RESULT_DBLPTR

end function

'':::::
function foo ( byval bar as longint ptr ) as RESULT

	function = RESULT_LNGPTR

end function

'':::::
function foo ( byval bar as barenum ) as RESULT

	function = RESULT_BARENUM

end function

'':::::
function foo ( byval bar as barenum ptr ) as RESULT

	function = RESULT_BARENUMPTR

end function

'':::::
function foo ( byval baz as bazenum ) as RESULT

	function = RESULT_BAZENUM

end function

'':::::
function foo ( byval baz as bazenum ptr ) as RESULT

	function = RESULT_BAZENUMPTR

end function
