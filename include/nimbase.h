// Minimal nimbase.h targetting GBDK '20

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

#define N_LIB_PRIVATE
#define N_NIMCALL(rettype, name) rettype name
#define N_NIMCALL_PTR(rettype, name) rettype (*name)
#define N_RAW_NIMCALL
#define N_INLINE(rettype, name) inline rettype name
#define N_CLOSURE(rettype, name) N_NIMCALL(rettype, name)
#define N_CLOSURE_PTR(rettype, name) N_NIMCALL_PTR(rettype, name)
#define N_CDECL(rettype, name) rettype name

typedef signed int NI;
typedef unsigned int NU;

typedef int8_t NI8;
typedef int16_t NI16;
typedef int32_t NI32;
typedef int64_t NI64;
typedef float NF;

typedef uint8_t NU8;
typedef uint16_t NU16;
typedef uint32_t NU32;
typedef uint64_t NU64;

typedef char NIM_CHAR;
typedef char* NCSTRING;

#define NIM_BOOL bool
#define NIM_NIL 0
#define NIM_TRUE true
#define NIM_FALSE false

#define NIM_CONST  const

#define SEQ_DECL_SIZE
