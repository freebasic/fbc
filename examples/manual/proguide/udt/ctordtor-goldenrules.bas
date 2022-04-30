'' examples/manual/proguide/udt/ctordtor-goldenrules.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constructors, '=' Assignment-Operators, and Destructors (advanced, part #2)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgCtorsAssignDtors2
'' --------

'=== UDT with a string member =====================

Type UDTstr
   Dim As String s
End Type

'--------------------------------------------------

Dim As UDTstr us1
us1.s = "UDTstr"
Dim As UDTstr us2
us2 = us1
Dim As UDTstr us3 = us2
Print us1.s,
us1.s = ""
Print us2.s,
us2.s = ""
Print us3.s

'=== UDT with a string ptr member =================

Type UDTptr2str
   Dim As String Ptr ps
   Declare Constructor ()
   Declare Destructor ()
   Declare Operator Let (ByRef ups As UDTptr2str)
   Declare Constructor (ByRef ups As UDTptr2str)
End Type

Constructor UDTptr2str ()
   This.ps = New String
End Constructor

Destructor UDTptr2str ()
   Delete This.ps
End Destructor

Operator UDTptr2str.Let (ByRef ups As UDTptr2str)
   *This.ps = *ups.ps
End Operator

Constructor UDTptr2str (ByRef ups As UDTptr2str)
   Constructor()  '' calling the default constructor
   This = ups     '' calling the assignment operator
End Constructor

'--------------------------------------------------

Dim As UDTptr2str up1
*up1.ps = "UDTptr2str"
Dim As UDTptr2str up2
up2 = up1
Dim As UDTptr2str up3 = up2
Print *up1.ps,
*up1.ps = ""
Print *up2.ps,
*up2.ps = ""
Print *up3.ps

'==================================================

Sleep
			
