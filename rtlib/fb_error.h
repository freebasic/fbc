#ifndef __FB_ERROR_H__
#define __FB_ERROR_H__

typedef enum _FB_RTERROR {
	FB_RTERROR_OK = 0,
	FB_RTERROR_ILLEGALFUNCTIONCALL,
	FB_RTERROR_FILENOTFOUND,
	FB_RTERROR_FILEIO,
	FB_RTERROR_OUTOFMEM,
	FB_RTERROR_ILLEGALRESUME,
	FB_RTERROR_OUTOFBOUNDS,
	FB_RTERROR_NULLPTR,
	FB_RTERROR_NOPRIVILEDGES,
	FB_RTERROR_SIGINT,
	FB_RTERROR_SIGILL,
	FB_RTERROR_SIGFPE,
	FB_RTERROR_SIGSEGV,
	FB_RTERROR_SIGTERM,
	FB_RTERROR_SIGABRT,
	FB_RTERROR_SIGQUIT,
	FB_RTERROR_RETURNWITHOUTGOSUB,
	FB_RTERROR_ENDOFFILE,
	FB_RTERROR_MAX
} FB_RTERROR;

#define FB_ERROR_MESSAGE_SIZE		1024

typedef void (*FB_ERRHANDLER) (void);

typedef struct _FB_ERRORCTX {
    FB_ERRHANDLER  	handler;
    int				err_num;
    int				line_num;
    const char	   *mod_name;
    const char	   *fun_name;
    void		   *res_lbl;
    void		   *resnxt_lbl;
} FB_ERRORCTX;

       FB_ERRHANDLER fb_ErrorThrowEx    ( int errnum, int linenum, const char *fname,
       									  void *res_label, void *resnext_label );
FBCALL FB_ERRHANDLER fb_ErrorSetHandler ( FB_ERRHANDLER newhandler );
FBCALL int           fb_ErrorGetNum     ( void );
FBCALL int           fb_ErrorSetNum     ( int errnum );
       void         *fb_ErrorResume     ( void );
       void         *fb_ErrorResumeNext ( void );


#endif /* __FB_ERROR_H__ */
