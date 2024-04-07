'' examples/manual/proguide/primer/primer10.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FreeBASIC Primer #1'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPrimer1
'' --------

Dim As Single   total, count, number   ' multi variable declaration (same type)
Dim As String   text

Print "This program will calculate the sum and average for a"
Print "list of numbers. Enter an empty value to see results."
Print

Do
  Input "Enter a number: ", text       ' get user input
  If text = "" Then Exit Do            ' if empty -> quit Do/Loop
  count += 1                           ' increment count by: 1
  total += Val(text)                   ' add and assign new value
Loop

Print
Print "You entered:    "; count; "  number(s)"
Print "The sum is:     "; total

If count > 0 Then Print "The average is: "; total / count

Print
Print "Any keypress ends program. ";

Sleep
