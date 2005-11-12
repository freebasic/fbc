#ifndef __PP_BI__
#define __P_BI__

declare sub 		ppInit					( )

declare sub 		ppEnd					( )

declare function 	ppParse 				( ) as integer

declare sub		 	ppDefineInit			( )

declare sub		 	ppDefineEnd				( )

declare function 	ppDefine				( ) as integer

declare function 	ppDefineLoad			( byval s as FBSYMBOL ptr ) as integer

declare sub		 	ppPragmaInit			( )

declare sub		 	ppPragmaEnd				( )

declare function 	ppPragma				( ) as integer

declare sub		 	ppCondInit				( )

declare sub		 	ppCondEnd				( )

declare function 	ppCondIf 				( ) as integer

declare function 	ppCondElse 				( )  as integer

declare function 	ppCondEndIf 			( ) as integer


declare function 	ppReadLiteral			( ) as zstring ptr

declare function 	ppReadLiteralW			( ) as wstring ptr

#endif ''__PP_BI__
