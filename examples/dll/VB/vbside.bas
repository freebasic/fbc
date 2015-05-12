Attribute VB_Name = "Module1"


'' note: the argument must be passed by value (ByVal), VB6 seems to not
''	  	 pass the BSTR correctly by reference without a COM type-library

Declare Function dupme Lib "fbside.dll" Alias "dupme" (ByVal arg As String) As String
        
        
Sub main()
    Dim res As String
        
    res = "Hello! "
        
    MsgBox dupme(res)
        
End Sub
