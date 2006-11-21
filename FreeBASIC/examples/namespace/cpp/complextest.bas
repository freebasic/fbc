'' complextest.bas
'' compile eith:
''   fbc complextest.bas

#inclib "complexlib"

extern "c++"

  namespace cpp

    type complex
      
      as double re
      as double im

      declare function abs2() as double

    end type

    declare operator + cdecl ( byref as complex, byref as complex) as complex
    declare operator - cdecl ( byref as complex, byref as complex) as complex
    declare operator * cdecl ( byref as complex, byref as complex) as complex
    declare operator / cdecl ( byref as complex, byref as complex) as complex

  end namespace

end extern

using cpp

dim a as complex = (1,2)
dim b as complex = (3,4)

dim c as complex

c = a * b

print "c = " & c.re & " + i" & c.im

print "|c|^2 = "; c.abs2()

