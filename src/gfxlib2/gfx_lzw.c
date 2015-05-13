/* tiny LZW codec
 * Based on code by Mark Nelson, Dr. Dobb's Journal October, 1989
 */

#include "fb_gfx.h"
#include "fb_gfx_lzw.h"

LZW_ENTRY fb_lzw_entry[TABLE_SIZE];

static unsigned char *decode_string(unsigned char *buffer, int code)
{
	int index = 0;

	while (code > 255) {
		*buffer++ = fb_lzw_entry[code].value;
		code = fb_lzw_entry[code].prefix;
		if (index++ >= MAX_CODE - 1)
			return NULL;
	}
	*buffer = code;
	return buffer;
}

FBCALL int fb_hDecode
	(
		const unsigned char *in_buffer,
		ssize_t in_size,
		unsigned char *out_buffer,
		ssize_t *out_size
	)
{
	unsigned short new_code, old_code, next_code = 256;
	unsigned char *limit, decode_stack[MAX_CODE], *string, byte, bit = 0;

	/* Protecting the access to fb_lzw_entry */
	FB_LOCK( );

	INPUT_CODE(old_code);
	byte = old_code;
	*out_buffer++ = old_code;
	limit = out_buffer + *out_size;
	*out_size = 1;
	while (in_size > 0) {
		INPUT_CODE(new_code);
		if (new_code == MAX_CODE) {
			FB_UNLOCK( );
			return 0;
		}
		if (new_code >= next_code) {
			*decode_stack = byte;
			string = decode_string(decode_stack + 1, old_code);
		} else {
			string = decode_string(decode_stack, new_code);
		}
		if (!string) {
			FB_UNLOCK( );
			return -1;
		}
		byte = *string;
		while (string >= decode_stack) {
			if (out_buffer >= limit) {
				FB_UNLOCK( );
				return -1;
			}
			*out_buffer++ = *string--;
			(*out_size)++;
		}
		if (next_code < MAX_CODE) {
			fb_lzw_entry[next_code].prefix = old_code;
			fb_lzw_entry[next_code].value = byte;
			next_code++;
		}
		old_code = new_code;
	}

	FB_UNLOCK( );
	return -1;
}
