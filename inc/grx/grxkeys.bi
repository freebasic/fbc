'' FreeBASIC binding for GRX 2.4.9
''
'' based on the C header files:
''
''   * grxkeys.h ---- platform independent key definitions
''   *
''   * Copyright (c) 1997 Hartmut Schirmer
''   *
''   * This file is part of the GRX graphics library.
''   *
''   * The GRX graphics library is free software; you can redistribute it
''   * and/or modify it under some conditions; see the "copying.grx" file
''   * for details.
''   *
''   * This library is distributed in the hope that it will be useful,
''   * but WITHOUT ANY WARRANTY; without even the implied warranty of
''   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''   *
''
''
''   Source code with the above copyright is distributed under the following terms:
''
''    (1) The test programs for the graphics library (code in the 'test'
''        sub-directory) is distributed without restrictions. This code
''        is free for use in commercial, shareware or freeware applications.
''
''    (2) The GRX graphics library is distributed under the terms of the
''        GNU LGPL (Library General Public License) with the following amendments
''        and/or exceptions:
''
''        -  Using the DOS versions (DOS only! this exception DOES NOT apply to
''   	the Linux version) you are permitted to distribute an application
''   	linked with GRX in binary only, provided that the documentation
''   	of the program:
''
''   	   a)	informs the user that GRX is used in the program, AND
''
''   	   b)	provides the user with the necessary information about
''   		how to obtain GRX. (i.e. ftp site, etc..)
''
''    (3) Fonts (in the 'fonts' sub-directory). Most of the fonts included with
''        the GRX library were derived from fonts in the MIT X11R4 distribution.
''        They are distributed according to the terms in the file "COPYING.MIT"
''        (X license). Exceptions are:
''        - The fonts "ter-114b.res", "ter-114n.fna" and "ter-114v.psf" are
''          Copyright (C) 2002 Dimitar Zhekov, but are distributed under the
''          X license too.
''        - The "pc" BIOS font family, which is distributed without restrictions.
''
''   A copy of the GNU GPL (in the file "COPYING") and the GNU LGPL (in
''   the file "COPYING.LIB") is included with this document. If you did
''   not receive a copy of "COPYING" or "COPYING.LIB", you may obtain one 
''   from where this document was obtained, or by writing to:
''
''     Free Software Foundation
''     675 Mass Ave
''     Cambridge, MA 02139
''     USA
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

'' The following symbols have been renamed:
''     constant GrKey_a => GrKey_a_
''     constant GrKey_b => GrKey_b_
''     constant GrKey_c => GrKey_c_
''     constant GrKey_d => GrKey_d_
''     constant GrKey_e => GrKey_e_
''     constant GrKey_f => GrKey_f_
''     constant GrKey_g => GrKey_g_
''     constant GrKey_h => GrKey_h_
''     constant GrKey_i => GrKey_i_
''     constant GrKey_j => GrKey_j_
''     constant GrKey_k => GrKey_k_
''     constant GrKey_l => GrKey_l_
''     constant GrKey_m => GrKey_m_
''     constant GrKey_n => GrKey_n_
''     constant GrKey_o => GrKey_o_
''     constant GrKey_p => GrKey_p_
''     constant GrKey_q => GrKey_q_
''     constant GrKey_r => GrKey_r_
''     constant GrKey_s => GrKey_s_
''     constant GrKey_t => GrKey_t_
''     constant GrKey_u => GrKey_u_
''     constant GrKey_v => GrKey_v_
''     constant GrKey_w => GrKey_w_
''     constant GrKey_x => GrKey_x_
''     constant GrKey_y => GrKey_y_
''     constant GrKey_z => GrKey_z_

extern "C"

#define __GRKEYS_H_INCLUDED__
type GrKeyType as ushort
const GrKey_NoKey = &h0000
const GrKey_OutsideValidRange = &h0100
const GrKey_Control_A = &h0001
const GrKey_Control_B = &h0002
const GrKey_Control_C = &h0003
const GrKey_Control_D = &h0004
const GrKey_Control_E = &h0005
const GrKey_Control_F = &h0006
const GrKey_Control_G = &h0007
const GrKey_Control_H = &h0008
const GrKey_Control_I = &h0009
const GrKey_Control_J = &h000a
const GrKey_Control_K = &h000b
const GrKey_Control_L = &h000c
const GrKey_Control_M = &h000d
const GrKey_Control_N = &h000e
const GrKey_Control_O = &h000f
const GrKey_Control_P = &h0010
const GrKey_Control_Q = &h0011
const GrKey_Control_R = &h0012
const GrKey_Control_S = &h0013
const GrKey_Control_T = &h0014
const GrKey_Control_U = &h0015
const GrKey_Control_V = &h0016
const GrKey_Control_W = &h0017
const GrKey_Control_X = &h0018
const GrKey_Control_Y = &h0019
const GrKey_Control_Z = &h001a
const GrKey_Control_LBracket = &h001b
const GrKey_Control_BackSlash = &h001c
const GrKey_Control_RBracket = &h001d
const GrKey_Control_Caret = &h001e
const GrKey_Control_Underscore = &h001f
const GrKey_Space = &h0020
const GrKey_ExclamationPoint = &h0021
const GrKey_DoubleQuote = &h0022
const GrKey_Hash = &h0023
const GrKey_Dollar = &h0024
const GrKey_Percent = &h0025
const GrKey_Ampersand = &h0026
const GrKey_Quote = &h0027
const GrKey_LParen = &h0028
const GrKey_RParen = &h0029
const GrKey_Star = &h002a
const GrKey_Plus = &h002b
const GrKey_Comma = &h002c
const GrKey_Dash = &h002d
const GrKey_Period = &h002e
const GrKey_Slash = &h002f
const GrKey_0 = &h0030
const GrKey_1 = &h0031
const GrKey_2 = &h0032
const GrKey_3 = &h0033
const GrKey_4 = &h0034
const GrKey_5 = &h0035
const GrKey_6 = &h0036
const GrKey_7 = &h0037
const GrKey_8 = &h0038
const GrKey_9 = &h0039
const GrKey_Colon = &h003a
const GrKey_SemiColon = &h003b
const GrKey_LAngle = &h003c
const GrKey_Equals = &h003d
const GrKey_RAngle = &h003e
const GrKey_QuestionMark = &h003f
const GrKey_At = &h0040
const GrKey_A = &h0041
const GrKey_B = &h0042
const GrKey_C = &h0043
const GrKey_D = &h0044
const GrKey_E = &h0045
const GrKey_F = &h0046
const GrKey_G = &h0047
const GrKey_H = &h0048
const GrKey_I = &h0049
const GrKey_J = &h004a
const GrKey_K = &h004b
const GrKey_L = &h004c
const GrKey_M = &h004d
const GrKey_N = &h004e
const GrKey_O = &h004f
const GrKey_P = &h0050
const GrKey_Q = &h0051
const GrKey_R = &h0052
const GrKey_S = &h0053
const GrKey_T = &h0054
const GrKey_U = &h0055
const GrKey_V = &h0056
const GrKey_W = &h0057
const GrKey_X = &h0058
const GrKey_Y = &h0059
const GrKey_Z = &h005a
const GrKey_LBracket = &h005b
const GrKey_BackSlash = &h005c
const GrKey_RBracket = &h005d
const GrKey_Caret = &h005e
const GrKey_UnderScore = &h005f
const GrKey_BackQuote = &h0060
const GrKey_a_ = &h0061
const GrKey_b_ = &h0062
const GrKey_c_ = &h0063
const GrKey_d_ = &h0064
const GrKey_e_ = &h0065
const GrKey_f_ = &h0066
const GrKey_g_ = &h0067
const GrKey_h_ = &h0068
const GrKey_i_ = &h0069
const GrKey_j_ = &h006a
const GrKey_k_ = &h006b
const GrKey_l_ = &h006c
const GrKey_m_ = &h006d
const GrKey_n_ = &h006e
const GrKey_o_ = &h006f
const GrKey_p_ = &h0070
const GrKey_q_ = &h0071
const GrKey_r_ = &h0072
const GrKey_s_ = &h0073
const GrKey_t_ = &h0074
const GrKey_u_ = &h0075
const GrKey_v_ = &h0076
const GrKey_w_ = &h0077
const GrKey_x_ = &h0078
const GrKey_y_ = &h0079
const GrKey_z_ = &h007a
const GrKey_LBrace = &h007b
const GrKey_Pipe = &h007c
const GrKey_RBrace = &h007d
const GrKey_Tilde = &h007e
const GrKey_Control_Backspace = &h007f
const GrKey_Alt_Escape = &h0101
const GrKey_Control_At = &h0103
const GrKey_Alt_Backspace = &h010e
const GrKey_BackTab = &h010f
const GrKey_Alt_Q = &h0110
const GrKey_Alt_W = &h0111
const GrKey_Alt_E = &h0112
const GrKey_Alt_R = &h0113
const GrKey_Alt_T = &h0114
const GrKey_Alt_Y = &h0115
const GrKey_Alt_U = &h0116
const GrKey_Alt_I = &h0117
const GrKey_Alt_O = &h0118
const GrKey_Alt_P = &h0119
const GrKey_Alt_LBracket = &h011a
const GrKey_Alt_RBracket = &h011b
const GrKey_Alt_Return = &h011c
const GrKey_Alt_A = &h011e
const GrKey_Alt_S = &h011f
const GrKey_Alt_D = &h0120
const GrKey_Alt_F = &h0121
const GrKey_Alt_G = &h0122
const GrKey_Alt_H = &h0123
const GrKey_Alt_J = &h0124
const GrKey_Alt_K = &h0125
const GrKey_Alt_L = &h0126
const GrKey_Alt_Semicolon = &h0127
const GrKey_Alt_Quote = &h0128
const GrKey_Alt_Backquote = &h0129
const GrKey_Alt_Backslash = &h012b
const GrKey_Alt_Z = &h012c
const GrKey_Alt_X = &h012d
const GrKey_Alt_C = &h012e
const GrKey_Alt_V = &h012f
const GrKey_Alt_B = &h0130
const GrKey_Alt_N = &h0131
const GrKey_Alt_M = &h0132
const GrKey_Alt_Comma = &h0133
const GrKey_Alt_Period = &h0134
const GrKey_Alt_Slash = &h0135
const GrKey_Alt_KPStar = &h0137
const GrKey_F1 = &h013b
const GrKey_F2 = &h013c
const GrKey_F3 = &h013d
const GrKey_F4 = &h013e
const GrKey_F5 = &h013f
const GrKey_F6 = &h0140
const GrKey_F7 = &h0141
const GrKey_F8 = &h0142
const GrKey_F9 = &h0143
const GrKey_F10 = &h0144
const GrKey_Home = &h0147
const GrKey_Up = &h0148
const GrKey_PageUp = &h0149
const GrKey_Alt_KPMinus = &h014a
const GrKey_Left = &h014b
const GrKey_Center = &h014c
const GrKey_Right = &h014d
const GrKey_Alt_KPPlus = &h014e
const GrKey_End = &h014f
const GrKey_Down = &h0150
const GrKey_PageDown = &h0151
const GrKey_Insert = &h0152
const GrKey_Delete = &h0153
const GrKey_Shift_F1 = &h0154
const GrKey_Shift_F2 = &h0155
const GrKey_Shift_F3 = &h0156
const GrKey_Shift_F4 = &h0157
const GrKey_Shift_F5 = &h0158
const GrKey_Shift_F6 = &h0159
const GrKey_Shift_F7 = &h015a
const GrKey_Shift_F8 = &h015b
const GrKey_Shift_F9 = &h015c
const GrKey_Shift_F10 = &h015d
const GrKey_Control_F1 = &h015e
const GrKey_Control_F2 = &h015f
const GrKey_Control_F3 = &h0160
const GrKey_Control_F4 = &h0161
const GrKey_Control_F5 = &h0162
const GrKey_Control_F6 = &h0163
const GrKey_Control_F7 = &h0164
const GrKey_Control_F8 = &h0165
const GrKey_Control_F9 = &h0166
const GrKey_Control_F10 = &h0167
const GrKey_Alt_F1 = &h0168
const GrKey_Alt_F2 = &h0169
const GrKey_Alt_F3 = &h016a
const GrKey_Alt_F4 = &h016b
const GrKey_Alt_F5 = &h016c
const GrKey_Alt_F6 = &h016d
const GrKey_Alt_F7 = &h016e
const GrKey_Alt_F8 = &h016f
const GrKey_Alt_F9 = &h0170
const GrKey_Alt_F10 = &h0171
const GrKey_Control_Print = &h0172
const GrKey_Control_Left = &h0173
const GrKey_Control_Right = &h0174
const GrKey_Control_End = &h0175
const GrKey_Control_PageDown = &h0176
const GrKey_Control_Home = &h0177
const GrKey_Alt_1 = &h0178
const GrKey_Alt_2 = &h0179
const GrKey_Alt_3 = &h017a
const GrKey_Alt_4 = &h017b
const GrKey_Alt_5 = &h017c
const GrKey_Alt_6 = &h017d
const GrKey_Alt_7 = &h017e
const GrKey_Alt_8 = &h017f
const GrKey_Alt_9 = &h0180
const GrKey_Alt_0 = &h0181
const GrKey_Alt_Dash = &h0182
const GrKey_Alt_Equals = &h0183
const GrKey_Control_PageUp = &h0184
const GrKey_F11 = &h0185
const GrKey_F12 = &h0186
const GrKey_Shift_F11 = &h0187
const GrKey_Shift_F12 = &h0188
const GrKey_Control_F11 = &h0189
const GrKey_Control_F12 = &h018a
const GrKey_Alt_F11 = &h018b
const GrKey_Alt_F12 = &h018c
const GrKey_Control_Up = &h018d
const GrKey_Control_KPDash = &h018e
const GrKey_Control_Center = &h018f
const GrKey_Control_KPPlus = &h0190
const GrKey_Control_Down = &h0191
const GrKey_Control_Insert = &h0192
const GrKey_Control_Delete = &h0193
const GrKey_Control_Tab = &h0194
const GrKey_Control_KPSlash = &h0195
const GrKey_Control_KPStar = &h0196
const GrKey_Alt_KPSlash = &h01a4
const GrKey_Alt_Tab = &h01a5
const GrKey_Alt_Enter = &h01a6
const GrKey_Alt_LAngle = &h01b0
const GrKey_Alt_RAngle = &h01b1
const GrKey_Alt_At = &h01b2
const GrKey_Alt_LBrace = &h01b3
const GrKey_Alt_Pipe = &h01b4
const GrKey_Alt_RBrace = &h01b5
const GrKey_Print = &h01b6
const GrKey_Shift_Insert = &h01b7
const GrKey_Shift_Home = &h01b8
const GrKey_Shift_End = &h01b9
const GrKey_Shift_PageUp = &h01ba
const GrKey_Shift_PageDown = &h01bb
const GrKey_Alt_Up = &h01bc
const GrKey_Alt_Left = &h01bd
const GrKey_Alt_Center = &h01be
const GrKey_Alt_Right = &h01c0
const GrKey_Alt_Down = &h01c1
const GrKey_Alt_Insert = &h01c2
const GrKey_Alt_Delete = &h01c3
const GrKey_Alt_Home = &h01c4
const GrKey_Alt_End = &h01c5
const GrKey_Alt_PageUp = &h01c6
const GrKey_Alt_PageDown = &h01c7
const GrKey_Shift_Up = &h01c8
const GrKey_Shift_Down = &h01c9
const GrKey_Shift_Right = &h01ca
const GrKey_Shift_Left = &h01cb
const GrKey_LastDefinedKeycode = GrKey_Shift_Left
const GrKey_BackSpace = GrKey_Control_H
const GrKey_Tab = GrKey_Control_I
const GrKey_LineFeed = GrKey_Control_J
const GrKey_Escape = GrKey_Control_LBracket
const GrKey_Return = GrKey_Control_M

declare function GrKeyPressed() as long
declare function GrKeyRead() as GrKeyType
declare function GrKeyStat() as long

end extern
