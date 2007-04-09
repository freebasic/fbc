/*
 *  libfb - FreeBASIC's runtime library
 *  Copyright (C) 2004-2007 The FreeBASIC development team.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * cpudetect_x86.s -- x86 processor identification
 *
 * chng: jul/2005 written [DrV]
 *
 */

	.intel_syntax noprefix

.section .data
detected_cpu: .int 0  /* bytes 0-2: low 24 bits of feature flags (CPUID eax = 1, edx) */
                      /* byte    3: cpu family (03 = 386, 04 = 486, 05 = 586, 06 = 686) */

.section .text
/*:::::*/
/* int fb_CpuDetect(void); */
.globl _fb_CpuDetect
.globl fb_CpuDetect
_fb_CpuDetect:
fb_CpuDetect:

	mov eax, [detected_cpu]
	or eax, eax
	jz detect
	
	ret /* already detected (return detected_cpu) */
	
detect:	
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi
	
	/* check for CPUID availability (try toggling bit 21 of EFLAGS) */
	pushfd
	pop eax
	mov edx, eax
	xor eax, 0x200000
	push eax
	popfd
	pushfd
	pop eax
	xor eax, edx
	jnz cpuid_ok

	/* no CPUID; assume 386 and check if 486 (try toggling bit 18 (AC) of EFLAGS) */
	mov ebx, 0x03000000
	mov ecx, esp
	and esp, 0xFFFFFFFB /* round ESP down to a multiple of 4 (must be aligned if AC becomes enabled) */
	pushfd
	pop eax
	mov edx, eax
	xor eax, 0x40000
	push eax
	popfd
	pushfd
	pop eax
	xor eax, edx
	mov esp, ecx
	jz cpu486_not_found

	mov ebx, 0x04000000

cpu486_not_found:
	push edx
	popf
	mov eax, ebx
	jmp cpudetect_exit
	
cpuid_ok:
	mov eax, 1
	cpuid
	mov ebx, eax
	shl eax, 16
	and eax, 0x0F000000 /* family in high byte */
	cmp eax, 0x0F000000
	jne no_extended_family
	shl ebx, 12
	and ebx, 0xF0000000 /* add extended family if available */
	add eax, ebx

no_extended_family:
	and edx, 0x00FFFFFF /* low 24 bits of feature flags */
	or eax, edx
	
cpudetect_exit:
	
	mov [detected_cpu], eax
	
	pop	esi
	pop	edi
	pop	ebx
	pop	ebp
	ret
