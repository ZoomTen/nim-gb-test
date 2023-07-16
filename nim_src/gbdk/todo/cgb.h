#define 	RGB(r, g, b)   ((uint16_t)((((b) & 0x1f) << 10) | ((uint16_t)(((g) & 0x1f) << 5)) | (((r) & 0x1f) << 0)))
 
#define 	RGB8(r, g, b)   (((uint16_t)((((b) >> 3) & 0x1f) << 10)) | ((uint16_t)((((g) >> 3) & 0x1f) << 5)) | (((r) >> 3) & 0x1f))
 
#define 	RGBHTML(RGB24bit)   (RGB8((((RGB24bit) >> 16) & 0xff), (((RGB24bit) >> 8) & 0xff), ((RGB24bit) & 0xff)))
 
#define 	RGB_RED   RGB(31, 0, 0)
 
#define 	RGB_DARKRED   RGB(15, 0, 0)
 
#define 	RGB_GREEN   RGB( 0, 31, 0)
 
#define 	RGB_DARKGREEN   RGB( 0, 15, 0)
 
#define 	RGB_BLUE   RGB( 0, 0, 31)
 
#define 	RGB_DARKBLUE   RGB( 0, 0, 15)
 
#define 	RGB_YELLOW   RGB(31, 31, 0)
 
#define 	RGB_DARKYELLOW   RGB(21, 21, 0)
 
#define 	RGB_CYAN   RGB( 0, 31, 31)
 
#define 	RGB_AQUA   RGB(28, 5, 22)
 
#define 	RGB_PINK   RGB(31, 0, 31)
 
#define 	RGB_PURPLE   RGB(21, 0, 21)
 
#define 	RGB_BLACK   RGB( 0, 0, 0)
 
#define 	RGB_DARKGRAY   RGB(10, 10, 10)
 
#define 	RGB_LIGHTGRAY   RGB(21, 21, 21)
 
#define 	RGB_WHITE   RGB(31, 31, 31)
 
#define 	RGB_LIGHTFLESH   RGB(30, 20, 15)
 
#define 	RGB_BROWN   RGB(10, 10, 0)
 
#define 	RGB_ORANGE   RGB(30, 20, 0)
 
#define 	RGB_TEAL   RGB(15, 15, 0)


Functions
void 	set_bkg_palette (uint8_t first_palette, uint8_t nb_palettes, palette_color_t *rgb_data) OLDCALL
 
void 	set_sprite_palette (uint8_t first_palette, uint8_t nb_palettes, palette_color_t *rgb_data) OLDCALL
 
void 	set_bkg_palette_entry (uint8_t palette, uint8_t entry, uint16_t rgb_data) OLDCALL
 
void 	set_sprite_palette_entry (uint8_t palette, uint8_t entry, uint16_t rgb_data) OLDCALL
 
void 	cpu_slow ()
 
void 	cpu_fast ()
 
void 	set_default_palette ()
 
void 	cgb_compatibility ()

typedef uint16_t 	palette_color_t
