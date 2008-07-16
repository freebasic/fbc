'' examples/manual/fileio/basicvsc.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgFileIO
'' --------

Data " File I/O test | 2008-07-04 "
Rem
Rem  Compile With FB 0.18.5
Rem  NOTE: FB 0.20 will support returning the amount of Data Read when Using Get

#include "crt\stdio.bi" '' Otherwise the "C"-stuff won't work

Dim As FILE  Ptr   QQ
Dim As UByte Ptr   BUF

Dim As UInteger    DD, EE, FF, GG, HH
Dim As ULongInt    II64

Dim As String      VGSTEMP, VGSFILE1, VGSFILE2

? : Read VGSTEMP : ? VGSTEMP : ?

VGSTEMP=Command$(1) : VGSFILE1="BLAH"
If VGSTEMP<>"" Then VGSFILE1=VGSTEMP
VGSTEMP=Command$(2) : VGSFILE2=VGSFILE1
If VGSTEMP<>"" Then VGSFILE2=VGSTEMP

BUF = Allocate(32768) '' 32 KiB

? : ? "FB - OPEN - GET """;VGSFILE1;"""": Sleep 1000
FF = FreeFile : HH=0 : II64=0
GG=Open (VGSFILE1 For Binary Access Read As #FF) '' Result 0 is OK here
'' "ACCESS READ" prevents from creating an empty file if it doesn't exist yet
? "OPEN: ";GG
If (GG=0) Then
  EE=Cast(UInteger,(Timer*100)) '' No integer timer in FB
  GG=Get (#FF,,*BUF,32768)
  '' But no way ^^^ to find out how much stuff got read 
  '' Even worse, EOF is __NOT__ considered as error, must vvv use EOF to test
  ? "1st  GET: ";GG
  ? "*** ";BUF[0];" ";BUF[1]
  Do
	HH=HH+1
	If EOF(FF) Or (GG<>0) Then Exit Do
	II64=II64+32768ull
	GG=Get (#FF,,*BUF,32768)
  Loop
  DD=Cast(UInteger,(Timer*100))-EE
  ? (DD+1)*10;" ms"
  If (HH>1) Then ? "Last GET: ";GG
  ? "Got cca ";II64;" to ";II64+32768ull;" bytes in ";HH;" calls"
  Close #FF
Endif

? : ? "C - FOPEN - FREAD """;VGSFILE2;"""" : Sleep 1000
HH=0 : II64=0
QQ=FOPEN(VGSFILE2,"rb")
'' Here 0 is evil and <>0 good, opposite from above !!!
'' Open existing file, will not be created if it doesn't exist 
'' "rb" is case sensitive and must be lowercase, STRPTR seems not necessary
? "FOPEN: ";QQ 
If (QQ<>0) Then
  EE=Cast(UInteger,(Timer*100))
  GG=FREAD(BUF,1,32768,QQ) '' 1 is size of byte - can't live without :-D
  '' Returns size of data read, <32768 on EOF, 0 after EOF, or "-1" on error 
  ? "1st FREAD ";GG
  ? "*** ";BUF[0];" ";BUF[1]
  Do
	HH=HH+1
	If (GG<=32768) Then II64=II64+Cast(ULongInt,GG)
	If (GG<>32768) Then Exit Do '' ERR or EOF
	GG=FREAD(BUF,1,32768,QQ)
  Loop
  DD=Cast(UInteger,(Timer*100))-EE
  ? (DD+1)*10;" ms"
  If (HH>1) Then ? "Last FREAD: ";GG
  ? "Got __EXACTLY__ ";II64;" bytes in ";HH;" calls"
  FCLOSE(QQ)
Endif

Deallocate(BUF): Sleep 1000 '' Crucial

End 
