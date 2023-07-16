#define 	GRAPHICS_WIDTH   160
 
#define 	GRAPHICS_HEIGHT   144
 
#define 	SOLID   0x00 /* Overwrites the existing pixels */
 
#define 	OR   0x01 /* Performs a logical OR */
 
#define 	XOR   0x02 /* Performs a logical XOR */
 
#define 	AND   0x03 /* Performs a logical AND */
 
#define 	WHITE   0
 
#define 	LTGREY   1
 
#define 	DKGREY   2
 
#define 	BLACK   3
 
#define 	M_NOFILL   0
 
#define 	M_FILL   1
 
#define 	SIGNED   1
 
#define 	UNSIGNED   0

void 	gprint (char *str) NONBANKED
 
void 	gprintln (int16_t number, int8_t radix, int8_t signed_value) NONBANKED
 
void 	gprintn (int8_t number, int8_t radix, int8_t signed_value) NONBANKED
 
int8_t 	gprintf (char *fmt,...) NONBANKED
 
void 	plot (uint8_t x, uint8_t y, uint8_t colour, uint8_t mode) OLDCALL
 
void 	plot_point (uint8_t x, uint8_t y) OLDCALL
 
void 	switch_data (uint8_t x, uint8_t y, uint8_t *src, uint8_t *dst) OLDCALL
 
void 	draw_image (uint8_t *data) OLDCALL
 
void 	line (uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2) OLDCALL
 
void 	box (uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2, uint8_t style) OLDCALL
 
void 	circle (uint8_t x, uint8_t y, uint8_t radius, uint8_t style) OLDCALL
 
uint8_t 	getpix (uint8_t x, uint8_t y) OLDCALL
 
void 	wrtchr (char chr) OLDCALL
 
void 	gotogxy (uint8_t x, uint8_t y) OLDCALL
 
void 	color (uint8_t forecolor, uint8_t backcolor, uint8_t mode) OLDCALL
