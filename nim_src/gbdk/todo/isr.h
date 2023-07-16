#define 	VECTOR_STAT   0x48
 
#define 	VECTOR_TIMER   0x50
 
#define 	VECTOR_SERIAL   0x58
 
#define 	VECTOR_JOYPAD   0x60
 
#define 	ISR_VECTOR(ADDR, FUNC)   static const isr_vector_t AT((ADDR)) __ISR_ ## ADDR = {0xc3, (void *)&(FUNC)};
 
#define 	ISR_NESTED_VECTOR(ADDR, FUNC)   static const isr_nested_vector_t AT((ADDR)) __ISR_ ## ADDR = {{0xfb, 0xc3}, (void *)&(FUNC)};

struct  	isr_vector_t
 
struct  	isr_nested_vector_t
