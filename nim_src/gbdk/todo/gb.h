#define 	NINTENDO
 
#define 	GAMEBOY
 
#define 	J_UP   0x04U
 
#define 	J_DOWN   0x08U
 
#define 	J_LEFT   0x02U
 
#define 	J_RIGHT   0x01U
 
#define 	J_A   0x10U
 
#define 	J_B   0x20U
 
#define 	J_SELECT   0x40U
 
#define 	J_START   0x80U
 
#define 	M_DRAWING   0x01U
 
#define 	M_TEXT_OUT   0x02U
 
#define 	M_TEXT_INOUT   0x03U
 
#define 	M_NO_SCROLL   0x04U
 
#define 	M_NO_INTERP   0x08U
 
#define 	S_PALETTE   0x10U
 
#define 	S_FLIPX   0x20U
 
#define 	S_FLIPY   0x40U
 
#define 	S_PRIORITY   0x80U
 
//#define 	EMPTY_IFLAG   0x00U
 
//#define 	VBL_IFLAG   0x01U
 
//#define 	LCD_IFLAG   0x02U
 
//#define 	TIM_IFLAG   0x04U
 
//#define 	SIO_IFLAG   0x08U
 
//#define 	JOY_IFLAG   0x10U
 
#define 	DMG_BLACK   0x03
 
#define 	DMG_DARK_GRAY   0x02
 
#define 	DMG_LITE_GRAY   0x01
 
#define 	DMG_WHITE   0x00
 
#define 	DMG_PALETTE(C0, C1, C2, C3)   ((uint8_t)((((C3) & 0x03) << 6) | (((C2) & 0x03) << 4) | (((C1) & 0x03) << 2) | ((C0) & 0x03)))
 
#define 	SCREENWIDTH   DEVICE_SCREEN_PX_WIDTH
 
#define 	SCREENHEIGHT   DEVICE_SCREEN_PX_HEIGHT
 
#define 	MINWNDPOSX   0x07U
 
#define 	MINWNDPOSY   0x00U
 
#define 	MAXWNDPOSX   0xA6U
 
#define 	MAXWNDPOSY   0x8FU
 
#define 	DMG_TYPE   0x01
 
#define 	MGB_TYPE   0xFF
 
#define 	CGB_TYPE   0x11
 
#define 	GBA_NOT_DETECTED   0x00
 
#define 	GBA_DETECTED   0x01
 
#define 	DEVICE_SUPPORTS_COLOR   (_cpu == CGB_TYPE)
 
#define 	IO_IDLE   0x00U
 
#define 	IO_SENDING   0x01U
 
#define 	IO_RECEIVING   0x02U
 
#define 	IO_ERROR   0x04U
 
#define 	CURRENT_BANK   _current_bank
 
#define 	BANK(VARNAME)   ( (uint8_t) & __bank_ ## VARNAME )
 
#define 	BANKREF(VARNAME)
 
#define 	BANKREF_EXTERN(VARNAME)   extern const void __bank_ ## VARNAME;
 
#define 	SWITCH_ROM_MEGADUCK(b)   _current_bank = (b), *(volatile uint8_t *)0x0001 = (b)
 
#define 	SWITCH_ROM_MBC1(b)   _current_bank = (b), *(volatile uint8_t *)0x2000 = (b)
 
#define 	SWITCH_ROM   SWITCH_ROM_MBC1
 
#define 	SWITCH_RAM_MBC1(b)   *(volatile uint8_t *)0x4000 = (b)
 
#define 	SWITCH_RAM   SWITCH_RAM_MBC1
 
#define 	ENABLE_RAM_MBC1   *(volatile uint8_t *)0x0000 = 0x0A
 
#define 	ENABLE_RAM   ENABLE_RAM_MBC1
 
#define 	DISABLE_RAM_MBC1   *(volatile uint8_t *)0x0000 = 0x00
 
#define 	DISABLE_RAM   DISABLE_RAM_MBC1
 
#define 	SWITCH_16_8_MODE_MBC1   *(volatile uint8_t *)0x6000 = 0x00
 
#define 	SWITCH_4_32_MODE_MBC1   *(volatile uint8_t *)0x6000 = 0x01
 
#define 	SWITCH_ROM_MBC5(b)
 
#define 	SWITCH_ROM_MBC5_8M(b)
 
#define 	SWITCH_RAM_MBC5(b)   *(volatile uint8_t *)0x4000 = (b)
 
#define 	ENABLE_RAM_MBC5   *(volatile uint8_t *)0x0000 = 0x0A
 
#define 	DISABLE_RAM_MBC5   *(volatile uint8_t *)0x0000 = 0x00
 
#define 	DISPLAY_ON   LCDC_REG|=LCDCF_ON
 
#define 	DISPLAY_OFF   display_off();
 
#define 	HIDE_LEFT_COLUMN
 
#define 	SHOW_LEFT_COLUMN
 
#define 	SHOW_BKG   LCDC_REG|=LCDCF_BGON
 
#define 	HIDE_BKG   LCDC_REG&=~LCDCF_BGON
 
#define 	SHOW_WIN   LCDC_REG|=LCDCF_WINON
 
#define 	HIDE_WIN   LCDC_REG&=~LCDCF_WINON
 
#define 	SHOW_SPRITES   LCDC_REG|=LCDCF_OBJON
 
#define 	HIDE_SPRITES   LCDC_REG&=~LCDCF_OBJON
 
#define 	SPRITES_8x16   LCDC_REG|=LCDCF_OBJ16
 
#define 	SPRITES_8x8   LCDC_REG&=~LCDCF_OBJ16
 
#define 	COMPAT_PALETTE(C0, C1, C2, C3)   ((uint8_t)(((C3) << 6) | ((C2) << 4) | ((C1) << 2) | (C0)))
 
#define 	set_bkg_2bpp_data   set_bkg_data
 
#define 	set_tile_map   set_bkg_tiles
 
#define 	set_tile_submap   set_bkg_submap
 
#define 	set_tile_xy   set_bkg_tile_xy
 
#define 	set_sprite_2bpp_data   set_sprite_data
 
#define 	DISABLE_OAM_DMA   _shadow_OAM_base = 0
 
#define 	DISABLE_VBL_TRANSFER   DISABLE_OAM_DMA
 
#define 	ENABLE_OAM_DMA   _shadow_OAM_base = (uint8_t)((uint16_t)&shadow_OAM >> 8)
 
#define 	ENABLE_VBL_TRANSFER   ENABLE_OAM_DMA
 
#define 	MAX_HARDWARE_SPRITES   40
 
#define 	fill_rect   fill_bkg_rect
 

// Interrupts:

void 	remove_VBL (int_handler h) OLDCALL
 
void 	remove_LCD (int_handler h) OLDCALL
 
void 	remove_TIM (int_handler h) OLDCALL
 
void 	remove_SIO (int_handler h) OLDCALL
 
void 	remove_JOY (int_handler h) OLDCALL
 
void 	add_VBL (int_handler h) OLDCALL
 
void 	add_LCD (int_handler h) OLDCALL
 
void 	add_TIM (int_handler h) OLDCALL
 
void 	add_low_priority_TIM (int_handler h) OLDCALL
 
void 	add_SIO (int_handler h) OLDCALL
 
void 	add_JOY (int_handler h) OLDCALL
 
void 	nowait_int_handler ()
 
void 	wait_int_handler ()
 
void 	enable_interrupts () PRESERVES_REGS(a
 
void 	disable_interrupts () PRESERVES_REGS(a

uint8_t 	cancel_pending_interrupts ()
 
// void 	set_interrupts (uint8_t flags) OLDCALL PRESERVES_REGS(b
 
// void 	wait_vbl_done () PRESERVES_REGS(b
 
// Drawing:
 
void 	mode (uint8_t m) OLDCALL
 
uint8_t 	get_mode () OLDCALL PRESERVES_REGS(b

// Serial:

void 	send_byte ()
 
void 	receive_byte ()

// Misc:

// void 	delay (uint16_t d) PRESERVES_REGS(h
 
// void 	reset ()

// Copy:
 
// void 	hiramcpy (uint8_t dst, const void *src, uint8_t n) OLDCALL PRESERVES_REGS(b

 
// Joypad:

// uint8_t 	joypad () PRESERVES_REGS(b
 
// uint8_t 	waitpad (uint8_t mask) PRESERVES_REGS(b
 
// void 	waitpadup () PRESERVES_REGS(a
 
// uint8_t 	joypad_init (uint8_t npads, joypads_t *joypads) OLDCALL
 
// void 	joypad_ex (joypads_t *joypads) PRESERVES_REGS(b

// VRAM:
 
void 	display_off () PRESERVES_REGS(b
 
void 	refresh_OAM () PRESERVES_REGS(b
 
void 	set_vram_byte (uint8_t *addr, uint8_t v) OLDCALL PRESERVES_REGS(b
 
uint8_t 	get_vram_byte (uint8_t *addr) PRESERVES_REGS(b
 
// uint8_t * 	get_bkg_xy_addr (uint8_t x, uint8_t y) OLDCALL PRESERVES_REGS(b
 
void 	set_2bpp_palette (uint16_t palette)
 
void 	set_1bpp_colors_ex (uint8_t fgcolor, uint8_t bgcolor, uint8_t mode) OLDCALL
 
void 	set_1bpp_colors (uint8_t fgcolor, uint8_t bgcolor)
 
// void 	set_bkg_data (uint8_t first_tile, uint8_t nb_tiles, const uint8_t *data) OLDCALL PRESERVES_REGS(b
 
void 	set_bkg_1bpp_data (uint8_t first_tile, uint8_t nb_tiles, const uint8_t *data) OLDCALL PRESERVES_REGS(b
 
void 	get_bkg_data (uint8_t first_tile, uint8_t nb_tiles, uint8_t *data) OLDCALL PRESERVES_REGS(b
 
// void 	set_bkg_tiles (uint8_t x, uint8_t y, uint8_t w, uint8_t h, const uint8_t *tiles) OLDCALL PRESERVES_REGS(b
 
//void 	set_bkg_based_tiles (uint8_t x, uint8_t y, uint8_t w, uint8_t h, const uint8_t *tiles, uint8_t base_tile)
 
void 	set_bkg_submap (uint8_t x, uint8_t y, uint8_t w, uint8_t h, const uint8_t *map, uint8_t map_w) OLDCALL
 
void 	set_bkg_based_submap (uint8_t x, uint8_t y, uint8_t w, uint8_t h, const uint8_t *map, uint8_t map_w, uint8_t base_tile)
 
void 	get_bkg_tiles (uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t *tiles) OLDCALL PRESERVES_REGS(b
 
// uint8_t * 	set_bkg_tile_xy (uint8_t x, uint8_t y, uint8_t t) OLDCALL PRESERVES_REGS(b
 
// uint8_t 	get_bkg_tile_xy (uint8_t x, uint8_t y) OLDCALL PRESERVES_REGS(b
 
void 	move_bkg (uint8_t x, uint8_t y)
 
void 	scroll_bkg (int8_t x, int8_t y)
 
uint8_t * 	get_win_xy_addr (uint8_t x, uint8_t y) OLDCALL PRESERVES_REGS(b
 
// void 	set_win_data (uint8_t first_tile, uint8_t nb_tiles, const uint8_t *data) OLDCALL PRESERVES_REGS(b
 
void 	set_win_1bpp_data (uint8_t first_tile, uint8_t nb_tiles, const uint8_t *data) OLDCALL PRESERVES_REGS(b
 
void 	get_win_data (uint8_t first_tile, uint8_t nb_tiles, uint8_t *data) OLDCALL PRESERVES_REGS(b
 
// void 	set_win_tiles (uint8_t x, uint8_t y, uint8_t w, uint8_t h, const uint8_t *tiles) OLDCALL PRESERVES_REGS(b
 
void 	set_win_based_tiles (uint8_t x, uint8_t y, uint8_t w, uint8_t h, const uint8_t *tiles, uint8_t base_tile)
 
void 	set_win_submap (uint8_t x, uint8_t y, uint8_t w, uint8_t h, const uint8_t *map, uint8_t map_w) OLDCALL
 
void 	set_win_based_submap (uint8_t x, uint8_t y, uint8_t w, uint8_t h, const uint8_t *map, uint8_t map_w, uint8_t base_tile)
 
void 	get_win_tiles (uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t *tiles) OLDCALL PRESERVES_REGS(b
 
uint8_t * 	set_win_tile_xy (uint8_t x, uint8_t y, uint8_t t) OLDCALL PRESERVES_REGS(b
 
uint8_t 	get_win_tile_xy (uint8_t x, uint8_t y) OLDCALL PRESERVES_REGS(b
 
void 	move_win (uint8_t x, uint8_t y)
 
void 	scroll_win (int8_t x, int8_t y)
 
// void 	set_sprite_data (uint8_t first_tile, uint8_t nb_tiles, const uint8_t *data) OLDCALL PRESERVES_REGS(b
 
void 	set_sprite_1bpp_data (uint8_t first_tile, uint8_t nb_tiles, const uint8_t *data) OLDCALL PRESERVES_REGS(b
 
void 	get_sprite_data (uint8_t first_tile, uint8_t nb_tiles, uint8_t *data) OLDCALL PRESERVES_REGS(b
 
void 	SET_SHADOW_OAM_ADDRESS (void *address)
 
// void 	set_sprite_tile (uint8_t nb, uint8_t tile)
 
uint8_t 	get_sprite_tile (uint8_t nb)
 
void 	set_sprite_prop (uint8_t nb, uint8_t prop)
 
uint8_t 	get_sprite_prop (uint8_t nb)
 
// void 	move_sprite (uint8_t nb, uint8_t x, uint8_t y)
 
void 	scroll_sprite (uint8_t nb, int8_t x, int8_t y)
 
void 	hide_sprite (uint8_t nb)
 
void 	set_data (uint8_t *vram_addr, const uint8_t *data, uint16_t len) OLDCALL PRESERVES_REGS(b
 
void 	get_data (uint8_t *data, uint8_t *vram_addr, uint16_t len) OLDCALL PRESERVES_REGS(b
 
void 	vmemcpy (uint8_t *dest, uint8_t *sour, uint16_t len) OLDCALL PRESERVES_REGS(b
 
void 	set_tiles (uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t *vram_addr, const uint8_t *tiles) OLDCALL
 
void 	set_tile_data (uint8_t first_tile, uint8_t nb_tiles, const uint8_t *data, uint8_t base) OLDCALL PRESERVES_REGS(b
 
void 	get_tiles (uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t *vram_addr, uint8_t *tiles) OLDCALL
 
void 	set_native_tile_data (uint16_t first_tile, uint8_t nb_tiles, const uint8_t *data)
 
void 	init_win (uint8_t c) OLDCALL PRESERVES_REGS(b
 
void 	init_bkg (uint8_t c) OLDCALL PRESERVES_REGS(b
 
void 	vmemset (void *s, uint8_t c, size_t n) OLDCALL PRESERVES_REGS(b
 
// void 	fill_bkg_rect (uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t tile) OLDCALL PRESERVES_REGS(b
 
// void 	fill_win_rect (uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t tile) OLDCALL PRESERVES_REGS(b
