

function paramtest_1(byref u as USTRING, byref w as wstring) as ustring
'***********************************************************************************************
' parameter test
'***********************************************************************************************


  function = u + w


end function


'***********************************************************************************************


function paramtest_2(byref u as USTRING, byref w as const wstring) as ustring
'***********************************************************************************************
' parameter test
'***********************************************************************************************


  function = u + w


end function


'***********************************************************************************************


function paramtest_3(byval u as USTRING, byref w as wstring) as ustring
'***********************************************************************************************
' parameter test
'***********************************************************************************************


  function = u + w


end function


'***********************************************************************************************


function paramtest_4(byval u as USTRING, byref w as const wstring) as ustring 
'***********************************************************************************************
' parameter test
'***********************************************************************************************


  function = u + w
'  function = u & w


end function


'***********************************************************************************************


function conversiontest_1(byref u as ustring, byref w as wstring) as long
'***********************************************************************************************
' parameter conversion (in)
'***********************************************************************************************


  if u <> w then
    function = 1
  else
    function = 0
  end if


end function


'***********************************************************************************************


function conversiontest_2(byref u as ustring, byref s as const string, byval flag as long = 0) as string
'***********************************************************************************************
' return conversion (out)
'***********************************************************************************************
dim s1 as string

  s1 = s

  if flag then
    function = u & s1
  else
    function = u + s
  end if
  

end function


'***********************************************************************************************


function conversiontest_3(byref u as ustring, byval s as string, byval flag as long = 0) as string
'***********************************************************************************************
' return conversion (out)
'***********************************************************************************************


  if flag then
    function = u & s
  else
    function = u + s
  end if
  

end function


'***********************************************************************************************



function conversiontest_4(byref u as ustring, byref s as string, byval flag as long = 0) as string
'***********************************************************************************************
' return conversion (out)
'***********************************************************************************************


  if flag then
    function = u & s
  else
    function = u + s
  end if


end function


'***********************************************************************************************


function conversiontest_5(byref u as ustring, byref w as wstring, byval flag as long = 0) as wstring ptr
'***********************************************************************************************
' return conversion (out)
'***********************************************************************************************
dim w1 as wstring * 260


  if flag then
    w1 = u & w
    function = @w1
  else
    w1 = u + w
    function = @w1
  end if


end function


'***********************************************************************************************


function conversiontest_6(byref u as ustring, byref s as string, byval flag as long = 0) as Ustring
'***********************************************************************************************
' return conversion (out)
'***********************************************************************************************


  if flag then
    function = u & s
  else
    function = u + s
  end if


end function


'***********************************************************************************************


function conversiontest_7(byref u as ustring, byref w as wstring, byval flag as long = 0) as Ustring
'***********************************************************************************************
' return conversion (out)
'***********************************************************************************************


  if flag then
    function = u & w
  else
    function = u + w
  end if


end function


