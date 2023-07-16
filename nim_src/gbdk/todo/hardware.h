#define 	__BYTES   extern UBYTE
 
#define 	__BYTE_REG   extern volatile UBYTE
 
#define 	__REG   extern volatile SFR
 
#define 	rP1   P1_REG
 
#define 	P1F_5   0b00100000
 
#define 	P1F_4   0b00010000
 
#define 	P1F_3   0b00001000
 
#define 	P1F_2   0b00000100
 
#define 	P1F_1   0b00000010
 
#define 	P1F_0   0b00000001
 
#define 	P1F_GET_DPAD   P1F_5
 
#define 	P1F_GET_BTN   P1F_4
 
#define 	P1F_GET_NONE   (P1F_4 | P1F_5)
 
#define 	rSB   SB_REG
 
#define 	rSC   SC_REG
 
#define 	rDIV   DIV_REG
 
#define 	rTIMA   TIMA_REG
 
#define 	rTMA   TMA_REG
 
#define 	rTAC   TAC_REG
 
#define 	TACF_START   0b00000100
 
#define 	TACF_STOP   0b00000000
 
#define 	TACF_4KHZ   0b00000000
 
#define 	TACF_16KHZ   0b00000011
 
#define 	TACF_65KHZ   0b00000010
 
#define 	TACF_262KHZ   0b00000001
 
#define 	SIOF_CLOCK_EXT   0b00000000
 
#define 	SIOF_CLOCK_INT   0b00000001
 
#define 	SIOF_SPEED_1X   0b00000000
 
#define 	SIOF_SPEED_32X   0b00000010
 
#define 	SIOF_XFER_START   0b10000000
 
#define 	SIOF_B_CLOCK   0
 
#define 	SIOF_B_SPEED   1
 
#define 	SIOF_B_XFER_START   7
 
#define 	rIF   IF_REG
 
#define 	rAUD1SWEEP   NR10_REG
 
#define 	AUD1SWEEP_UP   0b00000000
 
#define 	AUD1SWEEP_DOWN   0b00001000
 
#define 	AUD1SWEEP_TIME(x)   ((x) << 4)
 
#define 	AUD1SWEEP_LENGTH(x)   (x)
 
#define 	rAUD1LEN   NR11_REG
 
#define 	rAUD1ENV   NR12_REG
 
#define 	rAUD1LOW   NR13_REG
 
#define 	rAUD1HIGH   NR14_REG
 
#define 	rAUD2LEN   NR21_REG
 
#define 	rAUD2ENV   NR22_REG
 
#define 	rAUD2LOW   NR23_REG
 
#define 	rAUD2HIGH   NR24_REG
 
#define 	rAUD3ENA   NR30_REG
 
#define 	rAUD3LEN   NR31_REG
 
#define 	rAUD3LEVEL   NR32_REG
 
#define 	rAUD3LOW   NR33_REG
 
#define 	rAUD3HIGH   NR34_REG
 
#define 	rAUD4LEN   NR41_REG
 
#define 	rAUD4ENV   NR42_REG
 
#define 	rAUD4POLY   NR43_REG
 
#define 	AUD4POLY_WIDTH_15BIT   0x00
 
#define 	AUD4POLY_WIDTH_7BIT   0x08
 
#define 	rAUD4GO   NR44_REG
 
#define 	rAUDVOL   NR50_REG
 
#define 	AUDVOL_VOL_LEFT(x)   ((x) << 4)
 
#define 	AUDVOL_VOL_RIGHT(x)   ((x))
 
#define 	AUDVOL_VIN_LEFT   0b10000000
 
#define 	AUDVOL_VIN_RIGHT   0b00001000
 
#define 	rAUDTERM   NR51_REG
 
#define 	AUDTERM_4_LEFT   0b10000000
 
#define 	AUDTERM_3_LEFT   0b01000000
 
#define 	AUDTERM_2_LEFT   0b00100000
 
#define 	AUDTERM_1_LEFT   0b00010000
 
#define 	AUDTERM_4_RIGHT   0b00001000
 
#define 	AUDTERM_3_RIGHT   0b00000100
 
#define 	AUDTERM_2_RIGHT   0b00000010
 
#define 	AUDTERM_1_RIGHT   0b00000001
 
#define 	rAUDENA   NR52_REG
 
#define 	AUDENA_ON   0b10000000
 
#define 	AUDENA_OFF   0b00000000
 
//#define 	rLCDC   LCDC_REG
 
//#define 	LCDCF_OFF   0b00000000
 
//#define 	LCDCF_ON   0b10000000
 
//#define 	LCDCF_WIN9800   0b00000000
 
//#define 	LCDCF_WIN9C00   0b01000000
 
//#define 	LCDCF_WINOFF   0b00000000
 
//#define 	LCDCF_WINON   0b00100000
 
//#define 	LCDCF_BG8800   0b00000000
 
//#define 	LCDCF_BG8000   0b00010000
 
//#define 	LCDCF_BG9800   0b00000000
 
//#define 	LCDCF_BG9C00   0b00001000
 
//#define 	LCDCF_OBJ8   0b00000000
 
//#define 	LCDCF_OBJ16   0b00000100
 
//#define 	LCDCF_OBJOFF   0b00000000
 
//#define 	LCDCF_OBJON   0b00000010
 
//#define 	LCDCF_BGOFF   0b00000000
 
//#define 	LCDCF_BGON   0b00000001
 
//#define 	LCDCF_B_ON   7
 
//#define 	LCDCF_B_WIN9C00   6
 
//#define 	LCDCF_B_WINON   5
 
//#define 	LCDCF_B_BG8000   4
 
//#define 	LCDCF_B_BG9C00   3
 
//#define 	LCDCF_B_OBJ16   2
 
//#define 	LCDCF_B_OBJON   1
 
//#define 	LCDCF_B_BGON   0
 
//#define 	rSTAT   STAT_REG
 
//#define 	STATF_LYC   0b01000000
 
//#define 	STATF_MODE10   0b00100000
 
//#define 	STATF_MODE01   0b00010000
 
//#define 	STATF_MODE00   0b00001000
 
//#define 	STATF_LYCF   0b00000100
 
//#define 	STATF_HBL   0b00000000
 
//#define 	STATF_VBL   0b00000001
 
//#define 	STATF_OAM   0b00000010
 
//#define 	STATF_LCD   0b00000011
 
//#define 	STATF_BUSY   0b00000010
 
//#define 	STATF_B_LYC   6
 
//#define 	STATF_B_MODE10   5
 
//#define 	STATF_B_MODE01   4
 
//#define 	STATF_B_MODE00   3
 
//#define 	STATF_B_LYCF   2
 
//#define 	STATF_B_VBL   0
 
//#define 	STATF_B_OAM   1
 
//#define 	STATF_B_BUSY   1
 
#define 	rSCY
 
#define 	rSCX   SCX_REG
 
#define 	rLY   LY_REG
 
#define 	rLYC   LYC_REG
 
#define 	rDMA   DMA_REG
 
// #define 	rBGP   BGP_REG
 
// #define 	rOBP0   OBP0_REG
 
// #define 	rOBP1   OBP1_REG
 
#define 	rWY   WY_REG
 
#define 	rWX   WX_REG
 
#define 	rKEY1   KEY1_REG
 
#define 	rSPD   KEY1_REG
 
#define 	KEY1F_DBLSPEED   0b10000000
 
#define 	KEY1F_PREPARE   0b00000001
 
//#define 	rVBK   VBK_REG
 
//#define 	VBK_BANK_0   0
 
//#define 	VBK_TILES   0
 
//#define 	VBK_BANK_1   1
 
//#define 	VBK_ATTRIBUTES   1
 
#define 	BKGF_PRI   0b10000000
 
#define 	BKGF_YFLIP   0b01000000
 
#define 	BKGF_XFLIP   0b00100000
 
#define 	BKGF_BANK0   0b00000000
 
#define 	BKGF_BANK1   0b00001000
 
#define 	BKGF_CGB_PAL0   0b00000000
 
#define 	BKGF_CGB_PAL1   0b00000001
 
#define 	BKGF_CGB_PAL2   0b00000010
 
#define 	BKGF_CGB_PAL3   0b00000011
 
#define 	BKGF_CGB_PAL4   0b00000100
 
#define 	BKGF_CGB_PAL5   0b00000101
 
#define 	BKGF_CGB_PAL6   0b00000110
 
#define 	BKGF_CGB_PAL7   0b00000111
 
#define 	rHDMA1   HDMA1_REG
 
#define 	rHDMA2   HDMA2_REG
 
#define 	rHDMA3   HDMA3_REG
 
#define 	rHDMA4   HDMA4_REG
 
#define 	rHDMA5   HDMA5_REG
 
#define 	HDMA5F_MODE_GP   0b00000000
 
#define 	HDMA5F_MODE_HBL   0b10000000
 
#define 	HDMA5F_BUSY   0b10000000
 
#define 	rRP   RP_REG
 
#define 	RPF_ENREAD   0b11000000
 
#define 	RPF_DATAIN   0b00000010
 
#define 	RPF_WRITE_HI   0b00000001
 
#define 	RPF_WRITE_LO   0b00000000
 
#define 	rBCPS   BCPS_REG
 
#define 	BCPSF_AUTOINC   0b10000000
 
#define 	rBCPD   BCPD_REG
 
#define 	rOCPS   OCPS_REG
 
#define 	OCPSF_AUTOINC   0b10000000
 
#define 	rOCPD   OCPD_REG
 
#define 	rSVBK   SVBK_REG
 
#define 	rSMBK   SVBK_REG
 
#define 	rPCM12   PCM12_REG
 
#define 	rPCM34   PCM34_REG
 
#define 	rIE   IE_REG
 
#define 	IEF_HILO   0b00010000
 
#define 	IEF_SERIAL   0b00001000
 
#define 	IEF_TIMER   0b00000100
 
#define 	IEF_STAT   0b00000010
 
#define 	IEF_VBLANK   0b00000001
 
#define 	AUDLEN_DUTY_12_5   0b00000000
 
#define 	AUDLEN_DUTY_25   0b01000000
 
#define 	AUDLEN_DUTY_50   0b10000000
 
#define 	AUDLEN_DUTY_75   0b11000000
 
#define 	AUDLEN_LENGTH(x)   (x)
 
#define 	AUDENV_VOL(x)   ((x) << 4)
 
#define 	AUDENV_UP   0b00001000
 
#define 	AUDENV_DOWN   0b00000000
 
#define 	AUDENV_LENGTH(x)   (x)
 
#define 	AUDHIGH_RESTART   0b10000000
 
#define 	AUDHIGH_LENGTH_ON   0b01000000
 
#define 	AUDHIGH_LENGTH_OFF   0b00000000
 
#define 	OAMF_PRI   0b10000000
 
#define 	OAMF_YFLIP   0b01000000
 
#define 	OAMF_XFLIP   0b00100000
 
#define 	OAMF_PAL0   0b00000000
 
#define 	OAMF_PAL1   0b00010000
 
#define 	OAMF_BANK0   0b00000000
 
#define 	OAMF_BANK1   0b00001000
 
#define 	OAMF_CGB_PAL0   0b00000000
 
#define 	OAMF_CGB_PAL1   0b00000001
 
#define 	OAMF_CGB_PAL2   0b00000010
 
#define 	OAMF_CGB_PAL3   0b00000011
 
#define 	OAMF_CGB_PAL4   0b00000100
 
#define 	OAMF_CGB_PAL5   0b00000101
 
#define 	OAMF_CGB_PAL6   0b00000110
 
#define 	OAMF_CGB_PAL7   0b00000111
 
#define 	OAMF_PALMASK   0b00000111
 
#define 	DEVICE_SCREEN_X_OFFSET   0
 
#define 	DEVICE_SCREEN_Y_OFFSET   0
 
#define 	DEVICE_SCREEN_WIDTH   20
 
#define 	DEVICE_SCREEN_HEIGHT   18
 
#define 	DEVICE_SCREEN_BUFFER_WIDTH   32
 
#define 	DEVICE_SCREEN_BUFFER_HEIGHT   32
 
#define 	DEVICE_SCREEN_MAP_ENTRY_SIZE   1
 
#define 	DEVICE_SPRITE_PX_OFFSET_X   8
 
#define 	DEVICE_SPRITE_PX_OFFSET_Y   16
 
#define 	DEVICE_WINDOW_PX_OFFSET_X   7
 
#define 	DEVICE_WINDOW_PX_OFFSET_Y   0
 
#define 	DEVICE_SCREEN_PX_WIDTH   (DEVICE_SCREEN_WIDTH * 8)
 
#define 	DEVICE_SCREEN_PX_HEIGHT   (DEVICE_SCREEN_HEIGHT * 8)
 
//__BYTES 	_VRAM []
 
//__BYTES 	_VRAM8000 []
 
//__BYTES 	_VRAM8800 []
 
//__BYTES 	_VRAM9000 []
 
//__BYTES 	_SCRN0 []
 
//__BYTES 	_SCRN1 []
 
__BYTES 	_SRAM []
 
__BYTES 	_RAM []
 
__BYTES 	_RAMBANK []
 
__BYTES 	_OAMRAM []
 
__BYTE_REG 	_IO []
 
__BYTE_REG 	_AUD3WAVERAM []
 
__BYTE_REG 	_HRAM []
 
__BYTE_REG 	rRAMG
 
__BYTE_REG 	rROMB0
 
__BYTE_REG 	rROMB1
 
__BYTE_REG 	rRAMB
 
__REG 	P1_REG
 
__REG 	SB_REG
 
__REG 	SC_REG
 
__REG 	DIV_REG
 
__REG 	TIMA_REG
 
__REG 	TMA_REG
 
__REG 	TAC_REG
 
__REG 	IF_REG
 
__REG 	NR10_REG
 
__REG 	NR11_REG
 
__REG 	NR12_REG
 
__REG 	NR13_REG
 
__REG 	NR14_REG
 
__REG 	NR21_REG
 
__REG 	NR22_REG
 
__REG 	NR23_REG
 
__REG 	NR24_REG
 
__REG 	NR30_REG
 
__REG 	NR31_REG
 
__REG 	NR32_REG
 
__REG 	NR33_REG
 
__REG 	NR34_REG
 
__REG 	NR41_REG
 
__REG 	NR42_REG
 
__REG 	NR43_REG
 
__REG 	NR44_REG
 
__REG 	NR50_REG
 
__REG 	NR51_REG
 
__REG 	NR52_REG
 
__BYTE_REG 	AUD3WAVE [16]
 
__BYTE_REG 	PCM_SAMPLE [16]
 
//__REG 	LCDC_REG
 
//__REG 	STAT_REG
 
//__REG 	SCY_REG
 
//__REG 	SCX_REG
 
__REG 	LY_REG
 
//__REG 	LYC_REG
 
__REG 	DMA_REG
 
//__REG 	BGP_REG
 
//__REG 	OBP0_REG
 
//__REG 	OBP1_REG
 
//__REG 	WY_REG
 
//__REG 	WX_REG
 
__REG 	KEY1_REG
 
//__REG 	VBK_REG
 
__REG 	HDMA1_REG
 
__REG 	HDMA2_REG
 
__REG 	HDMA3_REG
 
__REG 	HDMA4_REG
 
__REG 	HDMA5_REG
 
__REG 	RP_REG
 
__REG 	BCPS_REG
 
__REG 	BCPD_REG
 
__REG 	OCPS_REG
 
__REG 	OCPD_REG
 
__REG 	SVBK_REG
 
__REG 	PCM12_REG
 
__REG 	PCM34_REG
 
__REG 	IE_REG
