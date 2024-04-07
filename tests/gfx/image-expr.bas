#include "fbcunit.bi"
#include once "fbgfx.bi"
#include once "crt/string.bi"

SUITE( fbc_tests.gfx.image_expr )

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
		CU_ASSERT( p <> NULL )

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

	type ByteUdtWithMatchingCast field = 1
		b as ubyte
		declare operator cast( ) as any ptr
	end type

	operator ByteUdtWithMatchingCast.cast( ) as any ptr
		operator = 0
	end operator

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

		'' Palette Get Using is in tests/gfx/palette.bas

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

			'' byref pointer = @array(0)
			var array0idx = @array(0)
			var byref array0 = array0idx
			line array0, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,0,255) ) )
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

			'' byref pointer = @array(0)
			var array0idx = @array(0)
			var byref array0 = array0idx
			line array0, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,0,255) ) )
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

			'' byref pointer = @array(0)
			var array0idx = @array(0)
			var byref array0 = array0idx
			line array0, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,0,255) ) )
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

	private sub hTestPtrArrayTarget( )
		'' An array access (excluding NIDXARRAY) with pointer type however is
		'' treated like any other pointer expression - i.e. the image is written
		'' into the pointed-to address, not into the array.
		scope
			dim array(0 to 1) as any ptr
			array(0) = imagecreate( SCREEN_W, SCREEN_H, rgb(0,0,0) )
			CU_ASSERT( hImageIsFilledWithColor( array(0), rgb(0,0,0) ) )

			'' array(0)
			line array(0), (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
			CU_ASSERT( hImageIsFilledWithColor( array(0), rgb(0,0,255) ) )

			'' GET into pointer from array access
			get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array(0)
			CU_ASSERT( hImageIsFilledWithColor( array(0), rgb(0,255,0) ) )

			'' GET into pointer from byref array access
			var byref array0 = array(0)
			get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array0
			CU_ASSERT( hImageIsFilledWithColor( array(0), rgb(0,255,0) ) )

			imagedestroy( array(0) )
		end scope

		'' NIDXARRAY: The image data is still stored into the array,
		'' regardless of what the array's dtype is.
		scope
			dim array(0 to (IMAGE_BUFFER_SIZE\sizeof(any ptr))-1) as any ptr

			get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )

			line array, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,0,255) ) )
		end scope

		'' @array(0): The type is an ANY PTR PTR which should be accepted too.
		scope
			dim array(0 to (IMAGE_BUFFER_SIZE\sizeof(any ptr))-1) as any ptr

			get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @array(0)
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )

			line @array(0), (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,0,255) ) )
		end scope

		'' @udt.array(0): Same as @array(0)
		scope
			type UDT
				array(0 to (IMAGE_BUFFER_SIZE\sizeof(any ptr))-1) as any ptr
			end type
			dim udt as UDT

			get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @udt.array(0)
			CU_ASSERT( hImageIsFilledWithColor( @udt.array(0), rgb(0,255,0) ) )

			line @udt.array(0), (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
			CU_ASSERT( hImageIsFilledWithColor( @udt.array(0), rgb(0,0,255) ) )
		end scope
	end sub

	private sub hTestUdtWithoutMatchingCastArrayTarget( )
		type UDT field = 1
			b as ubyte
		end type

		dim array(0 to IMAGE_BUFFER_SIZE-1) as UDT

		'' These cases should work despite the UDT not having a cast() overload

		'' NIDXARRAY
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )

		'' array(0)
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array(0)
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )

		'' @array(0)
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @array(0)
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )

		'' byref pointer = @array(0)
		var array0idx = @array(0)
		var byref array0 = array0idx
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array0
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
	end sub

	private sub hTestUdtWithMatchingCastArrayTarget( )
		dim array(0 to IMAGE_BUFFER_SIZE-1) as ByteUdtWithMatchingCast

		'' The cast() overload shouldn't be used in these cases

		'' NIDXARRAY
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )

		'' array(0)
		'' not tested, cast() is known to be used in this case

		'' @array(0)
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), @array(0)
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )

		'' byref pointer = @array(0)
		var array0idx = @array(0)
		var byref array0 = array0idx
		get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array0
		CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )


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

		'' byref pointer = @array(0)
		scope
			dim array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
			var array0idx = @array(0)
			var byref array0 = array0idx
			get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array0
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

		'' byref pointer = @array(0)
		scope
			dim array(0 to (IMAGE_BUFFER_SIZE\4)-1) as ulong
			var array0idx = @array(0)
			var byref array0 = array0idx
			get (0, 0) - (SCREEN_W-1, SCREEN_H-1), array0
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

		'' free x.p otherwise considered a memory leak
		imagedestroy( x.p )
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
		line (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,255,0), bf

		CU_ASSERT( x.sets = 0 )
		CU_ASSERT( x.gets = 2 )

		imagedestroy( x.p )
	end sub

	namespace castOverloadAnyPtr
		dim shared as integer casts_anyptr

		type UDT
			p as any ptr
			declare operator cast( ) as any ptr
		end type

		operator UDT.cast( ) as any ptr
			casts_anyptr += 1
			operator = p
		end operator

		private sub hTest( )
			dim x as UDT
			x.p = imagecreate( SCREEN_W, SCREEN_H, rgb(255,0,0) )
			CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(255,0,0) ) )

			CU_ASSERT( casts_anyptr = 0 )
			line x, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
			CU_ASSERT( casts_anyptr = 1 )
			CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(0,0,255) ) )

			imagedestroy( x.p )
		end sub
	end namespace

	namespace castOverloadFbImagePtr
		dim shared as integer casts_fbimageptr

		type UDT
			p as any ptr
			declare operator cast( ) as FB.IMAGE ptr
		end type

		operator UDT.cast( ) as FB.IMAGE ptr
			casts_fbimageptr += 1
			operator = p
		end operator

		private sub hTest( )
			dim x as UDT
			x.p = imagecreate( SCREEN_W, SCREEN_H, rgb(255,0,0) )
			CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(255,0,0) ) )

			CU_ASSERT( casts_fbimageptr = 0 )
			line x, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
			CU_ASSERT( casts_fbimageptr = 1 )
			CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(0,0,255) ) )

			imagedestroy( x.p )
		end sub
	end namespace

	namespace castOverloadAnyPtrFbImagePtr
		dim shared as integer casts_anyptr, casts_fbimageptr

		type UDT
			p as any ptr
			declare operator cast( ) as any ptr
			declare operator cast( ) as FB.IMAGE ptr
		end type

		operator UDT.cast( ) as any ptr
			casts_anyptr += 1
			operator = p
		end operator

		operator UDT.cast( ) as FB.IMAGE ptr
			casts_fbimageptr += 1
			operator = p
		end operator

		private sub hTest( )
			dim x as UDT
			x.p = imagecreate( SCREEN_W, SCREEN_H, rgb(255,0,0) )
			CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(255,0,0) ) )

			CU_ASSERT( casts_anyptr = 0 )
			CU_ASSERT( casts_fbimageptr = 0 )
			line x, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
			CU_ASSERT( casts_anyptr = 1 )
			CU_ASSERT( casts_fbimageptr = 0 )
			CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(0,0,255) ) )

			imagedestroy( x.p )
		end sub
	end namespace

	namespace castOverloadAnyPtrInteger
		dim shared as integer casts_anyptr, casts_integer

		type UDT
			p as any ptr
			declare operator cast( ) as any ptr
			declare operator cast( ) as integer
		end type

		operator UDT.cast( ) as any ptr
			casts_anyptr += 1
			operator = p
		end operator

		operator UDT.cast( ) as integer
			casts_integer += 1
			operator = 0
		end operator

		private sub hTest( )
			dim x as UDT
			x.p = imagecreate( SCREEN_W, SCREEN_H, rgb(255,0,0) )
			CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(255,0,0) ) )

			CU_ASSERT( casts_anyptr = 0 )
			CU_ASSERT( casts_integer = 0 )
			line x, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,0,255), bf
			CU_ASSERT( casts_anyptr = 1 )
			CU_ASSERT( casts_integer = 0 )
			CU_ASSERT( hImageIsFilledWithColor( x.p, rgb(0,0,255) ) )

			imagedestroy( x.p )
		end sub
	end namespace

	private sub hTestDrawSyntax( )
		scope
			CU_ASSERT( hScreenIsFilledWithColor( rgb(0,255,0) ) )
			draw "BM 0,0 P " & rgb(0,0,255) & "," & rgb(255,255,255)
			CU_ASSERT( hScreenIsFilledWithColor( rgb(0,0,255) ) )
			line (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,255,0), bf
		end scope

		scope
			var s = "BM 0,0 P " & rgb(0,0,255) & "," & rgb(255,255,255)
			CU_ASSERT( hScreenIsFilledWithColor( rgb(0,255,0) ) )
			draw s
			CU_ASSERT( hScreenIsFilledWithColor( rgb(0,0,255) ) )
			line (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,255,0), bf
		end scope

		scope
			dim s(0 to 0) as string = { "BM 0,0 P " & rgb(0,0,255) & "," & rgb(255,255,255) }
			CU_ASSERT( hScreenIsFilledWithColor( rgb(0,255,0) ) )
			draw s(0)
			CU_ASSERT( hScreenIsFilledWithColor( rgb(0,0,255) ) )
			line (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,255,0), bf
		end scope

		scope
			type UDT
				p as any ptr
			end type
			dim x as UDT
			var px = @x
			var p = imagecreate( SCREEN_W, SCREEN_H, rgb(255,0,0) )
			x.p = p
			dim array(0 to 0) as any ptr = { p }

			CU_ASSERT( hImageIsFilledWithColor( p, rgb(255,0,0) ) )
			draw p, "BM 0,0 P " & rgb(0,255,0) & "," & rgb(255,255,255)
			CU_ASSERT( hImageIsFilledWithColor( p, rgb(0,255,0) ) )
			line p, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf

			CU_ASSERT( hImageIsFilledWithColor( p, rgb(255,0,0) ) )
			draw x.p, "BM 0,0 P " & rgb(0,255,0) & "," & rgb(255,255,255)
			CU_ASSERT( hImageIsFilledWithColor( p, rgb(0,255,0) ) )
			line p, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf

			CU_ASSERT( hImageIsFilledWithColor( p, rgb(255,0,0) ) )
			draw px->p, "BM 0,0 P " & rgb(0,255,0) & "," & rgb(255,255,255)
			CU_ASSERT( hImageIsFilledWithColor( p, rgb(0,255,0) ) )
			line p, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf

			imagedestroy( p )
		end scope

		scope
			dim array(0 to IMAGE_BUFFER_SIZE-1) as ubyte
			scope
				var a = imagecreate( SCREEN_W, SCREEN_H, rgb(255,0,0) )
				memcpy( @array(0), a, IMAGE_BUFFER_SIZE )
				imagedestroy( a )
			end scope
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(255,0,0) ) )

			'' NIDXARRAY
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(255,0,0) ) )
			draw array, "BM 0,0 P " & rgb(0,255,0) & "," & rgb(255,255,255)
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
			line array, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf

			'' array(0)
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(255,0,0) ) )
			draw array(0), "BM 0,0 P " & rgb(0,255,0) & "," & rgb(255,255,255)
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
			line array, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf

			'' @array(0)
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(255,0,0) ) )
			draw @array(0), "BM 0,0 P " & rgb(0,255,0) & "," & rgb(255,255,255)
			CU_ASSERT( hImageIsFilledWithColor( @array(0), rgb(0,255,0) ) )
			line array, (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(255,0,0), bf
		end scope
	end sub

	TEST( all )
		CU_ASSERT( screenres( SCREEN_W, SCREEN_H, 32, , fb.GFX_NULL ) = 0 )

		line (0, 0) - (SCREEN_W-1, SCREEN_H-1), rgb(0,255,0), bf
		CU_ASSERT( hScreenIsFilledWithColor( rgb(0,255,0) ) )
		CU_ASSERT( hScreenIsFilledWithColor( rgb(0,0,0) ) = FALSE )

		hTestAllGfxCommands( )
		hTestPointerTypes( )
		hTestArrayTarget( )
		hTestPtrArrayTarget( )
		hTestUdtWithoutMatchingCastArrayTarget( )
		hTestUdtWithMatchingCastArrayTarget( )
		hTestGetIntoUByteArray( )
		hTestGetIntoULongArray( )
		hTestFieldTarget( )
		hTestConstSource( )
		hTestProperty( )
		castOverloadAnyPtr.hTest( )
		castOverloadFbImagePtr.hTest( )
		castOverloadAnyPtrFbImagePtr.hTest( )
		castOverloadAnyPtrInteger.hTest( )
		hTestDrawSyntax( )
	END_TEST

END_SUITE
