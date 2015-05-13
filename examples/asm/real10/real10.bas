''
'' some real10 routines by srvaldez
'' placed into the public domain, use any way you want
''
'' compile with: fbc real10.bas -lib
''

#include once "real10.bi"

Dim Shared ctrlwrd As Ushort : ctrlwrd = 4927'&B0001001100111111
'! fldcw [v_ctrlwrd] ' this guarantees extended precision

Function x_Exponent(Byref x As ext) As Integer
    Dim As Integer e
    Asm
        mov ebx,[x]
        lea eax,[e]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fld tbyte ptr [ebx] 'x
        fxtract
        fstp st(0)
        fistp dword ptr [eax]
        mov eax,[eax]
    End Asm
  Return e
End Function

Function x_toInt(Byref x As ext) As Integer
    Dim As Integer oldcw, newcw, lng
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word ptr [edx]
        mov ax,[edx]
        or ax,&b110000000000
        mov [edi],ax
        fldcw word ptr [edi]
        fld tbyte ptr [ecx]
        frndint 
        lea eax,[lng]
        fistp dword ptr [eax]
        fldcw word ptr [edx]
    End Asm
    Return lng
End Function

Function x_toLong(Byref x As ext) As Long
    Dim As Integer oldcw, newcw, lng
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word ptr [edx]
        mov ax,[edx]
        or ax,&b110000000000
        mov [edi],ax
        fldcw word ptr [edi]
        fld tbyte ptr [ecx]
        frndint 
        lea eax,[lng]
        fistp dword ptr [eax]
        fldcw word ptr [edx]
    End Asm
    Return lng
End Function

Function x_toLongInt(Byref x As ext) As LongInt
    Dim As Integer oldcw, newcw
    Dim As LongInt lng
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word ptr [edx]
        mov ax,[edx]
        or ax,&b110000000000
        mov [edi],ax
        fldcw word ptr [edi]
        fld tbyte ptr [ecx]
        frndint 
        lea eax,[lng]
        fistp qword ptr [eax]
        fldcw word ptr [edx]
    End Asm
    Return lng
End Function

Function x_toUInt(Byref x As ext) As UInteger
    Dim As Integer oldcw, newcw, lng
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word ptr [edx]
        mov ax,[edx]
        or ax,&b110000000000
        mov [edi],ax
        fldcw word ptr [edi]
        fld tbyte ptr [ecx]
        frndint 
        lea eax,[lng]
        fistp dword ptr [eax]
        fldcw word ptr [edx]
    End Asm
    Return lng
End Function

Function x_toULong(Byref x As ext) As ULong
    Dim As Integer oldcw, newcw, lng
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word ptr [edx]
        mov ax,[edx]
        or ax,&b110000000000
        mov [edi],ax
        fldcw word ptr [edi]
        fld tbyte ptr [ecx]
        frndint 
        lea eax,[lng]
        fistp dword ptr [eax]
        fldcw word ptr [edx]
    End Asm
    Return lng
End Function

Function x_toULongInt(Byref x As ext) As ULongInt
    Dim As Integer oldcw, newcw
    Dim As LongInt lng
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word ptr [edx]
        mov ax,[edx]
        or ax,&b110000000000
        mov [edi],ax
        fldcw word ptr [edi]
        fld tbyte ptr [ecx]
        frndint 
        lea eax,[lng]
        fistp qword ptr [eax]
        fldcw word ptr [edx]
    End Asm
    Return lng
End Function

Function x_toSingle(Byref x As ext) As Single
    Dim As Single sng
    Asm
        mov eax,[x]
        fld tbyte ptr [eax]
        lea eax,[sng]
        fstp dword ptr [eax]
    End Asm
    Return sng
End Function

Function x_toDouble(Byref x As ext) As Double
    Dim As Double dbl
    Asm
        mov eax,[x]
        fld tbyte ptr [eax]
        lea eax,[dbl]
        fstp qword ptr [eax]
    End Asm
    Return dbl
End Function

Function nInt(Byref x As ext) As Integer
    Dim As Integer oldcw, newcw, lng
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word ptr [edx]
        mov ax,[edx]
        or ax,&b000000000000
        mov [edi],ax
        fldcw word ptr [edi]
        fld tbyte ptr [ecx]
        frndint 
        lea eax,[lng]
        fistp dword ptr [eax]
        fldcw word ptr [edx]
    End Asm
  Return lng
End Function

Sub x_Frac(Byref y As ext, Byref x As ext) 'y=frac(x)
    Dim As Integer oldcw, newcw
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word ptr [edx]
        mov ax,[edx]
        or ax,&b110000000000
        mov [edi],ax
        fldcw word ptr [edi]
        fld tbyte ptr [ecx]
        fld st(0)
        frndint 
        fsubp st(1),st(0)
        mov eax,[y]
        fstp tbyte ptr [eax]
        fldcw word ptr [edx]
    End Asm
End Sub

Sub iReal10(Byref x As ext,Byval i As Integer)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fild dword ptr [i]
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub ilReal10(Byref x As ext,Byval i As Long)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fild dword ptr [i]
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub iqReal10(Byref x As ext,Byval i As LongInt)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fild qword ptr [i]
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub uiReal10(Byref x As ext,Byval i As UInteger)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fild dword ptr [i]
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub uilReal10(Byref x As ext,Byval i As ULong)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fild dword ptr [i]
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub uiqReal10(Byref x As ext,Byval i As ULongInt)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fild qword ptr [i]
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub sReal10(Byref x As ext,Byval i As Single)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fld dword ptr [i]
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub dReal10(Byref x As ext,Byval i As Double)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fld qword ptr [i]
        fstp tbyte ptr [eax]
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
        fld tbyte ptr [edx] 'load st0 with x
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
        sub eax,1
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
        fstp tbyte ptr [eax] 'store z (st0)
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
        fstcw word ptr [edx]
        mov ax,[edx]
        or ax,&b110000000000
        mov [edi],ax
        fldcw word ptr [edi]
        fld tbyte ptr [ecx]
        frndint 
        mov eax,[y]
        fstp tbyte ptr [eax]
        fldcw word ptr [edx]
    End Asm
End Sub

Sub x_iMul(Byref y as ext, Byref x As ext, Byval z As Integer) 'y=x*z
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ebx,[x]
        lea ecx,[z]
        mov eax,[y]
        fld tbyte ptr [ebx] 'x
        fild dword ptr [ecx]'z
        fmulp st(1),st(0)
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Sub(Byref z As ext, Byref x As ext, Byref y As ext) 'z=x-y
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov edx,[x]
        mov ebx,[y]
        mov eax,[z]
        fld tbyte ptr [edx]'x
        fld tbyte ptr [ebx]'y
        fsubp st(1),st(0)  'x-y
        fstp tbyte ptr [eax]'z
    End Asm
End Sub

Function x_Sign(Byref x As ext) As Integer   'returns -1 if x<0,  0 if x=0,  1 if x>0
    'by paul dixon
    Dim As Integer sign
    Asm
        mov edx,[x]
        fld tbyte ptr [edx]
        ftst
        fstsw ax
        fstp st(0)
        mov al,ah
        shr al,6     
        Xor ah,1 
        Xor ah,al
        shl ah,1
        Or al,ah
        And eax,3
        dec eax
        mov [sign],eax
    End Asm
    Return sign
End Function


Function x_FtoA(Byref x As ext, byval prec as integer=17) As String
    Dim As ext temp, y, z, w
    Dim As Integer ex, t, v, s, zz, i, oldcw, newcw
    Dim As Ushort c, hi, lo
    Dim As String f, vl, hb, lb
    if prec>17 or prec<0 then
        prec=17
'    elseif prec<2 then
'        prec=2
    end if
    s=x_Sign(x)
    ex=10
    v=x.fw(4) And &hFFFF
    zz=x.fw(3) And &hFFFF
    s=x.fw(4) shr 15
    If ((v=0) Or (v=32768)) And (zz=0) Then
        vl=" 0."+string(prec,"0")+"e+0000"
        If s=1 Then
            vl="-0."+string(prec,"0")+"e+0000"
        End If
    Goto ftoa_end
    End If
    If (((v=65535) Or (v=32767)) And (zz=49152)) Then
        vl=" NaN"
        Goto ftoa_end
    EndIf
    If ((v=32767) And (zz=32768)) Then
        vl=" Inf"
        Goto ftoa_end
    EndIf
    If ((v=65535) And (zz=32768)) Then
        vl="-Inf"
        Goto ftoa_end
    EndIf
    Asm
        mov eax,[x]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fld tbyte ptr [eax]  'x
        fabs             'abs(x)
        fstp tbyte ptr [z] 'z=abs(x)
        fild dword ptr [ex] 'load value 10 from ex
        fld st(0)          'dup
        fstp tbyte ptr [w] 'w=10
        fstp tbyte ptr [temp] 'temp=ex, = 10
        fldlg2           'load log10(2)
        fld tbyte ptr [z]
        fyl2x            ' st1*log2(x)
        fstcw word ptr [oldcw]
        mov ax,[oldcw]
        or ax,&b000000000000
        mov [newcw],ax
        fldcw word ptr [newcw]
        frndint
        fistp dword ptr [ex]
        fldcw word ptr [oldcw]
    End Asm
    x_iPower(temp,temp,17-ex) 'x_iPower(temp,temp,17-ex)
    Asm
        lea ebx,[z]
        lea ecx,[temp]
        fld tbyte ptr [temp]
        fld tbyte ptr [z]
        fmulp st(1),st(0)
        fld st(0)
        fstp tbyte ptr [temp]
        lea ebx,[y]
        fbstp tbyte ptr [y]
    End Asm
    c=y.tb(8)
    hi=c shr 4
    lo=c-hi shl 4
    If hi=0 then
        x_iMul(temp,temp,10)
        ex=ex-1
    End If
    Asm
        lea edi,[y]
        lea edx,[temp]
        fld tbyte ptr [temp]
        fbstp tbyte ptr [y]
    End Asm
    c=y.tb(8)
    hi=c shr 4
    lo=c-hi shl 4
    hb=Chr(hi+48)
    lb=Chr(lo+48)
    vl=hb+"."+lb
    i=7
    While i>=0
        c=y.tb(i)
        hi=c shr 4
        lo=c-hi shl 4
        hb=Chr(hi+48)
        lb=Chr(lo+48)
        vl=vl+hb+lb
        i=i-1
    Wend
    If s=1 Then
        vl="-"+vl
    Else
        vl=" "+vl
    End If
    f=Str(Abs(ex))
    f=string(4-len(f),"0")+f
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
    value=UCase(value)
    fln=Len(value)
    f=Instr(value,"NAN")
    If f>0 Then
        x.fw(4)=&hFFFF
        x.fw(3)=&hC000
        x.fw(2)=0
        x.fw(1)=0
        x.fw(0)=0
        Goto atof_end
    EndIf
    f=Instr(value,"INF")
    If f>0 Then
        x.fw(4)=&h7FFF
        x.fw(3)=&h8000
        x.fw(2)=0
        x.fw(1)=0
        x.fw(0)=0
        Goto atof_end
    EndIf
    f=Instr(value,"-INF")
    If f>0 Then
        x.fw(4)=&hFFFF
        x.fw(3)=&h8000
        x.fw(2)=0
        x.fw(1)=0
        x.fw(0)=0
        Goto atof_end
    EndIf
 
    f1=""
    f2=""
    f3=""
    Asm
        lea ebx,[pw]
        lea edx,[t]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fild dword ptr [edx]
        fstp tbyte ptr [ebx]
    End Asm
    While j<=fln
        c=Mid(value,j,1)
        If ep=1 Then
            If c=" " Then
                Goto atof1nxtch
            EndIf
            If c="-" Then
                es=-es
                c=""
            EndIf
            If c="+" Then
                Goto atof1nxtch
            EndIf
            If (c="0") And (f3="") Then
                Goto atof1nxtch
            EndIf
            If (c>"/") And (c<":") Then 'c is digit between 0 and 9
                f3=f3+c
                ex=10*ex+(Asc(c)-48)
                Goto atof1nxtch
            EndIf
        EndIf

        If c=" " Then
            Goto atof1nxtch
        EndIf
        If c="-" Then
            s=-s
            Goto atof1nxtch
        EndIf
        If c="+" Then
            Goto atof1nxtch
        EndIf
        If c="." Then
            If d=1 Then
                Goto atof1nxtch
            EndIf
            d=1
        EndIf
        If (c>"/") And (c<":") Then 'c$ is digit between 0 and 9
            If ((c="0") And (i=0)) Then
                If d=0 Then
                    Goto atof1nxtch
                EndIf
                If (d=1) And (f=0) Then
                    e=e-1
                    Goto atof1nxtch
                EndIf
            EndIf
            If d=0 Then
                f1=f1+c
                i=i+1
            Else
                If (c>"0") Then
                    fp=1
                EndIf
                f2=f2+c
                f=f+1
            EndIf
        EndIf
        If c="E" Then
            ep=1
        EndIf
atof1nxtch:
        j=j+1
    Wend
    If fp=0 Then
        f=0
        f2=""
    EndIf

    ex=es*ex-18+i+e '(es*ex)-(18-i)+e
    f1=f1+f2
    fln=Len(f1)
    If Len(f1)>20 Then
        f1=Mid(f1,1,20)
    EndIf
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
        lea ebx,[y]
        mov eax,[x]
        fbld tbyte ptr [eax]
        fimul dword ptr [t]
        fbld tbyte ptr [ebx]
        faddp st(1),st(0)   'x+y/100
        fidiv dword ptr [t]
        fstp tbyte ptr [eax]
    End Asm
    x_iPower(pw,pw,-ex)'10^(ex+2)
    Asm
        lea eax,[pw]
        fld tbyte ptr [eax]
        mov eax,[x]
        fld tbyte ptr [eax]
        fdivrp st(1),st(0)   'x=x*pw
    End Asm
    If s<0 Then
        Asm fchs
    EndIf
    Asm
        mov eax,[x]
        fstp tbyte ptr[eax]
    End Asm
atof_end:
End Sub

Function x_Fcom(Byref x As ext, Byref y As ext) As Integer
    Dim As integer flag
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        mov ebx,[y]
        fld tbyte ptr [eax]
        fld tbyte ptr [ebx]
        fsubp st(1),st(0)
        ftst
        fstp st(0)
        fstsw ax
        mov al,ah
        shr al,6     
        Xor ah,1 
        Xor ah,al
        shl ah,1
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
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fld tbyte ptr [ebx] 'x
        fabs            '|x|
        fstp tbyte ptr [eax]'y
    End Asm
End Sub

Sub x_Neg(Byref y As ext,Byref x As ext)'y=-x
    Asm
        mov ebx,[x]
        mov eax,[y]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fld tbyte ptr [ebx] 'x
        fchs            '-x
        fstp tbyte ptr [eax]'y
    End Asm
End Sub

Sub x_Add(Byref z As ext,Byref x As ext,Byref y As ext)'z=x+y
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov edx,[x]
        mov ebx,[y]
        mov eax,[z]
        fld tbyte ptr [edx]'x
        fld tbyte ptr [ebx]'y
        faddp st(1),st(0)  'x-y
        fstp tbyte ptr [eax]'z
    End Asm
End Sub

Sub x_Mul(Byref z As ext,Byref x As ext,Byref y As ext)'z=x*y
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[z]
        mov ebx,[y]
        mov ecx,[x]
        fld tbyte ptr [ecx] 'x
        fld tbyte ptr [ebx] 'y
        fmulp st(1),st(0)
        fstp tbyte ptr [eax]'z
    End Asm
End Sub

Sub x_Div(Byref z As ext,Byref x As ext,Byref y As ext)'z=x/y
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[z]
        mov ebx,[y]
        mov ecx,[x]
        fld tbyte ptr [ecx] 'x
        fld tbyte ptr [ebx] 'y
        fdivp st(1),st(0)
        fstp tbyte ptr [eax]'z
    End Asm
End Sub

Sub x_iDiv(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x/z
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ebx,[x]
        lea ecx,[z]
        mov eax,[y]
        fld tbyte ptr [ebx] 'x
        fild dword ptr [ecx]'z
        fdivp st(1),st(0)
        fstp tbyte ptr [eax]'y
    End Asm
End Sub

Sub x_iAdd(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x+z
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov edx,[x]
        lea ecx,[z]
        mov eax,[y]
        fld tbyte ptr [edx] 'x
        fild dword ptr [ecx]'z
        faddp st(1),st(0)
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_iSub(Byref y As ext,Byref x As ext,Byval z As Integer)'y=x-z
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ebx,[x]
        lea ecx,[z]
        mov eax,[y]
        fld tbyte ptr [ebx] 'x
        fild dword ptr [ecx]'z
        fsubp st(1),st(0)
        fstp tbyte ptr [eax] 'y
    End Asm
End Sub

Sub xInc(Byref x As ext)'x=x+1
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fld tbyte ptr [eax]'x
        fld1
        faddp st(1),st(0)
        fstp tbyte ptr [eax]'x
    End Asm
End Sub

Sub xDec(Byref x As ext)'x=x-1
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[x]
        fld tbyte ptr [eax]'x
        fld1
        fsubp st(1),st(0)
        fstp tbyte ptr [eax]'x
    End Asm
End Sub

Sub x_Scale(Byref y As ext,Byref x As ext,Byval j As Integer)'y=x*2^j
    Asm
        mov eax,[y]
        mov ebx,[x]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fild dword ptr [j]
        fld tbyte ptr [ebx]   'x
        fscale
        fstp tbyte ptr [eax]  'y
        fstp st(0) 'clean fpu stack
    End Asm
End Sub

Function x_Factorial(Byref y As ext,Byref x As ext) As Integer'y=x!
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ebx,[x]
        fld tbyte ptr [ebx] 'x
        fldz
        fcompp
        fnstsw ax
        sahf
        jne xFactorial0
        fld1
        jmp xFactorial7
        xFactorial0:
        fld tbyte ptr [ebx]
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
        fld tbyte ptr [mbig]
        jmp xFactorial7
        xFactorial2:
        fld tbyte ptr [ebx]
        fild word ptr [onethousand]
        fcompp
        fnstsw ax
        sahf
        jb xFactorial5
        fld tbyte ptr [ebx]
        sub esp,4
        fist dword ptr [esp]
        mov ecx,[esp]
        add esp,4
        fld1
        fld1
        fld st(2)
        xFactorial3:
        fmul st(2),st(0)
        fsub st(0),st(1)
        sub ecx,1
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
        fld tbyte ptr [ebx]         'load x
        fld tbyte ptr [120+gamma]   ' 9.5
        faddp st(1),st(0)           'x + 9.5
        fld st(0)                 'make copy
        fld tbyte ptr [ebx]         'load x again
        fld tbyte ptr [x_half]     'load .5
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
        fld tbyte ptr [x_e]        'st(0) = exp(st(0))
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
        fld tbyte ptr [gamma]       ' 2.50662827463100050  ' sqrt(2*pi)
        fmulp st(1),st(0)           'st(0) = (x + 9.5) ^ (x + .5) * exp(-(x + 9.5)) * sqrt(2*pi)
        fld tbyte ptr [gamma+10]    '1.00000000000000017
        fld tbyte ptr [ebx]         'load x again
        fiadd word ptr [ten]       'st(0) = x + 10
        fld tbyte ptr [110+gamma]   '-4.02353314126823637e-9
        fdiv st(0),st(1)            'st(0) = -4.02353314126823637e-9 / (x + 10)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 9
        fld tbyte ptr [100+gamma]   ' 5.38413643250956406e-8
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 8
        fld tbyte ptr [90+gamma]    '-7.42345251020141615e-3
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 7
        fld tbyte ptr [80+gamma]    ' 2.60569650561175583
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 6
        fld tbyte ptr [70+gamma]    '-108.176705351436963
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 5
        fld tbyte ptr [60+gamma]    ' 1301.60828605832187
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 4
        fld tbyte ptr [50+gamma]    '-6348.16021764145881
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 3
        fld tbyte ptr [40+gamma]    ' 14291.4927765747855
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 2
        fld tbyte ptr [30+gamma]    '-14815.3042676841391
        fdiv st(0),st(1)
        faddp st(2),st(0)
        fld1
        fsubp st(1),st(0)           'st(0) = x + 1
        fld tbyte ptr [20+gamma]    ' 5716.40018827434138
        fdivrp st(1),st(0)
        faddp  st(1),st(0)
        fmulp st(1),st(0)
        fstp st(1)
        xFactorial7:
        mov eax,[y]
        fstp tbyte ptr [eax]
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
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov eax,[y]
        mov ebx,[x]
        fld tbyte ptr [ebx] 'x
        fsqrt
        fstp tbyte ptr [eax]'y
    End Asm
End Sub

Sub x_Log10(Byref y As ext,Byref x As ext)'y=log10(x)
    Asm
        mov ebx,[x]
        mov eax,[y]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fldlg2 'load log10(2)
        fld tbyte ptr [ebx]'x
        fyl2x ' st(1)*log2(x)
        fstp tbyte ptr [eax] 'y=log10(x)
    End Asm
End Sub

Sub x_Log(Byref y As ext,Byref x As ext) 'y=ln(x)
    Asm
        mov ebx,[x]
        mov eax,[y]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fldln2 'load loge(2)
        fld tbyte ptr [ebx]'x
        fyl2x 'st(1)*log2(x)
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_ExpTen(Byref y As ext,Byref x As ext) 'y=10^x
    Asm
        mov ebx,[x]
        mov eax,[y]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fld tbyte ptr [ebx]
        fild word ptr [ten]
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
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Exp(Byref y As ext,Byref x As ext) 'y=e^x
    Asm
        mov ecx,[x]
        mov eax,[y]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fld tbyte ptr [ecx]
        fld tbyte ptr [x_e]
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
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Sin(Byref y As ext,Byref x As ext) 'y=sin(x)
    Asm
        mov ecx,[x]
        mov eax,[y]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fld tbyte ptr [ecx]'x
        fsin
        fstp tbyte ptr [eax]'y=sin(x)
    End Asm
End Sub

Sub x_Cos(Byref y As ext,Byref x As ext) 'y=cos(x)
    Asm
        mov ecx,[x]
        mov eax,[y]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fld tbyte ptr [ecx]'x
        fcos
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Tan(Byref y As ext,Byref x As ext) 'y=tan(x)
    Asm
        mov ecx,[x]
        mov eax,[y]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fld tbyte ptr [ecx]'x
        fptan
        fstp st(0)
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Asin(Byref y As ext,Byref x As ext)'y=asin(x)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte ptr [ecx] 'x
        fld1
        fld st(1)               
        fmul st(0),st(0)         
        fsubp st(1),st(0)       
        fsqrt                 
        fpatan 
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Acos(Byref y As ext,Byref x As ext)'y=acos(x)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte ptr [ecx] 'x
        fld1
        fld st(1)               
        fmul st(0),st(0)         
        fsubp st(1),st(0)       
        fsqrt
        fxch                 
        fpatan 
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Atan(Byref y As ext,Byref x As ext)'y=atan(x)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte ptr [ecx] 'x
        fld1
        fpatan
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Sinh(Byref y As ext,Byref x As ext)'y=sinh(x)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte ptr [ecx] 'x
        fld tbyte ptr [x_e]
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
        fld tbyte ptr [x_half]
        fmulp st(1),st(0)
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Cosh(Byref y As ext,Byref x As ext)'y=cosh(x)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte ptr [ecx] 'x
        fld tbyte ptr [x_e]
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
        fld tbyte ptr [x_half]
        fmulp st(1),st(0)
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Tanh(Byref y As ext,Byref x As ext)'y=tanh(x)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte ptr [ecx] 'x
        fld tbyte ptr [x_e]
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
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Asinh(Byref y As ext,Byref x As ext)'y=asinh(x)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fldln2 'load loge(2)
        fld tbyte ptr [ecx] 'x
        fld st(0)
        fmul st(0),st(0)
        fld1
        faddp st(1),st(0)
        fsqrt
        faddp st(1),st(0)
        fyl2x 'st(1)*log2(x)
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Acosh(Byref y As ext,Byref x As ext)'y=acosh(x)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fldln2 'load loge(2)
        fld tbyte ptr [ecx] 'x
        fld st(0)
        fmul st(0),st(0)
        fld1
        fsubp st(1),st(0)
        fsqrt
        faddp st(1),st(0)
        fyl2x 'st(1)*log2(x)
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Atanh(Byref y As ext,Byref x As ext)'y=atanh(x)
    Asm
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        mov ecx,[x]
        mov eax,[y]
        fld tbyte ptr [ecx] 'x
        fldln2 'load loge(2)
        fxch
        fld1
        faddp st(1),st(0) 
        fld st(0)
        fld tbyte ptr [x_two]
        fsubrp st(1),st(0)
        fdivp st(1),st(0)
        fyl2x 'st(1)*log2(x)
        fld tbyte ptr [x_half]
        fmulp st(1),st(0)
        fstp tbyte ptr [eax]
    End Asm
End Sub

Sub x_Power(Byref y As ext,Byref x As ext, Byref z As ext) 'y=x^z
    Asm
        mov ebx,[x]
        mov edx,[z]
        mov eax,[y]
        fldcw word ptr [ctrlwrd] ' this guarantees extended precision
        fld tbyte ptr [edx]
        fld tbyte ptr [ebx]
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
        fstp tbyte ptr [eax] ' z
    End Asm
End Sub

Function x_Floor(Byref y As ext, Byref x As ext) As Integer'y=Floor(x)
    Dim As Integer oldcw, newcw
    Asm
        mov ecx,[x]
        lea edx,[oldcw]
        lea edi,[newcw]
        fstcw word ptr [edx] 'oldcw
        mov ax,[edx]
        or ax,&b010000000000
        mov [edi],ax
        fldcw word ptr [edi]
        fld tbyte ptr [ecx]
        frndint
        fistp dword ptr [edi]
        fild dword ptr [edi]
        fldcw word ptr [edx]
        mov eax,[y]
        fstp tbyte ptr [eax]
    End Asm
    Return newcw
End Function



Function cext ( Byref lhs As ext ) As ext
    Return lhs
End Function

Function cext ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    Return retval
End Function

Function cext ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    Return retval
End Function

Function cext ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    Return retval
End Function

Function cext ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    Return retval
End Function

Function cext ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    Return retval
End Function

Function cext ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    Return retval
End Function

Function cext ( Byval lhs As Single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    Return retval
End Function

Function cext ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    Return retval
End Function

Function cext ( Byval lhs As String ) As ext
    Dim As ext retval
    x_AtoF ( retval, lhs )
    Return retval
End Function



Function xSin ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Sin ( retval, lhs )
    Return retval
End Function

Function xSin ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Sin ( retval, retval )
    Return retval
End Function

Function xSin ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Sin ( retval, retval )
    Return retval
End Function

Function xSin ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Sin ( retval, retval )
    Return retval
End Function

Function xSin ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Sin ( retval, retval )
    Return retval
End Function

Function xSin ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Sin ( retval, retval )
    Return retval
End Function

Function xSin ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Sin ( retval, retval )
    Return retval
End Function

Function xSin ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Sin ( retval, retval )
    Return retval
End Function

Function xSin ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Sin ( retval, retval )
    Return retval
End Function



Function xCos ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Cos ( retval, lhs )
    Return retval
End Function

Function xCos ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Cos ( retval, retval )
    Return retval
End Function

Function xCos ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Cos ( retval, retval )
    Return retval
End Function

Function xCos ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Cos ( retval, retval )
    Return retval
End Function

Function xCos ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Cos ( retval, retval )
    Return retval
End Function

Function xCos ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Cos ( retval, retval )
    Return retval
End Function

Function xCos ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Cos ( retval, retval )
    Return retval
End Function

Function xCos ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Cos ( retval, retval )
    Return retval
End Function

Function xCos ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Cos ( retval, retval )
    Return retval
End Function



Function xTan ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Tan ( retval, lhs )
    Return retval
End Function

Function xTan ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Tan ( retval, retval )
    Return retval
End Function

Function xTan ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Tan ( retval, retval )
    Return retval
End Function

Function xTan ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Tan ( retval, retval )
    Return retval
End Function

Function xTan ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Tan ( retval, retval )
    Return retval
End Function

Function xTan ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Tan ( retval, retval )
    Return retval
End Function

Function xTan ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Tan ( retval, retval )
    Return retval
End Function

Function xTan ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Tan ( retval, retval )
    Return retval
End Function

Function xTan ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Tan ( retval, retval )
    Return retval
End Function



Function xSinh ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Sinh ( retval, lhs )
    Return retval
End Function

Function xSinh ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Sinh ( retval, retval )
    Return retval
End Function

Function xSinh ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Sinh ( retval, retval )
    Return retval
End Function

Function xSinh ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Sinh ( retval, retval )
    Return retval
End Function

Function xSinh ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Sinh ( retval, retval )
    Return retval
End Function

Function xSinh ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Sinh ( retval, retval )
    Return retval
End Function

Function xSinh ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Sinh ( retval, retval )
    Return retval
End Function

Function xSinh ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Sinh ( retval, retval )
    Return retval
End Function

Function xSinh ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Sinh ( retval, retval )
    Return retval
End Function



Function xCosh ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Cosh ( retval, lhs )
    Return retval
End Function

Function xCosh ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Cosh ( retval, retval )
    Return retval
End Function

Function xCosh ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Cosh ( retval, retval )
    Return retval
End Function

Function xCosh ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Cosh ( retval, retval )
    Return retval
End Function

Function xCosh ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Cosh ( retval, retval )
    Return retval
End Function

Function xCosh ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Cosh ( retval, retval )
    Return retval
End Function

Function xCosh ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Cosh ( retval, retval )
    Return retval
End Function

Function xCosh ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Cosh ( retval, retval )
    Return retval
End Function

Function xCosh ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Cosh ( retval, retval )
    Return retval
End Function



Function xTanh ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Tanh ( retval, lhs )
    Return retval
End Function

Function xTanh ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Tanh ( retval, retval )
    Return retval
End Function

Function xTanh ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Tanh ( retval, retval )
    Return retval
End Function

Function xTanh ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Tanh ( retval, retval )
    Return retval
End Function

Function xTanh ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Tanh ( retval, retval )
    Return retval
End Function

Function xTanh ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Tanh ( retval, retval )
    Return retval
End Function

Function xTanh ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Tanh ( retval, retval )
    Return retval
End Function

Function xTanh ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Tanh ( retval, retval )
    Return retval
End Function

Function xTanh ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Tanh ( retval, retval )
    Return retval
End Function



Function xAsin ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Asin ( retval, lhs )
    Return retval
End Function

Function xAsin ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Asin ( retval, retval )
    Return retval
End Function

Function xAsin ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Asin ( retval, retval )
    Return retval
End Function

Function xAsin ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Asin ( retval, retval )
    Return retval
End Function

Function xAsin ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Asin ( retval, retval )
    Return retval
End Function

Function xAsin ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Asin ( retval, retval )
    Return retval
End Function

Function xAsin ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Asin ( retval, retval )
    Return retval
End Function

Function xAsin ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Asin ( retval, retval )
    Return retval
End Function

Function xAsin ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Asin ( retval, retval )
    Return retval
End Function



Function xAcos ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Acos ( retval, lhs )
    Return retval
End Function

Function xAcos ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Acos ( retval, retval )
    Return retval
End Function

Function xAcos ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Acos ( retval, retval )
    Return retval
End Function

Function xAcos ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Acos ( retval, retval )
    Return retval
End Function

Function xAcos ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Acos ( retval, retval )
    Return retval
End Function

Function xAcos ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Acos ( retval, retval )
    Return retval
End Function

Function xAcos ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Acos ( retval, retval )
    Return retval
End Function

Function xAcos ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Acos ( retval, retval )
    Return retval
End Function

Function xAcos ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Acos ( retval, retval )
    Return retval
End Function



Function xAtn ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Atan ( retval, lhs )
    Return retval
End Function

Function xAtn ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Atan ( retval, retval )
    Return retval
End Function

Function xAtn ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Atan ( retval, retval )
    Return retval
End Function

Function xAtn ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Atan ( retval, retval )
    Return retval
End Function

Function xAtn ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Atan ( retval, retval )
    Return retval
End Function

Function xAtn ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Atan ( retval, retval )
    Return retval
End Function

Function xAtn ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Atan ( retval, retval )
    Return retval
End Function

Function xAtn ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Atan ( retval, retval )
    Return retval
End Function

Function xAtn ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Atan ( retval, retval )
    Return retval
End Function



Function xAsinh ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Asinh ( retval, lhs )
    Return retval
End Function

Function xAsinh ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Asinh ( retval, retval )
    Return retval
End Function

Function xAsinh ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Asinh ( retval, retval )
    Return retval
End Function

Function xAsinh ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Asinh ( retval, retval )
    Return retval
End Function

Function xAsinh ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Asinh ( retval, retval )
    Return retval
End Function

Function xAsinh ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Asinh ( retval, retval )
    Return retval
End Function

Function xAsinh ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Asinh ( retval, retval )
    Return retval
End Function

Function xAsinh ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Asinh ( retval, retval )
    Return retval
End Function

Function xAsinh ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Asinh ( retval, retval )
    Return retval
End Function



Function xAcosh ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Acosh ( retval, lhs )
    Return retval
End Function

Function xAcosh ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Acosh ( retval, retval )
    Return retval
End Function

Function xAcosh ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Acosh ( retval, retval )
    Return retval
End Function

Function xAcosh ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Acosh ( retval, retval )
    Return retval
End Function

Function xAcosh ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Acosh ( retval, retval )
    Return retval
End Function

Function xAcosh ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Acosh ( retval, retval )
    Return retval
End Function

Function xAcosh ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Acosh ( retval, retval )
    Return retval
End Function

Function xAcosh ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Acosh ( retval, retval )
    Return retval
End Function

Function xAcosh ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Acosh ( retval, retval )
    Return retval
End Function



Function xAtnh ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Atanh ( retval, lhs )
    Return retval
End Function

Function xAtnh ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Atanh ( retval, retval )
    Return retval
End Function

Function xAtnh ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Atanh ( retval, retval )
    Return retval
End Function

Function xAtnh ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Atanh ( retval, retval )
    Return retval
End Function

Function xAtnh ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Atanh ( retval, retval )
    Return retval
End Function

Function xAtnh ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Atanh ( retval, retval )
    Return retval
End Function

Function xAtnh ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Atanh ( retval, retval )
    Return retval
End Function

Function xAtnh ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Atanh ( retval, retval )
    Return retval
End Function

Function xAtnh ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Atanh ( retval, retval )
    Return retval
End Function



Function xSqr ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Sqrt ( retval, lhs )
    Return retval
End Function

Function xSqr ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Sqrt ( retval, retval )
    Return retval
End Function

Function xSqr ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Sqrt ( retval, retval )
    Return retval
End Function

Function xSqr ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Sqrt ( retval, retval )
    Return retval
End Function

Function xSqr ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Sqrt ( retval, retval )
    Return retval
End Function

Function xSqr ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Sqrt ( retval, retval )
    Return retval
End Function

Function xSqr ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Sqrt ( retval, retval )
    Return retval
End Function

Function xSqr ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Sqrt ( retval, retval )
    Return retval
End Function

Function xSqr ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Sqrt ( retval, retval )
    Return retval
End Function



Function xLog ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Log ( retval, lhs )
    Return retval
End Function

Function xLog ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Log ( retval, retval )
    Return retval
End Function

Function xLog ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Log ( retval, retval )
    Return retval
End Function

Function xLog ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Log ( retval, retval )
    Return retval
End Function

Function xLog ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Log ( retval, retval )
    Return retval
End Function

Function xLog ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Log ( retval, retval )
    Return retval
End Function

Function xLog ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Log ( retval, retval )
    Return retval
End Function

Function xLog ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Log ( retval, retval )
    Return retval
End Function

Function xLog ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Log ( retval, retval )
    Return retval
End Function



Function xLog10 ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Log10 ( retval, lhs )
    Return retval
End Function

Function xLog10 ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Log10 ( retval, retval )
    Return retval
End Function

Function xLog10 ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Log10 ( retval, retval )
    Return retval
End Function

Function xLog10 ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Log10 ( retval, retval )
    Return retval
End Function

Function xLog10 ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Log10 ( retval, retval )
    Return retval
End Function

Function xLog10 ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Log10 ( retval, retval )
    Return retval
End Function

Function xLog10 ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Log10 ( retval, retval )
    Return retval
End Function

Function xLog10 ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Log10 ( retval, retval )
    Return retval
End Function

Function xLog10 ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Log10 ( retval, retval )
    Return retval
End Function



Function xExp ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Exp ( retval, lhs )
    Return retval
End Function

Function xExp ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Exp ( retval, retval )
    Return retval
End Function

Function xExp ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Exp ( retval, retval )
    Return retval
End Function

Function xExp ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Exp ( retval, retval )
    Return retval
End Function

Function xExp ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Exp ( retval, retval )
    Return retval
End Function

Function xExp ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Exp ( retval, retval )
    Return retval
End Function

Function xExp ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Exp ( retval, retval )
    Return retval
End Function

Function xExp ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Exp ( retval, retval )
    Return retval
End Function

Function xExp ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Exp ( retval, retval )
    Return retval
End Function



Function xExp10 ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_ExpTen ( retval, lhs )
    Return retval
End Function

Function xExp10 ( Byval lhs As Integer ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_ExpTen ( retval, retval )
    Return retval
End Function

Function xExp10 ( Byval lhs As Long ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_ExpTen ( retval, retval )
    Return retval
End Function

Function xExp10 ( Byval lhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_ExpTen ( retval, retval )
    Return retval
End Function

Function xExp10 ( Byval lhs As UInteger ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_ExpTen ( retval, retval )
    Return retval
End Function

Function xExp10 ( Byval lhs As ULong ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_ExpTen ( retval, retval )
    Return retval
End Function

Function xExp10 ( Byval lhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_ExpTen ( retval, retval )
    Return retval
End Function

Function xExp10 ( Byval lhs As single ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_ExpTen ( retval, retval )
    Return retval
End Function

Function xExp10 ( Byval lhs As Double ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_ExpTen ( retval, retval )
    Return retval
End Function

Operator + ( Byval lhs As ext, Byval rhs As ext ) As ext
    Dim As ext retval
    x_Add ( retval, lhs, rhs )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As ext, Byval rhs As Integer ) As ext
    Dim As ext retval
    ireal10 ( retval, rhs )
    x_Add ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As Integer, Byval rhs As ext ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Add ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As ext, Byval rhs As Long ) As ext
    Dim As ext retval
    ilreal10 ( retval, rhs )
    x_Add ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As Long, Byval rhs As ext ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Add ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As ext, Byval rhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, rhs )
    x_Add ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As LongInt, Byval rhs As ext ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Add ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As ext, Byval rhs As UInteger ) As ext
    Dim As ext retval
    uireal10 ( retval, rhs )
    x_Add ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As UInteger, Byval rhs As ext ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Add ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As ext, Byval rhs As ULong ) As ext
    Dim As ext retval
    uilreal10 ( retval, rhs )
    x_Add ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As ULong, Byval rhs As ext ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Add ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As ext, Byval rhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, rhs )
    x_Add ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As ULongInt, Byval rhs As ext ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Add ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As ext, Byval rhs As Single ) As ext
    Dim As ext retval
    sreal10 ( retval, rhs )
    x_Add ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As Single, Byval rhs As ext ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Add ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As ext, Byval rhs As Double ) As ext
    Dim As ext retval
    dreal10 ( retval, rhs )
    x_Add ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator + ( Byval lhs As Double, Byval rhs As ext ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Add ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

'=============================================================
Operator ext.+= ( byval rhs as double ) 'As ext
    Dim As ext retval
    dreal10 ( retval, rhs )
    x_Add ( this, this, retval )
End Operator
'=============================================================

Operator - ( Byval lhs As ext, Byval rhs As ext ) As ext
    Dim As ext retval
    x_Sub ( retval, lhs, rhs )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As ext, Byval rhs As Integer ) As ext
    Dim As ext retval
    ireal10 ( retval, rhs )
    x_Sub ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As Integer, Byval rhs As ext ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Sub ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator


Operator - ( Byval lhs As ext, Byval rhs As Long ) As ext
    Dim As ext retval
    ilreal10 ( retval, rhs )
    x_Sub ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As Long, Byval rhs As ext ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Sub ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As ext, Byval rhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, rhs )
    x_Sub ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As LongInt, Byval rhs As ext ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Sub ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As ext, Byval rhs As UInteger ) As ext
    Dim As ext retval
    uireal10 ( retval, rhs )
    x_Sub ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As UInteger, Byval rhs As ext ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Sub ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As ext, Byval rhs As ULong ) As ext
    Dim As ext retval
    uilreal10 ( retval, rhs )
    x_Sub ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As ULong, Byval rhs As ext ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Sub ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As ext, Byval rhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, rhs )
    x_Sub ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As ULongInt, Byval rhs As ext ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Sub ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As ext, Byval rhs As Single ) As ext
    Dim As ext retval
    sreal10 ( retval, rhs )
    x_Sub ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As Single, Byval rhs As ext ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Sub ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As ext, Byval rhs As Double ) As ext
    Dim As ext retval
    dreal10 ( retval, rhs )
    x_Sub ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As Double, Byval rhs As ext ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Sub ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator - ( Byval lhs As ext ) As ext
    Dim As ext retval
    x_Neg ( retval, lhs )
    Return retval'type<ext>retval
End Operator
Operator * ( Byval lhs As ext, Byval rhs As ext ) As ext
    Dim As ext retval
    x_Mul ( retval, lhs, rhs )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As ext, Byval rhs As Integer ) As ext
    Dim As ext retval
    ireal10 ( retval, rhs )
    x_Mul ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As Integer, Byval rhs As ext ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Mul ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As ext, Byval rhs As Long ) As ext
    Dim As ext retval
    ilreal10 ( retval, rhs )
    x_Mul ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As Long, Byval rhs As ext ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Mul ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As ext, Byval rhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, rhs )
    x_Mul ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As LongInt, Byval rhs As ext ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Mul ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As ext, Byval rhs As UInteger ) As ext
    Dim As ext retval
    uireal10 ( retval, rhs )
    x_Mul ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As UInteger, Byval rhs As ext ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Mul ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As ext, Byval rhs As ULong ) As ext
    Dim As ext retval
    uilreal10 ( retval, rhs )
    x_Mul ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As ULong, Byval rhs As ext ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Mul ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As ext, Byval rhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, rhs )
    x_Mul ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As ULongInt, Byval rhs As ext ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Mul ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As ext, Byval rhs As Single ) As ext
    Dim As ext retval
    sreal10 ( retval, rhs )
    x_Mul ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As Single, Byval rhs As ext ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Mul ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As ext, Byval rhs As Double ) As ext
    Dim As ext retval
    dreal10 ( retval, rhs )
    x_Mul ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator * ( Byval lhs As Double, Byval rhs As ext ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Mul ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As ext, Byval rhs As ext ) As ext
    Dim As ext retval
    x_Div ( retval, lhs, rhs )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As ext, Byval rhs As Integer ) As ext
    Dim As ext retval
    ireal10 ( retval, rhs )
    x_Div ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As Integer, Byval rhs As ext ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Div ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As ext, Byval rhs As Long ) As ext
    Dim As ext retval
    ilreal10 ( retval, rhs )
    x_Div ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As Long, Byval rhs As ext ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Div ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As ext, Byval rhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, rhs )
    x_Div ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As LongInt, Byval rhs As ext ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Div ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As ext, Byval rhs As UInteger ) As ext
    Dim As ext retval
    uireal10 ( retval, rhs )
    x_Div ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As UInteger, Byval rhs As ext ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Div ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As ext, Byval rhs As ULong ) As ext
    Dim As ext retval
    uilreal10 ( retval, rhs )
    x_Div ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As ULong, Byval rhs As ext ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Div ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As ext, Byval rhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, rhs )
    x_Div ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As ULongInt, Byval rhs As ext ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Div ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As ext, Byval rhs As Single ) As ext
    Dim As ext retval
    sreal10 ( retval, rhs )
    x_Div ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As Single, Byval rhs As ext ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Div ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As ext, Byval rhs As Double ) As ext
    Dim As ext retval
    dreal10 ( retval, rhs )
    x_Div ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator / ( Byval lhs As Double, Byval rhs As ext ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Div ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As ext, Byval rhs As ext ) As ext
    Dim As ext retval
    x_Power ( retval, lhs, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As ext, Byval rhs As Integer ) As ext
    Dim As ext retval
    x_iPower ( retval, lhs, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As Integer, Byval rhs As ext ) As ext
    Dim As ext retval
    iReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As ext, Byval rhs As Long ) As ext
    Dim As ext retval
    x_iPower ( retval, lhs, Cast(Integer, rhs) )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As Long, Byval rhs As ext ) As ext
    Dim As ext retval
    ilReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As ext, Byval rhs As LongInt ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As LongInt, Byval rhs As ext ) As ext
    Dim As ext retval
    iqReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As ext, Byval rhs As UInteger ) As ext
    Dim As ext retval
    x_iPower ( retval, lhs, Cast( Integer, rhs ) )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As UInteger, Byval rhs As ext ) As ext
    Dim As ext retval
    uiReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As ext, Byval rhs As ULong ) As ext
    Dim As ext retval
    x_iPower ( retval, lhs, Cast(Integer, rhs) )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As ULong, Byval rhs As ext ) As ext
    Dim As ext retval
    uilReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As ext, Byval rhs As ULongInt ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As ULongInt, Byval rhs As ext ) As ext
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As ext, Byval rhs As Single ) As ext
    Dim As ext retval
    sreal10 ( retval, rhs )
    x_Power ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As Single, Byval rhs As ext ) As ext
    Dim As ext retval
    sReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As ext, Byval rhs As Double ) As ext
    Dim As ext retval
    dreal10 ( retval, rhs )
    x_Power ( retval, lhs, retval )
    Return retval'type<ext>retval
End Operator

Operator ^ ( Byval lhs As Double, Byval rhs As ext ) As ext
    Dim As ext retval
    dReal10 ( retval, lhs )
    x_Power ( retval, retval, rhs )
    Return retval'type<ext>retval
End Operator

'rel ops

Operator <> ( Byval lhs As ext, Byval rhs As ext ) As Integer
    Dim As Integer relop
    relop=x_Fcom ( lhs, rhs )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As ext, Byval rhs As Integer ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As Integer, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As ext, Byval rhs As Long ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As Long, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As ext, Byval rhs As ULong ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As ULong, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As ext, Byval rhs As Single ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As Single, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As ext, Byval rhs As Double ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<>0
End Operator

Operator <> ( Byval lhs As Double, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<>0
End Operator

Operator < ( Byval lhs As ext, Byval rhs As ext ) As Integer
    Dim As Integer relop
    relop=x_Fcom ( lhs, rhs )
    Return relop=-1
End Operator

Operator < ( Byval lhs As ext, Byval rhs As Integer ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=-1
End Operator

Operator < ( Byval lhs As Integer, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=-1
End Operator

Operator < ( Byval lhs As ext, Byval rhs As Long ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=-1
End Operator

Operator < ( Byval lhs As Long, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=-1
End Operator

Operator < ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=-1
End Operator

Operator < ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=-1
End Operator

Operator < ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=-1
End Operator

Operator < ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=-1
End Operator

Operator < ( Byval lhs As ext, Byval rhs As ULong ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=-1
End Operator

Operator < ( Byval lhs As ULong, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=-1
End Operator

Operator < ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=-1
End Operator

Operator < ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=-1
End Operator

Operator < ( Byval lhs As ext, Byval rhs As Single ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=-1
End Operator

Operator < ( Byval lhs As Single, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=-1
End Operator

Operator < ( Byval lhs As ext, Byval rhs As Double ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=-1
End Operator

Operator < ( Byval lhs As Double, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=-1
End Operator

Operator <= ( Byval lhs As ext, Byval rhs As ext ) As Integer
    Dim As Integer relop
    relop=x_Fcom ( lhs, rhs )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As ext, Byval rhs As Integer ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As Integer, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As ext, Byval rhs As Long ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As Long, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As ext, Byval rhs As ULong ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As ULong, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As ext, Byval rhs As Single ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As Single, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As ext, Byval rhs As Double ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop<=0
End Operator

Operator <= ( Byval lhs As Double, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop<=0
End Operator

Operator = ( Byval lhs As ext, Byval rhs As ext ) As Integer
    Dim As Integer relop
    relop=x_Fcom ( lhs, rhs )
    Return relop=0
End Operator

Operator = ( Byval lhs As ext, Byval rhs As Integer ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=0
End Operator

Operator = ( Byval lhs As Integer, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=0
End Operator

Operator = ( Byval lhs As ext, Byval rhs As Long ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=0
End Operator

Operator = ( Byval lhs As Long, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=0
End Operator

Operator = ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=0
End Operator

Operator = ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=0
End Operator

Operator = ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=0
End Operator

Operator = ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=0
End Operator

Operator = ( Byval lhs As ext, Byval rhs As ULong ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=0
End Operator

Operator = ( Byval lhs As ULong, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=0
End Operator

Operator = ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=0
End Operator

Operator = ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=0
End Operator

Operator = ( Byval lhs As ext, Byval rhs As Single ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=0
End Operator

Operator = ( Byval lhs As Single, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=0
End Operator

Operator = ( Byval lhs As ext, Byval rhs As Double ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=0
End Operator

Operator = ( Byval lhs As Double, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=0
End Operator

Operator >= ( Byval lhs As ext, Byval rhs As ext ) As Integer
    Dim As Integer relop
    relop=x_Fcom ( lhs, rhs )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As ext, Byval rhs As Integer ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As Integer, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As ext, Byval rhs As Long ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As Long, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As ext, Byval rhs As ULong ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As ULong, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As ext, Byval rhs As Single ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As Single, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As ext, Byval rhs As Double ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop>=0
End Operator

Operator >= ( Byval lhs As Double, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop>=0
End Operator

Operator > ( Byval lhs As ext, Byval rhs As ext ) As Integer
    Dim As Integer relop
    relop=x_Fcom ( lhs, rhs )
    Return relop=1
End Operator

Operator > ( Byval lhs As ext, Byval rhs As Integer ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=1
End Operator

Operator > ( Byval lhs As Integer, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=1
End Operator

Operator > ( Byval lhs As ext, Byval rhs As Long ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=1
End Operator

Operator > ( Byval lhs As Long, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    ilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=1
End Operator

Operator > ( Byval lhs As ext, Byval rhs As LongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=1
End Operator

Operator > ( Byval lhs As LongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    iqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=1
End Operator

Operator > ( Byval lhs As ext, Byval rhs As UInteger ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=1
End Operator

Operator > ( Byval lhs As UInteger, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=1
End Operator

Operator > ( Byval lhs As ext, Byval rhs As ULong ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=1
End Operator

Operator > ( Byval lhs As ULong, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uilReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=1
End Operator

Operator > ( Byval lhs As ext, Byval rhs As ULongInt ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=1
End Operator

Operator > ( Byval lhs As ULongInt, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    uiqReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=1
End Operator

Operator > ( Byval lhs As ext, Byval rhs As Single ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=1
End Operator

Operator > ( Byval lhs As Single, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    sReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=1
End Operator

Operator > ( Byval lhs As ext, Byval rhs As Double ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, rhs )
    relop=x_Fcom ( lhs, retval )
    Return relop=1
End Operator

Operator > ( Byval lhs As Double, Byval rhs As ext ) As Integer
    Dim As Integer relop
    Dim As ext retval
    dReal10 ( retval, lhs )
    relop=x_Fcom ( retval, rhs )
    Return relop=1
End Operator

Operator ext.cast ( ) As Integer
    Operator = x_toInt ( this )
End Operator

Operator ext.cast ( ) As Long
    Operator = x_toLong ( this )
End Operator

Operator ext.cast ( ) As LongInt
    Operator = x_toLongInt ( this )
End Operator

Operator ext.cast ( ) As UInteger
    Operator = x_toUInt ( this )
End Operator

Operator ext.cast ( ) As ULong
    Operator = x_toULong ( this )
End Operator

Operator ext.cast ( ) As ULongInt
    Operator = x_toULongInt ( this )
End Operator

Operator ext.cast ( ) As Single
    Operator = x_toSingle ( this )
End Operator

Operator ext.cast ( ) As Double
    Operator = x_toDouble ( this )
End Operator

Operator ext.cast ( ) As String
    Operator = x_FtoA( this )
End Operator

constructor ext ( Byref rhs As ext )
   this = rhs
end constructor

constructor ext ( Byval rhs As Integer )
    iReal10 ( this, rhs )
end constructor

constructor ext ( Byval rhs As Long )
    ilReal10 ( this, rhs )
end constructor

constructor ext ( Byval rhs As LongInt )
    iqReal10 ( this, rhs )
end constructor

constructor ext ( Byval rhs As UInteger )
    uiReal10 ( this, rhs )
end constructor

constructor ext ( Byval rhs As ULong )
    uilReal10 ( this, rhs )
end constructor

constructor ext ( Byval rhs As ULongInt )
    uiqReal10 ( this, rhs )
end constructor

constructor ext ( Byval rhs As Single )
    sReal10 ( this, rhs )
end constructor

constructor ext ( Byval rhs As Double )
    dReal10 ( this, rhs )
end constructor

constructor ext ( Byref rhs As String )
    x_AtoF ( this, rhs )
end constructor

operator ext.let ( Byref rhs As ext )
    this.fw(0) = rhs.fw(0)
    this.fw(1) = rhs.fw(1)
    this.fw(2) = rhs.fw(2)
    this.fw(3) = rhs.fw(3)
    this.fw(4) = rhs.fw(4)
end operator

operator ext.let ( Byval rhs As Integer )
    iReal10 ( this, rhs )
end operator

operator ext.let ( Byval rhs As Long )
    ilReal10 ( this, rhs )
end operator

operator ext.let ( Byval rhs As LongInt )
    iqReal10 ( this, rhs )
end operator

operator ext.let ( Byval rhs As UInteger )
    uiReal10 ( this, rhs )
end operator

operator ext.let ( Byval rhs As ULong )
    uilReal10 ( this, rhs )
end operator

operator ext.let ( Byval rhs As ULongInt )
    uiqReal10 ( this, rhs )
end operator

operator ext.let ( Byval rhs As Single )
    sReal10 ( this, rhs )
end operator

operator ext.let ( Byval rhs As Double )
    dReal10 ( this, rhs )
end operator

operator ext.let ( Byref rhs As String )
    x_AtoF ( this, rhs )
end operator

'=========================================================
'' For Next for extended type
''
'' implicit step versions
''
'' In this example, we interpret implicit step
'' to mean 1
Operator ext.for( )
End Operator

Operator ext.step( )
        this += 1 'this = this+1 '
End Operator

Operator ext.next( Byref end_cond As ext ) As Integer
        Return this <= end_cond
End Operator


'' explicit step versions
''
Operator ext.for( Byref step_var As ext )
End Operator

Operator ext.step( Byref step_var As ext )
        this += step_var 'this = this + step_var '   
End Operator

Operator ext.next( Byref end_cond As ext, Byref step_var As ext ) As Integer
        If step_var < 0 Then
                Return this >= end_cond
        Else
                Return this <= end_cond
        End If
End Operator
