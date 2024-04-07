' TEST_MODE : COMPILE_ONLY_OK

'' #pragma private
'' #pragma private = false
'' #pragma private = true
'' #pragma push( private )
'' #pragma push( private, false )
'' #pragma push( private, true )
'' #pragma pop( private )
''

'' default value
	#assert( __FB_OPTION_PRIVATE__ = false )

'' test implicit true

	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma private
	#assert( __FB_OPTION_PRIVATE__ = true )

	#pragma private = false
	#assert( __FB_OPTION_PRIVATE__ = false )

'' test explicit true

	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma private = true
	#assert( __FB_OPTION_PRIVATE__ = true )

	#pragma private = false
	#assert( __FB_OPTION_PRIVATE__ = false )


'' test implicit push

	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma push( private )
	#assert( __FB_OPTION_PRIVATE__ = true )

	#pragma pop( private )
	#assert( __FB_OPTION_PRIVATE__ = false )

'' test explicit push false, push false nested

	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma push( private, false )
	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma push( private, false )
	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma pop( private )
	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma pop( private )
	#assert( __FB_OPTION_PRIVATE__ = false )

'' test explicit push false, push true nested

	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma push( private, false )
	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma push( private, true )
	#assert( __FB_OPTION_PRIVATE__ = true )

	#pragma pop( private )
	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma pop( private )
	#assert( __FB_OPTION_PRIVATE__ = false )

'' test explicit push true, push false nested

	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma push( private, true )
	#assert( __FB_OPTION_PRIVATE__ = true )

	#pragma push( private, false )
	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma pop( private )
	#assert( __FB_OPTION_PRIVATE__ = true )

	#pragma pop( private )
	#assert( __FB_OPTION_PRIVATE__ = false )

'' test explicit push true, push false nested

	#assert( __FB_OPTION_PRIVATE__ = false )

	#pragma push( private, true )
	#assert( __FB_OPTION_PRIVATE__ = true )

	#pragma push( private, true )
	#assert( __FB_OPTION_PRIVATE__ = true )

	#pragma pop( private )
	#assert( __FB_OPTION_PRIVATE__ = true )

	#pragma pop( private )
	#assert( __FB_OPTION_PRIVATE__ = false )
