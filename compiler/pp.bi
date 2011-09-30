#ifndef __PP_BI__
#define __PP_BI__

#include once "list.bi"

enum FB_TOKEN_PP
	FB_TK_PP_IF					= FB_TK_IF
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
end enum

type PP_CTX
	kwdns		as FBSYMBOL
	argtblist	as TLIST
	level 		as integer
	skipping	as integer
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

declare function ppParse _
	( _
	) as integer

declare sub ppDefineInit _
	( _
	)

declare sub ppDefineEnd _
	( _
	)

declare function ppDefine _
	( _
		byval ismultiline as integer _
	) as integer

declare function ppDefineLoad _
	( _
		byval s as FBSYMBOL ptr _
	) as integer

declare sub ppPragmaInit _
	( _
	)

declare sub ppPragmaEnd _
	( _
	)

declare function ppPragma _
	( _
	) as integer

declare function ppTypeOf _
	( _
	) as zstring ptr

declare sub ppCondInit _
	( _
	)

declare sub ppCondEnd _
	( _
	)

declare function ppCondIf _
	( _
	) as integer

declare function ppCondElse _
	( _
	) as integer

declare function ppCondEndIf _
	( _
	) as integer

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
