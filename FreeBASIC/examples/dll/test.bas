''
'' test -- calls a mydll's function and prints the result
'' 
'' compile as: fbc test.bas (couldn't be simplier, eh?)
''

'$include: 'C:\prg\code\bas\freeBASIC\examples\dll\mydll.bi'

	print "1 + 2 ="; addnumbers( 1, 2 )