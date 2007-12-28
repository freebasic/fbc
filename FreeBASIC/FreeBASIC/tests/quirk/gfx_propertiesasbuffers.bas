' TEST_MODE : COMPILE_ONLY_OK

type Image

    as any ptr m_buffer

    declare property Buffer( ) as any ptr
    declare property Buffer(byval as any ptr)

end type

property Image.Buffer(byval b as any ptr)
	this.m_buffer = b
end property
property Image.Buffer( ) as any ptr
	return this.m_buffer
end property
	

sub propertyAsSource cdecl( )

  dim as image img

  put (0,0), img.buffer
  
end sub

sub propertyAsTarget cdecl( )

  dim as image img
  dim as any ptr fakeBuffer
  
  pset img.buffer, ( 0, 0 ), 15
  preset img.buffer, ( 0, 0 ), 15
  line img.buffer, ( 0, 0 )-( 1, 1 ), 15
  circle img.buffer, ( 0, 0 ), 10
  paint img.buffer, ( 0, 0 ), 10
  draw string img.buffer, ( 0, 0 ), "uurrddddll"
  get ( 0, 0 )-( 1, 1 ), img.buffer
  put img.buffer, (0,0), fakeBuffer
  
  '' also testing another fix, unique
  '' to DRAW...
  draw img.buffer, "uurrddddll"

end sub
    
screen 13 