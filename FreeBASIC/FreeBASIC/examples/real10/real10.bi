'some real10 routines by srvaldez (jbklassen[=at=]warpdriveonline.com)

#inclib "real10"

Union ext
    As Integer fl(0 to 4-1)
    As Ushort fw(0 to 8-1)
    As Ubyte tb(0 to 16-1)
    
	Declare constructor ( Byref rhs As ext )
	Declare constructor ( Byval rhs As Integer = 0 )
	Declare constructor ( Byval rhs As Single )
	Declare constructor ( Byval rhs As Double )
	Declare constructor ( Byref rhs As String )
    
    Declare operator let( byref rhs As ext )
    Declare operator let( byval rhs As Integer )
    Declare operator let( byval rhs As Single )
    Declare operator let( byval rhs As Double )
    Declare operator let( byref rhs As String )  

    Declare operator cast( ) As Integer
    Declare operator cast( ) As Single
    Declare operator cast( ) As Double
    Declare operator cast( ) As String    
End Union

Declare Operator + ( Byref lhs As ext, Byref rhs As ext ) As ext
Declare Operator + ( Byref lhs As ext, Byval rhs As Integer ) As ext
Declare Operator + ( Byval lhs As Integer, Byref rhs As ext ) As ext
Declare Operator + ( Byref lhs As ext, Byval rhs As Single ) As ext
Declare Operator + ( Byval lhs As Single, Byref rhs As ext ) As ext
Declare Operator + ( Byref lhs As ext, Byval rhs As Double ) As ext
Declare Operator + ( Byval lhs As Double, Byref rhs As ext ) As ext
Declare Operator - ( Byref lhs As ext, Byref rhs As ext ) As ext
Declare Operator - ( Byref lhs As ext, Byval rhs As Integer ) As ext
Declare Operator - ( Byval lhs As Integer, Byref rhs As ext ) As ext
Declare Operator - ( Byref lhs As ext, Byval rhs As Single ) As ext
Declare Operator - ( Byval lhs As Single, Byref rhs As ext ) As ext
Declare Operator - ( Byref lhs As ext, Byval rhs As Double ) As ext
Declare Operator - ( Byval lhs As Double, Byref rhs As ext ) As ext
Declare Operator - ( Byref lhs As ext ) As ext
Declare Operator * ( Byref lhs As ext, Byref rhs As ext ) As ext
Declare Operator * ( Byref lhs As ext, Byval rhs As Integer ) As ext
Declare Operator * ( Byval lhs As Integer, Byref rhs As ext ) As ext
Declare Operator * ( Byref lhs As ext, Byval rhs As Single ) As ext
Declare Operator * ( Byval lhs As Single, Byref rhs As ext ) As ext
Declare Operator * ( Byref lhs As ext, Byval rhs As Double ) As ext
Declare Operator * ( Byval lhs As Double, Byref rhs As ext ) As ext
Declare Operator / ( Byref lhs As ext, Byref rhs As ext ) As ext
Declare Operator / ( Byref lhs As ext, Byval rhs As Integer ) As ext
Declare Operator / ( Byval lhs As Integer, Byref rhs As ext ) As ext
Declare Operator / ( Byref lhs As ext, Byval rhs As Single ) As ext
Declare Operator / ( Byval lhs As Single, Byref rhs As ext ) As ext
Declare Operator / ( Byref lhs As ext, Byval rhs As Double ) As ext
Declare Operator / ( Byval lhs As Double, Byref rhs As ext ) As ext
Declare Operator ^ ( Byref lhs As ext, Byref rhs As ext ) As ext
Declare Operator ^ ( Byref lhs As ext, Byval rhs As Integer ) As ext
Declare Operator ^ ( Byval lhs As Integer, Byref rhs As ext ) As ext
Declare Operator ^ ( Byref lhs As ext, Byval rhs As Single ) As ext
Declare Operator ^ ( Byval lhs As Single, Byref rhs As ext ) As ext
Declare Operator ^ ( Byref lhs As ext, Byval rhs As Double ) As ext
Declare Operator ^ ( Byval lhs As Double, Byref rhs As ext ) As ext

'rel ops
Declare Operator <> ( Byref lhs As ext, Byref rhs As ext ) As Integer
Declare Operator <> ( Byref lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator <> ( Byval lhs As Integer, Byref rhs As ext ) As Integer
Declare Operator <> ( Byref lhs As ext, Byval rhs As Single ) As Integer
Declare Operator <> ( Byval lhs As Single, Byref rhs As ext ) As Integer
Declare Operator <> ( Byref lhs As ext, Byval rhs As Double ) As Integer
Declare Operator <> ( Byval lhs As Double, Byref rhs As ext ) As Integer
Declare Operator < ( Byref lhs As ext, Byref rhs As ext ) As Integer
Declare Operator < ( Byref lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator < ( Byval lhs As Integer, Byref rhs As ext ) As Integer
Declare Operator < ( Byref lhs As ext, Byval rhs As Single ) As Integer
Declare Operator < ( Byval lhs As Single, Byref rhs As ext ) As Integer
Declare Operator < ( Byref lhs As ext, Byval rhs As Double ) As Integer
Declare Operator < ( Byval lhs As Double, Byref rhs As ext ) As Integer
Declare Operator <= ( Byref lhs As ext, Byref rhs As ext ) As Integer
Declare Operator <= ( Byref lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator <= ( Byval lhs As Integer, Byref rhs As ext ) As Integer
Declare Operator <= ( Byref lhs As ext, Byval rhs As Single ) As Integer
Declare Operator <= ( Byval lhs As Single, Byref rhs As ext ) As Integer
Declare Operator <= ( Byref lhs As ext, Byval rhs As Double ) As Integer
Declare Operator <= ( Byval lhs As Double, Byref rhs As ext ) As Integer
Declare Operator = ( Byref lhs As ext, Byref rhs As ext ) As Integer
Declare Operator = ( Byref lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator = ( Byval lhs As Integer, Byref rhs As ext ) As Integer
Declare Operator = ( Byref lhs As ext, Byval rhs As Single ) As Integer
Declare Operator = ( Byval lhs As Single, Byref rhs As ext ) As Integer
Declare Operator = ( Byref lhs As ext, Byval rhs As Double ) As Integer
Declare Operator = ( Byval lhs As Double, Byref rhs As ext ) As Integer
Declare Operator >= ( Byref lhs As ext, Byref rhs As ext ) As Integer
Declare Operator >= ( Byref lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator >= ( Byval lhs As Integer, Byref rhs As ext ) As Integer
Declare Operator >= ( Byref lhs As ext, Byval rhs As Single ) As Integer
Declare Operator >= ( Byval lhs As Single, Byref rhs As ext ) As Integer
Declare Operator >= ( Byref lhs As ext, Byval rhs As Double ) As Integer
Declare Operator >= ( Byval lhs As Double, Byref rhs As ext ) As Integer
Declare Operator > ( Byref lhs As ext, Byref rhs As ext ) As Integer
Declare Operator > ( Byref lhs As ext, Byval rhs As Integer ) As Integer
Declare Operator > ( Byval lhs As Integer, Byref rhs As ext ) As Integer
Declare Operator > ( Byref lhs As ext, Byval rhs As Single ) As Integer
Declare Operator > ( Byval lhs As Single, Byref rhs As ext ) As Integer
Declare Operator > ( Byref lhs As ext, Byval rhs As Double ) As Integer
Declare Operator > ( Byval lhs As Double, Byref rhs As ext ) As Integer


Declare Function xAcos Overload ( Byref lhs As ext ) As ext
Declare Function xAcos ( Byval lhs As Integer ) As ext
Declare Function xAcos ( Byval lhs As Single )  As ext
Declare Function xAcos ( Byval lhs As Double )  As ext
Declare Function xAcos ( Byval lhs As String )  As ext

Declare Function xAcosh Overload ( Byref lhs As ext ) As ext
Declare Function xAcosh ( Byval lhs As Integer ) As ext
Declare Function xAcosh ( Byval lhs As Single )  As ext
Declare Function xAcosh ( Byval lhs As Double )  As ext
Declare Function xAcosh ( Byval lhs As String )  As ext

Declare Function xAsin Overload ( Byref lhs As ext ) As ext
Declare Function xAsin ( Byval lhs As Integer ) As ext
Declare Function xAsin ( Byval lhs As Single )  As ext
Declare Function xAsin ( Byval lhs As Double )  As ext
Declare Function xAsin ( Byval lhs As String )  As ext

Declare Function xAsinh Overload ( Byref lhs As ext ) As ext
Declare Function xAsinh ( Byval lhs As Integer ) As ext
Declare Function xAsinh ( Byval lhs As Single )  As ext
Declare Function xAsinh ( Byval lhs As Double )  As ext
Declare Function xAsinh ( Byval lhs As String )  As ext

Declare Function xAtn Overload ( Byref lhs As ext ) As ext
Declare Function xAtn ( Byval lhs As Integer ) As ext
Declare Function xAtn ( Byval lhs As Single )  As ext
Declare Function xAtn ( Byval lhs As Double )  As ext
Declare Function xAtn ( Byval lhs As String )  As ext

Declare Function xAtnh Overload ( Byref lhs As ext ) As ext
Declare Function xAtnh ( Byval lhs As Integer ) As ext
Declare Function xAtnh ( Byval lhs As Single )  As ext
Declare Function xAtnh ( Byval lhs As Double )  As ext
Declare Function xAtnh ( Byval lhs As String )  As ext

Declare Function xCos Overload ( Byref lhs As ext ) As ext
Declare Function xCos ( Byval lhs As Integer ) As ext
Declare Function xCos ( Byval lhs As Single )  As ext
Declare Function xCos ( Byval lhs As Double )  As ext
Declare Function xCos ( Byval lhs As String )  As ext

Declare Function xCosh Overload ( Byref lhs As ext ) As ext
Declare Function xCosh ( Byval lhs As Integer ) As ext
Declare Function xCosh ( Byval lhs As Single )  As ext
Declare Function xCosh ( Byval lhs As Double )  As ext
Declare Function xCosh ( Byval lhs As String )  As ext

Declare Function xExp Overload ( Byref lhs As ext ) As ext
Declare Function xExp ( Byval lhs As Integer ) As ext
Declare Function xExp ( Byval lhs As Single )  As ext
Declare Function xExp ( Byval lhs As Double )  As ext
Declare Function xExp ( Byval lhs As String )  As ext

Declare Function xExp10 Overload ( Byref lhs As ext ) As ext
Declare Function xExp10 ( Byval lhs As Integer ) As ext
Declare Function xExp10 ( Byval lhs As Single )  As ext
Declare Function xExp10 ( Byval lhs As Double )  As ext
Declare Function xExp10 ( Byval lhs As String )  As ext

Declare Function xLog Overload ( Byref lhs As ext ) As ext
Declare Function xLog ( Byval lhs As Integer ) As ext
Declare Function xLog ( Byval lhs As Single )  As ext
Declare Function xLog ( Byval lhs As Double )  As ext
Declare Function xLog ( Byval lhs As String )  As ext

Declare Function xLog10 Overload ( Byref lhs As ext ) As ext
Declare Function xLog10 ( Byval lhs As Integer ) As ext
Declare Function xLog10 ( Byval lhs As Single )  As ext
Declare Function xLog10 ( Byval lhs As Double )  As ext
Declare Function xLog10 ( Byval lhs As String )  As ext

Declare Function xSin Overload ( Byref lhs As ext ) As ext
Declare Function xSin ( Byval lhs As Integer ) As ext
Declare Function xSin ( Byval lhs As Single )  As ext
Declare Function xSin ( Byval lhs As Double )  As ext
Declare Function xSin ( Byval lhs As String )  As ext

Declare Function xSinh Overload ( Byref lhs As ext ) As ext
Declare Function xSinh ( Byval lhs As Integer ) As ext
Declare Function xSinh ( Byval lhs As Single )  As ext
Declare Function xSinh ( Byval lhs As Double )  As ext
Declare Function xSinh ( Byval lhs As String )  As ext

Declare Function xSqr Overload ( Byref lhs As ext ) As ext
Declare Function xSqr ( Byval lhs As Integer ) As ext
Declare Function xSqr ( Byval lhs As Single )  As ext
Declare Function xSqr ( Byval lhs As Double )  As ext
Declare Function xSqr ( Byval lhs As String )  As ext

Declare Function xTan Overload ( Byref lhs As ext ) As ext
Declare Function xTan ( Byval lhs As Integer ) As ext
Declare Function xTan ( Byval lhs As Single )  As ext
Declare Function xTan ( Byval lhs As Double )  As ext
Declare Function xTan ( Byval lhs As String )  As ext

Declare Function xTanh Overload ( Byref lhs As ext ) As ext
Declare Function xTanh ( Byval lhs As Integer ) As ext
Declare Function xTanh ( Byval lhs As Single )  As ext
Declare Function xTanh ( Byval lhs As Double )  As ext
Declare Function xTanh ( Byval lhs As String )  As ext
