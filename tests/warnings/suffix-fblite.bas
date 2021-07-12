'' SUFFIX warnings

#lang "fblite"

#macro WARN( W )
	#if (W=0)
		#print none expected
	#elseif (W=1)
		#print warning expected
	#elseif (W>1) and (W<10)
		#print W warnings expected
	#else
		#print argument must be 0 to 9
		#error
	#endif
#endmacro

'' parser-assignment.bas ----
#print parser-assignment.bas ----

	sub parser_assignment()
		dim i as integer
		WARN( 1 )
		let% i = 1
	end sub


'' parser-comment.bas ----
#print parser-comment.bas ----

	'$lang: "fblite"
	WARN( 1 )
	'$include once%: "suffix-inc.bi"

	WARN( 1 )
	'$dynamic%
	WARN( 1 )
	'$static%


'' parser-decl-option.bas ----
#print parser-decl-option.bas ----

	WARN( 3 )
	defbyte% A%-Z%
	WARN( 1 )
	defubyte% A-Z
	WARN( 1 )
	defshort% A-Z
	WARN( 1 )
	defushort% A-Z
	WARN( 1 )
	defint% A-Z
	WARN( 1 )
	defuint% A-Z
	WARN( 1 )
	deflng% A-Z
	WARN( 1 )
	defulng% A-Z
	WARN( 1 )
	deflongint% A-Z
	WARN( 1 )
	defulongint% A-Z
	WARN( 1 )
	defsng% A-Z
	WARN( 1 )
	defdbl% A-Z
	WARN( 1 )
	defstr% A-Z

	WARN( 2 )
	option% byval%
	WARN( 1 )
	option  dynamic%
	WARN( 1 )
	option  static%
	WARN( 1 )
	option  gosub%
	WARN( 1 )
	option  explicit%
	WARN( 1 )
	option  private%
	WARN( 1 )
	option  escape%
	WARN( 1 )
	option  base% 1
	#define scrap
	WARN( 1 )
	option  nokeyword% scrap
	WARN( 1 )
	option  nogosub%
	WARN( 1 )
	option  gosub%


'' parser-quirk-goto-return.bas ----
#print parser-quirk-goto-return.bas ----

	WARN( 2 )
	goto% label%
	WARN( 2 )
	gosub% label%
	WARN( 2 )
	return% label%
	WARN( 2 )
	resume% next%

WARN( 1 )
label%:
	WARN( 1 )
	goto label%


'' parser-quirk-on.bas ----
#print parser-quirk-on.bas ----

	sub proc()
		goto label1%
		label1%:
		dim a as integer
		WARN( 4 )
		on% local% a goto% label1%
		WARN( 4 )
		on% local% a gosub% label1%
		WARN( 4 )
		on% error% goto% label1%
		WARN( 1 )
		goto label1%
	end sub

#print ---- String Functions ----

	WARN( 0 )
	print chr$(0)
	print inkey$
	print str$(0)
	print space$(0)
	print string$(0,0)
	print oct$(0)
	print hex$(0)
	print mks$(0)
	print mkd$(0)
	print mkl$(0)
	print mki$(0)
	print mkshort$(0)
	print mklongint$(0)
	print ltrim$("")
	print rtrim$("")
	print mid$("",0,0)
	print left$("",0)
	print right$("",0)
	print lcase$("")
	print ucase$("")
	print time$
	print date$
	print environ$("")
	print trim$("")
	print input$(0)
	print command$(0)

	WARN( 4 )
	print wchr$(0)
	print wstr$(0)
	print wstring$(0,0)
	print bin$(0)

#print ---- Procedure ----

	WARN(0)
	declare function foo$
	dim s$
	s$ = foo$
	function foo$
		foo$ = "bar"
	end function
