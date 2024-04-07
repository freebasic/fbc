'' examples/manual/defines/fbmain.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_MAIN__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdFBMain
'' --------

#ifdef __FB_MAIN__
  #print Compiling the main module
#else
  #print Compiling an additional module
#endif
