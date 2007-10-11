// C wrapper (c) 2005 Daniel Verkamp
// based on mini.h (c) by Stefan Roettger
// http://www9.cs.fau.de/~roettger/download

#ifdef __cplusplus
extern "C" {
#endif

void mini_setminierrorhandler(void (*handler)(char *file,int line,int fatal));

void mini_setparams(float minr,
               float maxd,
               float ginf,
               int maxc);

void *mini_initmap(short int *image,void **d2map,
              int *size,float *dim,float scale,
              float cellaspect,
              short int (*getelevation)(int i,int j,int size,void *data),
              void *objref);

int mini_inittexmap(unsigned char *image,int *width,int *height);

void *mini_initfogmap(unsigned char *image,int size,
                 float lambda,float displace,float emission,
                 float fogatt,float fogR,float fogG,float fogB);

void mini_setmaps(void *map,void *d2map,
             int size,float dim,float scale,
             int texid,int width,int height,
             float cellaspect,
             float ox,float oy,float oz,
             void **d2map2,int *size2,
             void *fogmap,float lambda,float displace,
             float emission,float fogR,float fogG,float fogB);

void mini_drawlandscape(float res,
                   float ex,float ey,float ez,
                   float fx,float fy,float fz,
                   float dx,float dy,float dz,
                   float ux,float uy,float uz,
                   float fovy,float aspect,
                   float nearp,float farp,
                   void (*beginfan)(void),
                   void (*fanvertex)(float i,float y,float j),
                   void (*notify)(int i,int j,int s),
                   void (*prismedge)(float x,float y,float yf,float z),
                   int state);
                   
int mini_checklandscape(float ex,float ey,float ez,
                   float dx,float dy,float dz,
                   float ux,float uy,float uz,
                   float fovy,float aspect,
                   float nearp,float farp,
                   int phase);

float mini_getheight1(int i,int j);

void mini_getheight2(float s,float t,float *height);

float mini_getheight3(float x,float z);

float mini_getfogheight(float x,float z);

void mini_getnormal1(float s,float t,float *nx,float *nz);

void mini_getnormal2(float x,float z,float *nx,float *ny,float *nz);

int mini_getmaxsize(float res,float fx,float fy,float fz,float fovy);

void mini_deletemaps();

int mini_getS(void);

void mini_setS(int newval);

float mini_getDx(void);

void mini_setDx(float newval);

float mini_getSCALE(void);

void mini_setSCALE(float newval);

float mini_getDz(void);

void mini_setDz(float newval);

float mini_getOX(void);

void mini_setOX(float newval);

float mini_getOY(void);

void mini_setOY(float newval);

float mini_getOZ(void);

void mini_setOZ(float newval);

float mini_getX(const float i);

float getY(const float y);

float getZ(const float j);

#ifdef __cplusplus
} // extern "C"
#endif
