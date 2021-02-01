' TEST_MODE : COMPILE_ONLY_FAIL
'' error on invalid expression

__FB_UNQUOTE__( __FB_EVAL__( "#define X " 2 ) )
