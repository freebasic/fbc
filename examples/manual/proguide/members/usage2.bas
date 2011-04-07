'' examples/manual/proguide/members/usage2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgMemberProcedures
'' --------

'' ... foo with static members as before ...
#include once "foo2.bi"

Dim bar As foo
bar.f(foo.g())
