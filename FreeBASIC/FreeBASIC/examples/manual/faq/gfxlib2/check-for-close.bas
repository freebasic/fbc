'' examples/manual/faq/gfxlib2/check-for-close.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=FaqPggfxlib2
'' --------

Screen 13
Do
  Print "Click the 'x' to close this app."
  Sleep
Loop Until Inkey = Chr( 255 ) + "k"
