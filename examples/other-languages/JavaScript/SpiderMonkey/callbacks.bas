'' Callback example: Functions that are used by the Javascript code,
'' but are implemented in FB.
#include once "spidermonkey/jsapi.bi"

Dim Shared As JSClass global_class = _
( _
    @"global", 0, _
    @JS_PropertyStub, @JS_PropertyStub, @JS_PropertyStub, @JS_PropertyStub, _
    @JS_EnumerateStub, @JS_ResolveStub, @JS_ConvertStub, @JS_FinalizeStub _
)

Private Function print_callback cdecl _
    ( _
        ByVal cx As JSContext Ptr, _
        ByVal obj As JSObject Ptr, _
        ByVal argc As uintN, _
        ByVal argv As jsval Ptr, _
        ByVal rval As jsval Ptr _
    ) As JSBool

    If (argc < 1) Then
        Return 0
    End If

    Print *JS_GetStringBytes(JS_ValueToString(cx, argv[0]))

    Return 1
End Function

Private Function ucase_callback cdecl _
    ( _
        ByVal cx As JSContext Ptr, _
        ByVal obj As JSObject Ptr, _
        ByVal argc As uintN, _
        ByVal argv As jsval Ptr, _
        ByVal rval As jsval Ptr _
    ) As JSBool
   
    If (argc < 1) Then
        Return 0
    End If
   
    '' Get the first argument
    Dim As ZString Ptr arg1 = JS_GetStringBytes(JS_ValueToString(cx, argv[0]))
   
    '' Get a buffer for the result string
    Dim As ZString Ptr result = JS_malloc(cx, Len(*arg1) + 1)

    '' Do the work
    *result = UCase(*arg1)

    '' Return it in rval
    *rval = STRING_TO_JSVAL(JS_NewString(cx, result, Len(*result)))

    Return 1
End Function

    Dim As JSRuntime Ptr rt = JS_NewRuntime(1048576 /'memory limit'/)
    Dim As JSContext Ptr cx = JS_NewContext(rt, 4096 /'stack size'/)
    Dim As JSObject Ptr global = JS_NewObject(cx, @global_class, NULL, NULL)

    JS_InitStandardClasses(cx, global)

    JS_DefineFunction(cx, global, "print", @print_callback, 1, 0)
    JS_DefineFunction(cx, global, "ucase", @ucase_callback, 1, 0)

    Const TEST_SCRIPT = "print(ucase('hello'));"

    Dim As jsval rval
    If (JS_EvaluateScript(cx, global, TEST_SCRIPT, Len(TEST_SCRIPT), "localhost", 1, @rval) = 0) Then
        Print "JS_EvaluateScript failed"
        Sleep
        End 1
    End If

    JS_DestroyContext(cx)
    JS_DestroyRuntime(rt)
