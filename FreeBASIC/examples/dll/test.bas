''
'' test -- calls a mydll's function and prints the result
'' 
'' compile as: fbc test.bas (couldn't be simplier, eh?)
''

'$include: 'mydll.bi'

	print "1 + 2 ="; addnumbers( 1, 2 )