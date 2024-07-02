#cmdline "-strip -R"

#Include "inc\EXCEL.bi"
using Excel
dim shared as ILine ptr pILine
dim shared as Application Ptr RHS

if pILine then
	pILine->Get_Application(@RHS)
end if