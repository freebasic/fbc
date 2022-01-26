#include once "_concat.bi"

#pragma once

#define __FB_Type_Equals(x, comp) (TypeOf(x) = TypeOf(comp))

#define __FB_Is_Integer(type) (__FB_Type_Equals(type, BOOLEAN) OrElse __FB_Type_Equals(type, BYTE) OrElse __FB_Type_Equals(type, UBYTE) OrElse __FB_Type_Equals(type, SHORT) OrElse __FB_Type_Equals(type, USHORT) OrElse __FB_Type_Equals(type, LONG) OrElse __FB_Type_Equals(type, ULONG) OrElse __FB_Type_Equals(type, INTEGER) OrElse __FB_Type_Equals(type, UINTEGER) OrElse __FB_Type_Equals(type, LONGINT) OrElse __FB_Type_Equals(type, ULONGINT))
#define __FB_Is_Float(type) (__FB_Type_Equals(type, FLOAT) OrElse __FB_Type_Equals(type, DOUBLE))
#define __FB_Is_String(type) (__FB_Type_Equals(type, STRING) OrElse __FB_Type_Equals(type, ZSTRING))

#define __FB_Is_BuiltIn(type) (__FB_Is_Integer(type) OrElse __FB_Is_Float(type) OrElse __FB_Is_String(type))

#define __FB_Ptr_Base_Type(type) __FB_ARG_LEFTOF__(type, PTR)

#define __FB_Is_Ptr(type) ( _
    __FB_QUOTE__(__FB_Ptr_Base_Type(type)) <> "" _
)

'' Smushes all args together into one long string 
'' So for __FB_MakePPType(MyNamespace, MySecondNamespace, MyType)
'' Produce MyNamespaceMySecondNamespaceMyType
#macro __FB_MakePPType_InternalBase(args...)
'' No ptrs, just concat everything
__FB_JOIN__( _
    __MAC_CONCAT_ARG_LIST, _
    __FB_ARG_COUNT__(args) _
) (args)

#endmacro

'' Replaces the last arg with out smushed together pointer type
'' then throws the whole lot to the non-ptr version to concat everything
#macro __FB_MakePPType_InternalPtr(args...)
__FB_MakePPType_InternalBase( _
    __FB_JOIN__( _
        __MAC_REPLACE_LAST_ARG, _
        __FB_ARG_COUNT__(args) _
    ) _
    ( _
        args, _
        __FB_JOIN__(__FB_Ptr_Base_Type(__FB_JOIN__(__MAC_LAST_ARG, __FB_ARG_COUNT__(args))(args)), Ptr) _
    ) _
)
#endmacro

'' adds PTR to the end of the type name, then extracts what's to the right of Ptr
'' If the type wasn't a Ptr, then there is nothing to the right of Ptr so Base is returned
'' If it was a ptr, then to the right of it will be the Ptr we just added
#define __FB_GetTypePtrOrBase(type) __FB_ARG_RIGHTOF__(__FB_UNQUOTE__(__FB_EVAL__(__FB_QUOTE__(type) " Ptr")), PTR, Base)

'' Smushes all args together into one long string 
'' So for __FB_MakePPType(MyNamespace, MySecondNamespace, MyType)
'' Produce MyNamespaceMySecondNamespaceMyType
'' Works with ptrs too
#macro __FB_MakePPType(args...)
__FB_JOIN__( _
    __FB_MakePPType_Internal, _
    __FB_GetTypePtrOrBase( _
		__FB_JOIN__( _
			__MAC_LAST_ARG, _
			__FB_ARG_COUNT__(args) _
		)(args) _
    ) _
)(args)

#endmacro

'' Put the dots in for the proper FB type
'' So for __FB_MakeFBType(MyNamespace, MySecondNamespace, MyType)
'' Produce MyNamespace.MySecondNamespace.MyType
#macro __FB_MakeFBType(args...)
__FB_JOIN__(__MAC_JOIN_ARG_LIST, __FB_ARG_COUNT__(args))(.,args)
#endmacro

#macro __FB_DefinePassType(Type, Name)
#if  __FB_Is_Integer(Type) OrElse __FB_Is_Float(Type) OrElse __FB_Is_Ptr(Type)
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(Name) " ByVal"))
#else
__FB_UNQUOTE__(__FB_EVAL__("#define " __FB_QUOTE__(Name) " ByRef"))
#endif
#endmacro

#define __FB_MakeTypeName(BaseType, UserType) __FB_JOIN__(BaseType, UserType)

#define __FB_Unwrap(x) x

#define __FB_MakeAssocTypeName(key, value) __FB_MakeTypeName( __FB_MakePPType key, __FB_MakePPType value)

'' Turn debug on if compiling with -exx
#if (__FB_ERR__ And 7) = 7
#define FB_CONTAINER_DEBUG
#endif

