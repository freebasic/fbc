''
''
'' cst_ffeatures -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_ffeatures_bi__
#define __cst_ffeatures_bi__

declare function ph_vc cdecl alias "ph_vc" (byval p as cst_item ptr) as cst_val ptr
declare function ph_vlng cdecl alias "ph_vlng" (byval p as cst_item ptr) as cst_val ptr
declare function ph_vheight cdecl alias "ph_vheight" (byval p as cst_item ptr) as cst_val ptr
declare function ph_vrnd cdecl alias "ph_vrnd" (byval p as cst_item ptr) as cst_val ptr
declare function ph_vfront cdecl alias "ph_vfront" (byval p as cst_item ptr) as cst_val ptr
declare function ph_ctype cdecl alias "ph_ctype" (byval p as cst_item ptr) as cst_val ptr
declare function ph_cplace cdecl alias "ph_cplace" (byval p as cst_item ptr) as cst_val ptr
declare function ph_cvox cdecl alias "ph_cvox" (byval p as cst_item ptr) as cst_val ptr
declare function cg_duration cdecl alias "cg_duration" (byval p as cst_item ptr) as cst_val ptr
declare function cg_state_pos cdecl alias "cg_state_pos" (byval p as cst_item ptr) as cst_val ptr
declare function cg_state_place cdecl alias "cg_state_place" (byval p as cst_item ptr) as cst_val ptr
declare function cg_state_index cdecl alias "cg_state_index" (byval p as cst_item ptr) as cst_val ptr
declare function cg_state_rindex cdecl alias "cg_state_rindex" (byval p as cst_item ptr) as cst_val ptr
declare function cg_phone_place cdecl alias "cg_phone_place" (byval p as cst_item ptr) as cst_val ptr
declare function cg_phone_index cdecl alias "cg_phone_index" (byval p as cst_item ptr) as cst_val ptr
declare function cg_phone_rindex cdecl alias "cg_phone_rindex" (byval p as cst_item ptr) as cst_val ptr
declare sub basic_ff_register cdecl alias "basic_ff_register" (byval ffunctions as cst_features ptr)

#endif
