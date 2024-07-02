#cmdline "-strip -R -z optabstract"

#Include "inc\EXCEL.bi"
using Excel
dim shared as ILine ptr pILine
dim shared as Application Ptr RHS

if pILine then
	pILine->Get_Application(@RHS)
end if