'' FreeBASIC binding for gtk+-3.16.6
''
'' based on the C header files:
''   GDK - The GIMP Drawing Kit
''   Copyright (C) 1995-1997 Peter Mattis, Spencer Kimball and Josh MacDonald
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library. If not, see <http://www.gnu.org/licenses/>.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "gdk-3"

#include once "crt/long.bi"
#include once "glib.bi"
#include once "gio/gio.bi"
#include once "pango/pango.bi"
#include once "glib-object.bi"
#include once "cairo/cairo.bi"
#include once "gdk-pixbuf/gdk-pixbuf.bi"
#include once "pango/pangocairo.bi"

'' The following symbols have been renamed:
''     constant GDK_DRAG_MOTION => GDK_DRAG_MOTION_
''     constant GDK_DRAG_STATUS => GDK_DRAG_STATUS_
''     constant GDK_PROPERTY_DELETE => GDK_PROPERTY_DELETE_
''     constant GDK_KEY_dead_A => GDK_KEY_dead_A_
''     constant GDK_KEY_dead_E => GDK_KEY_dead_E_
''     constant GDK_KEY_dead_I => GDK_KEY_dead_I_
''     constant GDK_KEY_dead_O => GDK_KEY_dead_O_
''     constant GDK_KEY_dead_U => GDK_KEY_dead_U_
''     constant GDK_KEY_Ch => GDK_KEY_Ch_
''     constant GDK_KEY_CH => GDK_KEY_CH__
''     constant GDK_KEY_C_h => GDK_KEY_C_h_
''     constant GDK_KEY_C_H => GDK_KEY_C_H__
''     constant GDK_KEY_A => GDK_KEY_A_
''     constant GDK_KEY_B => GDK_KEY_B_
''     constant GDK_KEY_C => GDK_KEY_C_
''     constant GDK_KEY_D => GDK_KEY_D_
''     constant GDK_KEY_E => GDK_KEY_E_
''     constant GDK_KEY_F => GDK_KEY_F_
''     constant GDK_KEY_G => GDK_KEY_G_
''     constant GDK_KEY_H => GDK_KEY_H_
''     constant GDK_KEY_I => GDK_KEY_I_
''     constant GDK_KEY_J => GDK_KEY_J_
''     constant GDK_KEY_K => GDK_KEY_K_
''     constant GDK_KEY_L => GDK_KEY_L_
''     constant GDK_KEY_M => GDK_KEY_M_
''     constant GDK_KEY_N => GDK_KEY_N_
''     constant GDK_KEY_O => GDK_KEY_O_
''     constant GDK_KEY_P => GDK_KEY_P_
''     constant GDK_KEY_Q => GDK_KEY_Q_
''     constant GDK_KEY_R => GDK_KEY_R_
''     constant GDK_KEY_S => GDK_KEY_S_
''     constant GDK_KEY_T => GDK_KEY_T_
''     constant GDK_KEY_U => GDK_KEY_U_
''     constant GDK_KEY_V => GDK_KEY_V_
''     constant GDK_KEY_W => GDK_KEY_W_
''     constant GDK_KEY_X => GDK_KEY_X_
''     constant GDK_KEY_Y => GDK_KEY_Y_
''     constant GDK_KEY_Z => GDK_KEY_Z_
''     constant GDK_KEY_Agrave => GDK_KEY_Agrave_
''     constant GDK_KEY_Aacute => GDK_KEY_Aacute_
''     constant GDK_KEY_Acircumflex => GDK_KEY_Acircumflex_
''     constant GDK_KEY_Atilde => GDK_KEY_Atilde_
''     constant GDK_KEY_Adiaeresis => GDK_KEY_Adiaeresis_
''     constant GDK_KEY_Aring => GDK_KEY_Aring_
''     constant GDK_KEY_AE => GDK_KEY_AE_
''     constant GDK_KEY_Ccedilla => GDK_KEY_Ccedilla_
''     constant GDK_KEY_Egrave => GDK_KEY_Egrave_
''     constant GDK_KEY_Eacute => GDK_KEY_Eacute_
''     constant GDK_KEY_Ecircumflex => GDK_KEY_Ecircumflex_
''     constant GDK_KEY_Ediaeresis => GDK_KEY_Ediaeresis_
''     constant GDK_KEY_Igrave => GDK_KEY_Igrave_
''     constant GDK_KEY_Iacute => GDK_KEY_Iacute_
''     constant GDK_KEY_Icircumflex => GDK_KEY_Icircumflex_
''     constant GDK_KEY_Idiaeresis => GDK_KEY_Idiaeresis_
''     constant GDK_KEY_Eth => GDK_KEY_Eth_
''     constant GDK_KEY_Ntilde => GDK_KEY_Ntilde_
''     constant GDK_KEY_Ograve => GDK_KEY_Ograve_
''     constant GDK_KEY_Oacute => GDK_KEY_Oacute_
''     constant GDK_KEY_Ocircumflex => GDK_KEY_Ocircumflex_
''     constant GDK_KEY_Otilde => GDK_KEY_Otilde_
''     constant GDK_KEY_Odiaeresis => GDK_KEY_Odiaeresis_
''     constant GDK_KEY_Oslash => GDK_KEY_Oslash_
''     constant GDK_KEY_Ooblique => GDK_KEY_Ooblique_
''     constant GDK_KEY_Ugrave => GDK_KEY_Ugrave_
''     constant GDK_KEY_Uacute => GDK_KEY_Uacute_
''     constant GDK_KEY_Ucircumflex => GDK_KEY_Ucircumflex_
''     constant GDK_KEY_Udiaeresis => GDK_KEY_Udiaeresis_
''     constant GDK_KEY_Yacute => GDK_KEY_Yacute_
''     constant GDK_KEY_Thorn => GDK_KEY_Thorn_
''     constant GDK_KEY_Aogonek => GDK_KEY_Aogonek_
''     constant GDK_KEY_Lstroke => GDK_KEY_Lstroke_
''     constant GDK_KEY_Lcaron => GDK_KEY_Lcaron_
''     constant GDK_KEY_Sacute => GDK_KEY_Sacute_
''     constant GDK_KEY_Scaron => GDK_KEY_Scaron_
''     constant GDK_KEY_Scedilla => GDK_KEY_Scedilla_
''     constant GDK_KEY_Tcaron => GDK_KEY_Tcaron_
''     constant GDK_KEY_Zacute => GDK_KEY_Zacute_
''     constant GDK_KEY_Zcaron => GDK_KEY_Zcaron_
''     constant GDK_KEY_Zabovedot => GDK_KEY_Zabovedot_
''     constant GDK_KEY_Racute => GDK_KEY_Racute_
''     constant GDK_KEY_Abreve => GDK_KEY_Abreve_
''     constant GDK_KEY_Lacute => GDK_KEY_Lacute_
''     constant GDK_KEY_Cacute => GDK_KEY_Cacute_
''     constant GDK_KEY_Ccaron => GDK_KEY_Ccaron_
''     constant GDK_KEY_Eogonek => GDK_KEY_Eogonek_
''     constant GDK_KEY_Ecaron => GDK_KEY_Ecaron_
''     constant GDK_KEY_Dcaron => GDK_KEY_Dcaron_
''     constant GDK_KEY_Dstroke => GDK_KEY_Dstroke_
''     constant GDK_KEY_Nacute => GDK_KEY_Nacute_
''     constant GDK_KEY_Ncaron => GDK_KEY_Ncaron_
''     constant GDK_KEY_Odoubleacute => GDK_KEY_Odoubleacute_
''     constant GDK_KEY_Rcaron => GDK_KEY_Rcaron_
''     constant GDK_KEY_Uring => GDK_KEY_Uring_
''     constant GDK_KEY_Udoubleacute => GDK_KEY_Udoubleacute_
''     constant GDK_KEY_Tcedilla => GDK_KEY_Tcedilla_
''     constant GDK_KEY_Hstroke => GDK_KEY_Hstroke_
''     constant GDK_KEY_Hcircumflex => GDK_KEY_Hcircumflex_
''     constant GDK_KEY_Gbreve => GDK_KEY_Gbreve_
''     constant GDK_KEY_Jcircumflex => GDK_KEY_Jcircumflex_
''     constant GDK_KEY_Cabovedot => GDK_KEY_Cabovedot_
''     constant GDK_KEY_Ccircumflex => GDK_KEY_Ccircumflex_
''     constant GDK_KEY_Gabovedot => GDK_KEY_Gabovedot_
''     constant GDK_KEY_Gcircumflex => GDK_KEY_Gcircumflex_
''     constant GDK_KEY_Ubreve => GDK_KEY_Ubreve_
''     constant GDK_KEY_Scircumflex => GDK_KEY_Scircumflex_
''     constant GDK_KEY_Rcedilla => GDK_KEY_Rcedilla_
''     constant GDK_KEY_Itilde => GDK_KEY_Itilde_
''     constant GDK_KEY_Lcedilla => GDK_KEY_Lcedilla_
''     constant GDK_KEY_Emacron => GDK_KEY_Emacron_
''     constant GDK_KEY_Gcedilla => GDK_KEY_Gcedilla_
''     constant GDK_KEY_Tslash => GDK_KEY_Tslash_
''     constant GDK_KEY_ENG => GDK_KEY_ENG_
''     constant GDK_KEY_Amacron => GDK_KEY_Amacron_
''     constant GDK_KEY_Iogonek => GDK_KEY_Iogonek_
''     constant GDK_KEY_Eabovedot => GDK_KEY_Eabovedot_
''     constant GDK_KEY_Imacron => GDK_KEY_Imacron_
''     constant GDK_KEY_Ncedilla => GDK_KEY_Ncedilla_
''     constant GDK_KEY_Omacron => GDK_KEY_Omacron_
''     constant GDK_KEY_Kcedilla => GDK_KEY_Kcedilla_
''     constant GDK_KEY_Uogonek => GDK_KEY_Uogonek_
''     constant GDK_KEY_Utilde => GDK_KEY_Utilde_
''     constant GDK_KEY_Umacron => GDK_KEY_Umacron_
''     constant GDK_KEY_Wcircumflex => GDK_KEY_Wcircumflex_
''     constant GDK_KEY_Ycircumflex => GDK_KEY_Ycircumflex_
''     constant GDK_KEY_Babovedot => GDK_KEY_Babovedot_
''     constant GDK_KEY_Dabovedot => GDK_KEY_Dabovedot_
''     constant GDK_KEY_Fabovedot => GDK_KEY_Fabovedot_
''     constant GDK_KEY_Mabovedot => GDK_KEY_Mabovedot_
''     constant GDK_KEY_Pabovedot => GDK_KEY_Pabovedot_
''     constant GDK_KEY_Sabovedot => GDK_KEY_Sabovedot_
''     constant GDK_KEY_Tabovedot => GDK_KEY_Tabovedot_
''     constant GDK_KEY_Wgrave => GDK_KEY_Wgrave_
''     constant GDK_KEY_Wacute => GDK_KEY_Wacute_
''     constant GDK_KEY_Wdiaeresis => GDK_KEY_Wdiaeresis_
''     constant GDK_KEY_Ygrave => GDK_KEY_Ygrave_
''     constant GDK_KEY_OE => GDK_KEY_OE_
''     constant GDK_KEY_Ydiaeresis => GDK_KEY_Ydiaeresis_
''     constant GDK_KEY_kana_A => GDK_KEY_kana_A_
''     constant GDK_KEY_kana_I => GDK_KEY_kana_I_
''     constant GDK_KEY_kana_U => GDK_KEY_kana_U_
''     constant GDK_KEY_kana_E => GDK_KEY_kana_E_
''     constant GDK_KEY_kana_O => GDK_KEY_kana_O_
''     constant GDK_KEY_kana_TSU => GDK_KEY_kana_TSU_
''     constant GDK_KEY_kana_TU => GDK_KEY_kana_TU_
''     constant GDK_KEY_kana_YA => GDK_KEY_kana_YA_
''     constant GDK_KEY_kana_YU => GDK_KEY_kana_YU_
''     constant GDK_KEY_kana_YO => GDK_KEY_kana_YO_
''     constant GDK_KEY_Cyrillic_GHE_bar => GDK_KEY_Cyrillic_GHE_bar_
''     constant GDK_KEY_Cyrillic_ZHE_descender => GDK_KEY_Cyrillic_ZHE_descender_
''     constant GDK_KEY_Cyrillic_KA_descender => GDK_KEY_Cyrillic_KA_descender_
''     constant GDK_KEY_Cyrillic_KA_vertstroke => GDK_KEY_Cyrillic_KA_vertstroke_
''     constant GDK_KEY_Cyrillic_EN_descender => GDK_KEY_Cyrillic_EN_descender_
''     constant GDK_KEY_Cyrillic_U_straight => GDK_KEY_Cyrillic_U_straight_
''     constant GDK_KEY_Cyrillic_U_straight_bar => GDK_KEY_Cyrillic_U_straight_bar_
''     constant GDK_KEY_Cyrillic_HA_descender => GDK_KEY_Cyrillic_HA_descender_
''     constant GDK_KEY_Cyrillic_CHE_descender => GDK_KEY_Cyrillic_CHE_descender_
''     constant GDK_KEY_Cyrillic_CHE_vertstroke => GDK_KEY_Cyrillic_CHE_vertstroke_
''     constant GDK_KEY_Cyrillic_SHHA => GDK_KEY_Cyrillic_SHHA_
''     constant GDK_KEY_Cyrillic_SCHWA => GDK_KEY_Cyrillic_SCHWA_
''     constant GDK_KEY_Cyrillic_I_macron => GDK_KEY_Cyrillic_I_macron_
''     constant GDK_KEY_Cyrillic_O_bar => GDK_KEY_Cyrillic_O_bar_
''     constant GDK_KEY_Cyrillic_U_macron => GDK_KEY_Cyrillic_U_macron_
''     constant GDK_KEY_Serbian_DJE => GDK_KEY_Serbian_DJE_
''     constant GDK_KEY_Macedonia_GJE => GDK_KEY_Macedonia_GJE_
''     constant GDK_KEY_Cyrillic_IO => GDK_KEY_Cyrillic_IO_
''     constant GDK_KEY_Ukrainian_IE => GDK_KEY_Ukrainian_IE_
''     constant GDK_KEY_Ukranian_JE => GDK_KEY_Ukranian_JE_
''     constant GDK_KEY_Macedonia_DSE => GDK_KEY_Macedonia_DSE_
''     constant GDK_KEY_Ukrainian_I => GDK_KEY_Ukrainian_I_
''     constant GDK_KEY_Ukranian_I => GDK_KEY_Ukranian_I_
''     constant GDK_KEY_Ukrainian_YI => GDK_KEY_Ukrainian_YI_
''     constant GDK_KEY_Ukranian_YI => GDK_KEY_Ukranian_YI_
''     constant GDK_KEY_Cyrillic_JE => GDK_KEY_Cyrillic_JE_
''     constant GDK_KEY_Serbian_JE => GDK_KEY_Serbian_JE_
''     constant GDK_KEY_Cyrillic_LJE => GDK_KEY_Cyrillic_LJE_
''     constant GDK_KEY_Serbian_LJE => GDK_KEY_Serbian_LJE_
''     constant GDK_KEY_Cyrillic_NJE => GDK_KEY_Cyrillic_NJE_
''     constant GDK_KEY_Serbian_NJE => GDK_KEY_Serbian_NJE_
''     constant GDK_KEY_Serbian_TSHE => GDK_KEY_Serbian_TSHE_
''     constant GDK_KEY_Macedonia_KJE => GDK_KEY_Macedonia_KJE_
''     constant GDK_KEY_Ukrainian_GHE_WITH_UPTURN => GDK_KEY_Ukrainian_GHE_WITH_UPTURN_
''     constant GDK_KEY_Byelorussian_SHORTU => GDK_KEY_Byelorussian_SHORTU_
''     constant GDK_KEY_Cyrillic_DZHE => GDK_KEY_Cyrillic_DZHE_
''     constant GDK_KEY_Serbian_DZE => GDK_KEY_Serbian_DZE_
''     constant GDK_KEY_Cyrillic_YU => GDK_KEY_Cyrillic_YU_
''     constant GDK_KEY_Cyrillic_A => GDK_KEY_Cyrillic_A_
''     constant GDK_KEY_Cyrillic_BE => GDK_KEY_Cyrillic_BE_
''     constant GDK_KEY_Cyrillic_TSE => GDK_KEY_Cyrillic_TSE_
''     constant GDK_KEY_Cyrillic_DE => GDK_KEY_Cyrillic_DE_
''     constant GDK_KEY_Cyrillic_IE => GDK_KEY_Cyrillic_IE_
''     constant GDK_KEY_Cyrillic_EF => GDK_KEY_Cyrillic_EF_
''     constant GDK_KEY_Cyrillic_GHE => GDK_KEY_Cyrillic_GHE_
''     constant GDK_KEY_Cyrillic_HA => GDK_KEY_Cyrillic_HA_
''     constant GDK_KEY_Cyrillic_I => GDK_KEY_Cyrillic_I_
''     constant GDK_KEY_Cyrillic_SHORTI => GDK_KEY_Cyrillic_SHORTI_
''     constant GDK_KEY_Cyrillic_KA => GDK_KEY_Cyrillic_KA_
''     constant GDK_KEY_Cyrillic_EL => GDK_KEY_Cyrillic_EL_
''     constant GDK_KEY_Cyrillic_EM => GDK_KEY_Cyrillic_EM_
''     constant GDK_KEY_Cyrillic_EN => GDK_KEY_Cyrillic_EN_
''     constant GDK_KEY_Cyrillic_O => GDK_KEY_Cyrillic_O_
''     constant GDK_KEY_Cyrillic_PE => GDK_KEY_Cyrillic_PE_
''     constant GDK_KEY_Cyrillic_YA => GDK_KEY_Cyrillic_YA_
''     constant GDK_KEY_Cyrillic_ER => GDK_KEY_Cyrillic_ER_
''     constant GDK_KEY_Cyrillic_ES => GDK_KEY_Cyrillic_ES_
''     constant GDK_KEY_Cyrillic_TE => GDK_KEY_Cyrillic_TE_
''     constant GDK_KEY_Cyrillic_U => GDK_KEY_Cyrillic_U_
''     constant GDK_KEY_Cyrillic_ZHE => GDK_KEY_Cyrillic_ZHE_
''     constant GDK_KEY_Cyrillic_VE => GDK_KEY_Cyrillic_VE_
''     constant GDK_KEY_Cyrillic_SOFTSIGN => GDK_KEY_Cyrillic_SOFTSIGN_
''     constant GDK_KEY_Cyrillic_YERU => GDK_KEY_Cyrillic_YERU_
''     constant GDK_KEY_Cyrillic_ZE => GDK_KEY_Cyrillic_ZE_
''     constant GDK_KEY_Cyrillic_SHA => GDK_KEY_Cyrillic_SHA_
''     constant GDK_KEY_Cyrillic_E => GDK_KEY_Cyrillic_E_
''     constant GDK_KEY_Cyrillic_SHCHA => GDK_KEY_Cyrillic_SHCHA_
''     constant GDK_KEY_Cyrillic_CHE => GDK_KEY_Cyrillic_CHE_
''     constant GDK_KEY_Cyrillic_HARDSIGN => GDK_KEY_Cyrillic_HARDSIGN_
''     constant GDK_KEY_Greek_ALPHAaccent => GDK_KEY_Greek_ALPHAaccent_
''     constant GDK_KEY_Greek_EPSILONaccent => GDK_KEY_Greek_EPSILONaccent_
''     constant GDK_KEY_Greek_ETAaccent => GDK_KEY_Greek_ETAaccent_
''     constant GDK_KEY_Greek_IOTAaccent => GDK_KEY_Greek_IOTAaccent_
''     constant GDK_KEY_Greek_IOTAdieresis => GDK_KEY_Greek_IOTAdieresis_
''     constant GDK_KEY_Greek_OMICRONaccent => GDK_KEY_Greek_OMICRONaccent_
''     constant GDK_KEY_Greek_UPSILONaccent => GDK_KEY_Greek_UPSILONaccent_
''     constant GDK_KEY_Greek_UPSILONdieresis => GDK_KEY_Greek_UPSILONdieresis_
''     constant GDK_KEY_Greek_OMEGAaccent => GDK_KEY_Greek_OMEGAaccent_
''     constant GDK_KEY_Greek_ALPHA => GDK_KEY_Greek_ALPHA_
''     constant GDK_KEY_Greek_BETA => GDK_KEY_Greek_BETA_
''     constant GDK_KEY_Greek_GAMMA => GDK_KEY_Greek_GAMMA_
''     constant GDK_KEY_Greek_DELTA => GDK_KEY_Greek_DELTA_
''     constant GDK_KEY_Greek_EPSILON => GDK_KEY_Greek_EPSILON_
''     constant GDK_KEY_Greek_ZETA => GDK_KEY_Greek_ZETA_
''     constant GDK_KEY_Greek_ETA => GDK_KEY_Greek_ETA_
''     constant GDK_KEY_Greek_THETA => GDK_KEY_Greek_THETA_
''     constant GDK_KEY_Greek_IOTA => GDK_KEY_Greek_IOTA_
''     constant GDK_KEY_Greek_KAPPA => GDK_KEY_Greek_KAPPA_
''     constant GDK_KEY_Greek_LAMDA => GDK_KEY_Greek_LAMDA_
''     constant GDK_KEY_Greek_LAMBDA => GDK_KEY_Greek_LAMBDA_
''     constant GDK_KEY_Greek_MU => GDK_KEY_Greek_MU_
''     constant GDK_KEY_Greek_NU => GDK_KEY_Greek_NU_
''     constant GDK_KEY_Greek_XI => GDK_KEY_Greek_XI_
''     constant GDK_KEY_Greek_OMICRON => GDK_KEY_Greek_OMICRON_
''     constant GDK_KEY_Greek_PI => GDK_KEY_Greek_PI_
''     constant GDK_KEY_Greek_RHO => GDK_KEY_Greek_RHO_
''     constant GDK_KEY_Greek_SIGMA => GDK_KEY_Greek_SIGMA_
''     constant GDK_KEY_Greek_TAU => GDK_KEY_Greek_TAU_
''     constant GDK_KEY_Greek_UPSILON => GDK_KEY_Greek_UPSILON_
''     constant GDK_KEY_Greek_PHI => GDK_KEY_Greek_PHI_
''     constant GDK_KEY_Greek_CHI => GDK_KEY_Greek_CHI_
''     constant GDK_KEY_Greek_PSI => GDK_KEY_Greek_PSI_
''     constant GDK_KEY_Greek_OMEGA => GDK_KEY_Greek_OMEGA_
''     constant GDK_KEY_Armenian_AYB => GDK_KEY_Armenian_AYB_
''     constant GDK_KEY_Armenian_BEN => GDK_KEY_Armenian_BEN_
''     constant GDK_KEY_Armenian_GIM => GDK_KEY_Armenian_GIM_
''     constant GDK_KEY_Armenian_DA => GDK_KEY_Armenian_DA_
''     constant GDK_KEY_Armenian_YECH => GDK_KEY_Armenian_YECH_
''     constant GDK_KEY_Armenian_ZA => GDK_KEY_Armenian_ZA_
''     constant GDK_KEY_Armenian_E => GDK_KEY_Armenian_E_
''     constant GDK_KEY_Armenian_AT => GDK_KEY_Armenian_AT_
''     constant GDK_KEY_Armenian_TO => GDK_KEY_Armenian_TO_
''     constant GDK_KEY_Armenian_ZHE => GDK_KEY_Armenian_ZHE_
''     constant GDK_KEY_Armenian_INI => GDK_KEY_Armenian_INI_
''     constant GDK_KEY_Armenian_LYUN => GDK_KEY_Armenian_LYUN_
''     constant GDK_KEY_Armenian_KHE => GDK_KEY_Armenian_KHE_
''     constant GDK_KEY_Armenian_TSA => GDK_KEY_Armenian_TSA_
''     constant GDK_KEY_Armenian_KEN => GDK_KEY_Armenian_KEN_
''     constant GDK_KEY_Armenian_HO => GDK_KEY_Armenian_HO_
''     constant GDK_KEY_Armenian_DZA => GDK_KEY_Armenian_DZA_
''     constant GDK_KEY_Armenian_GHAT => GDK_KEY_Armenian_GHAT_
''     constant GDK_KEY_Armenian_TCHE => GDK_KEY_Armenian_TCHE_
''     constant GDK_KEY_Armenian_MEN => GDK_KEY_Armenian_MEN_
''     constant GDK_KEY_Armenian_HI => GDK_KEY_Armenian_HI_
''     constant GDK_KEY_Armenian_NU => GDK_KEY_Armenian_NU_
''     constant GDK_KEY_Armenian_SHA => GDK_KEY_Armenian_SHA_
''     constant GDK_KEY_Armenian_VO => GDK_KEY_Armenian_VO_
''     constant GDK_KEY_Armenian_CHA => GDK_KEY_Armenian_CHA_
''     constant GDK_KEY_Armenian_PE => GDK_KEY_Armenian_PE_
''     constant GDK_KEY_Armenian_JE => GDK_KEY_Armenian_JE_
''     constant GDK_KEY_Armenian_RA => GDK_KEY_Armenian_RA_
''     constant GDK_KEY_Armenian_SE => GDK_KEY_Armenian_SE_
''     constant GDK_KEY_Armenian_VEV => GDK_KEY_Armenian_VEV_
''     constant GDK_KEY_Armenian_TYUN => GDK_KEY_Armenian_TYUN_
''     constant GDK_KEY_Armenian_RE => GDK_KEY_Armenian_RE_
''     constant GDK_KEY_Armenian_TSO => GDK_KEY_Armenian_TSO_
''     constant GDK_KEY_Armenian_VYUN => GDK_KEY_Armenian_VYUN_
''     constant GDK_KEY_Armenian_PYUR => GDK_KEY_Armenian_PYUR_
''     constant GDK_KEY_Armenian_KE => GDK_KEY_Armenian_KE_
''     constant GDK_KEY_Armenian_O => GDK_KEY_Armenian_O_
''     constant GDK_KEY_Armenian_FE => GDK_KEY_Armenian_FE_
''     constant GDK_KEY_Xabovedot => GDK_KEY_Xabovedot_
''     constant GDK_KEY_Ibreve => GDK_KEY_Ibreve_
''     constant GDK_KEY_Zstroke => GDK_KEY_Zstroke_
''     constant GDK_KEY_Gcaron => GDK_KEY_Gcaron_
''     constant GDK_KEY_Ocaron => GDK_KEY_Ocaron_
''     constant GDK_KEY_Obarred => GDK_KEY_Obarred_
''     constant GDK_KEY_SCHWA => GDK_KEY_SCHWA_
''     constant GDK_KEY_ezh => GDK_KEY_ezh_
''     constant GDK_KEY_Lbelowdot => GDK_KEY_Lbelowdot_
''     constant GDK_KEY_Abelowdot => GDK_KEY_Abelowdot_
''     constant GDK_KEY_Ahook => GDK_KEY_Ahook_
''     constant GDK_KEY_Acircumflexacute => GDK_KEY_Acircumflexacute_
''     constant GDK_KEY_Acircumflexgrave => GDK_KEY_Acircumflexgrave_
''     constant GDK_KEY_Acircumflexhook => GDK_KEY_Acircumflexhook_
''     constant GDK_KEY_Acircumflextilde => GDK_KEY_Acircumflextilde_
''     constant GDK_KEY_Acircumflexbelowdot => GDK_KEY_Acircumflexbelowdot_
''     constant GDK_KEY_Abreveacute => GDK_KEY_Abreveacute_
''     constant GDK_KEY_Abrevegrave => GDK_KEY_Abrevegrave_
''     constant GDK_KEY_Abrevehook => GDK_KEY_Abrevehook_
''     constant GDK_KEY_Abrevetilde => GDK_KEY_Abrevetilde_
''     constant GDK_KEY_Abrevebelowdot => GDK_KEY_Abrevebelowdot_
''     constant GDK_KEY_Ebelowdot => GDK_KEY_Ebelowdot_
''     constant GDK_KEY_Ehook => GDK_KEY_Ehook_
''     constant GDK_KEY_Etilde => GDK_KEY_Etilde_
''     constant GDK_KEY_Ecircumflexacute => GDK_KEY_Ecircumflexacute_
''     constant GDK_KEY_Ecircumflexgrave => GDK_KEY_Ecircumflexgrave_
''     constant GDK_KEY_Ecircumflexhook => GDK_KEY_Ecircumflexhook_
''     constant GDK_KEY_Ecircumflextilde => GDK_KEY_Ecircumflextilde_
''     constant GDK_KEY_Ecircumflexbelowdot => GDK_KEY_Ecircumflexbelowdot_
''     constant GDK_KEY_Ihook => GDK_KEY_Ihook_
''     constant GDK_KEY_Ibelowdot => GDK_KEY_Ibelowdot_
''     constant GDK_KEY_Obelowdot => GDK_KEY_Obelowdot_
''     constant GDK_KEY_Ohook => GDK_KEY_Ohook_
''     constant GDK_KEY_Ocircumflexacute => GDK_KEY_Ocircumflexacute_
''     constant GDK_KEY_Ocircumflexgrave => GDK_KEY_Ocircumflexgrave_
''     constant GDK_KEY_Ocircumflexhook => GDK_KEY_Ocircumflexhook_
''     constant GDK_KEY_Ocircumflextilde => GDK_KEY_Ocircumflextilde_
''     constant GDK_KEY_Ocircumflexbelowdot => GDK_KEY_Ocircumflexbelowdot_
''     constant GDK_KEY_Ohornacute => GDK_KEY_Ohornacute_
''     constant GDK_KEY_Ohorngrave => GDK_KEY_Ohorngrave_
''     constant GDK_KEY_Ohornhook => GDK_KEY_Ohornhook_
''     constant GDK_KEY_Ohorntilde => GDK_KEY_Ohorntilde_
''     constant GDK_KEY_Ohornbelowdot => GDK_KEY_Ohornbelowdot_
''     constant GDK_KEY_Ubelowdot => GDK_KEY_Ubelowdot_
''     constant GDK_KEY_Uhook => GDK_KEY_Uhook_
''     constant GDK_KEY_Uhornacute => GDK_KEY_Uhornacute_
''     constant GDK_KEY_Uhorngrave => GDK_KEY_Uhorngrave_
''     constant GDK_KEY_Uhornhook => GDK_KEY_Uhornhook_
''     constant GDK_KEY_Uhorntilde => GDK_KEY_Uhorntilde_
''     constant GDK_KEY_Uhornbelowdot => GDK_KEY_Uhornbelowdot_
''     constant GDK_KEY_Ybelowdot => GDK_KEY_Ybelowdot_
''     constant GDK_KEY_Yhook => GDK_KEY_Yhook_
''     constant GDK_KEY_Ytilde => GDK_KEY_Ytilde_
''     constant GDK_KEY_Ohorn => GDK_KEY_Ohorn_
''     constant GDK_KEY_Uhorn => GDK_KEY_Uhorn_

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define __GDK_H__
#define __GDK_H_INSIDE__

#ifdef __FB_UNIX__
	#define GDK_WINDOWING_X11
	#define GDK_WINDOWING_WAYLAND
	#define GDK_WINDOWING_MIR
#else
	#define GDK_WINDOWING_WIN32
#endif

#define __GDK_VERSION_MACROS_H__
const GDK_MAJOR_VERSION = 3
const GDK_MINOR_VERSION = 16
const GDK_MICRO_VERSION = 6
#define GDK_VERSION_3_0 G_ENCODE_VERSION(3, 0)
#define GDK_VERSION_3_2 G_ENCODE_VERSION(3, 2)
#define GDK_VERSION_3_4 G_ENCODE_VERSION(3, 4)
#define GDK_VERSION_3_6 G_ENCODE_VERSION(3, 6)
#define GDK_VERSION_3_8 G_ENCODE_VERSION(3, 8)
#define GDK_VERSION_3_10 G_ENCODE_VERSION(3, 10)
#define GDK_VERSION_3_12 G_ENCODE_VERSION(3, 12)
#define GDK_VERSION_3_14 G_ENCODE_VERSION(3, 14)
#define GDK_VERSION_3_16 G_ENCODE_VERSION(3, 16)
#define GDK_VERSION_CUR_STABLE G_ENCODE_VERSION(GDK_MAJOR_VERSION, GDK_MINOR_VERSION)
#define GDK_VERSION_PREV_STABLE G_ENCODE_VERSION(GDK_MAJOR_VERSION, GDK_MINOR_VERSION - 2)
#define GDK_VERSION_MIN_REQUIRED GDK_VERSION_CUR_STABLE
#define GDK_VERSION_MAX_ALLOWED GDK_VERSION_MIN_REQUIRED
#define __GDK_APP_LAUNCH_CONTEXT_H__
#define __GDK_TYPES_H__

#ifdef __FB_UNIX__
	#define GDK_WINDOWING_X11
	#define GDK_WINDOWING_WAYLAND
	#define GDK_WINDOWING_MIR
#else
	#define GDK_WINDOWING_WIN32
#endif

const GDK_CURRENT_TIME = cast(clong, 0)
const GDK_PARENT_RELATIVE = cast(clong, 1)
type GdkPoint as _GdkPoint
type GdkRectangle as cairo_rectangle_int_t
type GdkAtom as _GdkAtom ptr

#define GDK_ATOM_TO_POINTER(atom) (atom)
#define GDK_POINTER_TO_ATOM(ptr) cast(GdkAtom, (ptr))
#define _GDK_MAKE_ATOM(val) cast(GdkAtom, GUINT_TO_POINTER(val))
#define GDK_NONE _GDK_MAKE_ATOM(0)

type GdkColor as _GdkColor
type GdkRGBA as _GdkRGBA
type GdkCursor as _GdkCursor
type GdkVisual as _GdkVisual
type GdkDevice as _GdkDevice
type GdkDragContext as _GdkDragContext
type GdkDisplayManager as _GdkDisplayManager
type GdkDeviceManager as _GdkDeviceManager
type GdkDisplay as _GdkDisplay
type GdkScreen as _GdkScreen
type GdkWindow as _GdkWindow
type GdkKeymap as _GdkKeymap
type GdkAppLaunchContext as _GdkAppLaunchContext
type GdkGLContext as _GdkGLContext

type GdkByteOrder as long
enum
	GDK_LSB_FIRST
	GDK_MSB_FIRST
end enum

type GdkModifierType as long
enum
	GDK_SHIFT_MASK = 1 shl 0
	GDK_LOCK_MASK = 1 shl 1
	GDK_CONTROL_MASK = 1 shl 2
	GDK_MOD1_MASK = 1 shl 3
	GDK_MOD2_MASK = 1 shl 4
	GDK_MOD3_MASK = 1 shl 5
	GDK_MOD4_MASK = 1 shl 6
	GDK_MOD5_MASK = 1 shl 7
	GDK_BUTTON1_MASK = 1 shl 8
	GDK_BUTTON2_MASK = 1 shl 9
	GDK_BUTTON3_MASK = 1 shl 10
	GDK_BUTTON4_MASK = 1 shl 11
	GDK_BUTTON5_MASK = 1 shl 12
	GDK_MODIFIER_RESERVED_13_MASK = 1 shl 13
	GDK_MODIFIER_RESERVED_14_MASK = 1 shl 14
	GDK_MODIFIER_RESERVED_15_MASK = 1 shl 15
	GDK_MODIFIER_RESERVED_16_MASK = 1 shl 16
	GDK_MODIFIER_RESERVED_17_MASK = 1 shl 17
	GDK_MODIFIER_RESERVED_18_MASK = 1 shl 18
	GDK_MODIFIER_RESERVED_19_MASK = 1 shl 19
	GDK_MODIFIER_RESERVED_20_MASK = 1 shl 20
	GDK_MODIFIER_RESERVED_21_MASK = 1 shl 21
	GDK_MODIFIER_RESERVED_22_MASK = 1 shl 22
	GDK_MODIFIER_RESERVED_23_MASK = 1 shl 23
	GDK_MODIFIER_RESERVED_24_MASK = 1 shl 24
	GDK_MODIFIER_RESERVED_25_MASK = 1 shl 25
	GDK_SUPER_MASK = 1 shl 26
	GDK_HYPER_MASK = 1 shl 27
	GDK_META_MASK = 1 shl 28
	GDK_MODIFIER_RESERVED_29_MASK = 1 shl 29
	GDK_RELEASE_MASK = 1 shl 30
	GDK_MODIFIER_MASK = &h5c001fff
end enum

type GdkModifierIntent as long
enum
	GDK_MODIFIER_INTENT_PRIMARY_ACCELERATOR
	GDK_MODIFIER_INTENT_CONTEXT_MENU
	GDK_MODIFIER_INTENT_EXTEND_SELECTION
	GDK_MODIFIER_INTENT_MODIFY_SELECTION
	GDK_MODIFIER_INTENT_NO_TEXT_INPUT
	GDK_MODIFIER_INTENT_SHIFT_GROUP
end enum

type GdkStatus as long
enum
	GDK_OK = 0
	GDK_ERROR = -1
	GDK_ERROR_PARAM = -2
	GDK_ERROR_FILE = -3
	GDK_ERROR_MEM = -4
end enum

type GdkGrabStatus as long
enum
	GDK_GRAB_SUCCESS = 0
	GDK_GRAB_ALREADY_GRABBED = 1
	GDK_GRAB_INVALID_TIME = 2
	GDK_GRAB_NOT_VIEWABLE = 3
	GDK_GRAB_FROZEN = 4
	GDK_GRAB_FAILED = 5
end enum

type GdkGrabOwnership as long
enum
	GDK_OWNERSHIP_NONE
	GDK_OWNERSHIP_WINDOW
	GDK_OWNERSHIP_APPLICATION
end enum

type GdkEventMask as long
enum
	GDK_EXPOSURE_MASK = 1 shl 1
	GDK_POINTER_MOTION_MASK = 1 shl 2
	GDK_POINTER_MOTION_HINT_MASK = 1 shl 3
	GDK_BUTTON_MOTION_MASK = 1 shl 4
	GDK_BUTTON1_MOTION_MASK = 1 shl 5
	GDK_BUTTON2_MOTION_MASK = 1 shl 6
	GDK_BUTTON3_MOTION_MASK = 1 shl 7
	GDK_BUTTON_PRESS_MASK = 1 shl 8
	GDK_BUTTON_RELEASE_MASK = 1 shl 9
	GDK_KEY_PRESS_MASK = 1 shl 10
	GDK_KEY_RELEASE_MASK = 1 shl 11
	GDK_ENTER_NOTIFY_MASK = 1 shl 12
	GDK_LEAVE_NOTIFY_MASK = 1 shl 13
	GDK_FOCUS_CHANGE_MASK = 1 shl 14
	GDK_STRUCTURE_MASK = 1 shl 15
	GDK_PROPERTY_CHANGE_MASK = 1 shl 16
	GDK_VISIBILITY_NOTIFY_MASK = 1 shl 17
	GDK_PROXIMITY_IN_MASK = 1 shl 18
	GDK_PROXIMITY_OUT_MASK = 1 shl 19
	GDK_SUBSTRUCTURE_MASK = 1 shl 20
	GDK_SCROLL_MASK = 1 shl 21
	GDK_TOUCH_MASK = 1 shl 22
	GDK_SMOOTH_SCROLL_MASK = 1 shl 23
	GDK_ALL_EVENTS_MASK = &hFFFFFE
end enum

type _GdkPoint
	x as gint
	y as gint
end type

type GdkGLError as long
enum
	GDK_GL_ERROR_NOT_AVAILABLE
	GDK_GL_ERROR_UNSUPPORTED_FORMAT
	GDK_GL_ERROR_UNSUPPORTED_PROFILE
end enum

#define __GDK_SCREEN_H__
#define __GDK_DISPLAY_H__
#define __GDK_EVENTS_H__
#define __GDK_DND_H__
#define __GDK_DEVICE_H__
#define GDK_TYPE_DEVICE gdk_device_get_type()
#define GDK_DEVICE(o) G_TYPE_CHECK_INSTANCE_CAST((o), GDK_TYPE_DEVICE, GdkDevice)
#define GDK_IS_DEVICE(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GDK_TYPE_DEVICE)
type GdkTimeCoord as _GdkTimeCoord

type GdkInputSource as long
enum
	GDK_SOURCE_MOUSE
	GDK_SOURCE_PEN
	GDK_SOURCE_ERASER
	GDK_SOURCE_CURSOR
	GDK_SOURCE_KEYBOARD
	GDK_SOURCE_TOUCHSCREEN
	GDK_SOURCE_TOUCHPAD
end enum

type GdkInputMode as long
enum
	GDK_MODE_DISABLED
	GDK_MODE_SCREEN
	GDK_MODE_WINDOW
end enum

type GdkAxisUse as long
enum
	GDK_AXIS_IGNORE
	GDK_AXIS_X
	GDK_AXIS_Y
	GDK_AXIS_PRESSURE
	GDK_AXIS_XTILT
	GDK_AXIS_YTILT
	GDK_AXIS_WHEEL
	GDK_AXIS_LAST
end enum

type GdkDeviceType as long
enum
	GDK_DEVICE_TYPE_MASTER
	GDK_DEVICE_TYPE_SLAVE
	GDK_DEVICE_TYPE_FLOATING
end enum

const GDK_MAX_TIMECOORD_AXES = 128

type _GdkTimeCoord
	time as guint32
	axes(0 to 127) as gdouble
end type

declare function gdk_device_get_type() as GType
declare function gdk_device_get_name(byval device as GdkDevice ptr) as const gchar ptr
declare function gdk_device_get_has_cursor(byval device as GdkDevice ptr) as gboolean
declare function gdk_device_get_source(byval device as GdkDevice ptr) as GdkInputSource
declare function gdk_device_get_mode(byval device as GdkDevice ptr) as GdkInputMode
declare function gdk_device_set_mode(byval device as GdkDevice ptr, byval mode as GdkInputMode) as gboolean
declare function gdk_device_get_n_keys(byval device as GdkDevice ptr) as gint
declare function gdk_device_get_key(byval device as GdkDevice ptr, byval index_ as guint, byval keyval as guint ptr, byval modifiers as GdkModifierType ptr) as gboolean
declare sub gdk_device_set_key(byval device as GdkDevice ptr, byval index_ as guint, byval keyval as guint, byval modifiers as GdkModifierType)
declare function gdk_device_get_axis_use(byval device as GdkDevice ptr, byval index_ as guint) as GdkAxisUse
declare sub gdk_device_set_axis_use(byval device as GdkDevice ptr, byval index_ as guint, byval use as GdkAxisUse)
declare sub gdk_device_get_state(byval device as GdkDevice ptr, byval window as GdkWindow ptr, byval axes as gdouble ptr, byval mask as GdkModifierType ptr)
declare sub gdk_device_get_position(byval device as GdkDevice ptr, byval screen as GdkScreen ptr ptr, byval x as gint ptr, byval y as gint ptr)
declare function gdk_device_get_window_at_position(byval device as GdkDevice ptr, byval win_x as gint ptr, byval win_y as gint ptr) as GdkWindow ptr
declare sub gdk_device_get_position_double(byval device as GdkDevice ptr, byval screen as GdkScreen ptr ptr, byval x as gdouble ptr, byval y as gdouble ptr)
declare function gdk_device_get_window_at_position_double(byval device as GdkDevice ptr, byval win_x as gdouble ptr, byval win_y as gdouble ptr) as GdkWindow ptr
declare function gdk_device_get_history(byval device as GdkDevice ptr, byval window as GdkWindow ptr, byval start as guint32, byval stop as guint32, byval events as GdkTimeCoord ptr ptr ptr, byval n_events as gint ptr) as gboolean
declare sub gdk_device_free_history(byval events as GdkTimeCoord ptr ptr, byval n_events as gint)
declare function gdk_device_get_n_axes(byval device as GdkDevice ptr) as gint
declare function gdk_device_list_axes(byval device as GdkDevice ptr) as GList ptr
declare function gdk_device_get_axis_value(byval device as GdkDevice ptr, byval axes as gdouble ptr, byval axis_label as GdkAtom, byval value as gdouble ptr) as gboolean
declare function gdk_device_get_axis(byval device as GdkDevice ptr, byval axes as gdouble ptr, byval use as GdkAxisUse, byval value as gdouble ptr) as gboolean
declare function gdk_device_get_display(byval device as GdkDevice ptr) as GdkDisplay ptr
declare function gdk_device_get_associated_device(byval device as GdkDevice ptr) as GdkDevice ptr
declare function gdk_device_list_slave_devices(byval device as GdkDevice ptr) as GList ptr
declare function gdk_device_get_device_type(byval device as GdkDevice ptr) as GdkDeviceType
declare function gdk_device_grab(byval device as GdkDevice ptr, byval window as GdkWindow ptr, byval grab_ownership as GdkGrabOwnership, byval owner_events as gboolean, byval event_mask as GdkEventMask, byval cursor as GdkCursor ptr, byval time_ as guint32) as GdkGrabStatus
declare sub gdk_device_ungrab(byval device as GdkDevice ptr, byval time_ as guint32)
declare sub gdk_device_warp(byval device as GdkDevice ptr, byval screen as GdkScreen ptr, byval x as gint, byval y as gint)
declare function gdk_device_grab_info_libgtk_only(byval display as GdkDisplay ptr, byval device as GdkDevice ptr, byval grab_window as GdkWindow ptr ptr, byval owner_events as gboolean ptr) as gboolean
declare function gdk_device_get_last_event_window(byval device as GdkDevice ptr) as GdkWindow ptr
declare function gdk_device_get_vendor_id(byval device as GdkDevice ptr) as const gchar ptr
declare function gdk_device_get_product_id(byval device as GdkDevice ptr) as const gchar ptr

#define GDK_TYPE_DRAG_CONTEXT gdk_drag_context_get_type()
#define GDK_DRAG_CONTEXT(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_DRAG_CONTEXT, GdkDragContext)
#define GDK_IS_DRAG_CONTEXT(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_DRAG_CONTEXT)

type GdkDragAction as long
enum
	GDK_ACTION_DEFAULT = 1 shl 0
	GDK_ACTION_COPY = 1 shl 1
	GDK_ACTION_MOVE = 1 shl 2
	GDK_ACTION_LINK = 1 shl 3
	GDK_ACTION_PRIVATE = 1 shl 4
	GDK_ACTION_ASK = 1 shl 5
end enum

type GdkDragProtocol as long
enum
	GDK_DRAG_PROTO_NONE = 0
	GDK_DRAG_PROTO_MOTIF
	GDK_DRAG_PROTO_XDND
	GDK_DRAG_PROTO_ROOTWIN
	GDK_DRAG_PROTO_WIN32_DROPFILES
	GDK_DRAG_PROTO_OLE2
	GDK_DRAG_PROTO_LOCAL
	GDK_DRAG_PROTO_WAYLAND
end enum

declare function gdk_drag_context_get_type() as GType
declare sub gdk_drag_context_set_device(byval context as GdkDragContext ptr, byval device as GdkDevice ptr)
declare function gdk_drag_context_get_device(byval context as GdkDragContext ptr) as GdkDevice ptr
declare function gdk_drag_context_list_targets(byval context as GdkDragContext ptr) as GList ptr
declare function gdk_drag_context_get_actions(byval context as GdkDragContext ptr) as GdkDragAction
declare function gdk_drag_context_get_suggested_action(byval context as GdkDragContext ptr) as GdkDragAction
declare function gdk_drag_context_get_selected_action(byval context as GdkDragContext ptr) as GdkDragAction
declare function gdk_drag_context_get_source_window(byval context as GdkDragContext ptr) as GdkWindow ptr
declare function gdk_drag_context_get_dest_window(byval context as GdkDragContext ptr) as GdkWindow ptr
declare function gdk_drag_context_get_protocol(byval context as GdkDragContext ptr) as GdkDragProtocol
declare sub gdk_drag_status(byval context as GdkDragContext ptr, byval action as GdkDragAction, byval time_ as guint32)
declare sub gdk_drop_reply(byval context as GdkDragContext ptr, byval accepted as gboolean, byval time_ as guint32)
declare sub gdk_drop_finish(byval context as GdkDragContext ptr, byval success as gboolean, byval time_ as guint32)
declare function gdk_drag_get_selection(byval context as GdkDragContext ptr) as GdkAtom
declare function gdk_drag_begin(byval window as GdkWindow ptr, byval targets as GList ptr) as GdkDragContext ptr
declare function gdk_drag_begin_for_device(byval window as GdkWindow ptr, byval device as GdkDevice ptr, byval targets as GList ptr) as GdkDragContext ptr
declare sub gdk_drag_find_window_for_screen(byval context as GdkDragContext ptr, byval drag_window as GdkWindow ptr, byval screen as GdkScreen ptr, byval x_root as gint, byval y_root as gint, byval dest_window as GdkWindow ptr ptr, byval protocol as GdkDragProtocol ptr)
declare function gdk_drag_motion(byval context as GdkDragContext ptr, byval dest_window as GdkWindow ptr, byval protocol as GdkDragProtocol, byval x_root as gint, byval y_root as gint, byval suggested_action as GdkDragAction, byval possible_actions as GdkDragAction, byval time_ as guint32) as gboolean
declare sub gdk_drag_drop(byval context as GdkDragContext ptr, byval time_ as guint32)
declare sub gdk_drag_abort(byval context as GdkDragContext ptr, byval time_ as guint32)
declare function gdk_drag_drop_succeeded(byval context as GdkDragContext ptr) as gboolean

#define GDK_TYPE_EVENT gdk_event_get_type()
#define GDK_TYPE_EVENT_SEQUENCE gdk_event_sequence_get_type()
const GDK_PRIORITY_EVENTS = G_PRIORITY_DEFAULT
const GDK_PRIORITY_REDRAW = G_PRIORITY_HIGH_IDLE + 20
const GDK_EVENT_PROPAGATE = FALSE
const GDK_EVENT_STOP = CTRUE
const GDK_BUTTON_PRIMARY = 1
const GDK_BUTTON_MIDDLE = 2
const GDK_BUTTON_SECONDARY = 3

type GdkEventAny as _GdkEventAny
type GdkEventExpose as _GdkEventExpose
type GdkEventVisibility as _GdkEventVisibility
type GdkEventMotion as _GdkEventMotion
type GdkEventButton as _GdkEventButton
type GdkEventTouch as _GdkEventTouch
type GdkEventScroll as _GdkEventScroll
type GdkEventKey as _GdkEventKey
type GdkEventFocus as _GdkEventFocus
type GdkEventCrossing as _GdkEventCrossing
type GdkEventConfigure as _GdkEventConfigure
type GdkEventProperty as _GdkEventProperty
type GdkEventSelection as _GdkEventSelection
type GdkEventOwnerChange as _GdkEventOwnerChange
type GdkEventProximity as _GdkEventProximity
type GdkEventDND as _GdkEventDND
type GdkEventWindowState as _GdkEventWindowState
type GdkEventSetting as _GdkEventSetting
type GdkEventGrabBroken as _GdkEventGrabBroken
type GdkEventSequence as _GdkEventSequence
type GdkEvent as _GdkEvent
type GdkEventFunc as sub(byval event as GdkEvent ptr, byval data as gpointer)
type GdkXEvent as any

type GdkFilterReturn as long
enum
	GDK_FILTER_CONTINUE
	GDK_FILTER_TRANSLATE
	GDK_FILTER_REMOVE
end enum

type GdkFilterFunc as function(byval xevent as GdkXEvent ptr, byval event as GdkEvent ptr, byval data as gpointer) as GdkFilterReturn

type GdkEventType as long
enum
	GDK_NOTHING = -1
	GDK_DELETE = 0
	GDK_DESTROY = 1
	GDK_EXPOSE = 2
	GDK_MOTION_NOTIFY = 3
	GDK_BUTTON_PRESS = 4
	GDK_2BUTTON_PRESS = 5
	GDK_DOUBLE_BUTTON_PRESS = GDK_2BUTTON_PRESS
	GDK_3BUTTON_PRESS = 6
	GDK_TRIPLE_BUTTON_PRESS = GDK_3BUTTON_PRESS
	GDK_BUTTON_RELEASE = 7
	GDK_KEY_PRESS = 8
	GDK_KEY_RELEASE = 9
	GDK_ENTER_NOTIFY = 10
	GDK_LEAVE_NOTIFY = 11
	GDK_FOCUS_CHANGE = 12
	GDK_CONFIGURE = 13
	GDK_MAP = 14
	GDK_UNMAP = 15
	GDK_PROPERTY_NOTIFY = 16
	GDK_SELECTION_CLEAR = 17
	GDK_SELECTION_REQUEST = 18
	GDK_SELECTION_NOTIFY = 19
	GDK_PROXIMITY_IN = 20
	GDK_PROXIMITY_OUT = 21
	GDK_DRAG_ENTER = 22
	GDK_DRAG_LEAVE = 23
	GDK_DRAG_MOTION_ = 24
	GDK_DRAG_STATUS_ = 25
	GDK_DROP_START = 26
	GDK_DROP_FINISHED = 27
	GDK_CLIENT_EVENT = 28
	GDK_VISIBILITY_NOTIFY = 29
	GDK_SCROLL = 31
	GDK_WINDOW_STATE = 32
	GDK_SETTING = 33
	GDK_OWNER_CHANGE = 34
	GDK_GRAB_BROKEN = 35
	GDK_DAMAGE = 36
	GDK_TOUCH_BEGIN = 37
	GDK_TOUCH_UPDATE = 38
	GDK_TOUCH_END = 39
	GDK_TOUCH_CANCEL = 40
	GDK_EVENT_LAST
end enum

type GdkVisibilityState as long
enum
	GDK_VISIBILITY_UNOBSCURED
	GDK_VISIBILITY_PARTIAL
	GDK_VISIBILITY_FULLY_OBSCURED
end enum

type GdkScrollDirection as long
enum
	GDK_SCROLL_UP
	GDK_SCROLL_DOWN
	GDK_SCROLL_LEFT
	GDK_SCROLL_RIGHT
	GDK_SCROLL_SMOOTH
end enum

type GdkNotifyType as long
enum
	GDK_NOTIFY_ANCESTOR = 0
	GDK_NOTIFY_VIRTUAL = 1
	GDK_NOTIFY_INFERIOR = 2
	GDK_NOTIFY_NONLINEAR = 3
	GDK_NOTIFY_NONLINEAR_VIRTUAL = 4
	GDK_NOTIFY_UNKNOWN = 5
end enum

type GdkCrossingMode as long
enum
	GDK_CROSSING_NORMAL
	GDK_CROSSING_GRAB
	GDK_CROSSING_UNGRAB
	GDK_CROSSING_GTK_GRAB
	GDK_CROSSING_GTK_UNGRAB
	GDK_CROSSING_STATE_CHANGED
	GDK_CROSSING_TOUCH_BEGIN
	GDK_CROSSING_TOUCH_END
	GDK_CROSSING_DEVICE_SWITCH
end enum

type GdkPropertyState as long
enum
	GDK_PROPERTY_NEW_VALUE
	GDK_PROPERTY_DELETE_
end enum

type GdkWindowState as long
enum
	GDK_WINDOW_STATE_WITHDRAWN = 1 shl 0
	GDK_WINDOW_STATE_ICONIFIED = 1 shl 1
	GDK_WINDOW_STATE_MAXIMIZED = 1 shl 2
	GDK_WINDOW_STATE_STICKY = 1 shl 3
	GDK_WINDOW_STATE_FULLSCREEN = 1 shl 4
	GDK_WINDOW_STATE_ABOVE = 1 shl 5
	GDK_WINDOW_STATE_BELOW = 1 shl 6
	GDK_WINDOW_STATE_FOCUSED = 1 shl 7
	GDK_WINDOW_STATE_TILED = 1 shl 8
end enum

type GdkSettingAction as long
enum
	GDK_SETTING_ACTION_NEW
	GDK_SETTING_ACTION_CHANGED
	GDK_SETTING_ACTION_DELETED
end enum

type GdkOwnerChange as long
enum
	GDK_OWNER_CHANGE_NEW_OWNER
	GDK_OWNER_CHANGE_DESTROY
	GDK_OWNER_CHANGE_CLOSE
end enum

type _GdkEventAny
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
end type

type _GdkEventExpose
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	area as GdkRectangle
	region as cairo_region_t ptr
	count as gint
end type

type _GdkEventVisibility
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	state as GdkVisibilityState
end type

type _GdkEventMotion
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	x as gdouble
	y as gdouble
	axes as gdouble ptr
	state as guint
	is_hint as gint16
	device as GdkDevice ptr
	x_root as gdouble
	y_root as gdouble
end type

type _GdkEventButton
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	x as gdouble
	y as gdouble
	axes as gdouble ptr
	state as guint
	button as guint
	device as GdkDevice ptr
	x_root as gdouble
	y_root as gdouble
end type

type _GdkEventTouch
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	x as gdouble
	y as gdouble
	axes as gdouble ptr
	state as guint
	sequence as GdkEventSequence ptr
	emulating_pointer as gboolean
	device as GdkDevice ptr
	x_root as gdouble
	y_root as gdouble
end type

type _GdkEventScroll
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	x as gdouble
	y as gdouble
	state as guint
	direction as GdkScrollDirection
	device as GdkDevice ptr
	x_root as gdouble
	y_root as gdouble
	delta_x as gdouble
	delta_y as gdouble
end type

type _GdkEventKey
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	state as guint
	keyval as guint
	length as gint
	string as gchar ptr
	hardware_keycode as guint16
	group as guint8
	is_modifier : 1 as guint
end type

type _GdkEventCrossing
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	subwindow as GdkWindow ptr
	time as guint32
	x as gdouble
	y as gdouble
	x_root as gdouble
	y_root as gdouble
	mode as GdkCrossingMode
	detail as GdkNotifyType
	focus as gboolean
	state as guint
end type

type _GdkEventFocus
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	in as gint16
end type

type _GdkEventConfigure
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	x as gint
	y as gint
	width as gint
	height as gint
end type

type _GdkEventProperty
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	atom as GdkAtom
	time as guint32
	state as guint
end type

type _GdkEventSelection
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	selection as GdkAtom
	target as GdkAtom
	property as GdkAtom
	time as guint32
	requestor as GdkWindow ptr
end type

type _GdkEventOwnerChange
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	owner as GdkWindow ptr
	reason as GdkOwnerChange
	selection as GdkAtom
	time as guint32
	selection_time as guint32
end type

type _GdkEventProximity
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	device as GdkDevice ptr
end type

type _GdkEventSetting
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	action as GdkSettingAction
	name as zstring ptr
end type

type _GdkEventWindowState
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	changed_mask as GdkWindowState
	new_window_state as GdkWindowState
end type

type _GdkEventGrabBroken
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	keyboard as gboolean
	implicit as gboolean
	grab_window as GdkWindow ptr
end type

type _GdkEventDND
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	context as GdkDragContext ptr
	time as guint32
	x_root as gshort
	y_root as gshort
end type

union _GdkEvent
	as GdkEventType type
	any as GdkEventAny
	expose as GdkEventExpose
	visibility as GdkEventVisibility
	motion as GdkEventMotion
	button as GdkEventButton
	touch as GdkEventTouch
	scroll as GdkEventScroll
	key as GdkEventKey
	crossing as GdkEventCrossing
	focus_change as GdkEventFocus
	configure as GdkEventConfigure
	property as GdkEventProperty
	selection as GdkEventSelection
	owner_change as GdkEventOwnerChange
	proximity as GdkEventProximity
	dnd as GdkEventDND
	window_state as GdkEventWindowState
	setting as GdkEventSetting
	grab_broken as GdkEventGrabBroken
end union

declare function gdk_event_get_type() as GType
declare function gdk_event_sequence_get_type() as GType
declare function gdk_events_pending() as gboolean
declare function gdk_event_get() as GdkEvent ptr
declare function gdk_event_peek() as GdkEvent ptr
declare sub gdk_event_put(byval event as const GdkEvent ptr)
declare function gdk_event_new(byval type as GdkEventType) as GdkEvent ptr
declare function gdk_event_copy(byval event as const GdkEvent ptr) as GdkEvent ptr
declare sub gdk_event_free(byval event as GdkEvent ptr)
declare function gdk_event_get_window(byval event as const GdkEvent ptr) as GdkWindow ptr
declare function gdk_event_get_time(byval event as const GdkEvent ptr) as guint32
declare function gdk_event_get_state(byval event as const GdkEvent ptr, byval state as GdkModifierType ptr) as gboolean
declare function gdk_event_get_coords(byval event as const GdkEvent ptr, byval x_win as gdouble ptr, byval y_win as gdouble ptr) as gboolean
declare function gdk_event_get_root_coords(byval event as const GdkEvent ptr, byval x_root as gdouble ptr, byval y_root as gdouble ptr) as gboolean
declare function gdk_event_get_button(byval event as const GdkEvent ptr, byval button as guint ptr) as gboolean
declare function gdk_event_get_click_count(byval event as const GdkEvent ptr, byval click_count as guint ptr) as gboolean
declare function gdk_event_get_keyval(byval event as const GdkEvent ptr, byval keyval as guint ptr) as gboolean
declare function gdk_event_get_keycode(byval event as const GdkEvent ptr, byval keycode as guint16 ptr) as gboolean
declare function gdk_event_get_scroll_direction(byval event as const GdkEvent ptr, byval direction as GdkScrollDirection ptr) as gboolean
declare function gdk_event_get_scroll_deltas(byval event as const GdkEvent ptr, byval delta_x as gdouble ptr, byval delta_y as gdouble ptr) as gboolean
declare function gdk_event_get_axis(byval event as const GdkEvent ptr, byval axis_use as GdkAxisUse, byval value as gdouble ptr) as gboolean
declare sub gdk_event_set_device(byval event as GdkEvent ptr, byval device as GdkDevice ptr)
declare function gdk_event_get_device(byval event as const GdkEvent ptr) as GdkDevice ptr
declare sub gdk_event_set_source_device(byval event as GdkEvent ptr, byval device as GdkDevice ptr)
declare function gdk_event_get_source_device(byval event as const GdkEvent ptr) as GdkDevice ptr
declare sub gdk_event_request_motions(byval event as const GdkEventMotion ptr)
declare function gdk_event_triggers_context_menu(byval event as const GdkEvent ptr) as gboolean
declare function gdk_events_get_distance(byval event1 as GdkEvent ptr, byval event2 as GdkEvent ptr, byval distance as gdouble ptr) as gboolean
declare function gdk_events_get_angle(byval event1 as GdkEvent ptr, byval event2 as GdkEvent ptr, byval angle as gdouble ptr) as gboolean
declare function gdk_events_get_center(byval event1 as GdkEvent ptr, byval event2 as GdkEvent ptr, byval x as gdouble ptr, byval y as gdouble ptr) as gboolean
declare sub gdk_event_handler_set(byval func as GdkEventFunc, byval data as gpointer, byval notify as GDestroyNotify)
declare sub gdk_event_set_screen(byval event as GdkEvent ptr, byval screen as GdkScreen ptr)
declare function gdk_event_get_screen(byval event as const GdkEvent ptr) as GdkScreen ptr
declare function gdk_event_get_event_sequence(byval event as const GdkEvent ptr) as GdkEventSequence ptr
declare function gdk_event_get_event_type(byval event as const GdkEvent ptr) as GdkEventType
declare sub gdk_set_show_events(byval show_events as gboolean)
declare function gdk_get_show_events() as gboolean
declare function gdk_setting_get(byval name as const gchar ptr, byval value as GValue ptr) as gboolean

#define __GDK_DEVICE_MANAGER_H__
#define GDK_TYPE_DEVICE_MANAGER gdk_device_manager_get_type()
#define GDK_DEVICE_MANAGER(o) G_TYPE_CHECK_INSTANCE_CAST((o), GDK_TYPE_DEVICE_MANAGER, GdkDeviceManager)
#define GDK_IS_DEVICE_MANAGER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GDK_TYPE_DEVICE_MANAGER)

declare function gdk_device_manager_get_type() as GType
declare function gdk_device_manager_get_display(byval device_manager as GdkDeviceManager ptr) as GdkDisplay ptr
declare function gdk_device_manager_list_devices(byval device_manager as GdkDeviceManager ptr, byval type as GdkDeviceType) as GList ptr
declare function gdk_device_manager_get_client_pointer(byval device_manager as GdkDeviceManager ptr) as GdkDevice ptr

#define GDK_TYPE_DISPLAY gdk_display_get_type()
#define GDK_DISPLAY(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_DISPLAY, GdkDisplay)
#define GDK_IS_DISPLAY(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_DISPLAY)
#define GDK_DISPLAY_OBJECT(object) GDK_DISPLAY(object)

declare function gdk_display_get_type() as GType
declare function gdk_display_open(byval display_name as const gchar ptr) as GdkDisplay ptr
declare function gdk_display_get_name(byval display as GdkDisplay ptr) as const gchar ptr
declare function gdk_display_get_n_screens(byval display as GdkDisplay ptr) as gint
declare function gdk_display_get_screen(byval display as GdkDisplay ptr, byval screen_num as gint) as GdkScreen ptr
declare function gdk_display_get_default_screen(byval display as GdkDisplay ptr) as GdkScreen ptr
declare sub gdk_display_pointer_ungrab(byval display as GdkDisplay ptr, byval time_ as guint32)
declare sub gdk_display_keyboard_ungrab(byval display as GdkDisplay ptr, byval time_ as guint32)
declare function gdk_display_pointer_is_grabbed(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_device_is_grabbed(byval display as GdkDisplay ptr, byval device as GdkDevice ptr) as gboolean
declare sub gdk_display_beep(byval display as GdkDisplay ptr)
declare sub gdk_display_sync(byval display as GdkDisplay ptr)
declare sub gdk_display_flush(byval display as GdkDisplay ptr)
declare sub gdk_display_close(byval display as GdkDisplay ptr)
declare function gdk_display_is_closed(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_list_devices(byval display as GdkDisplay ptr) as GList ptr
declare function gdk_display_get_event(byval display as GdkDisplay ptr) as GdkEvent ptr
declare function gdk_display_peek_event(byval display as GdkDisplay ptr) as GdkEvent ptr
declare sub gdk_display_put_event(byval display as GdkDisplay ptr, byval event as const GdkEvent ptr)
declare function gdk_display_has_pending(byval display as GdkDisplay ptr) as gboolean
declare sub gdk_display_set_double_click_time(byval display as GdkDisplay ptr, byval msec as guint)
declare sub gdk_display_set_double_click_distance(byval display as GdkDisplay ptr, byval distance as guint)
declare function gdk_display_get_default() as GdkDisplay ptr
declare sub gdk_display_get_pointer(byval display as GdkDisplay ptr, byval screen as GdkScreen ptr ptr, byval x as gint ptr, byval y as gint ptr, byval mask as GdkModifierType ptr)
declare function gdk_display_get_window_at_pointer(byval display as GdkDisplay ptr, byval win_x as gint ptr, byval win_y as gint ptr) as GdkWindow ptr
declare sub gdk_display_warp_pointer(byval display as GdkDisplay ptr, byval screen as GdkScreen ptr, byval x as gint, byval y as gint)
declare function gdk_display_open_default_libgtk_only() as GdkDisplay ptr
declare function gdk_display_supports_cursor_alpha(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_supports_cursor_color(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_get_default_cursor_size(byval display as GdkDisplay ptr) as guint
declare sub gdk_display_get_maximal_cursor_size(byval display as GdkDisplay ptr, byval width as guint ptr, byval height as guint ptr)
declare function gdk_display_get_default_group(byval display as GdkDisplay ptr) as GdkWindow ptr
declare function gdk_display_supports_selection_notification(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_request_selection_notification(byval display as GdkDisplay ptr, byval selection as GdkAtom) as gboolean
declare function gdk_display_supports_clipboard_persistence(byval display as GdkDisplay ptr) as gboolean
declare sub gdk_display_store_clipboard(byval display as GdkDisplay ptr, byval clipboard_window as GdkWindow ptr, byval time_ as guint32, byval targets as const GdkAtom ptr, byval n_targets as gint)
declare function gdk_display_supports_shapes(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_supports_input_shapes(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_supports_composite(byval display as GdkDisplay ptr) as gboolean
declare sub gdk_display_notify_startup_complete(byval display as GdkDisplay ptr, byval startup_id as const gchar ptr)
declare function gdk_display_get_device_manager(byval display as GdkDisplay ptr) as GdkDeviceManager ptr
declare function gdk_display_get_app_launch_context(byval display as GdkDisplay ptr) as GdkAppLaunchContext ptr

#define GDK_TYPE_SCREEN gdk_screen_get_type()
#define GDK_SCREEN(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_SCREEN, GdkScreen)
#define GDK_IS_SCREEN(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_SCREEN)

declare function gdk_screen_get_type() as GType
declare function gdk_screen_get_system_visual(byval screen as GdkScreen ptr) as GdkVisual ptr
declare function gdk_screen_get_rgba_visual(byval screen as GdkScreen ptr) as GdkVisual ptr
declare function gdk_screen_is_composited(byval screen as GdkScreen ptr) as gboolean
declare function gdk_screen_get_root_window(byval screen as GdkScreen ptr) as GdkWindow ptr
declare function gdk_screen_get_display(byval screen as GdkScreen ptr) as GdkDisplay ptr
declare function gdk_screen_get_number(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_width(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_height(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_width_mm(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_height_mm(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_list_visuals(byval screen as GdkScreen ptr) as GList ptr
declare function gdk_screen_get_toplevel_windows(byval screen as GdkScreen ptr) as GList ptr
declare function gdk_screen_make_display_name(byval screen as GdkScreen ptr) as gchar ptr
declare function gdk_screen_get_n_monitors(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_primary_monitor(byval screen as GdkScreen ptr) as gint
declare sub gdk_screen_get_monitor_geometry(byval screen as GdkScreen ptr, byval monitor_num as gint, byval dest as GdkRectangle ptr)
declare sub gdk_screen_get_monitor_workarea(byval screen as GdkScreen ptr, byval monitor_num as gint, byval dest as GdkRectangle ptr)
declare function gdk_screen_get_monitor_at_point(byval screen as GdkScreen ptr, byval x as gint, byval y as gint) as gint
declare function gdk_screen_get_monitor_at_window(byval screen as GdkScreen ptr, byval window as GdkWindow ptr) as gint
declare function gdk_screen_get_monitor_width_mm(byval screen as GdkScreen ptr, byval monitor_num as gint) as gint
declare function gdk_screen_get_monitor_height_mm(byval screen as GdkScreen ptr, byval monitor_num as gint) as gint
declare function gdk_screen_get_monitor_plug_name(byval screen as GdkScreen ptr, byval monitor_num as gint) as gchar ptr
declare function gdk_screen_get_monitor_scale_factor(byval screen as GdkScreen ptr, byval monitor_num as gint) as gint
declare function gdk_screen_get_default() as GdkScreen ptr
declare function gdk_screen_get_setting(byval screen as GdkScreen ptr, byval name as const gchar ptr, byval value as GValue ptr) as gboolean
declare sub gdk_screen_set_font_options(byval screen as GdkScreen ptr, byval options as const cairo_font_options_t ptr)
declare function gdk_screen_get_font_options(byval screen as GdkScreen ptr) as const cairo_font_options_t ptr
declare sub gdk_screen_set_resolution(byval screen as GdkScreen ptr, byval dpi as gdouble)
declare function gdk_screen_get_resolution(byval screen as GdkScreen ptr) as gdouble
declare function gdk_screen_get_active_window(byval screen as GdkScreen ptr) as GdkWindow ptr
declare function gdk_screen_get_window_stack(byval screen as GdkScreen ptr) as GList ptr

#define GDK_TYPE_APP_LAUNCH_CONTEXT gdk_app_launch_context_get_type()
#define GDK_APP_LAUNCH_CONTEXT(o) G_TYPE_CHECK_INSTANCE_CAST((o), GDK_TYPE_APP_LAUNCH_CONTEXT, GdkAppLaunchContext)
#define GDK_IS_APP_LAUNCH_CONTEXT(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GDK_TYPE_APP_LAUNCH_CONTEXT)

declare function gdk_app_launch_context_get_type() as GType
declare function gdk_app_launch_context_new() as GdkAppLaunchContext ptr
declare sub gdk_app_launch_context_set_display(byval context as GdkAppLaunchContext ptr, byval display as GdkDisplay ptr)
declare sub gdk_app_launch_context_set_screen(byval context as GdkAppLaunchContext ptr, byval screen as GdkScreen ptr)
declare sub gdk_app_launch_context_set_desktop(byval context as GdkAppLaunchContext ptr, byval desktop as gint)
declare sub gdk_app_launch_context_set_timestamp(byval context as GdkAppLaunchContext ptr, byval timestamp as guint32)
declare sub gdk_app_launch_context_set_icon(byval context as GdkAppLaunchContext ptr, byval icon as GIcon ptr)
declare sub gdk_app_launch_context_set_icon_name(byval context as GdkAppLaunchContext ptr, byval icon_name as const zstring ptr)
#define __GDK_CAIRO_H__
#define __GDK_COLOR_H__

type _GdkColor
	pixel as guint32
	red as guint16
	green as guint16
	blue as guint16
end type

#define GDK_TYPE_COLOR gdk_color_get_type()
declare function gdk_color_get_type() as GType
declare function gdk_color_copy(byval color as const GdkColor ptr) as GdkColor ptr
declare sub gdk_color_free(byval color as GdkColor ptr)
declare function gdk_color_hash(byval color as const GdkColor ptr) as guint
declare function gdk_color_equal(byval colora as const GdkColor ptr, byval colorb as const GdkColor ptr) as gboolean
declare function gdk_color_parse(byval spec as const gchar ptr, byval color as GdkColor ptr) as gboolean
declare function gdk_color_to_string(byval color as const GdkColor ptr) as gchar ptr
#define __GDK_RGBA_H__

type _GdkRGBA
	red as gdouble
	green as gdouble
	blue as gdouble
	alpha as gdouble
end type

#define GDK_TYPE_RGBA gdk_rgba_get_type()
declare function gdk_rgba_get_type() as GType
declare function gdk_rgba_copy(byval rgba_ as const GdkRGBA ptr) as GdkRGBA ptr
declare sub gdk_rgba_free(byval rgba_ as GdkRGBA ptr)
declare function gdk_rgba_hash(byval p as gconstpointer) as guint
declare function gdk_rgba_equal(byval p1 as gconstpointer, byval p2 as gconstpointer) as gboolean
declare function gdk_rgba_parse(byval rgba_ as GdkRGBA ptr, byval spec as const gchar ptr) as gboolean
declare function gdk_rgba_to_string(byval rgba_ as const GdkRGBA ptr) as gchar ptr
#define __GDK_PIXBUF_H__
declare function gdk_pixbuf_get_from_window(byval window as GdkWindow ptr, byval src_x as gint, byval src_y as gint, byval width as gint, byval height as gint) as GdkPixbuf ptr
declare function gdk_pixbuf_get_from_surface(byval surface as cairo_surface_t ptr, byval src_x as gint, byval src_y as gint, byval width as gint, byval height as gint) as GdkPixbuf ptr
declare function gdk_cairo_create(byval window as GdkWindow ptr) as cairo_t ptr
declare function gdk_cairo_get_clip_rectangle(byval cr as cairo_t ptr, byval rect as GdkRectangle ptr) as gboolean
declare sub gdk_cairo_set_source_rgba(byval cr as cairo_t ptr, byval rgba_ as const GdkRGBA ptr)
declare sub gdk_cairo_set_source_pixbuf(byval cr as cairo_t ptr, byval pixbuf as const GdkPixbuf ptr, byval pixbuf_x as gdouble, byval pixbuf_y as gdouble)
declare sub gdk_cairo_set_source_window(byval cr as cairo_t ptr, byval window as GdkWindow ptr, byval x as gdouble, byval y as gdouble)
declare sub gdk_cairo_rectangle(byval cr as cairo_t ptr, byval rectangle as const GdkRectangle ptr)
declare sub gdk_cairo_region(byval cr as cairo_t ptr, byval region as const cairo_region_t ptr)
declare function gdk_cairo_region_create_from_surface(byval surface as cairo_surface_t ptr) as cairo_region_t ptr
declare sub gdk_cairo_set_source_color(byval cr as cairo_t ptr, byval color as const GdkColor ptr)
declare function gdk_cairo_surface_create_from_pixbuf(byval pixbuf as const GdkPixbuf ptr, byval scale as long, byval for_window as GdkWindow ptr) as cairo_surface_t ptr
declare sub gdk_cairo_draw_from_gl(byval cr as cairo_t ptr, byval window as GdkWindow ptr, byval source as long, byval source_type as long, byval buffer_scale as long, byval x as long, byval y as long, byval width as long, byval height as long)

#define __GDK_CURSOR_H__
#define GDK_TYPE_CURSOR gdk_cursor_get_type()
#define GDK_CURSOR(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_CURSOR, GdkCursor)
#define GDK_IS_CURSOR(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_CURSOR)

type GdkCursorType as long
enum
	GDK_X_CURSOR = 0
	GDK_ARROW = 2
	GDK_BASED_ARROW_DOWN = 4
	GDK_BASED_ARROW_UP = 6
	GDK_BOAT = 8
	GDK_BOGOSITY = 10
	GDK_BOTTOM_LEFT_CORNER = 12
	GDK_BOTTOM_RIGHT_CORNER = 14
	GDK_BOTTOM_SIDE = 16
	GDK_BOTTOM_TEE = 18
	GDK_BOX_SPIRAL = 20
	GDK_CENTER_PTR = 22
	GDK_CIRCLE = 24
	GDK_CLOCK = 26
	GDK_COFFEE_MUG = 28
	GDK_CROSS = 30
	GDK_CROSS_REVERSE = 32
	GDK_CROSSHAIR = 34
	GDK_DIAMOND_CROSS = 36
	GDK_DOT = 38
	GDK_DOTBOX = 40
	GDK_DOUBLE_ARROW = 42
	GDK_DRAFT_LARGE = 44
	GDK_DRAFT_SMALL = 46
	GDK_DRAPED_BOX = 48
	GDK_EXCHANGE = 50
	GDK_FLEUR = 52
	GDK_GOBBLER = 54
	GDK_GUMBY = 56
	GDK_HAND1 = 58
	GDK_HAND2 = 60
	GDK_HEART = 62
	GDK_ICON = 64
	GDK_IRON_CROSS = 66
	GDK_LEFT_PTR = 68
	GDK_LEFT_SIDE = 70
	GDK_LEFT_TEE = 72
	GDK_LEFTBUTTON = 74
	GDK_LL_ANGLE = 76
	GDK_LR_ANGLE = 78
	GDK_MAN = 80
	GDK_MIDDLEBUTTON = 82
	GDK_MOUSE = 84
	GDK_PENCIL = 86
	GDK_PIRATE = 88
	GDK_PLUS = 90
	GDK_QUESTION_ARROW = 92
	GDK_RIGHT_PTR = 94
	GDK_RIGHT_SIDE = 96
	GDK_RIGHT_TEE = 98
	GDK_RIGHTBUTTON = 100
	GDK_RTL_LOGO = 102
	GDK_SAILBOAT = 104
	GDK_SB_DOWN_ARROW = 106
	GDK_SB_H_DOUBLE_ARROW = 108
	GDK_SB_LEFT_ARROW = 110
	GDK_SB_RIGHT_ARROW = 112
	GDK_SB_UP_ARROW = 114
	GDK_SB_V_DOUBLE_ARROW = 116
	GDK_SHUTTLE = 118
	GDK_SIZING = 120
	GDK_SPIDER = 122
	GDK_SPRAYCAN = 124
	GDK_STAR = 126
	GDK_TARGET = 128
	GDK_TCROSS = 130
	GDK_TOP_LEFT_ARROW = 132
	GDK_TOP_LEFT_CORNER = 134
	GDK_TOP_RIGHT_CORNER = 136
	GDK_TOP_SIDE = 138
	GDK_TOP_TEE = 140
	GDK_TREK = 142
	GDK_UL_ANGLE = 144
	GDK_UMBRELLA = 146
	GDK_UR_ANGLE = 148
	GDK_WATCH = 150
	GDK_XTERM = 152
	GDK_LAST_CURSOR
	GDK_BLANK_CURSOR = -2
	GDK_CURSOR_IS_PIXMAP = -1
end enum

declare function gdk_cursor_get_type() as GType
declare function gdk_cursor_new_for_display(byval display as GdkDisplay ptr, byval cursor_type as GdkCursorType) as GdkCursor ptr
declare function gdk_cursor_new(byval cursor_type as GdkCursorType) as GdkCursor ptr
declare function gdk_cursor_new_from_pixbuf(byval display as GdkDisplay ptr, byval pixbuf as GdkPixbuf ptr, byval x as gint, byval y as gint) as GdkCursor ptr
declare function gdk_cursor_new_from_surface(byval display as GdkDisplay ptr, byval surface as cairo_surface_t ptr, byval x as gdouble, byval y as gdouble) as GdkCursor ptr
declare function gdk_cursor_new_from_name(byval display as GdkDisplay ptr, byval name as const gchar ptr) as GdkCursor ptr
declare function gdk_cursor_get_display(byval cursor as GdkCursor ptr) as GdkDisplay ptr
declare function gdk_cursor_ref(byval cursor as GdkCursor ptr) as GdkCursor ptr
declare sub gdk_cursor_unref(byval cursor as GdkCursor ptr)
declare function gdk_cursor_get_image(byval cursor as GdkCursor ptr) as GdkPixbuf ptr
declare function gdk_cursor_get_surface(byval cursor as GdkCursor ptr, byval x_hot as gdouble ptr, byval y_hot as gdouble ptr) as cairo_surface_t ptr
declare function gdk_cursor_get_cursor_type(byval cursor as GdkCursor ptr) as GdkCursorType

#define __GDK_DISPLAY_MANAGER_H__
#define GDK_TYPE_DISPLAY_MANAGER gdk_display_manager_get_type()
#define GDK_DISPLAY_MANAGER(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManager)
#define GDK_IS_DISPLAY_MANAGER(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_DISPLAY_MANAGER)

declare function gdk_display_manager_get_type() as GType
declare function gdk_display_manager_get() as GdkDisplayManager ptr
declare function gdk_display_manager_get_default_display(byval manager as GdkDisplayManager ptr) as GdkDisplay ptr
declare sub gdk_display_manager_set_default_display(byval manager as GdkDisplayManager ptr, byval display as GdkDisplay ptr)
declare function gdk_display_manager_list_displays(byval manager as GdkDisplayManager ptr) as GSList ptr
declare function gdk_display_manager_open_display(byval manager as GdkDisplayManager ptr, byval name as const gchar ptr) as GdkDisplay ptr
#define __GDK_ENUM_TYPES_H__
declare function gdk_cursor_type_get_type() as GType
#define GDK_TYPE_CURSOR_TYPE gdk_cursor_type_get_type()
declare function gdk_input_source_get_type() as GType
#define GDK_TYPE_INPUT_SOURCE gdk_input_source_get_type()
declare function gdk_input_mode_get_type() as GType
#define GDK_TYPE_INPUT_MODE gdk_input_mode_get_type()
declare function gdk_axis_use_get_type() as GType
#define GDK_TYPE_AXIS_USE gdk_axis_use_get_type()
declare function gdk_device_type_get_type() as GType
#define GDK_TYPE_DEVICE_TYPE gdk_device_type_get_type()
declare function gdk_drag_action_get_type() as GType
#define GDK_TYPE_DRAG_ACTION gdk_drag_action_get_type()
declare function gdk_drag_protocol_get_type() as GType
#define GDK_TYPE_DRAG_PROTOCOL gdk_drag_protocol_get_type()
declare function gdk_filter_return_get_type() as GType
#define GDK_TYPE_FILTER_RETURN gdk_filter_return_get_type()
declare function gdk_event_type_get_type() as GType
#define GDK_TYPE_EVENT_TYPE gdk_event_type_get_type()
declare function gdk_visibility_state_get_type() as GType
#define GDK_TYPE_VISIBILITY_STATE gdk_visibility_state_get_type()
declare function gdk_scroll_direction_get_type() as GType
#define GDK_TYPE_SCROLL_DIRECTION gdk_scroll_direction_get_type()
declare function gdk_notify_type_get_type() as GType
#define GDK_TYPE_NOTIFY_TYPE gdk_notify_type_get_type()
declare function gdk_crossing_mode_get_type() as GType
#define GDK_TYPE_CROSSING_MODE gdk_crossing_mode_get_type()
declare function gdk_property_state_get_type() as GType
#define GDK_TYPE_PROPERTY_STATE gdk_property_state_get_type()
declare function gdk_window_state_get_type() as GType
#define GDK_TYPE_WINDOW_STATE gdk_window_state_get_type()
declare function gdk_setting_action_get_type() as GType
#define GDK_TYPE_SETTING_ACTION gdk_setting_action_get_type()
declare function gdk_owner_change_get_type() as GType
#define GDK_TYPE_OWNER_CHANGE gdk_owner_change_get_type()
declare function gdk_frame_clock_phase_get_type() as GType
#define GDK_TYPE_FRAME_CLOCK_PHASE gdk_frame_clock_phase_get_type()
declare function gdk_prop_mode_get_type() as GType
#define GDK_TYPE_PROP_MODE gdk_prop_mode_get_type()
declare function gdk_byte_order_get_type() as GType
#define GDK_TYPE_BYTE_ORDER gdk_byte_order_get_type()
declare function gdk_modifier_type_get_type() as GType
#define GDK_TYPE_MODIFIER_TYPE gdk_modifier_type_get_type()
declare function gdk_modifier_intent_get_type() as GType
#define GDK_TYPE_MODIFIER_INTENT gdk_modifier_intent_get_type()
declare function gdk_status_get_type() as GType
#define GDK_TYPE_STATUS gdk_status_get_type()
declare function gdk_grab_status_get_type() as GType
#define GDK_TYPE_GRAB_STATUS gdk_grab_status_get_type()
declare function gdk_grab_ownership_get_type() as GType
#define GDK_TYPE_GRAB_OWNERSHIP gdk_grab_ownership_get_type()
declare function gdk_event_mask_get_type() as GType
#define GDK_TYPE_EVENT_MASK gdk_event_mask_get_type()
declare function gdk_gl_error_get_type() as GType
#define GDK_TYPE_GL_ERROR gdk_gl_error_get_type()
declare function gdk_visual_type_get_type() as GType
#define GDK_TYPE_VISUAL_TYPE gdk_visual_type_get_type()
declare function gdk_window_window_class_get_type() as GType
#define GDK_TYPE_WINDOW_WINDOW_CLASS gdk_window_window_class_get_type()
declare function gdk_window_type_get_type() as GType
#define GDK_TYPE_WINDOW_TYPE gdk_window_type_get_type()
declare function gdk_window_attributes_type_get_type() as GType
#define GDK_TYPE_WINDOW_ATTRIBUTES_TYPE gdk_window_attributes_type_get_type()
declare function gdk_window_hints_get_type() as GType
#define GDK_TYPE_WINDOW_HINTS gdk_window_hints_get_type()
declare function gdk_window_type_hint_get_type() as GType
#define GDK_TYPE_WINDOW_TYPE_HINT gdk_window_type_hint_get_type()
declare function gdk_wm_decoration_get_type() as GType
#define GDK_TYPE_WM_DECORATION gdk_wm_decoration_get_type()
declare function gdk_wm_function_get_type() as GType
#define GDK_TYPE_WM_FUNCTION gdk_wm_function_get_type()
declare function gdk_gravity_get_type() as GType
#define GDK_TYPE_GRAVITY gdk_gravity_get_type()
declare function gdk_window_edge_get_type() as GType
#define GDK_TYPE_WINDOW_EDGE gdk_window_edge_get_type()
declare function gdk_fullscreen_mode_get_type() as GType

#define GDK_TYPE_FULLSCREEN_MODE gdk_fullscreen_mode_get_type()
#define __GDK_FRAME_CLOCK_H__
#define __GDK_FRAME_TIMINGS_H__
type GdkFrameTimings as _GdkFrameTimings

declare function gdk_frame_timings_get_type() as GType
declare function gdk_frame_timings_ref(byval timings as GdkFrameTimings ptr) as GdkFrameTimings ptr
declare sub gdk_frame_timings_unref(byval timings as GdkFrameTimings ptr)
declare function gdk_frame_timings_get_frame_counter(byval timings as GdkFrameTimings ptr) as gint64
declare function gdk_frame_timings_get_complete(byval timings as GdkFrameTimings ptr) as gboolean
declare function gdk_frame_timings_get_frame_time(byval timings as GdkFrameTimings ptr) as gint64
declare function gdk_frame_timings_get_presentation_time(byval timings as GdkFrameTimings ptr) as gint64
declare function gdk_frame_timings_get_refresh_interval(byval timings as GdkFrameTimings ptr) as gint64
declare function gdk_frame_timings_get_predicted_presentation_time(byval timings as GdkFrameTimings ptr) as gint64

#define GDK_TYPE_FRAME_CLOCK gdk_frame_clock_get_type()
#define GDK_FRAME_CLOCK(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GDK_TYPE_FRAME_CLOCK, GdkFrameClock)
#define GDK_FRAME_CLOCK_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_FRAME_CLOCK, GdkFrameClockClass)
#define GDK_IS_FRAME_CLOCK(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GDK_TYPE_FRAME_CLOCK)
#define GDK_IS_FRAME_CLOCK_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_FRAME_CLOCK)
#define GDK_FRAME_CLOCK_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_FRAME_CLOCK, GdkFrameClockClass)

type GdkFrameClock as _GdkFrameClock
type GdkFrameClockPrivate as _GdkFrameClockPrivate
type GdkFrameClockClass as _GdkFrameClockClass

type GdkFrameClockPhase as long
enum
	GDK_FRAME_CLOCK_PHASE_NONE = 0
	GDK_FRAME_CLOCK_PHASE_FLUSH_EVENTS = 1 shl 0
	GDK_FRAME_CLOCK_PHASE_BEFORE_PAINT = 1 shl 1
	GDK_FRAME_CLOCK_PHASE_UPDATE = 1 shl 2
	GDK_FRAME_CLOCK_PHASE_LAYOUT = 1 shl 3
	GDK_FRAME_CLOCK_PHASE_PAINT = 1 shl 4
	GDK_FRAME_CLOCK_PHASE_RESUME_EVENTS = 1 shl 5
	GDK_FRAME_CLOCK_PHASE_AFTER_PAINT = 1 shl 6
end enum

declare function gdk_frame_clock_get_type() as GType
declare function gdk_frame_clock_get_frame_time(byval frame_clock as GdkFrameClock ptr) as gint64
declare sub gdk_frame_clock_request_phase(byval frame_clock as GdkFrameClock ptr, byval phase as GdkFrameClockPhase)
declare sub gdk_frame_clock_begin_updating(byval frame_clock as GdkFrameClock ptr)
declare sub gdk_frame_clock_end_updating(byval frame_clock as GdkFrameClock ptr)
declare function gdk_frame_clock_get_frame_counter(byval frame_clock as GdkFrameClock ptr) as gint64
declare function gdk_frame_clock_get_history_start(byval frame_clock as GdkFrameClock ptr) as gint64
declare function gdk_frame_clock_get_timings(byval frame_clock as GdkFrameClock ptr, byval frame_counter as gint64) as GdkFrameTimings ptr
declare function gdk_frame_clock_get_current_timings(byval frame_clock as GdkFrameClock ptr) as GdkFrameTimings ptr
declare sub gdk_frame_clock_get_refresh_info(byval frame_clock as GdkFrameClock ptr, byval base_time as gint64, byval refresh_interval_return as gint64 ptr, byval presentation_time_return as gint64 ptr)

#define __GDK_GL_CONTEXT_H__
#define GDK_TYPE_GL_CONTEXT gdk_gl_context_get_type()
#define GDK_GL_CONTEXT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GDK_TYPE_GL_CONTEXT, GdkGLContext)
#define GDK_IS_GL_CONTEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GDK_TYPE_GL_CONTEXT)
#define GDK_GL_ERROR gdk_gl_error_quark()

declare function gdk_gl_error_quark() as GQuark
declare function gdk_gl_context_get_type() as GType
declare function gdk_gl_context_get_display(byval context as GdkGLContext ptr) as GdkDisplay ptr
declare function gdk_gl_context_get_window(byval context as GdkGLContext ptr) as GdkWindow ptr
declare function gdk_gl_context_get_shared_context(byval context as GdkGLContext ptr) as GdkGLContext ptr
declare sub gdk_gl_context_get_version(byval context as GdkGLContext ptr, byval major as long ptr, byval minor as long ptr)
declare sub gdk_gl_context_set_required_version(byval context as GdkGLContext ptr, byval major as long, byval minor as long)
declare sub gdk_gl_context_get_required_version(byval context as GdkGLContext ptr, byval major as long ptr, byval minor as long ptr)
declare sub gdk_gl_context_set_debug_enabled(byval context as GdkGLContext ptr, byval enabled as gboolean)
declare function gdk_gl_context_get_debug_enabled(byval context as GdkGLContext ptr) as gboolean
declare sub gdk_gl_context_set_forward_compatible(byval context as GdkGLContext ptr, byval compatible as gboolean)
declare function gdk_gl_context_get_forward_compatible(byval context as GdkGLContext ptr) as gboolean
declare function gdk_gl_context_realize(byval context as GdkGLContext ptr, byval error as GError ptr ptr) as gboolean
declare sub gdk_gl_context_make_current(byval context as GdkGLContext ptr)
declare function gdk_gl_context_get_current() as GdkGLContext ptr
declare sub gdk_gl_context_clear_current()
#define __GDK_KEYS_H__
type GdkKeymapKey as _GdkKeymapKey

type _GdkKeymapKey
	keycode as guint
	group as gint
	level as gint
end type

#define GDK_TYPE_KEYMAP gdk_keymap_get_type()
#define GDK_KEYMAP(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_KEYMAP, GdkKeymap)
#define GDK_IS_KEYMAP(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_KEYMAP)

declare function gdk_keymap_get_type() as GType
declare function gdk_keymap_get_default() as GdkKeymap ptr
declare function gdk_keymap_get_for_display(byval display as GdkDisplay ptr) as GdkKeymap ptr
declare function gdk_keymap_lookup_key(byval keymap as GdkKeymap ptr, byval key as const GdkKeymapKey ptr) as guint
declare function gdk_keymap_translate_keyboard_state(byval keymap as GdkKeymap ptr, byval hardware_keycode as guint, byval state as GdkModifierType, byval group as gint, byval keyval as guint ptr, byval effective_group as gint ptr, byval level as gint ptr, byval consumed_modifiers as GdkModifierType ptr) as gboolean
declare function gdk_keymap_get_entries_for_keyval(byval keymap as GdkKeymap ptr, byval keyval as guint, byval keys as GdkKeymapKey ptr ptr, byval n_keys as gint ptr) as gboolean
declare function gdk_keymap_get_entries_for_keycode(byval keymap as GdkKeymap ptr, byval hardware_keycode as guint, byval keys as GdkKeymapKey ptr ptr, byval keyvals as guint ptr ptr, byval n_entries as gint ptr) as gboolean
declare function gdk_keymap_get_direction(byval keymap as GdkKeymap ptr) as PangoDirection
declare function gdk_keymap_have_bidi_layouts(byval keymap as GdkKeymap ptr) as gboolean
declare function gdk_keymap_get_caps_lock_state(byval keymap as GdkKeymap ptr) as gboolean
declare function gdk_keymap_get_num_lock_state(byval keymap as GdkKeymap ptr) as gboolean
declare function gdk_keymap_get_modifier_state(byval keymap as GdkKeymap ptr) as guint
declare sub gdk_keymap_add_virtual_modifiers(byval keymap as GdkKeymap ptr, byval state as GdkModifierType ptr)
declare function gdk_keymap_map_virtual_modifiers(byval keymap as GdkKeymap ptr, byval state as GdkModifierType ptr) as gboolean
declare function gdk_keymap_get_modifier_mask(byval keymap as GdkKeymap ptr, byval intent as GdkModifierIntent) as GdkModifierType
declare function gdk_keyval_name(byval keyval as guint) as gchar ptr
declare function gdk_keyval_from_name(byval keyval_name as const gchar ptr) as guint
declare sub gdk_keyval_convert_case(byval symbol as guint, byval lower as guint ptr, byval upper as guint ptr)
declare function gdk_keyval_to_upper(byval keyval as guint) as guint
declare function gdk_keyval_to_lower(byval keyval as guint) as guint
declare function gdk_keyval_is_upper(byval keyval as guint) as gboolean
declare function gdk_keyval_is_lower(byval keyval as guint) as gboolean
declare function gdk_keyval_to_unicode(byval keyval as guint) as guint32
declare function gdk_unicode_to_keyval(byval wc as guint32) as guint

#define __GDK_KEYSYMS_H__
const GDK_KEY_VoidSymbol = &hffffff
const GDK_KEY_BackSpace = &hff08
const GDK_KEY_Tab = &hff09
const GDK_KEY_Linefeed = &hff0a
const GDK_KEY_Clear = &hff0b
const GDK_KEY_Return = &hff0d
const GDK_KEY_Pause = &hff13
const GDK_KEY_Scroll_Lock = &hff14
const GDK_KEY_Sys_Req = &hff15
const GDK_KEY_Escape = &hff1b
const GDK_KEY_Delete = &hffff
const GDK_KEY_Multi_key = &hff20
const GDK_KEY_Codeinput = &hff37
const GDK_KEY_SingleCandidate = &hff3c
const GDK_KEY_MultipleCandidate = &hff3d
const GDK_KEY_PreviousCandidate = &hff3e
const GDK_KEY_Kanji = &hff21
const GDK_KEY_Muhenkan = &hff22
const GDK_KEY_Henkan_Mode = &hff23
const GDK_KEY_Henkan = &hff23
const GDK_KEY_Romaji = &hff24
const GDK_KEY_Hiragana = &hff25
const GDK_KEY_Katakana = &hff26
const GDK_KEY_Hiragana_Katakana = &hff27
const GDK_KEY_Zenkaku = &hff28
const GDK_KEY_Hankaku = &hff29
const GDK_KEY_Zenkaku_Hankaku = &hff2a
const GDK_KEY_Touroku = &hff2b
const GDK_KEY_Massyo = &hff2c
const GDK_KEY_Kana_Lock = &hff2d
const GDK_KEY_Kana_Shift = &hff2e
const GDK_KEY_Eisu_Shift = &hff2f
const GDK_KEY_Eisu_toggle = &hff30
const GDK_KEY_Kanji_Bangou = &hff37
const GDK_KEY_Zen_Koho = &hff3d
const GDK_KEY_Mae_Koho = &hff3e
const GDK_KEY_Home = &hff50
const GDK_KEY_Left = &hff51
const GDK_KEY_Up = &hff52
const GDK_KEY_Right = &hff53
const GDK_KEY_Down = &hff54
const GDK_KEY_Prior = &hff55
const GDK_KEY_Page_Up = &hff55
const GDK_KEY_Next = &hff56
const GDK_KEY_Page_Down = &hff56
const GDK_KEY_End = &hff57
const GDK_KEY_Begin = &hff58
const GDK_KEY_Select = &hff60
const GDK_KEY_Print = &hff61
const GDK_KEY_Execute = &hff62
const GDK_KEY_Insert = &hff63
const GDK_KEY_Undo = &hff65
const GDK_KEY_Redo = &hff66
const GDK_KEY_Menu = &hff67
const GDK_KEY_Find = &hff68
const GDK_KEY_Cancel = &hff69
const GDK_KEY_Help = &hff6a
const GDK_KEY_Break = &hff6b
const GDK_KEY_Mode_switch = &hff7e
const GDK_KEY_script_switch = &hff7e
const GDK_KEY_Num_Lock = &hff7f
const GDK_KEY_KP_Space = &hff80
const GDK_KEY_KP_Tab = &hff89
const GDK_KEY_KP_Enter = &hff8d
const GDK_KEY_KP_F1 = &hff91
const GDK_KEY_KP_F2 = &hff92
const GDK_KEY_KP_F3 = &hff93
const GDK_KEY_KP_F4 = &hff94
const GDK_KEY_KP_Home = &hff95
const GDK_KEY_KP_Left = &hff96
const GDK_KEY_KP_Up = &hff97
const GDK_KEY_KP_Right = &hff98
const GDK_KEY_KP_Down = &hff99
const GDK_KEY_KP_Prior = &hff9a
const GDK_KEY_KP_Page_Up = &hff9a
const GDK_KEY_KP_Next = &hff9b
const GDK_KEY_KP_Page_Down = &hff9b
const GDK_KEY_KP_End = &hff9c
const GDK_KEY_KP_Begin = &hff9d
const GDK_KEY_KP_Insert = &hff9e
const GDK_KEY_KP_Delete = &hff9f
const GDK_KEY_KP_Equal = &hffbd
const GDK_KEY_KP_Multiply = &hffaa
const GDK_KEY_KP_Add = &hffab
const GDK_KEY_KP_Separator = &hffac
const GDK_KEY_KP_Subtract = &hffad
const GDK_KEY_KP_Decimal = &hffae
const GDK_KEY_KP_Divide = &hffaf
const GDK_KEY_KP_0 = &hffb0
const GDK_KEY_KP_1 = &hffb1
const GDK_KEY_KP_2 = &hffb2
const GDK_KEY_KP_3 = &hffb3
const GDK_KEY_KP_4 = &hffb4
const GDK_KEY_KP_5 = &hffb5
const GDK_KEY_KP_6 = &hffb6
const GDK_KEY_KP_7 = &hffb7
const GDK_KEY_KP_8 = &hffb8
const GDK_KEY_KP_9 = &hffb9
const GDK_KEY_F1 = &hffbe
const GDK_KEY_F2 = &hffbf
const GDK_KEY_F3 = &hffc0
const GDK_KEY_F4 = &hffc1
const GDK_KEY_F5 = &hffc2
const GDK_KEY_F6 = &hffc3
const GDK_KEY_F7 = &hffc4
const GDK_KEY_F8 = &hffc5
const GDK_KEY_F9 = &hffc6
const GDK_KEY_F10 = &hffc7
const GDK_KEY_F11 = &hffc8
const GDK_KEY_L1 = &hffc8
const GDK_KEY_F12 = &hffc9
const GDK_KEY_L2 = &hffc9
const GDK_KEY_F13 = &hffca
const GDK_KEY_L3 = &hffca
const GDK_KEY_F14 = &hffcb
const GDK_KEY_L4 = &hffcb
const GDK_KEY_F15 = &hffcc
const GDK_KEY_L5 = &hffcc
const GDK_KEY_F16 = &hffcd
const GDK_KEY_L6 = &hffcd
const GDK_KEY_F17 = &hffce
const GDK_KEY_L7 = &hffce
const GDK_KEY_F18 = &hffcf
const GDK_KEY_L8 = &hffcf
const GDK_KEY_F19 = &hffd0
const GDK_KEY_L9 = &hffd0
const GDK_KEY_F20 = &hffd1
const GDK_KEY_L10 = &hffd1
const GDK_KEY_F21 = &hffd2
const GDK_KEY_R1 = &hffd2
const GDK_KEY_F22 = &hffd3
const GDK_KEY_R2 = &hffd3
const GDK_KEY_F23 = &hffd4
const GDK_KEY_R3 = &hffd4
const GDK_KEY_F24 = &hffd5
const GDK_KEY_R4 = &hffd5
const GDK_KEY_F25 = &hffd6
const GDK_KEY_R5 = &hffd6
const GDK_KEY_F26 = &hffd7
const GDK_KEY_R6 = &hffd7
const GDK_KEY_F27 = &hffd8
const GDK_KEY_R7 = &hffd8
const GDK_KEY_F28 = &hffd9
const GDK_KEY_R8 = &hffd9
const GDK_KEY_F29 = &hffda
const GDK_KEY_R9 = &hffda
const GDK_KEY_F30 = &hffdb
const GDK_KEY_R10 = &hffdb
const GDK_KEY_F31 = &hffdc
const GDK_KEY_R11 = &hffdc
const GDK_KEY_F32 = &hffdd
const GDK_KEY_R12 = &hffdd
const GDK_KEY_F33 = &hffde
const GDK_KEY_R13 = &hffde
const GDK_KEY_F34 = &hffdf
const GDK_KEY_R14 = &hffdf
const GDK_KEY_F35 = &hffe0
const GDK_KEY_R15 = &hffe0
const GDK_KEY_Shift_L = &hffe1
const GDK_KEY_Shift_R = &hffe2
const GDK_KEY_Control_L = &hffe3
const GDK_KEY_Control_R = &hffe4
const GDK_KEY_Caps_Lock = &hffe5
const GDK_KEY_Shift_Lock = &hffe6
const GDK_KEY_Meta_L = &hffe7
const GDK_KEY_Meta_R = &hffe8
const GDK_KEY_Alt_L = &hffe9
const GDK_KEY_Alt_R = &hffea
const GDK_KEY_Super_L = &hffeb
const GDK_KEY_Super_R = &hffec
const GDK_KEY_Hyper_L = &hffed
const GDK_KEY_Hyper_R = &hffee
const GDK_KEY_ISO_Lock = &hfe01
const GDK_KEY_ISO_Level2_Latch = &hfe02
const GDK_KEY_ISO_Level3_Shift = &hfe03
const GDK_KEY_ISO_Level3_Latch = &hfe04
const GDK_KEY_ISO_Level3_Lock = &hfe05
const GDK_KEY_ISO_Level5_Shift = &hfe11
const GDK_KEY_ISO_Level5_Latch = &hfe12
const GDK_KEY_ISO_Level5_Lock = &hfe13
const GDK_KEY_ISO_Group_Shift = &hff7e
const GDK_KEY_ISO_Group_Latch = &hfe06
const GDK_KEY_ISO_Group_Lock = &hfe07
const GDK_KEY_ISO_Next_Group = &hfe08
const GDK_KEY_ISO_Next_Group_Lock = &hfe09
const GDK_KEY_ISO_Prev_Group = &hfe0a
const GDK_KEY_ISO_Prev_Group_Lock = &hfe0b
const GDK_KEY_ISO_First_Group = &hfe0c
const GDK_KEY_ISO_First_Group_Lock = &hfe0d
const GDK_KEY_ISO_Last_Group = &hfe0e
const GDK_KEY_ISO_Last_Group_Lock = &hfe0f
const GDK_KEY_ISO_Left_Tab = &hfe20
const GDK_KEY_ISO_Move_Line_Up = &hfe21
const GDK_KEY_ISO_Move_Line_Down = &hfe22
const GDK_KEY_ISO_Partial_Line_Up = &hfe23
const GDK_KEY_ISO_Partial_Line_Down = &hfe24
const GDK_KEY_ISO_Partial_Space_Left = &hfe25
const GDK_KEY_ISO_Partial_Space_Right = &hfe26
const GDK_KEY_ISO_Set_Margin_Left = &hfe27
const GDK_KEY_ISO_Set_Margin_Right = &hfe28
const GDK_KEY_ISO_Release_Margin_Left = &hfe29
const GDK_KEY_ISO_Release_Margin_Right = &hfe2a
const GDK_KEY_ISO_Release_Both_Margins = &hfe2b
const GDK_KEY_ISO_Fast_Cursor_Left = &hfe2c
const GDK_KEY_ISO_Fast_Cursor_Right = &hfe2d
const GDK_KEY_ISO_Fast_Cursor_Up = &hfe2e
const GDK_KEY_ISO_Fast_Cursor_Down = &hfe2f
const GDK_KEY_ISO_Continuous_Underline = &hfe30
const GDK_KEY_ISO_Discontinuous_Underline = &hfe31
const GDK_KEY_ISO_Emphasize = &hfe32
const GDK_KEY_ISO_Center_Object = &hfe33
const GDK_KEY_ISO_Enter = &hfe34
const GDK_KEY_dead_grave = &hfe50
const GDK_KEY_dead_acute = &hfe51
const GDK_KEY_dead_circumflex = &hfe52
const GDK_KEY_dead_tilde = &hfe53
const GDK_KEY_dead_perispomeni = &hfe53
const GDK_KEY_dead_macron = &hfe54
const GDK_KEY_dead_breve = &hfe55
const GDK_KEY_dead_abovedot = &hfe56
const GDK_KEY_dead_diaeresis = &hfe57
const GDK_KEY_dead_abovering = &hfe58
const GDK_KEY_dead_doubleacute = &hfe59
const GDK_KEY_dead_caron = &hfe5a
const GDK_KEY_dead_cedilla = &hfe5b
const GDK_KEY_dead_ogonek = &hfe5c
const GDK_KEY_dead_iota = &hfe5d
const GDK_KEY_dead_voiced_sound = &hfe5e
const GDK_KEY_dead_semivoiced_sound = &hfe5f
const GDK_KEY_dead_belowdot = &hfe60
const GDK_KEY_dead_hook = &hfe61
const GDK_KEY_dead_horn = &hfe62
const GDK_KEY_dead_stroke = &hfe63
const GDK_KEY_dead_abovecomma = &hfe64
const GDK_KEY_dead_psili = &hfe64
const GDK_KEY_dead_abovereversedcomma = &hfe65
const GDK_KEY_dead_dasia = &hfe65
const GDK_KEY_dead_doublegrave = &hfe66
const GDK_KEY_dead_belowring = &hfe67
const GDK_KEY_dead_belowmacron = &hfe68
const GDK_KEY_dead_belowcircumflex = &hfe69
const GDK_KEY_dead_belowtilde = &hfe6a
const GDK_KEY_dead_belowbreve = &hfe6b
const GDK_KEY_dead_belowdiaeresis = &hfe6c
const GDK_KEY_dead_invertedbreve = &hfe6d
const GDK_KEY_dead_belowcomma = &hfe6e
const GDK_KEY_dead_currency = &hfe6f
const GDK_KEY_dead_a = &hfe80
const GDK_KEY_dead_A_ = &hfe81
const GDK_KEY_dead_e = &hfe82
const GDK_KEY_dead_E_ = &hfe83
const GDK_KEY_dead_i = &hfe84
const GDK_KEY_dead_I_ = &hfe85
const GDK_KEY_dead_o = &hfe86
const GDK_KEY_dead_O_ = &hfe87
const GDK_KEY_dead_u = &hfe88
const GDK_KEY_dead_U_ = &hfe89
const GDK_KEY_dead_small_schwa = &hfe8a
const GDK_KEY_dead_capital_schwa = &hfe8b
const GDK_KEY_dead_greek = &hfe8c
const GDK_KEY_First_Virtual_Screen = &hfed0
const GDK_KEY_Prev_Virtual_Screen = &hfed1
const GDK_KEY_Next_Virtual_Screen = &hfed2
const GDK_KEY_Last_Virtual_Screen = &hfed4
const GDK_KEY_Terminate_Server = &hfed5
const GDK_KEY_AccessX_Enable = &hfe70
const GDK_KEY_AccessX_Feedback_Enable = &hfe71
const GDK_KEY_RepeatKeys_Enable = &hfe72
const GDK_KEY_SlowKeys_Enable = &hfe73
const GDK_KEY_BounceKeys_Enable = &hfe74
const GDK_KEY_StickyKeys_Enable = &hfe75
const GDK_KEY_MouseKeys_Enable = &hfe76
const GDK_KEY_MouseKeys_Accel_Enable = &hfe77
const GDK_KEY_Overlay1_Enable = &hfe78
const GDK_KEY_Overlay2_Enable = &hfe79
const GDK_KEY_AudibleBell_Enable = &hfe7a
const GDK_KEY_Pointer_Left = &hfee0
const GDK_KEY_Pointer_Right = &hfee1
const GDK_KEY_Pointer_Up = &hfee2
const GDK_KEY_Pointer_Down = &hfee3
const GDK_KEY_Pointer_UpLeft = &hfee4
const GDK_KEY_Pointer_UpRight = &hfee5
const GDK_KEY_Pointer_DownLeft = &hfee6
const GDK_KEY_Pointer_DownRight = &hfee7
const GDK_KEY_Pointer_Button_Dflt = &hfee8
const GDK_KEY_Pointer_Button1 = &hfee9
const GDK_KEY_Pointer_Button2 = &hfeea
const GDK_KEY_Pointer_Button3 = &hfeeb
const GDK_KEY_Pointer_Button4 = &hfeec
const GDK_KEY_Pointer_Button5 = &hfeed
const GDK_KEY_Pointer_DblClick_Dflt = &hfeee
const GDK_KEY_Pointer_DblClick1 = &hfeef
const GDK_KEY_Pointer_DblClick2 = &hfef0
const GDK_KEY_Pointer_DblClick3 = &hfef1
const GDK_KEY_Pointer_DblClick4 = &hfef2
const GDK_KEY_Pointer_DblClick5 = &hfef3
const GDK_KEY_Pointer_Drag_Dflt = &hfef4
const GDK_KEY_Pointer_Drag1 = &hfef5
const GDK_KEY_Pointer_Drag2 = &hfef6
const GDK_KEY_Pointer_Drag3 = &hfef7
const GDK_KEY_Pointer_Drag4 = &hfef8
const GDK_KEY_Pointer_Drag5 = &hfefd
const GDK_KEY_Pointer_EnableKeys = &hfef9
const GDK_KEY_Pointer_Accelerate = &hfefa
const GDK_KEY_Pointer_DfltBtnNext = &hfefb
const GDK_KEY_Pointer_DfltBtnPrev = &hfefc
const GDK_KEY_ch = &hfea0
const GDK_KEY_Ch_ = &hfea1
const GDK_KEY_CH__ = &hfea2
const GDK_KEY_c_h = &hfea3
const GDK_KEY_C_h_ = &hfea4
const GDK_KEY_C_H__ = &hfea5
const GDK_KEY_3270_Duplicate = &hfd01
const GDK_KEY_3270_FieldMark = &hfd02
const GDK_KEY_3270_Right2 = &hfd03
const GDK_KEY_3270_Left2 = &hfd04
const GDK_KEY_3270_BackTab = &hfd05
const GDK_KEY_3270_EraseEOF = &hfd06
const GDK_KEY_3270_EraseInput = &hfd07
const GDK_KEY_3270_Reset = &hfd08
const GDK_KEY_3270_Quit = &hfd09
const GDK_KEY_3270_PA1 = &hfd0a
const GDK_KEY_3270_PA2 = &hfd0b
const GDK_KEY_3270_PA3 = &hfd0c
const GDK_KEY_3270_Test = &hfd0d
const GDK_KEY_3270_Attn = &hfd0e
const GDK_KEY_3270_CursorBlink = &hfd0f
const GDK_KEY_3270_AltCursor = &hfd10
const GDK_KEY_3270_KeyClick = &hfd11
const GDK_KEY_3270_Jump = &hfd12
const GDK_KEY_3270_Ident = &hfd13
const GDK_KEY_3270_Rule = &hfd14
const GDK_KEY_3270_Copy = &hfd15
const GDK_KEY_3270_Play = &hfd16
const GDK_KEY_3270_Setup = &hfd17
const GDK_KEY_3270_Record = &hfd18
const GDK_KEY_3270_ChangeScreen = &hfd19
const GDK_KEY_3270_DeleteWord = &hfd1a
const GDK_KEY_3270_ExSelect = &hfd1b
const GDK_KEY_3270_CursorSelect = &hfd1c
const GDK_KEY_3270_PrintScreen = &hfd1d
const GDK_KEY_3270_Enter = &hfd1e
const GDK_KEY_space = &h020
const GDK_KEY_exclam = &h021
const GDK_KEY_quotedbl = &h022
const GDK_KEY_numbersign = &h023
const GDK_KEY_dollar = &h024
const GDK_KEY_percent = &h025
const GDK_KEY_ampersand = &h026
const GDK_KEY_apostrophe = &h027
const GDK_KEY_quoteright = &h027
const GDK_KEY_parenleft = &h028
const GDK_KEY_parenright = &h029
const GDK_KEY_asterisk = &h02a
const GDK_KEY_plus = &h02b
const GDK_KEY_comma = &h02c
const GDK_KEY_minus = &h02d
const GDK_KEY_period = &h02e
const GDK_KEY_slash = &h02f
const GDK_KEY_0 = &h030
const GDK_KEY_1 = &h031
const GDK_KEY_2 = &h032
const GDK_KEY_3 = &h033
const GDK_KEY_4 = &h034
const GDK_KEY_5 = &h035
const GDK_KEY_6 = &h036
const GDK_KEY_7 = &h037
const GDK_KEY_8 = &h038
const GDK_KEY_9 = &h039
const GDK_KEY_colon = &h03a
const GDK_KEY_semicolon = &h03b
const GDK_KEY_less = &h03c
const GDK_KEY_equal = &h03d
const GDK_KEY_greater = &h03e
const GDK_KEY_question = &h03f
const GDK_KEY_at = &h040
const GDK_KEY_A_ = &h041
const GDK_KEY_B_ = &h042
const GDK_KEY_C_ = &h043
const GDK_KEY_D_ = &h044
const GDK_KEY_E_ = &h045
const GDK_KEY_F_ = &h046
const GDK_KEY_G_ = &h047
const GDK_KEY_H_ = &h048
const GDK_KEY_I_ = &h049
const GDK_KEY_J_ = &h04a
const GDK_KEY_K_ = &h04b
const GDK_KEY_L_ = &h04c
const GDK_KEY_M_ = &h04d
const GDK_KEY_N_ = &h04e
const GDK_KEY_O_ = &h04f
const GDK_KEY_P_ = &h050
const GDK_KEY_Q_ = &h051
const GDK_KEY_R_ = &h052
const GDK_KEY_S_ = &h053
const GDK_KEY_T_ = &h054
const GDK_KEY_U_ = &h055
const GDK_KEY_V_ = &h056
const GDK_KEY_W_ = &h057
const GDK_KEY_X_ = &h058
const GDK_KEY_Y_ = &h059
const GDK_KEY_Z_ = &h05a
const GDK_KEY_bracketleft = &h05b
const GDK_KEY_backslash = &h05c
const GDK_KEY_bracketright = &h05d
const GDK_KEY_asciicircum = &h05e
const GDK_KEY_underscore = &h05f
const GDK_KEY_grave = &h060
const GDK_KEY_quoteleft = &h060
const GDK_KEY_a = &h061
const GDK_KEY_b = &h062
const GDK_KEY_c = &h063
const GDK_KEY_d = &h064
const GDK_KEY_e = &h065
const GDK_KEY_f = &h066
const GDK_KEY_g = &h067
const GDK_KEY_h = &h068
const GDK_KEY_i = &h069
const GDK_KEY_j = &h06a
const GDK_KEY_k = &h06b
const GDK_KEY_l = &h06c
const GDK_KEY_m = &h06d
const GDK_KEY_n = &h06e
const GDK_KEY_o = &h06f
const GDK_KEY_p = &h070
const GDK_KEY_q = &h071
const GDK_KEY_r = &h072
const GDK_KEY_s = &h073
const GDK_KEY_t = &h074
const GDK_KEY_u = &h075
const GDK_KEY_v = &h076
const GDK_KEY_w = &h077
const GDK_KEY_x = &h078
const GDK_KEY_y = &h079
const GDK_KEY_z = &h07a
const GDK_KEY_braceleft = &h07b
const GDK_KEY_bar = &h07c
const GDK_KEY_braceright = &h07d
const GDK_KEY_asciitilde = &h07e
const GDK_KEY_nobreakspace = &h0a0
const GDK_KEY_exclamdown = &h0a1
const GDK_KEY_cent = &h0a2
const GDK_KEY_sterling = &h0a3
const GDK_KEY_currency = &h0a4
const GDK_KEY_yen = &h0a5
const GDK_KEY_brokenbar = &h0a6
const GDK_KEY_section = &h0a7
const GDK_KEY_diaeresis = &h0a8
const GDK_KEY_copyright = &h0a9
const GDK_KEY_ordfeminine = &h0aa
const GDK_KEY_guillemotleft = &h0ab
const GDK_KEY_notsign = &h0ac
const GDK_KEY_hyphen = &h0ad
const GDK_KEY_registered = &h0ae
const GDK_KEY_macron = &h0af
const GDK_KEY_degree = &h0b0
const GDK_KEY_plusminus = &h0b1
const GDK_KEY_twosuperior = &h0b2
const GDK_KEY_threesuperior = &h0b3
const GDK_KEY_acute = &h0b4
const GDK_KEY_mu = &h0b5
const GDK_KEY_paragraph = &h0b6
const GDK_KEY_periodcentered = &h0b7
const GDK_KEY_cedilla = &h0b8
const GDK_KEY_onesuperior = &h0b9
const GDK_KEY_masculine = &h0ba
const GDK_KEY_guillemotright = &h0bb
const GDK_KEY_onequarter = &h0bc
const GDK_KEY_onehalf = &h0bd
const GDK_KEY_threequarters = &h0be
const GDK_KEY_questiondown = &h0bf
const GDK_KEY_Agrave_ = &h0c0
const GDK_KEY_Aacute_ = &h0c1
const GDK_KEY_Acircumflex_ = &h0c2
const GDK_KEY_Atilde_ = &h0c3
const GDK_KEY_Adiaeresis_ = &h0c4
const GDK_KEY_Aring_ = &h0c5
const GDK_KEY_AE_ = &h0c6
const GDK_KEY_Ccedilla_ = &h0c7
const GDK_KEY_Egrave_ = &h0c8
const GDK_KEY_Eacute_ = &h0c9
const GDK_KEY_Ecircumflex_ = &h0ca
const GDK_KEY_Ediaeresis_ = &h0cb
const GDK_KEY_Igrave_ = &h0cc
const GDK_KEY_Iacute_ = &h0cd
const GDK_KEY_Icircumflex_ = &h0ce
const GDK_KEY_Idiaeresis_ = &h0cf
const GDK_KEY_Eth_ = &h0d0
const GDK_KEY_Ntilde_ = &h0d1
const GDK_KEY_Ograve_ = &h0d2
const GDK_KEY_Oacute_ = &h0d3
const GDK_KEY_Ocircumflex_ = &h0d4
const GDK_KEY_Otilde_ = &h0d5
const GDK_KEY_Odiaeresis_ = &h0d6
const GDK_KEY_multiply = &h0d7
const GDK_KEY_Oslash_ = &h0d8
const GDK_KEY_Ooblique_ = &h0d8
const GDK_KEY_Ugrave_ = &h0d9
const GDK_KEY_Uacute_ = &h0da
const GDK_KEY_Ucircumflex_ = &h0db
const GDK_KEY_Udiaeresis_ = &h0dc
const GDK_KEY_Yacute_ = &h0dd
const GDK_KEY_Thorn_ = &h0de
const GDK_KEY_ssharp = &h0df
const GDK_KEY_agrave = &h0e0
const GDK_KEY_aacute = &h0e1
const GDK_KEY_acircumflex = &h0e2
const GDK_KEY_atilde = &h0e3
const GDK_KEY_adiaeresis = &h0e4
const GDK_KEY_aring = &h0e5
const GDK_KEY_ae = &h0e6
const GDK_KEY_ccedilla = &h0e7
const GDK_KEY_egrave = &h0e8
const GDK_KEY_eacute = &h0e9
const GDK_KEY_ecircumflex = &h0ea
const GDK_KEY_ediaeresis = &h0eb
const GDK_KEY_igrave = &h0ec
const GDK_KEY_iacute = &h0ed
const GDK_KEY_icircumflex = &h0ee
const GDK_KEY_idiaeresis = &h0ef
const GDK_KEY_eth = &h0f0
const GDK_KEY_ntilde = &h0f1
const GDK_KEY_ograve = &h0f2
const GDK_KEY_oacute = &h0f3
const GDK_KEY_ocircumflex = &h0f4
const GDK_KEY_otilde = &h0f5
const GDK_KEY_odiaeresis = &h0f6
const GDK_KEY_division = &h0f7
const GDK_KEY_oslash = &h0f8
const GDK_KEY_ooblique = &h0f8
const GDK_KEY_ugrave = &h0f9
const GDK_KEY_uacute = &h0fa
const GDK_KEY_ucircumflex = &h0fb
const GDK_KEY_udiaeresis = &h0fc
const GDK_KEY_yacute = &h0fd
const GDK_KEY_thorn = &h0fe
const GDK_KEY_ydiaeresis = &h0ff
const GDK_KEY_Aogonek_ = &h1a1
const GDK_KEY_breve = &h1a2
const GDK_KEY_Lstroke_ = &h1a3
const GDK_KEY_Lcaron_ = &h1a5
const GDK_KEY_Sacute_ = &h1a6
const GDK_KEY_Scaron_ = &h1a9
const GDK_KEY_Scedilla_ = &h1aa
const GDK_KEY_Tcaron_ = &h1ab
const GDK_KEY_Zacute_ = &h1ac
const GDK_KEY_Zcaron_ = &h1ae
const GDK_KEY_Zabovedot_ = &h1af
const GDK_KEY_aogonek = &h1b1
const GDK_KEY_ogonek = &h1b2
const GDK_KEY_lstroke = &h1b3
const GDK_KEY_lcaron = &h1b5
const GDK_KEY_sacute = &h1b6
const GDK_KEY_caron = &h1b7
const GDK_KEY_scaron = &h1b9
const GDK_KEY_scedilla = &h1ba
const GDK_KEY_tcaron = &h1bb
const GDK_KEY_zacute = &h1bc
const GDK_KEY_doubleacute = &h1bd
const GDK_KEY_zcaron = &h1be
const GDK_KEY_zabovedot = &h1bf
const GDK_KEY_Racute_ = &h1c0
const GDK_KEY_Abreve_ = &h1c3
const GDK_KEY_Lacute_ = &h1c5
const GDK_KEY_Cacute_ = &h1c6
const GDK_KEY_Ccaron_ = &h1c8
const GDK_KEY_Eogonek_ = &h1ca
const GDK_KEY_Ecaron_ = &h1cc
const GDK_KEY_Dcaron_ = &h1cf
const GDK_KEY_Dstroke_ = &h1d0
const GDK_KEY_Nacute_ = &h1d1
const GDK_KEY_Ncaron_ = &h1d2
const GDK_KEY_Odoubleacute_ = &h1d5
const GDK_KEY_Rcaron_ = &h1d8
const GDK_KEY_Uring_ = &h1d9
const GDK_KEY_Udoubleacute_ = &h1db
const GDK_KEY_Tcedilla_ = &h1de
const GDK_KEY_racute = &h1e0
const GDK_KEY_abreve = &h1e3
const GDK_KEY_lacute = &h1e5
const GDK_KEY_cacute = &h1e6
const GDK_KEY_ccaron = &h1e8
const GDK_KEY_eogonek = &h1ea
const GDK_KEY_ecaron = &h1ec
const GDK_KEY_dcaron = &h1ef
const GDK_KEY_dstroke = &h1f0
const GDK_KEY_nacute = &h1f1
const GDK_KEY_ncaron = &h1f2
const GDK_KEY_odoubleacute = &h1f5
const GDK_KEY_rcaron = &h1f8
const GDK_KEY_uring = &h1f9
const GDK_KEY_udoubleacute = &h1fb
const GDK_KEY_tcedilla = &h1fe
const GDK_KEY_abovedot = &h1ff
const GDK_KEY_Hstroke_ = &h2a1
const GDK_KEY_Hcircumflex_ = &h2a6
const GDK_KEY_Iabovedot = &h2a9
const GDK_KEY_Gbreve_ = &h2ab
const GDK_KEY_Jcircumflex_ = &h2ac
const GDK_KEY_hstroke = &h2b1
const GDK_KEY_hcircumflex = &h2b6
const GDK_KEY_idotless = &h2b9
const GDK_KEY_gbreve = &h2bb
const GDK_KEY_jcircumflex = &h2bc
const GDK_KEY_Cabovedot_ = &h2c5
const GDK_KEY_Ccircumflex_ = &h2c6
const GDK_KEY_Gabovedot_ = &h2d5
const GDK_KEY_Gcircumflex_ = &h2d8
const GDK_KEY_Ubreve_ = &h2dd
const GDK_KEY_Scircumflex_ = &h2de
const GDK_KEY_cabovedot = &h2e5
const GDK_KEY_ccircumflex = &h2e6
const GDK_KEY_gabovedot = &h2f5
const GDK_KEY_gcircumflex = &h2f8
const GDK_KEY_ubreve = &h2fd
const GDK_KEY_scircumflex = &h2fe
const GDK_KEY_kra = &h3a2
const GDK_KEY_kappa = &h3a2
const GDK_KEY_Rcedilla_ = &h3a3
const GDK_KEY_Itilde_ = &h3a5
const GDK_KEY_Lcedilla_ = &h3a6
const GDK_KEY_Emacron_ = &h3aa
const GDK_KEY_Gcedilla_ = &h3ab
const GDK_KEY_Tslash_ = &h3ac
const GDK_KEY_rcedilla = &h3b3
const GDK_KEY_itilde = &h3b5
const GDK_KEY_lcedilla = &h3b6
const GDK_KEY_emacron = &h3ba
const GDK_KEY_gcedilla = &h3bb
const GDK_KEY_tslash = &h3bc
const GDK_KEY_ENG_ = &h3bd
const GDK_KEY_eng = &h3bf
const GDK_KEY_Amacron_ = &h3c0
const GDK_KEY_Iogonek_ = &h3c7
const GDK_KEY_Eabovedot_ = &h3cc
const GDK_KEY_Imacron_ = &h3cf
const GDK_KEY_Ncedilla_ = &h3d1
const GDK_KEY_Omacron_ = &h3d2
const GDK_KEY_Kcedilla_ = &h3d3
const GDK_KEY_Uogonek_ = &h3d9
const GDK_KEY_Utilde_ = &h3dd
const GDK_KEY_Umacron_ = &h3de
const GDK_KEY_amacron = &h3e0
const GDK_KEY_iogonek = &h3e7
const GDK_KEY_eabovedot = &h3ec
const GDK_KEY_imacron = &h3ef
const GDK_KEY_ncedilla = &h3f1
const GDK_KEY_omacron = &h3f2
const GDK_KEY_kcedilla = &h3f3
const GDK_KEY_uogonek = &h3f9
const GDK_KEY_utilde = &h3fd
const GDK_KEY_umacron = &h3fe
const GDK_KEY_Wcircumflex_ = &h1000174
const GDK_KEY_wcircumflex = &h1000175
const GDK_KEY_Ycircumflex_ = &h1000176
const GDK_KEY_ycircumflex = &h1000177
const GDK_KEY_Babovedot_ = &h1001e02
const GDK_KEY_babovedot = &h1001e03
const GDK_KEY_Dabovedot_ = &h1001e0a
const GDK_KEY_dabovedot = &h1001e0b
const GDK_KEY_Fabovedot_ = &h1001e1e
const GDK_KEY_fabovedot = &h1001e1f
const GDK_KEY_Mabovedot_ = &h1001e40
const GDK_KEY_mabovedot = &h1001e41
const GDK_KEY_Pabovedot_ = &h1001e56
const GDK_KEY_pabovedot = &h1001e57
const GDK_KEY_Sabovedot_ = &h1001e60
const GDK_KEY_sabovedot = &h1001e61
const GDK_KEY_Tabovedot_ = &h1001e6a
const GDK_KEY_tabovedot = &h1001e6b
const GDK_KEY_Wgrave_ = &h1001e80
const GDK_KEY_wgrave = &h1001e81
const GDK_KEY_Wacute_ = &h1001e82
const GDK_KEY_wacute = &h1001e83
const GDK_KEY_Wdiaeresis_ = &h1001e84
const GDK_KEY_wdiaeresis = &h1001e85
const GDK_KEY_Ygrave_ = &h1001ef2
const GDK_KEY_ygrave = &h1001ef3
const GDK_KEY_OE_ = &h13bc
const GDK_KEY_oe = &h13bd
const GDK_KEY_Ydiaeresis_ = &h13be
const GDK_KEY_overline = &h47e
const GDK_KEY_kana_fullstop = &h4a1
const GDK_KEY_kana_openingbracket = &h4a2
const GDK_KEY_kana_closingbracket = &h4a3
const GDK_KEY_kana_comma = &h4a4
const GDK_KEY_kana_conjunctive = &h4a5
const GDK_KEY_kana_middledot = &h4a5
const GDK_KEY_kana_WO = &h4a6
const GDK_KEY_kana_a = &h4a7
const GDK_KEY_kana_i = &h4a8
const GDK_KEY_kana_u = &h4a9
const GDK_KEY_kana_e = &h4aa
const GDK_KEY_kana_o = &h4ab
const GDK_KEY_kana_ya = &h4ac
const GDK_KEY_kana_yu = &h4ad
const GDK_KEY_kana_yo = &h4ae
const GDK_KEY_kana_tsu = &h4af
const GDK_KEY_kana_tu = &h4af
const GDK_KEY_prolongedsound = &h4b0
const GDK_KEY_kana_A_ = &h4b1
const GDK_KEY_kana_I_ = &h4b2
const GDK_KEY_kana_U_ = &h4b3
const GDK_KEY_kana_E_ = &h4b4
const GDK_KEY_kana_O_ = &h4b5
const GDK_KEY_kana_KA = &h4b6
const GDK_KEY_kana_KI = &h4b7
const GDK_KEY_kana_KU = &h4b8
const GDK_KEY_kana_KE = &h4b9
const GDK_KEY_kana_KO = &h4ba
const GDK_KEY_kana_SA = &h4bb
const GDK_KEY_kana_SHI = &h4bc
const GDK_KEY_kana_SU = &h4bd
const GDK_KEY_kana_SE = &h4be
const GDK_KEY_kana_SO = &h4bf
const GDK_KEY_kana_TA = &h4c0
const GDK_KEY_kana_CHI = &h4c1
const GDK_KEY_kana_TI = &h4c1
const GDK_KEY_kana_TSU_ = &h4c2
const GDK_KEY_kana_TU_ = &h4c2
const GDK_KEY_kana_TE = &h4c3
const GDK_KEY_kana_TO = &h4c4
const GDK_KEY_kana_NA = &h4c5
const GDK_KEY_kana_NI = &h4c6
const GDK_KEY_kana_NU = &h4c7
const GDK_KEY_kana_NE = &h4c8
const GDK_KEY_kana_NO = &h4c9
const GDK_KEY_kana_HA = &h4ca
const GDK_KEY_kana_HI = &h4cb
const GDK_KEY_kana_FU = &h4cc
const GDK_KEY_kana_HU = &h4cc
const GDK_KEY_kana_HE = &h4cd
const GDK_KEY_kana_HO = &h4ce
const GDK_KEY_kana_MA = &h4cf
const GDK_KEY_kana_MI = &h4d0
const GDK_KEY_kana_MU = &h4d1
const GDK_KEY_kana_ME = &h4d2
const GDK_KEY_kana_MO = &h4d3
const GDK_KEY_kana_YA_ = &h4d4
const GDK_KEY_kana_YU_ = &h4d5
const GDK_KEY_kana_YO_ = &h4d6
const GDK_KEY_kana_RA = &h4d7
const GDK_KEY_kana_RI = &h4d8
const GDK_KEY_kana_RU = &h4d9
const GDK_KEY_kana_RE = &h4da
const GDK_KEY_kana_RO = &h4db
const GDK_KEY_kana_WA = &h4dc
const GDK_KEY_kana_N = &h4dd
const GDK_KEY_voicedsound = &h4de
const GDK_KEY_semivoicedsound = &h4df
const GDK_KEY_kana_switch = &hff7e
const GDK_KEY_Farsi_0 = &h10006f0
const GDK_KEY_Farsi_1 = &h10006f1
const GDK_KEY_Farsi_2 = &h10006f2
const GDK_KEY_Farsi_3 = &h10006f3
const GDK_KEY_Farsi_4 = &h10006f4
const GDK_KEY_Farsi_5 = &h10006f5
const GDK_KEY_Farsi_6 = &h10006f6
const GDK_KEY_Farsi_7 = &h10006f7
const GDK_KEY_Farsi_8 = &h10006f8
const GDK_KEY_Farsi_9 = &h10006f9
const GDK_KEY_Arabic_percent = &h100066a
const GDK_KEY_Arabic_superscript_alef = &h1000670
const GDK_KEY_Arabic_tteh = &h1000679
const GDK_KEY_Arabic_peh = &h100067e
const GDK_KEY_Arabic_tcheh = &h1000686
const GDK_KEY_Arabic_ddal = &h1000688
const GDK_KEY_Arabic_rreh = &h1000691
const GDK_KEY_Arabic_comma = &h5ac
const GDK_KEY_Arabic_fullstop = &h10006d4
const GDK_KEY_Arabic_0 = &h1000660
const GDK_KEY_Arabic_1 = &h1000661
const GDK_KEY_Arabic_2 = &h1000662
const GDK_KEY_Arabic_3 = &h1000663
const GDK_KEY_Arabic_4 = &h1000664
const GDK_KEY_Arabic_5 = &h1000665
const GDK_KEY_Arabic_6 = &h1000666
const GDK_KEY_Arabic_7 = &h1000667
const GDK_KEY_Arabic_8 = &h1000668
const GDK_KEY_Arabic_9 = &h1000669
const GDK_KEY_Arabic_semicolon = &h5bb
const GDK_KEY_Arabic_question_mark = &h5bf
const GDK_KEY_Arabic_hamza = &h5c1
const GDK_KEY_Arabic_maddaonalef = &h5c2
const GDK_KEY_Arabic_hamzaonalef = &h5c3
const GDK_KEY_Arabic_hamzaonwaw = &h5c4
const GDK_KEY_Arabic_hamzaunderalef = &h5c5
const GDK_KEY_Arabic_hamzaonyeh = &h5c6
const GDK_KEY_Arabic_alef = &h5c7
const GDK_KEY_Arabic_beh = &h5c8
const GDK_KEY_Arabic_tehmarbuta = &h5c9
const GDK_KEY_Arabic_teh = &h5ca
const GDK_KEY_Arabic_theh = &h5cb
const GDK_KEY_Arabic_jeem = &h5cc
const GDK_KEY_Arabic_hah = &h5cd
const GDK_KEY_Arabic_khah = &h5ce
const GDK_KEY_Arabic_dal = &h5cf
const GDK_KEY_Arabic_thal = &h5d0
const GDK_KEY_Arabic_ra = &h5d1
const GDK_KEY_Arabic_zain = &h5d2
const GDK_KEY_Arabic_seen = &h5d3
const GDK_KEY_Arabic_sheen = &h5d4
const GDK_KEY_Arabic_sad = &h5d5
const GDK_KEY_Arabic_dad = &h5d6
const GDK_KEY_Arabic_tah = &h5d7
const GDK_KEY_Arabic_zah = &h5d8
const GDK_KEY_Arabic_ain = &h5d9
const GDK_KEY_Arabic_ghain = &h5da
const GDK_KEY_Arabic_tatweel = &h5e0
const GDK_KEY_Arabic_feh = &h5e1
const GDK_KEY_Arabic_qaf = &h5e2
const GDK_KEY_Arabic_kaf = &h5e3
const GDK_KEY_Arabic_lam = &h5e4
const GDK_KEY_Arabic_meem = &h5e5
const GDK_KEY_Arabic_noon = &h5e6
const GDK_KEY_Arabic_ha = &h5e7
const GDK_KEY_Arabic_heh = &h5e7
const GDK_KEY_Arabic_waw = &h5e8
const GDK_KEY_Arabic_alefmaksura = &h5e9
const GDK_KEY_Arabic_yeh = &h5ea
const GDK_KEY_Arabic_fathatan = &h5eb
const GDK_KEY_Arabic_dammatan = &h5ec
const GDK_KEY_Arabic_kasratan = &h5ed
const GDK_KEY_Arabic_fatha = &h5ee
const GDK_KEY_Arabic_damma = &h5ef
const GDK_KEY_Arabic_kasra = &h5f0
const GDK_KEY_Arabic_shadda = &h5f1
const GDK_KEY_Arabic_sukun = &h5f2
const GDK_KEY_Arabic_madda_above = &h1000653
const GDK_KEY_Arabic_hamza_above = &h1000654
const GDK_KEY_Arabic_hamza_below = &h1000655
const GDK_KEY_Arabic_jeh = &h1000698
const GDK_KEY_Arabic_veh = &h10006a4
const GDK_KEY_Arabic_keheh = &h10006a9
const GDK_KEY_Arabic_gaf = &h10006af
const GDK_KEY_Arabic_noon_ghunna = &h10006ba
const GDK_KEY_Arabic_heh_doachashmee = &h10006be
const GDK_KEY_Farsi_yeh = &h10006cc
const GDK_KEY_Arabic_farsi_yeh = &h10006cc
const GDK_KEY_Arabic_yeh_baree = &h10006d2
const GDK_KEY_Arabic_heh_goal = &h10006c1
const GDK_KEY_Arabic_switch = &hff7e
const GDK_KEY_Cyrillic_GHE_bar_ = &h1000492
const GDK_KEY_Cyrillic_ghe_bar = &h1000493
const GDK_KEY_Cyrillic_ZHE_descender_ = &h1000496
const GDK_KEY_Cyrillic_zhe_descender = &h1000497
const GDK_KEY_Cyrillic_KA_descender_ = &h100049a
const GDK_KEY_Cyrillic_ka_descender = &h100049b
const GDK_KEY_Cyrillic_KA_vertstroke_ = &h100049c
const GDK_KEY_Cyrillic_ka_vertstroke = &h100049d
const GDK_KEY_Cyrillic_EN_descender_ = &h10004a2
const GDK_KEY_Cyrillic_en_descender = &h10004a3
const GDK_KEY_Cyrillic_U_straight_ = &h10004ae
const GDK_KEY_Cyrillic_u_straight = &h10004af
const GDK_KEY_Cyrillic_U_straight_bar_ = &h10004b0
const GDK_KEY_Cyrillic_u_straight_bar = &h10004b1
const GDK_KEY_Cyrillic_HA_descender_ = &h10004b2
const GDK_KEY_Cyrillic_ha_descender = &h10004b3
const GDK_KEY_Cyrillic_CHE_descender_ = &h10004b6
const GDK_KEY_Cyrillic_che_descender = &h10004b7
const GDK_KEY_Cyrillic_CHE_vertstroke_ = &h10004b8
const GDK_KEY_Cyrillic_che_vertstroke = &h10004b9
const GDK_KEY_Cyrillic_SHHA_ = &h10004ba
const GDK_KEY_Cyrillic_shha = &h10004bb
const GDK_KEY_Cyrillic_SCHWA_ = &h10004d8
const GDK_KEY_Cyrillic_schwa = &h10004d9
const GDK_KEY_Cyrillic_I_macron_ = &h10004e2
const GDK_KEY_Cyrillic_i_macron = &h10004e3
const GDK_KEY_Cyrillic_O_bar_ = &h10004e8
const GDK_KEY_Cyrillic_o_bar = &h10004e9
const GDK_KEY_Cyrillic_U_macron_ = &h10004ee
const GDK_KEY_Cyrillic_u_macron = &h10004ef
const GDK_KEY_Serbian_dje = &h6a1
const GDK_KEY_Macedonia_gje = &h6a2
const GDK_KEY_Cyrillic_io = &h6a3
const GDK_KEY_Ukrainian_ie = &h6a4
const GDK_KEY_Ukranian_je = &h6a4
const GDK_KEY_Macedonia_dse = &h6a5
const GDK_KEY_Ukrainian_i = &h6a6
const GDK_KEY_Ukranian_i = &h6a6
const GDK_KEY_Ukrainian_yi = &h6a7
const GDK_KEY_Ukranian_yi = &h6a7
const GDK_KEY_Cyrillic_je = &h6a8
const GDK_KEY_Serbian_je = &h6a8
const GDK_KEY_Cyrillic_lje = &h6a9
const GDK_KEY_Serbian_lje = &h6a9
const GDK_KEY_Cyrillic_nje = &h6aa
const GDK_KEY_Serbian_nje = &h6aa
const GDK_KEY_Serbian_tshe = &h6ab
const GDK_KEY_Macedonia_kje = &h6ac
const GDK_KEY_Ukrainian_ghe_with_upturn = &h6ad
const GDK_KEY_Byelorussian_shortu = &h6ae
const GDK_KEY_Cyrillic_dzhe = &h6af
const GDK_KEY_Serbian_dze = &h6af
const GDK_KEY_numerosign = &h6b0
const GDK_KEY_Serbian_DJE_ = &h6b1
const GDK_KEY_Macedonia_GJE_ = &h6b2
const GDK_KEY_Cyrillic_IO_ = &h6b3
const GDK_KEY_Ukrainian_IE_ = &h6b4
const GDK_KEY_Ukranian_JE_ = &h6b4
const GDK_KEY_Macedonia_DSE_ = &h6b5
const GDK_KEY_Ukrainian_I_ = &h6b6
const GDK_KEY_Ukranian_I_ = &h6b6
const GDK_KEY_Ukrainian_YI_ = &h6b7
const GDK_KEY_Ukranian_YI_ = &h6b7
const GDK_KEY_Cyrillic_JE_ = &h6b8
const GDK_KEY_Serbian_JE_ = &h6b8
const GDK_KEY_Cyrillic_LJE_ = &h6b9
const GDK_KEY_Serbian_LJE_ = &h6b9
const GDK_KEY_Cyrillic_NJE_ = &h6ba
const GDK_KEY_Serbian_NJE_ = &h6ba
const GDK_KEY_Serbian_TSHE_ = &h6bb
const GDK_KEY_Macedonia_KJE_ = &h6bc
const GDK_KEY_Ukrainian_GHE_WITH_UPTURN_ = &h6bd
const GDK_KEY_Byelorussian_SHORTU_ = &h6be
const GDK_KEY_Cyrillic_DZHE_ = &h6bf
const GDK_KEY_Serbian_DZE_ = &h6bf
const GDK_KEY_Cyrillic_yu = &h6c0
const GDK_KEY_Cyrillic_a = &h6c1
const GDK_KEY_Cyrillic_be = &h6c2
const GDK_KEY_Cyrillic_tse = &h6c3
const GDK_KEY_Cyrillic_de = &h6c4
const GDK_KEY_Cyrillic_ie = &h6c5
const GDK_KEY_Cyrillic_ef = &h6c6
const GDK_KEY_Cyrillic_ghe = &h6c7
const GDK_KEY_Cyrillic_ha = &h6c8
const GDK_KEY_Cyrillic_i = &h6c9
const GDK_KEY_Cyrillic_shorti = &h6ca
const GDK_KEY_Cyrillic_ka = &h6cb
const GDK_KEY_Cyrillic_el = &h6cc
const GDK_KEY_Cyrillic_em = &h6cd
const GDK_KEY_Cyrillic_en = &h6ce
const GDK_KEY_Cyrillic_o = &h6cf
const GDK_KEY_Cyrillic_pe = &h6d0
const GDK_KEY_Cyrillic_ya = &h6d1
const GDK_KEY_Cyrillic_er = &h6d2
const GDK_KEY_Cyrillic_es = &h6d3
const GDK_KEY_Cyrillic_te = &h6d4
const GDK_KEY_Cyrillic_u = &h6d5
const GDK_KEY_Cyrillic_zhe = &h6d6
const GDK_KEY_Cyrillic_ve = &h6d7
const GDK_KEY_Cyrillic_softsign = &h6d8
const GDK_KEY_Cyrillic_yeru = &h6d9
const GDK_KEY_Cyrillic_ze = &h6da
const GDK_KEY_Cyrillic_sha = &h6db
const GDK_KEY_Cyrillic_e = &h6dc
const GDK_KEY_Cyrillic_shcha = &h6dd
const GDK_KEY_Cyrillic_che = &h6de
const GDK_KEY_Cyrillic_hardsign = &h6df
const GDK_KEY_Cyrillic_YU_ = &h6e0
const GDK_KEY_Cyrillic_A_ = &h6e1
const GDK_KEY_Cyrillic_BE_ = &h6e2
const GDK_KEY_Cyrillic_TSE_ = &h6e3
const GDK_KEY_Cyrillic_DE_ = &h6e4
const GDK_KEY_Cyrillic_IE_ = &h6e5
const GDK_KEY_Cyrillic_EF_ = &h6e6
const GDK_KEY_Cyrillic_GHE_ = &h6e7
const GDK_KEY_Cyrillic_HA_ = &h6e8
const GDK_KEY_Cyrillic_I_ = &h6e9
const GDK_KEY_Cyrillic_SHORTI_ = &h6ea
const GDK_KEY_Cyrillic_KA_ = &h6eb
const GDK_KEY_Cyrillic_EL_ = &h6ec
const GDK_KEY_Cyrillic_EM_ = &h6ed
const GDK_KEY_Cyrillic_EN_ = &h6ee
const GDK_KEY_Cyrillic_O_ = &h6ef
const GDK_KEY_Cyrillic_PE_ = &h6f0
const GDK_KEY_Cyrillic_YA_ = &h6f1
const GDK_KEY_Cyrillic_ER_ = &h6f2
const GDK_KEY_Cyrillic_ES_ = &h6f3
const GDK_KEY_Cyrillic_TE_ = &h6f4
const GDK_KEY_Cyrillic_U_ = &h6f5
const GDK_KEY_Cyrillic_ZHE_ = &h6f6
const GDK_KEY_Cyrillic_VE_ = &h6f7
const GDK_KEY_Cyrillic_SOFTSIGN_ = &h6f8
const GDK_KEY_Cyrillic_YERU_ = &h6f9
const GDK_KEY_Cyrillic_ZE_ = &h6fa
const GDK_KEY_Cyrillic_SHA_ = &h6fb
const GDK_KEY_Cyrillic_E_ = &h6fc
const GDK_KEY_Cyrillic_SHCHA_ = &h6fd
const GDK_KEY_Cyrillic_CHE_ = &h6fe
const GDK_KEY_Cyrillic_HARDSIGN_ = &h6ff
const GDK_KEY_Greek_ALPHAaccent_ = &h7a1
const GDK_KEY_Greek_EPSILONaccent_ = &h7a2
const GDK_KEY_Greek_ETAaccent_ = &h7a3
const GDK_KEY_Greek_IOTAaccent_ = &h7a4
const GDK_KEY_Greek_IOTAdieresis_ = &h7a5
const GDK_KEY_Greek_IOTAdiaeresis = &h7a5
const GDK_KEY_Greek_OMICRONaccent_ = &h7a7
const GDK_KEY_Greek_UPSILONaccent_ = &h7a8
const GDK_KEY_Greek_UPSILONdieresis_ = &h7a9
const GDK_KEY_Greek_OMEGAaccent_ = &h7ab
const GDK_KEY_Greek_accentdieresis = &h7ae
const GDK_KEY_Greek_horizbar = &h7af
const GDK_KEY_Greek_alphaaccent = &h7b1
const GDK_KEY_Greek_epsilonaccent = &h7b2
const GDK_KEY_Greek_etaaccent = &h7b3
const GDK_KEY_Greek_iotaaccent = &h7b4
const GDK_KEY_Greek_iotadieresis = &h7b5
const GDK_KEY_Greek_iotaaccentdieresis = &h7b6
const GDK_KEY_Greek_omicronaccent = &h7b7
const GDK_KEY_Greek_upsilonaccent = &h7b8
const GDK_KEY_Greek_upsilondieresis = &h7b9
const GDK_KEY_Greek_upsilonaccentdieresis = &h7ba
const GDK_KEY_Greek_omegaaccent = &h7bb
const GDK_KEY_Greek_ALPHA_ = &h7c1
const GDK_KEY_Greek_BETA_ = &h7c2
const GDK_KEY_Greek_GAMMA_ = &h7c3
const GDK_KEY_Greek_DELTA_ = &h7c4
const GDK_KEY_Greek_EPSILON_ = &h7c5
const GDK_KEY_Greek_ZETA_ = &h7c6
const GDK_KEY_Greek_ETA_ = &h7c7
const GDK_KEY_Greek_THETA_ = &h7c8
const GDK_KEY_Greek_IOTA_ = &h7c9
const GDK_KEY_Greek_KAPPA_ = &h7ca
const GDK_KEY_Greek_LAMDA_ = &h7cb
const GDK_KEY_Greek_LAMBDA_ = &h7cb
const GDK_KEY_Greek_MU_ = &h7cc
const GDK_KEY_Greek_NU_ = &h7cd
const GDK_KEY_Greek_XI_ = &h7ce
const GDK_KEY_Greek_OMICRON_ = &h7cf
const GDK_KEY_Greek_PI_ = &h7d0
const GDK_KEY_Greek_RHO_ = &h7d1
const GDK_KEY_Greek_SIGMA_ = &h7d2
const GDK_KEY_Greek_TAU_ = &h7d4
const GDK_KEY_Greek_UPSILON_ = &h7d5
const GDK_KEY_Greek_PHI_ = &h7d6
const GDK_KEY_Greek_CHI_ = &h7d7
const GDK_KEY_Greek_PSI_ = &h7d8
const GDK_KEY_Greek_OMEGA_ = &h7d9
const GDK_KEY_Greek_alpha = &h7e1
const GDK_KEY_Greek_beta = &h7e2
const GDK_KEY_Greek_gamma = &h7e3
const GDK_KEY_Greek_delta = &h7e4
const GDK_KEY_Greek_epsilon = &h7e5
const GDK_KEY_Greek_zeta = &h7e6
const GDK_KEY_Greek_eta = &h7e7
const GDK_KEY_Greek_theta = &h7e8
const GDK_KEY_Greek_iota = &h7e9
const GDK_KEY_Greek_kappa = &h7ea
const GDK_KEY_Greek_lamda = &h7eb
const GDK_KEY_Greek_lambda = &h7eb
const GDK_KEY_Greek_mu = &h7ec
const GDK_KEY_Greek_nu = &h7ed
const GDK_KEY_Greek_xi = &h7ee
const GDK_KEY_Greek_omicron = &h7ef
const GDK_KEY_Greek_pi = &h7f0
const GDK_KEY_Greek_rho = &h7f1
const GDK_KEY_Greek_sigma = &h7f2
const GDK_KEY_Greek_finalsmallsigma = &h7f3
const GDK_KEY_Greek_tau = &h7f4
const GDK_KEY_Greek_upsilon = &h7f5
const GDK_KEY_Greek_phi = &h7f6
const GDK_KEY_Greek_chi = &h7f7
const GDK_KEY_Greek_psi = &h7f8
const GDK_KEY_Greek_omega = &h7f9
const GDK_KEY_Greek_switch = &hff7e
const GDK_KEY_leftradical = &h8a1
const GDK_KEY_topleftradical = &h8a2
const GDK_KEY_horizconnector = &h8a3
const GDK_KEY_topintegral = &h8a4
const GDK_KEY_botintegral = &h8a5
const GDK_KEY_vertconnector = &h8a6
const GDK_KEY_topleftsqbracket = &h8a7
const GDK_KEY_botleftsqbracket = &h8a8
const GDK_KEY_toprightsqbracket = &h8a9
const GDK_KEY_botrightsqbracket = &h8aa
const GDK_KEY_topleftparens = &h8ab
const GDK_KEY_botleftparens = &h8ac
const GDK_KEY_toprightparens = &h8ad
const GDK_KEY_botrightparens = &h8ae
const GDK_KEY_leftmiddlecurlybrace = &h8af
const GDK_KEY_rightmiddlecurlybrace = &h8b0
const GDK_KEY_topleftsummation = &h8b1
const GDK_KEY_botleftsummation = &h8b2
const GDK_KEY_topvertsummationconnector = &h8b3
const GDK_KEY_botvertsummationconnector = &h8b4
const GDK_KEY_toprightsummation = &h8b5
const GDK_KEY_botrightsummation = &h8b6
const GDK_KEY_rightmiddlesummation = &h8b7
const GDK_KEY_lessthanequal = &h8bc
const GDK_KEY_notequal = &h8bd
const GDK_KEY_greaterthanequal = &h8be
const GDK_KEY_integral = &h8bf
const GDK_KEY_therefore = &h8c0
const GDK_KEY_variation = &h8c1
const GDK_KEY_infinity = &h8c2
const GDK_KEY_nabla = &h8c5
const GDK_KEY_approximate = &h8c8
const GDK_KEY_similarequal = &h8c9
const GDK_KEY_ifonlyif = &h8cd
const GDK_KEY_implies = &h8ce
const GDK_KEY_identical = &h8cf
const GDK_KEY_radical = &h8d6
const GDK_KEY_includedin = &h8da
const GDK_KEY_includes = &h8db
const GDK_KEY_intersection = &h8dc
const GDK_KEY_union = &h8dd
const GDK_KEY_logicaland = &h8de
const GDK_KEY_logicalor = &h8df
const GDK_KEY_partialderivative = &h8ef
const GDK_KEY_function = &h8f6
const GDK_KEY_leftarrow = &h8fb
const GDK_KEY_uparrow = &h8fc
const GDK_KEY_rightarrow = &h8fd
const GDK_KEY_downarrow = &h8fe
const GDK_KEY_blank = &h9df
const GDK_KEY_soliddiamond = &h9e0
const GDK_KEY_checkerboard = &h9e1
const GDK_KEY_ht = &h9e2
const GDK_KEY_ff = &h9e3
const GDK_KEY_cr = &h9e4
const GDK_KEY_lf = &h9e5
const GDK_KEY_nl = &h9e8
const GDK_KEY_vt = &h9e9
const GDK_KEY_lowrightcorner = &h9ea
const GDK_KEY_uprightcorner = &h9eb
const GDK_KEY_upleftcorner = &h9ec
const GDK_KEY_lowleftcorner = &h9ed
const GDK_KEY_crossinglines = &h9ee
const GDK_KEY_horizlinescan1 = &h9ef
const GDK_KEY_horizlinescan3 = &h9f0
const GDK_KEY_horizlinescan5 = &h9f1
const GDK_KEY_horizlinescan7 = &h9f2
const GDK_KEY_horizlinescan9 = &h9f3
const GDK_KEY_leftt = &h9f4
const GDK_KEY_rightt = &h9f5
const GDK_KEY_bott = &h9f6
const GDK_KEY_topt = &h9f7
const GDK_KEY_vertbar = &h9f8
const GDK_KEY_emspace = &haa1
const GDK_KEY_enspace = &haa2
const GDK_KEY_em3space = &haa3
const GDK_KEY_em4space = &haa4
const GDK_KEY_digitspace = &haa5
const GDK_KEY_punctspace = &haa6
const GDK_KEY_thinspace = &haa7
const GDK_KEY_hairspace = &haa8
const GDK_KEY_emdash = &haa9
const GDK_KEY_endash = &haaa
const GDK_KEY_signifblank = &haac
const GDK_KEY_ellipsis = &haae
const GDK_KEY_doubbaselinedot = &haaf
const GDK_KEY_onethird = &hab0
const GDK_KEY_twothirds = &hab1
const GDK_KEY_onefifth = &hab2
const GDK_KEY_twofifths = &hab3
const GDK_KEY_threefifths = &hab4
const GDK_KEY_fourfifths = &hab5
const GDK_KEY_onesixth = &hab6
const GDK_KEY_fivesixths = &hab7
const GDK_KEY_careof = &hab8
const GDK_KEY_figdash = &habb
const GDK_KEY_leftanglebracket = &habc
const GDK_KEY_decimalpoint = &habd
const GDK_KEY_rightanglebracket = &habe
const GDK_KEY_marker = &habf
const GDK_KEY_oneeighth = &hac3
const GDK_KEY_threeeighths = &hac4
const GDK_KEY_fiveeighths = &hac5
const GDK_KEY_seveneighths = &hac6
const GDK_KEY_trademark = &hac9
const GDK_KEY_signaturemark = &haca
const GDK_KEY_trademarkincircle = &hacb
const GDK_KEY_leftopentriangle = &hacc
const GDK_KEY_rightopentriangle = &hacd
const GDK_KEY_emopencircle = &hace
const GDK_KEY_emopenrectangle = &hacf
const GDK_KEY_leftsinglequotemark = &had0
const GDK_KEY_rightsinglequotemark = &had1
const GDK_KEY_leftdoublequotemark = &had2
const GDK_KEY_rightdoublequotemark = &had3
const GDK_KEY_prescription = &had4
const GDK_KEY_permille = &had5
const GDK_KEY_minutes = &had6
const GDK_KEY_seconds = &had7
const GDK_KEY_latincross = &had9
const GDK_KEY_hexagram = &hada
const GDK_KEY_filledrectbullet = &hadb
const GDK_KEY_filledlefttribullet = &hadc
const GDK_KEY_filledrighttribullet = &hadd
const GDK_KEY_emfilledcircle = &hade
const GDK_KEY_emfilledrect = &hadf
const GDK_KEY_enopencircbullet = &hae0
const GDK_KEY_enopensquarebullet = &hae1
const GDK_KEY_openrectbullet = &hae2
const GDK_KEY_opentribulletup = &hae3
const GDK_KEY_opentribulletdown = &hae4
const GDK_KEY_openstar = &hae5
const GDK_KEY_enfilledcircbullet = &hae6
const GDK_KEY_enfilledsqbullet = &hae7
const GDK_KEY_filledtribulletup = &hae8
const GDK_KEY_filledtribulletdown = &hae9
const GDK_KEY_leftpointer = &haea
const GDK_KEY_rightpointer = &haeb
const GDK_KEY_club = &haec
const GDK_KEY_diamond = &haed
const GDK_KEY_heart = &haee
const GDK_KEY_maltesecross = &haf0
const GDK_KEY_dagger = &haf1
const GDK_KEY_doubledagger = &haf2
const GDK_KEY_checkmark = &haf3
const GDK_KEY_ballotcross = &haf4
const GDK_KEY_musicalsharp = &haf5
const GDK_KEY_musicalflat = &haf6
const GDK_KEY_malesymbol = &haf7
const GDK_KEY_femalesymbol = &haf8
const GDK_KEY_telephone = &haf9
const GDK_KEY_telephonerecorder = &hafa
const GDK_KEY_phonographcopyright = &hafb
const GDK_KEY_caret = &hafc
const GDK_KEY_singlelowquotemark = &hafd
const GDK_KEY_doublelowquotemark = &hafe
const GDK_KEY_cursor = &haff
const GDK_KEY_leftcaret = &hba3
const GDK_KEY_rightcaret = &hba6
const GDK_KEY_downcaret = &hba8
const GDK_KEY_upcaret = &hba9
const GDK_KEY_overbar = &hbc0
const GDK_KEY_downtack = &hbc2
const GDK_KEY_upshoe = &hbc3
const GDK_KEY_downstile = &hbc4
const GDK_KEY_underbar = &hbc6
const GDK_KEY_jot = &hbca
const GDK_KEY_quad = &hbcc
const GDK_KEY_uptack = &hbce
const GDK_KEY_circle = &hbcf
const GDK_KEY_upstile = &hbd3
const GDK_KEY_downshoe = &hbd6
const GDK_KEY_rightshoe = &hbd8
const GDK_KEY_leftshoe = &hbda
const GDK_KEY_lefttack = &hbdc
const GDK_KEY_righttack = &hbfc
const GDK_KEY_hebrew_doublelowline = &hcdf
const GDK_KEY_hebrew_aleph = &hce0
const GDK_KEY_hebrew_bet = &hce1
const GDK_KEY_hebrew_beth = &hce1
const GDK_KEY_hebrew_gimel = &hce2
const GDK_KEY_hebrew_gimmel = &hce2
const GDK_KEY_hebrew_dalet = &hce3
const GDK_KEY_hebrew_daleth = &hce3
const GDK_KEY_hebrew_he = &hce4
const GDK_KEY_hebrew_waw = &hce5
const GDK_KEY_hebrew_zain = &hce6
const GDK_KEY_hebrew_zayin = &hce6
const GDK_KEY_hebrew_chet = &hce7
const GDK_KEY_hebrew_het = &hce7
const GDK_KEY_hebrew_tet = &hce8
const GDK_KEY_hebrew_teth = &hce8
const GDK_KEY_hebrew_yod = &hce9
const GDK_KEY_hebrew_finalkaph = &hcea
const GDK_KEY_hebrew_kaph = &hceb
const GDK_KEY_hebrew_lamed = &hcec
const GDK_KEY_hebrew_finalmem = &hced
const GDK_KEY_hebrew_mem = &hcee
const GDK_KEY_hebrew_finalnun = &hcef
const GDK_KEY_hebrew_nun = &hcf0
const GDK_KEY_hebrew_samech = &hcf1
const GDK_KEY_hebrew_samekh = &hcf1
const GDK_KEY_hebrew_ayin = &hcf2
const GDK_KEY_hebrew_finalpe = &hcf3
const GDK_KEY_hebrew_pe = &hcf4
const GDK_KEY_hebrew_finalzade = &hcf5
const GDK_KEY_hebrew_finalzadi = &hcf5
const GDK_KEY_hebrew_zade = &hcf6
const GDK_KEY_hebrew_zadi = &hcf6
const GDK_KEY_hebrew_qoph = &hcf7
const GDK_KEY_hebrew_kuf = &hcf7
const GDK_KEY_hebrew_resh = &hcf8
const GDK_KEY_hebrew_shin = &hcf9
const GDK_KEY_hebrew_taw = &hcfa
const GDK_KEY_hebrew_taf = &hcfa
const GDK_KEY_Hebrew_switch = &hff7e
const GDK_KEY_Thai_kokai = &hda1
const GDK_KEY_Thai_khokhai = &hda2
const GDK_KEY_Thai_khokhuat = &hda3
const GDK_KEY_Thai_khokhwai = &hda4
const GDK_KEY_Thai_khokhon = &hda5
const GDK_KEY_Thai_khorakhang = &hda6
const GDK_KEY_Thai_ngongu = &hda7
const GDK_KEY_Thai_chochan = &hda8
const GDK_KEY_Thai_choching = &hda9
const GDK_KEY_Thai_chochang = &hdaa
const GDK_KEY_Thai_soso = &hdab
const GDK_KEY_Thai_chochoe = &hdac
const GDK_KEY_Thai_yoying = &hdad
const GDK_KEY_Thai_dochada = &hdae
const GDK_KEY_Thai_topatak = &hdaf
const GDK_KEY_Thai_thothan = &hdb0
const GDK_KEY_Thai_thonangmontho = &hdb1
const GDK_KEY_Thai_thophuthao = &hdb2
const GDK_KEY_Thai_nonen = &hdb3
const GDK_KEY_Thai_dodek = &hdb4
const GDK_KEY_Thai_totao = &hdb5
const GDK_KEY_Thai_thothung = &hdb6
const GDK_KEY_Thai_thothahan = &hdb7
const GDK_KEY_Thai_thothong = &hdb8
const GDK_KEY_Thai_nonu = &hdb9
const GDK_KEY_Thai_bobaimai = &hdba
const GDK_KEY_Thai_popla = &hdbb
const GDK_KEY_Thai_phophung = &hdbc
const GDK_KEY_Thai_fofa = &hdbd
const GDK_KEY_Thai_phophan = &hdbe
const GDK_KEY_Thai_fofan = &hdbf
const GDK_KEY_Thai_phosamphao = &hdc0
const GDK_KEY_Thai_moma = &hdc1
const GDK_KEY_Thai_yoyak = &hdc2
const GDK_KEY_Thai_rorua = &hdc3
const GDK_KEY_Thai_ru = &hdc4
const GDK_KEY_Thai_loling = &hdc5
const GDK_KEY_Thai_lu = &hdc6
const GDK_KEY_Thai_wowaen = &hdc7
const GDK_KEY_Thai_sosala = &hdc8
const GDK_KEY_Thai_sorusi = &hdc9
const GDK_KEY_Thai_sosua = &hdca
const GDK_KEY_Thai_hohip = &hdcb
const GDK_KEY_Thai_lochula = &hdcc
const GDK_KEY_Thai_oang = &hdcd
const GDK_KEY_Thai_honokhuk = &hdce
const GDK_KEY_Thai_paiyannoi = &hdcf
const GDK_KEY_Thai_saraa = &hdd0
const GDK_KEY_Thai_maihanakat = &hdd1
const GDK_KEY_Thai_saraaa = &hdd2
const GDK_KEY_Thai_saraam = &hdd3
const GDK_KEY_Thai_sarai = &hdd4
const GDK_KEY_Thai_saraii = &hdd5
const GDK_KEY_Thai_saraue = &hdd6
const GDK_KEY_Thai_sarauee = &hdd7
const GDK_KEY_Thai_sarau = &hdd8
const GDK_KEY_Thai_sarauu = &hdd9
const GDK_KEY_Thai_phinthu = &hdda
const GDK_KEY_Thai_maihanakat_maitho = &hdde
const GDK_KEY_Thai_baht = &hddf
const GDK_KEY_Thai_sarae = &hde0
const GDK_KEY_Thai_saraae = &hde1
const GDK_KEY_Thai_sarao = &hde2
const GDK_KEY_Thai_saraaimaimuan = &hde3
const GDK_KEY_Thai_saraaimaimalai = &hde4
const GDK_KEY_Thai_lakkhangyao = &hde5
const GDK_KEY_Thai_maiyamok = &hde6
const GDK_KEY_Thai_maitaikhu = &hde7
const GDK_KEY_Thai_maiek = &hde8
const GDK_KEY_Thai_maitho = &hde9
const GDK_KEY_Thai_maitri = &hdea
const GDK_KEY_Thai_maichattawa = &hdeb
const GDK_KEY_Thai_thanthakhat = &hdec
const GDK_KEY_Thai_nikhahit = &hded
const GDK_KEY_Thai_leksun = &hdf0
const GDK_KEY_Thai_leknung = &hdf1
const GDK_KEY_Thai_leksong = &hdf2
const GDK_KEY_Thai_leksam = &hdf3
const GDK_KEY_Thai_leksi = &hdf4
const GDK_KEY_Thai_lekha = &hdf5
const GDK_KEY_Thai_lekhok = &hdf6
const GDK_KEY_Thai_lekchet = &hdf7
const GDK_KEY_Thai_lekpaet = &hdf8
const GDK_KEY_Thai_lekkao = &hdf9
const GDK_KEY_Hangul = &hff31
const GDK_KEY_Hangul_Start = &hff32
const GDK_KEY_Hangul_End = &hff33
const GDK_KEY_Hangul_Hanja = &hff34
const GDK_KEY_Hangul_Jamo = &hff35
const GDK_KEY_Hangul_Romaja = &hff36
const GDK_KEY_Hangul_Codeinput = &hff37
const GDK_KEY_Hangul_Jeonja = &hff38
const GDK_KEY_Hangul_Banja = &hff39
const GDK_KEY_Hangul_PreHanja = &hff3a
const GDK_KEY_Hangul_PostHanja = &hff3b
const GDK_KEY_Hangul_SingleCandidate = &hff3c
const GDK_KEY_Hangul_MultipleCandidate = &hff3d
const GDK_KEY_Hangul_PreviousCandidate = &hff3e
const GDK_KEY_Hangul_Special = &hff3f
const GDK_KEY_Hangul_switch = &hff7e
const GDK_KEY_Hangul_Kiyeog = &hea1
const GDK_KEY_Hangul_SsangKiyeog = &hea2
const GDK_KEY_Hangul_KiyeogSios = &hea3
const GDK_KEY_Hangul_Nieun = &hea4
const GDK_KEY_Hangul_NieunJieuj = &hea5
const GDK_KEY_Hangul_NieunHieuh = &hea6
const GDK_KEY_Hangul_Dikeud = &hea7
const GDK_KEY_Hangul_SsangDikeud = &hea8
const GDK_KEY_Hangul_Rieul = &hea9
const GDK_KEY_Hangul_RieulKiyeog = &heaa
const GDK_KEY_Hangul_RieulMieum = &heab
const GDK_KEY_Hangul_RieulPieub = &heac
const GDK_KEY_Hangul_RieulSios = &head
const GDK_KEY_Hangul_RieulTieut = &heae
const GDK_KEY_Hangul_RieulPhieuf = &heaf
const GDK_KEY_Hangul_RieulHieuh = &heb0
const GDK_KEY_Hangul_Mieum = &heb1
const GDK_KEY_Hangul_Pieub = &heb2
const GDK_KEY_Hangul_SsangPieub = &heb3
const GDK_KEY_Hangul_PieubSios = &heb4
const GDK_KEY_Hangul_Sios = &heb5
const GDK_KEY_Hangul_SsangSios = &heb6
const GDK_KEY_Hangul_Ieung = &heb7
const GDK_KEY_Hangul_Jieuj = &heb8
const GDK_KEY_Hangul_SsangJieuj = &heb9
const GDK_KEY_Hangul_Cieuc = &heba
const GDK_KEY_Hangul_Khieuq = &hebb
const GDK_KEY_Hangul_Tieut = &hebc
const GDK_KEY_Hangul_Phieuf = &hebd
const GDK_KEY_Hangul_Hieuh = &hebe
const GDK_KEY_Hangul_A = &hebf
const GDK_KEY_Hangul_AE = &hec0
const GDK_KEY_Hangul_YA = &hec1
const GDK_KEY_Hangul_YAE = &hec2
const GDK_KEY_Hangul_EO = &hec3
const GDK_KEY_Hangul_E = &hec4
const GDK_KEY_Hangul_YEO = &hec5
const GDK_KEY_Hangul_YE = &hec6
const GDK_KEY_Hangul_O = &hec7
const GDK_KEY_Hangul_WA = &hec8
const GDK_KEY_Hangul_WAE = &hec9
const GDK_KEY_Hangul_OE = &heca
const GDK_KEY_Hangul_YO = &hecb
const GDK_KEY_Hangul_U = &hecc
const GDK_KEY_Hangul_WEO = &hecd
const GDK_KEY_Hangul_WE = &hece
const GDK_KEY_Hangul_WI = &hecf
const GDK_KEY_Hangul_YU = &hed0
const GDK_KEY_Hangul_EU = &hed1
const GDK_KEY_Hangul_YI = &hed2
const GDK_KEY_Hangul_I = &hed3
const GDK_KEY_Hangul_J_Kiyeog = &hed4
const GDK_KEY_Hangul_J_SsangKiyeog = &hed5
const GDK_KEY_Hangul_J_KiyeogSios = &hed6
const GDK_KEY_Hangul_J_Nieun = &hed7
const GDK_KEY_Hangul_J_NieunJieuj = &hed8
const GDK_KEY_Hangul_J_NieunHieuh = &hed9
const GDK_KEY_Hangul_J_Dikeud = &heda
const GDK_KEY_Hangul_J_Rieul = &hedb
const GDK_KEY_Hangul_J_RieulKiyeog = &hedc
const GDK_KEY_Hangul_J_RieulMieum = &hedd
const GDK_KEY_Hangul_J_RieulPieub = &hede
const GDK_KEY_Hangul_J_RieulSios = &hedf
const GDK_KEY_Hangul_J_RieulTieut = &hee0
const GDK_KEY_Hangul_J_RieulPhieuf = &hee1
const GDK_KEY_Hangul_J_RieulHieuh = &hee2
const GDK_KEY_Hangul_J_Mieum = &hee3
const GDK_KEY_Hangul_J_Pieub = &hee4
const GDK_KEY_Hangul_J_PieubSios = &hee5
const GDK_KEY_Hangul_J_Sios = &hee6
const GDK_KEY_Hangul_J_SsangSios = &hee7
const GDK_KEY_Hangul_J_Ieung = &hee8
const GDK_KEY_Hangul_J_Jieuj = &hee9
const GDK_KEY_Hangul_J_Cieuc = &heea
const GDK_KEY_Hangul_J_Khieuq = &heeb
const GDK_KEY_Hangul_J_Tieut = &heec
const GDK_KEY_Hangul_J_Phieuf = &heed
const GDK_KEY_Hangul_J_Hieuh = &heee
const GDK_KEY_Hangul_RieulYeorinHieuh = &heef
const GDK_KEY_Hangul_SunkyeongeumMieum = &hef0
const GDK_KEY_Hangul_SunkyeongeumPieub = &hef1
const GDK_KEY_Hangul_PanSios = &hef2
const GDK_KEY_Hangul_KkogjiDalrinIeung = &hef3
const GDK_KEY_Hangul_SunkyeongeumPhieuf = &hef4
const GDK_KEY_Hangul_YeorinHieuh = &hef5
const GDK_KEY_Hangul_AraeA = &hef6
const GDK_KEY_Hangul_AraeAE = &hef7
const GDK_KEY_Hangul_J_PanSios = &hef8
const GDK_KEY_Hangul_J_KkogjiDalrinIeung = &hef9
const GDK_KEY_Hangul_J_YeorinHieuh = &hefa
const GDK_KEY_Korean_Won = &heff
const GDK_KEY_Armenian_ligature_ew = &h1000587
const GDK_KEY_Armenian_full_stop = &h1000589
const GDK_KEY_Armenian_verjaket = &h1000589
const GDK_KEY_Armenian_separation_mark = &h100055d
const GDK_KEY_Armenian_but = &h100055d
const GDK_KEY_Armenian_hyphen = &h100058a
const GDK_KEY_Armenian_yentamna = &h100058a
const GDK_KEY_Armenian_exclam = &h100055c
const GDK_KEY_Armenian_amanak = &h100055c
const GDK_KEY_Armenian_accent = &h100055b
const GDK_KEY_Armenian_shesht = &h100055b
const GDK_KEY_Armenian_question = &h100055e
const GDK_KEY_Armenian_paruyk = &h100055e
const GDK_KEY_Armenian_AYB_ = &h1000531
const GDK_KEY_Armenian_ayb = &h1000561
const GDK_KEY_Armenian_BEN_ = &h1000532
const GDK_KEY_Armenian_ben = &h1000562
const GDK_KEY_Armenian_GIM_ = &h1000533
const GDK_KEY_Armenian_gim = &h1000563
const GDK_KEY_Armenian_DA_ = &h1000534
const GDK_KEY_Armenian_da = &h1000564
const GDK_KEY_Armenian_YECH_ = &h1000535
const GDK_KEY_Armenian_yech = &h1000565
const GDK_KEY_Armenian_ZA_ = &h1000536
const GDK_KEY_Armenian_za = &h1000566
const GDK_KEY_Armenian_E_ = &h1000537
const GDK_KEY_Armenian_e = &h1000567
const GDK_KEY_Armenian_AT_ = &h1000538
const GDK_KEY_Armenian_at = &h1000568
const GDK_KEY_Armenian_TO_ = &h1000539
const GDK_KEY_Armenian_to = &h1000569
const GDK_KEY_Armenian_ZHE_ = &h100053a
const GDK_KEY_Armenian_zhe = &h100056a
const GDK_KEY_Armenian_INI_ = &h100053b
const GDK_KEY_Armenian_ini = &h100056b
const GDK_KEY_Armenian_LYUN_ = &h100053c
const GDK_KEY_Armenian_lyun = &h100056c
const GDK_KEY_Armenian_KHE_ = &h100053d
const GDK_KEY_Armenian_khe = &h100056d
const GDK_KEY_Armenian_TSA_ = &h100053e
const GDK_KEY_Armenian_tsa = &h100056e
const GDK_KEY_Armenian_KEN_ = &h100053f
const GDK_KEY_Armenian_ken = &h100056f
const GDK_KEY_Armenian_HO_ = &h1000540
const GDK_KEY_Armenian_ho = &h1000570
const GDK_KEY_Armenian_DZA_ = &h1000541
const GDK_KEY_Armenian_dza = &h1000571
const GDK_KEY_Armenian_GHAT_ = &h1000542
const GDK_KEY_Armenian_ghat = &h1000572
const GDK_KEY_Armenian_TCHE_ = &h1000543
const GDK_KEY_Armenian_tche = &h1000573
const GDK_KEY_Armenian_MEN_ = &h1000544
const GDK_KEY_Armenian_men = &h1000574
const GDK_KEY_Armenian_HI_ = &h1000545
const GDK_KEY_Armenian_hi = &h1000575
const GDK_KEY_Armenian_NU_ = &h1000546
const GDK_KEY_Armenian_nu = &h1000576
const GDK_KEY_Armenian_SHA_ = &h1000547
const GDK_KEY_Armenian_sha = &h1000577
const GDK_KEY_Armenian_VO_ = &h1000548
const GDK_KEY_Armenian_vo = &h1000578
const GDK_KEY_Armenian_CHA_ = &h1000549
const GDK_KEY_Armenian_cha = &h1000579
const GDK_KEY_Armenian_PE_ = &h100054a
const GDK_KEY_Armenian_pe = &h100057a
const GDK_KEY_Armenian_JE_ = &h100054b
const GDK_KEY_Armenian_je = &h100057b
const GDK_KEY_Armenian_RA_ = &h100054c
const GDK_KEY_Armenian_ra = &h100057c
const GDK_KEY_Armenian_SE_ = &h100054d
const GDK_KEY_Armenian_se = &h100057d
const GDK_KEY_Armenian_VEV_ = &h100054e
const GDK_KEY_Armenian_vev = &h100057e
const GDK_KEY_Armenian_TYUN_ = &h100054f
const GDK_KEY_Armenian_tyun = &h100057f
const GDK_KEY_Armenian_RE_ = &h1000550
const GDK_KEY_Armenian_re = &h1000580
const GDK_KEY_Armenian_TSO_ = &h1000551
const GDK_KEY_Armenian_tso = &h1000581
const GDK_KEY_Armenian_VYUN_ = &h1000552
const GDK_KEY_Armenian_vyun = &h1000582
const GDK_KEY_Armenian_PYUR_ = &h1000553
const GDK_KEY_Armenian_pyur = &h1000583
const GDK_KEY_Armenian_KE_ = &h1000554
const GDK_KEY_Armenian_ke = &h1000584
const GDK_KEY_Armenian_O_ = &h1000555
const GDK_KEY_Armenian_o = &h1000585
const GDK_KEY_Armenian_FE_ = &h1000556
const GDK_KEY_Armenian_fe = &h1000586
const GDK_KEY_Armenian_apostrophe = &h100055a
const GDK_KEY_Georgian_an = &h10010d0
const GDK_KEY_Georgian_ban = &h10010d1
const GDK_KEY_Georgian_gan = &h10010d2
const GDK_KEY_Georgian_don = &h10010d3
const GDK_KEY_Georgian_en = &h10010d4
const GDK_KEY_Georgian_vin = &h10010d5
const GDK_KEY_Georgian_zen = &h10010d6
const GDK_KEY_Georgian_tan = &h10010d7
const GDK_KEY_Georgian_in = &h10010d8
const GDK_KEY_Georgian_kan = &h10010d9
const GDK_KEY_Georgian_las = &h10010da
const GDK_KEY_Georgian_man = &h10010db
const GDK_KEY_Georgian_nar = &h10010dc
const GDK_KEY_Georgian_on = &h10010dd
const GDK_KEY_Georgian_par = &h10010de
const GDK_KEY_Georgian_zhar = &h10010df
const GDK_KEY_Georgian_rae = &h10010e0
const GDK_KEY_Georgian_san = &h10010e1
const GDK_KEY_Georgian_tar = &h10010e2
const GDK_KEY_Georgian_un = &h10010e3
const GDK_KEY_Georgian_phar = &h10010e4
const GDK_KEY_Georgian_khar = &h10010e5
const GDK_KEY_Georgian_ghan = &h10010e6
const GDK_KEY_Georgian_qar = &h10010e7
const GDK_KEY_Georgian_shin = &h10010e8
const GDK_KEY_Georgian_chin = &h10010e9
const GDK_KEY_Georgian_can = &h10010ea
const GDK_KEY_Georgian_jil = &h10010eb
const GDK_KEY_Georgian_cil = &h10010ec
const GDK_KEY_Georgian_char = &h10010ed
const GDK_KEY_Georgian_xan = &h10010ee
const GDK_KEY_Georgian_jhan = &h10010ef
const GDK_KEY_Georgian_hae = &h10010f0
const GDK_KEY_Georgian_he = &h10010f1
const GDK_KEY_Georgian_hie = &h10010f2
const GDK_KEY_Georgian_we = &h10010f3
const GDK_KEY_Georgian_har = &h10010f4
const GDK_KEY_Georgian_hoe = &h10010f5
const GDK_KEY_Georgian_fi = &h10010f6
const GDK_KEY_Xabovedot_ = &h1001e8a
const GDK_KEY_Ibreve_ = &h100012c
const GDK_KEY_Zstroke_ = &h10001b5
const GDK_KEY_Gcaron_ = &h10001e6
const GDK_KEY_Ocaron_ = &h10001d1
const GDK_KEY_Obarred_ = &h100019f
const GDK_KEY_xabovedot = &h1001e8b
const GDK_KEY_ibreve = &h100012d
const GDK_KEY_zstroke = &h10001b6
const GDK_KEY_gcaron = &h10001e7
const GDK_KEY_ocaron = &h10001d2
const GDK_KEY_obarred = &h1000275
const GDK_KEY_SCHWA_ = &h100018f
const GDK_KEY_schwa = &h1000259
const GDK_KEY_EZH = &h10001b7
const GDK_KEY_ezh_ = &h1000292
const GDK_KEY_Lbelowdot_ = &h1001e36
const GDK_KEY_lbelowdot = &h1001e37
const GDK_KEY_Abelowdot_ = &h1001ea0
const GDK_KEY_abelowdot = &h1001ea1
const GDK_KEY_Ahook_ = &h1001ea2
const GDK_KEY_ahook = &h1001ea3
const GDK_KEY_Acircumflexacute_ = &h1001ea4
const GDK_KEY_acircumflexacute = &h1001ea5
const GDK_KEY_Acircumflexgrave_ = &h1001ea6
const GDK_KEY_acircumflexgrave = &h1001ea7
const GDK_KEY_Acircumflexhook_ = &h1001ea8
const GDK_KEY_acircumflexhook = &h1001ea9
const GDK_KEY_Acircumflextilde_ = &h1001eaa
const GDK_KEY_acircumflextilde = &h1001eab
const GDK_KEY_Acircumflexbelowdot_ = &h1001eac
const GDK_KEY_acircumflexbelowdot = &h1001ead
const GDK_KEY_Abreveacute_ = &h1001eae
const GDK_KEY_abreveacute = &h1001eaf
const GDK_KEY_Abrevegrave_ = &h1001eb0
const GDK_KEY_abrevegrave = &h1001eb1
const GDK_KEY_Abrevehook_ = &h1001eb2
const GDK_KEY_abrevehook = &h1001eb3
const GDK_KEY_Abrevetilde_ = &h1001eb4
const GDK_KEY_abrevetilde = &h1001eb5
const GDK_KEY_Abrevebelowdot_ = &h1001eb6
const GDK_KEY_abrevebelowdot = &h1001eb7
const GDK_KEY_Ebelowdot_ = &h1001eb8
const GDK_KEY_ebelowdot = &h1001eb9
const GDK_KEY_Ehook_ = &h1001eba
const GDK_KEY_ehook = &h1001ebb
const GDK_KEY_Etilde_ = &h1001ebc
const GDK_KEY_etilde = &h1001ebd
const GDK_KEY_Ecircumflexacute_ = &h1001ebe
const GDK_KEY_ecircumflexacute = &h1001ebf
const GDK_KEY_Ecircumflexgrave_ = &h1001ec0
const GDK_KEY_ecircumflexgrave = &h1001ec1
const GDK_KEY_Ecircumflexhook_ = &h1001ec2
const GDK_KEY_ecircumflexhook = &h1001ec3
const GDK_KEY_Ecircumflextilde_ = &h1001ec4
const GDK_KEY_ecircumflextilde = &h1001ec5
const GDK_KEY_Ecircumflexbelowdot_ = &h1001ec6
const GDK_KEY_ecircumflexbelowdot = &h1001ec7
const GDK_KEY_Ihook_ = &h1001ec8
const GDK_KEY_ihook = &h1001ec9
const GDK_KEY_Ibelowdot_ = &h1001eca
const GDK_KEY_ibelowdot = &h1001ecb
const GDK_KEY_Obelowdot_ = &h1001ecc
const GDK_KEY_obelowdot = &h1001ecd
const GDK_KEY_Ohook_ = &h1001ece
const GDK_KEY_ohook = &h1001ecf
const GDK_KEY_Ocircumflexacute_ = &h1001ed0
const GDK_KEY_ocircumflexacute = &h1001ed1
const GDK_KEY_Ocircumflexgrave_ = &h1001ed2
const GDK_KEY_ocircumflexgrave = &h1001ed3
const GDK_KEY_Ocircumflexhook_ = &h1001ed4
const GDK_KEY_ocircumflexhook = &h1001ed5
const GDK_KEY_Ocircumflextilde_ = &h1001ed6
const GDK_KEY_ocircumflextilde = &h1001ed7
const GDK_KEY_Ocircumflexbelowdot_ = &h1001ed8
const GDK_KEY_ocircumflexbelowdot = &h1001ed9
const GDK_KEY_Ohornacute_ = &h1001eda
const GDK_KEY_ohornacute = &h1001edb
const GDK_KEY_Ohorngrave_ = &h1001edc
const GDK_KEY_ohorngrave = &h1001edd
const GDK_KEY_Ohornhook_ = &h1001ede
const GDK_KEY_ohornhook = &h1001edf
const GDK_KEY_Ohorntilde_ = &h1001ee0
const GDK_KEY_ohorntilde = &h1001ee1
const GDK_KEY_Ohornbelowdot_ = &h1001ee2
const GDK_KEY_ohornbelowdot = &h1001ee3
const GDK_KEY_Ubelowdot_ = &h1001ee4
const GDK_KEY_ubelowdot = &h1001ee5
const GDK_KEY_Uhook_ = &h1001ee6
const GDK_KEY_uhook = &h1001ee7
const GDK_KEY_Uhornacute_ = &h1001ee8
const GDK_KEY_uhornacute = &h1001ee9
const GDK_KEY_Uhorngrave_ = &h1001eea
const GDK_KEY_uhorngrave = &h1001eeb
const GDK_KEY_Uhornhook_ = &h1001eec
const GDK_KEY_uhornhook = &h1001eed
const GDK_KEY_Uhorntilde_ = &h1001eee
const GDK_KEY_uhorntilde = &h1001eef
const GDK_KEY_Uhornbelowdot_ = &h1001ef0
const GDK_KEY_uhornbelowdot = &h1001ef1
const GDK_KEY_Ybelowdot_ = &h1001ef4
const GDK_KEY_ybelowdot = &h1001ef5
const GDK_KEY_Yhook_ = &h1001ef6
const GDK_KEY_yhook = &h1001ef7
const GDK_KEY_Ytilde_ = &h1001ef8
const GDK_KEY_ytilde = &h1001ef9
const GDK_KEY_Ohorn_ = &h10001a0
const GDK_KEY_ohorn = &h10001a1
const GDK_KEY_Uhorn_ = &h10001af
const GDK_KEY_uhorn = &h10001b0
const GDK_KEY_EcuSign = &h10020a0
const GDK_KEY_ColonSign = &h10020a1
const GDK_KEY_CruzeiroSign = &h10020a2
const GDK_KEY_FFrancSign = &h10020a3
const GDK_KEY_LiraSign = &h10020a4
const GDK_KEY_MillSign = &h10020a5
const GDK_KEY_NairaSign = &h10020a6
const GDK_KEY_PesetaSign = &h10020a7
const GDK_KEY_RupeeSign = &h10020a8
const GDK_KEY_WonSign = &h10020a9
const GDK_KEY_NewSheqelSign = &h10020aa
const GDK_KEY_DongSign = &h10020ab
const GDK_KEY_EuroSign = &h20ac
const GDK_KEY_zerosuperior = &h1002070
const GDK_KEY_foursuperior = &h1002074
const GDK_KEY_fivesuperior = &h1002075
const GDK_KEY_sixsuperior = &h1002076
const GDK_KEY_sevensuperior = &h1002077
const GDK_KEY_eightsuperior = &h1002078
const GDK_KEY_ninesuperior = &h1002079
const GDK_KEY_zerosubscript = &h1002080
const GDK_KEY_onesubscript = &h1002081
const GDK_KEY_twosubscript = &h1002082
const GDK_KEY_threesubscript = &h1002083
const GDK_KEY_foursubscript = &h1002084
const GDK_KEY_fivesubscript = &h1002085
const GDK_KEY_sixsubscript = &h1002086
const GDK_KEY_sevensubscript = &h1002087
const GDK_KEY_eightsubscript = &h1002088
const GDK_KEY_ninesubscript = &h1002089
const GDK_KEY_partdifferential = &h1002202
const GDK_KEY_emptyset = &h1002205
const GDK_KEY_elementof = &h1002208
const GDK_KEY_notelementof = &h1002209
const GDK_KEY_containsas = &h100220b
const GDK_KEY_squareroot = &h100221a
const GDK_KEY_cuberoot = &h100221b
const GDK_KEY_fourthroot = &h100221c
const GDK_KEY_dintegral = &h100222c
const GDK_KEY_tintegral = &h100222d
const GDK_KEY_because = &h1002235
const GDK_KEY_approxeq = &h1002248
const GDK_KEY_notapproxeq = &h1002247
const GDK_KEY_notidentical = &h1002262
const GDK_KEY_stricteq = &h1002263
const GDK_KEY_braille_dot_1 = &hfff1
const GDK_KEY_braille_dot_2 = &hfff2
const GDK_KEY_braille_dot_3 = &hfff3
const GDK_KEY_braille_dot_4 = &hfff4
const GDK_KEY_braille_dot_5 = &hfff5
const GDK_KEY_braille_dot_6 = &hfff6
const GDK_KEY_braille_dot_7 = &hfff7
const GDK_KEY_braille_dot_8 = &hfff8
const GDK_KEY_braille_dot_9 = &hfff9
const GDK_KEY_braille_dot_10 = &hfffa
const GDK_KEY_braille_blank = &h1002800
const GDK_KEY_braille_dots_1 = &h1002801
const GDK_KEY_braille_dots_2 = &h1002802
const GDK_KEY_braille_dots_12 = &h1002803
const GDK_KEY_braille_dots_3 = &h1002804
const GDK_KEY_braille_dots_13 = &h1002805
const GDK_KEY_braille_dots_23 = &h1002806
const GDK_KEY_braille_dots_123 = &h1002807
const GDK_KEY_braille_dots_4 = &h1002808
const GDK_KEY_braille_dots_14 = &h1002809
const GDK_KEY_braille_dots_24 = &h100280a
const GDK_KEY_braille_dots_124 = &h100280b
const GDK_KEY_braille_dots_34 = &h100280c
const GDK_KEY_braille_dots_134 = &h100280d
const GDK_KEY_braille_dots_234 = &h100280e
const GDK_KEY_braille_dots_1234 = &h100280f
const GDK_KEY_braille_dots_5 = &h1002810
const GDK_KEY_braille_dots_15 = &h1002811
const GDK_KEY_braille_dots_25 = &h1002812
const GDK_KEY_braille_dots_125 = &h1002813
const GDK_KEY_braille_dots_35 = &h1002814
const GDK_KEY_braille_dots_135 = &h1002815
const GDK_KEY_braille_dots_235 = &h1002816
const GDK_KEY_braille_dots_1235 = &h1002817
const GDK_KEY_braille_dots_45 = &h1002818
const GDK_KEY_braille_dots_145 = &h1002819
const GDK_KEY_braille_dots_245 = &h100281a
const GDK_KEY_braille_dots_1245 = &h100281b
const GDK_KEY_braille_dots_345 = &h100281c
const GDK_KEY_braille_dots_1345 = &h100281d
const GDK_KEY_braille_dots_2345 = &h100281e
const GDK_KEY_braille_dots_12345 = &h100281f
const GDK_KEY_braille_dots_6 = &h1002820
const GDK_KEY_braille_dots_16 = &h1002821
const GDK_KEY_braille_dots_26 = &h1002822
const GDK_KEY_braille_dots_126 = &h1002823
const GDK_KEY_braille_dots_36 = &h1002824
const GDK_KEY_braille_dots_136 = &h1002825
const GDK_KEY_braille_dots_236 = &h1002826
const GDK_KEY_braille_dots_1236 = &h1002827
const GDK_KEY_braille_dots_46 = &h1002828
const GDK_KEY_braille_dots_146 = &h1002829
const GDK_KEY_braille_dots_246 = &h100282a
const GDK_KEY_braille_dots_1246 = &h100282b
const GDK_KEY_braille_dots_346 = &h100282c
const GDK_KEY_braille_dots_1346 = &h100282d
const GDK_KEY_braille_dots_2346 = &h100282e
const GDK_KEY_braille_dots_12346 = &h100282f
const GDK_KEY_braille_dots_56 = &h1002830
const GDK_KEY_braille_dots_156 = &h1002831
const GDK_KEY_braille_dots_256 = &h1002832
const GDK_KEY_braille_dots_1256 = &h1002833
const GDK_KEY_braille_dots_356 = &h1002834
const GDK_KEY_braille_dots_1356 = &h1002835
const GDK_KEY_braille_dots_2356 = &h1002836
const GDK_KEY_braille_dots_12356 = &h1002837
const GDK_KEY_braille_dots_456 = &h1002838
const GDK_KEY_braille_dots_1456 = &h1002839
const GDK_KEY_braille_dots_2456 = &h100283a
const GDK_KEY_braille_dots_12456 = &h100283b
const GDK_KEY_braille_dots_3456 = &h100283c
const GDK_KEY_braille_dots_13456 = &h100283d
const GDK_KEY_braille_dots_23456 = &h100283e
const GDK_KEY_braille_dots_123456 = &h100283f
const GDK_KEY_braille_dots_7 = &h1002840
const GDK_KEY_braille_dots_17 = &h1002841
const GDK_KEY_braille_dots_27 = &h1002842
const GDK_KEY_braille_dots_127 = &h1002843
const GDK_KEY_braille_dots_37 = &h1002844
const GDK_KEY_braille_dots_137 = &h1002845
const GDK_KEY_braille_dots_237 = &h1002846
const GDK_KEY_braille_dots_1237 = &h1002847
const GDK_KEY_braille_dots_47 = &h1002848
const GDK_KEY_braille_dots_147 = &h1002849
const GDK_KEY_braille_dots_247 = &h100284a
const GDK_KEY_braille_dots_1247 = &h100284b
const GDK_KEY_braille_dots_347 = &h100284c
const GDK_KEY_braille_dots_1347 = &h100284d
const GDK_KEY_braille_dots_2347 = &h100284e
const GDK_KEY_braille_dots_12347 = &h100284f
const GDK_KEY_braille_dots_57 = &h1002850
const GDK_KEY_braille_dots_157 = &h1002851
const GDK_KEY_braille_dots_257 = &h1002852
const GDK_KEY_braille_dots_1257 = &h1002853
const GDK_KEY_braille_dots_357 = &h1002854
const GDK_KEY_braille_dots_1357 = &h1002855
const GDK_KEY_braille_dots_2357 = &h1002856
const GDK_KEY_braille_dots_12357 = &h1002857
const GDK_KEY_braille_dots_457 = &h1002858
const GDK_KEY_braille_dots_1457 = &h1002859
const GDK_KEY_braille_dots_2457 = &h100285a
const GDK_KEY_braille_dots_12457 = &h100285b
const GDK_KEY_braille_dots_3457 = &h100285c
const GDK_KEY_braille_dots_13457 = &h100285d
const GDK_KEY_braille_dots_23457 = &h100285e
const GDK_KEY_braille_dots_123457 = &h100285f
const GDK_KEY_braille_dots_67 = &h1002860
const GDK_KEY_braille_dots_167 = &h1002861
const GDK_KEY_braille_dots_267 = &h1002862
const GDK_KEY_braille_dots_1267 = &h1002863
const GDK_KEY_braille_dots_367 = &h1002864
const GDK_KEY_braille_dots_1367 = &h1002865
const GDK_KEY_braille_dots_2367 = &h1002866
const GDK_KEY_braille_dots_12367 = &h1002867
const GDK_KEY_braille_dots_467 = &h1002868
const GDK_KEY_braille_dots_1467 = &h1002869
const GDK_KEY_braille_dots_2467 = &h100286a
const GDK_KEY_braille_dots_12467 = &h100286b
const GDK_KEY_braille_dots_3467 = &h100286c
const GDK_KEY_braille_dots_13467 = &h100286d
const GDK_KEY_braille_dots_23467 = &h100286e
const GDK_KEY_braille_dots_123467 = &h100286f
const GDK_KEY_braille_dots_567 = &h1002870
const GDK_KEY_braille_dots_1567 = &h1002871
const GDK_KEY_braille_dots_2567 = &h1002872
const GDK_KEY_braille_dots_12567 = &h1002873
const GDK_KEY_braille_dots_3567 = &h1002874
const GDK_KEY_braille_dots_13567 = &h1002875
const GDK_KEY_braille_dots_23567 = &h1002876
const GDK_KEY_braille_dots_123567 = &h1002877
const GDK_KEY_braille_dots_4567 = &h1002878
const GDK_KEY_braille_dots_14567 = &h1002879
const GDK_KEY_braille_dots_24567 = &h100287a
const GDK_KEY_braille_dots_124567 = &h100287b
const GDK_KEY_braille_dots_34567 = &h100287c
const GDK_KEY_braille_dots_134567 = &h100287d
const GDK_KEY_braille_dots_234567 = &h100287e
const GDK_KEY_braille_dots_1234567 = &h100287f
const GDK_KEY_braille_dots_8 = &h1002880
const GDK_KEY_braille_dots_18 = &h1002881
const GDK_KEY_braille_dots_28 = &h1002882
const GDK_KEY_braille_dots_128 = &h1002883
const GDK_KEY_braille_dots_38 = &h1002884
const GDK_KEY_braille_dots_138 = &h1002885
const GDK_KEY_braille_dots_238 = &h1002886
const GDK_KEY_braille_dots_1238 = &h1002887
const GDK_KEY_braille_dots_48 = &h1002888
const GDK_KEY_braille_dots_148 = &h1002889
const GDK_KEY_braille_dots_248 = &h100288a
const GDK_KEY_braille_dots_1248 = &h100288b
const GDK_KEY_braille_dots_348 = &h100288c
const GDK_KEY_braille_dots_1348 = &h100288d
const GDK_KEY_braille_dots_2348 = &h100288e
const GDK_KEY_braille_dots_12348 = &h100288f
const GDK_KEY_braille_dots_58 = &h1002890
const GDK_KEY_braille_dots_158 = &h1002891
const GDK_KEY_braille_dots_258 = &h1002892
const GDK_KEY_braille_dots_1258 = &h1002893
const GDK_KEY_braille_dots_358 = &h1002894
const GDK_KEY_braille_dots_1358 = &h1002895
const GDK_KEY_braille_dots_2358 = &h1002896
const GDK_KEY_braille_dots_12358 = &h1002897
const GDK_KEY_braille_dots_458 = &h1002898
const GDK_KEY_braille_dots_1458 = &h1002899
const GDK_KEY_braille_dots_2458 = &h100289a
const GDK_KEY_braille_dots_12458 = &h100289b
const GDK_KEY_braille_dots_3458 = &h100289c
const GDK_KEY_braille_dots_13458 = &h100289d
const GDK_KEY_braille_dots_23458 = &h100289e
const GDK_KEY_braille_dots_123458 = &h100289f
const GDK_KEY_braille_dots_68 = &h10028a0
const GDK_KEY_braille_dots_168 = &h10028a1
const GDK_KEY_braille_dots_268 = &h10028a2
const GDK_KEY_braille_dots_1268 = &h10028a3
const GDK_KEY_braille_dots_368 = &h10028a4
const GDK_KEY_braille_dots_1368 = &h10028a5
const GDK_KEY_braille_dots_2368 = &h10028a6
const GDK_KEY_braille_dots_12368 = &h10028a7
const GDK_KEY_braille_dots_468 = &h10028a8
const GDK_KEY_braille_dots_1468 = &h10028a9
const GDK_KEY_braille_dots_2468 = &h10028aa
const GDK_KEY_braille_dots_12468 = &h10028ab
const GDK_KEY_braille_dots_3468 = &h10028ac
const GDK_KEY_braille_dots_13468 = &h10028ad
const GDK_KEY_braille_dots_23468 = &h10028ae
const GDK_KEY_braille_dots_123468 = &h10028af
const GDK_KEY_braille_dots_568 = &h10028b0
const GDK_KEY_braille_dots_1568 = &h10028b1
const GDK_KEY_braille_dots_2568 = &h10028b2
const GDK_KEY_braille_dots_12568 = &h10028b3
const GDK_KEY_braille_dots_3568 = &h10028b4
const GDK_KEY_braille_dots_13568 = &h10028b5
const GDK_KEY_braille_dots_23568 = &h10028b6
const GDK_KEY_braille_dots_123568 = &h10028b7
const GDK_KEY_braille_dots_4568 = &h10028b8
const GDK_KEY_braille_dots_14568 = &h10028b9
const GDK_KEY_braille_dots_24568 = &h10028ba
const GDK_KEY_braille_dots_124568 = &h10028bb
const GDK_KEY_braille_dots_34568 = &h10028bc
const GDK_KEY_braille_dots_134568 = &h10028bd
const GDK_KEY_braille_dots_234568 = &h10028be
const GDK_KEY_braille_dots_1234568 = &h10028bf
const GDK_KEY_braille_dots_78 = &h10028c0
const GDK_KEY_braille_dots_178 = &h10028c1
const GDK_KEY_braille_dots_278 = &h10028c2
const GDK_KEY_braille_dots_1278 = &h10028c3
const GDK_KEY_braille_dots_378 = &h10028c4
const GDK_KEY_braille_dots_1378 = &h10028c5
const GDK_KEY_braille_dots_2378 = &h10028c6
const GDK_KEY_braille_dots_12378 = &h10028c7
const GDK_KEY_braille_dots_478 = &h10028c8
const GDK_KEY_braille_dots_1478 = &h10028c9
const GDK_KEY_braille_dots_2478 = &h10028ca
const GDK_KEY_braille_dots_12478 = &h10028cb
const GDK_KEY_braille_dots_3478 = &h10028cc
const GDK_KEY_braille_dots_13478 = &h10028cd
const GDK_KEY_braille_dots_23478 = &h10028ce
const GDK_KEY_braille_dots_123478 = &h10028cf
const GDK_KEY_braille_dots_578 = &h10028d0
const GDK_KEY_braille_dots_1578 = &h10028d1
const GDK_KEY_braille_dots_2578 = &h10028d2
const GDK_KEY_braille_dots_12578 = &h10028d3
const GDK_KEY_braille_dots_3578 = &h10028d4
const GDK_KEY_braille_dots_13578 = &h10028d5
const GDK_KEY_braille_dots_23578 = &h10028d6
const GDK_KEY_braille_dots_123578 = &h10028d7
const GDK_KEY_braille_dots_4578 = &h10028d8
const GDK_KEY_braille_dots_14578 = &h10028d9
const GDK_KEY_braille_dots_24578 = &h10028da
const GDK_KEY_braille_dots_124578 = &h10028db
const GDK_KEY_braille_dots_34578 = &h10028dc
const GDK_KEY_braille_dots_134578 = &h10028dd
const GDK_KEY_braille_dots_234578 = &h10028de
const GDK_KEY_braille_dots_1234578 = &h10028df
const GDK_KEY_braille_dots_678 = &h10028e0
const GDK_KEY_braille_dots_1678 = &h10028e1
const GDK_KEY_braille_dots_2678 = &h10028e2
const GDK_KEY_braille_dots_12678 = &h10028e3
const GDK_KEY_braille_dots_3678 = &h10028e4
const GDK_KEY_braille_dots_13678 = &h10028e5
const GDK_KEY_braille_dots_23678 = &h10028e6
const GDK_KEY_braille_dots_123678 = &h10028e7
const GDK_KEY_braille_dots_4678 = &h10028e8
const GDK_KEY_braille_dots_14678 = &h10028e9
const GDK_KEY_braille_dots_24678 = &h10028ea
const GDK_KEY_braille_dots_124678 = &h10028eb
const GDK_KEY_braille_dots_34678 = &h10028ec
const GDK_KEY_braille_dots_134678 = &h10028ed
const GDK_KEY_braille_dots_234678 = &h10028ee
const GDK_KEY_braille_dots_1234678 = &h10028ef
const GDK_KEY_braille_dots_5678 = &h10028f0
const GDK_KEY_braille_dots_15678 = &h10028f1
const GDK_KEY_braille_dots_25678 = &h10028f2
const GDK_KEY_braille_dots_125678 = &h10028f3
const GDK_KEY_braille_dots_35678 = &h10028f4
const GDK_KEY_braille_dots_135678 = &h10028f5
const GDK_KEY_braille_dots_235678 = &h10028f6
const GDK_KEY_braille_dots_1235678 = &h10028f7
const GDK_KEY_braille_dots_45678 = &h10028f8
const GDK_KEY_braille_dots_145678 = &h10028f9
const GDK_KEY_braille_dots_245678 = &h10028fa
const GDK_KEY_braille_dots_1245678 = &h10028fb
const GDK_KEY_braille_dots_345678 = &h10028fc
const GDK_KEY_braille_dots_1345678 = &h10028fd
const GDK_KEY_braille_dots_2345678 = &h10028fe
const GDK_KEY_braille_dots_12345678 = &h10028ff
const GDK_KEY_Sinh_ng = &h1000d82
const GDK_KEY_Sinh_h2 = &h1000d83
const GDK_KEY_Sinh_a = &h1000d85
const GDK_KEY_Sinh_aa = &h1000d86
const GDK_KEY_Sinh_ae = &h1000d87
const GDK_KEY_Sinh_aee = &h1000d88
const GDK_KEY_Sinh_i = &h1000d89
const GDK_KEY_Sinh_ii = &h1000d8a
const GDK_KEY_Sinh_u = &h1000d8b
const GDK_KEY_Sinh_uu = &h1000d8c
const GDK_KEY_Sinh_ri = &h1000d8d
const GDK_KEY_Sinh_rii = &h1000d8e
const GDK_KEY_Sinh_lu = &h1000d8f
const GDK_KEY_Sinh_luu = &h1000d90
const GDK_KEY_Sinh_e = &h1000d91
const GDK_KEY_Sinh_ee = &h1000d92
const GDK_KEY_Sinh_ai = &h1000d93
const GDK_KEY_Sinh_o = &h1000d94
const GDK_KEY_Sinh_oo = &h1000d95
const GDK_KEY_Sinh_au = &h1000d96
const GDK_KEY_Sinh_ka = &h1000d9a
const GDK_KEY_Sinh_kha = &h1000d9b
const GDK_KEY_Sinh_ga = &h1000d9c
const GDK_KEY_Sinh_gha = &h1000d9d
const GDK_KEY_Sinh_ng2 = &h1000d9e
const GDK_KEY_Sinh_nga = &h1000d9f
const GDK_KEY_Sinh_ca = &h1000da0
const GDK_KEY_Sinh_cha = &h1000da1
const GDK_KEY_Sinh_ja = &h1000da2
const GDK_KEY_Sinh_jha = &h1000da3
const GDK_KEY_Sinh_nya = &h1000da4
const GDK_KEY_Sinh_jnya = &h1000da5
const GDK_KEY_Sinh_nja = &h1000da6
const GDK_KEY_Sinh_tta = &h1000da7
const GDK_KEY_Sinh_ttha = &h1000da8
const GDK_KEY_Sinh_dda = &h1000da9
const GDK_KEY_Sinh_ddha = &h1000daa
const GDK_KEY_Sinh_nna = &h1000dab
const GDK_KEY_Sinh_ndda = &h1000dac
const GDK_KEY_Sinh_tha = &h1000dad
const GDK_KEY_Sinh_thha = &h1000dae
const GDK_KEY_Sinh_dha = &h1000daf
const GDK_KEY_Sinh_dhha = &h1000db0
const GDK_KEY_Sinh_na = &h1000db1
const GDK_KEY_Sinh_ndha = &h1000db3
const GDK_KEY_Sinh_pa = &h1000db4
const GDK_KEY_Sinh_pha = &h1000db5
const GDK_KEY_Sinh_ba = &h1000db6
const GDK_KEY_Sinh_bha = &h1000db7
const GDK_KEY_Sinh_ma = &h1000db8
const GDK_KEY_Sinh_mba = &h1000db9
const GDK_KEY_Sinh_ya = &h1000dba
const GDK_KEY_Sinh_ra = &h1000dbb
const GDK_KEY_Sinh_la = &h1000dbd
const GDK_KEY_Sinh_va = &h1000dc0
const GDK_KEY_Sinh_sha = &h1000dc1
const GDK_KEY_Sinh_ssha = &h1000dc2
const GDK_KEY_Sinh_sa = &h1000dc3
const GDK_KEY_Sinh_ha = &h1000dc4
const GDK_KEY_Sinh_lla = &h1000dc5
const GDK_KEY_Sinh_fa = &h1000dc6
const GDK_KEY_Sinh_al = &h1000dca
const GDK_KEY_Sinh_aa2 = &h1000dcf
const GDK_KEY_Sinh_ae2 = &h1000dd0
const GDK_KEY_Sinh_aee2 = &h1000dd1
const GDK_KEY_Sinh_i2 = &h1000dd2
const GDK_KEY_Sinh_ii2 = &h1000dd3
const GDK_KEY_Sinh_u2 = &h1000dd4
const GDK_KEY_Sinh_uu2 = &h1000dd6
const GDK_KEY_Sinh_ru2 = &h1000dd8
const GDK_KEY_Sinh_e2 = &h1000dd9
const GDK_KEY_Sinh_ee2 = &h1000dda
const GDK_KEY_Sinh_ai2 = &h1000ddb
const GDK_KEY_Sinh_o2 = &h1000ddc
const GDK_KEY_Sinh_oo2 = &h1000ddd
const GDK_KEY_Sinh_au2 = &h1000dde
const GDK_KEY_Sinh_lu2 = &h1000ddf
const GDK_KEY_Sinh_ruu2 = &h1000df2
const GDK_KEY_Sinh_luu2 = &h1000df3
const GDK_KEY_Sinh_kunddaliya = &h1000df4
const GDK_KEY_ModeLock = &h1008ff01
const GDK_KEY_MonBrightnessUp = &h1008ff02
const GDK_KEY_MonBrightnessDown = &h1008ff03
const GDK_KEY_KbdLightOnOff = &h1008ff04
const GDK_KEY_KbdBrightnessUp = &h1008ff05
const GDK_KEY_KbdBrightnessDown = &h1008ff06
const GDK_KEY_Standby = &h1008ff10
const GDK_KEY_AudioLowerVolume = &h1008ff11
const GDK_KEY_AudioMute = &h1008ff12
const GDK_KEY_AudioRaiseVolume = &h1008ff13
const GDK_KEY_AudioPlay = &h1008ff14
const GDK_KEY_AudioStop = &h1008ff15
const GDK_KEY_AudioPrev = &h1008ff16
const GDK_KEY_AudioNext = &h1008ff17
const GDK_KEY_HomePage = &h1008ff18
const GDK_KEY_Mail = &h1008ff19
const GDK_KEY_Start = &h1008ff1a
const GDK_KEY_Search = &h1008ff1b
const GDK_KEY_AudioRecord = &h1008ff1c
const GDK_KEY_Calculator = &h1008ff1d
const GDK_KEY_Memo = &h1008ff1e
const GDK_KEY_ToDoList = &h1008ff1f
const GDK_KEY_Calendar = &h1008ff20
const GDK_KEY_PowerDown = &h1008ff21
const GDK_KEY_ContrastAdjust = &h1008ff22
const GDK_KEY_RockerUp = &h1008ff23
const GDK_KEY_RockerDown = &h1008ff24
const GDK_KEY_RockerEnter = &h1008ff25
const GDK_KEY_Back = &h1008ff26
const GDK_KEY_Forward = &h1008ff27
const GDK_KEY_Stop = &h1008ff28
const GDK_KEY_Refresh = &h1008ff29
const GDK_KEY_PowerOff = &h1008ff2a
const GDK_KEY_WakeUp = &h1008ff2b
const GDK_KEY_Eject = &h1008ff2c
const GDK_KEY_ScreenSaver = &h1008ff2d
const GDK_KEY_WWW = &h1008ff2e
const GDK_KEY_Sleep = &h1008ff2f
const GDK_KEY_Favorites = &h1008ff30
const GDK_KEY_AudioPause = &h1008ff31
const GDK_KEY_AudioMedia = &h1008ff32
const GDK_KEY_MyComputer = &h1008ff33
const GDK_KEY_VendorHome = &h1008ff34
const GDK_KEY_LightBulb = &h1008ff35
const GDK_KEY_Shop = &h1008ff36
const GDK_KEY_History = &h1008ff37
const GDK_KEY_OpenURL = &h1008ff38
const GDK_KEY_AddFavorite = &h1008ff39
const GDK_KEY_HotLinks = &h1008ff3a
const GDK_KEY_BrightnessAdjust = &h1008ff3b
const GDK_KEY_Finance = &h1008ff3c
const GDK_KEY_Community = &h1008ff3d
const GDK_KEY_AudioRewind = &h1008ff3e
const GDK_KEY_BackForward = &h1008ff3f
const GDK_KEY_Launch0 = &h1008ff40
const GDK_KEY_Launch1 = &h1008ff41
const GDK_KEY_Launch2 = &h1008ff42
const GDK_KEY_Launch3 = &h1008ff43
const GDK_KEY_Launch4 = &h1008ff44
const GDK_KEY_Launch5 = &h1008ff45
const GDK_KEY_Launch6 = &h1008ff46
const GDK_KEY_Launch7 = &h1008ff47
const GDK_KEY_Launch8 = &h1008ff48
const GDK_KEY_Launch9 = &h1008ff49
const GDK_KEY_LaunchA = &h1008ff4a
const GDK_KEY_LaunchB = &h1008ff4b
const GDK_KEY_LaunchC = &h1008ff4c
const GDK_KEY_LaunchD = &h1008ff4d
const GDK_KEY_LaunchE = &h1008ff4e
const GDK_KEY_LaunchF = &h1008ff4f
const GDK_KEY_ApplicationLeft = &h1008ff50
const GDK_KEY_ApplicationRight = &h1008ff51
const GDK_KEY_Book = &h1008ff52
const GDK_KEY_CD = &h1008ff53
const GDK_KEY_WindowClear = &h1008ff55
const GDK_KEY_Close = &h1008ff56
const GDK_KEY_Copy = &h1008ff57
const GDK_KEY_Cut = &h1008ff58
const GDK_KEY_Display = &h1008ff59
const GDK_KEY_DOS = &h1008ff5a
const GDK_KEY_Documents = &h1008ff5b
const GDK_KEY_Excel = &h1008ff5c
const GDK_KEY_Explorer = &h1008ff5d
const GDK_KEY_Game = &h1008ff5e
const GDK_KEY_Go = &h1008ff5f
const GDK_KEY_iTouch = &h1008ff60
const GDK_KEY_LogOff = &h1008ff61
const GDK_KEY_Market = &h1008ff62
const GDK_KEY_Meeting = &h1008ff63
const GDK_KEY_MenuKB = &h1008ff65
const GDK_KEY_MenuPB = &h1008ff66
const GDK_KEY_MySites = &h1008ff67
const GDK_KEY_New = &h1008ff68
const GDK_KEY_News = &h1008ff69
const GDK_KEY_OfficeHome = &h1008ff6a
const GDK_KEY_Open = &h1008ff6b
const GDK_KEY_Option = &h1008ff6c
const GDK_KEY_Paste = &h1008ff6d
const GDK_KEY_Phone = &h1008ff6e
const GDK_KEY_Reply = &h1008ff72
const GDK_KEY_Reload = &h1008ff73
const GDK_KEY_RotateWindows = &h1008ff74
const GDK_KEY_RotationPB = &h1008ff75
const GDK_KEY_RotationKB = &h1008ff76
const GDK_KEY_Save = &h1008ff77
const GDK_KEY_ScrollUp = &h1008ff78
const GDK_KEY_ScrollDown = &h1008ff79
const GDK_KEY_ScrollClick = &h1008ff7a
const GDK_KEY_Send = &h1008ff7b
const GDK_KEY_Spell = &h1008ff7c
const GDK_KEY_SplitScreen = &h1008ff7d
const GDK_KEY_Support = &h1008ff7e
const GDK_KEY_TaskPane = &h1008ff7f
const GDK_KEY_Terminal = &h1008ff80
const GDK_KEY_Tools = &h1008ff81
const GDK_KEY_Travel = &h1008ff82
const GDK_KEY_UserPB = &h1008ff84
const GDK_KEY_User1KB = &h1008ff85
const GDK_KEY_User2KB = &h1008ff86
const GDK_KEY_Video = &h1008ff87
const GDK_KEY_WheelButton = &h1008ff88
const GDK_KEY_Word = &h1008ff89
const GDK_KEY_Xfer = &h1008ff8a
const GDK_KEY_ZoomIn = &h1008ff8b
const GDK_KEY_ZoomOut = &h1008ff8c
const GDK_KEY_Away = &h1008ff8d
const GDK_KEY_Messenger = &h1008ff8e
const GDK_KEY_WebCam = &h1008ff8f
const GDK_KEY_MailForward = &h1008ff90
const GDK_KEY_Pictures = &h1008ff91
const GDK_KEY_Music = &h1008ff92
const GDK_KEY_Battery = &h1008ff93
const GDK_KEY_Bluetooth = &h1008ff94
const GDK_KEY_WLAN = &h1008ff95
const GDK_KEY_UWB = &h1008ff96
const GDK_KEY_AudioForward = &h1008ff97
const GDK_KEY_AudioRepeat = &h1008ff98
const GDK_KEY_AudioRandomPlay = &h1008ff99
const GDK_KEY_Subtitle = &h1008ff9a
const GDK_KEY_AudioCycleTrack = &h1008ff9b
const GDK_KEY_CycleAngle = &h1008ff9c
const GDK_KEY_FrameBack = &h1008ff9d
const GDK_KEY_FrameForward = &h1008ff9e
const GDK_KEY_Time = &h1008ff9f
const GDK_KEY_SelectButton = &h1008ffa0
const GDK_KEY_View = &h1008ffa1
const GDK_KEY_TopMenu = &h1008ffa2
const GDK_KEY_Red = &h1008ffa3
const GDK_KEY_Green = &h1008ffa4
const GDK_KEY_Yellow = &h1008ffa5
const GDK_KEY_Blue = &h1008ffa6
const GDK_KEY_Suspend = &h1008ffa7
const GDK_KEY_Hibernate = &h1008ffa8
const GDK_KEY_TouchpadToggle = &h1008ffa9
const GDK_KEY_TouchpadOn = &h1008ffb0
const GDK_KEY_TouchpadOff = &h1008ffb1
const GDK_KEY_AudioMicMute = &h1008ffb2
const GDK_KEY_Switch_VT_1 = &h1008fe01
const GDK_KEY_Switch_VT_2 = &h1008fe02
const GDK_KEY_Switch_VT_3 = &h1008fe03
const GDK_KEY_Switch_VT_4 = &h1008fe04
const GDK_KEY_Switch_VT_5 = &h1008fe05
const GDK_KEY_Switch_VT_6 = &h1008fe06
const GDK_KEY_Switch_VT_7 = &h1008fe07
const GDK_KEY_Switch_VT_8 = &h1008fe08
const GDK_KEY_Switch_VT_9 = &h1008fe09
const GDK_KEY_Switch_VT_10 = &h1008fe0a
const GDK_KEY_Switch_VT_11 = &h1008fe0b
const GDK_KEY_Switch_VT_12 = &h1008fe0c
const GDK_KEY_Ungrab = &h1008fe20
const GDK_KEY_ClearGrab = &h1008fe21
const GDK_KEY_Next_VMode = &h1008fe22
const GDK_KEY_Prev_VMode = &h1008fe23
const GDK_KEY_LogWindowTree = &h1008fe24
const GDK_KEY_LogGrabInfo = &h1008fe25
#define __GDK_MAIN_H__
const GDK_PRIORITY_EVENTS = G_PRIORITY_DEFAULT

declare sub gdk_parse_args(byval argc as gint ptr, byval argv as gchar ptr ptr ptr)
declare sub gdk_init(byval argc as gint ptr, byval argv as gchar ptr ptr ptr)
declare function gdk_init_check(byval argc as gint ptr, byval argv as gchar ptr ptr ptr) as gboolean
declare sub gdk_add_option_entries_libgtk_only(byval group as GOptionGroup ptr)
declare sub gdk_pre_parse_libgtk_only()
declare function gdk_get_program_class() as const gchar ptr
declare sub gdk_set_program_class(byval program_class as const gchar ptr)
declare sub gdk_notify_startup_complete()
declare sub gdk_notify_startup_complete_with_id(byval startup_id as const gchar ptr)
declare sub gdk_error_trap_push()
declare function gdk_error_trap_pop() as gint
declare sub gdk_error_trap_pop_ignored()
declare function gdk_get_display_arg_name() as const gchar ptr
declare function gdk_get_display() as gchar ptr
declare function gdk_pointer_grab(byval window as GdkWindow ptr, byval owner_events as gboolean, byval event_mask as GdkEventMask, byval confine_to as GdkWindow ptr, byval cursor as GdkCursor ptr, byval time_ as guint32) as GdkGrabStatus
declare function gdk_keyboard_grab(byval window as GdkWindow ptr, byval owner_events as gboolean, byval time_ as guint32) as GdkGrabStatus
declare sub gdk_pointer_ungrab(byval time_ as guint32)
declare sub gdk_keyboard_ungrab(byval time_ as guint32)
declare function gdk_pointer_is_grabbed() as gboolean
declare function gdk_screen_width() as gint
declare function gdk_screen_height() as gint
declare function gdk_screen_width_mm() as gint
declare function gdk_screen_height_mm() as gint
declare sub gdk_set_double_click_time(byval msec as guint)
declare sub gdk_beep()
declare sub gdk_flush()
declare sub gdk_disable_multidevice()
declare sub gdk_set_allowed_backends(byval backends as const gchar ptr)
#define __GDK_PANGO_H__
declare function gdk_pango_context_get_for_screen(byval screen as GdkScreen ptr) as PangoContext ptr
declare function gdk_pango_context_get() as PangoContext ptr
declare function gdk_pango_layout_line_get_clip_region(byval line as PangoLayoutLine ptr, byval x_origin as gint, byval y_origin as gint, byval index_ranges as const gint ptr, byval n_ranges as gint) as cairo_region_t ptr
declare function gdk_pango_layout_get_clip_region(byval layout as PangoLayout ptr, byval x_origin as gint, byval y_origin as gint, byval index_ranges as const gint ptr, byval n_ranges as gint) as cairo_region_t ptr
#define __GDK_PROPERTY_H__

type GdkPropMode as long
enum
	GDK_PROP_MODE_REPLACE
	GDK_PROP_MODE_PREPEND
	GDK_PROP_MODE_APPEND
end enum

declare function gdk_atom_intern(byval atom_name as const gchar ptr, byval only_if_exists as gboolean) as GdkAtom
declare function gdk_atom_intern_static_string(byval atom_name as const gchar ptr) as GdkAtom
declare function gdk_atom_name(byval atom as GdkAtom) as gchar ptr
declare function gdk_property_get(byval window as GdkWindow ptr, byval property as GdkAtom, byval type as GdkAtom, byval offset as gulong, byval length as gulong, byval pdelete as gint, byval actual_property_type as GdkAtom ptr, byval actual_format as gint ptr, byval actual_length as gint ptr, byval data as guchar ptr ptr) as gboolean
declare sub gdk_property_change(byval window as GdkWindow ptr, byval property as GdkAtom, byval type as GdkAtom, byval format as gint, byval mode as GdkPropMode, byval data as const guchar ptr, byval nelements as gint)
declare sub gdk_property_delete(byval window as GdkWindow ptr, byval property as GdkAtom)
declare function gdk_text_property_to_utf8_list_for_display(byval display as GdkDisplay ptr, byval encoding as GdkAtom, byval format as gint, byval text as const guchar ptr, byval length as gint, byval list as gchar ptr ptr ptr) as gint
declare function gdk_utf8_to_string_target(byval str as const gchar ptr) as gchar ptr
#define __GDK_RECTANGLE_H__
declare function gdk_rectangle_intersect(byval src1 as const GdkRectangle ptr, byval src2 as const GdkRectangle ptr, byval dest as GdkRectangle ptr) as gboolean
declare sub gdk_rectangle_union(byval src1 as const GdkRectangle ptr, byval src2 as const GdkRectangle ptr, byval dest as GdkRectangle ptr)
declare function gdk_rectangle_get_type() as GType

#define GDK_TYPE_RECTANGLE gdk_rectangle_get_type()
#define __GDK_SELECTION_H__
#define GDK_SELECTION_PRIMARY _GDK_MAKE_ATOM(1)
#define GDK_SELECTION_SECONDARY _GDK_MAKE_ATOM(2)
#define GDK_SELECTION_CLIPBOARD _GDK_MAKE_ATOM(69)
#define GDK_TARGET_BITMAP _GDK_MAKE_ATOM(5)
#define GDK_TARGET_COLORMAP _GDK_MAKE_ATOM(7)
#define GDK_TARGET_DRAWABLE _GDK_MAKE_ATOM(17)
#define GDK_TARGET_PIXMAP _GDK_MAKE_ATOM(20)
#define GDK_TARGET_STRING _GDK_MAKE_ATOM(31)
#define GDK_SELECTION_TYPE_ATOM _GDK_MAKE_ATOM(4)
#define GDK_SELECTION_TYPE_BITMAP _GDK_MAKE_ATOM(5)
#define GDK_SELECTION_TYPE_COLORMAP _GDK_MAKE_ATOM(7)
#define GDK_SELECTION_TYPE_DRAWABLE _GDK_MAKE_ATOM(17)
#define GDK_SELECTION_TYPE_INTEGER _GDK_MAKE_ATOM(19)
#define GDK_SELECTION_TYPE_PIXMAP _GDK_MAKE_ATOM(20)
#define GDK_SELECTION_TYPE_WINDOW _GDK_MAKE_ATOM(33)
#define GDK_SELECTION_TYPE_STRING _GDK_MAKE_ATOM(31)

declare function gdk_selection_owner_set(byval owner as GdkWindow ptr, byval selection as GdkAtom, byval time_ as guint32, byval send_event as gboolean) as gboolean
declare function gdk_selection_owner_get(byval selection as GdkAtom) as GdkWindow ptr
declare function gdk_selection_owner_set_for_display(byval display as GdkDisplay ptr, byval owner as GdkWindow ptr, byval selection as GdkAtom, byval time_ as guint32, byval send_event as gboolean) as gboolean
declare function gdk_selection_owner_get_for_display(byval display as GdkDisplay ptr, byval selection as GdkAtom) as GdkWindow ptr
declare sub gdk_selection_convert(byval requestor as GdkWindow ptr, byval selection as GdkAtom, byval target as GdkAtom, byval time_ as guint32)
declare function gdk_selection_property_get(byval requestor as GdkWindow ptr, byval data as guchar ptr ptr, byval prop_type as GdkAtom ptr, byval prop_format as gint ptr) as gint
declare sub gdk_selection_send_notify(byval requestor as GdkWindow ptr, byval selection as GdkAtom, byval target as GdkAtom, byval property as GdkAtom, byval time_ as guint32)
declare sub gdk_selection_send_notify_for_display(byval display as GdkDisplay ptr, byval requestor as GdkWindow ptr, byval selection as GdkAtom, byval target as GdkAtom, byval property as GdkAtom, byval time_ as guint32)
#define __GDK_TEST_UTILS_H__
#define __GDK_WINDOW_H__

type GdkGeometry as _GdkGeometry
type GdkWindowAttr as _GdkWindowAttr
type GdkWindowRedirect as _GdkWindowRedirect

type GdkWindowWindowClass as long
enum
	GDK_INPUT_OUTPUT
	GDK_INPUT_ONLY
end enum

type GdkWindowType as long
enum
	GDK_WINDOW_ROOT
	GDK_WINDOW_TOPLEVEL
	GDK_WINDOW_CHILD
	GDK_WINDOW_TEMP
	GDK_WINDOW_FOREIGN
	GDK_WINDOW_OFFSCREEN
	GDK_WINDOW_SUBSURFACE
end enum

type GdkWindowAttributesType as long
enum
	GDK_WA_TITLE = 1 shl 1
	GDK_WA_X = 1 shl 2
	GDK_WA_Y = 1 shl 3
	GDK_WA_CURSOR = 1 shl 4
	GDK_WA_VISUAL = 1 shl 5
	GDK_WA_WMCLASS = 1 shl 6
	GDK_WA_NOREDIR = 1 shl 7
	GDK_WA_TYPE_HINT = 1 shl 8
end enum

type GdkWindowHints as long
enum
	GDK_HINT_POS = 1 shl 0
	GDK_HINT_MIN_SIZE = 1 shl 1
	GDK_HINT_MAX_SIZE = 1 shl 2
	GDK_HINT_BASE_SIZE = 1 shl 3
	GDK_HINT_ASPECT = 1 shl 4
	GDK_HINT_RESIZE_INC = 1 shl 5
	GDK_HINT_WIN_GRAVITY = 1 shl 6
	GDK_HINT_USER_POS = 1 shl 7
	GDK_HINT_USER_SIZE = 1 shl 8
end enum

type GdkWindowTypeHint as long
enum
	GDK_WINDOW_TYPE_HINT_NORMAL
	GDK_WINDOW_TYPE_HINT_DIALOG
	GDK_WINDOW_TYPE_HINT_MENU
	GDK_WINDOW_TYPE_HINT_TOOLBAR
	GDK_WINDOW_TYPE_HINT_SPLASHSCREEN
	GDK_WINDOW_TYPE_HINT_UTILITY
	GDK_WINDOW_TYPE_HINT_DOCK
	GDK_WINDOW_TYPE_HINT_DESKTOP
	GDK_WINDOW_TYPE_HINT_DROPDOWN_MENU
	GDK_WINDOW_TYPE_HINT_POPUP_MENU
	GDK_WINDOW_TYPE_HINT_TOOLTIP
	GDK_WINDOW_TYPE_HINT_NOTIFICATION
	GDK_WINDOW_TYPE_HINT_COMBO
	GDK_WINDOW_TYPE_HINT_DND
end enum

type GdkWMDecoration as long
enum
	GDK_DECOR_ALL = 1 shl 0
	GDK_DECOR_BORDER = 1 shl 1
	GDK_DECOR_RESIZEH = 1 shl 2
	GDK_DECOR_TITLE = 1 shl 3
	GDK_DECOR_MENU = 1 shl 4
	GDK_DECOR_MINIMIZE = 1 shl 5
	GDK_DECOR_MAXIMIZE = 1 shl 6
end enum

type GdkWMFunction as long
enum
	GDK_FUNC_ALL = 1 shl 0
	GDK_FUNC_RESIZE = 1 shl 1
	GDK_FUNC_MOVE = 1 shl 2
	GDK_FUNC_MINIMIZE = 1 shl 3
	GDK_FUNC_MAXIMIZE = 1 shl 4
	GDK_FUNC_CLOSE = 1 shl 5
end enum

type GdkGravity as long
enum
	GDK_GRAVITY_NORTH_WEST = 1
	GDK_GRAVITY_NORTH
	GDK_GRAVITY_NORTH_EAST
	GDK_GRAVITY_WEST
	GDK_GRAVITY_CENTER
	GDK_GRAVITY_EAST
	GDK_GRAVITY_SOUTH_WEST
	GDK_GRAVITY_SOUTH
	GDK_GRAVITY_SOUTH_EAST
	GDK_GRAVITY_STATIC
end enum

type GdkWindowEdge as long
enum
	GDK_WINDOW_EDGE_NORTH_WEST
	GDK_WINDOW_EDGE_NORTH
	GDK_WINDOW_EDGE_NORTH_EAST
	GDK_WINDOW_EDGE_WEST
	GDK_WINDOW_EDGE_EAST
	GDK_WINDOW_EDGE_SOUTH_WEST
	GDK_WINDOW_EDGE_SOUTH
	GDK_WINDOW_EDGE_SOUTH_EAST
end enum

type GdkFullscreenMode as long
enum
	GDK_FULLSCREEN_ON_CURRENT_MONITOR
	GDK_FULLSCREEN_ON_ALL_MONITORS
end enum

type _GdkWindowAttr
	title as gchar ptr
	event_mask as gint
	x as gint
	y as gint
	width as gint
	height as gint
	wclass as GdkWindowWindowClass
	visual as GdkVisual ptr
	window_type as GdkWindowType
	cursor as GdkCursor ptr
	wmclass_name as gchar ptr
	wmclass_class as gchar ptr
	override_redirect as gboolean
	type_hint as GdkWindowTypeHint
end type

type _GdkGeometry
	min_width as gint
	min_height as gint
	max_width as gint
	max_height as gint
	base_width as gint
	base_height as gint
	width_inc as gint
	height_inc as gint
	min_aspect as gdouble
	max_aspect as gdouble
	win_gravity as GdkGravity
end type

type GdkWindowClass as _GdkWindowClass
#define GDK_TYPE_WINDOW gdk_window_get_type()
#define GDK_WINDOW(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_WINDOW, GdkWindow)
#define GDK_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_WINDOW, GdkWindowClass)
#define GDK_IS_WINDOW(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_WINDOW)
#define GDK_IS_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_WINDOW)
#define GDK_WINDOW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_WINDOW, GdkWindowClass)

type _GdkWindowClass
	parent_class as GObjectClass
	pick_embedded_child as function(byval window as GdkWindow ptr, byval x as gdouble, byval y as gdouble) as GdkWindow ptr
	to_embedder as sub(byval window as GdkWindow ptr, byval offscreen_x as gdouble, byval offscreen_y as gdouble, byval embedder_x as gdouble ptr, byval embedder_y as gdouble ptr)
	from_embedder as sub(byval window as GdkWindow ptr, byval embedder_x as gdouble, byval embedder_y as gdouble, byval offscreen_x as gdouble ptr, byval offscreen_y as gdouble ptr)
	create_surface as function(byval window as GdkWindow ptr, byval width as gint, byval height as gint) as cairo_surface_t ptr
	_gdk_reserved1 as sub()
	_gdk_reserved2 as sub()
	_gdk_reserved3 as sub()
	_gdk_reserved4 as sub()
	_gdk_reserved5 as sub()
	_gdk_reserved6 as sub()
	_gdk_reserved7 as sub()
	_gdk_reserved8 as sub()
end type

declare function gdk_window_get_type() as GType
declare function gdk_window_new(byval parent as GdkWindow ptr, byval attributes as GdkWindowAttr ptr, byval attributes_mask as gint) as GdkWindow ptr
declare sub gdk_window_destroy(byval window as GdkWindow ptr)
declare function gdk_window_get_window_type(byval window as GdkWindow ptr) as GdkWindowType
declare function gdk_window_is_destroyed(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_get_visual(byval window as GdkWindow ptr) as GdkVisual ptr
declare function gdk_window_get_screen(byval window as GdkWindow ptr) as GdkScreen ptr
declare function gdk_window_get_display(byval window as GdkWindow ptr) as GdkDisplay ptr
declare function gdk_window_at_pointer(byval win_x as gint ptr, byval win_y as gint ptr) as GdkWindow ptr
declare sub gdk_window_show(byval window as GdkWindow ptr)
declare sub gdk_window_hide(byval window as GdkWindow ptr)
declare sub gdk_window_withdraw(byval window as GdkWindow ptr)
declare sub gdk_window_show_unraised(byval window as GdkWindow ptr)
declare sub gdk_window_move(byval window as GdkWindow ptr, byval x as gint, byval y as gint)
declare sub gdk_window_resize(byval window as GdkWindow ptr, byval width as gint, byval height as gint)
declare sub gdk_window_move_resize(byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gdk_window_reparent(byval window as GdkWindow ptr, byval new_parent as GdkWindow ptr, byval x as gint, byval y as gint)
declare sub gdk_window_raise(byval window as GdkWindow ptr)
declare sub gdk_window_lower(byval window as GdkWindow ptr)
declare sub gdk_window_restack(byval window as GdkWindow ptr, byval sibling as GdkWindow ptr, byval above as gboolean)
declare sub gdk_window_focus(byval window as GdkWindow ptr, byval timestamp as guint32)
declare sub gdk_window_set_user_data(byval window as GdkWindow ptr, byval user_data as gpointer)
declare sub gdk_window_set_override_redirect(byval window as GdkWindow ptr, byval override_redirect as gboolean)
declare function gdk_window_get_accept_focus(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_set_accept_focus(byval window as GdkWindow ptr, byval accept_focus as gboolean)
declare function gdk_window_get_focus_on_map(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_set_focus_on_map(byval window as GdkWindow ptr, byval focus_on_map as gboolean)
declare sub gdk_window_add_filter(byval window as GdkWindow ptr, byval function as GdkFilterFunc, byval data as gpointer)
declare sub gdk_window_remove_filter(byval window as GdkWindow ptr, byval function as GdkFilterFunc, byval data as gpointer)
declare sub gdk_window_scroll(byval window as GdkWindow ptr, byval dx as gint, byval dy as gint)
declare sub gdk_window_move_region(byval window as GdkWindow ptr, byval region as const cairo_region_t ptr, byval dx as gint, byval dy as gint)
declare function gdk_window_ensure_native(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_shape_combine_region(byval window as GdkWindow ptr, byval shape_region as const cairo_region_t ptr, byval offset_x as gint, byval offset_y as gint)
declare sub gdk_window_set_child_shapes(byval window as GdkWindow ptr)
declare function gdk_window_get_composited(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_set_composited(byval window as GdkWindow ptr, byval composited as gboolean)
declare sub gdk_window_merge_child_shapes(byval window as GdkWindow ptr)
declare sub gdk_window_input_shape_combine_region(byval window as GdkWindow ptr, byval shape_region as const cairo_region_t ptr, byval offset_x as gint, byval offset_y as gint)
declare sub gdk_window_set_child_input_shapes(byval window as GdkWindow ptr)
declare sub gdk_window_merge_child_input_shapes(byval window as GdkWindow ptr)
declare function gdk_window_is_visible(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_is_viewable(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_is_input_only(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_is_shaped(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_get_state(byval window as GdkWindow ptr) as GdkWindowState
declare function gdk_window_set_static_gravities(byval window as GdkWindow ptr, byval use_static as gboolean) as gboolean
type GdkWindowInvalidateHandlerFunc as sub(byval window as GdkWindow ptr, byval region as cairo_region_t ptr)
declare sub gdk_window_set_invalidate_handler(byval window as GdkWindow ptr, byval handler as GdkWindowInvalidateHandlerFunc)
declare function gdk_window_has_native(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_set_type_hint(byval window as GdkWindow ptr, byval hint as GdkWindowTypeHint)
declare function gdk_window_get_type_hint(byval window as GdkWindow ptr) as GdkWindowTypeHint
declare function gdk_window_get_modal_hint(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_set_modal_hint(byval window as GdkWindow ptr, byval modal as gboolean)
declare sub gdk_window_set_skip_taskbar_hint(byval window as GdkWindow ptr, byval skips_taskbar as gboolean)
declare sub gdk_window_set_skip_pager_hint(byval window as GdkWindow ptr, byval skips_pager as gboolean)
declare sub gdk_window_set_urgency_hint(byval window as GdkWindow ptr, byval urgent as gboolean)
declare sub gdk_window_set_geometry_hints(byval window as GdkWindow ptr, byval geometry as const GdkGeometry ptr, byval geom_mask as GdkWindowHints)
declare function gdk_window_get_clip_region(byval window as GdkWindow ptr) as cairo_region_t ptr
declare function gdk_window_get_visible_region(byval window as GdkWindow ptr) as cairo_region_t ptr
declare sub gdk_window_begin_paint_rect(byval window as GdkWindow ptr, byval rectangle as const GdkRectangle ptr)
declare sub gdk_window_mark_paint_from_clip(byval window as GdkWindow ptr, byval cr as cairo_t ptr)
declare sub gdk_window_begin_paint_region(byval window as GdkWindow ptr, byval region as const cairo_region_t ptr)
declare sub gdk_window_end_paint(byval window as GdkWindow ptr)
declare sub gdk_window_flush(byval window as GdkWindow ptr)
declare sub gdk_window_set_title(byval window as GdkWindow ptr, byval title as const gchar ptr)
declare sub gdk_window_set_role(byval window as GdkWindow ptr, byval role as const gchar ptr)
declare sub gdk_window_set_startup_id(byval window as GdkWindow ptr, byval startup_id as const gchar ptr)
declare sub gdk_window_set_transient_for(byval window as GdkWindow ptr, byval parent as GdkWindow ptr)
declare sub gdk_window_set_background(byval window as GdkWindow ptr, byval color as const GdkColor ptr)
declare sub gdk_window_set_background_rgba(byval window as GdkWindow ptr, byval rgba_ as const GdkRGBA ptr)
declare sub gdk_window_set_background_pattern(byval window as GdkWindow ptr, byval pattern as cairo_pattern_t ptr)
declare function gdk_window_get_background_pattern(byval window as GdkWindow ptr) as cairo_pattern_t ptr
declare sub gdk_window_set_cursor(byval window as GdkWindow ptr, byval cursor as GdkCursor ptr)
declare function gdk_window_get_cursor(byval window as GdkWindow ptr) as GdkCursor ptr
declare sub gdk_window_set_device_cursor(byval window as GdkWindow ptr, byval device as GdkDevice ptr, byval cursor as GdkCursor ptr)
declare function gdk_window_get_device_cursor(byval window as GdkWindow ptr, byval device as GdkDevice ptr) as GdkCursor ptr
declare sub gdk_window_get_user_data(byval window as GdkWindow ptr, byval data as gpointer ptr)
declare sub gdk_window_get_geometry(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr, byval width as gint ptr, byval height as gint ptr)
declare function gdk_window_get_width(byval window as GdkWindow ptr) as long
declare function gdk_window_get_height(byval window as GdkWindow ptr) as long
declare sub gdk_window_get_position(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr)
declare function gdk_window_get_origin(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr) as gint
declare sub gdk_window_get_root_coords(byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval root_x as gint ptr, byval root_y as gint ptr)
declare sub gdk_window_coords_to_parent(byval window as GdkWindow ptr, byval x as gdouble, byval y as gdouble, byval parent_x as gdouble ptr, byval parent_y as gdouble ptr)
declare sub gdk_window_coords_from_parent(byval window as GdkWindow ptr, byval parent_x as gdouble, byval parent_y as gdouble, byval x as gdouble ptr, byval y as gdouble ptr)
declare sub gdk_window_get_root_origin(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr)
declare sub gdk_window_get_frame_extents(byval window as GdkWindow ptr, byval rect as GdkRectangle ptr)
declare function gdk_window_get_scale_factor(byval window as GdkWindow ptr) as gint
declare function gdk_window_get_pointer(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr, byval mask as GdkModifierType ptr) as GdkWindow ptr
declare function gdk_window_get_device_position(byval window as GdkWindow ptr, byval device as GdkDevice ptr, byval x as gint ptr, byval y as gint ptr, byval mask as GdkModifierType ptr) as GdkWindow ptr
declare function gdk_window_get_device_position_double(byval window as GdkWindow ptr, byval device as GdkDevice ptr, byval x as gdouble ptr, byval y as gdouble ptr, byval mask as GdkModifierType ptr) as GdkWindow ptr
declare function gdk_window_get_parent(byval window as GdkWindow ptr) as GdkWindow ptr
declare function gdk_window_get_toplevel(byval window as GdkWindow ptr) as GdkWindow ptr
declare function gdk_window_get_effective_parent(byval window as GdkWindow ptr) as GdkWindow ptr
declare function gdk_window_get_effective_toplevel(byval window as GdkWindow ptr) as GdkWindow ptr
declare function gdk_window_get_children(byval window as GdkWindow ptr) as GList ptr
declare function gdk_window_peek_children(byval window as GdkWindow ptr) as GList ptr
declare function gdk_window_get_children_with_user_data(byval window as GdkWindow ptr, byval user_data as gpointer) as GList ptr
declare function gdk_window_get_events(byval window as GdkWindow ptr) as GdkEventMask
declare sub gdk_window_set_events(byval window as GdkWindow ptr, byval event_mask as GdkEventMask)
declare sub gdk_window_set_device_events(byval window as GdkWindow ptr, byval device as GdkDevice ptr, byval event_mask as GdkEventMask)
declare function gdk_window_get_device_events(byval window as GdkWindow ptr, byval device as GdkDevice ptr) as GdkEventMask
declare sub gdk_window_set_source_events(byval window as GdkWindow ptr, byval source as GdkInputSource, byval event_mask as GdkEventMask)
declare function gdk_window_get_source_events(byval window as GdkWindow ptr, byval source as GdkInputSource) as GdkEventMask
declare sub gdk_window_set_icon_list(byval window as GdkWindow ptr, byval pixbufs as GList ptr)
declare sub gdk_window_set_icon_name(byval window as GdkWindow ptr, byval name as const gchar ptr)
declare sub gdk_window_set_group(byval window as GdkWindow ptr, byval leader as GdkWindow ptr)
declare function gdk_window_get_group(byval window as GdkWindow ptr) as GdkWindow ptr
declare sub gdk_window_set_decorations(byval window as GdkWindow ptr, byval decorations as GdkWMDecoration)
declare function gdk_window_get_decorations(byval window as GdkWindow ptr, byval decorations as GdkWMDecoration ptr) as gboolean
declare sub gdk_window_set_functions(byval window as GdkWindow ptr, byval functions as GdkWMFunction)
declare function gdk_window_create_similar_surface(byval window as GdkWindow ptr, byval content as cairo_content_t, byval width as long, byval height as long) as cairo_surface_t ptr
declare function gdk_window_create_similar_image_surface(byval window as GdkWindow ptr, byval format as cairo_format_t, byval width as long, byval height as long, byval scale as long) as cairo_surface_t ptr
declare sub gdk_window_beep(byval window as GdkWindow ptr)
declare sub gdk_window_iconify(byval window as GdkWindow ptr)
declare sub gdk_window_deiconify(byval window as GdkWindow ptr)
declare sub gdk_window_stick(byval window as GdkWindow ptr)
declare sub gdk_window_unstick(byval window as GdkWindow ptr)
declare sub gdk_window_maximize(byval window as GdkWindow ptr)
declare sub gdk_window_unmaximize(byval window as GdkWindow ptr)
declare sub gdk_window_fullscreen(byval window as GdkWindow ptr)
declare sub gdk_window_set_fullscreen_mode(byval window as GdkWindow ptr, byval mode as GdkFullscreenMode)
declare function gdk_window_get_fullscreen_mode(byval window as GdkWindow ptr) as GdkFullscreenMode
declare sub gdk_window_unfullscreen(byval window as GdkWindow ptr)
declare sub gdk_window_set_keep_above(byval window as GdkWindow ptr, byval setting as gboolean)
declare sub gdk_window_set_keep_below(byval window as GdkWindow ptr, byval setting as gboolean)
declare sub gdk_window_set_opacity(byval window as GdkWindow ptr, byval opacity as gdouble)
declare sub gdk_window_register_dnd(byval window as GdkWindow ptr)
declare function gdk_window_get_drag_protocol(byval window as GdkWindow ptr, byval target as GdkWindow ptr ptr) as GdkDragProtocol
declare sub gdk_window_begin_resize_drag(byval window as GdkWindow ptr, byval edge as GdkWindowEdge, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gdk_window_begin_resize_drag_for_device(byval window as GdkWindow ptr, byval edge as GdkWindowEdge, byval device as GdkDevice ptr, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gdk_window_begin_move_drag(byval window as GdkWindow ptr, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gdk_window_begin_move_drag_for_device(byval window as GdkWindow ptr, byval device as GdkDevice ptr, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gdk_window_invalidate_rect(byval window as GdkWindow ptr, byval rect as const GdkRectangle ptr, byval invalidate_children as gboolean)
declare sub gdk_window_invalidate_region(byval window as GdkWindow ptr, byval region as const cairo_region_t ptr, byval invalidate_children as gboolean)
type GdkWindowChildFunc as function(byval window as GdkWindow ptr, byval user_data as gpointer) as gboolean
declare sub gdk_window_invalidate_maybe_recurse(byval window as GdkWindow ptr, byval region as const cairo_region_t ptr, byval child_func as GdkWindowChildFunc, byval user_data as gpointer)
declare function gdk_window_get_update_area(byval window as GdkWindow ptr) as cairo_region_t ptr
declare sub gdk_window_freeze_updates(byval window as GdkWindow ptr)
declare sub gdk_window_thaw_updates(byval window as GdkWindow ptr)
declare sub gdk_window_freeze_toplevel_updates_libgtk_only(byval window as GdkWindow ptr)
declare sub gdk_window_thaw_toplevel_updates_libgtk_only(byval window as GdkWindow ptr)
declare sub gdk_window_process_all_updates()
declare sub gdk_window_process_updates(byval window as GdkWindow ptr, byval update_children as gboolean)
declare sub gdk_window_set_debug_updates(byval setting as gboolean)
declare sub gdk_window_constrain_size(byval geometry as GdkGeometry ptr, byval flags as GdkWindowHints, byval width as gint, byval height as gint, byval new_width as gint ptr, byval new_height as gint ptr)
declare sub gdk_window_enable_synchronized_configure(byval window as GdkWindow ptr)
declare sub gdk_window_configure_finished(byval window as GdkWindow ptr)
declare function gdk_get_default_root_window() as GdkWindow ptr
declare function gdk_offscreen_window_get_surface(byval window as GdkWindow ptr) as cairo_surface_t ptr
declare sub gdk_offscreen_window_set_embedder(byval window as GdkWindow ptr, byval embedder as GdkWindow ptr)
declare function gdk_offscreen_window_get_embedder(byval window as GdkWindow ptr) as GdkWindow ptr
declare sub gdk_window_geometry_changed(byval window as GdkWindow ptr)
declare sub gdk_window_set_support_multidevice(byval window as GdkWindow ptr, byval support_multidevice as gboolean)
declare function gdk_window_get_support_multidevice(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_get_frame_clock(byval window as GdkWindow ptr) as GdkFrameClock ptr
declare sub gdk_window_set_opaque_region(byval window as GdkWindow ptr, byval region as cairo_region_t ptr)
declare sub gdk_window_set_event_compression(byval window as GdkWindow ptr, byval event_compression as gboolean)
declare function gdk_window_get_event_compression(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_set_shadow_width(byval window as GdkWindow ptr, byval left as gint, byval right as gint, byval top as gint, byval bottom as gint)
declare function gdk_window_show_window_menu(byval window as GdkWindow ptr, byval event as GdkEvent ptr) as gboolean
declare function gdk_window_create_gl_context(byval window as GdkWindow ptr, byval error as GError ptr ptr) as GdkGLContext ptr
declare sub gdk_test_render_sync(byval window as GdkWindow ptr)
declare function gdk_test_simulate_key(byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval keyval as guint, byval modifiers as GdkModifierType, byval key_pressrelease as GdkEventType) as gboolean
declare function gdk_test_simulate_button(byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval button as guint, byval modifiers as GdkModifierType, byval button_pressrelease as GdkEventType) as gboolean
#define __GDK_THREADS_H__
declare sub gdk_threads_init()
declare sub gdk_threads_enter()
declare sub gdk_threads_leave()
declare sub gdk_threads_set_lock_functions(byval enter_fn as GCallback, byval leave_fn as GCallback)
declare function gdk_threads_add_idle_full(byval priority as gint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function gdk_threads_add_idle(byval function as GSourceFunc, byval data as gpointer) as guint
declare function gdk_threads_add_timeout_full(byval priority as gint, byval interval as guint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function gdk_threads_add_timeout(byval interval as guint, byval function as GSourceFunc, byval data as gpointer) as guint
declare function gdk_threads_add_timeout_seconds_full(byval priority as gint, byval interval as guint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function gdk_threads_add_timeout_seconds(byval interval as guint, byval function as GSourceFunc, byval data as gpointer) as guint

#define __GDK_VISUAL_H__
#define GDK_TYPE_VISUAL gdk_visual_get_type()
#define GDK_VISUAL(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_VISUAL, GdkVisual)
#define GDK_IS_VISUAL(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_VISUAL)

type GdkVisualType as long
enum
	GDK_VISUAL_STATIC_GRAY
	GDK_VISUAL_GRAYSCALE
	GDK_VISUAL_STATIC_COLOR
	GDK_VISUAL_PSEUDO_COLOR
	GDK_VISUAL_TRUE_COLOR
	GDK_VISUAL_DIRECT_COLOR
end enum

declare function gdk_visual_get_type() as GType
declare function gdk_visual_get_best_depth() as gint
declare function gdk_visual_get_best_type() as GdkVisualType
declare function gdk_visual_get_system() as GdkVisual ptr
declare function gdk_visual_get_best() as GdkVisual ptr
declare function gdk_visual_get_best_with_depth(byval depth as gint) as GdkVisual ptr
declare function gdk_visual_get_best_with_type(byval visual_type as GdkVisualType) as GdkVisual ptr
declare function gdk_visual_get_best_with_both(byval depth as gint, byval visual_type as GdkVisualType) as GdkVisual ptr
declare sub gdk_query_depths(byval depths as gint ptr ptr, byval count as gint ptr)
declare sub gdk_query_visual_types(byval visual_types as GdkVisualType ptr ptr, byval count as gint ptr)
declare function gdk_list_visuals() as GList ptr
declare function gdk_visual_get_screen(byval visual as GdkVisual ptr) as GdkScreen ptr
declare function gdk_visual_get_visual_type(byval visual as GdkVisual ptr) as GdkVisualType
declare function gdk_visual_get_depth(byval visual as GdkVisual ptr) as gint
declare function gdk_visual_get_byte_order(byval visual as GdkVisual ptr) as GdkByteOrder
declare function gdk_visual_get_colormap_size(byval visual as GdkVisual ptr) as gint
declare function gdk_visual_get_bits_per_rgb(byval visual as GdkVisual ptr) as gint
declare sub gdk_visual_get_red_pixel_details(byval visual as GdkVisual ptr, byval mask as guint32 ptr, byval shift as gint ptr, byval precision as gint ptr)
declare sub gdk_visual_get_green_pixel_details(byval visual as GdkVisual ptr, byval mask as guint32 ptr, byval shift as gint ptr, byval precision as gint ptr)
declare sub gdk_visual_get_blue_pixel_details(byval visual as GdkVisual ptr, byval mask as guint32 ptr, byval shift as gint ptr, byval precision as gint ptr)
type GdkAppLaunchContext_autoptr as GdkAppLaunchContext ptr

private sub glib_autoptr_cleanup_GdkAppLaunchContext(byval _ptr as GdkAppLaunchContext ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkCursor_autoptr as GdkCursor ptr

private sub glib_autoptr_cleanup_GdkCursor(byval _ptr as GdkCursor ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkDevice_autoptr as GdkDevice ptr

private sub glib_autoptr_cleanup_GdkDevice(byval _ptr as GdkDevice ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkDeviceManager_autoptr as GdkDeviceManager ptr

private sub glib_autoptr_cleanup_GdkDeviceManager(byval _ptr as GdkDeviceManager ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkDisplay_autoptr as GdkDisplay ptr

private sub glib_autoptr_cleanup_GdkDisplay(byval _ptr as GdkDisplay ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkDisplayManager_autoptr as GdkDisplayManager ptr

private sub glib_autoptr_cleanup_GdkDisplayManager(byval _ptr as GdkDisplayManager ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkDragContext_autoptr as GdkDragContext ptr

private sub glib_autoptr_cleanup_GdkDragContext(byval _ptr as GdkDragContext ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkFrameClock_autoptr as GdkFrameClock ptr

private sub glib_autoptr_cleanup_GdkFrameClock(byval _ptr as GdkFrameClock ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkGLContext_autoptr as GdkGLContext ptr

private sub glib_autoptr_cleanup_GdkGLContext(byval _ptr as GdkGLContext ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkKeymap_autoptr as GdkKeymap ptr

private sub glib_autoptr_cleanup_GdkKeymap(byval _ptr as GdkKeymap ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkScreen_autoptr as GdkScreen ptr

private sub glib_autoptr_cleanup_GdkScreen(byval _ptr as GdkScreen ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkVisual_autoptr as GdkVisual ptr

private sub glib_autoptr_cleanup_GdkVisual(byval _ptr as GdkVisual ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkWindow_autoptr as GdkWindow ptr

private sub glib_autoptr_cleanup_GdkWindow(byval _ptr as GdkWindow ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GdkEvent_autoptr as GdkEvent ptr

private sub glib_autoptr_cleanup_GdkEvent(byval _ptr as GdkEvent ptr ptr)
	if *_ptr then
		gdk_event_free(*_ptr)
	end if
end sub

type GdkFrameTimings_autoptr as GdkFrameTimings ptr

private sub glib_autoptr_cleanup_GdkFrameTimings(byval _ptr as GdkFrameTimings ptr ptr)
	if *_ptr then
		gdk_frame_timings_unref(*_ptr)
	end if
end sub

type GdkRGBA_autoptr as GdkRGBA ptr

private sub glib_autoptr_cleanup_GdkRGBA(byval _ptr as GdkRGBA ptr ptr)
	if *_ptr then
		gdk_rgba_free(*_ptr)
	end if
end sub

#undef __GDK_H_INSIDE__

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
