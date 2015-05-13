/* tiny LZW codec
 * Based on code by Mark Nelson, Dr. Dobb's Journal October, 1989
 */

#include "fb_gfx.h"
#include "fb_gfx_lzw.h"

static LZW_ENTRY *find_match(unsigned short prefix, unsigned char value)
{
	unsigned short index, offset = 1;

	index = ((unsigned short)value << 4) ^ prefix;
	if (index)
		offset = TABLE_SIZE - index;
	while (1) {
		if ((fb_lzw_entry[index].code == -1) ||
		    ((fb_lzw_entry[index].prefix == prefix) && (fb_lzw_entry[index].value == value)))
			return &fb_lzw_entry[index];
		index = (index + offset) % TABLE_SIZE;
	}
}

FBCALL int fb_hEncode
	(
		const unsigned char *in_buffer,
		ssize_t in_size,
		unsigned char *out_buffer,
		ssize_t *out_size
	)
{
	LZW_ENTRY *e;
	unsigned short string_code, next_code = 256;
	unsigned char bit = 0;
	ssize_t size;

	/* Protecting the access to fb_lzw_entry */
	FB_LOCK( );

	size = 0;
	fb_hMemSet(fb_lzw_entry, -1, sizeof(fb_lzw_entry));
	string_code = *in_buffer++;
	in_size--;
	while (in_size) {
		e = find_match(string_code, *in_buffer);
		if (e->code != -1)
			string_code = (unsigned short)e->code;
		else {
			if (next_code < MAX_CODE) {
				e->code = next_code++;
				e->prefix = string_code;
				e->value = *in_buffer;
			}
			OUTPUT_CODE(string_code);
			string_code = *in_buffer;
		}
		in_buffer++;
		in_size--;
	}
	OUTPUT_CODE(string_code);
	OUTPUT_CODE(MAX_CODE);
	if (bit)
		size++;
	*out_size = size;

	FB_UNLOCK( );
	return 0;
}
