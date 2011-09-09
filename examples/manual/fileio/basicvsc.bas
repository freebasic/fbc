'' examples/manual/fileio/basicvsc.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgFileIO
'' --------

Data " File I/O example & test GET vs FREAD | (CL) 2008-10-12 Public Domain "
Data " http://www.freebasic.net/wiki/wikka.php?wakka=ProPgFileIO "
Rem
Rem Compile With FB 0.20 Or newer
Rem
Rem In the commandline supply preferably 2 different files of same big size
Rem Default Is "BLAH" For both (bad)
Rem In both loops (Get And FREAD) the last Read can be "empty" ... no problem

#include "crt\stdio.bi" '' Otherwise the "C"-stuff won't work

Dim As FILE  Ptr   QQ   '' This is the C-like file access pointer
Dim As UByte Ptr   BUF  '' Buffer used for both FB-like and C-like read
Dim As UInteger    FILN '' FB-like "filenumber"

Dim As UInteger    AA, BB, CC, DD, EE
Dim As ULongInt    II64 '' We do try to support files >= 4 GiB

Dim As String      VGSTEMP, VGSFILE1, VGSFILE2

? : Read VGSTEMP : ? VGSTEMP : Read VGSTEMP : ? VGSTEMP : ?

VGSTEMP=Command$(1) : VGSFILE1="BLAH"
If (VGSTEMP<>"") Then VGSFILE1=VGSTEMP
VGSTEMP=Command$(2) : VGSFILE2=VGSFILE1
If (VGSTEMP<>"") Then VGSFILE2=VGSTEMP

BUF = Allocate(32768) '' 32 KiB - hoping it won't fail, BUF could be 0 ...

? : ? "FB - OPEN - GET , """+VGSFILE1+"""": Sleep 1000
FILN = FreeFile : AA=0 : II64=0 '' AA counts blocks per 32 KiB already read
BB=Open (VGSFILE1 For Binary Access Read As #FILN)
'' Result 0 is OK here, <>0 is evil
'' "ACCESS READ" should prevent file creation if it doesn't exist
? "OPEN result  : " ; BB
If (BB=0) Then '' BB will be "reused" for timer below
  BB=Cast(UInteger,(Timer*100)) '' No UINTEGER TIMER in FB, make units 10 ms
  CC=Get (#FILN,,*BUF,32768,DD)
  '' CC has the success status, 0 is OK, <>0 is bad
  '' DD is the amount of data read
  '' EOF is __NOT__ considered as error here
  ? "0th GET      : ";CC;" ";DD
  ? "2 bytes read : ";BUF[0];" ";BUF[1]
  Do
	AA=AA+1 : II64=II64+Cast(ULongInt,DD)
	If (DD<32768) Or (CC<>0) Then Exit Do '' Give up
	CC=Get (#FILN,,*BUF,32768,DD)
  Loop
  EE=Cast(UInteger,(Timer*100))-BB
  ? "Time         : ";(EE+1)*10;" ms"
  If (AA>1) Then ? "Last GET     : ";CC;" ";DD
  ? "Got __EXACTLY__ ";II64;" bytes in ";AA;" calls"
  Close #FILN
ENDIF

? : ? "C - FOPEN - FREAD , """+VGSFILE2+"""" : Sleep 1000
AA=0 : II64=0 '' AA counts blocks per 32 KiB already read
QQ=FOPEN(VGSFILE2,"rb")
'' Here 0 is evil and <>0 good, opposite from above !!!
'' File will not be created if it doesn't exist (good)
'' "rb" is case sensitive and must be lowercase, STRPTR seems not necessary
? "FOPEN result : " ; QQ
If (QQ<>0) Then
  BB=Cast(UInteger,(Timer*100)) '' No UINTEGER TIMER in FB, make units 10 ms
  DD=FREAD(BUF,1,32768,QQ) '' 1 is size of byte - can't live without :-D
  '' Returns size of data read, <32768 on EOF, 0 after EOF, or "-1" on error
  ? "0th FREAD    : ";DD
  ? "2 bytes read : ";BUF[0];" ";BUF[1]
  Do
	AA=AA+1
	If (DD<=32768) Then II64=II64+Cast(ULongInt,DD)
	If (DD<>32768) Then Exit Do '' ERR or EOF
	DD=FREAD(BUF,1,32768,QQ)
  Loop
  EE=Cast(UInteger,(Timer*100))-BB
  ? "Time         : ";(EE+1)*10;" ms"
  If (AA>1) Then ? "Last FREAD   : ";DD
  ? "Got __EXACTLY__ ";II64;" bytes in ";AA;" calls"
  FCLOSE(QQ)
ENDIF

Deallocate(BUF): Sleep 1000 '' Crucial

End
