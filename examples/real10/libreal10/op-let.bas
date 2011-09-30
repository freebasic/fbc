#include once "real10.bi"
#include once "intern.bi"

operator ext.let ( Byref rhs As ext )
    this.fl(0) = rhs.fl(0)
    this.fl(1) = rhs.fl(1)
    this.fl(2) = rhs.fl(2)
    this.fl(3) = rhs.fl(3)
end operator

operator ext.let ( Byval rhs As Integer )
    iReal10 ( this, rhs ) 
end operator

operator ext.let ( Byval rhs As Single )
    sReal10 ( this, rhs )
end operator

operator ext.let ( Byval rhs As Double )
    dReal10 ( this, rhs )
end operator

operator ext.let ( Byref rhs As String )
    x_AtoF ( this, rhs )
end operator

