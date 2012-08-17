'' examples/manual/libraries/disphelper3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ExtLibdisphelper
'' --------

'' VB Script example

#define UNICODE
#include "disphelper/disphelper.bi"

'' This function runs a script using the MSScriptControl.
'' Optionally returns a result.
Sub RunScript _
	( _
		ByVal result_identifier As LPWSTR, _
		ByVal result As LPVOID, _
		ByVal script As LPWSTR, _
		ByVal language As LPWSTR _
	)

	DISPATCH_OBJ(control)
	If (SUCCEEDED(dhCreateObject("MSScriptControl.ScriptControl", NULL, @control))) Then
		If (SUCCEEDED(dhPutValue(control, ".Language = %T", language))) Then
			dhPutValue(control, ".AllowUI = %b", TRUE)
			dhPutValue(control, ".UseSafeSubset = %b", FALSE)

			If (result) Then
				dhGetValue(result_identifier, result, control, ".Eval(%T)", script)
			Else
				dhCallMethod(control, ".Eval(%T)", script)
			End If
		End If
	End If

	SAFE_RELEASE(control)
End Sub

	dhInitialize(TRUE)
	dhToggleExceptions(TRUE)

	'' VBScript sample
	RunScript(NULL, NULL, !"MsgBox(\"This Is a VBScript test.\" & vbcrlf & \"It worked!\",64 Or 3)", "VBScript")

	'' JScript sample
	Dim As Integer result
	RunScript("%d", @result, "Math.round(Math.pow(5, 2) * Math.PI)", "JScript")
	Print "Result ="; result

	Print "Press any key to exit..."
	Sleep

	dhUninitialize(TRUE)
