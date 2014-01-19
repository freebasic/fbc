# include "fbcu.bi"
#include once "fbgfx.bi"

namespace fbc_tests.gfx.fb_image_expr

const TRUE = -1
const FALSE = 0

const SCREEN_W = 16
const SCREEN_H = 16

private function hScreenIsFilledWithColor( byval col as ulong ) as integer
	'' Assuming 32bit screen
	dim as integer w, h, depth, bpp, pitch
	screeninfo w, h, depth, bpp, pitch
	CU_ASSERT( w = SCREEN_W )
	CU_ASSERT( h = SCREEN_H )
	CU_ASSERT( depth = 32 )
	CU_ASSERT( bpp = 4 )
	CU_ASSERT( pitch = bpp*w )

	screenlock( )

	dim as ulong ptr p = screenptr( )
	CU_ASSERT( p )

	function = TRUE
	for i as integer = 0 to (w * h)-1
		if( p[i] <> col ) then
			function = FALSE
			exit for
		end if
	next

	screenunlock( )
end function

private function hImageIsFilledWithColor( byval buffer as any ptr, byval col as ulong ) as integer
	dim as fb.IMAGE ptr img = buffer
	CU_ASSERT( img->width = SCREEN_W )
	CU_ASSERT( img->height = SCREEN_H )
	CU_ASSERT( img->bpp = 4 )
	CU_ASSERT( img->pitch = img->width * img->bpp )

	function = TRUE
	for i as integer = 0 to (img->width * img->height)-1
		if( cptr( ulong ptr, img + 1 )[i] <> col ) then
			function = FALSE
			exit for
		end if
	next
end function

private sub hResetImageToBlack( byval p as any ptr )
	line p, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,0), bf
	CU_ASSERT( hImageIsFilledWithColor( p, rgb(0,0,0) ) )
end sub

type ImageUdt1
	header as fb.IMAGE
	pixels(0 to (SCREEN_W*SCREEN_H)-1) as ulong  '' room for WxH 32bit pixels behind the header
end type

type SomeUdt1
	i as integer
	d as double
end type

type DerivedUdt1 extends SomeUdt1
	i as integer
	d as double
end type

type DerivedUdt2 extends object
	i as integer
	d as double
end type

const IMAGE_BUFFER_SIZE = sizeof(fb.IMAGE) + (SCREEN_W*SCREEN_H*4)

'' All the quirk gfx commands which have target/source image parameters
'' should work fine when they're used
private sub hTestAllGfxCommands( )
	dim as any ptr a = imagecreate( SCREEN_W, SCREEN_H, rgb(  0,0,0) )
	dim as any ptr b = imagecreate( SCREEN_W, SCREEN_H, rgb(255,0,0) )

	CU_ASSERT( hImageIsFilledWithColor( a, rgb(  0,0,0) ) )
	CU_ASSERT( hImageIsFilledWithColor( a, rgb(255,0,0) ) = FALSE )
	CU_ASSERT( hImageIsFilledWithColor( b, rgb(  0,0,0) ) = FALSE )
	CU_ASSERT( hImageIsFilledWithColor( b, rgb(255,0,0) ) )

	line a, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
	CU_ASSERT( hImageIsFilledWithColor( a, rgb(255,0,0) ) )
	hResetImageToBlack( a )

	pset a, (0, 0), rgb(255,0,0)
	CU_ASSERT( hImageIsFilledWithColor( a, rgb(0,0,0) ) = FALSE )
	hResetImageToBlack( a )

	circle a, (0, 0), 2, rgb(255,0,0)
	CU_ASSERT( hImageIsFilledWithColor( a, rgb(0,0,0) ) = FALSE )
	hResetImageToBlack( a )

	paint a, (0, 0), rgb(255,0,0), rgb(255,255,255)
	CU_ASSERT( hImageIsFilledWithColor( a, rgb(255,0,0) ) )
	hResetImageToBlack( a )

	draw string a, (0, 0), "testing", rgb(255,0,0)
	CU_ASSERT( hImageIsFilledWithColor( a, rgb(0,0,0) ) = FALSE )
	hResetImageToBlack( a )

	'' TODO: Draw String custom font image

	draw a, "BM 0,0 P " & rgb(255,0,0) & "," & rgb(255,255,255)
	CU_ASSERT( hImageIsFilledWithColor( a, rgb(255,0,0) ) )
	hResetImageToBlack( a )

	'' TODO: Palette Using

	CU_ASSERT( hImageIsFilledWithColor( b, rgb(255,0,0) ) )
	put a, (0, 0), b, pset
	CU_ASSERT( hImageIsFilledWithColor( b, rgb(255,0,0) ) )
	CU_ASSERT( hImageIsFilledWithColor( a, rgb(255,0,0) ) )
	hResetImageToBlack( a )

	get b, (0, 0) - (SCREEN_W-1, SCREEN_H-1), a
	CU_ASSERT( hImageIsFilledWithColor( a, rgb(255,0,0) ) )
	hResetImageToBlack( a )

	CU_ASSERT( point( 0, 0, b ) = rgb(255,0,0) )

	imagedestroy( b )
	imagedestroy( a )
end sub

private sub hTestPointerTypes( )
	'' The target/source image expressions could be any pointer,
	'' the compiler does no type checking
	#macro checkType( T )
		scope
			dim as T ptr a = imagecreate( SCREEN_W, SCREEN_H, rgb(0,0,0) )
			CU_ASSERT( hImageIsFilledWithColor( a, rgb(0,0,0) ) )

			line a, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
			CU_ASSERT( hImageIsFilledWithColor( a, rgb(255,0,0) ) )

			imagedestroy( a )
		end scope
	#endmacro

	'' Should definitely work (since imagecreate returns an ANY PTR currently):
	checkType( any )

	'' Should probably work while there's no real type safety for the image parameters:
	checkType( byte )
	checkType( ubyte )
	checkType( short )
	checkType( ushort )
	checkType( long )
	checkType( ulong )
	checkType( longint )
	checkType( ulongint )
	checkType( integer )
	checkType( uinteger )

	'' Questionable:
	checkType( single )
	checkType( double )
	checkType( string )
	checkType( zstring )
	checkType( wstring )

	'' UDT pointers have to work too, because currently fb.IMAGE is just another UDT, not a built-in:
	checkType( fb.IMAGE )
	checkType( ImageUdt1 )
	checkType( SomeUdt1 )
	checkType( DerivedUdt1 )
	checkType( DerivedUdt2 )
end sub

'' We support arrays instead of dynamically allocated image buffers too,
'' probably due to QB compatibility.
private sub hTestArrayTarget( )
	'' array on stack:
	scope
		dim array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
		scope
			var a = imagecreate( SCREEN_W, SCREEN_H, rgb(0,0,0) )
			memcpy( @array(0), a, IMAGE_BUFFER_SIZE )
			imagedestroy( a )
		end scope
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,0,0) ) )

		'' NIDXARRAY
		line array, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(255,0,0) ) )

		'' array(0)
		line array(0), (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,0,255) ) )

		'' @array(0)
		line @array(0), (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(255,0,0) ) )
	end scope

	'' array on heap:
	scope
		static array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
		scope
			var a = imagecreate( SCREEN_W, SCREEN_H, rgb(0,0,0) )
			memcpy( @array(0), a, IMAGE_BUFFER_SIZE )
			imagedestroy( a )
		end scope
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,0,0) ) )

		'' NIDXARRAY
		line array, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(255,0,0) ) )

		'' array(0)
		line array(0), (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,0,255) ) )

		'' @array(0)
		line @array(0), (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(255,0,0) ) )
	end scope

	'' dynamic array, descriptor on stack:
	scope
		redim array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
		scope
			var a = imagecreate( SCREEN_W, SCREEN_H, rgb(0,0,0) )
			memcpy( @array(0), a, IMAGE_BUFFER_SIZE )
			imagedestroy( a )
		end scope
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,0,0) ) )

		'' NIDXARRAY
		line array, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(255,0,0) ) )

		'' array(0)
		line array(0), (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,0,255) ) )

		'' @array(0)
		line @array(0), (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(255,0,0) ) )
	end scope

	'' array field:
	scope
		type UDT
			array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
		end type
		dim udt as UDT
		dim pudt as UDT ptr = @udt
		scope
			var a = imagecreate( SCREEN_W, SCREEN_H, rgb(0,0,0) )
			memcpy( pudt, a, IMAGE_BUFFER_SIZE )
			imagedestroy( a )
		end scope

		'' pudt->array
		line pudt->array, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
		CU_ASSERT( hImageIsFilledWithColor( @pudt->array(0), rgb(255,0,0) ) )

		'' pudt->array(0)
		line pudt->array(0), (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
		CU_ASSERT( hImageIsFilledWithColor( @pudt->array(0), rgb(255,0,0) ) )

		'' @pudt->array(0)
		line @pudt->array(0), (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
		CU_ASSERT( hImageIsFilledWithColor( @pudt->array(0), rgb(255,0,0) ) )
	end scope
end sub

'' GET from screen into some array...
private sub hTestGetIntoUByteArray( )
	'' NIDXARRAY, array on stack
	scope
		dim array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' NIDXARRAY, array on heap
	scope
		static array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' NIDXARRAY, dynamic array, descriptor on stack
	scope
		redim array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' array(0)
	scope
		dim array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array(0)
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' array(1)
	scope
		dim array(0 to IMAGE_BUFFER_SIZE+1-1) as ubyte
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array(1)
		CU_ASSERT( hImageIsFilledWithColor( @array(1), rgb(0,255,0) ) )
	end scope

	'' array(i)
	scope
		dim array(0 to IMAGE_BUFFER_SIZE+50-1) as ubyte
		var i = 50
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array(i)
		CU_ASSERT( hImageIsFilledWithColor( @array(i), rgb(0,255,0) ) )
	end scope

	'' @array(0)
	scope
		dim array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @array(0)
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' @array(1)
	scope
		dim array(0 to IMAGE_BUFFER_SIZE+1-1) as ubyte
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @array(1)
		CU_ASSERT( hImageIsFilledWithColor( @array(1), rgb(0,255,0) ) )
	end scope

	'' @array(i)
	scope
		dim array(0 to IMAGE_BUFFER_SIZE+50-1) as ubyte
		var i = 50
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @array(i)
		CU_ASSERT( hImageIsFilledWithColor( @array(i), rgb(0,255,0) ) )
	end scope

	'' udt.array(0)
	scope
		type UDT
			array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
		end type
		dim udt as UDT
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), udt.array(0)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(0), rgb(0,255,0) ) )
	end scope

	'' udt.array(1)
	scope
		type UDT
			array(0 to IMAGE_BUFFER_SIZE+1-1) as ubyte
		end type
		dim udt as UDT
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), udt.array(1)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(1), rgb(0,255,0) ) )
	end scope

	'' udt.array(i)
	scope
		type UDT
			array(0 to IMAGE_BUFFER_SIZE+50-1) as ubyte
		end type
		dim udt as UDT
		var i = 50
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), udt.array(i)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(i), rgb(0,255,0) ) )
	end scope

	'' @udt.array(0)
	scope
		type UDT
			array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
		end type
		dim udt as UDT
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @udt.array(0)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(0), rgb(0,255,0) ) )
	end scope

	'' @udt.array(1)
	scope
		type UDT
			array(0 to IMAGE_BUFFER_SIZE+1-1) as ubyte
		end type
		dim udt as UDT
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @udt.array(1)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(1), rgb(0,255,0) ) )
	end scope

	'' @udt.array(i)
	scope
		type UDT
			array(0 to IMAGE_BUFFER_SIZE+50-1) as ubyte
		end type
		dim udt as UDT
		var i = 50
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @udt.array(i)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(i), rgb(0,255,0) ) )
	end scope
end sub

private sub hTestGetIntoULongArray( )
	'' NIDXARRAY, array on stack
	scope
		dim array(0 to (IMAGE_BUFFER_SIZE\4)-1) as ulong
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' NIDXARRAY, array on heap
	scope
		static array(0 to (IMAGE_BUFFER_SIZE\4)-1) as ulong
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' NIDXARRAY, dynamic array, descriptor on stack
	scope
		redim array(0 to (IMAGE_BUFFER_SIZE\4)-1) as ulong
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' array(0)
	scope
		dim array(0 to (IMAGE_BUFFER_SIZE\4)-1) as ulong
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array(0)
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' array(1)
	scope
		dim array(0 to (IMAGE_BUFFER_SIZE\4)+1-1) as ulong
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array(1)
		CU_ASSERT( hImageIsFilledWithColor( @array(1), rgb(0,255,0) ) )
	end scope

	'' array(i)
	scope
		dim array(0 to (IMAGE_BUFFER_SIZE\4)+50-1) as ulong
		var i = 50
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array(i)
		CU_ASSERT( hImageIsFilledWithColor( @array(i), rgb(0,255,0) ) )
	end scope

	'' @array(0)
	scope
		dim array(0 to (IMAGE_BUFFER_SIZE\4)-1) as ulong
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @array(0)
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' @array(1)
	scope
		dim array(0 to (IMAGE_BUFFER_SIZE\4)+1-1) as ulong
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @array(1)
		CU_ASSERT( hImageIsFilledWithColor( @array(1), rgb(0,255,0) ) )
	end scope

	'' @array(i)
	scope
		dim array(0 to (IMAGE_BUFFER_SIZE\4)+50-1) as ulong
		var i = 50
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @array(i)
		CU_ASSERT( hImageIsFilledWithColor( @array(i), rgb(0,255,0) ) )
	end scope

	'' udt.array(0)
	scope
		type UDT
			array(0 to (IMAGE_BUFFER_SIZE\4)-1) as ulong
		end type
		dim udt as UDT
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), udt.array(0)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(0), rgb(0,255,0) ) )
	end scope

	'' udt.array(1)
	scope
		type UDT
			array(0 to (IMAGE_BUFFER_SIZE\4)+1-1) as ulong
		end type
		dim udt as UDT
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), udt.array(1)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(1), rgb(0,255,0) ) )
	end scope

	'' udt.array(i)
	scope
		type UDT
			array(0 to (IMAGE_BUFFER_SIZE\4)+50-1) as ulong
		end type
		dim udt as UDT
		var i = 50
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), udt.array(i)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(i), rgb(0,255,0) ) )
	end scope

	'' @udt.array(0)
	scope
		type UDT
			array(0 to (IMAGE_BUFFER_SIZE\4)-1) as ulong
		end type
		dim udt as UDT
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @udt.array(0)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(0), rgb(0,255,0) ) )
	end scope

	'' @udt.array(1)
	scope
		type UDT
			array(0 to (IMAGE_BUFFER_SIZE\4)+1-1) as ulong
		end type
		dim udt as UDT
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @udt.array(1)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(1), rgb(0,255,0) ) )
	end scope

	'' @udt.array(i)
	scope
		type UDT
			array(0 to (IMAGE_BUFFER_SIZE\4)+50-1) as ulong
		end type
		dim udt as UDT
		var i = 50
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @udt.array(i)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(i), rgb(0,255,0) ) )
	end scope
end sub

'' GET from screen into an array of pointers: The image data should still be
'' stored into the array, regardless of what the array's dtype is. The only
'' thing that matters is that the array is large enough to hold all the image
'' data.
private sub hTestGetIntoPtrArray( )
	'' NIDXARRAY
	scope
		dim array(0 to (IMAGE_BUFFER_SIZE\sizeof(any ptr))-1) as any ptr
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' array(0)
	scope
		dim array(0 to (IMAGE_BUFFER_SIZE\sizeof(any ptr))-1) as any ptr
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array(0)
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' @array(0)
	scope
		dim array(0 to (IMAGE_BUFFER_SIZE\sizeof(any ptr))-1) as any ptr
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @array(0)
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end scope

	'' udt.array(0)
	scope
		type UDT
			array(0 to (IMAGE_BUFFER_SIZE\sizeof(any ptr))-1) as any ptr
		end type
		dim udt as UDT
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), udt.array(0)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(0), rgb(0,255,0) ) )
	end scope

	'' @udt.array(0)
	scope
		type UDT
			array(0 to (IMAGE_BUFFER_SIZE\sizeof(any ptr))-1) as any ptr
		end type
		dim udt as UDT
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @udt.array(0)
		CU_ASSERT( hImageIsFilledWithColor( @udt.array(0), rgb(0,255,0) ) )
	end scope
end sub

private sub hTestFieldTarget( )
	type UDT
		p as fb.IMAGE ptr
	end type
	dim x as UDT
	var px = @x

	x.p = imagecreate( SCREEN_W, SCREEN_H, rgb(0,0,0) )
	CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(0,0,0) ) )

	'' x.p
	line x.p, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
	CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(255,0,0) ) )

	'' px->p
	line px->p, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
	CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(0,0,255) ) )
end sub

private sub hTestConstSource( )
	CU_ASSERT( hScreenIsFilledWithColor( rgb(0,255,0) ) )

	dim a as const FB.IMAGE ptr = imagecreate( SCREEN_W, SCREEN_H, rgb(0,0,0) )
	put (0, 0), a, pset
	CU_ASSERT( hScreenIsFilledWithColor( rgb(0,0,0) ) )
	imagedestroy( a )

	line (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,255,0), bf
	CU_ASSERT( hScreenIsFilledWithColor( rgb(0,255,0) ) )
end sub

type PropertyUdt
	gets as integer
	sets as integer
	p as any ptr
	declare property image() as any ptr
	declare property image(byval as any ptr)
end type

property PropertyUdt.image() as any ptr
	gets += 1
	property = p
end property

property PropertyUdt.image(byval p as any ptr)
	sets += 1
	this.p = p
end property

private sub hTestProperty( )
	dim x as PropertyUdt
	x.p = imagecreate( SCREEN_W, SCREEN_H, rgb(0,0,0) )
	CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(0,0,0) ) )

	CU_ASSERT( x.sets = 0 )
	CU_ASSERT( x.gets = 0 )

	line x.image, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
	CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(255,0,0) ) )

	CU_ASSERT( x.sets = 0 )
	CU_ASSERT( x.gets = 1 )

	CU_ASSERT( hScreenIsFilledWithColor( rgb(0,255,0) ) )
	put (0, 0), x.image, pset
	CU_ASSERT( hScreenIsFilledWithColor( rgb(255,0,0) ) )

	CU_ASSERT( x.sets = 0 )
	CU_ASSERT( x.gets = 2 )

	imagedestroy( x.p )
end sub

private sub test cdecl( )
	CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )

	line (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,255,0), bf
	CU_ASSERT( hScreenIsFilledWithColor( rgb(0,255,0) ) )
	CU_ASSERT( hScreenIsFilledWithColor( rgb(0,0,0) ) = FALSE )

	hTestAllGfxCommands( )
	hTestPointerTypes( )
	hTestArrayTarget( )
	hTestGetIntoUByteArray( )
	hTestGetIntoULongArray( )
	hTestGetIntoPtrArray( )
	hTestFieldTarget( )
	hTestConstSource( )
	hTestProperty( )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/gfx/fb-image-expr" )
	fbcu.add_test( "1", @test )
end sub

end namespace
