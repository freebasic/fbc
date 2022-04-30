'' examples/manual/faq/dos/lowmemas.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DOS related FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=FaqDOS
'' --------

'' DOS only example of inline ASM accessing low memory 
'' Run in text mode 80x25 only

'' Including dos/go32.bi will define "_dos_ds"
'' "pointing" into GO32 block

#include "dos/go32.bi" 

Dim As UInteger DDS

DDS=_dos_ds

? : ? "Hello world !"
? "_dos_ds=$";Hex$(DDS) 
? "This is just a tEst - abcd ABCD XYZ xyz @[`{ - press any key ..."

Do
  Sleep 1000
  If Inkey$<>"" Then Exit Do
  Asm
	mov  eax,[DDS] '' Directly using "_dos_ds" won't work here !!!
	push eax
	pop  gs        '' Just to get sure, it is usually set anyway
	Xor  ebx,ebx
	aa3:
	mov  al,[gs:0xB8000+2*ebx]
	cmp  al,65  '' "a"
	jb   aa1
	cmp  al,122 '' "z"
	ja   aa1   
	cmp  al,90  '' "Z"
	jbe  aa2
	cmp  al,97  '' "a"    
	jb   aa1 
	aa2: 
	Xor  al,32  '' Swap case
	aa1:
	mov  [gs:0xB8000+2*ebx],al
	inc  ebx
	cmp  ebx,2000
	jne  aa3
  End Asm  
Loop
? : ? "Bye"
End
