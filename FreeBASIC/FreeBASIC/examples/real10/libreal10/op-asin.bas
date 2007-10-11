#include once "real10.bi"
#include once "intern.bi"

Function xAsin ( Byref lhs As ext ) As ext
    Dim As ext retval
    x_Asin ( retval, lhs )
    Return retval
End Function

Function xAsin ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Asin ( retval, retval )
    Return retval
End Function

Function xAsin ( Byval lhs As Single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Asin ( retval, retval )
    Return retval
End Function

Function xAsin ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Asin ( retval, retval )
    Return retval
End Function
