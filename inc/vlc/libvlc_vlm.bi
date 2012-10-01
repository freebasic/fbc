/'*****************************************************************************
 * libvlc_vlm.h:  libvlc_* new external API
 *****************************************************************************
 * Copyright (C) 1998-2008 the VideoLAN team
 * $Id: f09dbe506ef2f21b2d894e9086d91e11672bf2b9 $
 *
 * Authors: Clément Stenac <zorglub@videolan.org>
 *          Jean-Paul Saman <jpsaman _at_ m2x _dot_ nl>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
 *****************************************************************************'/
 
#ifndef __libvlc_vlm_bi__
#define __libvlc_vlm_bi__

#define LIBVLC_VLM_H 1

/'*****************************************************************************
 * VLM
 *****************************************************************************'/

extern "C"

' * Release the vlm instance related to the given libvlc_instance_t
declare sub libvlc_vlm_release( p_instance as libvlc_instance_t ptr )

/'**
 * Add a broadcast, with one input.
 *
 * \param p_instance the instance
 * \param psz_name the name of the new broadcast
 * \param psz_input the input MRL
 * \param psz_output the output MRL (the parameter to the "sout" variable)
 * \param i_options number of additional options
 * \param ppsz_options additional options
 * \param b_enabled boolean for enabling the new broadcast
 * \param b_loop Should this broadcast be played in loop ?
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_add_broadcast (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval psz_input as zstring ptr, byval psz_output as zstring ptr, byval i_options as integer, byval ppsz_options as byte ptr ptr, byval b_enabled as integer, byval b_loop as integer) as integer

/'**
 * Add a vod, with one input.
 *
 * \param p_instance the instance
 * \param psz_name the name of the new vod media
 * \param psz_input the input MRL
 * \param i_options number of additional options
 * \param ppsz_options additional options
 * \param b_enabled boolean for enabling the new vod
 * \param psz_mux the muxer of the vod media
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_add_vod (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval psz_input as zstring ptr, byval i_options as integer, byval ppsz_options as byte ptr ptr, byval b_enabled as integer, byval psz_mux as zstring ptr) as integer

/'**
 * Delete a media (VOD or broadcast).
 *
 * \param p_instance the instance
 * \param psz_name the media to delete
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_del_media (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr) as integer

/'**
 * Enable or disable a media (VOD or broadcast).
 *
 * \param p_instance the instance
 * \param psz_name the media to work on
 * \param b_enabled the new status
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_set_enabled (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval b_enabled as integer) as integer

/'**
 * Set the output for a media.
 *
 * \param p_instance the instance
 * \param psz_name the media to work on
 * \param psz_output the output MRL (the parameter to the "sout" variable)
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_set_output (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval psz_output as zstring ptr) as integer

/'**
 * Set a media's input MRL. This will delete all existing inputs and
 * add the specified one.
 *
 * \param p_instance the instance
 * \param psz_name the media to work on
 * \param psz_input the input MRL
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_set_input (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval psz_input as zstring ptr) as integer

/'**
 * Add a media's input MRL. This will add the specified one.
 *
 * \param p_instance the instance
 * \param psz_name the media to work on
 * \param psz_input the input MRL
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_add_input (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval psz_input as zstring ptr) as integer

/'**
 * Set a media's loop status.
 *
 * \param p_instance the instance
 * \param psz_name the media to work on
 * \param b_loop the new status
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_set_loop (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval b_loop as integer) as integer

/'**
 * Set a media's vod muxer.
 *
 * \param p_instance the instance
 * \param psz_name the media to work on
 * \param psz_mux the new muxer
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_set_mux (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval psz_mux as zstring ptr) as integer

/'**
 * Edit the parameters of a media. This will delete all existing inputs and
 * add the specified one.
 *
 * \param p_instance the instance
 * \param psz_name the name of the new broadcast
 * \param psz_input the input MRL
 * \param psz_output the output MRL (the parameter to the "sout" variable)
 * \param i_options number of additional options
 * \param ppsz_options additional options
 * \param b_enabled boolean for enabling the new broadcast
 * \param b_loop Should this broadcast be played in loop ?
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_change_media (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval psz_input as zstring ptr, byval psz_output as zstring ptr, byval i_options as integer, byval ppsz_options as byte ptr ptr, byval b_enabled as integer, byval b_loop as integer) as integer

/'**
 * Play the named broadcast.
 *
 * \param p_instance the instance
 * \param psz_name the name of the broadcast
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_play_media (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr) as integer

/'**
 * Stop the named broadcast.
 *
 * \param p_instance the instance
 * \param psz_name the name of the broadcast
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_stop_media (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr) as integer

/'**
 * Pause the named broadcast.
 *
 * \param p_instance the instance
 * \param psz_name the name of the broadcast
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_pause_media (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr) as integer

/'**
 * Seek in the named broadcast.
 *
 * \param p_instance the instance
 * \param psz_name the name of the broadcast
 * \param f_percentage the percentage to seek to
 * \return 0 on success, -1 on error
 *'/
declare function libvlc_vlm_seek_media (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval f_percentage as single) as integer

/'**
 * Return information about the named media as a JSON
 * string representation.
 *
 * This function is mainly intended for debugging use,
 * if you want programmatic access to the state of
 * a vlm_media_instance_t, please use the corresponding
 * libvlc_vlm_get_media_instance_xxx -functions.
 * Currently there are no such functions available for
 * vlm_media_t though.
 *
 * \param p_instance the instance
 * \param psz_name the name of the media,
 *      if the name is an empty string, all media is described
 * \return string with information about named media, or NULL on error
 *'/
declare function libvlc_vlm_show_media (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr) as zstring ptr

/'**
 * Get vlm_media instance position by name or instance id
 *
 * \param p_instance a libvlc instance
 * \param psz_name name of vlm media instance
 * \param i_instance instance id
 * \return position as float or -1. on error
 *'/
declare function libvlc_vlm_get_media_instance_position (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval i_instance as integer) as single

/'**
 * Get vlm_media instance time by name or instance id
 *
 * \param p_instance a libvlc instance
 * \param psz_name name of vlm media instance
 * \param i_instance instance id
 * \return time as integer or -1 on error
 *'/
declare function libvlc_vlm_get_media_instance_time (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval i_instance as integer) as integer

/'**
 * Get vlm_media instance length by name or instance id
 *
 * \param p_instance a libvlc instance
 * \param psz_name name of vlm media instance
 * \param i_instance instance id
 * \return length of media item or -1 on error
 *'/
declare function libvlc_vlm_get_media_instance_length (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval i_instance as integer) as integer

/'**
 * Get vlm_media instance playback rate by name or instance id
 *
 * \param p_instance a libvlc instance
 * \param psz_name name of vlm media instance
 * \param i_instance instance id
 * \return playback rate or -1 on error
 *'/
declare function libvlc_vlm_get_media_instance_rate cdecl (byval p_instance as libvlc_instance_t ptr, byval psz_name as zstring ptr, byval i_instance as integer) as integer



end extern

#endif
