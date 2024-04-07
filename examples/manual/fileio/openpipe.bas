'' examples/manual/fileio/openpipe.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPEN PIPE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpenPipe
'' --------

'' This example uses Open Pipe to run a shell command and retrieve its output. 
#ifdef __FB_UNIX__
Const TEST_COMMAND = "ls *"
#else
Const TEST_COMMAND = "dir *.*"
#endif

Open Pipe TEST_COMMAND For Input As #1

Dim As String ln
Do Until EOF(1)
	Line Input #1, ln
	Print ln
Loop

Close #1
