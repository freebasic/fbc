#include once "real10.bi"
#include once "intern.bi"

Operator ^ ( Byref lhs As ext, Byref rhs As ext ) As ext
    Dim As ext retval
    x_Power ( retval, lhs, rhs )
    Return retval
End Operator

Operator ^ ( Byref lhs As ext, Byval rhs As Integer ) As ext
    Dim As ext retval
    x_iPower ( retval, lhs, rhs )
    Return retval
End Operator

Operator ^ ( Byval lhs As Integer, Byref rhs As ext ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval
End Operator

Operator ^ ( Byref lhs As ext, Byval rhs As Single ) As ext
    Dim As ext retval
    sreal10 ( retval, rhs )
    x_Power ( retval, lhs, retval )
    Return retval
End Operator

Operator ^ ( Byval lhs As Single, Byref rhs As ext ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval
End Operator

Operator ^ ( Byref lhs As ext, Byval rhs As Double ) As ext
    Dim As ext retval
    dreal10 ( retval, rhs )
    x_Power ( retval, lhs, retval )
    Return retval
End Operator

Operator ^ ( Byval lhs As Double, Byref rhs As ext ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval
End Operator
