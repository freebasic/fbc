'' examples/manual/system/fre.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FRE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFre
'' --------

Dim mem As UInteger = Fre

Print "Free memory:"
Print
Print mem; " bytes"
Print mem  \ 1024; " kilobytes"
Print mem  \ (1024 * 1024); " megabytes"
