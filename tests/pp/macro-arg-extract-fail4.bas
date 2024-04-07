' TEST_MODE : COMPILE_ONLY_FAIL
'' no index or args should cause compile fail

#macro VarMac()

Const arg As String = __FB_QUOTE__(__FB_ARG_EXTRACT__(  ))

#endmacro

VarMac() 
