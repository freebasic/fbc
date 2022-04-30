'' examples/manual/datatype/string-buffer.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'STRING'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgString
'' --------

'' Variable-length strings as buffers

'' Reserving space for a string,
'' using Space() to produce lots of space characters (ASCII 32)
Dim As String mybigstring = Space(1024)
Print "buffer address: &h" & Hex( StrPtr( mybigstring ), 8 ) & ", length: " & Len( mybigstring )

'' Explicitly destroying a string
mybigstring = ""
Print "buffer address: &h" & Hex( StrPtr( mybigstring ), 8 ) & ", length: " & Len( mybigstring )
