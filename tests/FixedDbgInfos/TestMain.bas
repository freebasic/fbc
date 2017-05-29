type tX
	d as BYTE
	e as integer
End Type

dim ttX as tX
with ttX
	select case  .d
		case 1,4,8,9
			.e=1
		case 2,3,5,7
			.e=2
		case else
			.e=3
	End Select
End With
dim as string a="aaaaaaaaaaaaaaaaaaaaaa"

#Include "Test1.bas"
dim as string b="bbbbbbbbbbbbbbbbbbbbbb" +a
end

sub ta naked()
	asm
		BLabel:
		.long 12345
		mov eax,1
	End Asm
End Sub
