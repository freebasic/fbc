'' examples/manual/system/setenviron.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSetenviron
'' --------

'e.g. to set the system variable "path" to "c:":

Shell "set path" 'shows the value of path
SetEnviron "path=c:"
Shell "set path" 'shows the new value of path
