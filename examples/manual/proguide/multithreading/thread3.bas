'' examples/manual/proguide/multithreading/thread3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Threads'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtThreads
'' --------

'    Only 4 member procedures in public access (the first 3 returning 'true' if success, 'false' else):
'        - Function 'Set' to parametrize the considered timer (time-out in ms, pointer to user thread)
'        - Function 'Start' to start the considered timer
'        - Function 'Stop' to stop the considered timer (then, the considered timer may be re-Set and re-Start)
'        - Property 'Counter' to get the occurrence number of the timer
'    Plus an 'Any Ptr' in public access:
'        - Pointer field 'userdata' to point to any user data structure (optional usage)
'
'    Remark:
'        - Pointer to the considered timer instance is provided to the user thread procedure
'          in order to be able to factorize the treatment per timers group,
'          and to address the right user data structure if used (see example for usage).
'
'    In private access:
'        - 4 internal variables (time-out value, pointer to user thread, handle to timer thread, counter of occurence)
'        - Static timer thread


#include "fbthread.bi"
Type UDT_timer_thread
	Public:
		Declare Function Set (ByVal time_out As UInteger, _
							  ByVal timer_procedure As Sub(ByVal param As Any Ptr)) _
							  As Boolean
		Declare Function Start () As Boolean
		Declare Function Stop () As Boolean
		Declare Property Counter () As UInteger
		Dim As Any Ptr userdata
	Private:
		Dim As UInteger tempo
		Dim As Sub(ByVal param As Any Ptr) routine
		Dim As Any Ptr handle
		Dim As UInteger count
		Declare Static Sub thread (ByVal param As Any Ptr)
End Type

Function UDT_timer_thread.Set (ByVal time_out As UInteger, _
							  ByVal timer_procedure As Sub(ByVal param As Any Ptr)) _
							  As Boolean
	If timer_procedure > 0 And This.handle = 0 Then
		This.tempo = time_out
		This.routine = timer_procedure
		This.count = 0
		Function = True
	Else
		Function = False
	End If
End Function

Function UDT_timer_thread.Start () As Boolean
	If This.handle = 0 And This.routine > 0 Then
		This.handle = ThreadCreate(@UDT_timer_thread.thread, @This)
		Function = True
	Else
		Function = False
	End If
End Function

Function UDT_timer_thread.Stop () As Boolean
	If This.handle > 0 Then
		Dim p As Any Ptr = 0
		Swap p, This.handle
		ThreadWait(p)
		Function = True
	Else
		Function = False
	End If
End Function

Property UDT_timer_thread.Counter () As UInteger
	Return This.count
End Property

Static Sub UDT_timer_thread.thread (ByVal param As Any Ptr)
	Dim As UDT_timer_thread Ptr pu = param
	While pu->handle > 0
		Sleep pu->tempo, 1
		pu->count += 1
		If pu->routine > 0 Then
			Dim As Any Ptr p = ThreadCreate(Cast(Any Ptr, pu->routine), param)
			ThreadDetach(p)
		End If
	Wend
End Sub

'---------------------------------------------------------------------------------------------------

Dim As UInteger tempo1 = 950
Dim As UInteger tempo2 = 380
Dim As UDT_timer_thread timer1
	timer1.userdata = New String("        callback from timer #1 (" & tempo1 & "ms)")
Dim As UDT_timer_thread timer2
	timer2.userdata = New String("        callback from timer #2 (" & tempo2 & "ms)")

Sub User_thread (ByVal param As Any Ptr)
	Dim As UDT_timer_thread Ptr pu = param
	Dim As String Ptr ps = pu->userdata
	Print *ps & ", occurrence: " & pu->Counter
End Sub

Print "Beginning of test"
If timer1.Set(tempo1, @User_thread) Then
	Print "    timer #1 set OK"
	If timer1.Start Then
		Print "        timer #1 start OK"
	End If
End If
If timer2.Set(tempo2, @User_thread) Then
	Print "    timer #2 set OK"
	If timer2.Start Then
		Print "        timer #2 start OK"
	End If
End If
Print "    Then, any key to stop the timers"

Sleep

If timer1.stop Then
	Print "    timer #1 stop OK"
End If
If timer2.stop Then
	Print "    timer #2 stop OK"
End If
Sleep 500, 1
Print "End of test"
Delete Cast(String Ptr, timer1.userdata)
Delete Cast(String Ptr, timer2.userdata)

Sleep
		
