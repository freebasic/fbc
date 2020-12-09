'' examples/manual/defines/fbunquote2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbunquote
'' --------

#define X __FB_QUOTE__( Print "hello" )
#macro Y( arg )
  __FB_UNQUOTE__( arg )
#endmacro

Print X
Y( X )

/' Output:
print "hello"
hello
'/
	
