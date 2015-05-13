#pragma once

#include once "tre.bi"

const TRE_REGEX_H = 1

#ifndef TRE_USE_SYSTEM_REGEX_H
	#define regcomp tre_regcomp
	#define regerror tre_regerror
	#define regexec tre_regexec
	#define regfree tre_regfree
#endif

#define regacomp tre_regacomp
#define regaexec tre_regaexec
#define regancomp tre_regancomp
#define reganexec tre_reganexec
#define regawncomp tre_regawncomp
#define regawnexec tre_regawnexec
#define regncomp tre_regncomp
#define regnexec tre_regnexec
#define regwcomp tre_regwcomp
#define regwexec tre_regwexec
#define regwncomp tre_regwncomp
#define regwnexec tre_regwnexec
