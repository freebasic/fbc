#include once "real10.bi"
#include once "intern.bi"

constructor ext ( Byref rhs As ext )
	this = rhs
end constructor

constructor ext ( Byval rhs As Integer )
    iReal10 ( this, rhs ) 
end constructor

constructor ext ( Byval rhs As Single )
    sReal10 ( this, rhs )
end constructor

constructor ext ( Byval rhs As Double )
    dReal10 ( this, rhs )
end constructor

constructor ext ( Byref rhs As String )
    x_AtoF ( this, rhs )
end constructor

