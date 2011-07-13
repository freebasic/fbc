#include "fb_gfx.h"

static unsigned char internal_data[];
static unsigned char inited = FALSE;

// Pull in the auto-generated data...
#include "libfb_gfx_data.h"

static unsigned char internal_data[DATA_SIZE];

void fb_hSetupData()
{
    int size = DATA_SIZE;

    if (inited)
        return;

    fb_hDecode(compressed_data, sizeof(compressed_data), internal_data, &size);

    inited = TRUE;
}
