'' real10 routines by srvaldez (jbklassen[=at=]warpdriveonline.com)

#inclib "real10"

Union ext
    As Ushort fw(0 to 5-1)
    As Ubyte tb(0 to 10-1)

   Declare constructor ( Byref rhs As ext )
   Declare constructor ( Byval rhs As Integer = 0 )
   Declare constructor ( Byval rhs As Long = 0 )
   Declare constructor ( Byval rhs As LongInt = 0 )
   Declare constructor ( Byval rhs As UInteger = 0 )
   Declare constructor ( Byval rhs As ULong = 0 )
   Declare constructor ( Byval rhs As ULongInt = 0 )
   Declare constructor ( Byval rhs As Single )
   Declare constructor ( Byval rhs As Double )
   Declare constructor ( Byref rhs As String ="0" )

    Declare operator let( byref rhs As ext )
    Declare operator let( byval rhs As Integer )
    Declare operator let( byval rhs As Long )
    Declare operator let( byval rhs As LongInt )
    Declare operator let( byval rhs As UInteger )
    Declare operator let( byval rhs As ULong )
    Declare operator let( byval rhs As ULongInt )
    Declare operator let( byval rhs As Single )
    Declare operator let( byval rhs As Double )
    Declare operator let( byref rhs As String ) 

    '' implicit step versions
    Declare Operator For ( )
    Declare Operator Step( )
    Declare Operator Next( Byref end_cond As ext ) As Integer
   
    '' explicit step versions
    Declare Operator For ( Byref step_var As ext )
    Declare Operator Step( Byref step_var As ext )
    Declare Operator Next( Byref end_cond As ext, Byref step_var As ext ) As Integer
    Declare Operator += (byval rhs as double)
    Declare operator cast( ) As Integer
    Declare operator cast( ) As Long
    Declare operator cast( ) As LongInt
    Declare operator cast( ) As UInteger
    Declare operator cast( ) As ULong
    Declare operator cast( ) As ULongInt
    Declare operator cast( ) As Single
    Declare operator cast( ) As Double
    Declare operator cast( ) As String   
End Union

Declare Function x_Exponent(Byref x As ext) As Integer
Declare Function x_toInt(Byref x As ext) As Integer
Declare Function x_toLong(Byref x As ext) As Long
Declare Function x_toLongInt(Byref x As ext) As LongInt
Declare Function x_toUInt(Byref x As ext) As UInteger
Declare Function x_toULong(Byref x As ext) As ULong
Declare Function x_toULongInt(Byref x As ext) As ULongInt
Declare Function x_toSingle(Byref x As ext) As Single
Declare Function x_toDouble(Byref x As ext) As Double
Declare Function nInt(Byref x As ext) As Integer
Declare Sub x_Frac(Byref y As ext, Byref x As ext)

Declare Sub iReal10(Byref x As ext,Byval i As Integer)
Declare Sub ilReal10(Byref x As ext,Byval i As Long)
Declare Sub iqReal10(Byref x As ext,Byval i As LongInt)
Declare Sub uiReal10(Byref x As ext,Byval i As UInteger)
Declare Sub uilReal10(Byref x As ext,Byval i As ULong)
Declare Sub uiqReal10(Byref x As ext,Byval i As ULongInt)
Declare Sub sReal10(Byref x As ext,Byval i As Single)
Declare Sub dReal10(Byref x As ext,Byval i As Double)
Declare Sub x_iPower(Byref y As ext, Byref x As ext, Byval e As Integer)
Declare Sub x_Trunc(Byref y As ext, Byref x As ext) 'y=trunc(x)
Declare Sub x_iMul(Byref y as ext, Byref x As ext, Byval z As Integer) 'y=x*z
Declare Sub x_Sub(Byref z As ext, Byref x As ext, Byref y As ext) 'z=x-y
Declare Function x_Sign(Byref x As ext) As Integer   'returns -1 if x<0,  0 if x=0,  1 if x>0
Declare Function x_FtoA(Byref x As ext, byval prec as integer=17) As String
Declare Sub x_AtoF(Byref x As ext, Byval value As String)
Declare Function x_Fcom(Byref x As ext, Byref y As ext) As Integer
Declare Sub x_Abs(Byref y As ext,Byref x As ext)'y=abs(x)
Declare Sub x_Neg(Byref y As ext,Byref x As ext)'y=-x
Declare Sub x_Add(Byref z As ext,Byref x As ext,Byref y As ext)'z=x+y
Declare Sub x_Mul(Byref z As ext,Byref x As ext,Byref y As ext)'z=x*y
Declare Sub x_Div(Byref z As ext,Byref x As ext,Byref y As ext)'z=x/y
Declare Sub x_iDiv(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x/z
Declare Sub x_iAdd(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x+z
Declare Sub x_iSub(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x-z
Declare Sub xInc(Byref x As ext)'x=x+1
Declare Sub xDec(Byref x As ext)'x=x-1
Declare Sub x_Scale(Byref y As ext,Byref x As ext,Byval j As Integer)'y=x*2^j
Declare Function x_Factorial(Byref y As ext,Byref x As ext) As Integer'y=x!
Declare Sub x_Sqrt(Byref y As ext,Byref x As ext)'y=sqrt(x)
Declare Sub x_Log10(Byref y As ext,Byref x As ext)'y=log10(x)
Declare Sub x_Log(Byref y As ext,Byref x As ext) 'y=ln(x)
Declare Sub x_ExpTen(Byref y As ext,Byref x As ext) 'y=10^x
Declare Sub x_Exp(Byref y As ext,Byref x As ext) 'y=e^x
Declare Sub x_Sin(Byref y As ext,Byref x As ext) 'y=sin(x)
Declare Sub x_Cos(Byref y As ext,Byref x As ext) 'y=cos(x)
Declare Sub x_Tan(Byref y As ext,Byref x As ext) 'y=tan(x)
Declare Sub x_Asin(Byref y As ext,Byref x As ext)'y=asin(x)
Declare Sub x_Acos(Byref y As ext,Byref x As ext)'y=acos(x)
Declare Sub x_Atan(Byref y As ext,Byref x As ext)'y=atan(x)
Declare Sub x_Sinh(Byref y As ext,Byref x As ext)'y=sinh(x)
Declare Sub x_Cosh(Byref y As ext,Byref x As ext)'y=cosh(x)
Declare Sub x_Tanh(Byref y As ext,Byref x As ext)'y=tanh(x)
Declare Sub x_Asinh(Byref y As ext,Byref x As ext)'y=asinh(x)
Declare Sub x_Acosh(Byref y As ext,Byref x As ext)'y=acosh(x)
Declare Sub x_Atanh(Byref y As ext,Byref x As ext)'y=atanh(x)
Declare Sub x_Power(Byref y As ext,Byref x As ext, Byref z As ext) 'y=x^z
Declare Function x_Floor(Byref y As ext, Byref x As ext) As Integer'y=Floor(x)

Declare Function cext Overload ( Byref lhs As ext ) As ext
Declare Function cext ( Byval lhs As Integer ) As ext
Declare Function cext ( Byval lhs As Long ) As ext
Declare Function cext ( Byval lhs As LongInt ) As ext
Declare Function cext ( Byval lhs As UInteger ) As ext
Declare Function cext ( Byval lhs As ULong ) As ext
Declare Function cext ( Byval lhs As ULongInt ) As ext
Declare Function cext ( Byval lhs As Single )  As ext
Declare Function cext ( Byval lhs As Double )  As ext
Declare Function cext ( Byval lhs As String )  As ext

Declare Function xSin Overload ( Byval lhs As ext ) As ext
Declare Function xSin ( Byval lhs As Integer ) As ext
Declare Function xSin ( Byval lhs As Long ) As ext
Declare Function xSin ( Byval lhs As LongInt ) As ext
Declare Function xSin ( Byval lhs As UInteger ) As ext
Declare Function xSin ( Byval lhs As ULong ) As ext
Declare Function xSin ( Byval lhs As ULongInt ) As ext
Declare Function xSin ( Byval lhs As single )  As ext
Declare Function xSin ( Byval lhs As Double )  As ext
Declare Function xSin ( Byval lhs As String )  As ext

Declare Function xCos Overload ( Byval lhs As ext ) As ext
Declare Function xCos ( Byval lhs As Integer ) As ext
Declare Function xCos ( Byval lhs As Long ) As ext
Declare Function xCos ( Byval lhs As LongInt ) As ext
Declare Function xCos ( Byval lhs As UInteger ) As ext
Declare Function xCos ( Byval lhs As ULong ) As ext
Declare Function xCos ( Byval lhs As ULongInt ) As ext
Declare Function xCos ( Byval lhs As single )  As ext
Declare Function xCos ( Byval lhs As Double )  As ext
Declare Function xCos ( Byval lhs As String )  As ext

Declare Function xTan Overload ( Byval lhs As ext ) As ext
Declare Function xTan ( Byval lhs As Integer ) As ext
Declare Function xTan ( Byval lhs As Long ) As ext
Declare Function xTan ( Byval lhs As LongInt ) As ext
Declare Function xTan ( Byval lhs As UInteger ) As ext
Declare Function xTan ( Byval lhs As ULong ) As ext
Declare Function xTan ( Byval lhs As ULongInt ) As ext
Declare Function xTan ( Byval lhs As single )  As ext
Declare Function xTan ( Byval lhs As Double )  As ext
Declare Function xTan ( Byval lhs As String )  As ext

Declare Function xSinh Overload ( Byval lhs As ext ) As ext
Declare Function xSinh ( Byval lhs As Integer ) As ext
Declare Function xSinh ( Byval lhs As Long ) As ext
Declare Function xSinh ( Byval lhs As LongInt ) As ext
Declare Function xSinh ( Byval lhs As UInteger ) As ext
Declare Function xSinh ( Byval lhs As ULong ) As ext
Declare Function xSinh ( Byval lhs As ULongInt ) As ext
Declare Function xSinh ( Byval lhs As single )  As ext
Declare Function xSinh ( Byval lhs As Double )  As ext
Declare Function xSinh ( Byval lhs As String )  As ext

Declare Function xCosh Overload ( Byval lhs As ext ) As ext
Declare Function xCosh ( Byval lhs As Integer ) As ext
Declare Function xCosh ( Byval lhs As Long ) As ext
Declare Function xCosh ( Byval lhs As LongInt ) As ext
Declare Function xCosh ( Byval lhs As UInteger ) As ext
Declare Function xCosh ( Byval lhs As ULong ) As ext
Declare Function xCosh ( Byval lhs As ULongInt ) As ext
Declare Function xCosh ( Byval lhs As single )  As ext
Declare Function xCosh ( Byval lhs As Double )  As ext
Declare Function xCosh ( Byval lhs As String )  As ext

Declare Function xTanh Overload ( Byval lhs As ext ) As ext
Declare Function xTanh ( Byval lhs As Integer ) As ext
Declare Function xTanh ( Byval lhs As Long ) As ext
Declare Function xTanh ( Byval lhs As LongInt ) As ext
Declare Function xTanh ( Byval lhs As UInteger ) As ext
Declare Function xTanh ( Byval lhs As ULong ) As ext
Declare Function xTanh ( Byval lhs As ULongInt ) As ext
Declare Function xTanh ( Byval lhs As single )  As ext
Declare Function xTanh ( Byval lhs As Double )  As ext
Declare Function xTanh ( Byval lhs As String )  As ext

Declare Function xAsin Overload ( Byval lhs As ext ) As ext
Declare Function xAsin ( Byval lhs As Integer ) As ext
Declare Function xAsin ( Byval lhs As Long ) As ext
Declare Function xAsin ( Byval lhs As LongInt ) As ext
Declare Function xAsin ( Byval lhs As UInteger ) As ext
Declare Function xAsin ( Byval lhs As ULong ) As ext
Declare Function xAsin ( Byval lhs As ULongInt ) As ext
Declare Function xAsin ( Byval lhs As single )  As ext
Declare Function xAsin ( Byval lhs As Double )  As ext
Declare Function xAsin ( Byval lhs As String )  As ext

Declare Function xAcos Overload ( Byval lhs As ext ) As ext
Declare Function xAcos ( Byval lhs As Integer ) As ext
Declare Function xAcos ( Byval lhs As Long ) As ext
Declare Function xAcos ( Byval lhs As LongInt ) As ext
Declare Function xAcos ( Byval lhs As UInteger ) As ext
Declare Function xAcos ( Byval lhs As ULong ) As ext
Declare Function xAcos ( Byval lhs As ULongInt ) As ext
Declare Function xAcos ( Byval lhs As single )  As ext
Declare Function xAcos ( Byval lhs As Double )  As ext
Declare Function xAcos ( Byval lhs As String )  As ext

Declare Function xAtn Overload ( Byval lhs As ext ) As ext
Declare Function xAtn ( Byval lhs As Integer ) As ext
Declare Function xAtn ( Byval lhs As Long ) As ext
Declare Function xAtn ( Byval lhs As LongInt ) As ext
Declare Function xAtn ( Byval lhs As UInteger ) As ext
Declare Function xAtn ( Byval lhs As ULong ) As ext
Declare Function xAtn ( Byval lhs As ULongInt ) As ext
Declare Function xAtn ( Byval lhs As single )  As ext
Declare Function xAtn ( Byval lhs As Double )  As ext
Declare Function xAtn ( Byval lhs As String )  As ext

Declare Function xAsinh Overload ( Byval lhs As ext ) As ext
Declare Function xAsinh ( Byval lhs As Integer ) As ext
Declare Function xAsinh ( Byval lhs As Long ) As ext
Declare Function xAsinh ( Byval lhs As LongInt ) As ext
Declare Function xAsinh ( Byval lhs As UInteger ) As ext
Declare Function xAsinh ( Byval lhs As ULong ) As ext
Declare Function xAsinh ( Byval lhs As ULongInt ) As ext
Declare Function xAsinh ( Byval lhs As single )  As ext
Declare Function xAsinh ( Byval lhs As Double )  As ext
Declare Function xAsinh ( Byval lhs As String )  As ext

Declare Function xAcosh Overload ( Byval lhs As ext ) As ext
Declare Function xAcosh ( Byval lhs As Integer ) As ext
Declare Function xAcosh ( Byval lhs As Long ) As ext
Declare Function xAcosh ( Byval lhs As LongInt ) As ext
Declare Function xAcosh ( Byval lhs As UInteger ) As ext
Declare Function xAcosh ( Byval lhs As ULong ) As ext
Declare Function xAcosh ( Byval lhs As ULongInt ) As ext
Declare Function xAcosh ( Byval lhs As single )  As ext
Declare Function xAcosh ( Byval lhs As Double )  As ext
Declare Function xAcosh ( Byval lhs As String )  As ext

Declare Function xAtnh Overload ( Byval lhs As ext ) As ext
Declare Function xAtnh ( Byval lhs As Integer ) As ext
Declare Function xAtnh ( Byval lhs As Long ) As ext
Declare Function xAtnh ( Byval lhs As LongInt ) As ext
Declare Function xAtnh ( Byval lhs As UInteger ) As ext
Declare Function xAtnh ( Byval lhs As ULong ) As ext
Declare Function xAtnh ( Byval lhs As ULongInt ) As ext
Declare Function xAtnh ( Byval lhs As single )  As ext
Declare Function xAtnh ( Byval lhs As Double )  As ext
Declare Function xAtnh ( Byval lhs As String )  As ext

Declare Function xSqr Overload ( Byval lhs As ext ) As ext
Declare Function xSqr ( Byval lhs As Integer ) As ext
Declare Function xSqr ( Byval lhs As Long ) As ext
Declare Function xSqr ( Byval lhs As LongInt ) As ext
Declare Function xSqr ( Byval lhs As UInteger ) As ext
Declare Function xSqr ( Byval lhs As ULong ) As ext
Declare Function xSqr ( Byval lhs As ULongInt ) As ext
Declare Function xSqr ( Byval lhs As single )  As ext
Declare Function xSqr ( Byval lhs As Double )  As ext
Declare Function xSqr ( Byval lhs As String )  As ext

Declare Function xLog Overload ( Byval lhs As ext ) As ext
Declare Function xLog ( Byval lhs As Integer ) As ext
Declare Function xLog ( Byval lhs As Long ) As ext
Declare Function xLog ( Byval lhs As LongInt ) As ext
Declare Function xLog ( Byval lhs As UInteger ) As ext
Declare Function xLog ( Byval lhs As ULong ) As ext
Declare Function xLog ( Byval lhs As ULongInt ) As ext
Declare Function xLog ( Byval lhs As single )  As ext
Declare Function xLog ( Byval lhs As Double )  As ext
Declare Function xLog ( Byval lhs As String )  As ext

Declare Function xLog10 Overload ( Byval lhs As ext ) As ext
Declare Function xLog10 ( Byval lhs As Integer ) As ext
Declare Function xLog10 ( Byval lhs As Long ) As ext
Declare Function xLog10 ( Byval lhs As LongInt ) As ext
Declare Function xLog10 ( Byval lhs As UInteger ) As ext
Declare Function xLog10 ( Byval lhs As ULong ) As ext
Declare Function xLog10 ( Byval lhs As ULongInt ) As ext
Declare Function xLog10 ( Byval lhs As single )  As ext
Declare Function xLog10 ( Byval lhs As Double )  As ext
Declare Function xLog10 ( Byval lhs As String )  As ext

Declare Function xExp Overload ( Byval lhs As ext ) As ext
Declare Function xExp ( Byval lhs As Integer ) As ext
Declare Function xExp ( Byval lhs As Long ) As ext
Declare Function xExp ( Byval lhs As LongInt ) As ext
Declare Function xExp ( Byval lhs As UInteger ) As ext
Declare Function xExp ( Byval lhs As ULong ) As ext
Declare Function xExp ( Byval lhs As ULongInt ) As ext
Declare Function xExp ( Byval lhs As single )  As ext
Declare Function xExp ( Byval lhs As Double )  As ext
Declare Function xExp ( Byval lhs As String )  As ext

Declare Function xExp10 Overload ( Byval lhs As ext ) As ext
Declare Function xExp10 ( Byval lhs As Integer ) As ext
Declare Function xExp10 ( Byval lhs As Long ) As ext
Declare Function xExp10 ( Byval lhs As LongInt ) As ext
Declare Function xExp10 ( Byval lhs As UInteger ) As ext
Declare Function xExp10 ( Byval lhs As ULong ) As ext
Declare Function xExp10 ( Byval lhs As ULongInt ) As ext
Declare Function xExp10 ( Byval lhs As single )  As ext
Declare Function xExp10 ( Byval lhs As Double )  As ext
Declare Function xExp10 ( Byval lhs As String )  As ext

Declare Operator + ( Byval lhs As ext, Byval rhs As ext ) As ext
Declare Operator + ( Byval lhs As ext, Byval rhs As Integer ) As ext
Declare Operator + ( Byval lhs As Integer, Byval rhs As ext ) As ext
Declare Operator + ( Byval lhs As ext, Byval rhs As Long ) As ext
Declare Operator + ( Byval lhs As Long, Byval rhs As ext ) As ext
Declare Operator + ( Byval lhs As ext, Byval rhs As LongInt ) As ext
Declare Operator + ( Byval lhs As LongInt, Byval rhs As ext ) As ext
Declare Operator + ( Byval lhs As ext, Byval rhs As UInteger ) As ext
Declare Operator + ( Byval lhs As UInteger, Byval rhs As ext ) As ext
Declare Operator + ( Byval lhs As ext, Byval rhs As ULong ) As ext
Declare Operator + ( Byval lhs As ULong, Byval rhs As ext ) As ext
Declare Operator + ( Byval lhs As ext, Byval rhs As ULongInt ) As ext
Declare Operator + ( Byval lhs As ULongInt, Byval rhs As ext ) As ext
Declare Operator + ( Byval lhs As ext, Byval rhs As Single ) As ext
Declare Operator + ( Byval lhs As Single, Byval rhs As ext ) As ext
Declare Operator + ( Byval lhs As ext, Byval rhs As Double ) As ext
Declare Operator + ( Byval lhs As Double, Byval rhs As ext ) As ext

Declare Operator - ( Byval lhs As ext, Byval rhs As ext ) As ext
Declare Operator - ( Byval lhs As ext, Byval rhs As Integer ) As ext
Declare Operator - ( Byval lhs As Integer, Byval rhs As ext ) As ext
Declare Operator - ( Byval lhs As ext, Byval rhs As Long ) As ext
Declare Operator - ( Byval lhs As Long, Byval rhs As ext ) As ext
Declare Operator - ( Byval lhs As ext, Byval rhs As LongInt ) As ext
Declare Operator - ( Byval lhs As LongInt, Byval rhs As ext ) As ext
Declare Operator - ( Byval lhs As ext, Byval rhs As UInteger ) As ext
Declare Operator - ( Byval lhs As UInteger, Byval rhs As ext ) As ext
Declare Operator - ( Byval lhs As ext, Byval rhs As ULong ) As ext
Declare Operator - ( Byval lhs As ULong, Byval rhs As ext ) As ext
Declare Operator - ( Byval lhs As ext, Byval rhs As ULongInt ) As ext
Declare Operator - ( Byval lhs As ULongInt, Byval rhs As ext ) As ext
Declare Operator - ( Byval lhs As ext, Byval rhs As Single ) As ext
Declare Operator - ( Byval lhs As Single, Byval rhs As ext ) As ext
Declare Operator - ( Byval lhs As ext, Byval rhs As Double ) As ext
Declare Operator - ( Byval lhs As Double, Byval rhs As ext ) As ext
Declare Operator - ( Byval lhs As ext ) As ext

Declare Operator * ( Byval lhs As ext, Byval rhs As ext ) As ext
Declare Operator * ( Byval lhs As ext, Byval rhs As Integer ) As ext
Declare Operator * ( Byval lhs As Integer, Byval rhs As ext ) As ext
Declare Operator * ( Byval lhs As ext, Byval rhs As Long ) As ext
Declare Operator * ( Byval lhs As Long, Byval rhs As ext ) As ext
Declare Operator * ( Byval lhs As ext, Byval rhs As LongInt ) As ext
Declare Operator * ( Byval lhs As LongInt, Byval rhs As ext ) As ext
Declare Operator * ( Byval lhs As ext, Byval rhs As UInteger ) As ext
Declare Operator * ( Byval lhs As UInteger, Byval rhs As ext ) As ext
Declare Operator * ( Byval lhs As ext, Byval rhs As ULong ) As ext
Declare Operator * ( Byval lhs As ULong, Byval rhs As ext ) As ext
Declare Operator * ( Byval lhs As ext, Byval rhs As ULongInt ) As ext
Declare Operator * ( Byval lhs As ULongInt, Byval rhs As ext ) As ext
Declare Operator * ( Byval lhs As ext, Byval rhs As Single ) As ext
Declare Operator * ( Byval lhs As Single, Byval rhs As ext ) As ext
Declare Operator * ( Byval lhs As ext, Byval rhs As Double ) As ext
Declare Operator * ( Byval lhs As Double, Byval rhs As ext ) As ext

Declare Operator / ( Byval lhs As ext, Byval rhs As ext ) As ext
Declare Operator / ( Byval lhs As ext, Byval rhs As Integer ) As ext
Declare Operator / ( Byval lhs As Integer, Byval rhs As ext ) As ext
Declare Operator / ( Byval lhs As ext, Byval rhs As Long ) As ext
Declare Operator / ( Byval lhs As Long, Byval rhs As ext ) As ext
Declare Operator / ( Byval lhs As ext, Byval rhs As LongInt ) As ext
Declare Operator / ( Byval lhs As LongInt, Byval rhs As ext ) As ext
Declare Operator / ( Byval lhs As ext, Byval rhs As UInteger ) As ext
Declare Operator / ( Byval lhs As UInteger, Byval rhs As ext ) As ext
Declare Operator / ( Byval lhs As ext, Byval rhs As ULong ) As ext
Declare Operator / ( Byval lhs As ULong, Byval rhs As ext ) As ext
Declare Operator / ( Byval lhs As ext, Byval rhs As ULongInt ) As ext
Declare Operator / ( Byval lhs As ULongInt, Byval rhs As ext ) As ext
Declare Operator / ( Byval lhs As ext, Byval rhs As Single ) As ext
Declare Operator / ( Byval lhs As Single, Byval rhs As ext ) As ext
Declare Operator / ( Byval lhs As ext, Byval rhs As Double ) As ext
Declare Operator / ( Byval lhs As Double, Byval rhs As ext ) As ext

Declare Operator ^ ( Byval lhs As ext, Byval rhs As ext ) As ext
Declare Operator ^ ( Byval lhs As ext, Byval rhs As Integer ) As ext
Declare Operator ^ ( Byval lhs As Integer, Byval rhs As ext ) As ext
Declare Operator ^ ( Byval lhs As ext, Byval rhs As Long ) As ext
Declare Operator ^ ( Byval lhs As Long, Byval rhs As ext ) As ext
Declare Operator ^ ( Byval lhs As ext, Byval rhs As LongInt ) As ext
Declare Operator ^ ( Byval lhs As LongInt, Byval rhs As ext ) As ext
Declare Operator ^ ( Byval lhs As ext, Byval rhs As UInteger ) As ext
Declare Operator ^ ( Byval lhs As UInteger, Byval rhs As ext ) As ext
Declare Operator ^ ( Byval lhs As ext, Byval rhs As ULong ) As ext
Declare Operator ^ ( Byval lhs As ULong, Byval rhs As ext ) As ext
Declare Operator ^ ( Byval lhs As ext, Byval rhs As ULongInt ) As ext
Declare Operator ^ ( Byval lhs As ULongInt, Byval rhs As ext ) As ext
Declare Operator ^ ( Byval lhs As ext, Byval rhs As Single ) As ext
Declare Operator ^ ( Byval lhs As Single, Byval rhs As ext ) As ext
Declare Operator ^ ( Byval lhs As ext, Byval rhs As Double ) As ext
Declare Operator ^ ( Byval lhs As Double, Byval rhs As ext ) As ext

'rel ops

Declare Operator <> ( Byval lhs As ext, Byval rhs As ext ) As Integer
Declare Operator <> ( Byval lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator <> ( Byval lhs As Integer, Byval rhs As ext ) As Integer
Declare Operator <> ( Byval lhs As ext, Byval rhs As Long ) As Integer
Declare Operator <> ( Byval lhs As Long, Byval rhs As ext ) As Integer
Declare Operator <> ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
Declare Operator <> ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
Declare Operator <> ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
Declare Operator <> ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
Declare Operator <> ( Byval lhs As ext, Byval rhs As ULong ) As Integer
Declare Operator <> ( Byval lhs As ULong, Byval rhs As ext ) As Integer
Declare Operator <> ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
Declare Operator <> ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
Declare Operator <> ( Byval lhs As ext, Byval rhs As Single ) As Integer
Declare Operator <> ( Byval lhs As Single, Byval rhs As ext ) As Integer
Declare Operator <> ( Byval lhs As ext, Byval rhs As Double ) As Integer
Declare Operator <> ( Byval lhs As Double, Byval rhs As ext ) As Integer

Declare Operator < ( Byval lhs As ext, Byval rhs As ext ) As Integer
Declare Operator < ( Byval lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator < ( Byval lhs As Integer, Byval rhs As ext ) As Integer
Declare Operator < ( Byval lhs As ext, Byval rhs As Long ) As Integer
Declare Operator < ( Byval lhs As Long, Byval rhs As ext ) As Integer
Declare Operator < ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
Declare Operator < ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
Declare Operator < ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
Declare Operator < ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
Declare Operator < ( Byval lhs As ext, Byval rhs As ULong ) As Integer
Declare Operator < ( Byval lhs As ULong, Byval rhs As ext ) As Integer
Declare Operator < ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
Declare Operator < ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
Declare Operator < ( Byval lhs As ext, Byval rhs As Single ) As Integer
Declare Operator < ( Byval lhs As Single, Byval rhs As ext ) As Integer
Declare Operator < ( Byval lhs As ext, Byval rhs As Double ) As Integer
Declare Operator < ( Byval lhs As Double, Byval rhs As ext ) As Integer

Declare Operator <= ( Byval lhs As ext, Byval rhs As ext ) As Integer
Declare Operator <= ( Byval lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator <= ( Byval lhs As Integer, Byval rhs As ext ) As Integer
Declare Operator <= ( Byval lhs As ext, Byval rhs As Long ) As Integer
Declare Operator <= ( Byval lhs As Long, Byval rhs As ext ) As Integer
Declare Operator <= ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
Declare Operator <= ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
Declare Operator <= ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
Declare Operator <= ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
Declare Operator <= ( Byval lhs As ext, Byval rhs As ULong ) As Integer
Declare Operator <= ( Byval lhs As ULong, Byval rhs As ext ) As Integer
Declare Operator <= ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
Declare Operator <= ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
Declare Operator <= ( Byval lhs As ext, Byval rhs As Single ) As Integer
Declare Operator <= ( Byval lhs As Single, Byval rhs As ext ) As Integer
Declare Operator <= ( Byval lhs As ext, Byval rhs As Double ) As Integer
Declare Operator <= ( Byval lhs As Double, Byval rhs As ext ) As Integer

Declare Operator = ( Byval lhs As ext, Byval rhs As ext ) As Integer
Declare Operator = ( Byval lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator = ( Byval lhs As Integer, Byval rhs As ext ) As Integer
Declare Operator = ( Byval lhs As ext, Byval rhs As Long ) As Integer
Declare Operator = ( Byval lhs As Long, Byval rhs As ext ) As Integer
Declare Operator = ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
Declare Operator = ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
Declare Operator = ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
Declare Operator = ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
Declare Operator = ( Byval lhs As ext, Byval rhs As ULong ) As Integer
Declare Operator = ( Byval lhs As ULong, Byval rhs As ext ) As Integer
Declare Operator = ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
Declare Operator = ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
Declare Operator = ( Byval lhs As ext, Byval rhs As Single ) As Integer
Declare Operator = ( Byval lhs As Single, Byval rhs As ext ) As Integer
Declare Operator = ( Byval lhs As ext, Byval rhs As Double ) As Integer
Declare Operator = ( Byval lhs As Double, Byval rhs As ext ) As Integer

Declare Operator >= ( Byval lhs As ext, Byval rhs As ext ) As Integer
Declare Operator >= ( Byval lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator >= ( Byval lhs As Integer, Byval rhs As ext ) As Integer
Declare Operator >= ( Byval lhs As ext, Byval rhs As Long ) As Integer
Declare Operator >= ( Byval lhs As Long, Byval rhs As ext ) As Integer
Declare Operator >= ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
Declare Operator >= ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
Declare Operator >= ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
Declare Operator >= ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
Declare Operator >= ( Byval lhs As ext, Byval rhs As ULong ) As Integer
Declare Operator >= ( Byval lhs As ULong, Byval rhs As ext ) As Integer
Declare Operator >= ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
Declare Operator >= ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
Declare Operator >= ( Byval lhs As ext, Byval rhs As Single ) As Integer
Declare Operator >= ( Byval lhs As Single, Byval rhs As ext ) As Integer
Declare Operator >= ( Byval lhs As ext, Byval rhs As Double ) As Integer
Declare Operator >= ( Byval lhs As Double, Byval rhs As ext ) As Integer

Declare Operator > ( Byval lhs As ext, Byval rhs As ext ) As Integer
Declare Operator > ( Byval lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator > ( Byval lhs As Integer, Byval rhs As ext ) As Integer
Declare Operator > ( Byval lhs As ext, Byval rhs As Long ) As Integer
Declare Operator > ( Byval lhs As Long, Byval rhs As ext ) As Integer
Declare Operator > ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
Declare Operator > ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
Declare Operator > ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
Declare Operator > ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
Declare Operator > ( Byval lhs As ext, Byval rhs As ULong ) As Integer
Declare Operator > ( Byval lhs As ULong, Byval rhs As ext ) As Integer
Declare Operator > ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
Declare Operator > ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
Declare Operator > ( Byval lhs As ext, Byval rhs As Single ) As Integer
Declare Operator > ( Byval lhs As Single, Byval rhs As ext ) As Integer
Declare Operator > ( Byval lhs As ext, Byval rhs As Double ) As Integer
Declare Operator > ( Byval lhs As Double, Byval rhs As ext ) As Integer
