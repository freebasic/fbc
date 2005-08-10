#
#  libfb - FreeBASIC's runtime library
#  Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

#
# str_ftoa_x86.s -- float to string, internal usage, x86 arch only
#
# chng: jan/2001 written [v1ctor]
#       feb/2005 ported to GAS [v1ctor]
#
#

		.intel_syntax noprefix
		.arch i386


.section .data
const_il2t:     .tfloat 0.3010299956639811952   # 1 / lg 10
const_10:       .double 10.0
dizima_tb:      .tfloat 9.E-9
                .tfloat 9.E-17

                # 1 / pow10(0..16) table
ipow10_tb:      .tfloat 1.E-00, 1.E-01, 1.E-02, 1.E-03, 1.E-04, 1.E-05
                .tfloat 1.E-06, 1.E-07, 1.E-08, 1.E-09, 1.E-10, 1.E-11
                .tfloat 1.E-12, 1.E-13, 1.E-14, 1.E-15, 1.E-16


.section .bss
		.lcomm  old_cw,2                # control word
		.lcomm  cur_cw,2                # /
		.lcomm  exp2,2                  # pow of 2
		.lcomm  exp10,2                 #  '   ' 10
		.lcomm  _int,2
		.lcomm  _dt,10


.section .text
#::::::::::::::
# int fb_f2a( double num, char *dst, int digits, int addblank );
.globl _fb_f2a
.globl fb_f2a
_fb_f2a:
fb_f2a:
		push	ebp
		mov	ebp, esp
		push	ebx
		push	edi
		push	esi

                fld     qword ptr [ebp+8]	# double num
                mov     edi, [ebp+16]		# char *dst
                mov     ecx, [ebp+20]		# int digits
                
		#  in: st0= float
                #      edi-> asc string
                #      ecx= digits (max 8 f/ SINGLEs and 16 f/ DOUBLEs)
                #            
                # out: eax= asc string length

                fnstcw  [old_cw]       # save control word
                mov     ax, [old_cw]
                mov     [cur_cw], ax

                push    edi                     # (0)

                # check if NaN, zero or negative
                ftst
                fnstsw  ax
                sahf
                jp      ffnan              	# NaN?
                jz      ffzero             	# 0?

                mov     al, ' '                 # assume positive (QB quirk)
                jnb     ffsave_sign
                fabs                            # 2 positive
                mov     al, '-'
                jmp	ffsave_sign

ffcheck_sign:   cmp	dword ptr [ebp+24], 0	# addblank == FALSE?
		je	ffskip_sign                

ffsave_sign:	mov     [edi], al
                inc     edi

ffskip_sign:    # check if out-of-range

                # 10 ^ b    = 2 ^ a
                # lg 10 ^ b = lg 2 ^ a
                # b * lg 10 = a * lg 2  || lg 2 = 1
                # b         = (int)(a / lg 10)

                # find a
                fld     st(0)                   # dup tos
                fxtract                         # st1= a, st(0)= m
                fstp    st(0)                   # pop m
                fist    dword ptr [exp2]        # save the pow2
                # calc b
                fldt    [const_il2t]  # 1 / lg 10
                fmulp   st(1), st(0)
                frndint                         # 2 int
                fist    dword ptr [exp10]       # save b & leave it on st(0)

                # abs(b) >= cx
                mov     eax, [exp10]
                cdq
                xor     eax, edx
                sub     eax, edx
                cmp     eax, ecx
                jge     ffsci_notation     	# use scientific notation?

                fstp    st(0)                   # pop b
#::::::::::::::
                # decimal notation

                cmp     dword ptr [exp2], 0
                jle     ffset_round             # exp2 <= 0?
                # put the integer part in fractional part (to use
                # FMUL (1 clock) instead of FDIV or DIV (40 clocks))
                mov     ebx, [exp10]
                shl     ebx, 1                  # ebx= qword (8 bytes) index
                fldt    [ipow10_tb+ebx*4+ebx]
                fmulp   st(1), st(0)

ffset_round:    # change rounding control to truncating toward 0
                or      word ptr [cur_cw], 0b110000000000
                fldcw   [cur_cw]

                # handle dizima periodica (0.99999999999999998 -> 1.0)
                cmp     ecx, 9
                sbb     ebx, ebx                # ebx= (ecx < 9? -2: 0)
                shl     ebx, 1                  # /
                fldt    [dizima_tb+ebx*4+ebx + 10]
                faddp   st(1), st(0)

                # set last mantissa's bit (to prevent dizima to happen)
                fstpt   [_dt]
                or      byte ptr [_dt+1], 0b10
                fldt    [_dt]

                # float 2 dec
                # if number has integer part:
                #    int digits = exponent
                #    frac digits = digits - int digits
                # else
                #    int digits = 0
                #    frac digits = digits

                cmp     dword ptr [exp2], 0
                jl      ffno_int           	# no int digits?

                mov     ebx, [exp10]            # ebx= int digits (exp)
                mov     edx, ecx                # edx= frac digits (dig - int)
                sub     edx, ebx                # /

                mov     ecx, edx                # ecx= digits - int + 1
                inc     ecx                     # /

                # check if already has an int digit
                fist    dword ptr [_int]
                mov     al, byte ptr [_int]
                test    al, al
                jz      ffiloop                 # not?
                add     al, '0'                 # 2 asc
                mov     [edi], al
                inc     edi
                dec     edx                     # --frac digits
                dec     ecx
                test    ebx, ebx
                jz      ffcheck_frac            # any more int digits?

ffiloop:        fisub   dword ptr [_int]        # del digit
                fmul    qword ptr [const_10]    # next digit
                fist    dword ptr [_int]        # get digit

                mov     al, byte ptr [_int]
                add     al, '0'                 # 2 asc
                mov     [edi], al
                inc     edi
                dec     ebx
                jnz     ffiloop

ffcheck_frac:   test    edx, edx
                jle     ffdone                  # any frac digit?
                mov     byte ptr [edi], '.'
                inc     edi

fffloop:        fisub   dword ptr [_int]        # del digit
                fmul    qword ptr [const_10]    # next digit
                fist    dword ptr [_int]        # get digit

                mov     al, byte ptr [_int]     # /
                add     al, '0'                 # 2 asc
                mov     [edi], al
                inc     edi
                dec     edx
                jnz     fffloop

                # delete zero(s) at right
                mov     al, '0'
                dec     edi
                std                             # go down
                repe    scasb                   # scan while = '0'
                cld
                cmp     ecx, 1                  # all digits= '0'? del '.'
                sbb     ecx, ecx                # ecx= 2 + (ecx == 0? -1: 0)
                add     ecx, 2                  # /
                add     edi, ecx                #
                jmp     ffdone

ffno_int:       mov     byte ptr [edi], '.'     # (QB quirk)
                inc     edi
                mov     edx, ecx                # edx= frac digits (dig)
                inc     ecx                     # ecx= digits + 1
                mov     dword ptr [_int], 0     # f/ FISUB
                jmp     fffloop

ffdone:         fstp    st(0)                   # pop tos

#::::::::::::::
ffexit:         mov	byte ptr [edi], 0	# NULL-term
		lea     eax, [edi+1]		# edi + 1
                pop     edi                     # (0)
                sub     eax, edi                # asc string length

                fldcw   [old_cw]       # restore control word

                pop	esi
                pop	edi
                pop	ebx
                pop	ebp
                ret

#::::::::::::::
ffzero:         fstp    st(0)                     # pop 0
                mov     word ptr [edi], 0x3020    # ' 0' (QB quirk)
                add     edi, 2
                jmp     ffexit

#::::::::::::::
ffnan:          fstpt	[_dt]         		# pop NaN
                shl     byte ptr [_dt+9], 1
                sbb     bl, bl                  # bl= (NaN >= 0? 0: 2)
                and     bl, 0b10                # /
                mov     ax, 0x2B31
                add     al, bl
                mov     [edi], ax
                mov     dword ptr [edi+2], 0x2E234E41 	# #.NAN (QB quirk)
                mov     byte ptr [edi+6], 'N'		# /
                add     edi, 7
                jmp     ffexit

#::::::::::::::
ffsci_notation: # f=float, m=mantissa (frac), a=exponent (int)
                # f = m * (2 ^ a)
                # m = f / (2 ^ a)
                # for decimal base: m = f / (10 ^ b)

                # calc 10 ^ b

                # x = 10 ^ b
                # lg x = lg 10 ^ b
                # lg x = b * lg 10
                # 2 ^ (b * lg 10) = x
                fldl2t                          # b*= lg 10
                fmulp   st(1), st(0)            # /

                # 2 ^ b = (2 ^ (int)b) * (2 ^ (b - (int)b))
                fld     st(0)                   # dup tos
                frndint                         # (int)b
                fsub    st(1), st(0)            # b - (int)b
                fxch
                f2xm1                           # (2 ^ (b - (int)b) - 1
                fld1                            # + 1
                faddp   st(1), st(0)            # /
                fscale                          # st(0) * (b ^ (int)b)
                fstp    st(1)                   # free

                # m= f / (10 ^ b)
                fdivp   st(1), st(0)

                # change rounding control to truncating toward 0
                or      word ptr [cur_cw], 0b110000000000
                fldcw   [cur_cw]

                # handle dizima periodica (0.9999999999 -> 1.0)
                cmp     ecx, 9
                sbb     ebx, ebx                # ebx= (cx < 9? -2: 0)
                shl     ebx, 1                  # /
                fldt    [dizima_tb+ebx*4+ebx + 10]
                faddp   st(1), st(0)

                # set last mantissa's bit (to prevent dizima to happen)
                fstpt   [_dt]
                or      byte ptr [_dt+1], 0b10
                fldt	[_dt]

                # float 2 dec
                # mantissa (integer part)
                fist    dword ptr [_int]
                mov     al, byte ptr [_int]
                test    al, al
                jnz     ffsave_int              # not zero?

                fmul    qword ptr [const_10]    # next digit
                dec     dword ptr [exp10]       # --exponent
                fist    dword ptr [_int]
                mov     al, byte ptr [_int]

ffsave_int:     add     al, '0'                 # 2 asc
                mov     [edi], al
                mov     byte ptr [edi+1], '.'
                add     edi, 2

                # mantissa (fractional part)
                mov     ebx, ecx                # ebx= number-of-digits - 1
                dec     ebx                     # /

ffloop:         fisub   dword ptr [_int]        # del digit
                fmul    qword ptr [const_10]    # next digit
                fist    dword ptr [_int]        # get digit

                mov     al, byte ptr [_int]     # /
                add     al, '0'                 # 2 asc
                mov     [edi], al
                inc     edi
                dec     ebx
                jnz     ffloop

                fstp    st(0)                   # free tos

                # delete zero(s) at right
                mov     ebx, ecx                # save number-of-digits
                mov     al, '0'
                dec     edi
                std                             # go down
                repe    scasb                   # scan while = '0'
                cld
                cmp     ecx, 1                  # all digits= '0'? del '.'
                sbb     ecx, ecx                # ecx= 2 + (ecx == 0? -1: 0)
                add     ecx, 2                  # /
                add     edi, ecx                #

ffexp:          # exponent
                mov     eax, [exp10]
                # eax= abs(eax)
                cdq
                xor     eax, edx
                sub     eax, edx

                # 'E'
                mov     byte ptr [edi], 'E'

                # sign
                and     dl, 0b10
                add     dl, '+'                 # dl= '+' or '-'
                mov     [edi+1], dl
                # bin 2 dec
                mov     ecx, 10
                cmp     eax, 99
                ja      ff3_digits              # exp > 99?

                div     cl
                add     ax, 0x3030              # '00' dec 2 asc
                mov     [edi+2], ax             # save
                add     edi, 4
                jmp     ffexit

ff3_digits:     xor     edx, edx
                div     ecx
                div     cl
                add     dl, '0'                 # dec 2 asc
                add     ax, 0x3030              # '00' /
                mov     [edi+2], ax             # save
                mov     [edi+4], dl             # /
                add     edi, 5
                jmp     ffexit
                