type foo 
  s as string 
  l as longint
end type 

const TEST_VAL = &hdeadbeefdeadc0de

	dim as foo ptr bar

	bar = allocate( len( foo ) ) 

	bar->l = TEST_VAL

	*cast( byte ptr, @bar->l ) = 0

	assert( bar->l = (TEST_VAL and not 255) )