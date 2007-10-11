#include once "real10.bi"
#include once "intern.bi"

Function xLog10 ( Byref lhs As ext ) As ext
    Dim As ext retval
    x_Log10 ( retval, lhs )
    Return retval
End Function

Function xLog10 ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Log10 ( retval, retval )
    Return retval
End Function

Function xLog10 ( Byval lhs As Single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Log10 ( retval, retval )
    Return retval
End Function

Function xLog10 ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Log10 ( retval, retval )
    Return retval
End Function
