'' examples/manual/proguide/members/usage1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberProcedures
'' --------

'' ... foo with non-static members as before ...
#include once "foo1.bi"

Dim bar As foo
bar.f(bar.g())
