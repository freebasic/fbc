'' examples/manual/libraries/disphelper3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'disphelper'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibdisphelper
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
			dhPutValue(control, ".AllowUI = %b", True)
			dhPutValue(control, ".UseSafeSubset = %b", False)

			If (result) Then
				dhGetValue(result_identifier, result, control, ".Eval(%T)", script)
			Else
				dhCallMethod(control, ".Eval(%T)", script)
			End If
		End If
	End If

	SAFE_RELEASE(control)
End Sub

	dhInitialize(True)
	dhToggleExceptions(True)

	'' VBScript sample
	RunScript(NULL, NULL, !"MsgBox(\"This Is a VBScript test.\" & vbcrlf & \"It worked!\",64 Or 3)", "VBScript")

	'' JScript sample
	Dim As Integer result
	RunScript("%d", @result, "Math.round(Math.pow(5, 2) * Math.PI)", "JScript")
	Print "Result ="; result

	Print "Press any key to exit..."
	Sleep

	dhUninitialize(True)
