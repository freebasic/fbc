'' examples/manual/proguide/multithreading/criticalsectionfaq12.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Dim As Any Ptr ptid
Dim As Double t0
Dim As Any Ptr p0 = @t0
Dim As Double t1
Dim As Double count
Dim As Single tmean
Dim As Single tmin = 10   '' start value
Dim As Single tmax = -10  '' start value

Sub myThread (ByVal p As Any Ptr)
	*Cast(Double Ptr, p) = Timer  '' similar code line as in main code
End Sub

Print "Tmin/Tmean/Tmax between begin of thread code and return from ThreadCreate() :"
Do
	count += 1
	ptid = ThreadCreate(@myThread, @t1)
	*Cast(Double Ptr, p0) = Timer  '' similar code line as in thread code
   
	ThreadWait(ptid)
   
	tmean = (tmean * (count - 1) + (t1 - t0)) / count
	If t1 - t0 < tmin Or t1 - t0 > tmax Then
		If t1 - t0 < tmin Then
			tmin = t1 - t0
		End If
		If t1 - t0 > tmax Then
			tmax = t1 - t0
		End If
		Print Time; Using "    Tmin=+###.###### ms    Tmean=+###.###### ms    Tmax=+###.###### ms"; tmin * 1000; tmean * 1000; tmax * 1000
	End If
Loop Until Inkey <> ""
