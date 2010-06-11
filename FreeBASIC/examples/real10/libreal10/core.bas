#include once "real10.bi"
#include once "intern.bi"

Dim Shared ctrlwrd As Ushort : ctrlwrd = 4927'&B0001001100111111 
'! fldcw [v_ctrlwrd] ' this guarantees extended precision

Function x_Exponent(Byref x As ext) As Integer
    Dim As Integer e
    Asm
        mov ebx,[x]
        lea eax,[e]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fld tbyte Ptr [ebx] 'x
        fxtract
        fstp st(0)
        fistp dword Ptr [eax]
        mov eax,[eax]
    End Asm
  Return e
End Function

Function x_toLong(Byref x As ext) As Integer
    Dim As Integer oldcw, newcw, lng
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word [edx] 
        mov ax,[edx] 
        Or ax,&b110000000000 
        mov [edi],ax
        fldcw word [edi] 
        fld tbyte Ptr [ecx] 
        frndint  
        lea eax,[lng] 
        fistp dword Ptr [eax] 
        fldcw word [edx]
    End Asm
    Return lng
End Function

Function x_toSingle(Byref x As ext) As Single
    Dim As Single sng
    Asm
        mov eax,[x]
        fld tbyte Ptr [eax] 
        lea eax,[sng] 
        fstp dword Ptr [eax] 
    End Asm
    Return sng
End Function

Function x_toDouble(Byref x As ext) As Double
    Dim As Double dbl
    Asm
        mov eax,[x]
        fld tbyte Ptr [eax] 
        lea eax,[dbl] 
        fstp qword Ptr [eax] 
    End Asm
    Return dbl
End Function

Function nInt(Byref x As ext) As Integer
    Dim As Integer oldcw, newcw, lng
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word [edx] 
        mov ax,[edx] 
        Or ax,&b000000000000
        mov [edi],ax
        fldcw word [edi] 
        fld tbyte Ptr [ecx] 
        frndint  
        lea eax,[lng] 
        fistp dword Ptr [eax] 
        fldcw word [edx]
    End Asm
  Return lng
End Function

Sub x_Frac(Byref y As ext, Byref x As ext) 'y=frac(x)
    Dim As Integer oldcw, newcw
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word [edx] 
        mov ax,[edx] 
        Or ax,&b110000000000 
        mov [edi],ax
        fldcw word [edi] 
        fld tbyte Ptr [ecx] 
        fld st(0)
        frndint  
        fsubp st(1),st(0)
        mov eax,[y] 
        fstp tbyte Ptr [eax] 
        fldcw word [edx]
    End Asm
End Sub

Sub iReal10(Byref x As ext,Byval i As Integer)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fild dword Ptr [i]
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub sReal10(Byref x As ext,Byval i As Single)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fld dword Ptr [i]
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub dReal10(Byref x As ext,Byval i As Double)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fld qword Ptr [i]
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_iPower(Byref y As ext, Byref x As ext, Byval e As Integer)
    Asm
        mov eax,[e]
        mov ebx,eax
        rxpower_abseax:
        neg eax
        js  rxpower_abseax
        fld1          '  z=1.0
        fld1
        mov edx,[x]
        fld tbyte Ptr [edx] 'load st0 with x
        cmp eax,0     'while e>0
        rxpower_while1:
        jle rxpower_wend1
        rxpower_while2:
        bt eax,0      'test for odd/even
        jc rxpower_wend2      'jump if odd
  '                while y is even
        sar eax,1     'eax=eax/2
        fmul st(0),st(0)  'x=x*x
        jmp rxpower_while2
        rxpower_wend2:
        Sub eax,1
        fmul st(1),st(0)  'z=z*x 'st1=st1*st0
        jmp rxpower_while1 
        rxpower_wend1:
        fstp st(0)      'cleanup fpu stack
        fstp st(1)      '"       "   "
        cmp ebx,0     'test to see if y<0
        jge rxpower_noinv     'skip reciprocal if not less than 0
  '                if y<0 take reciprocal
        fld1
        fdivrp st(1),st(0)
        rxpower_noinv:
        mov eax,[y]
        fstp tbyte Ptr [eax] 'store z (st0)
        fstp st(0) 'clear fpu stack
        fstp st(0) 'clear fpu stack
    End Asm
End Sub

Sub x_Trunc(Byref y As ext, Byref x As ext) 'y=trunc(x)
    Dim As Integer oldcw, newcw
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word [edx] 
        mov ax,[edx] 
        Or ax,&b110000000000
        mov [edi],ax
        fldcw word [edi] 
        fld tbyte Ptr [ecx] 
        frndint  
        mov eax,[y] 
        fstp tbyte Ptr [eax] 
        fldcw word [edx]
    End Asm
End Sub

Sub x_iMul(Byref y As ext, Byref x As ext, Byval z As Integer) 'y=x*z 
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ebx,[x]
        lea ecx,[z]
        mov eax,[y]
        fld tbyte Ptr [ebx] 'x
        fild dword Ptr [ecx]'z
        fmulp st(1),st(0)
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Sub(Byref z As ext, Byref x As ext, Byref y As ext) 'z=x-y
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov edx,[x]
        mov ebx,[y]
        mov eax,[z]
        fld tbyte Ptr [edx]'x
        fld tbyte Ptr [ebx]'y
        fsubp st(1),st(0)  'x-y
        fstp tbyte Ptr [eax]'z 
    End Asm
End Sub

Function x_Sign(Byref x As ext) As Integer   'returns -1 if x<0,  0 if x=0,  1 if x>0 
    'by paul dixon 
    Dim As Integer sign
    Asm
        mov edx,[x] 
        fld tbyte Ptr [edx] 
        ftst 
        fstsw ax 
        mov al,ah 
        Shr al,6      
        Xor ah,1  
        Xor ah,al 
        Shl ah,1 
        Or al,ah 
        And eax,3 
        dec eax 
        mov [sign],eax
    End Asm
    Return sign
End Function 

Function x_FtoA(Byref x As ext) As String
    Dim As ext temp, y, z, w
    Dim As Integer ex, t, v, s, zz, i
    Dim As Ushort c, hi, lo
    Dim As String f, vl, hb, lb
    s=x_Sign(x)
    ex=10
    v=x.fw(4) And &hFFFF
    zz=x.fw(3) And &hFFFF
    s=x.fw(4) Shr 15
    If ((v=0) Or (v=32768)) And (zz=0) Then
        vl=" 0.000000000000000000e+0000"
        If s=1 Then
            vl="-0.000000000000000000e+0000"
        End If
    Goto ftoa_end
    End If
    If (((v=65535) Or (v=32767)) And (zz=49152)) Then
        vl=" NaN"
        Goto ftoa_end
    Endif
    If ((v=32767) And (zz=32768)) Then
        vl=" Inf"
        Goto ftoa_end
    Endif
    If ((v=65535) And (zz=32768)) Then
        vl="-Inf"
        Goto ftoa_end
    Endif
    Asm
        mov ebx,[x]
        lea ecx,[temp]
        lea edi,[y]
        lea edx,[ex]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fld tbyte Ptr [ebx]  'x
        fabs             'abs(x)
        lea esi,[z]
        fstp tbyte Ptr [esi] 'z=abs(x)
        fild dword Ptr [edx] 'load value 10 from ex
        fld st(0)          'dup
        lea edx,[w]
        fstp tbyte Ptr [edx] 'w=10
        fstp tbyte Ptr [ecx] 'temp=ex, = 10
        fldlg2           'load log10(2) 
        fld tbyte Ptr [esi]
        fyl2x            ' st1*log2(x) 
        fstp tbyte Ptr [edi] 'y=log10(x)
    End Asm
    ex=nInt(y)
    x_iPower(temp,temp,17-ex)
    Asm
        lea ebx,[z]
        lea ecx,[temp]
        fld tbyte Ptr [ecx]  'temp
        fld tbyte Ptr [ebx]  'z
        fmulp st(1),st(0)
        fstp tbyte Ptr [ecx] 'temp
    End Asm
    x_Trunc(w,temp)
    Asm
        lea edi,[y]
        lea edx,[w]
        fld tbyte Ptr [edx]  'w
        fbstp tbyte [edi]'y
    End Asm
    c=y.tb(8) And &hFF
    hi=c Shr 4
    lo=c-hi Shl 4
    If hi=0 Then
        x_iMul(temp,temp,10)
        ex=ex-1
    End If
    x_Trunc(y,temp)
    x_Sub(temp,temp,y)
    x_iMul(temp,temp,10)
    Asm
        lea ecx,[temp]
        lea edi,[y]
        lea edx,[w]
        fld tbyte Ptr [edi]  'y
        fbstp tbyte [edi]'y
        fld tbyte Ptr [ecx]  'temp
        fbstp tbyte [edx]'w
    End Asm
    c=y.tb(8) And &hFF
    hi=c Shr 4
    lo=c-hi Shl 4
    hb=Chr(hi+48)
    lb=Chr(lo+48)
    vl=hb+"."+lb
    i=7
    While i>=0
        c=y.tb(i) And &hFF
        hi=c Shr 4
        lo=c-hi Shl 4
        hb=Chr(hi+48)
        lb=Chr(lo+48)
        vl=vl+hb+lb
        i=i-1
    Wend
    c=w.tb(0) And &hFF
    hi=c Shr 4
    lo=c-hi Shl 4
    lb=Chr(lo+48)
    vl=vl+lb
    If s=1 Then
        vl="-"+vl
    Else
        vl=" "+vl
    End If
    f=Str(Abs(ex))
    f=String(4-Len(f),"0")+f
    If ex<0 Then
        f="e-"+f
    Else
        f="e+"+f
    End If
    vl=vl+f
  
    ftoa_end:
    Return vl
End Function


Sub x_AtoF(Byref x As ext, Byval value As String)
    Dim As ext y, pw
    Dim As Integer t, j, s, d, e, ep, ex, es, i, f, fp, fln
    Dim As String f1, f2, f3, c
    Dim As Ushort cw
    
    t=10 :j=1 :s=1 :d=0 :e=0 :ep=0 :ex=0 :es=1 :i=0 :f=0 :fp=0
    value=Ucase(value)
    fln=Len(value)
    f=Instr(value,"NAN")
    If f>0 Then
        x.fw(4)=&hFFFF
        x.fw(3)=&hC000
        x.fw(2)=0
        x.fw(1)=0
        x.fw(0)=0
        Goto atof_end
    Endif
    f=Instr(value,"INF")
    If f>0 Then
        x.fw(4)=&h7FFF
        x.fw(3)=&h8000
        x.fw(2)=0
        x.fw(1)=0
        x.fw(0)=0
        Goto atof_end
    Endif
    f=Instr(value,"-INF")
    If f>0 Then
        x.fw(4)=&hFFFF
        x.fw(3)=&h8000
        x.fw(2)=0
        x.fw(1)=0
        x.fw(0)=0
        Goto atof_end
    Endif
  
    f1=""
    f2=""
    f3=""
    Asm
        lea ebx,[pw]
        lea edx,[t]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fild dword Ptr [edx]
        fstp tbyte Ptr [ebx]
    End Asm
    While j<=fln
        c=Mid(value,j,1)
        If ep=1 Then
            If c=" " Then
                Goto atof1nxtch
            Endif
            If c="-" Then
                es=-es
                c=""
            Endif
            If c="+" Then
                Goto atof1nxtch
            Endif
            If (c="0") And (f3="") Then
                Goto atof1nxtch
            Endif
            If (c>"/") And (c<":") Then 'c is digit between 0 and 9
                f3=f3+c
                ex=10*ex+(Asc(c)-48)
                Goto atof1nxtch
            Endif
        Endif

        If c=" " Then
            Goto atof1nxtch
        Endif
        If c="-" Then
            s=-s
            Goto atof1nxtch
        Endif
        If c="+" Then
            Goto atof1nxtch
        Endif
        If c="." Then
            If d=1 Then
                Goto atof1nxtch
            Endif
            d=1
        Endif
        If (c>"/") And (c<":") Then 'c is digit between 0 and 9
            If ((c="0") And (i=0)) Then
                If d=0 Then
                    Goto atof1nxtch
                Endif
                If (d=1) And (f=0) Then
                    e=e-1
                    Goto atof1nxtch
                Endif
            Endif
            If d=0 Then
                f1=f1+c
                i=i+1
            Else
                If (c>"0") Then
                    fp=1
                Endif
                f2=f2+c
                f=f+1
            Endif
        Endif
        If c="E" Then
            ep=1
        Endif
atof1nxtch:
        j=j+1
    Wend
    If fp=0 Then
        f=0
        f2=""
    Endif

    ex=es*ex-18+i+e '(es*ex)-(18-i)+e
    f1=f1+f2
    fln=Len(f1)
    If Len(f1)>20 Then
        f1=Mid(f1,1,20)
    Endif
    While Len(f1)<20
        f1=f1+"0"
    Wend

    x.tb(9)=0 'alway zero for positive bcd number
    i=1
    j=8
    While i<18
        cw=16*(Asc(Mid(f1,i,1))-48)
        i=i+1
        cw=cw+(Asc(Mid(f1,i,1))-48)
        i=i+1
        x.tb(j)=cw
        j=j-1
    Wend

    'put the last two digits into y
    For i=1 To 9
        y.tb(i)=0
    Next
    cw=16*(Asc(Mid(f1,19,1))-48)
    cw=cw+(Asc(Mid(f1,20,1))-48)
    y.tb(0)=cw
    t=100
    Asm
        lea edx,[t]
        lea ebx,[y]
        fbld tbyte [ebx]
        fild dword Ptr [edx]
        fdivp st(1),st(0)   'y/100
        mov eax,[x]
        fbld tbyte [eax]
        faddp st(1),st(0)   'x+y/100
        fstp tbyte Ptr [eax]
    End Asm
    x_iPower(pw,pw,ex)'10^(ex+2)
    Asm
        lea ebx,[pw]
        mov eax,[x]
        fld tbyte Ptr [ebx]
        fld tbyte Ptr [eax]
        fmulp st(1),st(0)   'x=x*pw
    End Asm
    If s<0 Then
        Asm fchs
    Endif
    Asm
        mov eax,[x]
        fstp tbyte Ptr[eax]
    End Asm
atof_end:
End Sub

Function x_Fcom(Byref x As ext, Byref y As ext) As Integer
    Dim As Integer flag
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision 
        mov eax,[x]
        mov ebx,[y]
        fld tbyte Ptr [eax]
        fld tbyte Ptr [ebx]
        fsubp st(1),st(0)
        ftst 
        fstsw ax 
        mov al,ah 
        Shr al,6      
        Xor ah,1  
        Xor ah,al 
        Shl ah,1 
        Or al,ah 
        And eax,3 
        dec eax 
        mov [flag],eax
    End Asm
    Return flag
End Function 

Sub x_Abs(Byref y As ext,Byref x As ext)'y=abs(x)
    Asm
        mov ebx,[x]
        mov eax,[y]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fld tbyte Ptr [ebx] 'x
        fabs            '|x|
        fstp tbyte Ptr [eax]'y
    End Asm
End Sub 

Sub x_Neg(Byref y As ext,Byref x As ext)'y=-x
    Asm
        mov ebx,[x]
        mov eax,[y]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fld tbyte Ptr [ebx] 'x
        fchs            '-x
        fstp tbyte Ptr [eax]'y
    End Asm
End Sub 

Sub x_Add(Byref z As ext,Byref x As ext,Byref y As ext)'z=x+y
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov edx,[x]
        mov ebx,[y]
        mov eax,[z]
        fld tbyte Ptr [edx]'x
        fld tbyte Ptr [ebx]'y
        faddp st(1),st(0)  'x-y
        fstp tbyte Ptr [eax]'z 
    End Asm
End Sub 

Sub x_Mul(Byref z As ext,Byref x As ext,Byref y As ext)'z=x*y
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov eax,[z]
        mov ebx,[y]
        mov ecx,[x]
        fld tbyte Ptr [ecx] 'x
        fld tbyte Ptr [ebx] 'y
        fmulp st(1),st(0)
        fstp tbyte Ptr [eax]'z 
    End Asm
End Sub 

Sub x_Div(Byref z As ext,Byref x As ext,Byref y As ext)'z=x/y
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov eax,[z]
        mov ebx,[y]
        mov ecx,[x]
        fld tbyte Ptr [ecx] 'x
        fld tbyte Ptr [ebx] 'y
        fdivp st(1),st(0)
        fstp tbyte Ptr [eax]'z 
    End Asm
End Sub 

Sub x_iDiv(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x/z 
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ebx,[x]
        lea ecx,[z]
        mov eax,[y]
        fld tbyte Ptr [ebx] 'x
        fild dword Ptr [ecx]'z 
        fdivp st(1),st(0)
        fstp tbyte Ptr [eax]'y 
    End Asm
End Sub

Sub x_iAdd(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x+z 
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov edx,[x]
        lea ecx,[z]
        mov eax,[y]
        fld tbyte Ptr [edx] 'x
        fild dword Ptr [ecx]'z
        faddp st(1),st(0)
        fstp tbyte Ptr [eax]
    End Asm
End Sub 

Sub x_iSub(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x-z 
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ebx,[x]
        lea ecx,[z]
        mov eax,[y]
        fld tbyte Ptr [ebx] 'x
        fild dword Ptr [ecx]'z
        fsubp st(1),st(0)
        fstp tbyte Ptr [eax] 'y
    End Asm
End Sub 

Sub xInc(Byref x As ext)'x=x+1
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fld tbyte Ptr [eax]'x
        fld1
        faddp st(1),st(0)
        fstp tbyte Ptr [eax]'x
    End Asm
End Sub 

Sub xDec(Byref x As ext)'x=x-1
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fld tbyte Ptr [eax]'x
        fld1
        fsubp st(1),st(0)
        fstp tbyte Ptr [eax]'x
    End Asm
End Sub 

Sub x_Scale(Byref y As ext,Byref x As ext,Byval j As Integer)'y=x*2^j
    Asm
        mov eax,[y]
        mov ebx,[x]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fild dword Ptr [j]
        fld tbyte Ptr [ebx]   'x
        fscale
        fstp tbyte Ptr [eax]  'y
        fstp st(0) 'clean fpu stack
    End Asm
End Sub

Function x_Factorial(Byref y As ext,Byref x As ext) As Integer'y=x!
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ebx,[x]
        fld tbyte Ptr [ebx] 'x
        fldz
        fcompp
        fnstsw ax
        sahf
        jne xFactorial0
        fld1
        jmp xFactorial7
        xFactorial0:
        fld tbyte Ptr [ebx]
        fld st(0)
        fld st(0)
        frndint
        fcompp
        fnstsw ax
        sahf
        je xFactorial1
        jmp xFactorial5
        xFactorial1:
        fldz
        fcompp
        fnstsw ax
        sahf
        jbe xFactorial2
        fld tbyte Ptr [mbig] 
        jmp xFactorial7
        xFactorial2:
        fld tbyte Ptr [ebx]
        fild word Ptr [onethousand]
        fcompp
        fnstsw ax
        sahf
        jb xFactorial5
        fld tbyte Ptr [ebx]
        Sub esp,4
        fist dword Ptr [esp]
        mov ecx,[esp]
        add esp,4
        fld1
        fld1
        fld st(2)
        xFactorial3:
        fmul st(2),st(0)
        fsub st(0),st(1) 
        Sub ecx,1
        jg xFactorial3
        xFactorial4:
        fcompp
        fstp st(1)
        jmp xFactorial7
  
  '***************************************
  
  ' gamma(x + 1) = (x + y + 1/2)^(x + 1/2)*exp(-(x + y + 1/2))
  ' *sqrt(2*pi)*(c0 + c1/(x + 1) + c2/(x + 2) +...+ cn/(x + n))
  ' 
  ' for more information visit http://home.att.net/~numericana/answer/info/godfrey.htm
        xFactorial5:
        fld tbyte Ptr [ebx]         'load x
        fld tbyte Ptr [120+gamma]   ' 9.5 
        faddp st(1),st(0)           'x + 9.5
        fld st(0)                 'make copy
        fld tbyte Ptr [ebx]         'load x again
        fld tbyte Ptr [x_half]     'load .5
        faddp st(1),st(0)           'x + .5
        fxch                    'exchange st(0) and st(1): st(0) = x + 9.5, st(1) = x + .5
        fyl2x                   'st(0) = st(0) ^ st(1)
        fld st(0)                 ' "
        frndint                 ' "
        fsub st(1), st(0)           ' "
        fld1                    ' "
        fscale                  ' "
        fxch                    ' "
        fxch st(2)                ' "
        f2xm1                   ' "
        fld1                    ' "
        faddp st(1), st(0)          ' "
        fmulp st(1), st(0)          ' "
        fstp st(1)                ' clean up fpu stack, result in st(0)
        fxch                    'exchange st(0) and st(1): st(0) = x + 9.5, st(1) = (x + 9.5) ^ (x + .5)
        fchs                    'st(0) = - st(0) = -(x + 9.5)
        fld tbyte Ptr [x_e]        'st(0) = exp(st(0))
        fyl2x                   ' "
        fld st(0)                 ' "
        frndint                 ' "
        fsub st(1), st(0)           ' "
        fld1                    ' "
        fscale                  ' "
        fxch                    ' "
        fxch st(2)                ' "
        f2xm1                   ' "
        fld1                    ' "
        faddp st(1), st(0)          ' "
        fmulp st(1), st(0)          ' "
        fstp st(1)                ' clean up fpu stack, result in st(0)
        fmulp st(1),st(0)           'st(0) = (x + 9.5) ^ (x + .5) * exp(-(x + 9.5))
        fld tbyte Ptr [gamma]       ' 2.50662827463100050  ' sqrt(2*pi)
        fmulp st(1),st(0)           'st(0) = (x + 9.5) ^ (x + .5) * exp(-(x + 9.5)) * sqrt(2*pi)
        fld tbyte Ptr [gamma+10]    '1.00000000000000017
        fld tbyte Ptr [ebx]         'load x again
        fiadd word Ptr [ten]       'st(0) = x + 10
        fld tbyte Ptr [110+gamma]   '-4.02353314126823637e-9 
        fdiv st(0),st(1)            'st(0) = -4.02353314126823637e-9 / (x + 10)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 9
        fld tbyte Ptr [100+gamma]   ' 5.38413643250956406e-8
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 8
        fld tbyte Ptr [90+gamma]    '-7.42345251020141615e-3
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 7
        fld tbyte Ptr [80+gamma]    ' 2.60569650561175583
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 6
        fld tbyte Ptr [70+gamma]    '-108.176705351436963
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 5
        fld tbyte Ptr [60+gamma]    ' 1301.60828605832187
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 4
        fld tbyte Ptr [50+gamma]    '-6348.16021764145881
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 3
        fld tbyte Ptr [40+gamma]    ' 14291.4927765747855
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 2
        fld tbyte Ptr [30+gamma]    '-14815.3042676841391
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 1
        fld tbyte Ptr [20+gamma]    ' 5716.40018827434138
        fdivrp st(1),st(0)
        faddp  st(1),st(0)
        fmulp st(1),st(0)
        fstp st(1)
        xFactorial7:
        mov eax,[y]
        fstp tbyte Ptr [eax]
    End Asm
    Return 0
    Asm
'N=10,Y=9
        gamma:
        .word &h2CB2,&hB138,&h98FF,&hA06C,&h4000    '         2.50662827463100050  ' Sqrt(2*Pi)  '    gamma
        .word &h064A,&h0000,&h0000,&h8000,&h3FFF    '(FC0F)   1.00000000000000017 ______________ ' 10+gamma
        .word &h4FAA,&hE8F4,&h3395,&hB2A3,&h400B    '(735D)   5716.40018827434138 ______________ ' 20+gamma
        .word &h6D9E,&hF2A2,&h3791,&hE77D,&hC00C    '(DF08)  -14815.3042676841391 ______________ ' 30+gamma
        .word &hC153,&h6C23,&hF89A,&hDF4D,&h400C    '(1B7F)   14291.4927765747855 ______________ ' 40+gamma
        .word &h767D,&h2FD2,&h4820,&hC661,&hC00B    '(A17A)  -6348.16021764145881 ______________ ' 50+gamma
        .word &h5DC8,&h52E3,&h7714,&hA2B3,&h4009    '(07DC)   1301.60828605832187 ______________ ' 60+gamma
        .word &h5F26,&hB2E6,&h791F,&hD85A,&hC005    '(D958)  -108.176705351436963 ______________ ' 70+gamma
        .word &hAC57,&hB9DA,&hBB46,&hA6C3,&h4000    '(290D)   2.60569650561175583 ______________ ' 80+gamma
        .word &h5E13,&h9ACD,&h6EE0,&hF340,&hBFF7    '(C05D)  -7.42345251020141615e-3 ___________ ' 90+gamma
        .word &h16EB,&hFC65,&h34C4,&hE73F,&h3FE6    '(F280)   5.38413643250956406e-8 ___________ '100+gamma
        .word &hB1AB,&h8882,&h5F2D,&h8A3F,&hBFE3    '(A364)  -4.02353314126823637e-9 ___________ '110+gamma
        .word &h0000,&h0000,&h0000,&h9800,&h4002    '         9.5 ______________________________ '120+gamma
        mbig: .word &h7F1F,&hD8A2,&h8387,&h9462,&hFF95 '-1.7e4900
        pbig: .word &h7F1F,&hD8A2,&h8387,&h9462,&h7F95 ' 1.7e4900
        x_half: .word &h0000,&h0000,&h0000,&h8000,&h3FFE
        x_e: .word &h4A9B,&hA2BB,&h5458,&hADF8,&h4000
        x_two:  .word &h0000,&h0000,&h0000,&h8000,&h4000
        onethousand: .word 1000
        ten: .word 10
    End Asm
End Function 

Sub x_Sqrt(Byref y As ext,Byref x As ext)'y=sqrt(x)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov eax,[y]
        mov ebx,[x]
        fld tbyte Ptr [ebx] 'x
        fsqrt
        fstp tbyte Ptr [eax]'y 
    End Asm
End Sub 

Sub x_Log10(Byref y As ext,Byref x As ext)'y=log10(x)
    Asm
        mov ebx,[x]
        mov eax,[y]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fldlg2 'load log10(2) 
        fld tbyte Ptr [ebx]'x
        fyl2x ' st(1)*log2(x) 
        fstp tbyte Ptr [eax] 'y=log10(x)
    End Asm
End Sub 

Sub x_Log(Byref y As ext,Byref x As ext) 'y=ln(x)
    Asm
        mov ebx,[x] 
        mov eax,[y] 
        fldcw [ctrlwrd] ' this guarantees extended precision
        fldln2 'load loge(2) 
        fld tbyte Ptr [ebx]'x
        fyl2x 'st(1)*log2(x) 
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_ExpTen(Byref y As ext,Byref x As ext) 'y=10^x
    Asm
        mov ebx,[x]
        mov eax,[y]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fld tbyte Ptr [ebx]
        fild word Ptr [ten]
        fyl2x
        fld st(0) 
        frndint 
        fsub st(1), st(0) 
        fld1 
        fscale 
        fxch 
        fxch st(2) 
        f2xm1 
        fld1 
        faddp st(1), st(0) 
        fmulp st(1), st(0)
        fstp st(1) 
        fstp tbyte Ptr [eax]
    End Asm
End Sub 

Sub x_Exp(Byref y As ext,Byref x As ext) 'y=e^x
    Asm
        mov ecx,[x] 
        mov eax,[y]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fld tbyte Ptr [ecx]
        fld tbyte Ptr [x_e]
        fyl2x
        fld st(0) 
        frndint 
        fsub st(1), st(0) 
        fld1 
        fscale 
        fxch 
        fxch st(2) 
        f2xm1 
        fld1 
        faddp st(1), st(0) 
        fmulp st(1), st(0)
        fstp st(1) 
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Sin(Byref y As ext,Byref x As ext) 'y=sin(x)
    Asm
        mov ecx,[x]
        mov eax,[y]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fld tbyte Ptr [ecx]'x
        fsin
        fstp tbyte Ptr [eax]'y=sin(x)
    End Asm
End Sub

Sub x_Cos(Byref y As ext,Byref x As ext) 'y=cos(x)
    Asm
        mov ecx,[x]
        mov eax,[y]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fld tbyte Ptr [ecx]'x
        fcos
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Tan(Byref y As ext,Byref x As ext) 'y=tan(x)
    Asm
        mov ecx,[x]
        mov eax,[y]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fld tbyte Ptr [ecx]'x
        fptan
        fstp st(0)
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Asin(Byref y As ext,Byref x As ext)'y=asin(x)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte Ptr [ecx] 'x
        fld1
        fld st(1)               
        fmul st(0),st(0)          
        fsubp st(1),st(0)        
        fsqrt                 
        fpatan  
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Acos(Byref y As ext,Byref x As ext)'y=acos(x)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte Ptr [ecx] 'x
        fld1
        fld st(1)               
        fmul st(0),st(0)          
        fsubp st(1),st(0)        
        fsqrt
        fxch                 
        fpatan  
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Atan(Byref y As ext,Byref x As ext)'y=atan(x)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte Ptr [ecx] 'x
        fld1
        fpatan 
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Sinh(Byref y As ext,Byref x As ext)'y=sinh(x)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte Ptr [ecx] 'x
        fld tbyte Ptr [x_e]
        fyl2x
        fld st(0) 
        frndint 
        fsub st(1), st(0) 
        fld1 
        fscale 
        fxch 
        fxch st(2) 
        f2xm1 
        fld1 
        faddp st(1), st(0) 
        fmulp st(1), st(0) 
        fstp st(1)
        fld st(0)
        fld1
        fdivrp st(1),st(0)
        fsubp st(1),st(0)
        fld tbyte Ptr [x_half]
        fmulp st(1),st(0)
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Cosh(Byref y As ext,Byref x As ext)'y=cosh(x)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte Ptr [ecx] 'x
        fld tbyte Ptr [x_e]
        fyl2x
        fld st(0) 
        frndint 
        fsub st(1), st(0) 
        fld1 
        fscale 
        fxch 
        fxch st(2)
        f2xm1 
        fld1 
        faddp st(1), st(0) 
        fmulp st(1), st(0) 
        fstp st(1)
        fld st(0)
        fld1
        fdivrp st(1),st(0)
        faddp st(1),st(0)
        fld tbyte Ptr [x_half]
        fmulp st(1),st(0)
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Tanh(Byref y As ext,Byref x As ext)'y=tanh(x)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte Ptr [ecx] 'x
        fld tbyte Ptr [x_e]
        fyl2x
        fld st(0) 
        frndint 
        fsub st(1), st(0) 
        fld1 
        fscale 
        fxch 
        fxch st(2) 
        f2xm1 
        fld1 
        faddp st(1), st(0) 
        fmulp st(1), st(0) 
        fstp st(1)
        fmul  st(0),st(0)
        fld   st(0)
        fld1
        faddp st(1),st(0)
        fxch 
        fld1
        fsubp st(1),st(0)
        fdivrp st(1),st(0)  
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Asinh(Byref y As ext,Byref x As ext)'y=asinh(x)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fldln2 'load loge(2) 
        fld tbyte Ptr [ecx] 'x
        fld st(0)
        fmul st(0),st(0)
        fld1
        faddp st(1),st(0)
        fsqrt
        faddp st(1),st(0)
        fyl2x 'st(1)*log2(x)
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Acosh(Byref y As ext,Byref x As ext)'y=acosh(x)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fldln2 'load loge(2) 
        fld tbyte Ptr [ecx] 'x
        fld st(0)
        fmul st(0),st(0)
        fld1
        fsubp st(1),st(0)
        fsqrt
        faddp st(1),st(0)
        fyl2x 'st(1)*log2(x)
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Atanh(Byref y As ext,Byref x As ext)'y=atanh(x)
    Asm
        fldcw [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte Ptr [ecx] 'x
        fldln2 'load loge(2) 
        fxch
        fld1
        faddp st(1),st(0)  
        fld st(0)
        fld tbyte Ptr [x_two]
        fsubrp st(1),st(0)
        fdivp st(1),st(0)
        fyl2x 'st(1)*log2(x)
        fld tbyte Ptr [x_half]
        fmulp st(1),st(0)
        fstp tbyte Ptr [eax]
    End Asm
End Sub

Sub x_Power(Byref y As ext,Byref x As ext, Byref z As ext) 'y=x^z
    Asm
        mov ebx,[x]
        mov edx,[z]
        mov eax,[y]
        fldcw [ctrlwrd] ' this guarantees extended precision
        fld tbyte Ptr [edx]
        fld tbyte Ptr [ebx]
        fyl2x
        fld st(0) 
        frndint 
        fsub st(1), st(0) 
        fld1 
        fscale 
        fxch 
        fxch st(2) 
        f2xm1 
        fld1 
        faddp st(1), st(0) 
        fmulp st(1), st(0)
        fstp st(1) 
        fstp tbyte Ptr [eax] ' z
    End Asm
End Sub

Function x_Floor(Byref y As ext, Byref x As ext) As Integer'y=Floor(x)
    Dim As Integer oldcw, newcw
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word [edx] 'oldcw
        mov ax,[edx]
        Or ax,&b010000000000
        mov [edi],ax
        fldcw word [edi] 
        fld tbyte Ptr [ecx]
        frndint 
        fistp dword Ptr [edi]
        fild dword Ptr [edi]
        fldcw word [edx]
        mov eax,[y]
        fstp tbyte Ptr [eax]
    End Asm
    Return newcw
End Function
 