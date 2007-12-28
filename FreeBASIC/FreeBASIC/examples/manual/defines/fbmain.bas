'' examples/manual/defines/fbmain.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdFBMain
'' --------

#ifdef __FB_MAIN__
  #print Compiling the main module
#else
  #print Compiling an additional module
#endif
