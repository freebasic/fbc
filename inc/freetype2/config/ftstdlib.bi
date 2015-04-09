'' FreeBASIC binding for freetype-2.5.5

#pragma once

#include once "crt/stddef.bi"
#include once "crt/limits.bi"
#include once "crt/string.bi"
#include once "crt/stdio.bi"
#include once "crt/stdlib.bi"
#include once "crt/setjmp.bi"
#include once "crt/stdarg.bi"

#define __FTSTDLIB_H__
#define ft_ptrdiff_t integer
#define FT_CHAR_BIT CHAR_BIT
#define FT_USHORT_MAX USHRT_MAX
#define FT_INT_MAX INT_MAX
#define FT_INT_MIN INT_MIN
#define FT_UINT_MAX UINT_MAX
#define FT_ULONG_MAX ULONG_MAX
#define ft_memchr memchr
#define ft_memcmp memcmp
#define ft_memcpy memcpy
#define ft_memmove memmove
#define ft_memset memset
#define ft_strcat strcat
#define ft_strcmp strcmp
#define ft_strcpy strcpy
#define ft_strlen strlen
#define ft_strncmp strncmp
#define ft_strncpy strncpy
#define ft_strrchr strrchr
#define ft_strstr strstr
#define FT_FILE FILE
#define ft_fclose fclose
#define ft_fopen fopen
#define ft_fread fread
#define ft_fseek fseek
#define ft_ftell ftell
#define ft_sprintf sprintf
#define ft_qsort qsort
#define ft_scalloc calloc
#define ft_sfree free
#define ft_smalloc malloc
#define ft_srealloc realloc
#define ft_atol atol
#define ft_labs labs
#define ft_jmp_buf jmp_buf
#define ft_longjmp longjmp
#define ft_setjmp(b) setjmp(*cptr(ft_jmp_buf ptr, @(b)))
