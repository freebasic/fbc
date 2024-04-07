'' examples/manual/libraries/spidermonkey1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SpiderMonkey'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibspidermonkey
'' --------

'' Evaluating javascript code
#include Once "spidermonkey/jsapi.bi"

Dim Shared As JSClass global_class = _
( _
	@"global", 0, _
	@JS_PropertyStub, @JS_PropertyStub, @JS_PropertyStub, @JS_PropertyStub, _
	@JS_EnumerateStub, @JS_ResolveStub, @JS_ConvertStub, @JS_FinalizeStub _
)

Dim As JSRuntime Ptr rt = JS_NewRuntime(1048576 /'memory limit'/)
Dim As JSContext Ptr cx = JS_NewContext(rt, 4096 /'stack size'/)
Dim As JSObject Ptr global = JS_NewObject(cx, @global_class, NULL, NULL) 

JS_InitStandardClasses(cx, global)

'' This string could also be read in from a file or as part of HTTP data etc.
Const TEST_SCRIPT = _
	!"function fact(n)           \n" + _
	!"{                          \n" + _
	!"    if (n <= 1)            \n" + _
	!"        return 1;          \n" + _
	!"                           \n" + _
	!"    return n * fact(n - 1);\n" + _
	!"}                          \n" + _
	!"                           \n" + _
	!"    fact(5)                \n"

Dim As jsval rval
If (JS_EvaluateScript(cx, global, TEST_SCRIPT, Len(TEST_SCRIPT), "localhost", 1, @rval) = 0) Then
	Print "JS_EvaluateScript failed"
	Sleep
	End 1
End If

Print "result: " & *JS_GetStringBytes(JS_ValueToString(cx, rval))

JS_DestroyContext(cx)
JS_DestroyRuntime(rt)
