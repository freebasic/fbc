'' examples/manual/prepro/defined.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DEFINED'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDefined
'' --------

'e.g. - which symbols are defined out of a, b, c, and d ?

Const a = 300
#define b 12
Dim c As Single

#if defined(a)
 Print "a is defined"
#endif
#if defined(b)
 Print "b is defined"
#endif
#if defined(c)
 Print "c is defined"
#endif
#if defined(d)
 Print "d is defined"
#endif
