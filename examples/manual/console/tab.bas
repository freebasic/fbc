'' examples/manual/console/tab.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTab
'' --------

'' Using Print with Tab to justify text in a table

Dim As String A1, B1, A2, B2

A1 = "Jane"
B1 = "DOE"
A2 = "Bob"
B2 = "Smith"

Print "FIRST NAME"; Tab(35); "LAST NAME"
Print "----------"; Tab(35); "----------"
Print A1; Tab(35); B1
Print A2; Tab(35); B2
