'' SUFFIX warnings

'$lang: "qb"

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

#print ---- parser-assignment.bas ----

WARN( 0 )
dim a%
WARN( 1 )
let% a% = 1

WARN( 0 )
dim b%(1 to 2)
WARN( 1 )
let% b%(1) = 1

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
print input$(0)
print command$(0)

#print ---- Procedure ----

WARN(0)
declare function foo$
s$ = foo$
function foo$
	foo$ = "bar"
end function
