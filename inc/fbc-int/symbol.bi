#ifndef __FBC_INT_SYMBOL_BI__
#define __FBC_INT_SYMBOL_BI__

'' warning: WORK IN PROGRESS
'' This header exposes internals of the fbc compiler through the built-in
'' macro __FB_QUERY_SYMBOL__.  Much work is still needed here.
''
'' Constants are mostly copied as-is from src/compiler/symb.bi
'' Except:
'' - fbc namespace added
'' - macros prefixed with fbc
''
'' Use symbol names and fully qualified symbols in user code for hopefully
'' the least number of breakages in future.

# if __FB_LANG__ = "qb"
#     error "include not supported in qb dialect"
# endif

namespace FBC

'' declarations must follow src/compiler/symb.bi

enum FB_DATACLASS
	FB_DATACLASS_INTEGER
	FB_DATACLASS_FPOINT
	FB_DATACLASS_STRING
	FB_DATACLASS_UDT
	FB_DATACLASS_PROC
	FB_DATACLASS_UNKNOWN
end enum

enum FB_DATATYPE
	FB_DATATYPE_VOID
	FB_DATATYPE_BOOLEAN
	FB_DATATYPE_BYTE
	FB_DATATYPE_UBYTE
	FB_DATATYPE_CHAR
	FB_DATATYPE_SHORT
	FB_DATATYPE_USHORT
	FB_DATATYPE_WCHAR
	FB_DATATYPE_INTEGER
	FB_DATATYPE_UINT
	FB_DATATYPE_ENUM
	FB_DATATYPE_LONG
	FB_DATATYPE_ULONG
	FB_DATATYPE_LONGINT
	FB_DATATYPE_ULONGINT
	FB_DATATYPE_SINGLE
	FB_DATATYPE_DOUBLE
	FB_DATATYPE_STRING
	FB_DATATYPE_FIXSTR
	FB_DATATYPE_VA_LIST
	FB_DATATYPE_STRUCT
	FB_DATATYPE_NAMESPC
	FB_DATATYPE_FUNCTION
	FB_DATATYPE_FWDREF
	FB_DATATYPE_POINTER
	FB_DATATYPE_XMMWORD
end enum

const FB_DATATYPES = (FB_DATATYPE_XMMWORD - FB_DATATYPE_VOID) + 1

const FB_DT_TYPEMASK        = &b00000000000000000000000000011111 '' max 32 built-in datatypes
const FB_DT_PTRMASK         = &b00000000000000000000000111100000 '' level of pointer indirection
const FB_DT_CONSTMASK       = &b00000000000000111111111000000000 '' PTRLEVELS + 1 bit-masks
const FB_DATATYPE_REFERENCE = &b00000000000010000000000000000000 '' used for mangling BYREF parameters
const FB_DT_MANGLEMASK      = &b00000001111100000000000000000000 '' used to modify mangling for builtin types
const FB_DATATYPE_INVALID   = &b10000000000000000000000000000000

const FB_DT_PTRLEVELS       = 8                 '' max levels of pointer indirection
const FB_DT_PTRPOS          = 5                 '' first bit for pointer level
const FB_DT_CONSTPOS        = FB_DT_PTRPOS + 4  '' first bit for const bits
const FB_DT_MANGLEPOS       = 20                '' first bit for mangle modifier

enum FB_SYMBCLASS
	FB_SYMBCLASS_VAR            = 1         '' variable
	FB_SYMBCLASS_CONST                      '' constant
	FB_SYMBCLASS_PROC                       '' procedure
	FB_SYMBCLASS_PARAM                      '' parameter
	FB_SYMBCLASS_DEFINE                     '' define
	FB_SYMBCLASS_KEYWORD                    '' keyword
	FB_SYMBCLASS_LABEL                      '' label
	FB_SYMBCLASS_NAMESPACE                  '' namespace
	FB_SYMBCLASS_ENUM                       '' enum
	FB_SYMBCLASS_STRUCT                     '' type
	FB_SYMBCLASS_CLASS                      '' class
	FB_SYMBCLASS_FIELD                      '' field
	FB_SYMBCLASS_TYPEDEF                    '' typedef
	FB_SYMBCLASS_FWDREF                     '' forward definition
	FB_SYMBCLASS_SCOPE                      '' scope
	FB_SYMBCLASS_RESERVED                   '' reserved symbol
	FB_SYMBCLASS_NSIMPORT                   '' namespace import (an USING)
end enum

'' !!!TODO!!! - explain these ...
#define fbcTypeGet( dt ) iif( dt and fbc.FB_DT_PTRMASK, fbc.FB_DATATYPE_POINTER, dt and fbc.FB_DT_TYPEMASK )
#define fbcTypeGetDtOnly( dt ) (dt and fbc.FB_DT_TYPEMASK)
#define fbcTypeGetDtAndPtrOnly( dt ) (dt and (fbc.FB_DT_TYPEMASK or fbc.B_DT_PTRMASK))
#define fbcTypeGetDtPtrAndMangleDtOnly( dt ) (dt and (fbc.FB_DT_TYPEMASK or FB_DT_PTRMASK or fbc.FB_DT_MANGLEMASK))

#define fbcTypeIsPtr( dt ) (((dt and fbc.FB_DT_PTRMASK) <> 0))
#define fbcTypeGetPtrCnt( dt ) ((dt and fbc.FB_DT_PTRMASK) shr fbc.FB_DT_PTRPOS)

'' FB_QUERY_SYMBOL must follow src/compiler/symb-define.bas
''
enum FB_QUERY_SYMBOL explicit

	'' query type
	symbclass  = &h0000     '' return the symbol's class as FB_SYMBCLASS
	datatype   = &h0001     '' return symbol's type as FB_DATATYPE
	dataclass  = &h0002     '' return the symbol's data class as FB_DATACLASS
	typename   = &h0003     '' return the typename as text
	typenameid = &h0004     '' return the typename as text with specical characters replaced with '_'
	mangleid   = &h0005     '' return the decorated (mangled) type name (WIP)
	exists     = &h0006     '' return if the symbol name / identifier is exists

	querymask  = &h00ff     '' mask for query values

	'' filters
	'' if no filter is given, and filtermask is zero, then the default methods
	'' are used for symbol lookup.  If filtermask is non-zero, then only use
	'' the specified methods for symbol lookup

	identifier = &h0100     '' use identifier & type name symbol lookups
	typeofexpr = &h0200     '' use TYPEOF/expression

	filtermask = &hff00     '' mask for filter values

end enum

'' Convenience MACROS
'' warning: naming is subject to change
''

'' FB_SYMBCLASS
#define isVariable( sym )  ( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym ) = fbc.FB_SYMBCLASS_VAR )
#define isConst( sym )     ( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym ) = fbc.FB_SYMBCLASS_CONST )
#define isProcedure( sym ) ( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym ) = fbc.FB_SYMBCLASS_PROC )
#define isNamespace( sym ) ( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym ) = fbc.FB_SYMBCLASS_NAMESPACE )
#define isUDT( sym )       ( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym ) = fbc.FB_SYMBCLASS_STRUCT )

'' FB_DATACLASS
#define isDataClassInteger( sym ) ( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.dataclass, sym ) = fbc.FB_DATACLASS_INTEGER )
#define isDataClassFloat( sym )   ( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.dataclass, sym ) = fbc.FB_DATACLASS_FLOAT )
#define isDataClassString( sym )  ( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.dataclass, sym ) = fbc.FB_DATACLASS_STRING )
#define isDataClassUDT( sym )     ( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.dataclass, sym ) = fbc.FB_DATACLASS_UDT )
#define isDataClassProc( sym )    ( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.dataclass, sym ) = fbc.FB_DATACLASS_PROC )

'' FB_DATATYPE
#define isTypeBoolean( sym )  ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_BOOLEAN )
#define isTypeByte( sym )     ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_BYTE )
#define isTypeUbyte( sym )    ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_UBYTE )
#define isTypeShort( sym )    ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_SHORT )
#define isTypeUShort( sym )   ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_USHORT )
#define isTypeLong( sym )     ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_LONG )
#define isTypeULong( sym )    ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_ULONG )
#define isTypeInteger( sym )  ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_INTEGER )
#define isTypeUInteger( sym ) ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_UINTEGER )
#define isTypeLongint( sym )  ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_LONGINT )
#define isTypeULongint( sym ) ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_ULONGINT )
#define isTypeSingle( sym )   ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_SINGLE )
#define isTypeDouble( sym )   ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_DOUBLE )
#define isTypeUDT( sym )      ( fbcTypeGetDtOnly( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_STRUCT )
#define isTypePointer( sym )  ( fbcTypeGet      ( __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.datatype, sym ) ) = fbc.FB_DATATYPE_POINTER )


end namespace

#endif


