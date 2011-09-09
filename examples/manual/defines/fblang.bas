'' examples/manual/defines/fblang.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfblang
'' --------

'' Set option explicit always on

#ifdef __FB_LANG__
  #if __FB_LANG__ <> "fb"
	Option Explicit
  #endif
#else
  '' Older version - before lang fb
  Option Explicit
#endif
