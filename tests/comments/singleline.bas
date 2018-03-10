' TEST_MODE : COMPILE_ONLY_OK

' this won't be parsed
rem this won't be parsed

' ':' statement separator ignored in comments
' comment : invalid_statement
rem comment : invalid_statement

rem comment is OK
rem rem comment is OK
' comment is OK
'' comment is OK
''' comment is OK

' end of line continuation is meaningless in comments
' comment _
#define X1
#ifndef X1
#error X1 should be defined
#endif

rem end of line continuation is meaningless in comments
rem comment _
#define X1
#ifndef X1
#error X1 should be defined
#endif

#if ENABLE_CHECK_BUGS

#print enable check for #866 fbc throws lexer errors in comments stating with $ 
#print see bug #866 at https://sourceforge.net/p/fbc/bugs/866/
#print introduced by #832 QB type suffixes allowed on any keywords 
#print see bug #832 at https://sourceforge.net/p/fbc/bugs/832/


'$=f#
'$=f#
'$=f#
'$=f#
'$=f#

rem ${f!
rem $=f# 
rem $^f$
rem $-f%
rem $@f&

#endif
