type tX
	a as byte
	b as short
	c as integer
	d as long
	e as longint
	f as longint
	g as string
End Type
type tX2
	a as tX PTR
	b as short
	c as integer
	d as long
	e as longint
	f as longint
	g as string
End Type
dim ttX as tX2,CTTX AS TX
dim 	aa as Ubyte=ANY,dF as long=ANY
select case  aa
	case 1,4,5 to 8,9
		dF=1
	case 2,3,5,7
		dF=2
	case else
		if aa=8 then
			dF=3
		EndIf
End Select
with ttX

	.A=@CTTX
	select case  .a->A
		case 1,4,5 to 8,9
			.f=1
		case 2,3,5,7
			.f=2
		case else
			if .a->A=8 then
				.f=3
			EndIf
	End Select
	select case  .B
		case 1,4,5 to 8,9
			.f=1
		case 2,3,5,7
			.f=2
		case else
			.f=3
	End Select
	select case  cast(short,.A->A)
		case 1,4,5 to 8,9
			.f=1
		case 2,3,5,7
			.f=2
		case else
			.f=3
	End Select

	.g="GGGGG"
	select case  .g
		case "1,4,5 to 8,9"
			.f=1
		case "2,3,5,7"
			.f=2
		case else
			.f=3
	End Select
End With
dim as string a="aaaaaaaaaaaaaaaaaaaaaa"

#Include "Test1.bas"
dim as string b="bbbbbbbbbbbbbbbbbbbbbb" +a
end

sub ta naked()
	asm
		BLabel:
		mov eax,ebx
		.long 12345
		mov eax,1
	End Asm
End Sub
