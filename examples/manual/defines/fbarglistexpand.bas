'' examples/manual/defines/fbarglistexpand.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_ARG_LISTEXPAND__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbarglistexpand
'' --------

#macro m( arg... )
	#print "   "##arg
#endmacro

#print "macroargcount>0 (=1):"
__FB_ARG_LISTEXPAND__( m, 1, Hello1, Hello2, Hello3, Hello4)
#print " "
#print "macroargcount=0 (=0):"
__FB_ARG_LISTEXPAND__( m, 0, Hello1, Hello2, Hello3, Hello4)
#print " "
#print "macroargcount<0 (=-1):"
__FB_ARG_LISTEXPAND__( m, -1, Hello1, Hello2, Hello3, Hello4)


/' Compiler output:
macroargcount>0 (=1):
   Hello1
   Hello2
   Hello3
   Hello4
 
macroargcount=0 (=0):
   Hello1, Hello2, Hello3, Hello4
 
macroargcount<0 (=-1):
   Hello1, Hello2, Hello3, Hello4
   Hello2, Hello3, Hello4
   Hello3, Hello4
   Hello4
'/
