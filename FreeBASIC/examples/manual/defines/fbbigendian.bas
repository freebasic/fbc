'' examples/manual/defines/fbbigendian.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdFBBigEndian
'' --------

#ifdef __FB_BIGENDIAN__
   '...instructions only for big endian machines
#else
  '...instructions only for little endian machines
#endif 
