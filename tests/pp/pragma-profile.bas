' TEST_MODE : COMPILE_ONLY_OK

'' #pragma profile
'' #pragma profile = false
'' #pragma profile = true
'' #pragma push( profile )
'' #pragma push( profile, false )
'' #pragma push( profile, true )
'' #pragma pop( profile )
''

'' default value
	#assert( __FB_OPTION_PROFILE__ = true )

'' test implicit true

	#assert( __FB_OPTION_PROFILE__ = true )

	#pragma profile = false
	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma profile
	#assert( __FB_OPTION_PROFILE__ = true )


'' test explicit true

	#assert( __FB_OPTION_PROFILE__ = true )

	#pragma profile = true
	#assert( __FB_OPTION_PROFILE__ = true )

	#pragma profile = false
	#assert( __FB_OPTION_PROFILE__ = false )


'' test implicit push

	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma push( profile )
	#assert( __FB_OPTION_PROFILE__ = true )

	#pragma pop( profile )
	#assert( __FB_OPTION_PROFILE__ = false )

'' test explicit push false, push false nested

	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma push( profile, false )
	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma push( profile, false )
	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma pop( profile )
	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma pop( profile )
	#assert( __FB_OPTION_PROFILE__ = false )

'' test explicit push false, push true nested

	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma push( profile, false )
	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma push( profile, true )
	#assert( __FB_OPTION_PROFILE__ = true )

	#pragma pop( profile )
	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma pop( profile )
	#assert( __FB_OPTION_PROFILE__ = false )

'' test explicit push true, push false nested

	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma push( profile, true )
	#assert( __FB_OPTION_PROFILE__ = true )

	#pragma push( profile, false )
	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma pop( profile )
	#assert( __FB_OPTION_PROFILE__ = true )

	#pragma pop( profile )
	#assert( __FB_OPTION_PROFILE__ = false )

'' test explicit push true, push false nested

	#assert( __FB_OPTION_PROFILE__ = false )

	#pragma push( profile, true )
	#assert( __FB_OPTION_PROFILE__ = true )

	#pragma push( profile, true )
	#assert( __FB_OPTION_PROFILE__ = true )

	#pragma pop( profile )
	#assert( __FB_OPTION_PROFILE__ = true )

	#pragma pop( profile )
	#assert( __FB_OPTION_PROFILE__ = false )
