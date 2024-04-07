'' examples/manual/fileio/openlpt2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPEN LPT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpenLpt
'' --------

' Sends contents of text file test.txt to Windows printer named "ReceiptPrinter"
Dim RptInput As String
Dim PrintFileNum As Long, RptFileFileNum As Long

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
