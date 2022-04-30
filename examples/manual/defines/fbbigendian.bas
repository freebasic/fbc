'' examples/manual/defines/fbbigendian.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_BIGENDIAN__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdFBBigEndian
'' --------

#ifdef __FB_BIGENDIAN__
   '...instructions only for big endian machines
#else
  '...instructions only for little endian machines
#endif 
