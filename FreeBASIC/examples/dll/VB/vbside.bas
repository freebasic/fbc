Attribute VB_Name = "Module1"
Option Explicit

'' notes: 
'' 1) the alias must be given and it must be mangled following the 
''    standard-call convention (ie, include and @ character and the 
''    number of bytes pushed to stack
'' 2) the argument must be passed by value (ByVal), VB6 seems to not
''	  pass the BSTR correctly by reference without a COM type-library

Declare Function dupme Lib "fbside.dll" Alias "dupme@4" (ByVal arg As String) As String
        
        
Sub main()
    Dim res As String
        
    res = "Hello! "
        
    MsgBox dupme(res)
        
End Sub
