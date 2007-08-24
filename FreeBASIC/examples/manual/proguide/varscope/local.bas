'' examples/manual/proguide/varscope/local.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgVariableScope
'' --------

'' visible only in this module
Dim As Integer local_moduleLevel1

'' OK.
Print local_moduleLevel1

Scope
  '' OK; SCOPE Blocks inherit outer scope
  Print local_moduleLevel1
  
  '' visible only in this SCOPE Block
  Dim As Integer local_moduleLevel2

  '' OK.
  Print local_moduleLevel2
End Scope

'' Error; can't see inner-SCOPE vars
'' print local_moduleLevel2

Function some_function( ) As Integer
  '' visible only in this function
  Dim As Integer local_functionLevel

  '' OK.
  Print local_functionLevel

  '' Error; can't see local module-level vars  
  '' print local_moduleLevel1

  '' Error; can't see local module-level vars
  '' print local_moduleLevel2

  function = 0

End Function

'' print local_functionLevel                    '' Error; can't see function_level vars
End 0
