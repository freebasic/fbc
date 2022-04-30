'' examples/manual/proguide/object-class.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Types as Objects'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgTypeObjects
'' --------

'' Sample Type showing available methods and operators
'' Practically this is a pointless example, as the only
'' data member is an Integer.  It serves only as a
'' guide to syntax.
''
'' There are many other combinations that can be
'' used in passed parameters.  For simplicity
'' This example only uses byref and type T
'' where ever possible.

'' The type 'DataType' is included to show where
'' any data type might be used
Type DataType As Integer

'' The type 'UDT' is included to show where only 
'' a UDT data type can be used
Type UDT
  value As DataType
End Type

'' Our main type
Type T
  value As DataType
  value_array( 0 ) As DataType

  '' let, cast, combined assignment operators,
  '' constructors, and the destructor, must be
  '' declared inside the type.
  ''
  '' Parameters can be passed Byval or Byref
  '' in most (All? - verify this).
  ''
  '' All procs can be overloaded with different
  '' types as parameters.  In many cases this is not
  '' necessary as the TYPE can be coerced and
  '' converted depending on the CAST methods
  '' it exposes.  The compiler will to its best
  '' to evaluate statements and expressions if
  '' there is enough information to complete
  '' the operation.
  ''
  '' For example,
  '' Even though operator += may not be overloaded
  '' but operator let and operator + are, the
  '' compiler will convert the T += datatype
  '' to T = T + datatype.

  '' Nonstatic members must be declared inside the
  '' type.
  ''
  '' All Nonstatic members are implicitly
  '' passed a hidden **this** parameter having
  '' the same type as the TYPE in which they are
  '' declared.
  ''
  '' Nonstatic member overloaded operators do not
  '' return a type.  All operations are done on the
  '' hidden this parameter.
  ''
  '' Properties: Can be value properties or single
  '' indexed value properties
  '' GET/SET methods must be each delcared if used.

  '' Nonstatic Member Declarations:

  '' Memory Allocation/Deallocation
  
  Declare Operator New ( ByVal size As UInteger ) As Any Ptr
  Declare Operator New[] ( ByVal size As UInteger ) As Any Ptr
  Declare Operator Delete ( ByVal buf As Any Ptr )
  Declare Operator Delete[] ( ByVal buf As Any Ptr )

  '' Assignment

  Declare Operator Let ( ByRef rhs As T )
  Declare Operator Let ( ByRef rhs As DataType )

  '' Cast can be overloaded to return multiple types

  Declare Operator Cast () As String
  Declare Operator Cast () As DataType

  '' Combined assignment

  Declare Operator += ( ByRef rhs As T )
  Declare Operator += ( ByRef rhs As DataType )
  Declare Operator -= ( ByRef rhs As DataType )
  Declare Operator *= ( ByRef rhs As DataType )
  Declare Operator /= ( ByRef rhs As DataType )
  Declare Operator \= ( ByRef rhs As DataType )
  Declare Operator Mod= ( ByRef rhs As DataType )
  Declare Operator Shl= ( ByRef rhs As DataType )
  Declare Operator Shr= ( ByRef rhs As DataType )
  Declare Operator And= ( ByRef rhs As DataType )
  Declare Operator Or= ( ByRef rhs As DataType )
  Declare Operator Xor= ( ByRef rhs As DataType )
  Declare Operator Imp= ( ByRef rhs As DataType )
  Declare Operator Eqv= ( ByRef rhs As DataType )
  Declare Operator ^= ( ByRef rhs As DataType )
  Declare Operator &= ( ByRef rhs As DataType )
  
  '' Address of

  Declare Operator @ () As DataType Ptr

  '' Constructors can be overloaded

  Declare Constructor ()
  Declare Constructor ( ByRef rhs As T )
  Declare Constructor ( ByRef rhs As DataType )

  '' There can be only one destructor

  Declare Destructor ()

  '' Nonstatic member functions and subs
  '' overloaded procs must have different parameters

  Declare Function f ( ) As DataType
  Declare Function f ( ByRef arg1 As DataType ) As DataType

  Declare Sub s ( )
  Declare Sub s ( ByRef arg1 As T )
  Declare Sub s ( ByRef arg1 As DataType )

  '' Properties

  Declare Property p () As DataType
  Declare Property p ( ByRef new_value As DataType )

  Declare Property pidx ( ByVal index As DataType ) As DataType
  Declare Property pidx ( ByVal index As DataType, ByRef new_value As DataType )

  '' Iterator
  
  Declare Operator For ()
  Declare Operator Step ()
  Declare Operator Next ( ByRef cond As T ) As Integer

  Declare Operator For ( ByRef stp As T )
  Declare Operator Step ( ByRef stp As T )
  Declare Operator Next ( ByRef cond As T, ByRef stp As T ) As Integer

End Type

'' These must be global procedures
'' Globals are not prefixed with the the TYPE name

'' At least one parameter must be of Type 'T'
'' For simplicity, type 'T' is always given first for binary ops
'' in this example

Declare Operator - ( ByRef rhs As T ) As DataType
Declare Operator Not ( ByRef rhs As T ) As DataType

Declare Operator -> ( ByRef rhs As T ) As UDT
Declare Operator * ( ByRef rhs As T ) As DataType

Declare Operator + ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator - ( ByRef lhs As T, ByRef rhs As DataType ) As DataType 
Declare Operator * ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator / ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator \ ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator Mod ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator Shl ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator Shr ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator And ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator Or ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator Xor ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator Imp ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator Eqv ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator ^ ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator = ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator <> ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator < ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator > ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator <= ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator >= ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
Declare Operator & ( ByRef lhs As T, ByRef rhs As DataType ) As DataType

Declare Operator Abs ( ByRef arg As UDT ) As Double
Declare Operator Fix ( ByRef arg As UDT ) As Double
Declare Operator Frac ( ByRef arg As UDT ) As Double
Declare Operator Int ( ByRef arg As UDT ) As Double
Declare Operator Sgn ( ByRef arg As UDT ) As Double

'' Global procedures (subs and funcs) can also accept the TYPE
'' as a parameter or return it as a value, as could be done
'' in previous versions of FreeBASIC.
'' No example given. See function or sub in the manual.

'' All TYPE members are defined outside the TYPE

'' Nonstatic members must be prefixed with type name
'' in this case 'T'

'' Name resolution in a NAMESPACE is same as other
'' subs/funcs.  Use USING or prefix the namespace name

Operator T.new ( ByVal size As UInteger ) As Any Ptr
	Operator = Allocate( size )
End Operator
 
Operator T.new[] ( ByVal size As UInteger ) As Any Ptr
	Operator = Allocate( size )
End Operator

Operator T.delete ( ByVal buf As Any Ptr )
	Deallocate buf
End Operator

Operator T.delete[] ( ByVal buf As Any Ptr )
	Deallocate buf
End Operator

Operator T.let ( ByRef rhs As T )
  value = rhs.value  
End Operator

Operator T.let ( ByRef rhs As DataType )
  value = rhs  
End Operator

Operator T.cast ( ) As String
  Return Str( value )
End Operator

Operator T.cast ( ) As DataType
  Return value
End Operator

Operator T.+= ( ByRef rhs As T )
  value += rhs.value
End Operator

Operator T.+= ( ByRef rhs As DataType )
  value += rhs
End Operator

Operator T.-= ( ByRef rhs As DataType )
  value -= rhs
End Operator

Operator T.*= ( ByRef rhs As DataType )
  value *= rhs
End Operator

Operator T./= ( ByRef rhs As DataType )
  value /= rhs
End Operator

Operator T.\= ( ByRef rhs As DataType )
  value \= rhs
End Operator

Operator T.mod= ( ByRef rhs As DataType )
  value Mod= rhs
End Operator

Operator T.shl= ( ByRef rhs As DataType )
  value Shl= rhs
End Operator

Operator T.shr= ( ByRef rhs As DataType )
  value Shr= rhs
End Operator

Operator T.and= ( ByRef rhs As DataType )
  value And= rhs
End Operator

Operator T.or= ( ByRef rhs As DataType )
  value Or= rhs
End Operator

Operator T.xor= ( ByRef rhs As DataType )
  value Xor= rhs
End Operator

Operator T.imp= ( ByRef rhs As DataType )
  value Imp= rhs
End Operator

Operator T.eqv= ( ByRef rhs As DataType )
  value Eqv= rhs
End Operator

Operator T.^= ( ByRef rhs As DataType )
  value ^= rhs
End Operator

Operator T.&= ( ByRef rhs As DataType )
  Dim tmp As String
  tmp &= Str( rhs )
End Operator

Operator T.@ () As DataType Ptr
  Return( Cast( DataType Ptr, @This ))
End Operator


'' Constructors:

Constructor T ()
  '' default constructor
  value = 0
End Constructor

Constructor T ( ByRef rhs As T )
  '' copy constructor
  value = rhs.value
End Constructor

Constructor T ( ByRef rhs As DataType )
  '' custom constructor
  value = rhs
End Constructor

'' There can be only one destructor

Destructor T ()
  '' clean-up, none in this example
End Destructor



'' Globals must specify all arguments and return type

Operator - ( ByRef rhs As T ) As DataType
  Return (-rhs.value)
End Operator

Operator Not ( ByRef rhs As T ) As DataType
  Return (Not rhs.value)
End Operator

Operator -> ( ByRef rhs As T ) As UDT
  Return Type(4)
End Operator

Operator * ( ByRef rhs As T ) As DataType
  Return 5
End Operator

Operator + ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value + rhs)
End Operator

Operator - ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value - rhs)
End Operator

Operator * ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value * rhs)
End Operator

Operator / ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value / rhs)
End Operator

Operator \ ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value \ rhs)
End Operator

Operator Mod ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value Mod rhs)
End Operator

Operator Shl ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value Shl rhs)
End Operator

Operator Shr ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value Shr rhs)
End Operator

Operator And ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value And rhs)
End Operator

Operator Or ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value Or rhs)
End Operator

Operator Xor ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value Xor rhs)
End Operator

Operator Imp ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value Imp rhs)
End Operator

Operator Eqv ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value Eqv rhs)
End Operator

Operator ^ ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value ^ rhs)
End Operator

Operator = ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value = rhs)
End Operator

Operator <> ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value <> rhs)
End Operator

Operator < ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value < rhs)
End Operator

Operator > ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value > rhs)
End Operator

Operator <= ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value <= rhs)
End Operator

Operator >= ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return (lhs.value >= rhs)
End Operator

Operator & ( ByRef lhs As T, ByRef rhs As DataType ) As DataType
  Return Val(lhs.value & rhs)
End Operator

Operator Abs ( ByRef arg As UDT ) As Double
	Return Abs(arg.value)
End Operator

Operator Fix ( ByRef arg As UDT ) As Double
	Return Fix(arg.value)
End Operator

Operator Frac ( ByRef arg As UDT ) As Double
	Return Frac(arg.value)
End Operator

Operator Int ( ByRef arg As UDT ) As Double
	Return Int(arg.value)
End Operator

Operator Sgn ( ByRef arg As UDT ) As Double
	Return Sgn(arg.value)
End Operator

'' Nonstatic member methods

Function T.f ( ) As DataType
  Dim x As DataType
  Return x
End Function

Function T.f ( ByRef arg1 As DataType ) As DataType
  arg1 = this.value
  Return value
End Function

Sub T.s ( )
  '' refer to the type using
  
  '' with block
  With This
	.value = 1
  End With
  
  '' field access
  this.value = 2
  
  '' directly
  value = 3

End Sub

Sub T.s ( ByRef arg1 As T )
  value = arg1.value
End Sub

Sub T.s ( ByRef arg1 As DataType )
  value = arg1
End Sub

Property T.p () As DataType
  '' GET property
  Return value
End Property

Property T.p ( ByRef new_value As DataType )
  '' SET property
  value = new_value
End Property

Property T.pidx ( ByVal index As DataType ) As DataType
  '' GET indexed property
  Return value_array( index )
End Property

Property T.pidx ( ByVal index As DataType, ByRef new_value As DataType )
  '' SET indexed property
  value_array( index ) = new_value
End Property

Operator T.for ()
End Operator

Operator T.step ()
End Operator

Operator T.next ( ByRef cond As T ) As Integer
  Return 0
End Operator

Operator T.for ( ByRef stp As T )
End Operator 

Operator T.step ( ByRef stp As T )
End Operator

Operator T.next ( ByRef cond As T, ByRef stp As T ) As Integer
  Return 0
End Operator

'' new, delete, delete[]

'' Allocate object
Dim X As T Ptr = New T

'' Deallocate object
Delete X

'' Allocate object vector
Dim Xlist As T Ptr = New T[10]

'' Deallocate object vector
Delete[] Xlist
		
