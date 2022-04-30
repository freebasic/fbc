'' examples/manual/variable/byref4.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BYREF (variables)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgByrefVariables
'' --------

'' Polymorphism (by using inheritance and virtuality) can be activated through any of the 3 following kinds of entities:
''   - base-type pointers referring to derived-type objects,
''   - dereferenced base-type pointers referring to derived-type objects,
''   - base-type references referring to derived-type objects.
'
'' If in the first line of the below code, FALSE is put instead TRUE, the polymorphism by virtuality is no more activated.


#define virtuality True

Type myBase Extends Object
  #if virtuality = True
	Declare Virtual Sub hello()
  #else
	Declare Sub Hello()
  #endif
End Type

Sub myBase.hello()
  Print "myBase.hello()"
End Sub

Type myDerived Extends myBase
  Declare Sub hello()
End Type

Sub myDerived.hello()
  Print "myDerived.hello()"
End Sub


Dim As myBase mb
Dim As myBase Ptr pmb = @mb
Dim ByRef As myBase rmb = mb  '' or Var Byref rmb = mb
pmb->hello()    '' pmb is a base-type pointer referring to a base-type object
(*pmb).hello()  '' *pmb is a dereferenced base-type pointer referring to a base-type object
rmb.hello()     '' rmb is a base-type reference referring to a base-type object

Print

Dim As myDerived md
Dim As myBase Ptr pmd = @md
Dim ByRef As myBase rmd = md  '' only syntax because the reference data-type must be different from the one of object
pmd->hello()    '' pmd is a base-type pointer referring to a derived-type object
(*pmd).hello()  '' *pmd is a dereferenced base-type pointer referring to a derived-type object
rmd.hello()     '' rmd is a base-type reference referring to a derived-type object

Sleep
	
