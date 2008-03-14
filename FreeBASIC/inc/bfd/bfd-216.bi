''
''
'' bfd -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bfd_ver_bi__
#define __bfd_ver_bi__

#inclib "bfd"
#inclib "iberty"

#ifndef __FB_LINUX__
#inclib "intl"
#endif

#define BFD_ARCH_SIZE 32
#define BFD_DEFAULT_TARGET_SIZE 32

type bfd_int64_t as longint
type bfd_uint64_t as ulongint
type bfd as bfd_
type bfd_boolean as integer

#ifndef FALSE
#define FALSE 0
#define TRUE 1
#endif

#ifndef stat
type stat as _stat
#endif

type bfd_vma as unsigned long
type bfd_signed_vma as integer
type symvalue as unsigned long
type bfd_size_type as unsigned long
type flagword as uinteger
type bfd_byte as ubyte

type file_ptr as long
type ufile_ptr as unsigned long

type ecoff_debug_info as ecoff_debug_info_
type ecoff_debug_swap as ecoff_debug_swap_
type ecoff_extr as ecoff_extr_
type bfd_symbol as bfd_symbol_
type bfd_link_info as bfd_link_info_
type bfd_link_hash_entry as bfd_link_hash_entry_
type bfd_elf_version_tree as bfd_elf_version_tree_
type internal_syment as internal_syment_
type internal_auxent as internal_auxent_
type bfd_strtab_hash as bfd_strtab_hash_
type bfd_section as bfd_section_
type bfd_window_internal as bfd_window_internal_
type bfd_link_order as bfd_link_order_
type reloc_cache_entry as reloc_cache_entry_
type relent_chain as relent_chain_
type bfd_target as bfd_target_
type bfd_iovec as bfd_iovec_
type bfd_link_hash_table as bfd_link_hash_table_

#define HALF_BFD_SIZE_TYPE (((bfd_size_type) 1) shl (8 * sizeof(bfd_size_type) \ 2))

enum bfd_format
	bfd_unknown = 0
	bfd_object
	bfd_archive
	bfd_core
	bfd_type_end
end enum

#define BFD_NO_FLAGS &h00
#define HAS_RELOC &h01
#define EXEC_P &h02
#define HAS_LINENO &h04
#define HAS_DEBUG &h08
#define HAS_SYMS &h10
#define HAS_LOCALS &h20
#define DYNAMIC_ &h40
#define WP_TEXT &h80
#define D_PAGED &h100
#define BFD_IS_RELAXABLE &h200
#define BFD_TRADITIONAL_FORMAT &h400
#define BFD_IN_MEMORY &h800
#define HAS_LOAD_PAGE &h1000
#define BFD_LINKER_CREATED &h2000

type symindex as uinteger
type reloc_howto_type as reloc_howto_struct

#define BFD_NO_MORE_SYMBOLS cast(symindex, not 0)
#define bfd_get_section(x) ((x)->section)
#define bfd_get_output_section(x) ((x)->section->output_section)
#define bfd_set_section(x,y) (x)->section = (y)
#define bfd_asymbol_base(x) ((x)->section->vma)
#define bfd_asymbol_value(x) (bfd_asymbol_base(x) + (x)->value)
#define bfd_asymbol_name(x) ((x)->name)
#define bfd_asymbol_bfd(x) ((x)->the_bfd)
#define bfd_asymbol_flavour(x) (bfd_asymbol_bfd(x)->xvec->flavour)

type carsym
	name as zstring ptr
	file_offset as file_ptr
end type

union orl__u
	pos as file_ptr
	abfd as bfd ptr
end union

type orl
	name as byte ptr ptr
	u as orl__u
	namidx as integer
end type

union alent__u
	sym as bfd_symbol ptr
	offset as bfd_vma
end union

type lineno_cache_entry
	line_number as uinteger
	u as alent__u
end type

type alent as lineno_cache_entry

type sec_ptr as bfd_section ptr
type stat_type as _stat

enum bfd_print_symbol
	bfd_print_symbol_name
	bfd_print_symbol_more
	bfd_print_symbol_all
end enum

type bfd_print_symbol_type as bfd_print_symbol

type symbol_info
	value as symvalue
	type as byte
	name as zstring ptr
	stab_type as ubyte
	stab_other as byte
	stab_desc as short
	stab_name as zstring ptr
end type

type bfd_hash_entry
	next as bfd_hash_entry ptr
	string as zstring ptr
	hash as uinteger
end type

type bfd_hash_table
	table as bfd_hash_entry ptr ptr
	size as uinteger
	newfunc as function cdecl(byval as bfd_hash_entry ptr, byval as bfd_hash_table ptr, byval as zstring ptr) as bfd_hash_entry ptr
	memory as any ptr
end type

#define bfd_get_section_name(bfd, ptr_) ((ptr_)->name + 0)
#define bfd_get_section_vma(bfd, ptr_) ((ptr_)->vma + 0)
#define bfd_get_section_lma(bfd, ptr_) ((ptr_)->lma + 0)
#define bfd_get_section_alignment(bfd, ptr_) ((ptr_)->alignment_power + 0)
#define bfd_section_name(bfd, ptr_) (ptr_)->name
#define bfd_section_size(bfd, ptr_) ((ptr_)->size
#define bfd_get_section_size(ptr_) (ptr_)->size
#define bfd_section_vma(bfd, ptr_) (ptr_)->vma
#define bfd_section_lma(bfd, ptr_) (ptr_)->lma
#define bfd_section_alignment(bfd, ptr_) (ptr_)->alignment_power
#define bfd_get_section_flags(bfd, ptr_) ((ptr_)->flags + 0)
#define bfd_get_section_userdata(bfd, ptr_) ((ptr_)->userdata)
#define bfd_is_com_section(ptr_) (((ptr_)->flags and SEC_IS_COMMON) <> 0)
#define bfd_set_section_vma(bfd, ptr_, val) (ptr_)->vma = (ptr_)->lma = (val)): (ptr_)->user_set_vma = TRUE
#define bfd_set_section_alignment(bfd, ptr_, val) (ptr_)->alignment_power = (val)
#define bfd_set_section_userdata(bfd, ptr_, val) (ptr_)->userdata = (val)
#define bfd_get_section_limit(bfd, sec) iif((sec)->rawsize, (sec)->rawsize, (sec)->size) \ bfd_octets_per_byte (bfd))

type stab_info
	strings as bfd_strtab_hash ptr
	includes as bfd_hash_table
	stabstr as bfd_section ptr
end type

#define bfd_get_filename(abfd) cast(zstring ptr, (abfd)->filename)
#define bfd_get_cacheable(abfd) (abfd)->cacheable
#define bfd_get_format(abfd) (abfd)->format
#define bfd_get_target(abfd) (abfd)->xvec->name
#define bfd_get_flavour(abfd) (abfd)->xvec->flavour
#define bfd_family_coff(abfd) (bfd_get_flavour(abfd) = bfd_target_coff_flavour or bfd_get_flavour(abfd) = bfd_target_xcoff_flavour)
#define bfd_big_endian(abfd) ((abfd)->xvec->byteorder = BFD_ENDIAN_BIG)
#define bfd_little_endian(abfd) ((abfd)->xvec->byteorder = BFD_ENDIAN_LITTLE)
#define bfd_header_big_endian(abfd) ((abfd)->xvec->header_byteorder = BFD_ENDIAN_BIG)
#define bfd_header_little_endian(abfd) ((abfd)->xvec->header_byteorder = BFD_ENDIAN_LITTLE)
#define bfd_get_file_flags(abfd) (abfd)->flags
#define bfd_applicable_file_flags(abfd) (abfd)->xvec->object_flags
#define bfd_applicable_section_flags(abfd) (abfd)->xvec->section_flags
#define bfd_my_archive(abfd) (abfd)->my_archive
#define bfd_has_map(abfd) (abfd)->has_armap
#define bfd_valid_reloc_types(abfd) (abfd)->xvec->valid_reloc_types
#define bfd_usrdata(abfd) (abfd)->usrdata
#define bfd_get_start_address(abfd) (abfd)->start_address
#define bfd_get_symcount(abfd) (abfd)->symcount
#define bfd_get_outsymbols(abfd) (abfd)->outsymbols
#define bfd_count_sections(abfd) (abfd)->section_count
#define bfd_get_dynamic_symcount(abfd) (abfd)->dynsymcount
#define bfd_get_symbol_leading_char(abfd) (abfd)->xvec->symbol_leading_char
#define bfd_set_cacheable(abfd,bool) (abfd)->cacheable = bool

type bfd_link_needed_list
	next as bfd_link_needed_list ptr
	by as bfd ptr
	name as zstring ptr
end type

enum dynamic_lib_link_class
	DYN_NORMAL = 0
	DYN_AS_NEEDED = 1
	DYN_DT_NEEDED = 2
	DYN_NO_ADD_NEEDED = 4
	DYN_NO_NEEDED = 8
end enum

type bfd_window
	data as any ptr
	size as bfd_size_type
	i as bfd_window_internal ptr
end type

type coff_comdat_info
	name as zstring ptr
	symbol as integer
end type

union asection_map
	link_order as bfd_link_order ptr
	s as bfd_section ptr
end union


type bfd_section_
	name as zstring ptr
	id as integer
	index as integer
	next as bfd_section ptr
	flags as flagword
	user_set_vma:1 as uinteger
	linker_mark:1 as uinteger
	linker_has_input:1 as uinteger
	gc_mark:1 as uinteger
	segment_mark:1 as uinteger
	sec_info_type:3 as uinteger
	use_rela_p:1 as uinteger
	has_tls_reloc:1 as uinteger
	has_gp_reloc:1 as uinteger
	need_finalize_relax:1 as uinteger
	reloc_done:1 as uinteger
	vma as bfd_vma
	lma as bfd_vma
	size as bfd_size_type
	rawsize as bfd_size_type
	output_offset as bfd_vma
	output_section as bfd_section ptr
	alignment_power as uinteger
	relocation as reloc_cache_entry ptr
	orelocation as reloc_cache_entry ptr ptr
	reloc_count as uinteger
	filepos as file_ptr
	rel_filepos as file_ptr
	line_filepos as file_ptr
	userdata as any ptr
	contents as ubyte ptr
	lineno as alent ptr
	lineno_count as uinteger
	entsize as uinteger
	kept_section as bfd_section ptr
	moving_line_filepos as file_ptr
	target_index as integer
	used_by_bfd as any ptr
	constructor_chain as relent_chain ptr
	owner as bfd ptr
	symbol as bfd_symbol ptr
	symbol_ptr_ptr as bfd_symbol ptr ptr
	link_order_head as bfd_link_order ptr
	link_order_tail as bfd_link_order ptr
end type

#define SEC_NO_FLAGS &h000
#define SEC_ALLOC &h001
#define SEC_LOAD &h002
#define SEC_RELOC &h004
#define SEC_READONLY &h008
#define SEC_CODE &h010
#define SEC_DATA &h020
#define SEC_ROM &h040
#define SEC_CONSTRUCTOR &h080
#define SEC_HAS_CONTENTS &h100
#define SEC_NEVER_LOAD &h200
#define SEC_THREAD_LOCAL &h400
#define SEC_HAS_GOT_REF &h800
#define SEC_IS_COMMON &h1000
#define SEC_DEBUGGING &h2000
#define SEC_IN_MEMORY &h4000
#define SEC_EXCLUDE &h8000
#define SEC_SORT_ENTRIES &h10000
#define SEC_LINK_ONCE &h20000
#define SEC_LINK_DUPLICATES &h40000
#define SEC_LINK_DUPLICATES_DISCARD &h0
#define SEC_LINK_DUPLICATES_ONE_ONLY &h80000
#define SEC_LINK_DUPLICATES_SAME_SIZE &h100000
#define SEC_LINK_DUPLICATES_SAME_CONTENTS (&h80000 or &h100000)
#define SEC_LINKER_CREATED &h200000
#define SEC_KEEP &h400000
#define SEC_SMALL_DATA &h800000
#define SEC_MERGE &h1000000
#define SEC_STRINGS &h2000000
#define SEC_GROUP &h4000000
#define SEC_COFF_SHARED_LIBRARY &h10000000
#define SEC_COFF_SHARED &h20000000
#define SEC_TIC54X_BLOCK &h40000000
#define SEC_TIC54X_CLINK &h80000000
#define ELF_INFO_TYPE_NONE 0
#define ELF_INFO_TYPE_STABS 1
#define ELF_INFO_TYPE_MERGE 2
#define ELF_INFO_TYPE_EH_FRAME 3
#define ELF_INFO_TYPE_JUST_SYMS 4

type asection as bfd_section

#define BFD_ABS_SECTION_NAME "*ABS*"
#define BFD_UND_SECTION_NAME "*UND*"
#define BFD_COM_SECTION_NAME "*COM*"
#define BFD_IND_SECTION_NAME "*IND*"

extern bfd_abs_section alias "bfd_abs_section" as asection
extern bfd_und_section alias "bfd_und_section" as asection
extern bfd_com_section alias "bfd_com_section" as asection
extern bfd_ind_section alias "bfd_ind_section" as asection
extern bfd_abs_symbol alias "bfd_abs_symbol" as bfd_symbol ptr
extern bfd_com_symbol alias "bfd_com_symbol" as bfd_symbol ptr
extern bfd_und_symbol alias "bfd_und_symbol" as bfd_symbol ptr
extern bfd_ind_symbol alias "bfd_ind_symbol" as bfd_symbol ptr

enum bfd_architecture
	bfd_arch_unknown
	bfd_arch_obscure
	bfd_arch_m68k
	bfd_arch_vax
	bfd_arch_i960
	bfd_arch_or32
	bfd_arch_a29k
	bfd_arch_sparc
	bfd_arch_mips
	bfd_arch_i386
	bfd_arch_we32k
	bfd_arch_tahoe
	bfd_arch_i860
	bfd_arch_i370
	bfd_arch_romp
	bfd_arch_alliant
	bfd_arch_convex
	bfd_arch_m88k
	bfd_arch_m98k
	bfd_arch_pyramid
	bfd_arch_h8300
	bfd_arch_pdp11
	bfd_arch_powerpc
	bfd_arch_rs6000
	bfd_arch_hppa
	bfd_arch_d10v
	bfd_arch_d30v
	bfd_arch_dlx
	bfd_arch_m68hc11
	bfd_arch_m68hc12
	bfd_arch_z8k
	bfd_arch_h8500
	bfd_arch_sh
	bfd_arch_alpha
	bfd_arch_arm
	bfd_arch_ns32k
	bfd_arch_w65
	bfd_arch_tic30
	bfd_arch_tic4x
	bfd_arch_tic54x
	bfd_arch_tic80
	bfd_arch_v850
	bfd_arch_arc
	bfd_arch_m32r
	bfd_arch_mn10200
	bfd_arch_mn10300
	bfd_arch_fr30
	bfd_arch_frv
	bfd_arch_mcore
	bfd_arch_ia64
	bfd_arch_ip2k
	bfd_arch_iq2000
	bfd_arch_pj
	bfd_arch_avr
	bfd_arch_cr16c
	bfd_arch_crx
	bfd_arch_cris
	bfd_arch_s390
	bfd_arch_openrisc
	bfd_arch_mmix
	bfd_arch_xstormy16
	bfd_arch_msp430
	bfd_arch_xtensa
	bfd_arch_maxq
	bfd_arch_last
end enum

#define bfd_mach_m68000 1
#define bfd_mach_m68008 2
#define bfd_mach_m68010 3
#define bfd_mach_m68020 4
#define bfd_mach_m68030 5
#define bfd_mach_m68040 6
#define bfd_mach_m68060 7
#define bfd_mach_cpu32 8
#define bfd_mach_mcf_isa_a_nodiv 9
#define bfd_mach_mcf_isa_a 10
#define bfd_mach_mcf_isa_a_mac 11
#define bfd_mach_mcf_isa_a_emac 12
#define bfd_mach_mcf_isa_aplus 13
#define bfd_mach_mcf_isa_aplus_mac 14
#define bfd_mach_mcf_isa_aplus_emac 15
#define bfd_mach_mcf_isa_b_nousp 16
#define bfd_mach_mcf_isa_b_nousp_mac 17
#define bfd_mach_mcf_isa_b_nousp_emac 18
#define bfd_mach_mcf_isa_b 19
#define bfd_mach_mcf_isa_b_mac 20
#define bfd_mach_mcf_isa_b_emac 21
#define bfd_mach_mcf_isa_b_float 22
#define bfd_mach_mcf_isa_b_float_mac 23
#define bfd_mach_mcf_isa_b_float_emac 24
#define bfd_mach_i960_core 1
#define bfd_mach_i960_ka_sa 2
#define bfd_mach_i960_kb_sb 3
#define bfd_mach_i960_mc 4
#define bfd_mach_i960_xa 5
#define bfd_mach_i960_ca 6
#define bfd_mach_i960_jx 7
#define bfd_mach_i960_hx 8
#define bfd_mach_sparc 1
#define bfd_mach_sparc_sparclet 2
#define bfd_mach_sparc_sparclite 3
#define bfd_mach_sparc_v8plus 4
#define bfd_mach_sparc_v8plusa 5
#define bfd_mach_sparc_sparclite_le 6
#define bfd_mach_sparc_v9 7
#define bfd_mach_sparc_v9a 8
#define bfd_mach_sparc_v8plusb 9
#define bfd_mach_sparc_v9b 10
#define bfd_mach_mips3000 3000
#define bfd_mach_mips3900 3900
#define bfd_mach_mips4000 4000
#define bfd_mach_mips4010 4010
#define bfd_mach_mips4100 4100
#define bfd_mach_mips4111 4111
#define bfd_mach_mips4120 4120
#define bfd_mach_mips4300 4300
#define bfd_mach_mips4400 4400
#define bfd_mach_mips4600 4600
#define bfd_mach_mips4650 4650
#define bfd_mach_mips5000 5000
#define bfd_mach_mips5400 5400
#define bfd_mach_mips5500 5500
#define bfd_mach_mips6000 6000
#define bfd_mach_mips7000 7000
#define bfd_mach_mips8000 8000
#define bfd_mach_mips9000 9000
#define bfd_mach_mips10000 10000
#define bfd_mach_mips12000 12000
#define bfd_mach_mips16 16
#define bfd_mach_mips5 5
#define bfd_mach_mips_sb1 12310201
#define bfd_mach_mipsisa32 32
#define bfd_mach_mipsisa32r2 33
#define bfd_mach_mipsisa64 64
#define bfd_mach_mipsisa64r2 65
#define bfd_mach_i386_i386 1
#define bfd_mach_i386_i8086 2
#define bfd_mach_i386_i386_intel_syntax 3
#define bfd_mach_x86_64 64
#define bfd_mach_x86_64_intel_syntax 65
#define bfd_mach_h8300 1
#define bfd_mach_h8300h 2
#define bfd_mach_h8300s 3
#define bfd_mach_h8300hn 4
#define bfd_mach_h8300sn 5
#define bfd_mach_h8300sx 6
#define bfd_mach_h8300sxn 7
#define bfd_mach_ppc 32
#define bfd_mach_ppc64 64
#define bfd_mach_ppc_403 403
#define bfd_mach_ppc_403gc 4030
#define bfd_mach_ppc_505 505
#define bfd_mach_ppc_601 601
#define bfd_mach_ppc_602 602
#define bfd_mach_ppc_603 603
#define bfd_mach_ppc_ec603e 6031
#define bfd_mach_ppc_604 604
#define bfd_mach_ppc_620 620
#define bfd_mach_ppc_630 630
#define bfd_mach_ppc_750 750
#define bfd_mach_ppc_860 860
#define bfd_mach_ppc_a35 35
#define bfd_mach_ppc_rs64ii 642
#define bfd_mach_ppc_rs64iii 643
#define bfd_mach_ppc_7400 7400
#define bfd_mach_ppc_e500 500
#define bfd_mach_rs6k 6000
#define bfd_mach_rs6k_rs1 6001
#define bfd_mach_rs6k_rsc 6003
#define bfd_mach_rs6k_rs2 6002
#define bfd_mach_hppa10 10
#define bfd_mach_hppa11 11
#define bfd_mach_hppa20 20
#define bfd_mach_hppa20w 25
#define bfd_mach_d10v 1
#define bfd_mach_d10v_ts2 2
#define bfd_mach_d10v_ts3 3
#define bfd_mach_m6812_default 0
#define bfd_mach_m6812 1
#define bfd_mach_m6812s 2
#define bfd_mach_z8001 1
#define bfd_mach_z8002 2
#define bfd_mach_sh 1
#define bfd_mach_sh2 &h20
#define bfd_mach_sh_dsp &h2d
#define bfd_mach_sh2a &h2a
#define bfd_mach_sh2a_nofpu &h2b
#define bfd_mach_sh2a_nofpu_or_sh4_nommu_nofpu &h2a1
#define bfd_mach_sh2a_nofpu_or_sh3_nommu &h2a2
#define bfd_mach_sh2a_or_sh4 &h2a3
#define bfd_mach_sh2a_or_sh3e &h2a4
#define bfd_mach_sh2e &h2e
#define bfd_mach_sh3 &h30
#define bfd_mach_sh3_nommu &h31
#define bfd_mach_sh3_dsp &h3d
#define bfd_mach_sh3e &h3e
#define bfd_mach_sh4 &h40
#define bfd_mach_sh4_nofpu &h41
#define bfd_mach_sh4_nommu_nofpu &h42
#define bfd_mach_sh4a &h4a
#define bfd_mach_sh4a_nofpu &h4b
#define bfd_mach_sh4al_dsp &h4d
#define bfd_mach_sh5 &h50
#define bfd_mach_alpha_ev4 &h10
#define bfd_mach_alpha_ev5 &h20
#define bfd_mach_alpha_ev6 &h30
#define bfd_mach_arm_unknown 0
#define bfd_mach_arm_2 1
#define bfd_mach_arm_2a 2
#define bfd_mach_arm_3 3
#define bfd_mach_arm_3M 4
#define bfd_mach_arm_4 5
#define bfd_mach_arm_4T 6
#define bfd_mach_arm_5 7
#define bfd_mach_arm_5T 8
#define bfd_mach_arm_5TE 9
#define bfd_mach_arm_XScale 10
#define bfd_mach_arm_ep9312 11
#define bfd_mach_arm_iWMMXt 12
#define bfd_mach_tic3x 30
#define bfd_mach_tic4x 40
#define bfd_mach_v850 1
#define bfd_mach_v850e asc("E")
#define bfd_mach_v850e1 asc("1")
#define bfd_mach_arc_5 5
#define bfd_mach_arc_6 6
#define bfd_mach_arc_7 7
#define bfd_mach_arc_8 8
#define bfd_mach_m16c &h75
#define bfd_mach_m32c &h78
#define bfd_mach_m32r 1
#define bfd_mach_m32rx asc("x")
#define bfd_mach_m32r2 asc("2")
#define bfd_mach_mn10300 300
#define bfd_mach_am33 330
#define bfd_mach_am33_2 332
#define bfd_mach_fr30 &h46523330
#define bfd_mach_frv 1
#define bfd_mach_frvsimple 2
#define bfd_mach_fr300 300
#define bfd_mach_fr400 400
#define bfd_mach_fr450 450
#define bfd_mach_frvtomcat 499
#define bfd_mach_fr500 500
#define bfd_mach_fr550 550
#define bfd_mach_ia64_elf64 64
#define bfd_mach_ia64_elf32 32
#define bfd_mach_ip2022 1
#define bfd_mach_ip2022ext 2
#define bfd_mach_iq2000 1
#define bfd_mach_iq10 2
#define bfd_mach_ms1 1
#define bfd_mach_mrisc2 2
#define bfd_mach_ms2 3
#define bfd_mach_avr1 1
#define bfd_mach_avr2 2
#define bfd_mach_avr3 3
#define bfd_mach_avr4 4
#define bfd_mach_avr5 5
#define bfd_mach_bfin 1
#define bfd_mach_cr16c 1
#define bfd_mach_crx 1
#define bfd_mach_cris_v0_v10 255
#define bfd_mach_cris_v32 32
#define bfd_mach_cris_v10_v32 1032
#define bfd_mach_s390_31 31
#define bfd_mach_s390_64 64
#define bfd_mach_xstormy16 1
#define bfd_mach_msp11 11
#define bfd_mach_msp110 110
#define bfd_mach_msp12 12
#define bfd_mach_msp13 13
#define bfd_mach_msp14 14
#define bfd_mach_msp15 15
#define bfd_mach_msp16 16
#define bfd_mach_msp21 21
#define bfd_mach_msp31 31
#define bfd_mach_msp32 32
#define bfd_mach_msp33 33
#define bfd_mach_msp41 41
#define bfd_mach_msp42 42
#define bfd_mach_msp43 43
#define bfd_mach_msp44 44
#define bfd_mach_xc16x 1
#define bfd_mach_xc16xl 2
#define bfd_mach_xc16xs 3
#define bfd_mach_xtensa 1
#define bfd_mach_maxq10 10
#define bfd_mach_maxq20 20
#define bfd_mach_z80strict 1
#define bfd_mach_z80 3
#define bfd_mach_z80full 7
#define bfd_mach_r800 11

type bfd_arch_info
	bits_per_word as integer
	bits_per_address as integer
	bits_per_byte as integer
	arch as bfd_architecture
	mach as uinteger
	arch_name as zstring ptr
	printable_name as zstring ptr
	section_align_power as uinteger
	the_default as bfd_boolean
	compatible as function cdecl(byval as bfd_arch_info ptr, byval as bfd_arch_info ptr) as bfd_arch_info ptr
	scan as function cdecl(byval as bfd_arch_info ptr, byval as zstring ptr) as bfd_boolean
	next as bfd_arch_info ptr
end type

type bfd_arch_info_type as bfd_arch_info

enum bfd_reloc_status
	bfd_reloc_ok
	bfd_reloc_overflow
	bfd_reloc_outofrange
	bfd_reloc_continue
	bfd_reloc_notsupported
	bfd_reloc_other
	bfd_reloc_undefined
	bfd_reloc_dangerous
end enum

type bfd_reloc_status_type as bfd_reloc_status

type reloc_cache_entry_
	sym_ptr_ptr as bfd_symbol ptr ptr
	address as bfd_size_type
	addend as bfd_vma
	howto as reloc_howto_type ptr
end type

type arelent as reloc_cache_entry

enum complain_overflow
	complain_overflow_dont
	complain_overflow_bitfield
	complain_overflow_signed
	complain_overflow_unsigned
end enum

type reloc_howto_struct
	type as uinteger
	rightshift as uinteger
	size as integer
	bitsize as uinteger
	pc_relative as bfd_boolean
	bitpos as uinteger
	complain_on_overflow as complain_overflow
	special_function as function cdecl(byval as bfd ptr, byval as arelent ptr, byval as bfd_symbol ptr, byval as any ptr, byval as asection ptr, byval as bfd ptr, byval as byte ptr ptr) as bfd_reloc_status_type
	name as zstring ptr
	partial_inplace as bfd_boolean
	src_mask as bfd_vma
	dst_mask as bfd_vma
	pcrel_offset as bfd_boolean
end type

type relent_chain_
	relent as arelent
	next as relent_chain ptr
end type

type arelent_chain as relent_chain


enum bfd_reloc_code_real
	BFD_RELOC_64 = 1
/'	BFD_RELOC_32
	BFD_RELOC_26
	BFD_RELOC_24
	BFD_RELOC_16
	BFD_RELOC_14
	BFD_RELOC_8
	BFD_RELOC_64_PCREL
	BFD_RELOC_32_PCREL
	BFD_RELOC_24_PCREL
	BFD_RELOC_16_PCREL
	BFD_RELOC_12_PCREL
	BFD_RELOC_8_PCREL
	BFD_RELOC_32_SECREL
	BFD_RELOC_32_GOT_PCREL
	BFD_RELOC_16_GOT_PCREL
	BFD_RELOC_8_GOT_PCREL
	BFD_RELOC_32_GOTOFF
	BFD_RELOC_16_GOTOFF
	BFD_RELOC_LO16_GOTOFF
	BFD_RELOC_HI16_GOTOFF
	BFD_RELOC_HI16_S_GOTOFF
	BFD_RELOC_8_GOTOFF
	BFD_RELOC_64_PLT_PCREL
	BFD_RELOC_32_PLT_PCREL
	BFD_RELOC_24_PLT_PCREL
	BFD_RELOC_16_PLT_PCREL
	BFD_RELOC_8_PLT_PCREL
	BFD_RELOC_64_PLTOFF
	BFD_RELOC_32_PLTOFF
	BFD_RELOC_16_PLTOFF
	BFD_RELOC_LO16_PLTOFF
	BFD_RELOC_HI16_PLTOFF
	BFD_RELOC_HI16_S_PLTOFF
	BFD_RELOC_8_PLTOFF
	BFD_RELOC_68K_GLOB_DAT
	BFD_RELOC_68K_JMP_SLOT
	BFD_RELOC_68K_RELATIVE
	BFD_RELOC_32_BASEREL
	BFD_RELOC_16_BASEREL
	BFD_RELOC_LO16_BASEREL
	BFD_RELOC_HI16_BASEREL
	BFD_RELOC_HI16_S_BASEREL
	BFD_RELOC_8_BASEREL
	BFD_RELOC_RVA
	BFD_RELOC_8_FFnn
	BFD_RELOC_32_PCREL_S2
	BFD_RELOC_16_PCREL_S2
	BFD_RELOC_23_PCREL_S2
	BFD_RELOC_HI22
	BFD_RELOC_LO10
	BFD_RELOC_GPREL16
	BFD_RELOC_GPREL32
	BFD_RELOC_I960_CALLJ
	BFD_RELOC_NONE
	BFD_RELOC_SPARC_WDISP22
	BFD_RELOC_SPARC22
	BFD_RELOC_SPARC13
	BFD_RELOC_SPARC_GOT10
	BFD_RELOC_SPARC_GOT13
	BFD_RELOC_SPARC_GOT22
	BFD_RELOC_SPARC_PC10
	BFD_RELOC_SPARC_PC22
	BFD_RELOC_SPARC_WPLT30
	BFD_RELOC_SPARC_COPY
	BFD_RELOC_SPARC_GLOB_DAT
	BFD_RELOC_SPARC_JMP_SLOT
	BFD_RELOC_SPARC_RELATIVE
	BFD_RELOC_SPARC_UA16
	BFD_RELOC_SPARC_UA32
	BFD_RELOC_SPARC_UA64
	BFD_RELOC_SPARC_BASE13
	BFD_RELOC_SPARC_BASE22
	BFD_RELOC_SPARC_10
	BFD_RELOC_SPARC_11
	BFD_RELOC_SPARC_OLO10
	BFD_RELOC_SPARC_HH22
	BFD_RELOC_SPARC_HM10
	BFD_RELOC_SPARC_LM22
	BFD_RELOC_SPARC_PC_HH22
	BFD_RELOC_SPARC_PC_HM10
	BFD_RELOC_SPARC_PC_LM22
	BFD_RELOC_SPARC_WDISP16
	BFD_RELOC_SPARC_WDISP19
	BFD_RELOC_SPARC_7
	BFD_RELOC_SPARC_6
	BFD_RELOC_SPARC_5
	BFD_RELOC_SPARC_PLT32
	BFD_RELOC_SPARC_PLT64
	BFD_RELOC_SPARC_HIX22
	BFD_RELOC_SPARC_LOX10
	BFD_RELOC_SPARC_H44
	BFD_RELOC_SPARC_M44
	BFD_RELOC_SPARC_L44
	BFD_RELOC_SPARC_REGISTER
	BFD_RELOC_SPARC_REV32
	BFD_RELOC_SPARC_TLS_GD_HI22
	BFD_RELOC_SPARC_TLS_GD_LO10
	BFD_RELOC_SPARC_TLS_GD_ADD
	BFD_RELOC_SPARC_TLS_GD_CALL
	BFD_RELOC_SPARC_TLS_LDM_HI22
	BFD_RELOC_SPARC_TLS_LDM_LO10
	BFD_RELOC_SPARC_TLS_LDM_ADD
	BFD_RELOC_SPARC_TLS_LDM_CALL
	BFD_RELOC_SPARC_TLS_LDO_HIX22
	BFD_RELOC_SPARC_TLS_LDO_LOX10
	BFD_RELOC_SPARC_TLS_LDO_ADD
	BFD_RELOC_SPARC_TLS_IE_HI22
	BFD_RELOC_SPARC_TLS_IE_LO10
	BFD_RELOC_SPARC_TLS_IE_LD
	BFD_RELOC_SPARC_TLS_IE_LDX
	BFD_RELOC_SPARC_TLS_IE_ADD
	BFD_RELOC_SPARC_TLS_LE_HIX22
	BFD_RELOC_SPARC_TLS_LE_LOX10
	BFD_RELOC_SPARC_TLS_DTPMOD32
	BFD_RELOC_SPARC_TLS_DTPMOD64
	BFD_RELOC_SPARC_TLS_DTPOFF32
	BFD_RELOC_SPARC_TLS_DTPOFF64
	BFD_RELOC_SPARC_TLS_TPOFF32
	BFD_RELOC_SPARC_TLS_TPOFF64
	BFD_RELOC_ALPHA_GPDISP_HI16
	BFD_RELOC_ALPHA_GPDISP_LO16
	BFD_RELOC_ALPHA_GPDISP
	BFD_RELOC_ALPHA_LITERAL
	BFD_RELOC_ALPHA_ELF_LITERAL
	BFD_RELOC_ALPHA_LITUSE
	BFD_RELOC_ALPHA_HINT
	BFD_RELOC_ALPHA_LINKAGE
	BFD_RELOC_ALPHA_CODEADDR
	BFD_RELOC_ALPHA_GPREL_HI16
	BFD_RELOC_ALPHA_GPREL_LO16
	BFD_RELOC_ALPHA_BRSGP
	BFD_RELOC_ALPHA_TLSGD
	BFD_RELOC_ALPHA_TLSLDM
	BFD_RELOC_ALPHA_DTPMOD64
	BFD_RELOC_ALPHA_GOTDTPREL16
	BFD_RELOC_ALPHA_DTPREL64
	BFD_RELOC_ALPHA_DTPREL_HI16
	BFD_RELOC_ALPHA_DTPREL_LO16
	BFD_RELOC_ALPHA_DTPREL16
	BFD_RELOC_ALPHA_GOTTPREL16
	BFD_RELOC_ALPHA_TPREL64
	BFD_RELOC_ALPHA_TPREL_HI16
	BFD_RELOC_ALPHA_TPREL_LO16
	BFD_RELOC_ALPHA_TPREL16
	BFD_RELOC_MIPS_JMP
	BFD_RELOC_MIPS16_JMP
	BFD_RELOC_MIPS16_GPREL
	BFD_RELOC_HI16
	BFD_RELOC_HI16_S
	BFD_RELOC_LO16
	BFD_RELOC_HI16_PCREL
	BFD_RELOC_HI16_S_PCREL
	BFD_RELOC_LO16_PCREL
	BFD_RELOC_MIPS16_HI16
	BFD_RELOC_MIPS16_HI16_S
	BFD_RELOC_MIPS16_LO16
	BFD_RELOC_MIPS_LITERAL
	BFD_RELOC_MIPS_GOT16
	BFD_RELOC_MIPS_CALL16
	BFD_RELOC_MIPS_GOT_HI16
	BFD_RELOC_MIPS_GOT_LO16
	BFD_RELOC_MIPS_CALL_HI16
	BFD_RELOC_MIPS_CALL_LO16
	BFD_RELOC_MIPS_SUB
	BFD_RELOC_MIPS_GOT_PAGE
	BFD_RELOC_MIPS_GOT_OFST
	BFD_RELOC_MIPS_GOT_DISP
	BFD_RELOC_MIPS_SHIFT5
	BFD_RELOC_MIPS_SHIFT6
	BFD_RELOC_MIPS_INSERT_A
	BFD_RELOC_MIPS_INSERT_B
	BFD_RELOC_MIPS_DELETE
	BFD_RELOC_MIPS_HIGHEST
	BFD_RELOC_MIPS_HIGHER
	BFD_RELOC_MIPS_SCN_DISP
	BFD_RELOC_MIPS_REL16
	BFD_RELOC_MIPS_RELGOT
	BFD_RELOC_MIPS_JALR
	BFD_RELOC_MIPS_TLS_DTPMOD32
	BFD_RELOC_MIPS_TLS_DTPREL32
	BFD_RELOC_MIPS_TLS_DTPMOD64
	BFD_RELOC_MIPS_TLS_DTPREL64
	BFD_RELOC_MIPS_TLS_GD
	BFD_RELOC_MIPS_TLS_LDM
	BFD_RELOC_MIPS_TLS_DTPREL_HI16
	BFD_RELOC_MIPS_TLS_DTPREL_LO16
	BFD_RELOC_MIPS_TLS_GOTTPREL
	BFD_RELOC_MIPS_TLS_TPREL32
	BFD_RELOC_MIPS_TLS_TPREL64
	BFD_RELOC_MIPS_TLS_TPREL_HI16
	BFD_RELOC_MIPS_TLS_TPREL_LO16
	BFD_RELOC_MIPS_COPY
	BFD_RELOC_MIPS_JUMP_SLOT
	BFD_RELOC_FRV_LABEL16
	BFD_RELOC_FRV_LABEL24
	BFD_RELOC_FRV_LO16
	BFD_RELOC_FRV_HI16
	BFD_RELOC_FRV_GPREL12
	BFD_RELOC_FRV_GPRELU12
	BFD_RELOC_FRV_GPREL32
	BFD_RELOC_FRV_GPRELHI
	BFD_RELOC_FRV_GPRELLO
	BFD_RELOC_FRV_GOT12
	BFD_RELOC_FRV_GOTHI
	BFD_RELOC_FRV_GOTLO
	BFD_RELOC_FRV_FUNCDESC
	BFD_RELOC_FRV_FUNCDESC_GOT12
	BFD_RELOC_FRV_FUNCDESC_GOTHI
	BFD_RELOC_FRV_FUNCDESC_GOTLO
	BFD_RELOC_FRV_FUNCDESC_VALUE
	BFD_RELOC_FRV_FUNCDESC_GOTOFF12
	BFD_RELOC_FRV_FUNCDESC_GOTOFFHI
	BFD_RELOC_FRV_FUNCDESC_GOTOFFLO
	BFD_RELOC_FRV_GOTOFF12
	BFD_RELOC_FRV_GOTOFFHI
	BFD_RELOC_FRV_GOTOFFLO
	BFD_RELOC_FRV_GETTLSOFF
	BFD_RELOC_FRV_TLSDESC_VALUE
	BFD_RELOC_FRV_GOTTLSDESC12
	BFD_RELOC_FRV_GOTTLSDESCHI
	BFD_RELOC_FRV_GOTTLSDESCLO
	BFD_RELOC_FRV_TLSMOFF12
	BFD_RELOC_FRV_TLSMOFFHI
	BFD_RELOC_FRV_TLSMOFFLO
	BFD_RELOC_FRV_GOTTLSOFF12
	BFD_RELOC_FRV_GOTTLSOFFHI
	BFD_RELOC_FRV_GOTTLSOFFLO
	BFD_RELOC_FRV_TLSOFF
	BFD_RELOC_FRV_TLSDESC_RELAX
	BFD_RELOC_FRV_GETTLSOFF_RELAX
	BFD_RELOC_FRV_TLSOFF_RELAX
	BFD_RELOC_FRV_TLSMOFF
	BFD_RELOC_MN10300_GOTOFF24
	BFD_RELOC_MN10300_GOT32
	BFD_RELOC_MN10300_GOT24
	BFD_RELOC_MN10300_GOT16
	BFD_RELOC_MN10300_COPY
	BFD_RELOC_MN10300_GLOB_DAT
	BFD_RELOC_MN10300_JMP_SLOT
	BFD_RELOC_MN10300_RELATIVE
	BFD_RELOC_386_GOT32
	BFD_RELOC_386_PLT32
	BFD_RELOC_386_COPY
	BFD_RELOC_386_GLOB_DAT
	BFD_RELOC_386_JUMP_SLOT
	BFD_RELOC_386_RELATIVE
	BFD_RELOC_386_GOTOFF
	BFD_RELOC_386_GOTPC
	BFD_RELOC_386_TLS_TPOFF
	BFD_RELOC_386_TLS_IE
	BFD_RELOC_386_TLS_GOTIE
	BFD_RELOC_386_TLS_LE
	BFD_RELOC_386_TLS_GD
	BFD_RELOC_386_TLS_LDM
	BFD_RELOC_386_TLS_LDO_32
	BFD_RELOC_386_TLS_IE_32
	BFD_RELOC_386_TLS_LE_32
	BFD_RELOC_386_TLS_DTPMOD32
	BFD_RELOC_386_TLS_DTPOFF32
	BFD_RELOC_386_TLS_TPOFF32
	BFD_RELOC_386_TLS_GOTDESC
	BFD_RELOC_386_TLS_DESC_CALL
	BFD_RELOC_386_TLS_DESC
	BFD_RELOC_X86_64_GOT32
	BFD_RELOC_X86_64_PLT32
	BFD_RELOC_X86_64_COPY
	BFD_RELOC_X86_64_GLOB_DAT
	BFD_RELOC_X86_64_JUMP_SLOT
	BFD_RELOC_X86_64_RELATIVE
	BFD_RELOC_X86_64_GOTPCREL
	BFD_RELOC_X86_64_32S
	BFD_RELOC_X86_64_DTPMOD64
	BFD_RELOC_X86_64_DTPOFF64
	BFD_RELOC_X86_64_TPOFF64
	BFD_RELOC_X86_64_TLSGD
	BFD_RELOC_X86_64_TLSLD
	BFD_RELOC_X86_64_DTPOFF32
	BFD_RELOC_X86_64_GOTTPOFF
	BFD_RELOC_X86_64_TPOFF32
	BFD_RELOC_X86_64_GOTOFF64
	BFD_RELOC_X86_64_GOTPC32
	BFD_RELOC_X86_64_GOT64
	BFD_RELOC_X86_64_GOTPCREL64
	BFD_RELOC_X86_64_GOTPC64
	BFD_RELOC_X86_64_GOTPLT64
	BFD_RELOC_X86_64_PLTOFF64
	BFD_RELOC_X86_64_GOTPC32_TLSDESC
	BFD_RELOC_X86_64_TLSDESC_CALL
	BFD_RELOC_X86_64_TLSDESC
	BFD_RELOC_NS32K_IMM_8
	BFD_RELOC_NS32K_IMM_16
	BFD_RELOC_NS32K_IMM_32
	BFD_RELOC_NS32K_IMM_8_PCREL
	BFD_RELOC_NS32K_IMM_16_PCREL
	BFD_RELOC_NS32K_IMM_32_PCREL
	BFD_RELOC_NS32K_DISP_8
	BFD_RELOC_NS32K_DISP_16
	BFD_RELOC_NS32K_DISP_32
	BFD_RELOC_NS32K_DISP_8_PCREL
	BFD_RELOC_NS32K_DISP_16_PCREL
	BFD_RELOC_NS32K_DISP_32_PCREL
	BFD_RELOC_PDP11_DISP_8_PCREL
	BFD_RELOC_PDP11_DISP_6_PCREL
	BFD_RELOC_PJ_CODE_HI16
	BFD_RELOC_PJ_CODE_LO16
	BFD_RELOC_PJ_CODE_DIR16
	BFD_RELOC_PJ_CODE_DIR32
	BFD_RELOC_PJ_CODE_REL16
	BFD_RELOC_PJ_CODE_REL32
	BFD_RELOC_PPC_B26
	BFD_RELOC_PPC_BA26
	BFD_RELOC_PPC_TOC16
	BFD_RELOC_PPC_B16
	BFD_RELOC_PPC_B16_BRTAKEN
	BFD_RELOC_PPC_B16_BRNTAKEN
	BFD_RELOC_PPC_BA16
	BFD_RELOC_PPC_BA16_BRTAKEN
	BFD_RELOC_PPC_BA16_BRNTAKEN
	BFD_RELOC_PPC_COPY
	BFD_RELOC_PPC_GLOB_DAT
	BFD_RELOC_PPC_JMP_SLOT
	BFD_RELOC_PPC_RELATIVE
	BFD_RELOC_PPC_LOCAL24PC
	BFD_RELOC_PPC_EMB_NADDR32
	BFD_RELOC_PPC_EMB_NADDR16
	BFD_RELOC_PPC_EMB_NADDR16_LO
	BFD_RELOC_PPC_EMB_NADDR16_HI
	BFD_RELOC_PPC_EMB_NADDR16_HA
	BFD_RELOC_PPC_EMB_SDAI16
	BFD_RELOC_PPC_EMB_SDA2I16
	BFD_RELOC_PPC_EMB_SDA2REL
	BFD_RELOC_PPC_EMB_SDA21
	BFD_RELOC_PPC_EMB_MRKREF
	BFD_RELOC_PPC_EMB_RELSEC16
	BFD_RELOC_PPC_EMB_RELST_LO
	BFD_RELOC_PPC_EMB_RELST_HI
	BFD_RELOC_PPC_EMB_RELST_HA
	BFD_RELOC_PPC_EMB_BIT_FLD
	BFD_RELOC_PPC_EMB_RELSDA
	BFD_RELOC_PPC64_HIGHER
	BFD_RELOC_PPC64_HIGHER_S
	BFD_RELOC_PPC64_HIGHEST
	BFD_RELOC_PPC64_HIGHEST_S
	BFD_RELOC_PPC64_TOC16_LO
	BFD_RELOC_PPC64_TOC16_HI
	BFD_RELOC_PPC64_TOC16_HA
	BFD_RELOC_PPC64_TOC
	BFD_RELOC_PPC64_PLTGOT16
	BFD_RELOC_PPC64_PLTGOT16_LO
	BFD_RELOC_PPC64_PLTGOT16_HI
	BFD_RELOC_PPC64_PLTGOT16_HA
	BFD_RELOC_PPC64_ADDR16_DS
	BFD_RELOC_PPC64_ADDR16_LO_DS
	BFD_RELOC_PPC64_GOT16_DS
	BFD_RELOC_PPC64_GOT16_LO_DS
	BFD_RELOC_PPC64_PLT16_LO_DS
	BFD_RELOC_PPC64_SECTOFF_DS
	BFD_RELOC_PPC64_SECTOFF_LO_DS
	BFD_RELOC_PPC64_TOC16_DS
	BFD_RELOC_PPC64_TOC16_LO_DS
	BFD_RELOC_PPC64_PLTGOT16_DS
	BFD_RELOC_PPC64_PLTGOT16_LO_DS
	BFD_RELOC_PPC_TLS
	BFD_RELOC_PPC_DTPMOD
	BFD_RELOC_PPC_TPREL16
	BFD_RELOC_PPC_TPREL16_LO
	BFD_RELOC_PPC_TPREL16_HI
	BFD_RELOC_PPC_TPREL16_HA
	BFD_RELOC_PPC_TPREL
	BFD_RELOC_PPC_DTPREL16
	BFD_RELOC_PPC_DTPREL16_LO
	BFD_RELOC_PPC_DTPREL16_HI
	BFD_RELOC_PPC_DTPREL16_HA
	BFD_RELOC_PPC_DTPREL
	BFD_RELOC_PPC_GOT_TLSGD16
	BFD_RELOC_PPC_GOT_TLSGD16_LO
	BFD_RELOC_PPC_GOT_TLSGD16_HI
	BFD_RELOC_PPC_GOT_TLSGD16_HA
	BFD_RELOC_PPC_GOT_TLSLD16
	BFD_RELOC_PPC_GOT_TLSLD16_LO
	BFD_RELOC_PPC_GOT_TLSLD16_HI
	BFD_RELOC_PPC_GOT_TLSLD16_HA
	BFD_RELOC_PPC_GOT_TPREL16
	BFD_RELOC_PPC_GOT_TPREL16_LO
	BFD_RELOC_PPC_GOT_TPREL16_HI
	BFD_RELOC_PPC_GOT_TPREL16_HA
	BFD_RELOC_PPC_GOT_DTPREL16
	BFD_RELOC_PPC_GOT_DTPREL16_LO
	BFD_RELOC_PPC_GOT_DTPREL16_HI
	BFD_RELOC_PPC_GOT_DTPREL16_HA
	BFD_RELOC_PPC64_TPREL16_DS
	BFD_RELOC_PPC64_TPREL16_LO_DS
	BFD_RELOC_PPC64_TPREL16_HIGHER
	BFD_RELOC_PPC64_TPREL16_HIGHERA
	BFD_RELOC_PPC64_TPREL16_HIGHEST
	BFD_RELOC_PPC64_TPREL16_HIGHESTA
	BFD_RELOC_PPC64_DTPREL16_DS
	BFD_RELOC_PPC64_DTPREL16_LO_DS
	BFD_RELOC_PPC64_DTPREL16_HIGHER
	BFD_RELOC_PPC64_DTPREL16_HIGHERA
	BFD_RELOC_PPC64_DTPREL16_HIGHEST
	BFD_RELOC_PPC64_DTPREL16_HIGHESTA
	BFD_RELOC_I370_D12
	BFD_RELOC_CTOR
	BFD_RELOC_ARM_PCREL_BRANCH
	BFD_RELOC_ARM_PCREL_BLX
	BFD_RELOC_THUMB_PCREL_BLX
	BFD_RELOC_ARM_PCREL_CALL
	BFD_RELOC_ARM_PCREL_JUMP
	BFD_RELOC_THUMB_PCREL_BRANCH7
	BFD_RELOC_THUMB_PCREL_BRANCH9
	BFD_RELOC_THUMB_PCREL_BRANCH12
	BFD_RELOC_THUMB_PCREL_BRANCH20
	BFD_RELOC_THUMB_PCREL_BRANCH23
	BFD_RELOC_THUMB_PCREL_BRANCH25
	BFD_RELOC_ARM_OFFSET_IMM
	BFD_RELOC_ARM_THUMB_OFFSET
	BFD_RELOC_ARM_TARGET1
	BFD_RELOC_ARM_ROSEGREL32
	BFD_RELOC_ARM_SBREL32
	BFD_RELOC_ARM_TARGET2
	BFD_RELOC_ARM_PREL31
	BFD_RELOC_ARM_JUMP_SLOT
	BFD_RELOC_ARM_GLOB_DAT
	BFD_RELOC_ARM_GOT32
	BFD_RELOC_ARM_PLT32
	BFD_RELOC_ARM_RELATIVE
	BFD_RELOC_ARM_GOTOFF
	BFD_RELOC_ARM_GOTPC
	BFD_RELOC_ARM_TLS_GD32
	BFD_RELOC_ARM_TLS_LDO32
	BFD_RELOC_ARM_TLS_LDM32
	BFD_RELOC_ARM_TLS_DTPOFF32
	BFD_RELOC_ARM_TLS_DTPMOD32
	BFD_RELOC_ARM_TLS_TPOFF32
	BFD_RELOC_ARM_TLS_IE32
	BFD_RELOC_ARM_TLS_LE32
	BFD_RELOC_ARM_IMMEDIATE
	BFD_RELOC_ARM_ADRL_IMMEDIATE
	BFD_RELOC_ARM_T32_IMMEDIATE
	BFD_RELOC_ARM_T32_IMM12
	BFD_RELOC_ARM_T32_ADD_PC12
	BFD_RELOC_ARM_SHIFT_IMM
	BFD_RELOC_ARM_SMC
	BFD_RELOC_ARM_SWI
	BFD_RELOC_ARM_MULTI
	BFD_RELOC_ARM_CP_OFF_IMM
	BFD_RELOC_ARM_CP_OFF_IMM_S2
	BFD_RELOC_ARM_T32_CP_OFF_IMM
	BFD_RELOC_ARM_T32_CP_OFF_IMM_S2
	BFD_RELOC_ARM_ADR_IMM
	BFD_RELOC_ARM_LDR_IMM
	BFD_RELOC_ARM_LITERAL
	BFD_RELOC_ARM_IN_POOL
	BFD_RELOC_ARM_OFFSET_IMM8
	BFD_RELOC_ARM_T32_OFFSET_U8
	BFD_RELOC_ARM_T32_OFFSET_IMM
	BFD_RELOC_ARM_HWLITERAL
	BFD_RELOC_ARM_THUMB_ADD
	BFD_RELOC_ARM_THUMB_IMM
	BFD_RELOC_ARM_THUMB_SHIFT
	BFD_RELOC_SH_PCDISP8BY2
	BFD_RELOC_SH_PCDISP12BY2
	BFD_RELOC_SH_IMM3
	BFD_RELOC_SH_IMM3U
	BFD_RELOC_SH_DISP12
	BFD_RELOC_SH_DISP12BY2
	BFD_RELOC_SH_DISP12BY4
	BFD_RELOC_SH_DISP12BY8
	BFD_RELOC_SH_DISP20
	BFD_RELOC_SH_DISP20BY8
	BFD_RELOC_SH_IMM4
	BFD_RELOC_SH_IMM4BY2
	BFD_RELOC_SH_IMM4BY4
	BFD_RELOC_SH_IMM8
	BFD_RELOC_SH_IMM8BY2
	BFD_RELOC_SH_IMM8BY4
	BFD_RELOC_SH_PCRELIMM8BY2
	BFD_RELOC_SH_PCRELIMM8BY4
	BFD_RELOC_SH_SWITCH16
	BFD_RELOC_SH_SWITCH32
	BFD_RELOC_SH_USES
	BFD_RELOC_SH_COUNT
	BFD_RELOC_SH_ALIGN
	BFD_RELOC_SH_CODE
	BFD_RELOC_SH_DATA
	BFD_RELOC_SH_LABEL
	BFD_RELOC_SH_LOOP_START
	BFD_RELOC_SH_LOOP_END
	BFD_RELOC_SH_COPY
	BFD_RELOC_SH_GLOB_DAT
	BFD_RELOC_SH_JMP_SLOT
	BFD_RELOC_SH_RELATIVE
	BFD_RELOC_SH_GOTPC
	BFD_RELOC_SH_GOT_LOW16
	BFD_RELOC_SH_GOT_MEDLOW16
	BFD_RELOC_SH_GOT_MEDHI16
	BFD_RELOC_SH_GOT_HI16
	BFD_RELOC_SH_GOTPLT_LOW16
	BFD_RELOC_SH_GOTPLT_MEDLOW16
	BFD_RELOC_SH_GOTPLT_MEDHI16
	BFD_RELOC_SH_GOTPLT_HI16
	BFD_RELOC_SH_PLT_LOW16
	BFD_RELOC_SH_PLT_MEDLOW16
	BFD_RELOC_SH_PLT_MEDHI16
	BFD_RELOC_SH_PLT_HI16
	BFD_RELOC_SH_GOTOFF_LOW16
	BFD_RELOC_SH_GOTOFF_MEDLOW16
	BFD_RELOC_SH_GOTOFF_MEDHI16
	BFD_RELOC_SH_GOTOFF_HI16
	BFD_RELOC_SH_GOTPC_LOW16
	BFD_RELOC_SH_GOTPC_MEDLOW16
	BFD_RELOC_SH_GOTPC_MEDHI16
	BFD_RELOC_SH_GOTPC_HI16
	BFD_RELOC_SH_COPY64
	BFD_RELOC_SH_GLOB_DAT64
	BFD_RELOC_SH_JMP_SLOT64
	BFD_RELOC_SH_RELATIVE64
	BFD_RELOC_SH_GOT10BY4
	BFD_RELOC_SH_GOT10BY8
	BFD_RELOC_SH_GOTPLT10BY4
	BFD_RELOC_SH_GOTPLT10BY8
	BFD_RELOC_SH_GOTPLT32
	BFD_RELOC_SH_SHMEDIA_CODE
	BFD_RELOC_SH_IMMU5
	BFD_RELOC_SH_IMMS6
	BFD_RELOC_SH_IMMS6BY32
	BFD_RELOC_SH_IMMU6
	BFD_RELOC_SH_IMMS10
	BFD_RELOC_SH_IMMS10BY2
	BFD_RELOC_SH_IMMS10BY4
	BFD_RELOC_SH_IMMS10BY8
	BFD_RELOC_SH_IMMS16
	BFD_RELOC_SH_IMMU16
	BFD_RELOC_SH_IMM_LOW16
	BFD_RELOC_SH_IMM_LOW16_PCREL
	BFD_RELOC_SH_IMM_MEDLOW16
	BFD_RELOC_SH_IMM_MEDLOW16_PCREL
	BFD_RELOC_SH_IMM_MEDHI16
	BFD_RELOC_SH_IMM_MEDHI16_PCREL
	BFD_RELOC_SH_IMM_HI16
	BFD_RELOC_SH_IMM_HI16_PCREL
	BFD_RELOC_SH_PT_16
	BFD_RELOC_SH_TLS_GD_32
	BFD_RELOC_SH_TLS_LD_32
	BFD_RELOC_SH_TLS_LDO_32
	BFD_RELOC_SH_TLS_IE_32
	BFD_RELOC_SH_TLS_LE_32
	BFD_RELOC_SH_TLS_DTPMOD32
	BFD_RELOC_SH_TLS_DTPOFF32
	BFD_RELOC_SH_TLS_TPOFF32
	BFD_RELOC_ARC_B22_PCREL
	BFD_RELOC_ARC_B26
	BFD_RELOC_BFIN_16_IMM
	BFD_RELOC_BFIN_16_HIGH
	BFD_RELOC_BFIN_4_PCREL
	BFD_RELOC_BFIN_5_PCREL
	BFD_RELOC_BFIN_16_LOW
	BFD_RELOC_BFIN_10_PCREL
	BFD_RELOC_BFIN_11_PCREL
	BFD_RELOC_BFIN_12_PCREL_JUMP
	BFD_RELOC_BFIN_12_PCREL_JUMP_S
	BFD_RELOC_BFIN_24_PCREL_CALL_X
	BFD_RELOC_BFIN_24_PCREL_JUMP_L
	BFD_RELOC_BFIN_GOT17M4
	BFD_RELOC_BFIN_GOTHI
	BFD_RELOC_BFIN_GOTLO
	BFD_RELOC_BFIN_FUNCDESC
	BFD_RELOC_BFIN_FUNCDESC_GOT17M4
	BFD_RELOC_BFIN_FUNCDESC_GOTHI
	BFD_RELOC_BFIN_FUNCDESC_GOTLO
	BFD_RELOC_BFIN_FUNCDESC_VALUE
	BFD_RELOC_BFIN_FUNCDESC_GOTOFF17M4
	BFD_RELOC_BFIN_FUNCDESC_GOTOFFHI
	BFD_RELOC_BFIN_FUNCDESC_GOTOFFLO
	BFD_RELOC_BFIN_GOTOFF17M4
	BFD_RELOC_BFIN_GOTOFFHI
	BFD_RELOC_BFIN_GOTOFFLO
	BFD_RELOC_BFIN_GOT
	BFD_RELOC_BFIN_PLTPC
	BFD_ARELOC_BFIN_PUSH
	BFD_ARELOC_BFIN_CONST
	BFD_ARELOC_BFIN_ADD
	BFD_ARELOC_BFIN_SUB
	BFD_ARELOC_BFIN_MULT
	BFD_ARELOC_BFIN_DIV
	BFD_ARELOC_BFIN_MOD
	BFD_ARELOC_BFIN_LSHIFT
	BFD_ARELOC_BFIN_RSHIFT
	BFD_ARELOC_BFIN_AND
	BFD_ARELOC_BFIN_OR
	BFD_ARELOC_BFIN_XOR
	BFD_ARELOC_BFIN_LAND
	BFD_ARELOC_BFIN_LOR
	BFD_ARELOC_BFIN_LEN
	BFD_ARELOC_BFIN_NEG
	BFD_ARELOC_BFIN_COMP
	BFD_ARELOC_BFIN_PAGE
	BFD_ARELOC_BFIN_HWPAGE
	BFD_ARELOC_BFIN_ADDR
	BFD_RELOC_D10V_10_PCREL_R
	BFD_RELOC_D10V_10_PCREL_L
	BFD_RELOC_D10V_18
	BFD_RELOC_D10V_18_PCREL
	BFD_RELOC_D30V_6
	BFD_RELOC_D30V_9_PCREL
	BFD_RELOC_D30V_9_PCREL_R
	BFD_RELOC_D30V_15
	BFD_RELOC_D30V_15_PCREL
	BFD_RELOC_D30V_15_PCREL_R
	BFD_RELOC_D30V_21
	BFD_RELOC_D30V_21_PCREL
	BFD_RELOC_D30V_21_PCREL_R
	BFD_RELOC_D30V_32
	BFD_RELOC_D30V_32_PCREL
	BFD_RELOC_DLX_HI16_S
	BFD_RELOC_DLX_LO16
	BFD_RELOC_DLX_JMP26
	BFD_RELOC_M32C_HI8
	BFD_RELOC_M32C_RL_JUMP
	BFD_RELOC_M32C_RL_1ADDR
	BFD_RELOC_M32C_RL_2ADDR
	BFD_RELOC_M32R_24
	BFD_RELOC_M32R_10_PCREL
	BFD_RELOC_M32R_18_PCREL
	BFD_RELOC_M32R_26_PCREL
	BFD_RELOC_M32R_HI16_ULO
	BFD_RELOC_M32R_HI16_SLO
	BFD_RELOC_M32R_LO16
	BFD_RELOC_M32R_SDA16
	BFD_RELOC_M32R_GOT24
	BFD_RELOC_M32R_26_PLTREL
	BFD_RELOC_M32R_COPY
	BFD_RELOC_M32R_GLOB_DAT
	BFD_RELOC_M32R_JMP_SLOT
	BFD_RELOC_M32R_RELATIVE
	BFD_RELOC_M32R_GOTOFF
	BFD_RELOC_M32R_GOTOFF_HI_ULO
	BFD_RELOC_M32R_GOTOFF_HI_SLO
	BFD_RELOC_M32R_GOTOFF_LO
	BFD_RELOC_M32R_GOTPC24
	BFD_RELOC_M32R_GOT16_HI_ULO
	BFD_RELOC_M32R_GOT16_HI_SLO
	BFD_RELOC_M32R_GOT16_LO
	BFD_RELOC_M32R_GOTPC_HI_ULO
	BFD_RELOC_M32R_GOTPC_HI_SLO
	BFD_RELOC_M32R_GOTPC_LO
	BFD_RELOC_V850_9_PCREL
	BFD_RELOC_V850_22_PCREL
	BFD_RELOC_V850_SDA_16_16_OFFSET
	BFD_RELOC_V850_SDA_15_16_OFFSET
	BFD_RELOC_V850_ZDA_16_16_OFFSET
	BFD_RELOC_V850_ZDA_15_16_OFFSET
	BFD_RELOC_V850_TDA_6_8_OFFSET
	BFD_RELOC_V850_TDA_7_8_OFFSET
	BFD_RELOC_V850_TDA_7_7_OFFSET
	BFD_RELOC_V850_TDA_16_16_OFFSET
	BFD_RELOC_V850_TDA_4_5_OFFSET
	BFD_RELOC_V850_TDA_4_4_OFFSET
	BFD_RELOC_V850_SDA_16_16_SPLIT_OFFSET
	BFD_RELOC_V850_ZDA_16_16_SPLIT_OFFSET
	BFD_RELOC_V850_CALLT_6_7_OFFSET
	BFD_RELOC_V850_CALLT_16_16_OFFSET
	BFD_RELOC_V850_LONGCALL
	BFD_RELOC_V850_LONGJUMP
	BFD_RELOC_V850_ALIGN
	BFD_RELOC_V850_LO16_SPLIT_OFFSET
	BFD_RELOC_MN10300_32_PCREL
	BFD_RELOC_MN10300_16_PCREL
	BFD_RELOC_TIC30_LDP
	BFD_RELOC_TIC54X_PARTLS7
	BFD_RELOC_TIC54X_PARTMS9
	BFD_RELOC_TIC54X_23
	BFD_RELOC_TIC54X_16_OF_23
	BFD_RELOC_TIC54X_MS7_OF_23
	BFD_RELOC_FR30_48
	BFD_RELOC_FR30_20
	BFD_RELOC_FR30_6_IN_4
	BFD_RELOC_FR30_8_IN_8
	BFD_RELOC_FR30_9_IN_8
	BFD_RELOC_FR30_10_IN_8
	BFD_RELOC_FR30_9_PCREL
	BFD_RELOC_FR30_12_PCREL
	BFD_RELOC_MCORE_PCREL_IMM8BY4
	BFD_RELOC_MCORE_PCREL_IMM11BY2
	BFD_RELOC_MCORE_PCREL_IMM4BY2
	BFD_RELOC_MCORE_PCREL_32
	BFD_RELOC_MCORE_PCREL_JSR_IMM11BY2
	BFD_RELOC_MCORE_RVA
	BFD_RELOC_MMIX_GETA
	BFD_RELOC_MMIX_GETA_1
	BFD_RELOC_MMIX_GETA_2
	BFD_RELOC_MMIX_GETA_3
	BFD_RELOC_MMIX_CBRANCH
	BFD_RELOC_MMIX_CBRANCH_J
	BFD_RELOC_MMIX_CBRANCH_1
	BFD_RELOC_MMIX_CBRANCH_2
	BFD_RELOC_MMIX_CBRANCH_3
	BFD_RELOC_MMIX_PUSHJ
	BFD_RELOC_MMIX_PUSHJ_1
	BFD_RELOC_MMIX_PUSHJ_2
	BFD_RELOC_MMIX_PUSHJ_3
	BFD_RELOC_MMIX_PUSHJ_STUBBABLE
	BFD_RELOC_MMIX_JMP
	BFD_RELOC_MMIX_JMP_1
	BFD_RELOC_MMIX_JMP_2
	BFD_RELOC_MMIX_JMP_3
	BFD_RELOC_MMIX_ADDR19
	BFD_RELOC_MMIX_ADDR27
	BFD_RELOC_MMIX_REG_OR_BYTE
	BFD_RELOC_MMIX_REG
	BFD_RELOC_MMIX_BASE_PLUS_OFFSET
	BFD_RELOC_MMIX_LOCAL
	BFD_RELOC_AVR_7_PCREL
	BFD_RELOC_AVR_13_PCREL
	BFD_RELOC_AVR_16_PM
	BFD_RELOC_AVR_LO8_LDI
	BFD_RELOC_AVR_HI8_LDI
	BFD_RELOC_AVR_HH8_LDI
	BFD_RELOC_AVR_MS8_LDI
	BFD_RELOC_AVR_LO8_LDI_NEG
	BFD_RELOC_AVR_HI8_LDI_NEG
	BFD_RELOC_AVR_HH8_LDI_NEG
	BFD_RELOC_AVR_MS8_LDI_NEG
	BFD_RELOC_AVR_LO8_LDI_PM
	BFD_RELOC_AVR_HI8_LDI_PM
	BFD_RELOC_AVR_HH8_LDI_PM
	BFD_RELOC_AVR_LO8_LDI_PM_NEG
	BFD_RELOC_AVR_HI8_LDI_PM_NEG
	BFD_RELOC_AVR_HH8_LDI_PM_NEG
	BFD_RELOC_AVR_CALL
	BFD_RELOC_AVR_LDI
	BFD_RELOC_AVR_6
	BFD_RELOC_AVR_6_ADIW
	BFD_RELOC_390_12
	BFD_RELOC_390_GOT12
	BFD_RELOC_390_PLT32
	BFD_RELOC_390_COPY
	BFD_RELOC_390_GLOB_DAT
	BFD_RELOC_390_JMP_SLOT
	BFD_RELOC_390_RELATIVE
	BFD_RELOC_390_GOTPC
	BFD_RELOC_390_GOT16
	BFD_RELOC_390_PC16DBL
	BFD_RELOC_390_PLT16DBL
	BFD_RELOC_390_PC32DBL
	BFD_RELOC_390_PLT32DBL
	BFD_RELOC_390_GOTPCDBL
	BFD_RELOC_390_GOT64
	BFD_RELOC_390_PLT64
	BFD_RELOC_390_GOTENT
	BFD_RELOC_390_GOTOFF64
	BFD_RELOC_390_GOTPLT12
	BFD_RELOC_390_GOTPLT16
	BFD_RELOC_390_GOTPLT32
	BFD_RELOC_390_GOTPLT64
	BFD_RELOC_390_GOTPLTENT
	BFD_RELOC_390_PLTOFF16
	BFD_RELOC_390_PLTOFF32
	BFD_RELOC_390_PLTOFF64
	BFD_RELOC_390_TLS_LOAD
	BFD_RELOC_390_TLS_GDCALL
	BFD_RELOC_390_TLS_LDCALL
	BFD_RELOC_390_TLS_GD32
	BFD_RELOC_390_TLS_GD64
	BFD_RELOC_390_TLS_GOTIE12
	BFD_RELOC_390_TLS_GOTIE32
	BFD_RELOC_390_TLS_GOTIE64
	BFD_RELOC_390_TLS_LDM32
	BFD_RELOC_390_TLS_LDM64
	BFD_RELOC_390_TLS_IE32
	BFD_RELOC_390_TLS_IE64
	BFD_RELOC_390_TLS_IEENT
	BFD_RELOC_390_TLS_LE32
	BFD_RELOC_390_TLS_LE64
	BFD_RELOC_390_TLS_LDO32
	BFD_RELOC_390_TLS_LDO64
	BFD_RELOC_390_TLS_DTPMOD
	BFD_RELOC_390_TLS_DTPOFF
	BFD_RELOC_390_TLS_TPOFF
	BFD_RELOC_390_20
	BFD_RELOC_390_GOT20
	BFD_RELOC_390_GOTPLT20
	BFD_RELOC_390_TLS_GOTIE20
	BFD_RELOC_IP2K_FR9
	BFD_RELOC_IP2K_BANK
	BFD_RELOC_IP2K_ADDR16CJP
	BFD_RELOC_IP2K_PAGE3
	BFD_RELOC_IP2K_LO8DATA
	BFD_RELOC_IP2K_HI8DATA
	BFD_RELOC_IP2K_EX8DATA
	BFD_RELOC_IP2K_LO8INSN
	BFD_RELOC_IP2K_HI8INSN
	BFD_RELOC_IP2K_PC_SKIP
	BFD_RELOC_IP2K_TEXT
	BFD_RELOC_IP2K_FR_OFFSET
	BFD_RELOC_VPE4KMATH_DATA
	BFD_RELOC_VPE4KMATH_INSN
	BFD_RELOC_VTABLE_INHERIT
	BFD_RELOC_VTABLE_ENTRY
	BFD_RELOC_IA64_IMM14
	BFD_RELOC_IA64_IMM22
	BFD_RELOC_IA64_IMM64
	BFD_RELOC_IA64_DIR32MSB
	BFD_RELOC_IA64_DIR32LSB
	BFD_RELOC_IA64_DIR64MSB
	BFD_RELOC_IA64_DIR64LSB
	BFD_RELOC_IA64_GPREL22
	BFD_RELOC_IA64_GPREL64I
	BFD_RELOC_IA64_GPREL32MSB
	BFD_RELOC_IA64_GPREL32LSB
	BFD_RELOC_IA64_GPREL64MSB
	BFD_RELOC_IA64_GPREL64LSB
	BFD_RELOC_IA64_LTOFF22
	BFD_RELOC_IA64_LTOFF64I
	BFD_RELOC_IA64_PLTOFF22
	BFD_RELOC_IA64_PLTOFF64I
	BFD_RELOC_IA64_PLTOFF64MSB
	BFD_RELOC_IA64_PLTOFF64LSB
	BFD_RELOC_IA64_FPTR64I
	BFD_RELOC_IA64_FPTR32MSB
	BFD_RELOC_IA64_FPTR32LSB
	BFD_RELOC_IA64_FPTR64MSB
	BFD_RELOC_IA64_FPTR64LSB
	BFD_RELOC_IA64_PCREL21B
	BFD_RELOC_IA64_PCREL21BI
	BFD_RELOC_IA64_PCREL21M
	BFD_RELOC_IA64_PCREL21F
	BFD_RELOC_IA64_PCREL22
	BFD_RELOC_IA64_PCREL60B
	BFD_RELOC_IA64_PCREL64I
	BFD_RELOC_IA64_PCREL32MSB
	BFD_RELOC_IA64_PCREL32LSB
	BFD_RELOC_IA64_PCREL64MSB
	BFD_RELOC_IA64_PCREL64LSB
	BFD_RELOC_IA64_LTOFF_FPTR22
	BFD_RELOC_IA64_LTOFF_FPTR64I
	BFD_RELOC_IA64_LTOFF_FPTR32MSB
	BFD_RELOC_IA64_LTOFF_FPTR32LSB
	BFD_RELOC_IA64_LTOFF_FPTR64MSB
	BFD_RELOC_IA64_LTOFF_FPTR64LSB
	BFD_RELOC_IA64_SEGREL32MSB
	BFD_RELOC_IA64_SEGREL32LSB
	BFD_RELOC_IA64_SEGREL64MSB
	BFD_RELOC_IA64_SEGREL64LSB
	BFD_RELOC_IA64_SECREL32MSB
	BFD_RELOC_IA64_SECREL32LSB
	BFD_RELOC_IA64_SECREL64MSB
	BFD_RELOC_IA64_SECREL64LSB
	BFD_RELOC_IA64_REL32MSB
	BFD_RELOC_IA64_REL32LSB
	BFD_RELOC_IA64_REL64MSB
	BFD_RELOC_IA64_REL64LSB
	BFD_RELOC_IA64_LTV32MSB
	BFD_RELOC_IA64_LTV32LSB
	BFD_RELOC_IA64_LTV64MSB
	BFD_RELOC_IA64_LTV64LSB
	BFD_RELOC_IA64_IPLTMSB
	BFD_RELOC_IA64_IPLTLSB
	BFD_RELOC_IA64_COPY
	BFD_RELOC_IA64_LTOFF22X
	BFD_RELOC_IA64_LDXMOV
	BFD_RELOC_IA64_TPREL14
	BFD_RELOC_IA64_TPREL22
	BFD_RELOC_IA64_TPREL64I
	BFD_RELOC_IA64_TPREL64MSB
	BFD_RELOC_IA64_TPREL64LSB
	BFD_RELOC_IA64_LTOFF_TPREL22
	BFD_RELOC_IA64_DTPMOD64MSB
	BFD_RELOC_IA64_DTPMOD64LSB
	BFD_RELOC_IA64_LTOFF_DTPMOD22
	BFD_RELOC_IA64_DTPREL14
	BFD_RELOC_IA64_DTPREL22
	BFD_RELOC_IA64_DTPREL64I
	BFD_RELOC_IA64_DTPREL32MSB
	BFD_RELOC_IA64_DTPREL32LSB
	BFD_RELOC_IA64_DTPREL64MSB
	BFD_RELOC_IA64_DTPREL64LSB
	BFD_RELOC_IA64_LTOFF_DTPREL22
	BFD_RELOC_M68HC11_HI8
	BFD_RELOC_M68HC11_LO8
	BFD_RELOC_M68HC11_3B
	BFD_RELOC_M68HC11_RL_JUMP
	BFD_RELOC_M68HC11_RL_GROUP
	BFD_RELOC_M68HC11_LO16
	BFD_RELOC_M68HC11_PAGE
	BFD_RELOC_M68HC11_24
	BFD_RELOC_M68HC12_5B
	BFD_RELOC_16C_NUM08
	BFD_RELOC_16C_NUM08_C
	BFD_RELOC_16C_NUM16
	BFD_RELOC_16C_NUM16_C
	BFD_RELOC_16C_NUM32
	BFD_RELOC_16C_NUM32_C
	BFD_RELOC_16C_DISP04
	BFD_RELOC_16C_DISP04_C
	BFD_RELOC_16C_DISP08
	BFD_RELOC_16C_DISP08_C
	BFD_RELOC_16C_DISP16
	BFD_RELOC_16C_DISP16_C
	BFD_RELOC_16C_DISP24
	BFD_RELOC_16C_DISP24_C
	BFD_RELOC_16C_DISP24a
	BFD_RELOC_16C_DISP24a_C
	BFD_RELOC_16C_REG04
	BFD_RELOC_16C_REG04_C
	BFD_RELOC_16C_REG04a
	BFD_RELOC_16C_REG04a_C
	BFD_RELOC_16C_REG14
	BFD_RELOC_16C_REG14_C
	BFD_RELOC_16C_REG16
	BFD_RELOC_16C_REG16_C
	BFD_RELOC_16C_REG20
	BFD_RELOC_16C_REG20_C
	BFD_RELOC_16C_ABS20
	BFD_RELOC_16C_ABS20_C
	BFD_RELOC_16C_ABS24
	BFD_RELOC_16C_ABS24_C
	BFD_RELOC_16C_IMM04
	BFD_RELOC_16C_IMM04_C
	BFD_RELOC_16C_IMM16
	BFD_RELOC_16C_IMM16_C
	BFD_RELOC_16C_IMM20
	BFD_RELOC_16C_IMM20_C
	BFD_RELOC_16C_IMM24
	BFD_RELOC_16C_IMM24_C
	BFD_RELOC_16C_IMM32
	BFD_RELOC_16C_IMM32_C
	BFD_RELOC_CRX_REL4
	BFD_RELOC_CRX_REL8
	BFD_RELOC_CRX_REL8_CMP
	BFD_RELOC_CRX_REL16
	BFD_RELOC_CRX_REL24
	BFD_RELOC_CRX_REL32
	BFD_RELOC_CRX_REGREL12
	BFD_RELOC_CRX_REGREL22
	BFD_RELOC_CRX_REGREL28
	BFD_RELOC_CRX_REGREL32
	BFD_RELOC_CRX_ABS16
	BFD_RELOC_CRX_ABS32
	BFD_RELOC_CRX_NUM8
	BFD_RELOC_CRX_NUM16
	BFD_RELOC_CRX_NUM32
	BFD_RELOC_CRX_IMM16
	BFD_RELOC_CRX_IMM32
	BFD_RELOC_CRX_SWITCH8
	BFD_RELOC_CRX_SWITCH16
	BFD_RELOC_CRX_SWITCH32
	BFD_RELOC_CRIS_BDISP8
	BFD_RELOC_CRIS_UNSIGNED_5
	BFD_RELOC_CRIS_SIGNED_6
	BFD_RELOC_CRIS_UNSIGNED_6
	BFD_RELOC_CRIS_SIGNED_8
	BFD_RELOC_CRIS_UNSIGNED_8
	BFD_RELOC_CRIS_SIGNED_16
	BFD_RELOC_CRIS_UNSIGNED_16
	BFD_RELOC_CRIS_LAPCQ_OFFSET
	BFD_RELOC_CRIS_UNSIGNED_4
	BFD_RELOC_CRIS_COPY
	BFD_RELOC_CRIS_GLOB_DAT
	BFD_RELOC_CRIS_JUMP_SLOT
	BFD_RELOC_CRIS_RELATIVE
	BFD_RELOC_CRIS_32_GOT
	BFD_RELOC_CRIS_16_GOT
	BFD_RELOC_CRIS_32_GOTPLT
	BFD_RELOC_CRIS_16_GOTPLT
	BFD_RELOC_CRIS_32_GOTREL
	BFD_RELOC_CRIS_32_PLT_GOTREL
	BFD_RELOC_CRIS_32_PLT_PCREL
	BFD_RELOC_860_COPY
	BFD_RELOC_860_GLOB_DAT
	BFD_RELOC_860_JUMP_SLOT
	BFD_RELOC_860_RELATIVE
	BFD_RELOC_860_PC26
	BFD_RELOC_860_PLT26
	BFD_RELOC_860_PC16
	BFD_RELOC_860_LOW0
	BFD_RELOC_860_SPLIT0
	BFD_RELOC_860_LOW1
	BFD_RELOC_860_SPLIT1
	BFD_RELOC_860_LOW2
	BFD_RELOC_860_SPLIT2
	BFD_RELOC_860_LOW3
	BFD_RELOC_860_LOGOT0
	BFD_RELOC_860_SPGOT0
	BFD_RELOC_860_LOGOT1
	BFD_RELOC_860_SPGOT1
	BFD_RELOC_860_LOGOTOFF0
	BFD_RELOC_860_SPGOTOFF0
	BFD_RELOC_860_LOGOTOFF1
	BFD_RELOC_860_SPGOTOFF1
	BFD_RELOC_860_LOGOTOFF2
	BFD_RELOC_860_LOGOTOFF3
	BFD_RELOC_860_LOPC
	BFD_RELOC_860_HIGHADJ
	BFD_RELOC_860_HAGOT
	BFD_RELOC_860_HAGOTOFF
	BFD_RELOC_860_HAPC
	BFD_RELOC_860_HIGH
	BFD_RELOC_860_HIGOT
	BFD_RELOC_860_HIGOTOFF
	BFD_RELOC_OPENRISC_ABS_26
	BFD_RELOC_OPENRISC_REL_26
	BFD_RELOC_H8_DIR16A8
	BFD_RELOC_H8_DIR16R8
	BFD_RELOC_H8_DIR24A8
	BFD_RELOC_H8_DIR24R8
	BFD_RELOC_H8_DIR32A16
	BFD_RELOC_XSTORMY16_REL_12
	BFD_RELOC_XSTORMY16_12
	BFD_RELOC_XSTORMY16_24
	BFD_RELOC_XSTORMY16_FPTR16
	BFD_RELOC_XC16X_PAG
	BFD_RELOC_XC16X_POF
	BFD_RELOC_XC16X_SEG
	BFD_RELOC_XC16X_SOF
	BFD_RELOC_VAX_GLOB_DAT
	BFD_RELOC_VAX_JMP_SLOT
	BFD_RELOC_VAX_RELATIVE
	BFD_RELOC_MT_PC16
	BFD_RELOC_MT_HI16
	BFD_RELOC_MT_LO16
	BFD_RELOC_MT_GNU_VTINHERIT
	BFD_RELOC_MT_GNU_VTENTRY
	BFD_RELOC_MT_PCINSN8
	BFD_RELOC_MSP430_10_PCREL
	BFD_RELOC_MSP430_16_PCREL
	BFD_RELOC_MSP430_16
	BFD_RELOC_MSP430_16_PCREL_BYTE
	BFD_RELOC_MSP430_16_BYTE
	BFD_RELOC_MSP430_2X_PCREL
	BFD_RELOC_MSP430_RL_PCREL
	BFD_RELOC_IQ2000_OFFSET_16
	BFD_RELOC_IQ2000_OFFSET_21
	BFD_RELOC_IQ2000_UHI16
	BFD_RELOC_XTENSA_RTLD
	BFD_RELOC_XTENSA_GLOB_DAT
	BFD_RELOC_XTENSA_JMP_SLOT
	BFD_RELOC_XTENSA_RELATIVE
	BFD_RELOC_XTENSA_PLT
	BFD_RELOC_XTENSA_DIFF8
	BFD_RELOC_XTENSA_DIFF16
	BFD_RELOC_XTENSA_DIFF32
	BFD_RELOC_XTENSA_SLOT0_OP
	BFD_RELOC_XTENSA_SLOT1_OP
	BFD_RELOC_XTENSA_SLOT2_OP
	BFD_RELOC_XTENSA_SLOT3_OP
	BFD_RELOC_XTENSA_SLOT4_OP
	BFD_RELOC_XTENSA_SLOT5_OP
	BFD_RELOC_XTENSA_SLOT6_OP
	BFD_RELOC_XTENSA_SLOT7_OP
	BFD_RELOC_XTENSA_SLOT8_OP
	BFD_RELOC_XTENSA_SLOT9_OP
	BFD_RELOC_XTENSA_SLOT10_OP
	BFD_RELOC_XTENSA_SLOT11_OP
	BFD_RELOC_XTENSA_SLOT12_OP
	BFD_RELOC_XTENSA_SLOT13_OP
	BFD_RELOC_XTENSA_SLOT14_OP
	BFD_RELOC_XTENSA_SLOT0_ALT
	BFD_RELOC_XTENSA_SLOT1_ALT
	BFD_RELOC_XTENSA_SLOT2_ALT
	BFD_RELOC_XTENSA_SLOT3_ALT
	BFD_RELOC_XTENSA_SLOT4_ALT
	BFD_RELOC_XTENSA_SLOT5_ALT
	BFD_RELOC_XTENSA_SLOT6_ALT
	BFD_RELOC_XTENSA_SLOT7_ALT
	BFD_RELOC_XTENSA_SLOT8_ALT
	BFD_RELOC_XTENSA_SLOT9_ALT
	BFD_RELOC_XTENSA_SLOT10_ALT
	BFD_RELOC_XTENSA_SLOT11_ALT
	BFD_RELOC_XTENSA_SLOT12_ALT
	BFD_RELOC_XTENSA_SLOT13_ALT
	BFD_RELOC_XTENSA_SLOT14_ALT
	BFD_RELOC_XTENSA_OP0
	BFD_RELOC_XTENSA_OP1
	BFD_RELOC_XTENSA_OP2
	BFD_RELOC_XTENSA_ASM_EXPAND
	BFD_RELOC_XTENSA_ASM_SIMPLIFY
	BFD_RELOC_Z80_DISP8
	BFD_RELOC_Z8K_DISP7
	BFD_RELOC_Z8K_CALLR
	BFD_RELOC_Z8K_IMM4L
	BFD_RELOC_UNUSED '/
end enum

type bfd_reloc_code_real_type as bfd_reloc_code_real

union asymbol__udata
	p as any ptr
	i as bfd_vma
end union

type bfd_symbol_
	the_bfd as bfd ptr
	name as zstring ptr
	value as symvalue
	flags as flagword
	section as bfd_section ptr
	udata as asymbol__udata
end type

#define BSF_NO_FLAGS &h00
#define BSF_LOCAL &h01
#define BSF_GLOBAL &h02
#define BSF_EXPORT &h02
#define BSF_DEBUGGING &h08
#define BSF_FUNCTION &h10
#define BSF_KEEP &h20
#define BSF_KEEP_G &h40
#define BSF_WEAK &h80
#define BSF_SECTION_SYM &h100
#define BSF_OLD_COMMON &h200
#define BFD_FORT_COMM_DEFAULT_VALUE 0
#define BSF_NOT_AT_END &h400
#define BSF_CONSTRUCTOR &h800
#define BSF_WARNING &h1000
#define BSF_INDIRECT &h2000
#define BSF_FILE &h4000
#define BSF_DYNAMIC &h8000
#define BSF_OBJECT &h10000
#define BSF_DEBUGGING_RELOC &h20000
#define BSF_THREAD_LOCAL &h40000

type asymbol as bfd_symbol

union bfd__tdata
	/'aout_data as aout_data_struct ptr
	aout_ar_data as artdata ptr
	oasys_obj_data as _oasys_data ptr
	oasys_ar_data as _oasys_ar_data ptr
	coff_obj_data as coff_tdata ptr
	pe_obj_data as pe_tdata ptr
	xcoff_obj_data as xcoff_tdata ptr
	ecoff_obj_data as ecoff_tdata ptr
	ieee_data as ieee_data_struct ptr
	ieee_ar_data as ieee_ar_data_struct ptr
	srec_data as srec_data_struct ptr
	ihex_data as ihex_data_struct ptr
	tekhex_data as tekhex_data_struct ptr
	elf_obj_data as elf_obj_tdata ptr
	nlm_obj_data as nlm_obj_tdata ptr
	bout_data as bout_data_struct ptr
	mmo_data as mmo_data_struct ptr
	sun_core_data as sun_core_struct ptr
	sco5_core_data as sco5_core_struct ptr
	trad_core_data as trad_core_struct ptr
	som_data as som_data_struct ptr
	hpux_core_data as hpux_core_struct ptr
	hppabsd_core_data as hppabsd_core_struct ptr
	sgi_core_data as sgi_core_struct ptr
	lynx_core_data as lynx_core_struct ptr
	osf_core_data as osf_core_struct ptr
	cisco_core_data as cisco_core_struct ptr
	versados_data as versados_data_struct ptr
	netbsd_core_data as netbsd_core_struct ptr
	mach_o_data as mach_o_data_struct ptr
	mach_o_fat_data as mach_o_fat_data_struct ptr
	pef_data as bfd_pef_data_struct ptr
	pef_xlib_data as bfd_pef_xlib_data_struct ptr
	sym_data as bfd_sym_data_struct ptr'/
	any as any ptr
end union

enum bfd_direction
  no_direction = 0
  read_direction = 1
  write_direction = 2
  both_direction = 3
end enum

type bfd_
	id as uinteger
	filename as zstring ptr
	xvec as bfd_target ptr
	iostream as any ptr
	iovec as bfd_iovec ptr
	cacheable as bfd_boolean
	target_defaulted as bfd_boolean
	lru_prev as bfd ptr
	lru_next as bfd ptr
	where as ufile_ptr
	opened_once as bfd_boolean
	mtime_set as bfd_boolean
	mtime as integer
	ifd as integer
	format as bfd_format
  direction as bfd_direction
	flags as flagword
	origin as ufile_ptr
	output_has_begun as bfd_boolean
	section_htab as bfd_hash_table
	sections as bfd_section ptr
	section_tail as bfd_section ptr ptr
	section_count as uinteger
	start_address as bfd_vma
	symcount as uinteger
	outsymbols as bfd_symbol ptr ptr
	dynsymcount as uinteger
	arch_info as bfd_arch_info ptr
	no_export as bfd_boolean
	arelt_data as any ptr
	my_archive as bfd ptr
	next as bfd ptr
	archive_head as bfd ptr
	has_armap as bfd_boolean
	link_next as bfd ptr
	archive_pass as integer
	tdata as bfd__tdata
	usrdata as any ptr
	memory as any ptr
end type

enum bfd_error
	bfd_error_no_error = 0
	bfd_error_system_call
	bfd_error_invalid_target
	bfd_error_wrong_format
	bfd_error_wrong_object_format
	bfd_error_invalid_operation
	bfd_error_no_memory
	bfd_error_no_symbols
	bfd_error_no_armap
	bfd_error_no_more_archived_files
	bfd_error_malformed_archive
	bfd_error_file_not_recognized
	bfd_error_file_ambiguously_recognized
	bfd_error_no_contents
	bfd_error_nonrepresentable_section
	bfd_error_no_debug_section
	bfd_error_bad_value
	bfd_error_file_truncated
	bfd_error_file_too_big
	bfd_error_invalid_error_code
end enum

type bfd_error_type as bfd_error

type bfd_error_handler_type as sub cdecl(byval as zstring ptr, ...)

type bfd_preserve
	marker as any ptr
	tdata as any ptr
	flags as flagword
	arch_info as bfd_arch_info ptr
	sections as bfd_section ptr
	section_tail as bfd_section ptr ptr
	section_count as uinteger
	section_htab as bfd_hash_table
end type

enum bfd_flavour
	bfd_target_unknown_flavour
	bfd_target_aout_flavour
	bfd_target_coff_flavour
	bfd_target_ecoff_flavour
	bfd_target_xcoff_flavour
	bfd_target_elf_flavour
	bfd_target_ieee_flavour
	bfd_target_nlm_flavour
	bfd_target_oasys_flavour
	bfd_target_tekhex_flavour
	bfd_target_srec_flavour
	bfd_target_ihex_flavour
	bfd_target_som_flavour
	bfd_target_os9k_flavour
	bfd_target_versados_flavour
	bfd_target_msdos_flavour
	bfd_target_ovax_flavour
	bfd_target_evax_flavour
	bfd_target_mmo_flavour
	bfd_target_mach_o_flavour
	bfd_target_pef_flavour
	bfd_target_pef_xlib_flavour
	bfd_target_sym_flavour
end enum

enum bfd_endian
	BFD_ENDIAN_BIG
	BFD_ENDIAN_LITTLE
	BFD_ENDIAN_UNKNOWN
end enum

#define bfd_put_8(abfd, val_, ptr_) *cast(ubyte ptr, ptr_) = (val_) and &hff
#define bfd_put_signed_8 bfd_put_8
#define bfd_get_8(abfd, ptr_) (*cast(ubyte ptr, ptr_) and &hff)
#define bfd_get_signed_8(abfd, ptr_) (((*cast(ubyte ptr, ptr_) and &hff) xor &h80) - &h80)
#define bfd_put_16(abfd, val_, ptr_) BFD_SEND (abfd, bfd_putx16, ((val_),(ptr_)))
#define bfd_put_signed_16 bfd_put_16
#define bfd_get_16(abfd, ptr_) BFD_SEND (abfd, bfd_getx16, (ptr_))
#define bfd_get_signed_16(abfd, ptr_) BFD_SEND (abfd, bfd_getx_signed_16, (ptr_))
#define bfd_put_32(abfd, val_, ptr_) BFD_SEND (abfd, bfd_putx32, ((val_),(ptr_)))
#define bfd_put_signed_32 bfd_put_32
#define bfd_get_32(abfd, ptr_) BFD_SEND (abfd, bfd_getx32, (ptr_))
#define bfd_get_signed_32(abfd, ptr_) BFD_SEND (abfd, bfd_getx_signed_32, (ptr_))
#define bfd_put_64(abfd, val_, ptr_) BFD_SEND (abfd, bfd_putx64, ((val_), (ptr_)))
#define bfd_put_signed_64 bfd_put_64
#define bfd_get_64(abfd, ptr_) BFD_SEND (abfd, bfd_getx64, (ptr_))
#define bfd_get_signed_64(abfd, ptr_) BFD_SEND (abfd, bfd_getx_signed_64, (ptr_))

#define bfd_h_put_8(abfd, val_, ptr_) bfd_put_8 (abfd, val_, ptr_)
#define bfd_h_put_signed_8(abfd, val_, ptr_) bfd_put_8 (abfd, val_, ptr_)
#define bfd_h_get_8(abfd, ptr_) bfd_get_8 (abfd, ptr_)
#define bfd_h_get_signed_8(abfd, ptr_) bfd_get_signed_8 (abfd, ptr_)
#define bfd_h_put_16(abfd, val_, ptr_) BFD_SEND (abfd, bfd_h_putx16, (val_, ptr_))
#define bfd_h_put_signed_16 bfd_h_put_16
#define bfd_h_get_16(abfd, ptr_) BFD_SEND (abfd, bfd_h_getx16, (ptr_))
#define bfd_h_get_signed_16(abfd, ptr_) BFD_SEND (abfd, bfd_h_getx_signed_16, (ptr_))
#define bfd_h_put_32(abfd, val_, ptr_) BFD_SEND (abfd, bfd_h_putx32, (val_, ptr_))
#define bfd_h_put_signed_32 bfd_h_put_32
#define bfd_h_get_32(abfd, ptr_) BFD_SEND (abfd, bfd_h_getx32, (ptr_))
#define bfd_h_get_signed_32(abfd, ptr_) BFD_SEND (abfd, bfd_h_getx_signed_32, (ptr_))
#define bfd_h_put_64(abfd, val_, ptr_) BFD_SEND (abfd, bfd_h_putx64, (val_, ptr_))
#define bfd_h_put_signed_64 bfd_h_put_64
#define bfd_h_get_64(abfd, ptr_) BFD_SEND (abfd, bfd_h_getx64, (ptr_))
#define bfd_h_get_signed_64(abfd, ptr_) BFD_SEND (abfd, bfd_h_getx_signed_64, (ptr_))

#define bfd_abs_section_ptr cast(asection ptr, @bfd_abs_section)
#define bfd_is_abs_section(sec) ((sec) = bfd_abs_section_ptr)
#define bfd_und_section_ptr cast(asection ptr, @bfd_und_section)
#define bfd_is_und_section(sec) ((sec) = bfd_und_section_ptr)
#define bfd_com_section_ptr cast(asection ptr, @bfd_com_section)
#define bfd_ind_section_ptr cast(asection ptr, @bfd_ind_section)
#define bfd_is_ind_section(sec) ((sec) = bfd_ind_section_ptr)
#define bfd_is_const_section(SEC) (((SEC) = bfd_abs_section_ptr) or ((SEC) = bfd_und_section_ptr) or ((SEC) = bfd_com_section_ptr) or ((SEC) = bfd_ind_section_ptr))

#define bfd_copy_private_section_data(ibfd, isection, obfd, osection) BFD_SEND (obfd, _bfd_copy_private_section_data, (ibfd, isection, obfd, osection))

#define bfd_get_symtab_upper_bound(abfd) BFD_SEND (abfd, _bfd_get_symtab_upper_bound, (abfd))
#define bfd_is_local_label_name(abfd, name_) BFD_SEND (abfd, _bfd_is_local_label_name, (abfd, name_))
#define bfd_is_target_special_symbol(abfd, sym) BFD_SEND (abfd, _bfd_is_target_special_symbol, (abfd, sym))
#define bfd_canonicalize_symtab(abfd, location) BFD_SEND (abfd, _bfd_canonicalize_symtab, (abfd, location))
#define bfd_make_empty_symbol(abfd) BFD_SEND (abfd, _bfd_make_empty_symbol, (abfd))
#define bfd_make_debug_symbol(abfd,ptr_,size) BFD_SEND (abfd, _bfd_make_debug_symbol, (abfd, ptr_, size))
#define bfd_copy_private_symbol_data(ibfd, isymbol, obfd, osymbol) BFD_SEND (obfd, _bfd_copy_private_symbol_data, (ibfd, isymbol, obfd, osymbol))
#define bfd_copy_private_header_data(ibfd, obfd) BFD_SEND (obfd, _bfd_copy_private_header_data, (ibfd, obfd))
#define bfd_copy_private_bfd_data(ibfd, obfd) BFD_SEND (obfd, _bfd_copy_private_bfd_data, (ibfd, obfd))
#define bfd_merge_private_bfd_data(ibfd, obfd) BFD_SEND (obfd, _bfd_merge_private_bfd_data, (ibfd, obfd))
#define bfd_set_private_flags(abfd, flags) BFD_SEND (abfd, _bfd_set_private_flags, (abfd, flags))
#define bfd_sizeof_headers(abfd, reloc) BFD_SEND (abfd, _bfd_sizeof_headers, (abfd, reloc))
#define bfd_find_nearest_line(abfd, sec, syms, off, file, func, line) BFD_SEND (abfd, _bfd_find_nearest_line, (abfd, sec, syms, off, file, func, line))
#define bfd_find_line(abfd, syms, sym, file, line) BFD_SEND (abfd, _bfd_find_line, (abfd, syms, sym, file, line))
#define bfd_find_inliner_info(abfd, file, func, line) BFD_SEND (abfd, _bfd_find_inliner_info, (abfd, file, func, line))
#define bfd_debug_info_start(abfd) BFD_SEND (abfd, _bfd_debug_info_start, (abfd))
#define bfd_debug_info_end(abfd) BFD_SEND (abfd, _bfd_debug_info_end, (abfd))
#define bfd_debug_info_accumulate(abfd, section) BFD_SEND (abfd, _bfd_debug_info_accumulate, (abfd, section))
#define bfd_stat_arch_elt(abfd, stat) BFD_SEND (abfd, _bfd_stat_arch_elt,(abfd, stat))
#define bfd_update_armap_timestamp(abfd) BFD_SEND (abfd, _bfd_update_armap_timestamp, (abfd))
#define bfd_set_arch_mach(abfd, arch, mach) BFD_SEND ( abfd, _bfd_set_arch_mach, (abfd, arch, mach))
#define bfd_relax_section(abfd, section, link_info, again) BFD_SEND (abfd, _bfd_relax_section, (abfd, section, link_info, again))
#define bfd_gc_sections(abfd, link_info) BFD_SEND (abfd, _bfd_gc_sections, (abfd, link_info))
#define bfd_merge_sections(abfd, link_info) BFD_SEND (abfd, _bfd_merge_sections, (abfd, link_info))
#define bfd_is_group_section(abfd, sec) BFD_SEND (abfd, _bfd_is_group_section, (abfd, sec))
#define bfd_discard_group(abfd, sec) BFD_SEND (abfd, _bfd_discard_group, (abfd, sec))
#define bfd_link_hash_table_create(abfd) BFD_SEND (abfd, _bfd_link_hash_table_create, (abfd))
#define bfd_link_hash_table_free(abfd, hash) BFD_SEND (abfd, _bfd_link_hash_table_free, (hash))
#define bfd_link_add_symbols(abfd, info) BFD_SEND (abfd, _bfd_link_add_symbols, (abfd, info))
#define bfd_link_just_syms(abfd, sec, info) BFD_SEND (abfd, _bfd_link_just_syms, (sec, info))
#define bfd_final_link(abfd, info) BFD_SEND (abfd, _bfd_final_link, (abfd, info))
#define bfd_free_cached_info(abfd) BFD_SEND (abfd, _bfd_free_cached_info, (abfd))
#define bfd_get_dynamic_symtab_upper_bound(abfd) BFD_SEND (abfd, _bfd_get_dynamic_symtab_upper_bound, (abfd))
#define bfd_print_private_bfd_data(abfd, file) BFD_SEND (abfd, _bfd_print_private_bfd_data, (abfd, file))
#define bfd_canonicalize_dynamic_symtab(abfd, asymbols) BFD_SEND (abfd, _bfd_canonicalize_dynamic_symtab, (abfd, asymbols))
#define bfd_get_synthetic_symtab(abfd, count, syms, dyncount, dynsyms, ret) BFD_SEND (abfd, _bfd_get_synthetic_symtab, (abfd, count, syms, dyncount, dynsyms, ret))
#define bfd_get_dynamic_reloc_upper_bound(abfd) BFD_SEND (abfd, _bfd_get_dynamic_reloc_upper_bound, (abfd))
#define bfd_canonicalize_dynamic_reloc(abfd, arels, asyms) BFD_SEND (abfd, _bfd_canonicalize_dynamic_reloc, (abfd, arels, asyms))
#define bfd_init_private_section_data(ibfd, isec, obfd, osec, link_info) BFD_SEND (obfd, _bfd_init_private_section_data, (ibfd, isec, obfd, osec, link_info))
#define bfd_get_elt_at_index(b,i) BFD_SEND (b, _bfd_get_elt_at_index, (b,i))
#define bfd_print_symbol_(b,p,s,e) BFD_SEND (b, _bfd_print_symbol, (b,p,s,e))
#define bfd_get_symbol_info(b,p,e) BFD_SEND (b, _bfd_get_symbol_info, (b,p,e))
#define bfd_read_minisymbols(b, d, m, s) BFD_SEND (b, _read_minisymbols, (b, d, m, s))
#define bfd_minisymbol_to_symbol(b, d, m, f) BFD_SEND (b, _minisymbol_to_symbol, (b, d, m, f))
#define bfd_link_split_section(abfd, sec) BFD_SEND (abfd, _bfd_link_split_section, (abfd, sec))
#define bfd_section_already_linked(abfd, sec) BFD_SEND (abfd, _section_already_linked, (abfd, sec))

type bfd_target_
	name as zstring ptr
	flavour as bfd_flavour
	byteorder as bfd_endian
	header_byteorder as bfd_endian
	object_flags as flagword
	section_flags as flagword
	symbol_leading_char as byte
	ar_pad_char as byte
	ar_max_namelen as ushort
	bfd_getx64 as function cdecl(byval as any ptr) as bfd_uint64_t
	bfd_getx_signed_64 as function cdecl(byval as any ptr) as bfd_int64_t
	bfd_putx64 as sub cdecl(byval as bfd_uint64_t, byval as any ptr)
	bfd_getx32 as function cdecl(byval as any ptr) as bfd_vma
	bfd_getx_signed_32 as function cdecl(byval as any ptr) as bfd_signed_vma
	bfd_putx32 as sub cdecl(byval as bfd_vma, byval as any ptr)
	bfd_getx16 as function cdecl(byval as any ptr) as bfd_vma
	bfd_getx_signed_16 as function cdecl(byval as any ptr) as bfd_signed_vma
	bfd_putx16 as sub cdecl(byval as bfd_vma, byval as any ptr)
	bfd_h_getx64 as function cdecl(byval as any ptr) as bfd_uint64_t
	bfd_h_getx_signed_64 as function cdecl(byval as any ptr) as bfd_int64_t
	bfd_h_putx64 as sub cdecl(byval as bfd_uint64_t, byval as any ptr)
	bfd_h_getx32 as function cdecl(byval as any ptr) as bfd_vma
	bfd_h_getx_signed_32 as function cdecl(byval as any ptr) as bfd_signed_vma
	bfd_h_putx32 as sub cdecl(byval as bfd_vma, byval as any ptr)
	bfd_h_getx16 as function cdecl(byval as any ptr) as bfd_vma
	bfd_h_getx_signed_16 as function cdecl(byval as any ptr) as bfd_signed_vma
	bfd_h_putx16 as sub cdecl(byval as bfd_vma, byval as any ptr)
	_bfd_check_format(0 to bfd_type_end-1) as bfd_target ptr
	_bfd_set_format(0 to bfd_type_end-1) as bfd_boolean ptr
	_bfd_write_contents(0 to bfd_type_end-1) as bfd_boolean ptr
	_close_and_cleanup as function cdecl(byval as bfd ptr) as bfd_boolean
	_bfd_free_cached_info as function cdecl(byval as bfd ptr) as bfd_boolean
	_new_section_hook as function cdecl(byval as bfd ptr, byval as sec_ptr) as bfd_boolean
	_bfd_get_section_contents as function cdecl(byval as bfd ptr, byval as sec_ptr, byval as any ptr, byval as file_ptr, byval as bfd_size_type) as bfd_boolean
	_bfd_get_section_contents_in_window as function cdecl(byval as bfd ptr, byval as sec_ptr, byval as bfd_window ptr, byval as file_ptr, byval as bfd_size_type) as bfd_boolean
	_bfd_copy_private_bfd_data as function cdecl(byval as bfd ptr, byval as bfd ptr) as bfd_boolean
	_bfd_merge_private_bfd_data as function cdecl(byval as bfd ptr, byval as bfd ptr) as bfd_boolean
	_bfd_copy_private_section_data as function cdecl(byval as bfd ptr, byval as sec_ptr, byval as bfd ptr, byval as sec_ptr) as bfd_boolean
	_bfd_copy_private_symbol_data as function cdecl(byval as bfd ptr, byval as asymbol ptr, byval as bfd ptr, byval as asymbol ptr) as bfd_boolean
	_bfd_copy_private_header_data as function cdecl(byval as bfd ptr, byval as bfd ptr) as bfd_boolean
	_bfd_set_private_flags as function cdecl(byval as bfd ptr, byval as flagword) as bfd_boolean
	_bfd_print_private_bfd_data as function cdecl(byval as bfd ptr, byval as any ptr) as bfd_boolean
	_core_file_failing_command as function cdecl(byval as bfd ptr) as byte ptr
	_core_file_failing_signal as function cdecl(byval as bfd ptr) as integer
	_core_file_matches_executable_p as function cdecl(byval as bfd ptr, byval as bfd ptr) as bfd_boolean
	_bfd_slurp_armap as function cdecl(byval as bfd ptr) as bfd_boolean
	_bfd_slurp_extended_name_table as function cdecl(byval as bfd ptr) as bfd_boolean
	_bfd_construct_extended_name_table as function cdecl(byval as bfd ptr, byval as byte ptr ptr, byval as bfd_size_type ptr, byval as byte ptr ptr) as bfd_boolean
	_bfd_truncate_arname as sub cdecl(byval as bfd ptr, byval as zstring ptr, byval as zstring ptr)
	write_armap as function cdecl(byval as bfd ptr, byval as uinteger, byval as orl ptr, byval as uinteger, byval as integer) as bfd_boolean
	_bfd_read_ar_hdr_fn as sub cdecl(byval as bfd ptr)
	openr_next_archived_file as function cdecl(byval as bfd ptr, byval as bfd ptr) as bfd ptr
	_bfd_get_elt_at_index as function cdecl(byval as bfd ptr, byval as symindex) as bfd ptr
	_bfd_stat_arch_elt as function cdecl(byval as bfd ptr, byval as stat ptr) as integer
	_bfd_update_armap_timestamp as function cdecl(byval as bfd ptr) as bfd_boolean
	_bfd_get_symtab_upper_bound as function cdecl(byval as bfd ptr) as integer
	_bfd_canonicalize_symtab as function cdecl(byval as bfd ptr, byval as bfd_symbol ptr ptr) as integer
	_bfd_make_empty_symbol as function cdecl(byval as bfd ptr) as bfd_symbol ptr
	_bfd_print_symbol as sub cdecl(byval as bfd ptr, byval as any ptr, byval as bfd_symbol ptr, byval as bfd_print_symbol_type)
	_bfd_get_symbol_info as sub cdecl(byval as bfd ptr, byval as bfd_symbol ptr, byval as symbol_info ptr)
	_bfd_is_local_label_name as function cdecl(byval as bfd ptr, byval as zstring ptr) as bfd_boolean
	_bfd_is_target_special_symbol as function cdecl(byval as bfd ptr, byval as asymbol ptr) as bfd_boolean
	_get_lineno as function cdecl(byval as bfd ptr, byval as bfd_symbol ptr) as alent ptr
	_bfd_find_nearest_line as function cdecl(byval as bfd ptr, byval as bfd_section ptr, byval as bfd_symbol ptr ptr, byval as bfd_vma, byval as byte ptr ptr, byval as byte ptr ptr, byval as uinteger ptr) as bfd_boolean
	_bfd_make_debug_symbol as function cdecl(byval as bfd ptr, byval as any ptr, byval as uinteger) as asymbol ptr
	_read_minisymbols as function cdecl(byval as bfd ptr, byval as bfd_boolean, byval as any ptr ptr, byval as uinteger ptr) as integer
	_minisymbol_to_symbol as function cdecl(byval as bfd ptr, byval as bfd_boolean, byval as any ptr, byval as asymbol ptr) as asymbol ptr
	_get_reloc_upper_bound as function cdecl(byval as bfd ptr, byval as sec_ptr) as integer
	_bfd_canonicalize_reloc as function cdecl(byval as bfd ptr, byval as sec_ptr, byval as arelent ptr ptr, byval as bfd_symbol ptr ptr) as integer
	reloc_type_lookup as function cdecl(byval as bfd ptr, byval as bfd_reloc_code_real_type) as reloc_howto_type ptr
	_bfd_set_arch_mach as function cdecl(byval as bfd ptr, byval as bfd_architecture, byval as uinteger) as bfd_boolean
	_bfd_set_section_contents as function cdecl(byval as bfd ptr, byval as sec_ptr, byval as any ptr, byval as file_ptr, byval as bfd_size_type) as bfd_boolean
	_bfd_sizeof_headers as function cdecl(byval as bfd ptr, byval as bfd_boolean) as integer
	_bfd_get_relocated_section_contents as function cdecl(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_link_order ptr, byval as bfd_byte ptr, byval as bfd_boolean, byval as bfd_symbol ptr ptr) as bfd_byte ptr
	_bfd_relax_section as function cdecl(byval as bfd ptr, byval as bfd_section ptr, byval as bfd_link_info ptr, byval as bfd_boolean ptr) as bfd_boolean
	_bfd_link_hash_table_create as function cdecl(byval as bfd ptr) as bfd_link_hash_table ptr
	_bfd_link_hash_table_free as sub cdecl(byval as bfd_link_hash_table ptr)
	_bfd_link_add_symbols as function cdecl(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
	_bfd_link_just_syms as sub cdecl(byval as asection ptr, byval as bfd_link_info ptr)
	_bfd_final_link as function cdecl(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
	_bfd_link_split_section as function cdecl(byval as bfd ptr, byval as bfd_section ptr) as bfd_boolean
	_bfd_gc_sections as function cdecl(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
	_bfd_merge_sections as function cdecl(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
	_bfd_is_group_section as function cdecl(byval as bfd ptr, byval as bfd_section ptr) as bfd_boolean
	_bfd_discard_group as function cdecl(byval as bfd ptr, byval as bfd_section ptr) as bfd_boolean
	_section_already_linked as sub cdecl(byval as bfd ptr, byval as bfd_section ptr)
	_bfd_get_dynamic_symtab_upper_bound as function cdecl(byval as bfd ptr) as integer
	_bfd_canonicalize_dynamic_symtab as function cdecl(byval as bfd ptr, byval as bfd_symbol ptr ptr) as integer
	_bfd_get_synthetic_symtab as function cdecl(byval as bfd ptr, byval as integer, byval as bfd_symbol ptr ptr, byval as integer, byval as bfd_symbol ptr ptr, byval as bfd_symbol ptr ptr) as integer
	_bfd_get_dynamic_reloc_upper_bound as function cdecl(byval as bfd ptr) as integer
	_bfd_canonicalize_dynamic_reloc as function cdecl(byval as bfd ptr, byval as arelent ptr ptr, byval as bfd_symbol ptr ptr) as integer
	alternative_target as bfd_target ptr
	backend_data as any ptr
end type

#define BFD_SEND(bfd, message, arglist) (bfd)->xvec->message arglist

extern "c"

declare function bfd_printable_name (byval abfd as bfd ptr) as zstring ptr
declare function bfd_scan_arch (byval string as zstring ptr) as bfd_arch_info_type ptr
declare function bfd_arch_list () as zstring ptr ptr
declare function bfd_arch_get_compatible (byval abfd as bfd ptr, byval bbfd as bfd ptr, byval accept_unknowns as bfd_boolean) as bfd_arch_info_type ptr
declare sub bfd_set_arch_info (byval abfd as bfd ptr, byval arg as bfd_arch_info_type ptr)
declare function bfd_get_arch (byval abfd as bfd ptr) as bfd_architecture
declare function bfd_get_mach (byval abfd as bfd ptr) as uinteger
declare function bfd_arch_bits_per_byte (byval abfd as bfd ptr) as uinteger
declare function bfd_arch_bits_per_address (byval abfd as bfd ptr) as uinteger
declare function bfd_get_arch_info (byval abfd as bfd ptr) as bfd_arch_info_type ptr
declare function bfd_lookup_arch (byval arch as bfd_architecture, byval machine as uinteger) as bfd_arch_info_type ptr
declare function bfd_printable_arch_mach (byval arch as bfd_architecture, byval machine as uinteger) as zstring ptr
declare function bfd_octets_per_byte (byval abfd as bfd ptr) as uinteger
declare function bfd_arch_mach_octets_per_byte (byval arch as bfd_architecture, byval machine as uinteger) as uinteger
declare function bfd_get_stab_name (byval as integer) as zstring ptr
declare sub bfd_sprintf_vma (byval as bfd ptr, byval as zstring ptr, byval as bfd_vma)
declare sub bfd_fprintf_vma (byval as bfd ptr, byval as any ptr, byval as bfd_vma)
declare function bfd_hash_table_init (byval as bfd_hash_table ptr, byval as function cdecl(byval as bfd_hash_entry ptr, byval as bfd_hash_table ptr, byval as zstring ptr) as bfd_hash_entry ptr) as bfd_boolean
declare function bfd_hash_table_init_n (byval as bfd_hash_table ptr, byval as function cdecl(byval as bfd_hash_entry ptr, byval as bfd_hash_table ptr, byval as zstring ptr) as bfd_hash_entry ptr, byval as uinteger, byval as uinteger) as bfd_boolean
declare sub bfd_hash_table_free (byval as bfd_hash_table ptr)
declare function bfd_hash_lookup (byval as bfd_hash_table ptr, byval as zstring ptr, byval create as bfd_boolean, byval copy as bfd_boolean) as bfd_hash_entry ptr
declare sub bfd_hash_replace (byval as bfd_hash_table ptr, byval old as bfd_hash_entry ptr, byval nw as bfd_hash_entry ptr)
declare function bfd_hash_newfunc (byval as bfd_hash_entry ptr, byval as bfd_hash_table ptr, byval as zstring ptr) as bfd_hash_entry ptr
declare function bfd_hash_allocate (byval as bfd_hash_table ptr, byval as uinteger) as any ptr
declare sub bfd_hash_traverse (byval as bfd_hash_table ptr, byval as function cdecl(byval as bfd_hash_entry ptr, byval as any ptr) as bfd_boolean, byval info as any ptr)
declare sub bfd_hash_set_default_size (byval as bfd_size_type)
declare function bfd_bread (byval as any ptr, byval as bfd_size_type, byval as bfd ptr) as bfd_size_type
declare function bfd_bwrite (byval as any ptr, byval as bfd_size_type, byval as bfd ptr) as bfd_size_type
declare function bfd_seek (byval as bfd ptr, byval as file_ptr, byval as integer) as integer
declare function bfd_tell (byval as bfd ptr) as file_ptr
declare function bfd_flush (byval as bfd ptr) as integer
declare function bfd_stat (byval as bfd ptr, byval as stat ptr) as integer
declare sub warn_deprecated (byval as zstring ptr, byval as zstring ptr, byval as integer, byval as zstring ptr)
declare function bfd_cache_close (byval abfd as bfd ptr) as bfd_boolean
declare function bfd_cache_close_all () as bfd_boolean
declare function bfd_record_phdr (byval as bfd ptr, byval as uinteger, byval as bfd_boolean, byval as flagword, byval as bfd_boolean, byval as bfd_vma, byval as bfd_boolean, byval as bfd_boolean, byval as uinteger, byval as bfd_section ptr ptr) as bfd_boolean
declare function bfd_getb64 (byval as any ptr) as bfd_uint64_t
declare function bfd_getl64 (byval as any ptr) as bfd_uint64_t
declare function bfd_getb_signed_64 (byval as any ptr) as bfd_int64_t
declare function bfd_getl_signed_64 (byval as any ptr) as bfd_int64_t
declare function bfd_getb32 (byval as any ptr) as bfd_vma
declare function bfd_getl32 (byval as any ptr) as bfd_vma
declare function bfd_getb_signed_32 (byval as any ptr) as bfd_signed_vma
declare function bfd_getl_signed_32 (byval as any ptr) as bfd_signed_vma
declare function bfd_getb16 (byval as any ptr) as bfd_vma
declare function bfd_getl16 (byval as any ptr) as bfd_vma
declare function bfd_getb_signed_16 (byval as any ptr) as bfd_signed_vma
declare function bfd_getl_signed_16 (byval as any ptr) as bfd_signed_vma
declare sub bfd_putb64 (byval as bfd_uint64_t, byval as any ptr)
declare sub bfd_putl64 (byval as bfd_uint64_t, byval as any ptr)
declare sub bfd_putb32 (byval as bfd_vma, byval as any ptr)
declare sub bfd_putl32 (byval as bfd_vma, byval as any ptr)
declare sub bfd_putb16 (byval as bfd_vma, byval as any ptr)
declare sub bfd_putl16 (byval as bfd_vma, byval as any ptr)
declare function bfd_get_bits (byval as any ptr, byval as integer, byval as bfd_boolean) as bfd_uint64_t
declare sub bfd_put_bits (byval as bfd_uint64_t, byval as any ptr, byval as integer, byval as bfd_boolean)
declare function bfd_section_already_linked_table_init () as bfd_boolean
declare sub bfd_section_already_linked_table_free ()
declare sub bfd_init_window (byval as bfd_window ptr)
declare sub bfd_free_window (byval as bfd_window ptr)
declare function bfd_get_file_window (byval as bfd ptr, byval as file_ptr, byval as bfd_size_type, byval as bfd_window ptr, byval as bfd_boolean) as bfd_boolean
declare sub bfd_init ()
declare function bfd_fopen (byval filename as zstring ptr, byval target as zstring ptr, byval mode as zstring ptr, byval fd as integer) as bfd ptr
declare function bfd_openr (byval filename as zstring ptr, byval target as zstring ptr) as bfd ptr
declare function bfd_fdopenr (byval filename as zstring ptr, byval target as zstring ptr, byval fd as integer) as bfd ptr
declare function bfd_openstreamr (byval as zstring ptr, byval as zstring ptr, byval as any ptr) as bfd ptr
declare function bfd_openr_iovec (byval filename as zstring ptr, byval target as zstring ptr, byval open as sub cdecl(byval as bfd ptr, byval as any ptr), byval open_closure as any ptr, byval pread as function cdecl(byval as bfd ptr, byval as any ptr, byval as any ptr, byval as file_ptr, byval as file_ptr) as file_ptr, byval close as function cdecl(byval as bfd ptr, byval as any ptr) as integer) as bfd ptr
declare function bfd_openw (byval filename as zstring ptr, byval target as zstring ptr) as bfd ptr
declare function bfd_close (byval abfd as bfd ptr) as bfd_boolean
declare function bfd_close_all_done (byval as bfd ptr) as bfd_boolean
declare function bfd_create (byval filename as zstring ptr, byval templ as bfd ptr) as bfd ptr
declare function bfd_make_writable (byval abfd as bfd ptr) as bfd_boolean
declare function bfd_make_readable (byval abfd as bfd ptr) as bfd_boolean
declare function bfd_calc_gnu_debuglink_crc32 (byval crc as uinteger, byval buf as ubyte ptr, byval len as bfd_size_type) as uinteger
declare function bfd_follow_gnu_debuglink (byval abfd as bfd ptr, byval dir as zstring ptr) as zstring ptr
declare function bfd_create_gnu_debuglink_section (byval abfd as bfd ptr, byval filename as zstring ptr) as bfd_section ptr
declare function bfd_fill_in_gnu_debuglink_section (byval abfd as bfd ptr, byval sect as bfd_section ptr, byval filename as zstring ptr) as bfd_boolean
declare function bfd_get_mtime (byval abfd as bfd ptr) as integer
declare function bfd_get_size (byval abfd as bfd ptr) as integer
declare sub bfd_section_list_clear (byval as bfd ptr)
declare function bfd_get_section_by_name (byval abfd as bfd ptr, byval name as zstring ptr) as asection ptr
declare function bfd_get_section_by_name_if (byval abfd as bfd ptr, byval name as zstring ptr, byval func as function cdecl(byval as bfd ptr, byval as asection ptr, byval as any ptr) as bfd_boolean, byval obj as any ptr) as asection ptr
declare function bfd_get_unique_section_name (byval abfd as bfd ptr, byval templat as zstring ptr, byval count as integer ptr) as zstring ptr
declare function bfd_make_section_old_way (byval abfd as bfd ptr, byval name as zstring ptr) as asection ptr
declare function bfd_make_section_anyway_with_flags (byval abfd as bfd ptr, byval name as zstring ptr, byval flags as flagword) as asection ptr
declare function bfd_make_section_anyway (byval abfd as bfd ptr, byval name as zstring ptr) as asection ptr
declare function bfd_make_section_with_flags (byval as bfd ptr, byval name as zstring ptr, byval flags as flagword) as asection ptr
declare function bfd_make_section (byval as bfd ptr, byval name as zstring ptr) as asection ptr
declare function bfd_set_section_flags (byval abfd as bfd ptr, byval sec as asection ptr, byval flags as flagword) as bfd_boolean
declare sub bfd_map_over_sections (byval abfd as bfd ptr, byval func as sub cdecl(byval as bfd ptr, byval as asection ptr, byval as any ptr), byval obj as any ptr)
declare function bfd_sections_find_if (byval abfd as bfd ptr, byval operation as function cdecl(byval as bfd ptr, byval as asection ptr, byval as any ptr) as bfd_boolean, byval obj as any ptr) as asection ptr
declare function bfd_set_section_size (byval abfd as bfd ptr, byval sec as asection ptr, byval val as bfd_size_type) as bfd_boolean
declare function bfd_set_section_contents (byval abfd as bfd ptr, byval section as asection ptr, byval data as any ptr, byval offset as file_ptr, byval count as bfd_size_type) as bfd_boolean
declare function bfd_get_section_contents (byval abfd as bfd ptr, byval section as asection ptr, byval location as any ptr, byval offset as file_ptr, byval count as bfd_size_type) as bfd_boolean
declare function bfd_malloc_and_get_section (byval abfd as bfd ptr, byval section as asection ptr, byval buf as bfd_byte ptr ptr) as bfd_boolean
declare function bfd_copy_private_section_data_ (byval ibfd as bfd ptr, byval isec as asection ptr, byval obfd as bfd ptr, byval osec as asection ptr) as bfd_boolean
declare function bfd_generic_is_group_section (byval as bfd ptr, byval sec as asection ptr) as bfd_boolean
declare function bfd_generic_discard_group (byval abfd as bfd ptr, byval group as asection ptr) as bfd_boolean
declare function bfd_check_overflow (byval how as complain_overflow, byval bitsize as uinteger, byval rightshift as uinteger, byval addrsize as uinteger, byval relocation as bfd_vma) as bfd_reloc_status_type
declare function bfd_perform_relocation (byval abfd as bfd ptr, byval reloc_entry as arelent ptr, byval data as any ptr, byval input_section as asection ptr, byval output_bfd as bfd ptr, byval error_message as byte ptr ptr) as bfd_reloc_status_type
declare function bfd_install_relocation (byval abfd as bfd ptr, byval reloc_entry as arelent ptr, byval data as any ptr, byval data_start as bfd_vma, byval input_section as asection ptr, byval error_message as byte ptr ptr) as bfd_reloc_status_type
declare function bfd_get_reloc_size (byval as reloc_howto_type ptr) as uinteger
declare function bfd_reloc_type_lookup (byval abfd as bfd ptr, byval code as bfd_reloc_code_real_type) as reloc_howto_type ptr
declare function bfd_get_reloc_code_name (byval code as bfd_reloc_code_real_type) as zstring ptr
declare function bfd_is_local_label (byval abfd as bfd ptr, byval sym as asymbol ptr) as bfd_boolean
declare function bfd_is_local_label_name_ (byval abfd as bfd ptr, byval name as zstring ptr) as bfd_boolean
declare function bfd_is_target_special_symbol_ (byval abfd as bfd ptr, byval sym as asymbol ptr) as bfd_boolean
declare function bfd_set_symtab (byval abfd as bfd ptr, byval location as asymbol ptr ptr, byval count as uinteger) as bfd_boolean
declare sub bfd_print_symbol_vandf (byval abfd as bfd ptr, byval file as any ptr, byval symbol as asymbol ptr)
declare function _bfd_generic_make_empty_symbol (byval as bfd ptr) as asymbol ptr
declare function bfd_decode_symclass (byval symbol as asymbol ptr) as integer
declare function bfd_is_undefined_symclass (byval symclass as integer) as bfd_boolean
declare sub bfd_symbol_info (byval symbol as asymbol ptr, byval ret as symbol_info ptr)
declare function bfd_copy_private_symbol_data_ (byval ibfd as bfd ptr, byval isym as asymbol ptr, byval obfd as bfd ptr, byval osym as asymbol ptr) as bfd_boolean
declare function bfd_get_error () as bfd_error_type
declare sub bfd_set_error (byval error_tag as bfd_error_type)
declare function bfd_errmsg (byval error_tag as bfd_error_type) as zstring ptr
declare sub bfd_perror (byval message as zstring ptr)
declare function bfd_set_error_handler (byval as bfd_error_handler_type) as bfd_error_handler_type
declare sub bfd_set_error_program_name (byval as zstring ptr)
declare function bfd_get_error_handler () as bfd_error_handler_type
declare function bfd_get_reloc_upper_bound (byval abfd as bfd ptr, byval sect as asection ptr) as integer
declare function bfd_canonicalize_reloc (byval abfd as bfd ptr, byval sec as asection ptr, byval loc as arelent ptr ptr, byval syms as asymbol ptr ptr) as integer
declare sub bfd_set_reloc (byval abfd as bfd ptr, byval sec as asection ptr, byval rel as arelent ptr ptr, byval count as uinteger)
declare function bfd_set_file_flags (byval abfd as bfd ptr, byval flags as flagword) as bfd_boolean
declare function bfd_get_arch_size (byval abfd as bfd ptr) as integer
declare function bfd_get_sign_extend_vma (byval abfd as bfd ptr) as integer
declare function bfd_set_start_address (byval abfd as bfd ptr, byval vma as bfd_vma) as bfd_boolean
declare function bfd_get_gp_size (byval abfd as bfd ptr) as uinteger
declare sub bfd_set_gp_size (byval abfd as bfd ptr, byval i as uinteger)
declare function bfd_scan_vma (byval string as zstring ptr, byval end as byte ptr ptr, byval base as integer) as bfd_vma
declare function bfd_copy_private_header_data_ (byval ibfd as bfd ptr, byval obfd as bfd ptr) as bfd_boolean
declare function bfd_copy_private_bfd_data_ (byval ibfd as bfd ptr, byval obfd as bfd ptr) as bfd_boolean
declare function bfd_merge_private_bfd_data_ (byval ibfd as bfd ptr, byval obfd as bfd ptr) as bfd_boolean
declare function bfd_set_private_flags_ (byval abfd as bfd ptr, byval flags as flagword) as bfd_boolean
declare function bfd_get_relocated_section_contents (byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_link_order ptr, byval as bfd_byte ptr, byval as bfd_boolean, byval as asymbol ptr ptr) as bfd_byte ptr
declare function bfd_alt_mach_code (byval abfd as bfd ptr, byval alternative as integer) as bfd_boolean
declare function bfd_preserve_save (byval as bfd ptr, byval as bfd_preserve ptr) as bfd_boolean
declare sub bfd_preserve_restore (byval as bfd ptr, byval as bfd_preserve ptr)
declare sub bfd_preserve_finish (byval as bfd ptr, byval as bfd_preserve ptr)
declare function bfd_get_next_mapent (byval abfd as bfd ptr, byval previous as symindex, byval sym as carsym ptr ptr) as symindex
declare function bfd_set_archive_head (byval output as bfd ptr, byval new_head as bfd ptr) as bfd_boolean
declare function bfd_openr_next_archived_file (byval archive as bfd ptr, byval previous as bfd ptr) as bfd ptr
declare function bfd_core_file_failing_command (byval abfd as bfd ptr) as zstring ptr
declare function bfd_core_file_failing_signal (byval abfd as bfd ptr) as integer
declare function core_file_matches_executable_p (byval core_bfd as bfd ptr, byval exec_bfd as bfd ptr) as bfd_boolean
declare function generic_core_file_matches_executable_p (byval core_bfd as bfd ptr, byval exec_bfd as bfd ptr) as bfd_boolean
declare function bfd_set_default_target (byval name as zstring ptr) as bfd_boolean
declare function bfd_find_target (byval target_name as zstring ptr, byval abfd as bfd ptr) as bfd_target ptr
declare function bfd_target_list () as zstring ptr ptr
declare function bfd_search_for_target (byval search_func as function cdecl(byval as bfd_target ptr, byval as any ptr) as integer, byval as any ptr) as bfd_target ptr
declare function bfd_check_format (byval abfd as bfd ptr, byval format as bfd_format) as bfd_boolean
declare function bfd_check_format_matches (byval abfd as bfd ptr, byval format as bfd_format, byval matching as byte ptr ptr ptr) as bfd_boolean
declare function bfd_set_format (byval abfd as bfd ptr, byval format as bfd_format) as bfd_boolean
declare function bfd_format_string (byval format as bfd_format) as zstring ptr
declare function bfd_link_split_section_ (byval abfd as bfd ptr, byval sec as asection ptr) as bfd_boolean
declare sub bfd_section_already_linked_ (byval abfd as bfd ptr, byval sec as asection ptr)
declare function bfd_simple_get_relocated_section_contents (byval abfd as bfd ptr, byval sec as asection ptr, byval outbuf as bfd_byte ptr, byval symbol_table as asymbol ptr ptr) as bfd_byte ptr
declare function bfd_ecoff_get_gp_value (byval abfd as bfd ptr) as bfd_vma
declare function bfd_ecoff_set_gp_value (byval abfd as bfd ptr, byval gp_value as bfd_vma) as bfd_boolean
declare function bfd_ecoff_set_regmasks (byval abfd as bfd ptr, byval gprmask as uinteger, byval fprmask as uinteger, byval cprmask as uinteger ptr) as bfd_boolean
declare function bfd_ecoff_debug_init (byval output_bfd as bfd ptr, byval output_debug as ecoff_debug_info ptr, byval output_swap as ecoff_debug_swap ptr, byval as bfd_link_info ptr) as any ptr
declare sub bfd_ecoff_debug_free (byval handle as any ptr, byval output_bfd as bfd ptr, byval output_debug as ecoff_debug_info ptr, byval output_swap as ecoff_debug_swap ptr, byval as bfd_link_info ptr)
declare function bfd_ecoff_debug_accumulate (byval handle as any ptr, byval output_bfd as bfd ptr, byval output_debug as ecoff_debug_info ptr, byval output_swap as ecoff_debug_swap ptr, byval input_bfd as bfd ptr, byval input_debug as ecoff_debug_info ptr, byval input_swap as ecoff_debug_swap ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_ecoff_debug_accumulate_other (byval handle as any ptr, byval output_bfd as bfd ptr, byval output_debug as ecoff_debug_info ptr, byval output_swap as ecoff_debug_swap ptr, byval input_bfd as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_ecoff_debug_externals (byval abfd as bfd ptr, byval debug as ecoff_debug_info ptr, byval swap as ecoff_debug_swap ptr, byval relocatable as bfd_boolean, byval get_extr as function cdecl(byval as bfd_symbol ptr, byval as ecoff_extr ptr) as bfd_boolean, byval set_index as sub cdecl(byval as bfd_symbol ptr, byval as bfd_size_type)) as bfd_boolean
declare function bfd_ecoff_debug_one_external (byval abfd as bfd ptr, byval debug as ecoff_debug_info ptr, byval swap as ecoff_debug_swap ptr, byval name as zstring ptr, byval esym as ecoff_extr ptr) as bfd_boolean
declare function bfd_ecoff_debug_size (byval abfd as bfd ptr, byval debug as ecoff_debug_info ptr, byval swap as ecoff_debug_swap ptr) as bfd_size_type
declare function bfd_ecoff_write_debug (byval abfd as bfd ptr, byval debug as ecoff_debug_info ptr, byval swap as ecoff_debug_swap ptr, byval where as file_ptr) as bfd_boolean
declare function bfd_ecoff_write_accumulated_debug (byval handle as any ptr, byval abfd as bfd ptr, byval debug as ecoff_debug_info ptr, byval swap as ecoff_debug_swap ptr, byval info as bfd_link_info ptr, byval where as file_ptr) as bfd_boolean
declare function bfd_elf_record_link_assignment (byval as bfd ptr, byval as bfd_link_info ptr, byval as zstring ptr, byval as bfd_boolean) as bfd_boolean
declare function bfd_elf_get_needed_list (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_link_needed_list ptr
declare function bfd_elf_get_bfd_needed_list (byval as bfd ptr, byval as bfd_link_needed_list ptr ptr) as bfd_boolean
declare function bfd_elf_size_dynamic_sections (byval as bfd ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as byte ptr ptr, byval as bfd_link_info ptr, byval as bfd_section ptr ptr, byval as bfd_elf_version_tree ptr) as bfd_boolean
declare function bfd_elf_size_dynsym_hash_dynstr (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare sub bfd_elf_set_dt_needed_name (byval as bfd ptr, byval as zstring ptr)
declare function bfd_elf_get_dt_soname (byval as bfd ptr) as zstring ptr
declare sub bfd_elf_set_dyn_lib_class (byval as bfd ptr, byval as integer)
declare function bfd_elf_get_dyn_lib_class (byval as bfd ptr) as integer
declare function bfd_elf_get_runpath_list (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_link_needed_list ptr
declare function bfd_elf_discard_info (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function _bfd_elf_default_action_discarded (byval as bfd_section ptr) as uinteger
declare function bfd_get_elf_phdr_upper_bound (byval abfd as bfd ptr) as integer
declare function bfd_get_elf_phdrs (byval abfd as bfd ptr, byval phdrs as any ptr) as integer
declare function bfd_elf_bfd_from_remote_memory (byval templ as bfd ptr, byval ehdr_vma as bfd_vma, byval loadbasep as bfd_vma ptr, byval target_read_memory as function cdecl(byval as bfd_vma, byval as bfd_byte ptr, byval as integer) as integer) as bfd ptr
declare function _bfd_elf_tls_setup (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_section ptr
declare sub _bfd_fix_excluded_sec_syms (byval as bfd ptr, byval as bfd_link_info ptr)
declare function bfd_m68k_mach_to_features (byval as integer) as uinteger
declare function bfd_m68k_features_to_mach (byval as uinteger) as integer
declare function bfd_m68k_elf32_create_embedded_relocs (byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_section ptr, byval as bfd_section ptr, byval as byte ptr ptr) as bfd_boolean
declare function bfd_bfin_elf32_create_embedded_relocs (byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_section ptr, byval as bfd_section ptr, byval as byte ptr ptr) as bfd_boolean
declare function bfd_sunos_get_needed_list (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_link_needed_list ptr
declare function bfd_sunos_record_link_assignment (byval as bfd ptr, byval as bfd_link_info ptr, byval as zstring ptr) as bfd_boolean
declare function bfd_sunos_size_dynamic_sections (byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_section ptr ptr, byval as bfd_section ptr ptr, byval as bfd_section ptr ptr) as bfd_boolean
declare function bfd_i386linux_size_dynamic_sections (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_m68klinux_size_dynamic_sections (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_sparclinux_size_dynamic_sections (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_xcoff_link_record_set (byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_link_hash_entry ptr, byval as bfd_size_type) as bfd_boolean
declare function bfd_xcoff_import_symbol (byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_link_hash_entry ptr, byval as bfd_vma, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as uinteger) as bfd_boolean
declare function bfd_xcoff_export_symbol (byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_link_hash_entry ptr) as bfd_boolean
declare function bfd_xcoff_link_count_reloc (byval as bfd ptr, byval as bfd_link_info ptr, byval as zstring ptr) as bfd_boolean
declare function bfd_xcoff_record_link_assignment (byval as bfd ptr, byval as bfd_link_info ptr, byval as zstring ptr) as bfd_boolean
declare function bfd_xcoff_size_dynamic_sections (byval as bfd ptr, byval as bfd_link_info ptr, byval as zstring ptr, byval as zstring ptr, byval as uinteger, byval as uinteger, byval as uinteger, byval as bfd_boolean, byval as integer, byval as bfd_boolean, byval as bfd_boolean, byval as bfd_section ptr ptr, byval as bfd_boolean) as bfd_boolean
declare function bfd_xcoff_link_generate_rtinit (byval as bfd ptr, byval as zstring ptr, byval as zstring ptr, byval as bfd_boolean) as bfd_boolean
declare function bfd_xcoff_ar_archive_set_magic (byval as bfd ptr, byval as zstring ptr) as bfd_boolean
declare function bfd_coff_get_syment (byval as bfd ptr, byval as bfd_symbol ptr, byval as internal_syment ptr) as bfd_boolean
declare function bfd_coff_get_auxent (byval as bfd ptr, byval as bfd_symbol ptr, byval as integer, byval as internal_auxent ptr) as bfd_boolean
declare function bfd_coff_set_symbol_class (byval as bfd ptr, byval as bfd_symbol ptr, byval as uinteger) as bfd_boolean
declare function bfd_m68k_coff_create_embedded_relocs (byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_section ptr, byval as bfd_section ptr, byval as byte ptr ptr) as bfd_boolean
declare function bfd_arm_allocate_interworking_sections (byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_arm_process_before_allocation (byval as bfd ptr, byval as bfd_link_info ptr, byval as integer) as bfd_boolean
declare function bfd_arm_get_bfd_for_interworking (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_arm_pe_allocate_interworking_sections (byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_arm_pe_process_before_allocation (byval as bfd ptr, byval as bfd_link_info ptr, byval as integer) as bfd_boolean
declare function bfd_arm_pe_get_bfd_for_interworking (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_elf32_arm_allocate_interworking_sections (byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_elf32_arm_process_before_allocation (byval as bfd ptr, byval as bfd_link_info ptr, byval as integer) as bfd_boolean
declare sub bfd_elf32_arm_set_target_relocs (byval as bfd_link_info ptr, byval as integer, byval as zstring ptr, byval as integer)
declare function bfd_elf32_arm_get_bfd_for_interworking (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_elf32_arm_add_glue_sections_to_bfd (byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_is_arm_mapping_symbol_name (byval name as zstring ptr) as bfd_boolean
declare function bfd_arm_merge_machines (byval as bfd ptr, byval as bfd ptr) as bfd_boolean
declare function bfd_arm_update_notes (byval as bfd ptr, byval as zstring ptr) as bfd_boolean
declare function bfd_arm_get_mach_from_notes (byval as bfd ptr, byval as zstring ptr) as uinteger
declare sub bfd_ticoff_set_section_load_page (byval as bfd_section ptr, byval as integer)
declare function bfd_ticoff_get_section_load_page (byval as bfd_section ptr) as integer
declare function bfd_h8300_pad_address (byval as bfd ptr, byval as bfd_vma) as bfd_vma
declare sub bfd_elf32_ia64_after_parse (byval as integer)
declare sub bfd_elf64_ia64_after_parse (byval as integer)
declare function bfd_coff_get_comdat_section (byval as bfd ptr, byval as bfd_section ptr) as coff_comdat_info ptr

end extern

#endif
