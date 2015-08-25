'' FreeBASIC binding for iup-3.15
''
'' based on the C header files:
''   Copyright (C) 1994-2015 Tecgraf, PUC-Rio.
''
''   Permission is hereby granted, free of charge, to any person obtaining
''   a copy of this software and associated documentation files (the
''   "Software"), to deal in the Software without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be
''   included in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

'' The following symbols have been renamed:
''     #define K_a => K_a_
''     #define K_b => K_b_
''     #define K_c => K_c_
''     #define K_d => K_d_
''     #define K_e => K_e_
''     #define K_f => K_f_
''     #define K_g => K_g_
''     #define K_h => K_h_
''     #define K_i => K_i_
''     #define K_j => K_j_
''     #define K_k => K_k_
''     #define K_l => K_l_
''     #define K_m => K_m_
''     #define K_n => K_n_
''     #define K_o => K_o_
''     #define K_p => K_p_
''     #define K_q => K_q_
''     #define K_r => K_r_
''     #define K_s => K_s_
''     #define K_t => K_t_
''     #define K_u => K_u_
''     #define K_v => K_v_
''     #define K_w => K_w_
''     #define K_x => K_x_
''     #define K_y => K_y_
''     #define K_z => K_z_
''     constant K_Ccedilla => K_Ccedilla_
''     #define K_cR => K_cR_

#define __IUPKEY_H
#define K_SP asc(" ")
#define K_exclam asc("!")
#define K_quotedbl asc("""")
#define K_numbersign asc("#")
#define K_dollar asc("$")
#define K_percent asc("%")
#define K_ampersand asc("&")
#define K_apostrophe asc("'")
#define K_parentleft asc("(")
#define K_parentright asc(")")
#define K_asterisk asc("*")
#define K_plus asc("+")
#define K_comma asc(",")
#define K_minus asc("-")
#define K_period asc(".")
#define K_slash asc("/")
#define K_0 asc("0")
#define K_1 asc("1")
#define K_2 asc("2")
#define K_3 asc("3")
#define K_4 asc("4")
#define K_5 asc("5")
#define K_6 asc("6")
#define K_7 asc("7")
#define K_8 asc("8")
#define K_9 asc("9")
#define K_colon asc(":")
#define K_semicolon asc(";")
#define K_less asc("<")
#define K_equal asc("=")
#define K_greater asc(">")
#define K_question asc("?")
#define K_at asc("@")
#define K_A asc("A")
#define K_B asc("B")
#define K_C asc("C")
#define K_D asc("D")
#define K_E asc("E")
#define K_F asc("F")
#define K_G asc("G")
#define K_H asc("H")
#define K_I asc("I")
#define K_J asc("J")
#define K_K asc("K")
#define K_L asc("L")
#define K_M asc("M")
#define K_N asc("N")
#define K_O asc("O")
#define K_P asc("P")
#define K_Q asc("Q")
#define K_R asc("R")
#define K_S asc("S")
#define K_T asc("T")
#define K_U asc("U")
#define K_V asc("V")
#define K_W asc("W")
#define K_X asc("X")
#define K_Y asc("Y")
#define K_Z asc("Z")
#define K_bracketleft asc("[")
#define K_backslash asc(!"\\")
#define K_bracketright asc("]")
#define K_circum asc("^")
#define K_underscore asc("_")
#define K_grave asc("`")
#define K_a_ asc("a")
#define K_b_ asc("b")
#define K_c_ asc("c")
#define K_d_ asc("d")
#define K_e_ asc("e")
#define K_f_ asc("f")
#define K_g_ asc("g")
#define K_h_ asc("h")
#define K_i_ asc("i")
#define K_j_ asc("j")
#define K_k_ asc("k")
#define K_l_ asc("l")
#define K_m_ asc("m")
#define K_n_ asc("n")
#define K_o_ asc("o")
#define K_p_ asc("p")
#define K_q_ asc("q")
#define K_r_ asc("r")
#define K_s_ asc("s")
#define K_t_ asc("t")
#define K_u_ asc("u")
#define K_v_ asc("v")
#define K_w_ asc("w")
#define K_x_ asc("x")
#define K_y_ asc("y")
#define K_z_ asc("z")
#define K_braceleft asc("{")
#define K_bar asc("|")
#define K_braceright asc("}")
#define K_tilde asc("~")
#define iup_isprint(_c) (((_c) > 31) andalso ((_c) < 127))
#define K_BS asc(!"\b")
#define K_TAB asc(!"\t")
#define K_LF asc(!"\n")
#define K_CR asc(!"\r")
#define K_quoteleft K_grave
#define K_quoteright K_apostrophe
#define isxkey iup_isXkey
#define iup_isXkey(_c) ((_c) >= 128)
const K_PAUSE = &hFF13
const K_ESC = &hFF1B
const K_HOME = &hFF50
const K_LEFT = &hFF51
const K_UP = &hFF52
const K_RIGHT = &hFF53
const K_DOWN = &hFF54
const K_PGUP = &hFF55
const K_PGDN = &hFF56
const K_END = &hFF57
const K_MIDDLE = &hFF0B
const K_Print = &hFF61
const K_INS = &hFF63
const K_Menu = &hFF67
const K_DEL = &hFFFF
const K_F1 = &hFFBE
const K_F2 = &hFFBF
const K_F3 = &hFFC0
const K_F4 = &hFFC1
const K_F5 = &hFFC2
const K_F6 = &hFFC3
const K_F7 = &hFFC4
const K_F8 = &hFFC5
const K_F9 = &hFFC6
const K_F10 = &hFFC7
const K_F11 = &hFFC8
const K_F12 = &hFFC9
const K_LSHIFT = &hFFE1
const K_RSHIFT = &hFFE2
const K_LCTRL = &hFFE3
const K_RCTRL = &hFFE4
const K_LALT = &hFFE9
const K_RALT = &hFFEA
const K_NUM = &hFF7F
const K_SCROLL = &hFF14
const K_CAPS = &hFFE5
const K_ccedilla = &h00E7
const K_Ccedilla_ = &h00C7
const K_acute = &h00B4
const K_diaeresis = &h00A8
#define iup_isShiftXkey(_c) ((_c) and &h10000000)
#define iup_isCtrlXkey(_c) ((_c) and &h20000000)
#define iup_isAltXkey(_c) ((_c) and &h40000000)
#define iup_isSysXkey(_c) ((_c) and &h80000000)
#define iup_XkeyBase(_c) ((_c) and &h0FFFFFFF)
#define iup_XkeyShift(_c) ((_c) or &h10000000)
#define iup_XkeyCtrl(_c) ((_c) or &h20000000)
#define iup_XkeyAlt(_c) ((_c) or &h40000000)
#define iup_XkeySys(_c) ((_c) or &h80000000)
#define K_sHOME iup_XkeyShift(K_HOME)
#define K_sUP iup_XkeyShift(K_UP)
#define K_sPGUP iup_XkeyShift(K_PGUP)
#define K_sLEFT iup_XkeyShift(K_LEFT)
#define K_sMIDDLE iup_XkeyShift(K_MIDDLE)
#define K_sRIGHT iup_XkeyShift(K_RIGHT)
#define K_sEND iup_XkeyShift(K_END)
#define K_sDOWN iup_XkeyShift(K_DOWN)
#define K_sPGDN iup_XkeyShift(K_PGDN)
#define K_sINS iup_XkeyShift(K_INS)
#define K_sDEL iup_XkeyShift(K_DEL)
#define K_sSP iup_XkeyShift(K_SP)
#define K_sTAB iup_XkeyShift(K_TAB)
#define K_sCR iup_XkeyShift(K_CR)
#define K_sBS iup_XkeyShift(K_BS)
#define K_sPAUSE iup_XkeyShift(K_PAUSE)
#define K_sESC iup_XkeyShift(K_ESC)
#define K_sF1 iup_XkeyShift(K_F1)
#define K_sF2 iup_XkeyShift(K_F2)
#define K_sF3 iup_XkeyShift(K_F3)
#define K_sF4 iup_XkeyShift(K_F4)
#define K_sF5 iup_XkeyShift(K_F5)
#define K_sF6 iup_XkeyShift(K_F6)
#define K_sF7 iup_XkeyShift(K_F7)
#define K_sF8 iup_XkeyShift(K_F8)
#define K_sF9 iup_XkeyShift(K_F9)
#define K_sF10 iup_XkeyShift(K_F10)
#define K_sF11 iup_XkeyShift(K_F11)
#define K_sF12 iup_XkeyShift(K_F12)
#define K_sPrint iup_XkeyShift(K_Print)
#define K_sMenu iup_XkeyShift(K_Menu)
#define K_cHOME iup_XkeyCtrl(K_HOME)
#define K_cUP iup_XkeyCtrl(K_UP)
#define K_cPGUP iup_XkeyCtrl(K_PGUP)
#define K_cLEFT iup_XkeyCtrl(K_LEFT)
#define K_cMIDDLE iup_XkeyCtrl(K_MIDDLE)
#define K_cRIGHT iup_XkeyCtrl(K_RIGHT)
#define K_cEND iup_XkeyCtrl(K_END)
#define K_cDOWN iup_XkeyCtrl(K_DOWN)
#define K_cPGDN iup_XkeyCtrl(K_PGDN)
#define K_cINS iup_XkeyCtrl(K_INS)
#define K_cDEL iup_XkeyCtrl(K_DEL)
#define K_cSP iup_XkeyCtrl(K_SP)
#define K_cTAB iup_XkeyCtrl(K_TAB)
#define K_cCR iup_XkeyCtrl(K_CR)
#define K_cBS iup_XkeyCtrl(K_BS)
#define K_cPAUSE iup_XkeyCtrl(K_PAUSE)
#define K_cESC iup_XkeyCtrl(K_ESC)
#define K_cCcedilla iup_XkeyCtrl(K_Ccedilla_)
#define K_cF1 iup_XkeyCtrl(K_F1)
#define K_cF2 iup_XkeyCtrl(K_F2)
#define K_cF3 iup_XkeyCtrl(K_F3)
#define K_cF4 iup_XkeyCtrl(K_F4)
#define K_cF5 iup_XkeyCtrl(K_F5)
#define K_cF6 iup_XkeyCtrl(K_F6)
#define K_cF7 iup_XkeyCtrl(K_F7)
#define K_cF8 iup_XkeyCtrl(K_F8)
#define K_cF9 iup_XkeyCtrl(K_F9)
#define K_cF10 iup_XkeyCtrl(K_F10)
#define K_cF11 iup_XkeyCtrl(K_F11)
#define K_cF12 iup_XkeyCtrl(K_F12)
#define K_cPrint iup_XkeyCtrl(K_Print)
#define K_cMenu iup_XkeyCtrl(K_Menu)
#define K_mHOME iup_XkeyAlt(K_HOME)
#define K_mUP iup_XkeyAlt(K_UP)
#define K_mPGUP iup_XkeyAlt(K_PGUP)
#define K_mLEFT iup_XkeyAlt(K_LEFT)
#define K_mMIDDLE iup_XkeyAlt(K_MIDDLE)
#define K_mRIGHT iup_XkeyAlt(K_RIGHT)
#define K_mEND iup_XkeyAlt(K_END)
#define K_mDOWN iup_XkeyAlt(K_DOWN)
#define K_mPGDN iup_XkeyAlt(K_PGDN)
#define K_mINS iup_XkeyAlt(K_INS)
#define K_mDEL iup_XkeyAlt(K_DEL)
#define K_mSP iup_XkeyAlt(K_SP)
#define K_mTAB iup_XkeyAlt(K_TAB)
#define K_mCR iup_XkeyAlt(K_CR)
#define K_mBS iup_XkeyAlt(K_BS)
#define K_mPAUSE iup_XkeyAlt(K_PAUSE)
#define K_mESC iup_XkeyAlt(K_ESC)
#define K_mCcedilla iup_XkeyAlt(K_Ccedilla_)
#define K_mF1 iup_XkeyAlt(K_F1)
#define K_mF2 iup_XkeyAlt(K_F2)
#define K_mF3 iup_XkeyAlt(K_F3)
#define K_mF4 iup_XkeyAlt(K_F4)
#define K_mF5 iup_XkeyAlt(K_F5)
#define K_mF6 iup_XkeyAlt(K_F6)
#define K_mF7 iup_XkeyAlt(K_F7)
#define K_mF8 iup_XkeyAlt(K_F8)
#define K_mF9 iup_XkeyAlt(K_F9)
#define K_mF10 iup_XkeyAlt(K_F10)
#define K_mF11 iup_XkeyAlt(K_F11)
#define K_mF12 iup_XkeyAlt(K_F12)
#define K_mPrint iup_XkeyAlt(K_Print)
#define K_mMenu iup_XkeyAlt(K_Menu)
#define K_yHOME iup_XkeySys(K_HOME)
#define K_yUP iup_XkeySys(K_UP)
#define K_yPGUP iup_XkeySys(K_PGUP)
#define K_yLEFT iup_XkeySys(K_LEFT)
#define K_yMIDDLE iup_XkeySys(K_MIDDLE)
#define K_yRIGHT iup_XkeySys(K_RIGHT)
#define K_yEND iup_XkeySys(K_END)
#define K_yDOWN iup_XkeySys(K_DOWN)
#define K_yPGDN iup_XkeySys(K_PGDN)
#define K_yINS iup_XkeySys(K_INS)
#define K_yDEL iup_XkeySys(K_DEL)
#define K_ySP iup_XkeySys(K_SP)
#define K_yTAB iup_XkeySys(K_TAB)
#define K_yCR iup_XkeySys(K_CR)
#define K_yBS iup_XkeySys(K_BS)
#define K_yPAUSE iup_XkeySys(K_PAUSE)
#define K_yESC iup_XkeySys(K_ESC)
#define K_yCcedilla iup_XkeySys(K_Ccedilla_)
#define K_yF1 iup_XkeySys(K_F1)
#define K_yF2 iup_XkeySys(K_F2)
#define K_yF3 iup_XkeySys(K_F3)
#define K_yF4 iup_XkeySys(K_F4)
#define K_yF5 iup_XkeySys(K_F5)
#define K_yF6 iup_XkeySys(K_F6)
#define K_yF7 iup_XkeySys(K_F7)
#define K_yF8 iup_XkeySys(K_F8)
#define K_yF9 iup_XkeySys(K_F9)
#define K_yF10 iup_XkeySys(K_F10)
#define K_yF11 iup_XkeySys(K_F11)
#define K_yF12 iup_XkeySys(K_F12)
#define K_yPrint iup_XkeySys(K_Print)
#define K_yMenu iup_XkeySys(K_Menu)
#define K_sPlus iup_XkeyShift(K_plus)
#define K_sComma iup_XkeyShift(K_comma)
#define K_sMinus iup_XkeyShift(K_minus)
#define K_sPeriod iup_XkeyShift(K_period)
#define K_sSlash iup_XkeyShift(K_slash)
#define K_sAsterisk iup_XkeyShift(K_asterisk)
#define K_cA iup_XkeyCtrl(K_A)
#define K_cB iup_XkeyCtrl(K_B)
#define K_cC iup_XkeyCtrl(K_C)
#define K_cD iup_XkeyCtrl(K_D)
#define K_cE iup_XkeyCtrl(K_E)
#define K_cF iup_XkeyCtrl(K_F)
#define K_cG iup_XkeyCtrl(K_G)
#define K_cH iup_XkeyCtrl(K_H)
#define K_cI iup_XkeyCtrl(K_I)
#define K_cJ iup_XkeyCtrl(K_J)
#define K_cK iup_XkeyCtrl(K_K)
#define K_cL iup_XkeyCtrl(K_L)
#define K_cM iup_XkeyCtrl(K_M)
#define K_cN iup_XkeyCtrl(K_N)
#define K_cO iup_XkeyCtrl(K_O)
#define K_cP iup_XkeyCtrl(K_P)
#define K_cQ iup_XkeyCtrl(K_Q)
#define K_cR_ iup_XkeyCtrl(K_R)
#define K_cS iup_XkeyCtrl(K_S)
#define K_cT iup_XkeyCtrl(K_T)
#define K_cU iup_XkeyCtrl(K_U)
#define K_cV iup_XkeyCtrl(K_V)
#define K_cW iup_XkeyCtrl(K_W)
#define K_cX iup_XkeyCtrl(K_X)
#define K_cY iup_XkeyCtrl(K_Y)
#define K_cZ iup_XkeyCtrl(K_Z)
#define K_c1 iup_XkeyCtrl(K_1)
#define K_c2 iup_XkeyCtrl(K_2)
#define K_c3 iup_XkeyCtrl(K_3)
#define K_c4 iup_XkeyCtrl(K_4)
#define K_c5 iup_XkeyCtrl(K_5)
#define K_c6 iup_XkeyCtrl(K_6)
#define K_c7 iup_XkeyCtrl(K_7)
#define K_c8 iup_XkeyCtrl(K_8)
#define K_c9 iup_XkeyCtrl(K_9)
#define K_c0 iup_XkeyCtrl(K_0)
#define K_cPlus iup_XkeyCtrl(K_plus)
#define K_cComma iup_XkeyCtrl(K_comma)
#define K_cMinus iup_XkeyCtrl(K_minus)
#define K_cPeriod iup_XkeyCtrl(K_period)
#define K_cSlash iup_XkeyCtrl(K_slash)
#define K_cSemicolon iup_XkeyCtrl(K_semicolon)
#define K_cEqual iup_XkeyCtrl(K_equal)
#define K_cBracketleft iup_XkeyCtrl(K_bracketleft)
#define K_cBracketright iup_XkeyCtrl(K_bracketright)
#define K_cBackslash iup_XkeyCtrl(K_backslash)
#define K_cAsterisk iup_XkeyCtrl(K_asterisk)
#define K_mA iup_XkeyAlt(K_A)
#define K_mB iup_XkeyAlt(K_B)
#define K_mC iup_XkeyAlt(K_C)
#define K_mD iup_XkeyAlt(K_D)
#define K_mE iup_XkeyAlt(K_E)
#define K_mF iup_XkeyAlt(K_F)
#define K_mG iup_XkeyAlt(K_G)
#define K_mH iup_XkeyAlt(K_H)
#define K_mI iup_XkeyAlt(K_I)
#define K_mJ iup_XkeyAlt(K_J)
#define K_mK iup_XkeyAlt(K_K)
#define K_mL iup_XkeyAlt(K_L)
#define K_mM iup_XkeyAlt(K_M)
#define K_mN iup_XkeyAlt(K_N)
#define K_mO iup_XkeyAlt(K_O)
#define K_mP iup_XkeyAlt(K_P)
#define K_mQ iup_XkeyAlt(K_Q)
#define K_mR iup_XkeyAlt(K_R)
#define K_mS iup_XkeyAlt(K_S)
#define K_mT iup_XkeyAlt(K_T)
#define K_mU iup_XkeyAlt(K_U)
#define K_mV iup_XkeyAlt(K_V)
#define K_mW iup_XkeyAlt(K_W)
#define K_mX iup_XkeyAlt(K_X)
#define K_mY iup_XkeyAlt(K_Y)
#define K_mZ iup_XkeyAlt(K_Z)
#define K_m1 iup_XkeyAlt(K_1)
#define K_m2 iup_XkeyAlt(K_2)
#define K_m3 iup_XkeyAlt(K_3)
#define K_m4 iup_XkeyAlt(K_4)
#define K_m5 iup_XkeyAlt(K_5)
#define K_m6 iup_XkeyAlt(K_6)
#define K_m7 iup_XkeyAlt(K_7)
#define K_m8 iup_XkeyAlt(K_8)
#define K_m9 iup_XkeyAlt(K_9)
#define K_m0 iup_XkeyAlt(K_0)
#define K_mPlus iup_XkeyAlt(K_plus)
#define K_mComma iup_XkeyAlt(K_comma)
#define K_mMinus iup_XkeyAlt(K_minus)
#define K_mPeriod iup_XkeyAlt(K_period)
#define K_mSlash iup_XkeyAlt(K_slash)
#define K_mSemicolon iup_XkeyAlt(K_semicolon)
#define K_mEqual iup_XkeyAlt(K_equal)
#define K_mBracketleft iup_XkeyAlt(K_bracketleft)
#define K_mBracketright iup_XkeyAlt(K_bracketright)
#define K_mBackslash iup_XkeyAlt(K_backslash)
#define K_mAsterisk iup_XkeyAlt(K_asterisk)
#define K_yA iup_XkeySys(K_A)
#define K_yB iup_XkeySys(K_B)
#define K_yC iup_XkeySys(K_C)
#define K_yD iup_XkeySys(K_D)
#define K_yE iup_XkeySys(K_E)
#define K_yF iup_XkeySys(K_F)
#define K_yG iup_XkeySys(K_G)
#define K_yH iup_XkeySys(K_H)
#define K_yI iup_XkeySys(K_I)
#define K_yJ iup_XkeySys(K_J)
#define K_yK iup_XkeySys(K_K)
#define K_yL iup_XkeySys(K_L)
#define K_yM iup_XkeySys(K_M)
#define K_yN iup_XkeySys(K_N)
#define K_yO iup_XkeySys(K_O)
#define K_yP iup_XkeySys(K_P)
#define K_yQ iup_XkeySys(K_Q)
#define K_yR iup_XkeySys(K_R)
#define K_yS iup_XkeySys(K_S)
#define K_yT iup_XkeySys(K_T)
#define K_yU iup_XkeySys(K_U)
#define K_yV iup_XkeySys(K_V)
#define K_yW iup_XkeySys(K_W)
#define K_yX iup_XkeySys(K_X)
#define K_yY iup_XkeySys(K_Y)
#define K_yZ iup_XkeySys(K_Z)
#define K_y1 iup_XkeySys(K_1)
#define K_y2 iup_XkeySys(K_2)
#define K_y3 iup_XkeySys(K_3)
#define K_y4 iup_XkeySys(K_4)
#define K_y5 iup_XkeySys(K_5)
#define K_y6 iup_XkeySys(K_6)
#define K_y7 iup_XkeySys(K_7)
#define K_y8 iup_XkeySys(K_8)
#define K_y9 iup_XkeySys(K_9)
#define K_y0 iup_XkeySys(K_0)
#define K_yPlus iup_XkeySys(K_plus)
#define K_yComma iup_XkeySys(K_comma)
#define K_yMinus iup_XkeySys(K_minus)
#define K_yPeriod iup_XkeySys(K_period)
#define K_ySlash iup_XkeySys(K_slash)
#define K_ySemicolon iup_XkeySys(K_semicolon)
#define K_yEqual iup_XkeySys(K_equal)
#define K_yBracketleft iup_XkeySys(K_bracketleft)
#define K_yBracketright iup_XkeySys(K_bracketright)
#define K_yBackslash iup_XkeySys(K_backslash)
#define K_yAsterisk iup_XkeySys(K_asterisk)
