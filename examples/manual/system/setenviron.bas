'' examples/manual/system/setenviron.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SETENVIRON'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSetenviron
'' --------

'e.g. to set the system variable "path" to "c:":

Shell "set path" 'shows the value of path
SetEnviron "path=c:"
Shell "set path" 'shows the new value of path
