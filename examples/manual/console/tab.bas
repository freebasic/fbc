'' examples/manual/console/tab.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'TAB'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTab
'' --------

'' Using Print with Tab to justify text in a table

Dim As String A1, B1, A2, B2

A1 = "Jane"
B1 = "Doe"
A2 = "Bob"
B2 = "Smith"

Print "FIRST NAME"; Tab(35); "LAST NAME"
Print "----------"; Tab(35); "----------"
Print A1; Tab(35); B1
Print A2; Tab(35); B2
