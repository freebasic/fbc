/'*************************************************************************/
/*                                                                       */
/*                  Language Technologies Institute                      */
/*                     Carnegie Mellon University                        */
/*                        Copyright (c) 1999                             */
/*                        All Rights Reserved.                           */
/*                                                                       */
/*  Permission is hereby granted, free of charge, to use and distribute  */
/*  this software and its documentation without restriction, including   */
/*  without limitation the rights to use, copy, modify, merge, publish,  */
/*  distribute, sublicense, and/or sell copies of this work, and to      */
/*  permit persons to whom this work is furnished to do so, subject to   */
/*  the following conditions:                                            */
/*   1. The code must retain the above copyright notice, this list of    */
/*      conditions and the following disclaimer.                         */
/*   2. Any modifications must be clearly marked as such.                */
/*   3. Original authors' name_s are not deleted.                         */
/*   4. The authors' name_s are not used to endorse or promote products   */
/*      derived from this software without specific prior written        */
/*      permission.                                                      */
/*                                                                       */
/*  CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK         */
/*  DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING      */
/*  ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   */
/*  SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE      */
/*  FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    */
/*  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   */
/*  AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          */
/*  ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       */
/*  THIS SOFTWARE.                                                       */
/*                                                                       */
/*************************************************************************/
/*             Author:  Alan W Black (awb@cs.cmu.edu)                    */
/*               Date:  December 1999                                    */
/*************************************************************************/
/*                                                                       */
/*  Light weight run-time speech synthesis system, public API            */
/*                                                                       */
/*************************************************************************'/

#ifndef __flite_bi__
#define __flite_bi__

#include once "flite/cst_string.bi"
#include once "flite/cst_regex.bi"
#include once "flite/cst_val.bi"
#include once "flite/cst_features.bi"
#include once "flite/cst_item.bi"
#include once "flite/cst_relation.bi"
#include once "flite/cst_utterance.bi"
#include once "flite/cst_wave.bi"
#include once "flite/cst_track.bi"

#include once "flite/cst_cart.bi"
#include once "flite/cst_phoneset.bi"
#include once "flite/cst_voice.bi"
#include once "flite/cst_audio.bi"

#include once "flite/cst_utt_utils.bi"
#include once "flite/cst_lexicon.bi"
#include once "flite/cst_synth.bi"
#include once "flite/cst_units.bi"
#include once "flite/cst_tokenstream.bi"

extern "C"

extern flite_voice_list as cst_val ptr

'/* Public functions */
declare function flite_init () as integer

'/* General top level functions */
declare function flite_voice_select (byval name_ as const zstring ptr) as cst_voice ptr
declare function flite_file_to_speech (byval filename_ as const zstring ptr, byval voice as cst_voice ptr, byval outtype as const zstring ptr) as single
declare function flite_text_to_speech (byval text as const zstring ptr, byval voice as cst_voice ptr, byval outtype as const zstring ptr) as single
declare function flite_phones_to_speech (byval text as const zstring ptr, byval voice as cst_voice ptr, byval outtype as const zstring ptr) as single
declare function flite_ssml_to_speech (byval filename_ as const zstring ptr, byval voice as cst_voice ptr, byval outtype as const zstring ptr) as single
declare function flite_voice_add_lex_addenda (byval v as cst_voice ptr, byval lexfile as const cst_string ptr) as integer

'/* Lower lever user functions */
declare function flite_text_to_wave (byval text as const zstring ptr, byval voice as cst_voice ptr) as cst_wave ptr
declare function flite_synth_text (byval text as const zstring ptr, byval voice as cst_voice ptr) as cst_utterance ptr
declare function flite_synth_phones (byval phones as const zstring ptr, byval voice as cst_voice ptr) as cst_utterance ptr
declare function flite_do_synth (byval u as cst_utterance ptr, byval voice as cst_voice ptr, byval synth as cst_uttfunc) as cst_utterance ptr
declare function flite_process_output (byval u as cst_utterance ptr, byval const outtype as zstring ptr, byval append as integer) as single

'/* flite public export wrappers for features access */
declare function flite_get_param_int (byval f as cst_features ptr, byval name_ as zstring ptr, byval def as integer) as integer
declare function flite_get_param_float (byval f as cst_features ptr, byval name_ as const zstring ptr, byval def as single) as single
declare function flite_get_param_string (byval f as cst_features ptr, byval name_ as const zstring ptr, byval def as zstring ptr) as const zstring ptr
declare function flite_get_param_val (byval f as cst_features ptr, byval name_ as const zstring ptr, byval def as cst_val ptr) as cst_val ptr
declare sub flite_feat_set_int (byval f as cst_features ptr, byval name_ as const zstring ptr, byval v as integer)
declare sub flite_feat_set_float (byval f as cst_features ptr, byval name_ as const zstring ptr, byval v as single)
declare sub flite_feat_set_string (byval f as cst_features ptr, byval name_ as const zstring ptr, byval v as zstring ptr)
declare sub flite_feat_set (byval f as cst_features ptr, byval name_ as const zstring ptr, byval v as cst_val ptr)
declare function flite_feat_remove (byval f as cst_features ptr, byval name_ as const zstring ptr) as integer

declare function flite_ffeature_string (byval item as cst_item ptr, byval featpath as const zstring ptr) as const zstring ptr
declare function flite_ffeature_int (byval item as cst_item ptr, byval featpath as const zstring ptr) as integer
declare function flite_ffeature_float (byval item as cst_item ptr, byval featpath as const zstring ptr) as single
declare function flite_ffeature (byval item as cst_item ptr, byval featpath as const zstring ptr) as const cst_val ptr
declare function flite_path_to_item (byval item as cst_item ptr, byval featpath as const zstring ptr) as cst_item ptr

end extern

#endif

