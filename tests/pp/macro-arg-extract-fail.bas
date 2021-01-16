' TEST_MODE : COMPILE_ONLY_FAIL
'' Non-numeric arg-to-extract should cause compile fail

#macro VarMac(args...)

Const arg As String = __FB_QUOTE__(__FB_ARG_EXTRACT__(jimArg, args))

#endmacro

VarMac(apple, orange, lychee, kiwi)