'' examples/manual/proguide/assignments.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Assignments'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgAssignments
'' --------

Dim As Integer x, y, z

x = 5          ''        (or 'x => 5')
Print x        ''  5     (assignment expression is a constant)

y = x + 4      ''        (or 'y => x + 4')
Print y        ''  9     (assignment expression is the sum of a variable and a constant)

y = y + 3      ''        (or 'y => y + 3')
Print y        ''  12    (value of x is incremented by 3)

z = 3          ''        (or 'z => 3')
z *= x         ''        (or 'z *=> x')
Print z        ''  15    (value of z is multiplied by value of x)

If x = y Then  ''        (value of x is not modified)
  Print x
Else
  Print x, y   ''  5     12
End If

x = y = z      ''        (or 'x => y = z')    (value of y is not modified)
Print x, y, z  ''  0     12    15
		
