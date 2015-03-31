#define PUT_MODE_TRANS		0
#define PUT_MODE_PSET		1
#define PUT_MODE_PRESET		2
#define PUT_MODE_AND		3
#define PUT_MODE_OR		4
#define PUT_MODE_XOR		5
#define PUT_MODE_ALPHA		6
#define PUT_MODE_ADD		7
#define PUT_MODE_CUSTOM		8
#define PUT_MODE_BLEND		9
#define PUT_MODES		10

typedef FBCALL unsigned int (BLENDER)(unsigned int, unsigned int, void *);
typedef void (PUTTER)(unsigned char *, unsigned char *, int, int, int, int, int, BLENDER *, void *);

typedef struct FB_GFXCTX {
	int id;
	int work_page;
	unsigned char **line;
	int max_h;
	int target_bpp;
	int target_pitch;
	void *last_target;
	float last_x, last_y;
	union {
		struct {
			int view_x, view_y, view_w, view_h;
		};
		int view[4];
	};
	union {
		struct {
			int old_view_x, old_view_y, old_view_w, old_view_h;
		};
		int old_view[4];
	};
	float win_x, win_y, win_w, win_h;
	unsigned int fg_color, bg_color;
	void (*put_pixel)(struct FB_GFXCTX *ctx, int x, int y, unsigned int color);
	unsigned int (*get_pixel)(struct FB_GFXCTX *ctx, int x, int y);
	void *(*pixel_set)(void *dest, int color, size_t size);
	PUTTER **putter[PUT_MODES];
	int flags;
} FB_GFXCTX;
