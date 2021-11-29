#include "fbcunit.bi"

Type VirtualRoot extends object
	/'0'/  Declare Abstract Operator Cast() As Integer
	/'4'/  Declare Abstract Operator Cast() As Long
	/'8'/  Declare Abstract Property Length() As Single
	/'12'/ Declare Abstract Property Length( ByVal new_length As Single )
	/'16'/ Declare virtual Sub ObjectRealType ()
	/'20'/ Declare Abstract Sub ObjectRealType(ByVal new_length As Integer )
	/'24'/ Declare Abstract Function ObjectRealType(ByVal new_length As Single ) As Single
	/'28'/ Declare virtual Destructor ()
End Type

Type Root Extends VirtualRoot
	/'0'/  Declare Operator Cast() As Integer
	/'4'/  Declare Operator Cast() As Long
	/'8'/  Declare Property Length() As Single
	/'12'/ Declare Property Length( ByVal new_length As Single )
	/'16'/ Declare Sub ObjectRealType ()
	/'20'/ Declare Sub ObjectRealType(ByVal new_length As Integer )
	/'24'/ Declare Function ObjectRealType(ByVal new_length As Single ) As Single
	/'28'/ Declare Destructor ()
End Type

Enum Em_Root
	/'0'/  Em_Cast_Integer						= 0
	/'4'/  Em_Cast__Long						= 4
	/'8'/  Em_Length__Single					= 8
	/'12'/ Em_Length_Single_					= 12
	/'16'/ Em_ObjectRealType__					= 16
	/'20'/ Em_ObjectRealType_Integer_			= 20
	/'24'/ Em_ObjectRealType_Single_Single		= 24
	/'28'/ Em_Destructor__						= 28
End Enum

#ifdef __FB_64BIT__
	#define FixSize 2
#else
	#define FixSize 1
#endif

dim shared id as integer

Sub VirtualRoot.ObjectRealType ()
	id = -(FixSize*Em_ObjectRealType__)
End Sub

Destructor VirtualRoot()
	id = -(FixSize*Em_Destructor__)
End Destructor

Operator Root.Cast() As Integer
	id = FixSize*Em_Cast_Integer
	return id
End Operator

Operator Root.Cast() As Long
	id = FixSize*Em_Cast__Long
	return id
End Operator

Property Root.Length() As Single
	id = FixSize*Em_Length__Single
	return id
End Property

Property Root.Length( ByVal new_length As Single )
	id = FixSize*Em_Length_Single_
End Property

Sub Root.ObjectRealType ()
	id = FixSize*Em_ObjectRealType__
End Sub

Sub Root.ObjectRealType(ByVal new_length As Integer )
	id = FixSize*Em_ObjectRealType_Integer_
End Sub

Function Root.ObjectRealType(ByVal new_length As Single ) As Single
	id = FixSize*Em_ObjectRealType_Single_Single
	return id
End Function

Destructor Root()
	id = FixSize*Em_Destructor__
End Destructor

SUITE( fbc_tests.pointers.AddressOf_Type )
	dim shared as Root vroot
	dim shared as Root ptr proot = @vroot
	dim shared as sub(byval this as any ptr ) pcallSub
	dim shared as sub(byval this as any ptr, ByVal new_length As Single ) pcallSub1
	dim shared as integer ptr pAddress

	#define DoTest_offsetof( offset, ProcNameAndType... ) _
	CU_ASSERT_EQUAL( FixSize * offset, offsetof(Root, (ProcNameAndType)) )

	'Syntax tree parsing
	TEST( SyntaxParsing )
		dim as integer value = any
		DoTest_offsetof( Em_Cast_Integer, Cast )
		DoTest_offsetof( Em_Cast_Integer, Cast, )
		DoTest_offsetof( Em_Cast_Integer, Cast, Operator() As Integer )
		value = offsetof(Root,          ( Cast, Any ) )
		value = offsetof(Root,          ( Cast, Any Operator() As Integer ) )

		DoTest_offsetof( Em_Length__Single, Length )
		DoTest_offsetof( Em_Length__Single, Length, )
		DoTest_offsetof( Em_Length__Single, Length, Property() As Single )
		value = offsetof(Root,            ( Length, Any ) )
		value = offsetof(Root,            ( Length, Any Property() As Single ) )

		DoTest_offsetof( Em_Destructor__, , Destructor() )
		value = offsetof(Root, ( , Any Destructor() ) )

	END_TEST

	'Gets the offset of the virtual function
	TEST( GetProcOffsetAddress2 )

		DoTest_offsetof( Em_Cast_Integer, Cast )
		DoTest_offsetof( Em_Length__Single, Length )
		DoTest_offsetof( Em_ObjectRealType__, ObjectRealType )
		DoTest_offsetof( Em_Destructor__, , Destructor() )

		DoTest_offsetof( Em_Cast_Integer, Cast, Operator() As Integer )
		DoTest_offsetof( Em_Cast__Long, Cast, Operator() As Long )
		DoTest_offsetof( Em_Length__Single, Length, Property() As Single )
		DoTest_offsetof( Em_Length_Single_, Length, Property( ByVal new_length As Single ) )
		DoTest_offsetof( Em_ObjectRealType__, ObjectRealType, Sub() )
		DoTest_offsetof( Em_ObjectRealType_Integer_, ObjectRealType, Sub(ByVal new_length As Integer) )
		DoTest_offsetof( Em_ObjectRealType_Single_Single, ObjectRealType, Function(ByVal new_length As Single ) As Single )

	END_TEST

	#define DoTest_GetAddressAnyAny( ProcName, ProcType... ) _
	CU_ASSERT_EQUAL( offsetof(Root, (ProcName, Any ProcType)), @vroot.(ProcName, Any ProcType) )

	#define DoTest_GetAddressAnyNone( ProcName, ProcType... ) _
	CU_ASSERT_EQUAL( offsetof(Root, (ProcName, Any ProcType)), @proot[0].(ProcName, ProcType) )

	#define DoTest_GetAddressAnyNone1( ProcName, ProcType... ) _
	CU_ASSERT_EQUAL( offsetof(Root, (ProcName, Any ProcType)), @proot->(ProcName, ProcType) )

	#macro DoTest_GetAddressNoneNone( ProcName, ProcType... )
		pAddress = *cast(integer ptr, cast(any ptr, proot)) + offsetof(Root, (ProcName, ProcType))
		CU_ASSERT_EQUAL( *pAddress, @proot->(ProcName, ProcType) )
	#endmacro

	#macro DoTest_GetProcRealAddress( ProcName, ProcType... )
		DoTest_GetAddressAnyAny( ProcName, ProcType )
		DoTest_GetAddressAnyNone( ProcName, ProcType )
		DoTest_GetAddressAnyNone1( ProcName, ProcType )
		DoTest_GetAddressNoneNone( ProcName, ProcType )
	#endmacro

	'Gets the real address of the function
	TEST( GetProcRealAddress )

		DoTest_GetProcRealAddress( Cast )
		DoTest_GetProcRealAddress( Cast )
		DoTest_GetProcRealAddress( Length )
		DoTest_GetProcRealAddress( Length )
		DoTest_GetProcRealAddress( ObjectRealType )
		DoTest_GetProcRealAddress( ObjectRealType )
		DoTest_GetProcRealAddress( ObjectRealType )
		DoTest_GetProcRealAddress( , Destructor() )

		DoTest_GetProcRealAddress( Cast, Operator() As Integer )
		DoTest_GetProcRealAddress( Cast, Operator() As Long )
		DoTest_GetProcRealAddress( Length, Property() As Single )
		DoTest_GetProcRealAddress( Length, Property( ByVal new_length As Single ) )
		DoTest_GetProcRealAddress( ObjectRealType, Sub() )
		DoTest_GetProcRealAddress( ObjectRealType, Sub(ByVal new_length As Integer) )
		DoTest_GetProcRealAddress( ObjectRealType, Function(ByVal new_length As Single ) As Single )
		DoTest_GetProcRealAddress( , Destructor() )

	END_TEST

	#macro DoTest_RunAddressAnyAny( offset, new_length ,ProcName, ProcType, Args... )
		pAddress = @proot->(ProcName, ProcType##Args)
		#if #new_length<>""
			pcallSub1 = pAddress
			pcallSub1( proot, new_length )
		#else
			pcallSub = pAddress
			pcallSub( proot )
		#endIf
		CU_ASSERT_EQUAL( FixSize * offset, id )
	#endmacro

	#macro DoTest_RunAddressAnyNone( offset, new_length ,ProcName, ProcType, Args... )
		pAddress = offsetof(Root, (ProcName, Any ProcType##Args))
		#if #new_length<>""
			pcallSub1 = pAddress
			pcallSub1( proot, new_length )
		#else
			pcallSub = pAddress
			pcallSub( proot )
		#endIf
		CU_ASSERT_EQUAL( FixSize * offset, id )
	#endmacro

	#macro DoTest_RunAddressNoneNone( offset, new_length ,ProcName, ProcType, Args... )
		pAddress = *cast(integer ptr, cast(any ptr, proot)) + offsetof(Root, (ProcName, ProcType##Args))
		#if #new_length<>""
			pcallSub1 = *pAddress
			pcallSub1( proot, new_length )
		#else
			pcallSub = *pAddress
			pcallSub( proot )
		#endIf
		CU_ASSERT_EQUAL( FixSize * offset, id )
	#endmacro

	#macro DoTest_RunProcRealAddress( offset, new_length ,ProcName, ProcType, Args... )
		DoTest_RunAddressAnyAny( offset, new_length ,ProcName, ProcType, Args )
		DoTest_RunAddressAnyNone( offset, new_length ,ProcName, ProcType, Args )
		DoTest_RunAddressNoneNone( offset, new_length ,ProcName, ProcType, Args )
	#endmacro

	'Gets the real address of the function
	TEST( RunProcRealAddress2 )
		DoTest_RunProcRealAddress( Em_Cast_Integer, ,Cast, Operator, () As Integer )
		DoTest_RunProcRealAddress( Em_Cast__Long,, Cast, Operator, () As Long )
		DoTest_RunProcRealAddress( Em_Length__Single, ,Length, Property, () As Single )
		DoTest_RunProcRealAddress( Em_Length_Single_,1 ,Length, Property, ( ByVal new_length As Single ) )
		DoTest_RunProcRealAddress( Em_ObjectRealType__, ,ObjectRealType, Sub, () )
		DoTest_RunProcRealAddress( Em_ObjectRealType_Integer_,1 ,ObjectRealType, Sub, (ByVal new_length As Integer) )
		DoTest_RunProcRealAddress( Em_ObjectRealType_Single_Single,1 ,ObjectRealType, Function, (ByVal new_length As Single ) As Single )

		''======== Calling this function will release the structure data ======
		'  DoTest_RunAddressNoneNone( Em_Destructor__, , , Destructor, () )
		''=====================================================================

	END_TEST

END_SUITE
