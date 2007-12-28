declare Function x_Exponent(Byref x As ext) As Integer
declare Function x_toLong(Byref x As ext) As Integer
declare Function x_toSingle(Byref x As ext) As Single
declare Function x_toDouble(Byref x As ext) As Double
declare Function nInt(Byref x As ext) As Integer
declare Sub x_Frac(Byref y As ext, Byref x As ext) 'y=frac(x)
declare Sub iReal10(Byref x As ext,Byval i As Integer)
declare Sub sReal10(Byref x As ext,Byval i As Single)
declare Sub dReal10(Byref x As ext,Byval i As Double)
declare Sub x_iPower(Byref y As ext, Byref x As ext, Byval e As Integer)
declare Sub x_Trunc(Byref y As ext, Byref x As ext) 'y=trunc(x)
declare Sub x_iMul(Byref y As ext, Byref x As ext, Byval z As Integer) 'y=x*z 
declare Sub x_Sub(Byref z As ext, Byref x As ext, Byref y As ext) 'z=x-y
declare Function x_Sign(Byref x As ext) As Integer   'returns -1 if x<0,  0 if x=0,  1 if x>0 
declare Function x_FtoA(Byref x As ext) As String
declare Sub x_AtoF(Byref x As ext, Byval value As String)
declare Function x_Fcom(Byref x As ext, Byref y As ext) As Integer
declare Sub x_Abs(Byref y As ext,Byref x As ext)'y=abs(x)
declare Sub x_Neg(Byref y As ext,Byref x As ext)'y=-x
declare Sub x_Add(Byref z As ext,Byref x As ext,Byref y As ext)'z=x+y
declare Sub x_Mul(Byref z As ext,Byref x As ext,Byref y As ext)'z=x*y
declare Sub x_Div(Byref z As ext,Byref x As ext,Byref y As ext)'z=x/y
declare Sub x_iDiv(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x/z 
declare Sub x_iAdd(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x+z 
declare Sub x_iSub(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x-z 
declare Sub xInc(Byref x As ext)'x=x+1
declare Sub xDec(Byref x As ext)'x=x-1
declare Sub x_Scale(Byref y As ext,Byref x As ext,Byval j As Integer)'y=x*2^j
declare Function x_Factorial(Byref y As ext,Byref x As ext) As Integer'y=x!
declare Sub x_Sqrt(Byref y As ext,Byref x As ext)'y=sqrt(x)
declare Sub x_Log10(Byref y As ext,Byref x As ext)'y=log10(x)
declare Sub x_Log(Byref y As ext,Byref x As ext) 'y=ln(x)
declare Sub x_ExpTen(Byref y As ext,Byref x As ext) 'y=10^x
declare Sub x_Exp(Byref y As ext,Byref x As ext) 'y=e^x
declare Sub x_Sin(Byref y As ext,Byref x As ext) 'y=sin(x)
declare Sub x_Cos(Byref y As ext,Byref x As ext) 'y=cos(x)
declare Sub x_Tan(Byref y As ext,Byref x As ext) 'y=tan(x)
declare Sub x_Asin(Byref y As ext,Byref x As ext)'y=asin(x)
declare Sub x_Acos(Byref y As ext,Byref x As ext)'y=acos(x)
declare Sub x_Atan(Byref y As ext,Byref x As ext)'y=atan(x)
declare Sub x_Sinh(Byref y As ext,Byref x As ext)'y=sinh(x)
declare Sub x_Cosh(Byref y As ext,Byref x As ext)'y=cosh(x)
declare Sub x_Tanh(Byref y As ext,Byref x As ext)'y=tanh(x)
declare Sub x_Asinh(Byref y As ext,Byref x As ext)'y=asinh(x)
declare Sub x_Acosh(Byref y As ext,Byref x As ext)'y=acosh(x)
declare Sub x_Atanh(Byref y As ext,Byref x As ext)'y=atanh(x)
declare Sub x_Power(Byref y As ext,Byref x As ext, Byref z As ext) 'y=x^z
declare Function x_Floor(Byref y As ext, Byref x As ext) As Integer'y=Floor(x)
