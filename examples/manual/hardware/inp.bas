'' examples/manual/hardware/inp.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'INP'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInp
'' --------

'' Turn off PC speaker
Out &h61,Inp(&h61) And &hfc
