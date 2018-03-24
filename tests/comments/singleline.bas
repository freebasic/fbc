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

'$=f#
'$=f#
'$=f#
'$=f#
'$=f#

''$=f#
''$=f#
''$=f#
''$=f#
''$=f#

rem ${f!
rem $=f# 
rem $^f$
rem $-f%
rem $@f&
