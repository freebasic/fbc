#ifndef __PP_BI__
#define __PP_BI__

#include once "list.bi"

enum FB_TOKEN_PP
	FB_TK_PP_IF                 = FB_TK_IF
	FB_TK_PP_IFDEF
	FB_TK_PP_IFNDEF
	FB_TK_PP_ELSE
	FB_TK_PP_ELSEIF
	FB_TK_PP_ENDIF
	FB_TK_PP_DEFINE
	FB_TK_PP_UNDEF
	FB_TK_PP_MACRO
	FB_TK_PP_ENDMACRO
	FB_TK_PP_INCLUDE
	FB_TK_PP_INCLIB
	FB_TK_PP_LIBPATH
	FB_TK_PP_PRAGMA
	FB_TK_PP_PRINT
	FB_TK_PP_ERROR
	FB_TK_PP_LINE
	FB_TK_PP_LANG
	FB_TK_PP_ASSERT
	FB_TK_PP_CMDLINE
	FB_TK_PP_DUMP
	FB_TK_PP_ODUMP
	FB_TK_PP_LOOKUP
end enum

type PP_CTX
	kwdns       as FBSYMBOL
	argtblist   as TLIST
	level       as integer
	skipping    as integer
	invoking    as integer      '' to let macros passed to other macros by name
end type

declare sub ppInit _
	( _
	)

declare sub ppEnd _
	( _
	)

declare sub ppCheck _
	( _
	)

declare sub ppParse( )

declare sub ppDefineInit _
	( _
	)

declare sub ppDefineEnd _
	( _
	)

declare sub ppDefine( byval ismultiline as integer )

declare function ppDefineLoad _
	( _
		byval s as FBSYMBOL ptr, _
		byval currmacro as FBSYMBOL ptr _
	) as integer

declare sub ppPragmaInit( )
declare sub ppPragmaEnd( )
declare sub ppPragma( )
declare function ppTypeOf( ) as string

declare sub ppCondInit _
	( _
	)

declare sub ppCondEnd _
	( _
	)

declare sub ppCondIf( )
declare sub ppCondElse( )
declare sub ppCondEndIf( )

declare sub ppAssert( )

declare function ppReadLiteral _
	( _
		byval ismultiline as integer = FALSE _
	) as zstring ptr

declare function ppReadLiteralW _
	( _
		byval ismultiline as integer = FALSE _
	) as wstring ptr


''
'' inter-module globals
''
extern pp as PP_CTX


#endif ''__PP_BI__
