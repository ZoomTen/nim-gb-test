#define 	BCD_HEX(v)   ((BCD)(v))
 
#define 	MAKE_BCD(v)   BCD_HEX(0x ## v)

typedef uint32_t 	BCD

void 	uint2bcd (uint16_t i, BCD *value) OLDCALL
 
void 	bcd_add (BCD *sour, const BCD *value) OLDCALL
 
void 	bcd_sub (BCD *sour, const BCD *value) OLDCALL
 
uint8_t 	bcd2text (const BCD *bcd, uint8_t tile_offset, uint8_t *buffer) OLDCALL
