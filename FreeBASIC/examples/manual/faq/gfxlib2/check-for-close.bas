'' examples/manual/faq/gfxlib2/check-for-close.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=FaqPggfxlib2
'' --------

'' "X" close button example , Win32 and Linux only
Dim As String key
Screen 13
Do
  Print "Click the 'x' to close this app."
  Sleep
  key = Inkey
Loop Until key = Chr(27) Or key = Chr(255, 107) 'escape or x-button
