#include once "real10.bi"
#include once "intern.bi"

Operator >= ( Byref lhs As ext, Byref rhs As ext ) As Integer
    Dim As Integer relop
    relop=x_Fcom ( lhs, rhs )
    Return relop>=0
End Operator

Operator >= ( Byref lhs As ext, Byval rhs As Integer ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As Integer, Byref rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop>=0
End Operator

Operator >= ( Byref lhs As ext, Byval rhs As Single ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As Single, Byref rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop>=0
End Operator

Operator >= ( Byref lhs As ext, Byval rhs As Double ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As Double, Byref rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop>=0
End Operator
