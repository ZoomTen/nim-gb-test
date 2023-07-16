struct  	metasprite_t

#define 	metasprite_end   -128
 
#define 	METASPR_ITEM(dy, dx, dt, a)   {(dy),(dx),(dt),(a)}
 
#define 	METASPR_TERM   {metasprite_end}

void 	hide_sprites_range (UINT8 from, UINT8 to) OLDCALL PRESERVES_REGS(b
 
uint8_t 	move_metasprite (const metasprite_t *metasprite, uint8_t base_tile, uint8_t base_sprite, uint8_t x, uint8_t y)
 
uint8_t 	move_metasprite_vflip (const metasprite_t *metasprite, uint8_t base_tile, uint8_t base_sprite, uint8_t x, uint8_t y)
 
uint8_t 	move_metasprite_hflip (const metasprite_t *metasprite, uint8_t base_tile, uint8_t base_sprite, uint8_t x, uint8_t y)
 
uint8_t 	move_metasprite_hvflip (const metasprite_t *metasprite, uint8_t base_tile, uint8_t base_sprite, uint8_t x, uint8_t y)
 
void 	hide_metasprite (const metasprite_t *metasprite, uint8_t base_sprite)

const void * 	__current_metasprite
 
uint8_t 	__current_base_tile
 
uint8_t 	__render_shadow_OAM
 
void 	c
