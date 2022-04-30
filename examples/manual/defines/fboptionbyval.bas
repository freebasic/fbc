'' examples/manual/defines/fboptionbyval.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_OPTION_BYVAL__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboptionbyval
'' --------

#if( __FB_OPTION_BYVAL__ <> 0 )
  #error Option ByVal must Not be used With This source
#endif
