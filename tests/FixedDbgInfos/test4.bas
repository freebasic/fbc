const AST_INITNODES				= 8192
const AST_INITPROCNODES			= 128
#define CL_ERROR   &HFFFFFFFF
#define CL_ADDR1   &H10000000 '操作码中地址大小的位字段(字节)
#define CL_ADDR2   &H20000000 '(单字)
type td
	d as integer
End Type
un:
dim cdd as string

Union ff
Data_b(0 To 7) As Byte  ' 20 21 22 23  24 25 26 27
Data_w(0 To 3) As Short
Data_d(0 To 1) As Long
Data_c(0 To 7) As byte
Data_s(0 To 3) As Short
Data_l(0 To 1) As Long
End Union

enum AST_OPOPT
AST_OPOPT_NONE  		= &h00000000

AST_OPOPT_ALLOCRES		= &h00000001
AST_OPOPT_LPTRARITH		= &h00000002
AST_OPOPT_RPTRARITH		= &h00000004
AST_OPOPT_NOCOERCION	= &h00000008
AST_OPOPT_DONTCHKPTR	= &h00000010
AST_OPOPT_DONTCHKOPOVL	= &h00000020
AST_OPOPT_ISINI			= &h00000040

AST_OPOPT_DOPTRARITH	= AST_OPOPT_LPTRARITH or AST_OPOPT_RPTRARITH

AST_OPOPT_DEFAULT		= AST_OPOPT_ALLOCRES
end enum

Declare function LDEXWY (ByVal StartAddress As Integer) As Integer
