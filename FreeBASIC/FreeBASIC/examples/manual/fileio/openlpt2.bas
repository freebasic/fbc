'' examples/manual/fileio/openlpt2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpenLpt
'' --------

' Sends contents of text file test.txt to Windows printer named "ReceiptPrinter"
Dim RptInput As String
Dim PrintFileNum As Integer, RptFileFileNum As Integer

RptFileFileNum = FreeFile
Open "test.txt" For Input As #RptFileFileNum

PrintFileNum = FreeFile
Open Lpt "LPT:ReceiptPrinter,TITLE=ReceiptWinTitle,EMU=TTY" As _
	#PrintFilenum

While (EOF(RptFileFileNum) = 0)
	    Line Input #RptFileFileNum, RptInput
	    Print #PrintFileNum, RptInput
Wend

Close #PrintFileNum  ' Interestingly, does not require CHR(12).  But if pagination is desired, CHR(12) is the way.

Close #RptFileFileNum

Print "Press any key to end program..."
GetKey

End
