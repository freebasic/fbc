#include once "real10.bi"
#include once "intern.bi"

Operator ext.cast ( ) As Integer
    Operator = x_toLong ( this )
End Operator

Operator ext.cast ( ) As Single
    Operator = x_toSingle ( this )
End Operator

Operator ext.cast ( ) As Double
    Operator = x_toDouble ( this )
End Operator

Operator ext.cast ( ) As String
    Operator = x_FtoA( this )
End Operator

