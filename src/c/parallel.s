GAS LISTING /tmp/ccC5kB4k.s 			page 1


   1              		.file	"parallel_merge.c"
   2              		.text
   3              	.Ltext0:
   4              		.p2align 4,,15
   5              		.type	merge, @function
   6              	merge:
   7              	.LFB20:
   8              		.file 1 "parallel_merge.c"
   1:parallel_merge.c **** #include <cilk/cilk.h>
   2:parallel_merge.c **** #include <omp.h>
   3:parallel_merge.c **** 
   4:parallel_merge.c **** #include "merge.h"
   5:parallel_merge.c **** 
   6:parallel_merge.c **** //merge two sorted arrays A and B into array C
   7:parallel_merge.c **** static void merge(uint32_t* C, uint32_t* A, uint32_t* Aend, uint32_t* B, uint32_t* Bend) {
   9              		.loc 1 7 0
  10              		.cfi_startproc
  11              	.LVL0:
  12 0000 4154     		pushq	%r12
  13              		.cfi_def_cfa_offset 16
  14              		.cfi_offset 12, -16
   8:parallel_merge.c ****   while (A < Aend && B < Bend) {
  15              		.loc 1 8 0
  16 0002 4839D6   		cmpq	%rdx, %rsi
   7:parallel_merge.c ****   while (A < Aend && B < Bend) {
  17              		.loc 1 7 0
  18 0005 4989F9   		movq	%rdi, %r9
  19 0008 55       		pushq	%rbp
  20              		.cfi_def_cfa_offset 24
  21              		.cfi_offset 6, -24
  22 0009 4C89C5   		movq	%r8, %rbp
  23 000c 53       		pushq	%rbx
  24              		.cfi_def_cfa_offset 32
  25              		.cfi_offset 3, -32
   7:parallel_merge.c ****   while (A < Aend && B < Bend) {
  26              		.loc 1 7 0
  27 000d 4889CB   		movq	%rcx, %rbx
  28              		.loc 1 8 0
  29 0010 734A     		jae	.L2
  30 0012 4C39C1   		cmpq	%r8, %rcx
  31 0015 720E     		jb	.L3
  32 0017 EB43     		jmp	.L2
  33              	.LVL1:
  34 0019 0F1F8000 		.p2align 4,,10
  34      000000
  35              		.p2align 3
  36              	.L18:
  37 0020 4839F2   		cmpq	%rsi, %rdx
  38 0023 7637     		jbe	.L2
  39              	.LVL2:
  40              	.L3:
  41              	.LBB2:
   9:parallel_merge.c ****     *C++ = *B ^ ((*A ^ *B) & -(*A < *B));
  42              		.loc 1 9 0
  43 0025 8B0B     		movl	(%rbx), %ecx
  44 0027 448B16   		movl	(%rsi), %r10d
  45 002a 4983C104 		addq	$4, %r9
GAS LISTING /tmp/ccC5kB4k.s 			page 2


  46              	.LVL3:
  47 002e 4139CA   		cmpl	%ecx, %r10d
  48 0031 19C0     		sbbl	%eax, %eax
  49 0033 4131CA   		xorl	%ecx, %r10d
  50 0036 4421D0   		andl	%r10d, %eax
  51 0039 31C8     		xorl	%ecx, %eax
  52 003b 418941FC 		movl	%eax, -4(%r9)
  10:parallel_merge.c ****     /*if (*A < *B) {
  11:parallel_merge.c ****       *C++ = *A++;
  12:parallel_merge.c ****     } else {
  13:parallel_merge.c ****       *C++ = *B++;
  14:parallel_merge.c ****     }*/
  15:parallel_merge.c ****     bool inc = *A < *B;
  53              		.loc 1 15 0
  54 003f 8B03     		movl	(%rbx), %eax
  55 0041 3906     		cmpl	%eax, (%rsi)
  56 0043 0F92C0   		setb	%al
  57              	.LVL4:
  16:parallel_merge.c ****     A += inc;
  58              		.loc 1 16 0
  59 0046 0FB6C8   		movzbl	%al, %ecx
  17:parallel_merge.c ****     B += !inc;
  60              		.loc 1 17 0
  61 0049 83F001   		xorl	$1, %eax
  62              	.LVL5:
  63 004c 0FB6C0   		movzbl	%al, %eax
  16:parallel_merge.c ****     A += inc;
  64              		.loc 1 16 0
  65 004f 488D348E 		leaq	(%rsi,%rcx,4), %rsi
  66              	.LVL6:
  67              		.loc 1 17 0
  68 0053 488D1C83 		leaq	(%rbx,%rax,4), %rbx
  69              	.LVL7:
  70              	.LBE2:
   8:parallel_merge.c ****     *C++ = *B ^ ((*A ^ *B) & -(*A < *B));
  71              		.loc 1 8 0
  72 0057 4839DD   		cmpq	%rbx, %rbp
  73 005a 77C4     		ja	.L18
  74              	.LVL8:
  75              	.L2:
  18:parallel_merge.c ****   }
  19:parallel_merge.c ****   /*while (A < Aend) {
  20:parallel_merge.c ****     *C++ = *A++;
  21:parallel_merge.c ****   }
  22:parallel_merge.c ****   while (B < Bend) {
  23:parallel_merge.c ****     *C++ = *B++;
  24:parallel_merge.c ****   }*/
  25:parallel_merge.c ****   memcpy(C, A, (Aend - A) * sizeof(*A));
  76              		.loc 1 25 0
  77 005c 4829F2   		subq	%rsi, %rdx
  78              	.LVL9:
  79 005f 4C89CF   		movq	%r9, %rdi
  80 0062 4989D4   		movq	%rdx, %r12
  81 0065 4983E4FC 		andq	$-4, %r12
  82 0069 4C89E2   		movq	%r12, %rdx
  83 006c E8000000 		call	memcpy
  83      00
GAS LISTING /tmp/ccC5kB4k.s 			page 3


  84              	.LVL10:
  85              	.LVL11:
  26:parallel_merge.c ****   memcpy(C + (Aend - A), B, (Bend - B) * sizeof(*B));
  86              		.loc 1 26 0
  87 0071 4889EA   		movq	%rbp, %rdx
  88 0074 4889DE   		movq	%rbx, %rsi
  89 0077 4A8D3C20 		leaq	(%rax,%r12), %rdi
  90 007b 4829DA   		subq	%rbx, %rdx
  27:parallel_merge.c **** }
  91              		.loc 1 27 0
  92 007e 5B       		popq	%rbx
  93              		.cfi_def_cfa_offset 24
  94              	.LVL12:
  95 007f 5D       		popq	%rbp
  96              		.cfi_def_cfa_offset 16
  97              	.LVL13:
  98 0080 415C     		popq	%r12
  99              		.cfi_def_cfa_offset 8
  26:parallel_merge.c ****   memcpy(C + (Aend - A), B, (Bend - B) * sizeof(*B));
 100              		.loc 1 26 0
 101 0082 4883E2FC 		andq	$-4, %rdx
 102 0086 E9000000 		jmp	memcpy
 102      00
 103              	.LVL14:
 104              	.LVL15:
 105              		.cfi_endproc
 106              	.LFE20:
 107              		.size	merge, .-merge
 108 008b 0F1F4400 		.p2align 4,,15
 108      00
 109              		.type	__cilk_spawn_001, @function
 110              	__cilk_spawn_001:
 111              	.LFB23:
 112              		.cfi_startproc
 113 0090 55       		pushq	%rbp
 114              		.cfi_def_cfa_offset 16
 115              		.cfi_offset 6, -16
 116 0091 4889E5   		movq	%rsp, %rbp
 117              		.cfi_def_cfa_register 6
 118 0094 4155     		pushq	%r13
 119 0096 4154     		pushq	%r12
 120 0098 53       		pushq	%rbx
 121 0099 4883EC58 		subq	$88, %rsp
 122              		.cfi_offset 13, -24
 123              		.cfi_offset 12, -32
 124              		.cfi_offset 3, -40
 125 009d 4989FC   		movq	%rdi, %r12
 126 00a0 4989F5   		movq	%rsi, %r13
 127 00a3 4889D3   		movq	%rdx, %rbx
  28:parallel_merge.c **** 
  29:parallel_merge.c **** static void merge_sort_helper(uint32_t* start, uint32_t* end, uint32_t* aux) {
  30:parallel_merge.c ****   uint32_t n = (end - start);
  31:parallel_merge.c ****   if (n == 1) {
  32:parallel_merge.c ****     return;
  33:parallel_merge.c ****   }
  34:parallel_merge.c ****   int* mid = start + n/2;
  35:parallel_merge.c **** 
GAS LISTING /tmp/ccC5kB4k.s 			page 4


  36:parallel_merge.c ****   // coarsening
  37:parallel_merge.c ****   if (n < (1L << 11)) {
  38:parallel_merge.c ****     merge_sort_helper(start, mid, aux);
  39:parallel_merge.c ****     merge_sort_helper(mid, end, aux + n/2);
  40:parallel_merge.c ****   }
  41:parallel_merge.c ****   else {
  42:parallel_merge.c ****     /* // OPENMP
  43:parallel_merge.c ****     #pragma omp parallel for
  44:parallel_merge.c ****     for (int i = 0; i < 2; i++) {
  45:parallel_merge.c ****       merge_sort_helper(start + i * n / 2, start + (i + 1) * n / 2, aux + i * n / 2);
  46:parallel_merge.c ****     }
  47:parallel_merge.c ****     */
  48:parallel_merge.c **** 
  49:parallel_merge.c ****     // CILK+
  50:parallel_merge.c ****     cilk_spawn merge_sort_helper(start, mid, aux);
 128              		.loc 1 50 0
 129 00a6 488D7D90 		leaq	-112(%rbp), %rdi
 130              	.L23:
 131              	.LVL16:
 132 00aa 488D7D90 		leaq	-112(%rbp), %rdi
 133 00ae E8000000 		call	__cilkrts_enter_frame
 133      00
 134              	.LVL17:
 135 00b3 488D7D90 		leaq	-112(%rbp), %rdi
 136              	.L24:
 137              	.LVL18:
 138 00b7 488D7D90 		leaq	-112(%rbp), %rdi
 139              	.L25:
 140              	.LVL19:
 141 00bb 488B4DA0 		movq	-96(%rbp), %rcx
 142 00bf 488B01   		movq	(%rcx), %rax
 143 00c2 488B5598 		movq	-104(%rbp), %rdx
 144 00c6 488910   		movq	%rdx, (%rax)
 145 00c9 4883C008 		addq	$8, %rax
 146 00cd 488901   		movq	%rax, (%rcx)
 147 00d0 834D9004 		orl	$4, -112(%rbp)
 148              	.L26:
 149              	.LVL20:
 150 00d4 4C89E2   		movq	%r12, %rdx
 151 00d7 4C89EE   		movq	%r13, %rsi
 152 00da 4889DF   		movq	%rbx, %rdi
 153 00dd E83E0000 		call	merge_sort_helper
 153      00
 154              	.LVL21:
 155 00e2 488B5598 		movq	-104(%rbp), %rdx
 156 00e6 488B45A0 		movq	-96(%rbp), %rax
 157 00ea 48895048 		movq	%rdx, 72(%rax)
 158 00ee 48C74598 		movq	$0, -104(%rbp)
 158      00000000 
 159 00f6 488D7D90 		leaq	-112(%rbp), %rdi
 160              	.L27:
 161              	.LVL22:
 162 00fa 8B4590   		movl	-112(%rbp), %eax
 163 00fd 85C0     		testl	%eax, %eax
 164 00ff 750B     		jne	.L22
 165              	.L20:
 166              	.L28:
GAS LISTING /tmp/ccC5kB4k.s 			page 5


 167              	.LVL23:
 168 0101 4883C458 		addq	$88, %rsp
 169 0105 5B       		popq	%rbx
 170 0106 415C     		popq	%r12
 171 0108 415D     		popq	%r13
 172 010a 5D       		popq	%rbp
 173              		.cfi_remember_state
 174              		.cfi_def_cfa 7, 8
 175 010b C3       		ret
 176              	.L22:
 177              		.cfi_restore_state
 178 010c 488D7D90 		leaq	-112(%rbp), %rdi
 179 0110 E8000000 		call	__cilkrts_leave_frame
 179      00
 180              	.LVL24:
 181 0115 EBEA     		jmp	.L20
 182              		.cfi_endproc
 183              	.LFE23:
 184              		.size	__cilk_spawn_001, .-__cilk_spawn_001
 185              		.section .itt_notify_tab,"a"
 186              	.L29:
 187 0000 2E       		.byte	46
 188 0001 69       		.byte	105
 189 0002 74       		.byte	116
 190 0003 74       		.byte	116
 191 0004 5F       		.byte	95
 192 0005 6E       		.byte	110
 193 0006 6F       		.byte	111
 194 0007 74       		.byte	116
 195 0008 69       		.byte	105
 196 0009 66       		.byte	102
 197 000a 79       		.byte	121
 198 000b 5F       		.byte	95
 199 000c 74       		.byte	116
 200 000d 61       		.byte	97
 201 000e 62       		.byte	98
 202 000f 00       		.byte	0
 203 0010 01       		.byte	1
 204 0011 01       		.byte	1
 205 0012 0600     		.value	6
 206 0014 9C000000 		.long	.L30-.L29
 207 0018 69000000 		.long	105
 208 001c 05010000 		.long	.L31-.L29
 209 0020 0C000000 		.long	12
 210 0024 00000000 		.quad	.L23
 210      00000000 
 211 002c 00000000 		.long	0
 212 0030 00000000 		.long	0
 213 0034 00000000 		.long	0
 214 0038 00000000 		.quad	.L24
 214      00000000 
 215 0040 00000000 		.long	0
 216 0044 18000000 		.long	24
 217 0048 02000000 		.long	2
 218 004c 00000000 		.quad	.L25
 218      00000000 
 219 0054 00000000 		.long	0
GAS LISTING /tmp/ccC5kB4k.s 			page 6


 220 0058 27000000 		.long	39
 221 005c 04000000 		.long	4
 222 0060 00000000 		.quad	.L26
 222      00000000 
 223 0068 00000000 		.long	0
 224 006c 39000000 		.long	57
 225 0070 06000000 		.long	6
 226 0074 00000000 		.quad	.L27
 226      00000000 
 227 007c 00000000 		.long	0
 228 0080 49000000 		.long	73
 229 0084 08000000 		.long	8
 230 0088 00000000 		.quad	.L28
 230      00000000 
 231 0090 00000000 		.long	0
 232 0094 5A000000 		.long	90
 233 0098 0A000000 		.long	10
 234              	.L30:
 235 009c 63       		.byte	99
 236 009d 69       		.byte	105
 237 009e 6C       		.byte	108
 238 009f 6B       		.byte	107
 239 00a0 5F       		.byte	95
 240 00a1 65       		.byte	101
 241 00a2 6E       		.byte	110
 242 00a3 74       		.byte	116
 243 00a4 65       		.byte	101
 244 00a5 72       		.byte	114
 245 00a6 5F       		.byte	95
 246 00a7 68       		.byte	104
 247 00a8 65       		.byte	101
 248 00a9 6C       		.byte	108
 249 00aa 70       		.byte	112
 250 00ab 65       		.byte	101
 251 00ac 72       		.byte	114
 252 00ad 5F       		.byte	95
 253 00ae 62       		.byte	98
 254 00af 65       		.byte	101
 255 00b0 67       		.byte	103
 256 00b1 69       		.byte	105
 257 00b2 6E       		.byte	110
 258 00b3 00       		.byte	0
 259 00b4 63       		.byte	99
 260 00b5 69       		.byte	105
 261 00b6 6C       		.byte	108
 262 00b7 6B       		.byte	107
 263 00b8 5F       		.byte	95
 264 00b9 65       		.byte	101
 265 00ba 6E       		.byte	110
 266 00bb 74       		.byte	116
 267 00bc 65       		.byte	101
 268 00bd 72       		.byte	114
 269 00be 5F       		.byte	95
 270 00bf 65       		.byte	101
 271 00c0 6E       		.byte	110
 272 00c1 64       		.byte	100
 273 00c2 00       		.byte	0
GAS LISTING /tmp/ccC5kB4k.s 			page 7


 274 00c3 63       		.byte	99
 275 00c4 69       		.byte	105
 276 00c5 6C       		.byte	108
 277 00c6 6B       		.byte	107
 278 00c7 5F       		.byte	95
 279 00c8 64       		.byte	100
 280 00c9 65       		.byte	101
 281 00ca 74       		.byte	116
 282 00cb 61       		.byte	97
 283 00cc 63       		.byte	99
 284 00cd 68       		.byte	104
 285 00ce 5F       		.byte	95
 286 00cf 62       		.byte	98
 287 00d0 65       		.byte	101
 288 00d1 67       		.byte	103
 289 00d2 69       		.byte	105
 290 00d3 6E       		.byte	110
 291 00d4 00       		.byte	0
 292 00d5 63       		.byte	99
 293 00d6 69       		.byte	105
 294 00d7 6C       		.byte	108
 295 00d8 6B       		.byte	107
 296 00d9 5F       		.byte	95
 297 00da 64       		.byte	100
 298 00db 65       		.byte	101
 299 00dc 74       		.byte	116
 300 00dd 61       		.byte	97
 301 00de 63       		.byte	99
 302 00df 68       		.byte	104
 303 00e0 5F       		.byte	95
 304 00e1 65       		.byte	101
 305 00e2 6E       		.byte	110
 306 00e3 64       		.byte	100
 307 00e4 00       		.byte	0
 308 00e5 63       		.byte	99
 309 00e6 69       		.byte	105
 310 00e7 6C       		.byte	108
 311 00e8 6B       		.byte	107
 312 00e9 5F       		.byte	95
 313 00ea 6C       		.byte	108
 314 00eb 65       		.byte	101
 315 00ec 61       		.byte	97
 316 00ed 76       		.byte	118
 317 00ee 65       		.byte	101
 318 00ef 5F       		.byte	95
 319 00f0 62       		.byte	98
 320 00f1 65       		.byte	101
 321 00f2 67       		.byte	103
 322 00f3 69       		.byte	105
 323 00f4 6E       		.byte	110
 324 00f5 00       		.byte	0
 325 00f6 63       		.byte	99
 326 00f7 69       		.byte	105
 327 00f8 6C       		.byte	108
 328 00f9 6B       		.byte	107
 329 00fa 5F       		.byte	95
 330 00fb 6C       		.byte	108
GAS LISTING /tmp/ccC5kB4k.s 			page 8


 331 00fc 65       		.byte	101
 332 00fd 61       		.byte	97
 333 00fe 76       		.byte	118
 334 00ff 65       		.byte	101
 335 0100 5F       		.byte	95
 336 0101 65       		.byte	101
 337 0102 6E       		.byte	110
 338 0103 64       		.byte	100
 339 0104 00       		.byte	0
 340              	.L31:
 341 0105 0155     		.value	21761
 342 0107 0155     		.value	21761
 343 0109 0155     		.value	21761
 344 010b 0130     		.value	12289
 345 010d 0155     		.value	21761
 346 010f 0130     		.value	12289
 347              		.text
 348 0117 660F1F84 		.p2align 4,,15
 348      00000000 
 348      00
 349              		.type	merge_sort_helper, @function
 350              	merge_sort_helper:
 351              	.LFB21:
  29:parallel_merge.c ****   uint32_t n = (end - start);
 352              		.loc 1 29 0
 353              		.cfi_startproc
 354              	.LVL25:
 355 0120 55       		pushq	%rbp
 356              		.cfi_def_cfa_offset 16
 357              		.cfi_offset 6, -16
 358 0121 4889E5   		movq	%rsp, %rbp
 359              		.cfi_def_cfa_register 6
 360 0124 4157     		pushq	%r15
 361 0126 4156     		pushq	%r14
 362 0128 4155     		pushq	%r13
 363 012a 4154     		pushq	%r12
 364 012c 53       		pushq	%rbx
 365 012d 4881EC98 		subq	$152, %rsp
 365      000000
 366              		.cfi_offset 15, -24
 367              		.cfi_offset 14, -32
 368              		.cfi_offset 13, -40
 369              		.cfi_offset 12, -48
 370              		.cfi_offset 3, -56
 371 0134 4889BD68 		movq	%rdi, -152(%rbp)
 371      FFFFFF
 372 013b 4889B560 		movq	%rsi, -160(%rbp)
 372      FFFFFF
 373 0142 48899570 		movq	%rdx, -144(%rbp)
 373      FFFFFF
  29:parallel_merge.c ****   uint32_t n = (end - start);
 374              		.loc 1 29 0
 375 0149 488D4580 		leaq	-128(%rbp), %rax
 376 014d 48898578 		movq	%rax, -136(%rbp)
 376      FFFFFF
 377 0154 4889C7   		movq	%rax, %rdi
 378              	.LVL26:
GAS LISTING /tmp/ccC5kB4k.s 			page 9


 379              	.L68:
  29:parallel_merge.c ****   uint32_t n = (end - start);
 380              		.loc 1 29 0 is_stmt 0 discriminator 1
 381 0157 488BBD78 		movq	-136(%rbp), %rdi
 381      FFFFFF
 382 015e E8000000 		call	__cilkrts_enter_frame
 382      00
 383              	.LVL27:
  29:parallel_merge.c ****   uint32_t n = (end - start);
 384              		.loc 1 29 0 discriminator 2
 385 0163 488BBD78 		movq	-136(%rbp), %rdi
 385      FFFFFF
 386              	.L69:
 387              	.LVL28:
  30:parallel_merge.c ****   if (n == 1) {
 388              		.loc 1 30 0 is_stmt 1
 389 016a 488B8560 		movq	-160(%rbp), %rax
 389      FFFFFF
 390 0171 488B9D68 		movq	-152(%rbp), %rbx
 390      FFFFFF
 391 0178 4829D8   		subq	%rbx, %rax
 392 017b 48C1F802 		sarq	$2, %rax
 393 017f 898554FF 		movl	%eax, -172(%rbp)
 393      FFFF
 394              	.LVL29:
  31:parallel_merge.c ****     return;
 395              		.loc 1 31 0
 396 0185 83F801   		cmpl	$1, %eax
 397 0188 0F847201 		je	.L33
 397      0000
  34:parallel_merge.c **** 
 398              		.loc 1 34 0
 399 018e 89C2     		movl	%eax, %edx
 400 0190 D1EA     		shrl	%edx
 401 0192 488D0C95 		leaq	0(,%rdx,4), %rcx
 401      00000000 
 402 019a 48898D48 		movq	%rcx, -184(%rbp)
 402      FFFFFF
 403 01a1 4801CB   		addq	%rcx, %rbx
 404 01a4 48899D58 		movq	%rbx, -168(%rbp)
 404      FFFFFF
 405              	.LVL30:
  37:parallel_merge.c ****     merge_sort_helper(start, mid, aux);
 406              		.loc 1 37 0
 407 01ab 3DFF0700 		cmpl	$2047, %eax
 407      00
 408 01b0 0F875202 		ja	.L34
 408      0000
  38:parallel_merge.c ****     merge_sort_helper(mid, end, aux + n/2);
 409              		.loc 1 38 0
 410 01b6 488B9570 		movq	-144(%rbp), %rdx
 410      FFFFFF
 411 01bd 4889DE   		movq	%rbx, %rsi
 412 01c0 488BBD68 		movq	-152(%rbp), %rdi
 412      FFFFFF
 413 01c7 E854FFFF 		call	merge_sort_helper
 413      FF
GAS LISTING /tmp/ccC5kB4k.s 			page 10


 414              	.LVL31:
 415              	.LVL32:
  39:parallel_merge.c ****   }
 416              		.loc 1 39 0
 417 01cc 488B9548 		movq	-184(%rbp), %rdx
 417      FFFFFF
 418 01d3 48039570 		addq	-144(%rbp), %rdx
 418      FFFFFF
 419 01da 488BB560 		movq	-160(%rbp), %rsi
 419      FFFFFF
 420 01e1 488BBD58 		movq	-168(%rbp), %rdi
 420      FFFFFF
 421 01e8 E833FFFF 		call	merge_sort_helper
 421      FF
 422              	.LVL33:
 423 01ed E9CD0000 		jmp	.L35
 423      00
 424              	.LVL34:
 425              		.p2align 4,,10
 426 01f2 660F1F44 		.p2align 3
 426      0000
 427              	.L48:
 428 01f8 4883C530 		addq	$48, %rbp
 429              	.LVL35:
 430 01fc 488D4580 		leaq	-128(%rbp), %rax
 431 0200 F6458010 		testb	$16, -128(%rbp)
 432 0204 48898578 		movq	%rax, -136(%rbp)
 432      FFFFFF
 433 020b 0F859F01 		jne	.L56
 433      0000
 434              	.L47:
 435 0211 488BBD78 		movq	-136(%rbp), %rdi
 435      FFFFFF
 436              	.L70:
 437              	.LVL36:
 438 0218 488B5588 		movq	-120(%rbp), %rdx
 439 021c 488B4590 		movq	-112(%rbp), %rax
 440 0220 48895048 		movq	%rdx, 72(%rax)
 441 0224 48C74588 		movq	$0, -120(%rbp)
 441      00000000 
 442 022c 488BBD78 		movq	-136(%rbp), %rdi
 442      FFFFFF
 443              	.L71:
 444              	.LVL37:
 445 0233 8B5580   		movl	-128(%rbp), %edx
 446 0236 85D2     		testl	%edx, %edx
 447 0238 0F85F101 		jne	.L51
 447      0000
 448              	.L53:
 449              	.L72:
 450              	.LVL38:
  51:parallel_merge.c ****     merge_sort_helper(mid, end, aux + n/2);
  52:parallel_merge.c ****     cilk_sync;
  53:parallel_merge.c ****   }
  54:parallel_merge.c **** 
  55:parallel_merge.c ****   merge(aux, start, mid, mid, end);
  56:parallel_merge.c ****   memcpy(start, aux, n * sizeof(*aux));
GAS LISTING /tmp/ccC5kB4k.s 			page 11


  57:parallel_merge.c **** }
 451              		.loc 1 57 0
 452 023e 4881C498 		addq	$152, %rsp
 452      000000
 453 0245 5B       		popq	%rbx
 454 0246 415C     		popq	%r12
 455 0248 415D     		popq	%r13
 456 024a 415E     		popq	%r14
 457 024c 415F     		popq	%r15
 458 024e 5D       		popq	%rbp
 459              		.cfi_remember_state
 460              		.cfi_def_cfa 7, 8
 461 024f C3       		ret
 462              	.LVL39:
 463              		.p2align 4,,10
 464              		.p2align 3
 465              	.L38:
 466              		.cfi_restore_state
  50:parallel_merge.c ****     merge_sort_helper(mid, end, aux + n/2);
 467              		.loc 1 50 0
 468 0250 4883C530 		addq	$48, %rbp
 469 0254 C78578FF 		movl	$1, -136(%rbp)
 469      FFFF0100 
 469      0000
 470              	.L39:
 471              	.LVL40:
  50:parallel_merge.c ****     merge_sort_helper(mid, end, aux + n/2);
 472              		.loc 1 50 0 is_stmt 0 discriminator 7
 473 025e 8BBD78FF 		movl	-136(%rbp), %edi
 473      FFFF
 474 0264 31C0     		xorl	%eax, %eax
 475              	.L73:
 476              	.LVL41:
  50:parallel_merge.c ****     merge_sort_helper(mid, end, aux + n/2);
 477              		.loc 1 50 0 discriminator 8
 478 0266 8B8D78FF 		movl	-136(%rbp), %ecx
 478      FFFF
 479 026c 85C9     		testl	%ecx, %ecx
 480 026e 0F844C01 		je	.L40
 480      0000
 481              	.L42:
  51:parallel_merge.c ****     merge_sort_helper(mid, end, aux + n/2);
 482              		.loc 1 51 0 is_stmt 1
 483 0274 8B8554FF 		movl	-172(%rbp), %eax
 483      FFFF
 484 027a D1E8     		shrl	%eax
 485 027c 488B8D70 		movq	-144(%rbp), %rcx
 485      FFFFFF
 486 0283 488D1481 		leaq	(%rcx,%rax,4), %rdx
 487 0287 488BB560 		movq	-160(%rbp), %rsi
 487      FFFFFF
 488 028e 488BBD58 		movq	-168(%rbp), %rdi
 488      FFFFFF
 489 0295 E886FEFF 		call	merge_sort_helper
 489      FF
 490              	.LVL42:
  52:parallel_merge.c ****   }
GAS LISTING /tmp/ccC5kB4k.s 			page 12


 491              		.loc 1 52 0
 492 029a 488D4580 		leaq	-128(%rbp), %rax
 493 029e 48898578 		movq	%rax, -136(%rbp)
 493      FFFFFF
 494 02a5 4889C7   		movq	%rax, %rdi
 495              	.L74:
 496              	.LVL43:
  52:parallel_merge.c ****   }
 497              		.loc 1 52 0 is_stmt 0 discriminator 1
 498 02a8 F6458002 		testb	$2, -128(%rbp)
 499 02ac 0F852D01 		jne	.L67
 499      0000
 500              		.p2align 4,,10
 501 02b2 660F1F44 		.p2align 3
 501      0000
 502              	.L43:
  52:parallel_merge.c ****   }
 503              		.loc 1 52 0 discriminator 3
 504 02b8 488BBD78 		movq	-136(%rbp), %rdi
 504      FFFFFF
 505              	.L75:
 506              	.LVL44:
 507              	.L35:
  55:parallel_merge.c ****   memcpy(start, aux, n * sizeof(*aux));
 508              		.loc 1 55 0 is_stmt 1
 509 02bf 4C8B8560 		movq	-160(%rbp), %r8
 509      FFFFFF
 510 02c6 488B9558 		movq	-168(%rbp), %rdx
 510      FFFFFF
 511 02cd 4889D1   		movq	%rdx, %rcx
 512 02d0 488BB568 		movq	-152(%rbp), %rsi
 512      FFFFFF
 513 02d7 488BBD70 		movq	-144(%rbp), %rdi
 513      FFFFFF
 514 02de E81DFDFF 		call	merge
 514      FF
 515              	.LVL45:
  56:parallel_merge.c **** }
 516              		.loc 1 56 0
 517 02e3 8B9554FF 		movl	-172(%rbp), %edx
 517      FFFF
 518 02e9 48C1E202 		salq	$2, %rdx
 519 02ed 488BB570 		movq	-144(%rbp), %rsi
 519      FFFFFF
 520 02f4 488BBD68 		movq	-152(%rbp), %rdi
 520      FFFFFF
 521 02fb E8000000 		call	memcpy
 521      00
 522              	.LVL46:
 523              	.LVL47:
 524              	.L33:
 525 0300 488BBD78 		movq	-136(%rbp), %rdi
 525      FFFFFF
 526              	.L76:
 527              	.LVL48:
 528 0307 F6458002 		testb	$2, -128(%rbp)
 529 030b 0F8400FF 		je	.L47
GAS LISTING /tmp/ccC5kB4k.s 			page 13


 529      FFFF
 530 0311 488BBD78 		movq	-136(%rbp), %rdi
 530      FFFFFF
 531 0318 488D5DD0 		leaq	-48(%rbp), %rbx
 532 031c 48895DA0 		movq	%rbx, -96(%rbp)
 533 0320 48C74728 		movq	$.L48, 40(%rdi)
 533      00000000 
 534 0328 48896730 		movq	%rsp, 48(%rdi)
 535 032c E8000000 		call	__cilkrts_sync
 535      00
 536              	.LVL49:
 537 0331 E9DBFEFF 		jmp	.L47
 537      FF
 538              	.LVL50:
 539 0336 662E0F1F 		.p2align 4,,10
 539      84000000 
 539      0000
 540              		.p2align 3
 541              	.L44:
  52:parallel_merge.c ****   }
 542              		.loc 1 52 0
 543 0340 4883C530 		addq	$48, %rbp
 544              	.LVL51:
 545 0344 488D4580 		leaq	-128(%rbp), %rax
 546 0348 F6458010 		testb	$16, -128(%rbp)
 547 034c 48898578 		movq	%rax, -136(%rbp)
 547      FFFFFF
 548 0353 0F845FFF 		je	.L43
 548      FFFF
  52:parallel_merge.c ****   }
 549              		.loc 1 52 0 is_stmt 0 discriminator 9
 550 0359 4889C7   		movq	%rax, %rdi
 551 035c E8000000 		call	__cilkrts_rethrow
 551      00
 552              	.LVL52:
 553 0361 E952FFFF 		jmp	.L43
 553      FF
 554              	.LVL53:
 555 0366 662E0F1F 		.p2align 4,,10
 555      84000000 
 555      0000
 556              		.p2align 3
 557              	.L36:
  50:parallel_merge.c ****     merge_sort_helper(mid, end, aux + n/2);
 558              		.loc 1 50 0 is_stmt 1
 559 0370 4883C530 		addq	$48, %rbp
 560 0374 488D4580 		leaq	-128(%rbp), %rax
 561 0378 48898578 		movq	%rax, -136(%rbp)
 561      FFFFFF
 562 037f 4889C7   		movq	%rax, %rdi
 563              	.L37:
 564              	.LVL54:
 565              	.L77:
  50:parallel_merge.c ****     merge_sort_helper(mid, end, aux + n/2);
 566              		.loc 1 50 0 is_stmt 0 discriminator 4
 567 0382 488B8578 		movq	-136(%rbp), %rax
 567      FFFFFF
GAS LISTING /tmp/ccC5kB4k.s 			page 14


 568 0389 488D5DD0 		leaq	-48(%rbp), %rbx
 569 038d 48895DA0 		movq	%rbx, -96(%rbp)
 570 0391 48C74028 		movq	$.L38, 40(%rax)
 570      00000000 
 571 0399 48896030 		movq	%rsp, 48(%rax)
 572 039d C78578FF 		movl	$0, -136(%rbp)
 572      FFFF0000 
 572      0000
 573 03a7 E9B2FEFF 		jmp	.L39
 573      FF
 574 03ac 0F1F4000 		.p2align 4,,10
 575              		.p2align 3
 576              	.L56:
 577 03b0 4889C7   		movq	%rax, %rdi
 578 03b3 E8000000 		call	__cilkrts_rethrow
 578      00
 579              	.LVL55:
 580 03b8 E954FEFF 		jmp	.L47
 580      FF
 581 03bd 0F1F00   		.p2align 4,,10
 582              		.p2align 3
 583              	.L40:
  50:parallel_merge.c ****     merge_sort_helper(mid, end, aux + n/2);
 584              		.loc 1 50 0 discriminator 9
 585 03c0 488B9568 		movq	-152(%rbp), %rdx
 585      FFFFFF
 586 03c7 488BB558 		movq	-168(%rbp), %rsi
 586      FFFFFF
 587 03ce 488BBD70 		movq	-144(%rbp), %rdi
 587      FFFFFF
 588 03d5 E8B6FCFF 		call	__cilk_spawn_001
 588      FF
 589              	.LVL56:
 590 03da E995FEFF 		jmp	.L42
 590      FF
 591              	.L67:
  52:parallel_merge.c ****   }
 592              		.loc 1 52 0 is_stmt 1 discriminator 2
 593 03df 488BBD78 		movq	-136(%rbp), %rdi
 593      FFFFFF
 594 03e6 488D4DD0 		leaq	-48(%rbp), %rcx
 595 03ea 48894DA0 		movq	%rcx, -96(%rbp)
 596 03ee 48C74728 		movq	$.L44, 40(%rdi)
 596      00000000 
 597 03f6 48896730 		movq	%rsp, 48(%rdi)
 598              	.L54:
 599 03fa E8000000 		call	__cilkrts_sync
 599      00
 600              	.LVL57:
 601 03ff E9B4FEFF 		jmp	.L43
 601      FF
 602              	.LVL58:
 603              		.p2align 4,,10
 604 0404 0F1F4000 		.p2align 3
 605              	.L34:
  50:parallel_merge.c ****     merge_sort_helper(mid, end, aux + n/2);
 606              		.loc 1 50 0
GAS LISTING /tmp/ccC5kB4k.s 			page 15


 607 0408 488B8578 		movq	-136(%rbp), %rax
 607      FFFFFF
 608              	.LVL59:
 609 040f 488D5DD0 		leaq	-48(%rbp), %rbx
 610              	.LVL60:
 611 0413 48895DA0 		movq	%rbx, -96(%rbp)
 612 0417 48C74028 		movq	$.L36, 40(%rax)
 612      00000000 
 613 041f 48896030 		movq	%rsp, 48(%rax)
 614 0423 488BBD78 		movq	-136(%rbp), %rdi
 614      FFFFFF
 615 042a E953FFFF 		jmp	.L37
 615      FF
 616              	.L51:
 617 042f 488BBD78 		movq	-136(%rbp), %rdi
 617      FFFFFF
 618 0436 E8000000 		call	__cilkrts_leave_frame
 618      00
 619              	.LVL61:
 620 043b E9FEFDFF 		jmp	.L53
 620      FF
 621              		.cfi_endproc
 622              	.LFE21:
 623              		.size	merge_sort_helper, .-merge_sort_helper
 624              		.section .itt_notify_tab,"a"
 625              	.L78:
 626 0111 2E       		.byte	46
 627 0112 69       		.byte	105
 628 0113 74       		.byte	116
 629 0114 74       		.byte	116
 630 0115 5F       		.byte	95
 631 0116 6E       		.byte	110
 632 0117 6F       		.byte	111
 633 0118 74       		.byte	116
 634 0119 69       		.byte	105
 635 011a 66       		.byte	102
 636 011b 79       		.byte	121
 637 011c 5F       		.byte	95
 638 011d 74       		.byte	116
 639 011e 61       		.byte	97
 640 011f 62       		.byte	98
 641 0120 00       		.byte	0
 642 0121 01       		.byte	1
 643 0122 01       		.byte	1
 644 0123 0A00     		.value	10
 645 0125 EC000000 		.long	.L79-.L78
 646 0129 A6000000 		.long	166
 647 012d 92010000 		.long	.L80-.L78
 648 0131 14000000 		.long	20
 649 0135 00000000 		.quad	.L68
 649      00000000 
 650 013d 00000000 		.long	0
 651 0141 00000000 		.long	0
 652 0145 00000000 		.long	0
 653 0149 00000000 		.quad	.L69
 653      00000000 
 654 0151 00000000 		.long	0
GAS LISTING /tmp/ccC5kB4k.s 			page 16


 655 0155 11000000 		.long	17
 656 0159 02000000 		.long	2
 657 015d 00000000 		.quad	.L70
 657      00000000 
 658 0165 00000000 		.long	0
 659 0169 20000000 		.long	32
 660 016d 04000000 		.long	4
 661 0171 00000000 		.quad	.L71
 661      00000000 
 662 0179 00000000 		.long	0
 663 017d 2E000000 		.long	46
 664 0181 06000000 		.long	6
 665 0185 00000000 		.quad	.L72
 665      00000000 
 666 018d 00000000 		.long	0
 667 0191 3F000000 		.long	63
 668 0195 08000000 		.long	8
 669 0199 00000000 		.quad	.L73
 669      00000000 
 670 01a1 00000000 		.long	0
 671 01a5 4E000000 		.long	78
 672 01a9 0A000000 		.long	10
 673 01ad 00000000 		.quad	.L74
 673      00000000 
 674 01b5 00000000 		.long	0
 675 01b9 65000000 		.long	101
 676 01bd 0C000000 		.long	12
 677 01c1 00000000 		.quad	.L75
 677      00000000 
 678 01c9 00000000 		.long	0
 679 01cd 75000000 		.long	117
 680 01d1 0E000000 		.long	14
 681 01d5 00000000 		.quad	.L76
 681      00000000 
 682 01dd 00000000 		.long	0
 683 01e1 83000000 		.long	131
 684 01e5 10000000 		.long	16
 685 01e9 00000000 		.quad	.L77
 685      00000000 
 686 01f1 00000000 		.long	0
 687 01f5 93000000 		.long	147
 688 01f9 12000000 		.long	18
 689              	.L79:
 690 01fd 63       		.byte	99
 691 01fe 69       		.byte	105
 692 01ff 6C       		.byte	108
 693 0200 6B       		.byte	107
 694 0201 5F       		.byte	95
 695 0202 65       		.byte	101
 696 0203 6E       		.byte	110
 697 0204 74       		.byte	116
 698 0205 65       		.byte	101
 699 0206 72       		.byte	114
 700 0207 5F       		.byte	95
 701 0208 62       		.byte	98
 702 0209 65       		.byte	101
 703 020a 67       		.byte	103
GAS LISTING /tmp/ccC5kB4k.s 			page 17


 704 020b 69       		.byte	105
 705 020c 6E       		.byte	110
 706 020d 00       		.byte	0
 707 020e 63       		.byte	99
 708 020f 69       		.byte	105
 709 0210 6C       		.byte	108
 710 0211 6B       		.byte	107
 711 0212 5F       		.byte	95
 712 0213 65       		.byte	101
 713 0214 6E       		.byte	110
 714 0215 74       		.byte	116
 715 0216 65       		.byte	101
 716 0217 72       		.byte	114
 717 0218 5F       		.byte	95
 718 0219 65       		.byte	101
 719 021a 6E       		.byte	110
 720 021b 64       		.byte	100
 721 021c 00       		.byte	0
 722 021d 63       		.byte	99
 723 021e 69       		.byte	105
 724 021f 6C       		.byte	108
 725 0220 6B       		.byte	107
 726 0221 5F       		.byte	95
 727 0222 73       		.byte	115
 728 0223 79       		.byte	121
 729 0224 6E       		.byte	110
 730 0225 63       		.byte	99
 731 0226 5F       		.byte	95
 732 0227 65       		.byte	101
 733 0228 6E       		.byte	110
 734 0229 64       		.byte	100
 735 022a 00       		.byte	0
 736 022b 63       		.byte	99
 737 022c 69       		.byte	105
 738 022d 6C       		.byte	108
 739 022e 6B       		.byte	107
 740 022f 5F       		.byte	95
 741 0230 6C       		.byte	108
 742 0231 65       		.byte	101
 743 0232 61       		.byte	97
 744 0233 76       		.byte	118
 745 0234 65       		.byte	101
 746 0235 5F       		.byte	95
 747 0236 62       		.byte	98
 748 0237 65       		.byte	101
 749 0238 67       		.byte	103
 750 0239 69       		.byte	105
 751 023a 6E       		.byte	110
 752 023b 00       		.byte	0
 753 023c 63       		.byte	99
 754 023d 69       		.byte	105
 755 023e 6C       		.byte	108
 756 023f 6B       		.byte	107
 757 0240 5F       		.byte	95
 758 0241 6C       		.byte	108
 759 0242 65       		.byte	101
 760 0243 61       		.byte	97
GAS LISTING /tmp/ccC5kB4k.s 			page 18


 761 0244 76       		.byte	118
 762 0245 65       		.byte	101
 763 0246 5F       		.byte	95
 764 0247 65       		.byte	101
 765 0248 6E       		.byte	110
 766 0249 64       		.byte	100
 767 024a 00       		.byte	0
 768 024b 63       		.byte	99
 769 024c 69       		.byte	105
 770 024d 6C       		.byte	108
 771 024e 6B       		.byte	107
 772 024f 5F       		.byte	95
 773 0250 73       		.byte	115
 774 0251 70       		.byte	112
 775 0252 61       		.byte	97
 776 0253 77       		.byte	119
 777 0254 6E       		.byte	110
 778 0255 5F       		.byte	95
 779 0256 6F       		.byte	111
 780 0257 72       		.byte	114
 781 0258 5F       		.byte	95
 782 0259 63       		.byte	99
 783 025a 6F       		.byte	111
 784 025b 6E       		.byte	110
 785 025c 74       		.byte	116
 786 025d 69       		.byte	105
 787 025e 6E       		.byte	110
 788 025f 75       		.byte	117
 789 0260 65       		.byte	101
 790 0261 00       		.byte	0
 791 0262 63       		.byte	99
 792 0263 69       		.byte	105
 793 0264 6C       		.byte	108
 794 0265 6B       		.byte	107
 795 0266 5F       		.byte	95
 796 0267 73       		.byte	115
 797 0268 79       		.byte	121
 798 0269 6E       		.byte	110
 799 026a 63       		.byte	99
 800 026b 5F       		.byte	95
 801 026c 62       		.byte	98
 802 026d 65       		.byte	101
 803 026e 67       		.byte	103
 804 026f 69       		.byte	105
 805 0270 6E       		.byte	110
 806 0271 00       		.byte	0
 807 0272 63       		.byte	99
 808 0273 69       		.byte	105
 809 0274 6C       		.byte	108
 810 0275 6B       		.byte	107
 811 0276 5F       		.byte	95
 812 0277 73       		.byte	115
 813 0278 79       		.byte	121
 814 0279 6E       		.byte	110
 815 027a 63       		.byte	99
 816 027b 5F       		.byte	95
 817 027c 65       		.byte	101
GAS LISTING /tmp/ccC5kB4k.s 			page 19


 818 027d 6E       		.byte	110
 819 027e 64       		.byte	100
 820 027f 00       		.byte	0
 821 0280 63       		.byte	99
 822 0281 69       		.byte	105
 823 0282 6C       		.byte	108
 824 0283 6B       		.byte	107
 825 0284 5F       		.byte	95
 826 0285 73       		.byte	115
 827 0286 79       		.byte	121
 828 0287 6E       		.byte	110
 829 0288 63       		.byte	99
 830 0289 5F       		.byte	95
 831 028a 62       		.byte	98
 832 028b 65       		.byte	101
 833 028c 67       		.byte	103
 834 028d 69       		.byte	105
 835 028e 6E       		.byte	110
 836 028f 00       		.byte	0
 837 0290 63       		.byte	99
 838 0291 69       		.byte	105
 839 0292 6C       		.byte	108
 840 0293 6B       		.byte	107
 841 0294 5F       		.byte	95
 842 0295 73       		.byte	115
 843 0296 70       		.byte	112
 844 0297 61       		.byte	97
 845 0298 77       		.byte	119
 846 0299 6E       		.byte	110
 847 029a 5F       		.byte	95
 848 029b 70       		.byte	112
 849 029c 72       		.byte	114
 850 029d 65       		.byte	101
 851 029e 70       		.byte	112
 852 029f 61       		.byte	97
 853 02a0 72       		.byte	114
 854 02a1 65       		.byte	101
 855 02a2 00       		.byte	0
 856              	.L80:
 857 02a3 0155     		.value	21761
 858 02a5 0155     		.value	21761
 859 02a7 0155     		.value	21761
 860 02a9 0155     		.value	21761
 861 02ab 0130     		.value	12289
 862 02ad 0155     		.value	21761
 863 02af 0155     		.value	21761
 864 02b1 0155     		.value	21761
 865 02b3 0155     		.value	21761
 866 02b5 0155     		.value	21761
 867              		.text
 868              		.p2align 4,,15
 869              		.globl	parallel_merge_sort
 870              		.type	parallel_merge_sort, @function
 871              	parallel_merge_sort:
 872              	.LFB22:
  58:parallel_merge.c **** 
  59:parallel_merge.c **** void parallel_merge_sort(uint32_t* arr, uint32_t* arrend) {
GAS LISTING /tmp/ccC5kB4k.s 			page 20


 873              		.loc 1 59 0
 874              		.cfi_startproc
 875              	.LVL62:
 876 0440 4154     		pushq	%r12
 877              		.cfi_def_cfa_offset 16
 878              		.cfi_offset 12, -16
 879 0442 48BAFCFF 		movabsq	$17179869180, %rdx
 879      FFFF0300 
 879      0000
 880 044c 4989F4   		movq	%rsi, %r12
 881 044f 55       		pushq	%rbp
 882              		.cfi_def_cfa_offset 24
 883              		.cfi_offset 6, -24
 884 0450 53       		pushq	%rbx
 885              		.cfi_def_cfa_offset 32
 886              		.cfi_offset 3, -32
 887              		.loc 1 59 0
 888 0451 4889FB   		movq	%rdi, %rbx
 889              	.LVL63:
  60:parallel_merge.c ****   uint32_t n = arrend - arr;
 890              		.loc 1 60 0
 891 0454 4889F7   		movq	%rsi, %rdi
 892              	.LVL64:
 893 0457 4829DF   		subq	%rbx, %rdi
  61:parallel_merge.c ****   uint32_t *aux = (uint32_t*)malloc(sizeof(uint32_t) * (n)); //auxilliary memory for merge sort
 894              		.loc 1 61 0
 895 045a 4821D7   		andq	%rdx, %rdi
 896 045d E8000000 		call	malloc
 896      00
 897              	.LVL65:
 898              	.LVL66:
  62:parallel_merge.c **** 
  63:parallel_merge.c ****   merge_sort_helper(arr, arrend, aux);
 899              		.loc 1 63 0
 900 0462 4889DF   		movq	%rbx, %rdi
 901 0465 4C89E6   		movq	%r12, %rsi
 902 0468 4889C2   		movq	%rax, %rdx
  61:parallel_merge.c ****   uint32_t *aux = (uint32_t*)malloc(sizeof(uint32_t) * (n)); //auxilliary memory for merge sort
 903              		.loc 1 61 0
 904 046b 4889C5   		movq	%rax, %rbp
 905              	.LVL67:
 906              		.loc 1 63 0
 907 046e E8ADFCFF 		call	merge_sort_helper
 907      FF
 908              	.LVL68:
 909              	.LVL69:
  64:parallel_merge.c **** 
  65:parallel_merge.c ****   free(aux);
  66:parallel_merge.c **** }
 910              		.loc 1 66 0
 911 0473 5B       		popq	%rbx
 912              		.cfi_def_cfa_offset 24
 913              	.LVL70:
  65:parallel_merge.c **** }
 914              		.loc 1 65 0
 915 0474 4889EF   		movq	%rbp, %rdi
 916              		.loc 1 66 0
GAS LISTING /tmp/ccC5kB4k.s 			page 21


 917 0477 5D       		popq	%rbp
 918              		.cfi_def_cfa_offset 16
 919              	.LVL71:
 920 0478 415C     		popq	%r12
 921              		.cfi_def_cfa_offset 8
 922              	.LVL72:
  65:parallel_merge.c **** }
 923              		.loc 1 65 0
 924 047a E9000000 		jmp	free
 924      00
 925              	.LVL73:
 926              	.LVL74:
 927              		.cfi_endproc
 928              	.LFE22:
 929              		.size	parallel_merge_sort, .-parallel_merge_sort
 930              	.Letext0:
 931              		.file 2 "/usr/include/stdint.h"
 932              		.file 3 "/afs/csail.mit.edu/proj/courses/6.172/cilkplus-4_8-install/lib/gcc/x86_64-unknown-linux-g
 933              		.file 4 "/usr/include/x86_64-linux-gnu/bits/types.h"
 934              		.file 5 "/usr/include/libio.h"
 935              		.file 6 "/usr/include/stdio.h"
 936              		.section	.debug_info,"",@progbits
 937              	.Ldebug_info0:
 938 0000 01040000 		.long	0x401
 939 0004 0400     		.value	0x4
 940 0006 00000000 		.long	.Ldebug_abbrev0
 941 000a 08       		.byte	0x8
 942 000b 01       		.uleb128 0x1
 943 000c 00000000 		.long	.LASF55
 944 0010 01       		.byte	0x1
 945 0011 00000000 		.long	.LASF56
 946 0015 00000000 		.long	.LASF57
 947 0019 00000000 		.quad	.Ltext0
 947      00000000 
 948 0021 7F040000 		.quad	.Letext0-.Ltext0
 948      00000000 
 949 0029 00000000 		.long	.Ldebug_line0
 950 002d 02       		.uleb128 0x2
 951 002e 08       		.byte	0x8
 952 002f 07       		.byte	0x7
 953 0030 00000000 		.long	.LASF0
 954 0034 02       		.uleb128 0x2
 955 0035 01       		.byte	0x1
 956 0036 08       		.byte	0x8
 957 0037 00000000 		.long	.LASF1
 958 003b 02       		.uleb128 0x2
 959 003c 01       		.byte	0x1
 960 003d 06       		.byte	0x6
 961 003e 00000000 		.long	.LASF2
 962 0042 02       		.uleb128 0x2
 963 0043 02       		.byte	0x2
 964 0044 05       		.byte	0x5
 965 0045 00000000 		.long	.LASF3
 966 0049 03       		.uleb128 0x3
 967 004a 04       		.byte	0x4
 968 004b 05       		.byte	0x5
 969 004c 696E7400 		.string	"int"
GAS LISTING /tmp/ccC5kB4k.s 			page 22


 970 0050 02       		.uleb128 0x2
 971 0051 08       		.byte	0x8
 972 0052 05       		.byte	0x5
 973 0053 00000000 		.long	.LASF4
 974 0057 02       		.uleb128 0x2
 975 0058 02       		.byte	0x2
 976 0059 07       		.byte	0x7
 977 005a 00000000 		.long	.LASF5
 978 005e 04       		.uleb128 0x4
 979 005f 00000000 		.long	.LASF8
 980 0063 02       		.byte	0x2
 981 0064 33       		.byte	0x33
 982 0065 69000000 		.long	0x69
 983 0069 02       		.uleb128 0x2
 984 006a 04       		.byte	0x4
 985 006b 07       		.byte	0x7
 986 006c 00000000 		.long	.LASF6
 987 0070 02       		.uleb128 0x2
 988 0071 08       		.byte	0x8
 989 0072 07       		.byte	0x7
 990 0073 00000000 		.long	.LASF7
 991 0077 04       		.uleb128 0x4
 992 0078 00000000 		.long	.LASF9
 993 007c 03       		.byte	0x3
 994 007d D4       		.byte	0xd4
 995 007e 70000000 		.long	0x70
 996 0082 04       		.uleb128 0x4
 997 0083 00000000 		.long	.LASF10
 998 0087 04       		.byte	0x4
 999 0088 83       		.byte	0x83
 1000 0089 50000000 		.long	0x50
 1001 008d 04       		.uleb128 0x4
 1002 008e 00000000 		.long	.LASF11
 1003 0092 04       		.byte	0x4
 1004 0093 84       		.byte	0x84
 1005 0094 50000000 		.long	0x50
 1006 0098 05       		.uleb128 0x5
 1007 0099 08       		.byte	0x8
 1008 009a 06       		.uleb128 0x6
 1009 009b 08       		.byte	0x8
 1010 009c A0000000 		.long	0xa0
 1011 00a0 02       		.uleb128 0x2
 1012 00a1 01       		.byte	0x1
 1013 00a2 06       		.byte	0x6
 1014 00a3 00000000 		.long	.LASF12
 1015 00a7 07       		.uleb128 0x7
 1016 00a8 00000000 		.long	.LASF42
 1017 00ac D8       		.byte	0xd8
 1018 00ad 05       		.byte	0x5
 1019 00ae F5       		.byte	0xf5
 1020 00af 27020000 		.long	0x227
 1021 00b3 08       		.uleb128 0x8
 1022 00b4 00000000 		.long	.LASF13
 1023 00b8 05       		.byte	0x5
 1024 00b9 F6       		.byte	0xf6
 1025 00ba 49000000 		.long	0x49
 1026 00be 00       		.byte	0
GAS LISTING /tmp/ccC5kB4k.s 			page 23


 1027 00bf 08       		.uleb128 0x8
 1028 00c0 00000000 		.long	.LASF14
 1029 00c4 05       		.byte	0x5
 1030 00c5 FB       		.byte	0xfb
 1031 00c6 9A000000 		.long	0x9a
 1032 00ca 08       		.byte	0x8
 1033 00cb 08       		.uleb128 0x8
 1034 00cc 00000000 		.long	.LASF15
 1035 00d0 05       		.byte	0x5
 1036 00d1 FC       		.byte	0xfc
 1037 00d2 9A000000 		.long	0x9a
 1038 00d6 10       		.byte	0x10
 1039 00d7 08       		.uleb128 0x8
 1040 00d8 00000000 		.long	.LASF16
 1041 00dc 05       		.byte	0x5
 1042 00dd FD       		.byte	0xfd
 1043 00de 9A000000 		.long	0x9a
 1044 00e2 18       		.byte	0x18
 1045 00e3 08       		.uleb128 0x8
 1046 00e4 00000000 		.long	.LASF17
 1047 00e8 05       		.byte	0x5
 1048 00e9 FE       		.byte	0xfe
 1049 00ea 9A000000 		.long	0x9a
 1050 00ee 20       		.byte	0x20
 1051 00ef 08       		.uleb128 0x8
 1052 00f0 00000000 		.long	.LASF18
 1053 00f4 05       		.byte	0x5
 1054 00f5 FF       		.byte	0xff
 1055 00f6 9A000000 		.long	0x9a
 1056 00fa 28       		.byte	0x28
 1057 00fb 09       		.uleb128 0x9
 1058 00fc 00000000 		.long	.LASF19
 1059 0100 05       		.byte	0x5
 1060 0101 0001     		.value	0x100
 1061 0103 9A000000 		.long	0x9a
 1062 0107 30       		.byte	0x30
 1063 0108 09       		.uleb128 0x9
 1064 0109 00000000 		.long	.LASF20
 1065 010d 05       		.byte	0x5
 1066 010e 0101     		.value	0x101
 1067 0110 9A000000 		.long	0x9a
 1068 0114 38       		.byte	0x38
 1069 0115 09       		.uleb128 0x9
 1070 0116 00000000 		.long	.LASF21
 1071 011a 05       		.byte	0x5
 1072 011b 0201     		.value	0x102
 1073 011d 9A000000 		.long	0x9a
 1074 0121 40       		.byte	0x40
 1075 0122 09       		.uleb128 0x9
 1076 0123 00000000 		.long	.LASF22
 1077 0127 05       		.byte	0x5
 1078 0128 0401     		.value	0x104
 1079 012a 9A000000 		.long	0x9a
 1080 012e 48       		.byte	0x48
 1081 012f 09       		.uleb128 0x9
 1082 0130 00000000 		.long	.LASF23
 1083 0134 05       		.byte	0x5
GAS LISTING /tmp/ccC5kB4k.s 			page 24


 1084 0135 0501     		.value	0x105
 1085 0137 9A000000 		.long	0x9a
 1086 013b 50       		.byte	0x50
 1087 013c 09       		.uleb128 0x9
 1088 013d 00000000 		.long	.LASF24
 1089 0141 05       		.byte	0x5
 1090 0142 0601     		.value	0x106
 1091 0144 9A000000 		.long	0x9a
 1092 0148 58       		.byte	0x58
 1093 0149 09       		.uleb128 0x9
 1094 014a 00000000 		.long	.LASF25
 1095 014e 05       		.byte	0x5
 1096 014f 0801     		.value	0x108
 1097 0151 5F020000 		.long	0x25f
 1098 0155 60       		.byte	0x60
 1099 0156 09       		.uleb128 0x9
 1100 0157 00000000 		.long	.LASF26
 1101 015b 05       		.byte	0x5
 1102 015c 0A01     		.value	0x10a
 1103 015e 65020000 		.long	0x265
 1104 0162 68       		.byte	0x68
 1105 0163 09       		.uleb128 0x9
 1106 0164 00000000 		.long	.LASF27
 1107 0168 05       		.byte	0x5
 1108 0169 0C01     		.value	0x10c
 1109 016b 49000000 		.long	0x49
 1110 016f 70       		.byte	0x70
 1111 0170 09       		.uleb128 0x9
 1112 0171 00000000 		.long	.LASF28
 1113 0175 05       		.byte	0x5
 1114 0176 1001     		.value	0x110
 1115 0178 49000000 		.long	0x49
 1116 017c 74       		.byte	0x74
 1117 017d 09       		.uleb128 0x9
 1118 017e 00000000 		.long	.LASF29
 1119 0182 05       		.byte	0x5
 1120 0183 1201     		.value	0x112
 1121 0185 82000000 		.long	0x82
 1122 0189 78       		.byte	0x78
 1123 018a 09       		.uleb128 0x9
 1124 018b 00000000 		.long	.LASF30
 1125 018f 05       		.byte	0x5
 1126 0190 1601     		.value	0x116
 1127 0192 57000000 		.long	0x57
 1128 0196 80       		.byte	0x80
 1129 0197 09       		.uleb128 0x9
 1130 0198 00000000 		.long	.LASF31
 1131 019c 05       		.byte	0x5
 1132 019d 1701     		.value	0x117
 1133 019f 3B000000 		.long	0x3b
 1134 01a3 82       		.byte	0x82
 1135 01a4 09       		.uleb128 0x9
 1136 01a5 00000000 		.long	.LASF32
 1137 01a9 05       		.byte	0x5
 1138 01aa 1801     		.value	0x118
 1139 01ac 6B020000 		.long	0x26b
 1140 01b0 83       		.byte	0x83
GAS LISTING /tmp/ccC5kB4k.s 			page 25


 1141 01b1 09       		.uleb128 0x9
 1142 01b2 00000000 		.long	.LASF33
 1143 01b6 05       		.byte	0x5
 1144 01b7 1C01     		.value	0x11c
 1145 01b9 7B020000 		.long	0x27b
 1146 01bd 88       		.byte	0x88
 1147 01be 09       		.uleb128 0x9
 1148 01bf 00000000 		.long	.LASF34
 1149 01c3 05       		.byte	0x5
 1150 01c4 2501     		.value	0x125
 1151 01c6 8D000000 		.long	0x8d
 1152 01ca 90       		.byte	0x90
 1153 01cb 09       		.uleb128 0x9
 1154 01cc 00000000 		.long	.LASF35
 1155 01d0 05       		.byte	0x5
 1156 01d1 2E01     		.value	0x12e
 1157 01d3 98000000 		.long	0x98
 1158 01d7 98       		.byte	0x98
 1159 01d8 09       		.uleb128 0x9
 1160 01d9 00000000 		.long	.LASF36
 1161 01dd 05       		.byte	0x5
 1162 01de 2F01     		.value	0x12f
 1163 01e0 98000000 		.long	0x98
 1164 01e4 A0       		.byte	0xa0
 1165 01e5 09       		.uleb128 0x9
 1166 01e6 00000000 		.long	.LASF37
 1167 01ea 05       		.byte	0x5
 1168 01eb 3001     		.value	0x130
 1169 01ed 98000000 		.long	0x98
 1170 01f1 A8       		.byte	0xa8
 1171 01f2 09       		.uleb128 0x9
 1172 01f3 00000000 		.long	.LASF38
 1173 01f7 05       		.byte	0x5
 1174 01f8 3101     		.value	0x131
 1175 01fa 98000000 		.long	0x98
 1176 01fe B0       		.byte	0xb0
 1177 01ff 09       		.uleb128 0x9
 1178 0200 00000000 		.long	.LASF39
 1179 0204 05       		.byte	0x5
 1180 0205 3201     		.value	0x132
 1181 0207 77000000 		.long	0x77
 1182 020b B8       		.byte	0xb8
 1183 020c 09       		.uleb128 0x9
 1184 020d 00000000 		.long	.LASF40
 1185 0211 05       		.byte	0x5
 1186 0212 3401     		.value	0x134
 1187 0214 49000000 		.long	0x49
 1188 0218 C0       		.byte	0xc0
 1189 0219 09       		.uleb128 0x9
 1190 021a 00000000 		.long	.LASF41
 1191 021e 05       		.byte	0x5
 1192 021f 3601     		.value	0x136
 1193 0221 81020000 		.long	0x281
 1194 0225 C4       		.byte	0xc4
 1195 0226 00       		.byte	0
 1196 0227 0A       		.uleb128 0xa
 1197 0228 00000000 		.long	.LASF58
GAS LISTING /tmp/ccC5kB4k.s 			page 26


 1198 022c 05       		.byte	0x5
 1199 022d 9A       		.byte	0x9a
 1200 022e 07       		.uleb128 0x7
 1201 022f 00000000 		.long	.LASF43
 1202 0233 18       		.byte	0x18
 1203 0234 05       		.byte	0x5
 1204 0235 A0       		.byte	0xa0
 1205 0236 5F020000 		.long	0x25f
 1206 023a 08       		.uleb128 0x8
 1207 023b 00000000 		.long	.LASF44
 1208 023f 05       		.byte	0x5
 1209 0240 A1       		.byte	0xa1
 1210 0241 5F020000 		.long	0x25f
 1211 0245 00       		.byte	0
 1212 0246 08       		.uleb128 0x8
 1213 0247 00000000 		.long	.LASF45
 1214 024b 05       		.byte	0x5
 1215 024c A2       		.byte	0xa2
 1216 024d 65020000 		.long	0x265
 1217 0251 08       		.byte	0x8
 1218 0252 08       		.uleb128 0x8
 1219 0253 00000000 		.long	.LASF46
 1220 0257 05       		.byte	0x5
 1221 0258 A6       		.byte	0xa6
 1222 0259 49000000 		.long	0x49
 1223 025d 10       		.byte	0x10
 1224 025e 00       		.byte	0
 1225 025f 06       		.uleb128 0x6
 1226 0260 08       		.byte	0x8
 1227 0261 2E020000 		.long	0x22e
 1228 0265 06       		.uleb128 0x6
 1229 0266 08       		.byte	0x8
 1230 0267 A7000000 		.long	0xa7
 1231 026b 0B       		.uleb128 0xb
 1232 026c A0000000 		.long	0xa0
 1233 0270 7B020000 		.long	0x27b
 1234 0274 0C       		.uleb128 0xc
 1235 0275 2D000000 		.long	0x2d
 1236 0279 00       		.byte	0
 1237 027a 00       		.byte	0
 1238 027b 06       		.uleb128 0x6
 1239 027c 08       		.byte	0x8
 1240 027d 27020000 		.long	0x227
 1241 0281 0B       		.uleb128 0xb
 1242 0282 A0000000 		.long	0xa0
 1243 0286 91020000 		.long	0x291
 1244 028a 0C       		.uleb128 0xc
 1245 028b 2D000000 		.long	0x2d
 1246 028f 13       		.byte	0x13
 1247 0290 00       		.byte	0
 1248 0291 02       		.uleb128 0x2
 1249 0292 08       		.byte	0x8
 1250 0293 05       		.byte	0x5
 1251 0294 00000000 		.long	.LASF47
 1252 0298 0D       		.uleb128 0xd
 1253 0299 00000000 		.long	.LASF59
 1254 029d 01       		.byte	0x1
GAS LISTING /tmp/ccC5kB4k.s 			page 27


 1255 029e 07       		.byte	0x7
 1256 029f 00000000 		.quad	.LFB20
 1256      00000000 
 1257 02a7 8B000000 		.quad	.LFE20-.LFB20
 1257      00000000 
 1258 02af 01       		.uleb128 0x1
 1259 02b0 9C       		.byte	0x9c
 1260 02b1 1C030000 		.long	0x31c
 1261 02b5 0E       		.uleb128 0xe
 1262 02b6 4300     		.string	"C"
 1263 02b8 01       		.byte	0x1
 1264 02b9 07       		.byte	0x7
 1265 02ba 1C030000 		.long	0x31c
 1266 02be 00000000 		.long	.LLST0
 1267 02c2 0E       		.uleb128 0xe
 1268 02c3 4100     		.string	"A"
 1269 02c5 01       		.byte	0x1
 1270 02c6 07       		.byte	0x7
 1271 02c7 1C030000 		.long	0x31c
 1272 02cb 00000000 		.long	.LLST1
 1273 02cf 0F       		.uleb128 0xf
 1274 02d0 00000000 		.long	.LASF48
 1275 02d4 01       		.byte	0x1
 1276 02d5 07       		.byte	0x7
 1277 02d6 1C030000 		.long	0x31c
 1278 02da 00000000 		.long	.LLST2
 1279 02de 0E       		.uleb128 0xe
 1280 02df 4200     		.string	"B"
 1281 02e1 01       		.byte	0x1
 1282 02e2 07       		.byte	0x7
 1283 02e3 1C030000 		.long	0x31c
 1284 02e7 00000000 		.long	.LLST3
 1285 02eb 0F       		.uleb128 0xf
 1286 02ec 00000000 		.long	.LASF49
 1287 02f0 01       		.byte	0x1
 1288 02f1 07       		.byte	0x7
 1289 02f2 1C030000 		.long	0x31c
 1290 02f6 00000000 		.long	.LLST4
 1291 02fa 10       		.uleb128 0x10
 1292 02fb 00000000 		.quad	.LBB2
 1292      00000000 
 1293 0303 32000000 		.quad	.LBE2-.LBB2
 1293      00000000 
 1294 030b 11       		.uleb128 0x11
 1295 030c 696E6300 		.string	"inc"
 1296 0310 01       		.byte	0x1
 1297 0311 0F       		.byte	0xf
 1298 0312 22030000 		.long	0x322
 1299 0316 00000000 		.long	.LLST5
 1300 031a 00       		.byte	0
 1301 031b 00       		.byte	0
 1302 031c 06       		.uleb128 0x6
 1303 031d 08       		.byte	0x8
 1304 031e 5E000000 		.long	0x5e
 1305 0322 02       		.uleb128 0x2
 1306 0323 01       		.byte	0x1
 1307 0324 02       		.byte	0x2
GAS LISTING /tmp/ccC5kB4k.s 			page 28


 1308 0325 00000000 		.long	.LASF50
 1309 0329 12       		.uleb128 0x12
 1310 032a 00000000 		.long	.LASF60
 1311 032e 01       		.byte	0x1
 1312 032f 1D       		.byte	0x1d
 1313 0330 00000000 		.quad	.LFB21
 1313      00000000 
 1314 0338 20030000 		.quad	.LFE21-.LFB21
 1314      00000000 
 1315 0340 01       		.uleb128 0x1
 1316 0341 9C       		.byte	0x9c
 1317 0342 90030000 		.long	0x390
 1318 0346 0F       		.uleb128 0xf
 1319 0347 00000000 		.long	.LASF51
 1320 034b 01       		.byte	0x1
 1321 034c 1D       		.byte	0x1d
 1322 034d 1C030000 		.long	0x31c
 1323 0351 00000000 		.long	.LLST6
 1324 0355 0E       		.uleb128 0xe
 1325 0356 656E6400 		.string	"end"
 1326 035a 01       		.byte	0x1
 1327 035b 1D       		.byte	0x1d
 1328 035c 1C030000 		.long	0x31c
 1329 0360 00000000 		.long	.LLST7
 1330 0364 0E       		.uleb128 0xe
 1331 0365 61757800 		.string	"aux"
 1332 0369 01       		.byte	0x1
 1333 036a 1D       		.byte	0x1d
 1334 036b 1C030000 		.long	0x31c
 1335 036f 00000000 		.long	.LLST8
 1336 0373 11       		.uleb128 0x11
 1337 0374 6E00     		.string	"n"
 1338 0376 01       		.byte	0x1
 1339 0377 1E       		.byte	0x1e
 1340 0378 5E000000 		.long	0x5e
 1341 037c 00000000 		.long	.LLST9
 1342 0380 11       		.uleb128 0x11
 1343 0381 6D696400 		.string	"mid"
 1344 0385 01       		.byte	0x1
 1345 0386 22       		.byte	0x22
 1346 0387 90030000 		.long	0x390
 1347 038b 00000000 		.long	.LLST10
 1348 038f 00       		.byte	0
 1349 0390 06       		.uleb128 0x6
 1350 0391 08       		.byte	0x8
 1351 0392 49000000 		.long	0x49
 1352 0396 13       		.uleb128 0x13
 1353 0397 00000000 		.long	.LASF61
 1354 039b 01       		.byte	0x1
 1355 039c 3B       		.byte	0x3b
 1356 039d 00000000 		.quad	.LFB22
 1356      00000000 
 1357 03a5 3F000000 		.quad	.LFE22-.LFB22
 1357      00000000 
 1358 03ad 01       		.uleb128 0x1
 1359 03ae 9C       		.byte	0x9c
 1360 03af EE030000 		.long	0x3ee
GAS LISTING /tmp/ccC5kB4k.s 			page 29


 1361 03b3 0E       		.uleb128 0xe
 1362 03b4 61727200 		.string	"arr"
 1363 03b8 01       		.byte	0x1
 1364 03b9 3B       		.byte	0x3b
 1365 03ba 1C030000 		.long	0x31c
 1366 03be 00000000 		.long	.LLST11
 1367 03c2 0F       		.uleb128 0xf
 1368 03c3 00000000 		.long	.LASF52
 1369 03c7 01       		.byte	0x1
 1370 03c8 3B       		.byte	0x3b
 1371 03c9 1C030000 		.long	0x31c
 1372 03cd 00000000 		.long	.LLST12
 1373 03d1 11       		.uleb128 0x11
 1374 03d2 6E00     		.string	"n"
 1375 03d4 01       		.byte	0x1
 1376 03d5 3C       		.byte	0x3c
 1377 03d6 5E000000 		.long	0x5e
 1378 03da 00000000 		.long	.LLST13
 1379 03de 11       		.uleb128 0x11
 1380 03df 61757800 		.string	"aux"
 1381 03e3 01       		.byte	0x1
 1382 03e4 3D       		.byte	0x3d
 1383 03e5 1C030000 		.long	0x31c
 1384 03e9 00000000 		.long	.LLST14
 1385 03ed 00       		.byte	0
 1386 03ee 14       		.uleb128 0x14
 1387 03ef 00000000 		.long	.LASF53
 1388 03f3 06       		.byte	0x6
 1389 03f4 A8       		.byte	0xa8
 1390 03f5 65020000 		.long	0x265
 1391 03f9 14       		.uleb128 0x14
 1392 03fa 00000000 		.long	.LASF54
 1393 03fe 06       		.byte	0x6
 1394 03ff A9       		.byte	0xa9
 1395 0400 65020000 		.long	0x265
 1396 0404 00       		.byte	0
 1397              		.section	.debug_abbrev,"",@progbits
 1398              	.Ldebug_abbrev0:
 1399 0000 01       		.uleb128 0x1
 1400 0001 11       		.uleb128 0x11
 1401 0002 01       		.byte	0x1
 1402 0003 25       		.uleb128 0x25
 1403 0004 0E       		.uleb128 0xe
 1404 0005 13       		.uleb128 0x13
 1405 0006 0B       		.uleb128 0xb
 1406 0007 03       		.uleb128 0x3
 1407 0008 0E       		.uleb128 0xe
 1408 0009 1B       		.uleb128 0x1b
 1409 000a 0E       		.uleb128 0xe
 1410 000b 11       		.uleb128 0x11
 1411 000c 01       		.uleb128 0x1
 1412 000d 12       		.uleb128 0x12
 1413 000e 07       		.uleb128 0x7
 1414 000f 10       		.uleb128 0x10
 1415 0010 17       		.uleb128 0x17
 1416 0011 00       		.byte	0
 1417 0012 00       		.byte	0
GAS LISTING /tmp/ccC5kB4k.s 			page 30


 1418 0013 02       		.uleb128 0x2
 1419 0014 24       		.uleb128 0x24
 1420 0015 00       		.byte	0
 1421 0016 0B       		.uleb128 0xb
 1422 0017 0B       		.uleb128 0xb
 1423 0018 3E       		.uleb128 0x3e
 1424 0019 0B       		.uleb128 0xb
 1425 001a 03       		.uleb128 0x3
 1426 001b 0E       		.uleb128 0xe
 1427 001c 00       		.byte	0
 1428 001d 00       		.byte	0
 1429 001e 03       		.uleb128 0x3
 1430 001f 24       		.uleb128 0x24
 1431 0020 00       		.byte	0
 1432 0021 0B       		.uleb128 0xb
 1433 0022 0B       		.uleb128 0xb
 1434 0023 3E       		.uleb128 0x3e
 1435 0024 0B       		.uleb128 0xb
 1436 0025 03       		.uleb128 0x3
 1437 0026 08       		.uleb128 0x8
 1438 0027 00       		.byte	0
 1439 0028 00       		.byte	0
 1440 0029 04       		.uleb128 0x4
 1441 002a 16       		.uleb128 0x16
 1442 002b 00       		.byte	0
 1443 002c 03       		.uleb128 0x3
 1444 002d 0E       		.uleb128 0xe
 1445 002e 3A       		.uleb128 0x3a
 1446 002f 0B       		.uleb128 0xb
 1447 0030 3B       		.uleb128 0x3b
 1448 0031 0B       		.uleb128 0xb
 1449 0032 49       		.uleb128 0x49
 1450 0033 13       		.uleb128 0x13
 1451 0034 00       		.byte	0
 1452 0035 00       		.byte	0
 1453 0036 05       		.uleb128 0x5
 1454 0037 0F       		.uleb128 0xf
 1455 0038 00       		.byte	0
 1456 0039 0B       		.uleb128 0xb
 1457 003a 0B       		.uleb128 0xb
 1458 003b 00       		.byte	0
 1459 003c 00       		.byte	0
 1460 003d 06       		.uleb128 0x6
 1461 003e 0F       		.uleb128 0xf
 1462 003f 00       		.byte	0
 1463 0040 0B       		.uleb128 0xb
 1464 0041 0B       		.uleb128 0xb
 1465 0042 49       		.uleb128 0x49
 1466 0043 13       		.uleb128 0x13
 1467 0044 00       		.byte	0
 1468 0045 00       		.byte	0
 1469 0046 07       		.uleb128 0x7
 1470 0047 13       		.uleb128 0x13
 1471 0048 01       		.byte	0x1
 1472 0049 03       		.uleb128 0x3
 1473 004a 0E       		.uleb128 0xe
 1474 004b 0B       		.uleb128 0xb
GAS LISTING /tmp/ccC5kB4k.s 			page 31


 1475 004c 0B       		.uleb128 0xb
 1476 004d 3A       		.uleb128 0x3a
 1477 004e 0B       		.uleb128 0xb
 1478 004f 3B       		.uleb128 0x3b
 1479 0050 0B       		.uleb128 0xb
 1480 0051 01       		.uleb128 0x1
 1481 0052 13       		.uleb128 0x13
 1482 0053 00       		.byte	0
 1483 0054 00       		.byte	0
 1484 0055 08       		.uleb128 0x8
 1485 0056 0D       		.uleb128 0xd
 1486 0057 00       		.byte	0
 1487 0058 03       		.uleb128 0x3
 1488 0059 0E       		.uleb128 0xe
 1489 005a 3A       		.uleb128 0x3a
 1490 005b 0B       		.uleb128 0xb
 1491 005c 3B       		.uleb128 0x3b
 1492 005d 0B       		.uleb128 0xb
 1493 005e 49       		.uleb128 0x49
 1494 005f 13       		.uleb128 0x13
 1495 0060 38       		.uleb128 0x38
 1496 0061 0B       		.uleb128 0xb
 1497 0062 00       		.byte	0
 1498 0063 00       		.byte	0
 1499 0064 09       		.uleb128 0x9
 1500 0065 0D       		.uleb128 0xd
 1501 0066 00       		.byte	0
 1502 0067 03       		.uleb128 0x3
 1503 0068 0E       		.uleb128 0xe
 1504 0069 3A       		.uleb128 0x3a
 1505 006a 0B       		.uleb128 0xb
 1506 006b 3B       		.uleb128 0x3b
 1507 006c 05       		.uleb128 0x5
 1508 006d 49       		.uleb128 0x49
 1509 006e 13       		.uleb128 0x13
 1510 006f 38       		.uleb128 0x38
 1511 0070 0B       		.uleb128 0xb
 1512 0071 00       		.byte	0
 1513 0072 00       		.byte	0
 1514 0073 0A       		.uleb128 0xa
 1515 0074 16       		.uleb128 0x16
 1516 0075 00       		.byte	0
 1517 0076 03       		.uleb128 0x3
 1518 0077 0E       		.uleb128 0xe
 1519 0078 3A       		.uleb128 0x3a
 1520 0079 0B       		.uleb128 0xb
 1521 007a 3B       		.uleb128 0x3b
 1522 007b 0B       		.uleb128 0xb
 1523 007c 00       		.byte	0
 1524 007d 00       		.byte	0
 1525 007e 0B       		.uleb128 0xb
 1526 007f 01       		.uleb128 0x1
 1527 0080 01       		.byte	0x1
 1528 0081 49       		.uleb128 0x49
 1529 0082 13       		.uleb128 0x13
 1530 0083 01       		.uleb128 0x1
 1531 0084 13       		.uleb128 0x13
GAS LISTING /tmp/ccC5kB4k.s 			page 32


 1532 0085 00       		.byte	0
 1533 0086 00       		.byte	0
 1534 0087 0C       		.uleb128 0xc
 1535 0088 21       		.uleb128 0x21
 1536 0089 00       		.byte	0
 1537 008a 49       		.uleb128 0x49
 1538 008b 13       		.uleb128 0x13
 1539 008c 2F       		.uleb128 0x2f
 1540 008d 0B       		.uleb128 0xb
 1541 008e 00       		.byte	0
 1542 008f 00       		.byte	0
 1543 0090 0D       		.uleb128 0xd
 1544 0091 2E       		.uleb128 0x2e
 1545 0092 01       		.byte	0x1
 1546 0093 03       		.uleb128 0x3
 1547 0094 0E       		.uleb128 0xe
 1548 0095 3A       		.uleb128 0x3a
 1549 0096 0B       		.uleb128 0xb
 1550 0097 3B       		.uleb128 0x3b
 1551 0098 0B       		.uleb128 0xb
 1552 0099 27       		.uleb128 0x27
 1553 009a 19       		.uleb128 0x19
 1554 009b 11       		.uleb128 0x11
 1555 009c 01       		.uleb128 0x1
 1556 009d 12       		.uleb128 0x12
 1557 009e 07       		.uleb128 0x7
 1558 009f 40       		.uleb128 0x40
 1559 00a0 18       		.uleb128 0x18
 1560 00a1 01       		.uleb128 0x1
 1561 00a2 13       		.uleb128 0x13
 1562 00a3 00       		.byte	0
 1563 00a4 00       		.byte	0
 1564 00a5 0E       		.uleb128 0xe
 1565 00a6 05       		.uleb128 0x5
 1566 00a7 00       		.byte	0
 1567 00a8 03       		.uleb128 0x3
 1568 00a9 08       		.uleb128 0x8
 1569 00aa 3A       		.uleb128 0x3a
 1570 00ab 0B       		.uleb128 0xb
 1571 00ac 3B       		.uleb128 0x3b
 1572 00ad 0B       		.uleb128 0xb
 1573 00ae 49       		.uleb128 0x49
 1574 00af 13       		.uleb128 0x13
 1575 00b0 02       		.uleb128 0x2
 1576 00b1 17       		.uleb128 0x17
 1577 00b2 00       		.byte	0
 1578 00b3 00       		.byte	0
 1579 00b4 0F       		.uleb128 0xf
 1580 00b5 05       		.uleb128 0x5
 1581 00b6 00       		.byte	0
 1582 00b7 03       		.uleb128 0x3
 1583 00b8 0E       		.uleb128 0xe
 1584 00b9 3A       		.uleb128 0x3a
 1585 00ba 0B       		.uleb128 0xb
 1586 00bb 3B       		.uleb128 0x3b
 1587 00bc 0B       		.uleb128 0xb
 1588 00bd 49       		.uleb128 0x49
GAS LISTING /tmp/ccC5kB4k.s 			page 33


 1589 00be 13       		.uleb128 0x13
 1590 00bf 02       		.uleb128 0x2
 1591 00c0 17       		.uleb128 0x17
 1592 00c1 00       		.byte	0
 1593 00c2 00       		.byte	0
 1594 00c3 10       		.uleb128 0x10
 1595 00c4 0B       		.uleb128 0xb
 1596 00c5 01       		.byte	0x1
 1597 00c6 11       		.uleb128 0x11
 1598 00c7 01       		.uleb128 0x1
 1599 00c8 12       		.uleb128 0x12
 1600 00c9 07       		.uleb128 0x7
 1601 00ca 00       		.byte	0
 1602 00cb 00       		.byte	0
 1603 00cc 11       		.uleb128 0x11
 1604 00cd 34       		.uleb128 0x34
 1605 00ce 00       		.byte	0
 1606 00cf 03       		.uleb128 0x3
 1607 00d0 08       		.uleb128 0x8
 1608 00d1 3A       		.uleb128 0x3a
 1609 00d2 0B       		.uleb128 0xb
 1610 00d3 3B       		.uleb128 0x3b
 1611 00d4 0B       		.uleb128 0xb
 1612 00d5 49       		.uleb128 0x49
 1613 00d6 13       		.uleb128 0x13
 1614 00d7 02       		.uleb128 0x2
 1615 00d8 17       		.uleb128 0x17
 1616 00d9 00       		.byte	0
 1617 00da 00       		.byte	0
 1618 00db 12       		.uleb128 0x12
 1619 00dc 2E       		.uleb128 0x2e
 1620 00dd 01       		.byte	0x1
 1621 00de 03       		.uleb128 0x3
 1622 00df 0E       		.uleb128 0xe
 1623 00e0 3A       		.uleb128 0x3a
 1624 00e1 0B       		.uleb128 0xb
 1625 00e2 3B       		.uleb128 0x3b
 1626 00e3 0B       		.uleb128 0xb
 1627 00e4 27       		.uleb128 0x27
 1628 00e5 19       		.uleb128 0x19
 1629 00e6 11       		.uleb128 0x11
 1630 00e7 01       		.uleb128 0x1
 1631 00e8 12       		.uleb128 0x12
 1632 00e9 07       		.uleb128 0x7
 1633 00ea 40       		.uleb128 0x40
 1634 00eb 18       		.uleb128 0x18
 1635 00ec 9642     		.uleb128 0x2116
 1636 00ee 19       		.uleb128 0x19
 1637 00ef 01       		.uleb128 0x1
 1638 00f0 13       		.uleb128 0x13
 1639 00f1 00       		.byte	0
 1640 00f2 00       		.byte	0
 1641 00f3 13       		.uleb128 0x13
 1642 00f4 2E       		.uleb128 0x2e
 1643 00f5 01       		.byte	0x1
 1644 00f6 3F       		.uleb128 0x3f
 1645 00f7 19       		.uleb128 0x19
GAS LISTING /tmp/ccC5kB4k.s 			page 34


 1646 00f8 03       		.uleb128 0x3
 1647 00f9 0E       		.uleb128 0xe
 1648 00fa 3A       		.uleb128 0x3a
 1649 00fb 0B       		.uleb128 0xb
 1650 00fc 3B       		.uleb128 0x3b
 1651 00fd 0B       		.uleb128 0xb
 1652 00fe 27       		.uleb128 0x27
 1653 00ff 19       		.uleb128 0x19
 1654 0100 11       		.uleb128 0x11
 1655 0101 01       		.uleb128 0x1
 1656 0102 12       		.uleb128 0x12
 1657 0103 07       		.uleb128 0x7
 1658 0104 40       		.uleb128 0x40
 1659 0105 18       		.uleb128 0x18
 1660 0106 01       		.uleb128 0x1
 1661 0107 13       		.uleb128 0x13
 1662 0108 00       		.byte	0
 1663 0109 00       		.byte	0
 1664 010a 14       		.uleb128 0x14
 1665 010b 34       		.uleb128 0x34
 1666 010c 00       		.byte	0
 1667 010d 03       		.uleb128 0x3
 1668 010e 0E       		.uleb128 0xe
 1669 010f 3A       		.uleb128 0x3a
 1670 0110 0B       		.uleb128 0xb
 1671 0111 3B       		.uleb128 0x3b
 1672 0112 0B       		.uleb128 0xb
 1673 0113 49       		.uleb128 0x49
 1674 0114 13       		.uleb128 0x13
 1675 0115 3F       		.uleb128 0x3f
 1676 0116 19       		.uleb128 0x19
 1677 0117 3C       		.uleb128 0x3c
 1678 0118 19       		.uleb128 0x19
 1679 0119 00       		.byte	0
 1680 011a 00       		.byte	0
 1681 011b 00       		.byte	0
 1682              		.section	.debug_loc,"",@progbits
 1683              	.Ldebug_loc0:
 1684              	.LLST0:
 1685 0000 00000000 		.quad	.LVL0-.Ltext0
 1685      00000000 
 1686 0008 19000000 		.quad	.LVL1-.Ltext0
 1686      00000000 
 1687 0010 0100     		.value	0x1
 1688 0012 55       		.byte	0x55
 1689 0013 19000000 		.quad	.LVL1-.Ltext0
 1689      00000000 
 1690 001b 70000000 		.quad	.LVL11-1-.Ltext0
 1690      00000000 
 1691 0023 0100     		.value	0x1
 1692 0025 59       		.byte	0x59
 1693 0026 00000000 		.quad	0
 1693      00000000 
 1694 002e 00000000 		.quad	0
 1694      00000000 
 1695              	.LLST1:
 1696 0036 00000000 		.quad	.LVL0-.Ltext0
GAS LISTING /tmp/ccC5kB4k.s 			page 35


 1696      00000000 
 1697 003e 53000000 		.quad	.LVL6-.Ltext0
 1697      00000000 
 1698 0046 0100     		.value	0x1
 1699 0048 54       		.byte	0x54
 1700 0049 53000000 		.quad	.LVL6-.Ltext0
 1700      00000000 
 1701 0051 70000000 		.quad	.LVL11-1-.Ltext0
 1701      00000000 
 1702 0059 0100     		.value	0x1
 1703 005b 54       		.byte	0x54
 1704 005c 00000000 		.quad	0
 1704      00000000 
 1705 0064 00000000 		.quad	0
 1705      00000000 
 1706              	.LLST2:
 1707 006c 00000000 		.quad	.LVL0-.Ltext0
 1707      00000000 
 1708 0074 5F000000 		.quad	.LVL9-.Ltext0
 1708      00000000 
 1709 007c 0100     		.value	0x1
 1710 007e 51       		.byte	0x51
 1711 007f 5F000000 		.quad	.LVL9-.Ltext0
 1711      00000000 
 1712 0087 8B000000 		.quad	.LFE20-.Ltext0
 1712      00000000 
 1713 008f 0400     		.value	0x4
 1714 0091 F3       		.byte	0xf3
 1715 0092 01       		.uleb128 0x1
 1716 0093 51       		.byte	0x51
 1717 0094 9F       		.byte	0x9f
 1718 0095 00000000 		.quad	0
 1718      00000000 
 1719 009d 00000000 		.quad	0
 1719      00000000 
 1720              	.LLST3:
 1721 00a5 00000000 		.quad	.LVL0-.Ltext0
 1721      00000000 
 1722 00ad 19000000 		.quad	.LVL1-.Ltext0
 1722      00000000 
 1723 00b5 0100     		.value	0x1
 1724 00b7 52       		.byte	0x52
 1725 00b8 19000000 		.quad	.LVL1-.Ltext0
 1725      00000000 
 1726 00c0 7F000000 		.quad	.LVL12-.Ltext0
 1726      00000000 
 1727 00c8 0100     		.value	0x1
 1728 00ca 53       		.byte	0x53
 1729 00cb 7F000000 		.quad	.LVL12-.Ltext0
 1729      00000000 
 1730 00d3 8A000000 		.quad	.LVL15-1-.Ltext0
 1730      00000000 
 1731 00db 0100     		.value	0x1
 1732 00dd 54       		.byte	0x54
 1733 00de 00000000 		.quad	0
 1733      00000000 
 1734 00e6 00000000 		.quad	0
GAS LISTING /tmp/ccC5kB4k.s 			page 36


 1734      00000000 
 1735              	.LLST4:
 1736 00ee 00000000 		.quad	.LVL0-.Ltext0
 1736      00000000 
 1737 00f6 19000000 		.quad	.LVL1-.Ltext0
 1737      00000000 
 1738 00fe 0100     		.value	0x1
 1739 0100 58       		.byte	0x58
 1740 0101 19000000 		.quad	.LVL1-.Ltext0
 1740      00000000 
 1741 0109 80000000 		.quad	.LVL13-.Ltext0
 1741      00000000 
 1742 0111 0100     		.value	0x1
 1743 0113 56       		.byte	0x56
 1744 0114 80000000 		.quad	.LVL13-.Ltext0
 1744      00000000 
 1745 011c 8B000000 		.quad	.LFE20-.Ltext0
 1745      00000000 
 1746 0124 0400     		.value	0x4
 1747 0126 F3       		.byte	0xf3
 1748 0127 01       		.uleb128 0x1
 1749 0128 58       		.byte	0x58
 1750 0129 9F       		.byte	0x9f
 1751 012a 00000000 		.quad	0
 1751      00000000 
 1752 0132 00000000 		.quad	0
 1752      00000000 
 1753              	.LLST5:
 1754 013a 19000000 		.quad	.LVL1-.Ltext0
 1754      00000000 
 1755 0142 25000000 		.quad	.LVL2-.Ltext0
 1755      00000000 
 1756 014a 0100     		.value	0x1
 1757 014c 52       		.byte	0x52
 1758 014d 46000000 		.quad	.LVL4-.Ltext0
 1758      00000000 
 1759 0155 4C000000 		.quad	.LVL5-.Ltext0
 1759      00000000 
 1760 015d 0100     		.value	0x1
 1761 015f 50       		.byte	0x50
 1762 0160 4C000000 		.quad	.LVL5-.Ltext0
 1762      00000000 
 1763 0168 5C000000 		.quad	.LVL8-.Ltext0
 1763      00000000 
 1764 0170 0100     		.value	0x1
 1765 0172 52       		.byte	0x52
 1766 0173 00000000 		.quad	0
 1766      00000000 
 1767 017b 00000000 		.quad	0
 1767      00000000 
 1768              	.LLST6:
 1769 0183 20010000 		.quad	.LVL25-.Ltext0
 1769      00000000 
 1770 018b 57010000 		.quad	.LVL26-.Ltext0
 1770      00000000 
 1771 0193 0100     		.value	0x1
 1772 0195 55       		.byte	0x55
GAS LISTING /tmp/ccC5kB4k.s 			page 37


 1773 0196 57010000 		.quad	.LVL26-.Ltext0
 1773      00000000 
 1774 019e F2010000 		.quad	.LVL34-.Ltext0
 1774      00000000 
 1775 01a6 0300     		.value	0x3
 1776 01a8 76       		.byte	0x76
 1777 01a9 E87E     		.sleb128 -152
 1778 01ab F2010000 		.quad	.LVL34-.Ltext0
 1778      00000000 
 1779 01b3 40040000 		.quad	.LFE21-.Ltext0
 1779      00000000 
 1780 01bb 0300     		.value	0x3
 1781 01bd 91       		.byte	0x91
 1782 01be D87E     		.sleb128 -168
 1783 01c0 00000000 		.quad	0
 1783      00000000 
 1784 01c8 00000000 		.quad	0
 1784      00000000 
 1785              	.LLST7:
 1786 01d0 20010000 		.quad	.LVL25-.Ltext0
 1786      00000000 
 1787 01d8 56010000 		.quad	.LVL26-1-.Ltext0
 1787      00000000 
 1788 01e0 0100     		.value	0x1
 1789 01e2 54       		.byte	0x54
 1790 01e3 56010000 		.quad	.LVL26-1-.Ltext0
 1790      00000000 
 1791 01eb F2010000 		.quad	.LVL34-.Ltext0
 1791      00000000 
 1792 01f3 0300     		.value	0x3
 1793 01f5 76       		.byte	0x76
 1794 01f6 E07E     		.sleb128 -160
 1795 01f8 F2010000 		.quad	.LVL34-.Ltext0
 1795      00000000 
 1796 0200 40040000 		.quad	.LFE21-.Ltext0
 1796      00000000 
 1797 0208 0300     		.value	0x3
 1798 020a 91       		.byte	0x91
 1799 020b D07E     		.sleb128 -176
 1800 020d 00000000 		.quad	0
 1800      00000000 
 1801 0215 00000000 		.quad	0
 1801      00000000 
 1802              	.LLST8:
 1803 021d 20010000 		.quad	.LVL25-.Ltext0
 1803      00000000 
 1804 0225 56010000 		.quad	.LVL26-1-.Ltext0
 1804      00000000 
 1805 022d 0100     		.value	0x1
 1806 022f 51       		.byte	0x51
 1807 0230 56010000 		.quad	.LVL26-1-.Ltext0
 1807      00000000 
 1808 0238 F2010000 		.quad	.LVL34-.Ltext0
 1808      00000000 
 1809 0240 0300     		.value	0x3
 1810 0242 76       		.byte	0x76
 1811 0243 F07E     		.sleb128 -144
GAS LISTING /tmp/ccC5kB4k.s 			page 38


 1812 0245 F2010000 		.quad	.LVL34-.Ltext0
 1812      00000000 
 1813 024d 40040000 		.quad	.LFE21-.Ltext0
 1813      00000000 
 1814 0255 0300     		.value	0x3
 1815 0257 91       		.byte	0x91
 1816 0258 E07E     		.sleb128 -160
 1817 025a 00000000 		.quad	0
 1817      00000000 
 1818 0262 00000000 		.quad	0
 1818      00000000 
 1819              	.LLST9:
 1820 026a 85010000 		.quad	.LVL29-.Ltext0
 1820      00000000 
 1821 0272 CB010000 		.quad	.LVL32-1-.Ltext0
 1821      00000000 
 1822 027a 0100     		.value	0x1
 1823 027c 50       		.byte	0x50
 1824 027d CB010000 		.quad	.LVL32-1-.Ltext0
 1824      00000000 
 1825 0285 F2010000 		.quad	.LVL34-.Ltext0
 1825      00000000 
 1826 028d 0300     		.value	0x3
 1827 028f 76       		.byte	0x76
 1828 0290 D47E     		.sleb128 -172
 1829 0292 FC010000 		.quad	.LVL35-.Ltext0
 1829      00000000 
 1830 029a 50020000 		.quad	.LVL39-.Ltext0
 1830      00000000 
 1831 02a2 0300     		.value	0x3
 1832 02a4 91       		.byte	0x91
 1833 02a5 C47E     		.sleb128 -188
 1834 02a7 5E020000 		.quad	.LVL40-.Ltext0
 1834      00000000 
 1835 02af 36030000 		.quad	.LVL50-.Ltext0
 1835      00000000 
 1836 02b7 0300     		.value	0x3
 1837 02b9 91       		.byte	0x91
 1838 02ba C47E     		.sleb128 -188
 1839 02bc 44030000 		.quad	.LVL51-.Ltext0
 1839      00000000 
 1840 02c4 66030000 		.quad	.LVL53-.Ltext0
 1840      00000000 
 1841 02cc 0300     		.value	0x3
 1842 02ce 91       		.byte	0x91
 1843 02cf C47E     		.sleb128 -188
 1844 02d1 82030000 		.quad	.LVL54-.Ltext0
 1844      00000000 
 1845 02d9 04040000 		.quad	.LVL58-.Ltext0
 1845      00000000 
 1846 02e1 0300     		.value	0x3
 1847 02e3 91       		.byte	0x91
 1848 02e4 C47E     		.sleb128 -188
 1849 02e6 04040000 		.quad	.LVL58-.Ltext0
 1849      00000000 
 1850 02ee 0F040000 		.quad	.LVL59-.Ltext0
 1850      00000000 
GAS LISTING /tmp/ccC5kB4k.s 			page 39


 1851 02f6 0100     		.value	0x1
 1852 02f8 50       		.byte	0x50
 1853 02f9 0F040000 		.quad	.LVL59-.Ltext0
 1853      00000000 
 1854 0301 40040000 		.quad	.LFE21-.Ltext0
 1854      00000000 
 1855 0309 0300     		.value	0x3
 1856 030b 91       		.byte	0x91
 1857 030c C47E     		.sleb128 -188
 1858 030e 00000000 		.quad	0
 1858      00000000 
 1859 0316 00000000 		.quad	0
 1859      00000000 
 1860              	.LLST10:
 1861 031e AB010000 		.quad	.LVL30-.Ltext0
 1861      00000000 
 1862 0326 F2010000 		.quad	.LVL34-.Ltext0
 1862      00000000 
 1863 032e 0100     		.value	0x1
 1864 0330 53       		.byte	0x53
 1865 0331 FC010000 		.quad	.LVL35-.Ltext0
 1865      00000000 
 1866 0339 50020000 		.quad	.LVL39-.Ltext0
 1866      00000000 
 1867 0341 0300     		.value	0x3
 1868 0343 91       		.byte	0x91
 1869 0344 C87E     		.sleb128 -184
 1870 0346 5E020000 		.quad	.LVL40-.Ltext0
 1870      00000000 
 1871 034e 36030000 		.quad	.LVL50-.Ltext0
 1871      00000000 
 1872 0356 0300     		.value	0x3
 1873 0358 91       		.byte	0x91
 1874 0359 C87E     		.sleb128 -184
 1875 035b 44030000 		.quad	.LVL51-.Ltext0
 1875      00000000 
 1876 0363 66030000 		.quad	.LVL53-.Ltext0
 1876      00000000 
 1877 036b 0300     		.value	0x3
 1878 036d 91       		.byte	0x91
 1879 036e C87E     		.sleb128 -184
 1880 0370 82030000 		.quad	.LVL54-.Ltext0
 1880      00000000 
 1881 0378 04040000 		.quad	.LVL58-.Ltext0
 1881      00000000 
 1882 0380 0300     		.value	0x3
 1883 0382 91       		.byte	0x91
 1884 0383 C87E     		.sleb128 -184
 1885 0385 04040000 		.quad	.LVL58-.Ltext0
 1885      00000000 
 1886 038d 13040000 		.quad	.LVL60-.Ltext0
 1886      00000000 
 1887 0395 0100     		.value	0x1
 1888 0397 53       		.byte	0x53
 1889 0398 13040000 		.quad	.LVL60-.Ltext0
 1889      00000000 
 1890 03a0 40040000 		.quad	.LFE21-.Ltext0
GAS LISTING /tmp/ccC5kB4k.s 			page 40


 1890      00000000 
 1891 03a8 0300     		.value	0x3
 1892 03aa 91       		.byte	0x91
 1893 03ab C87E     		.sleb128 -184
 1894 03ad 00000000 		.quad	0
 1894      00000000 
 1895 03b5 00000000 		.quad	0
 1895      00000000 
 1896              	.LLST11:
 1897 03bd 40040000 		.quad	.LVL62-.Ltext0
 1897      00000000 
 1898 03c5 57040000 		.quad	.LVL64-.Ltext0
 1898      00000000 
 1899 03cd 0100     		.value	0x1
 1900 03cf 55       		.byte	0x55
 1901 03d0 57040000 		.quad	.LVL64-.Ltext0
 1901      00000000 
 1902 03d8 74040000 		.quad	.LVL70-.Ltext0
 1902      00000000 
 1903 03e0 0100     		.value	0x1
 1904 03e2 53       		.byte	0x53
 1905 03e3 74040000 		.quad	.LVL70-.Ltext0
 1905      00000000 
 1906 03eb 7F040000 		.quad	.LFE22-.Ltext0
 1906      00000000 
 1907 03f3 0400     		.value	0x4
 1908 03f5 F3       		.byte	0xf3
 1909 03f6 01       		.uleb128 0x1
 1910 03f7 55       		.byte	0x55
 1911 03f8 9F       		.byte	0x9f
 1912 03f9 00000000 		.quad	0
 1912      00000000 
 1913 0401 00000000 		.quad	0
 1913      00000000 
 1914              	.LLST12:
 1915 0409 40040000 		.quad	.LVL62-.Ltext0
 1915      00000000 
 1916 0411 61040000 		.quad	.LVL66-1-.Ltext0
 1916      00000000 
 1917 0419 0100     		.value	0x1
 1918 041b 54       		.byte	0x54
 1919 041c 61040000 		.quad	.LVL66-1-.Ltext0
 1919      00000000 
 1920 0424 7A040000 		.quad	.LVL72-.Ltext0
 1920      00000000 
 1921 042c 0100     		.value	0x1
 1922 042e 5C       		.byte	0x5c
 1923 042f 7A040000 		.quad	.LVL72-.Ltext0
 1923      00000000 
 1924 0437 7F040000 		.quad	.LFE22-.Ltext0
 1924      00000000 
 1925 043f 0400     		.value	0x4
 1926 0441 F3       		.byte	0xf3
 1927 0442 01       		.uleb128 0x1
 1928 0443 54       		.byte	0x54
 1929 0444 9F       		.byte	0x9f
 1930 0445 00000000 		.quad	0
GAS LISTING /tmp/ccC5kB4k.s 			page 41


 1930      00000000 
 1931 044d 00000000 		.quad	0
 1931      00000000 
 1932              	.LLST13:
 1933 0455 54040000 		.quad	.LVL63-.Ltext0
 1933      00000000 
 1934 045d 57040000 		.quad	.LVL64-.Ltext0
 1934      00000000 
 1935 0465 0800     		.value	0x8
 1936 0467 74       		.byte	0x74
 1937 0468 00       		.sleb128 0
 1938 0469 75       		.byte	0x75
 1939 046a 00       		.sleb128 0
 1940 046b 1C       		.byte	0x1c
 1941 046c 34       		.byte	0x34
 1942 046d 1B       		.byte	0x1b
 1943 046e 9F       		.byte	0x9f
 1944 046f 57040000 		.quad	.LVL64-.Ltext0
 1944      00000000 
 1945 0477 61040000 		.quad	.LVL66-1-.Ltext0
 1945      00000000 
 1946 047f 0800     		.value	0x8
 1947 0481 74       		.byte	0x74
 1948 0482 00       		.sleb128 0
 1949 0483 73       		.byte	0x73
 1950 0484 00       		.sleb128 0
 1951 0485 1C       		.byte	0x1c
 1952 0486 34       		.byte	0x34
 1953 0487 1B       		.byte	0x1b
 1954 0488 9F       		.byte	0x9f
 1955 0489 61040000 		.quad	.LVL66-1-.Ltext0
 1955      00000000 
 1956 0491 74040000 		.quad	.LVL70-.Ltext0
 1956      00000000 
 1957 0499 0800     		.value	0x8
 1958 049b 7C       		.byte	0x7c
 1959 049c 00       		.sleb128 0
 1960 049d 73       		.byte	0x73
 1961 049e 00       		.sleb128 0
 1962 049f 1C       		.byte	0x1c
 1963 04a0 34       		.byte	0x34
 1964 04a1 1B       		.byte	0x1b
 1965 04a2 9F       		.byte	0x9f
 1966 04a3 74040000 		.quad	.LVL70-.Ltext0
 1966      00000000 
 1967 04ab 7A040000 		.quad	.LVL72-.Ltext0
 1967      00000000 
 1968 04b3 0900     		.value	0x9
 1969 04b5 7C       		.byte	0x7c
 1970 04b6 00       		.sleb128 0
 1971 04b7 F3       		.byte	0xf3
 1972 04b8 01       		.uleb128 0x1
 1973 04b9 55       		.byte	0x55
 1974 04ba 1C       		.byte	0x1c
 1975 04bb 34       		.byte	0x34
 1976 04bc 1B       		.byte	0x1b
 1977 04bd 9F       		.byte	0x9f
GAS LISTING /tmp/ccC5kB4k.s 			page 42


 1978 04be 7A040000 		.quad	.LVL72-.Ltext0
 1978      00000000 
 1979 04c6 7F040000 		.quad	.LFE22-.Ltext0
 1979      00000000 
 1980 04ce 0A00     		.value	0xa
 1981 04d0 F3       		.byte	0xf3
 1982 04d1 01       		.uleb128 0x1
 1983 04d2 54       		.byte	0x54
 1984 04d3 F3       		.byte	0xf3
 1985 04d4 01       		.uleb128 0x1
 1986 04d5 55       		.byte	0x55
 1987 04d6 1C       		.byte	0x1c
 1988 04d7 34       		.byte	0x34
 1989 04d8 1B       		.byte	0x1b
 1990 04d9 9F       		.byte	0x9f
 1991 04da 00000000 		.quad	0
 1991      00000000 
 1992 04e2 00000000 		.quad	0
 1992      00000000 
 1993              	.LLST14:
 1994 04ea 6E040000 		.quad	.LVL67-.Ltext0
 1994      00000000 
 1995 04f2 72040000 		.quad	.LVL69-1-.Ltext0
 1995      00000000 
 1996 04fa 0100     		.value	0x1
 1997 04fc 50       		.byte	0x50
 1998 04fd 72040000 		.quad	.LVL69-1-.Ltext0
 1998      00000000 
 1999 0505 78040000 		.quad	.LVL71-.Ltext0
 1999      00000000 
 2000 050d 0100     		.value	0x1
 2001 050f 56       		.byte	0x56
 2002 0510 78040000 		.quad	.LVL71-.Ltext0
 2002      00000000 
 2003 0518 7E040000 		.quad	.LVL74-1-.Ltext0
 2003      00000000 
 2004 0520 0100     		.value	0x1
 2005 0522 55       		.byte	0x55
 2006 0523 00000000 		.quad	0
 2006      00000000 
 2007 052b 00000000 		.quad	0
 2007      00000000 
 2008              		.section	.debug_aranges,"",@progbits
 2009 0000 2C000000 		.long	0x2c
 2010 0004 0200     		.value	0x2
 2011 0006 00000000 		.long	.Ldebug_info0
 2012 000a 08       		.byte	0x8
 2013 000b 00       		.byte	0
 2014 000c 0000     		.value	0
 2015 000e 0000     		.value	0
 2016 0010 00000000 		.quad	.Ltext0
 2016      00000000 
 2017 0018 7F040000 		.quad	.Letext0-.Ltext0
 2017      00000000 
 2018 0020 00000000 		.quad	0
 2018      00000000 
 2019 0028 00000000 		.quad	0
GAS LISTING /tmp/ccC5kB4k.s 			page 43


 2019      00000000 
 2020              		.section	.debug_line,"",@progbits
 2021              	.Ldebug_line0:
 2022 0000 A7010000 		.section	.debug_str,"MS",@progbits,1
 2022      0200FA00 
 2022      00000101 
 2022      FB0E0D00 
 2022      01010101 
 2023              	.LASF10:
 2024 0000 5F5F6F66 		.string	"__off_t"
 2024      665F7400 
 2025              	.LASF14:
 2026 0008 5F494F5F 		.string	"_IO_read_ptr"
 2026      72656164 
 2026      5F707472 
 2026      00
 2027              	.LASF26:
 2028 0015 5F636861 		.string	"_chain"
 2028      696E00
 2029              	.LASF9:
 2030 001c 73697A65 		.string	"size_t"
 2030      5F7400
 2031              	.LASF32:
 2032 0023 5F73686F 		.string	"_shortbuf"
 2032      72746275 
 2032      6600
 2033              	.LASF20:
 2034 002d 5F494F5F 		.string	"_IO_buf_base"
 2034      6275665F 
 2034      62617365 
 2034      00
 2035              	.LASF47:
 2036 003a 6C6F6E67 		.string	"long long int"
 2036      206C6F6E 
 2036      6720696E 
 2036      7400
 2037              	.LASF2:
 2038 0048 7369676E 		.string	"signed char"
 2038      65642063 
 2038      68617200 
 2039              	.LASF27:
 2040 0054 5F66696C 		.string	"_fileno"
 2040      656E6F00 
 2041              	.LASF15:
 2042 005c 5F494F5F 		.string	"_IO_read_end"
 2042      72656164 
 2042      5F656E64 
 2042      00
 2043              	.LASF57:
 2044 0069 2F616673 		.string	"/afs/athena.mit.edu/user/w/q/wqian94/JuliaCMerge/src/c"
 2044      2F617468 
 2044      656E612E 
 2044      6D69742E 
 2044      6564752F 
 2045              	.LASF4:
 2046 00a0 6C6F6E67 		.string	"long int"
 2046      20696E74 
GAS LISTING /tmp/ccC5kB4k.s 			page 44


 2046      00
 2047              	.LASF13:
 2048 00a9 5F666C61 		.string	"_flags"
 2048      677300
 2049              	.LASF21:
 2050 00b0 5F494F5F 		.string	"_IO_buf_end"
 2050      6275665F 
 2050      656E6400 
 2051              	.LASF30:
 2052 00bc 5F637572 		.string	"_cur_column"
 2052      5F636F6C 
 2052      756D6E00 
 2053              	.LASF29:
 2054 00c8 5F6F6C64 		.string	"_old_offset"
 2054      5F6F6666 
 2054      73657400 
 2055              	.LASF34:
 2056 00d4 5F6F6666 		.string	"_offset"
 2056      73657400 
 2057              	.LASF43:
 2058 00dc 5F494F5F 		.string	"_IO_marker"
 2058      6D61726B 
 2058      657200
 2059              	.LASF53:
 2060 00e7 73746469 		.string	"stdin"
 2060      6E00
 2061              	.LASF6:
 2062 00ed 756E7369 		.string	"unsigned int"
 2062      676E6564 
 2062      20696E74 
 2062      00
 2063              	.LASF7:
 2064 00fa 6C6F6E67 		.string	"long unsigned int"
 2064      20756E73 
 2064      69676E65 
 2064      6420696E 
 2064      7400
 2065              	.LASF18:
 2066 010c 5F494F5F 		.string	"_IO_write_ptr"
 2066      77726974 
 2066      655F7074 
 2066      7200
 2067              	.LASF45:
 2068 011a 5F736275 		.string	"_sbuf"
 2068      6600
 2069              	.LASF5:
 2070 0120 73686F72 		.string	"short unsigned int"
 2070      7420756E 
 2070      7369676E 
 2070      65642069 
 2070      6E7400
 2071              	.LASF22:
 2072 0133 5F494F5F 		.string	"_IO_save_base"
 2072      73617665 
 2072      5F626173 
 2072      6500
 2073              	.LASF33:
GAS LISTING /tmp/ccC5kB4k.s 			page 45


 2074 0141 5F6C6F63 		.string	"_lock"
 2074      6B00
 2075              	.LASF61:
 2076 0147 70617261 		.string	"parallel_merge_sort"
 2076      6C6C656C 
 2076      5F6D6572 
 2076      67655F73 
 2076      6F727400 
 2077              	.LASF28:
 2078 015b 5F666C61 		.string	"_flags2"
 2078      67733200 
 2079              	.LASF40:
 2080 0163 5F6D6F64 		.string	"_mode"
 2080      6500
 2081              	.LASF54:
 2082 0169 7374646F 		.string	"stdout"
 2082      757400
 2083              	.LASF0:
 2084 0170 73697A65 		.string	"sizetype"
 2084      74797065 
 2084      00
 2085              	.LASF19:
 2086 0179 5F494F5F 		.string	"_IO_write_end"
 2086      77726974 
 2086      655F656E 
 2086      6400
 2087              	.LASF55:
 2088 0187 474E5520 		.string	"GNU C 4.8.1 20130520 (prerelease) -mtune=generic -march=x86-64 -g -O3 -std=c99 -fcilkplus
 2088      4320342E 
 2088      382E3120 
 2088      32303133 
 2088      30353230 
 2089              	.LASF58:
 2090 01e1 5F494F5F 		.string	"_IO_lock_t"
 2090      6C6F636B 
 2090      5F7400
 2091              	.LASF42:
 2092 01ec 5F494F5F 		.string	"_IO_FILE"
 2092      46494C45 
 2092      00
 2093              	.LASF46:
 2094 01f5 5F706F73 		.string	"_pos"
 2094      00
 2095              	.LASF25:
 2096 01fa 5F6D6172 		.string	"_markers"
 2096      6B657273 
 2096      00
 2097              	.LASF49:
 2098 0203 42656E64 		.string	"Bend"
 2098      00
 2099              	.LASF50:
 2100 0208 5F426F6F 		.string	"_Bool"
 2100      6C00
 2101              	.LASF1:
 2102 020e 756E7369 		.string	"unsigned char"
 2102      676E6564 
 2102      20636861 
GAS LISTING /tmp/ccC5kB4k.s 			page 46


 2102      7200
 2103              	.LASF3:
 2104 021c 73686F72 		.string	"short int"
 2104      7420696E 
 2104      7400
 2105              	.LASF31:
 2106 0226 5F767461 		.string	"_vtable_offset"
 2106      626C655F 
 2106      6F666673 
 2106      657400
 2107              	.LASF48:
 2108 0235 41656E64 		.string	"Aend"
 2108      00
 2109              	.LASF8:
 2110 023a 75696E74 		.string	"uint32_t"
 2110      33325F74 
 2110      00
 2111              	.LASF52:
 2112 0243 61727265 		.string	"arrend"
 2112      6E6400
 2113              	.LASF12:
 2114 024a 63686172 		.string	"char"
 2114      00
 2115              	.LASF60:
 2116 024f 6D657267 		.string	"merge_sort_helper"
 2116      655F736F 
 2116      72745F68 
 2116      656C7065 
 2116      7200
 2117              	.LASF44:
 2118 0261 5F6E6578 		.string	"_next"
 2118      7400
 2119              	.LASF11:
 2120 0267 5F5F6F66 		.string	"__off64_t"
 2120      6636345F 
 2120      7400
 2121              	.LASF16:
 2122 0271 5F494F5F 		.string	"_IO_read_base"
 2122      72656164 
 2122      5F626173 
 2122      6500
 2123              	.LASF24:
 2124 027f 5F494F5F 		.string	"_IO_save_end"
 2124      73617665 
 2124      5F656E64 
 2124      00
 2125              	.LASF56:
 2126 028c 70617261 		.string	"parallel_merge.c"
 2126      6C6C656C 
 2126      5F6D6572 
 2126      67652E63 
 2126      00
 2127              	.LASF35:
 2128 029d 5F5F7061 		.string	"__pad1"
 2128      643100
 2129              	.LASF36:
 2130 02a4 5F5F7061 		.string	"__pad2"
GAS LISTING /tmp/ccC5kB4k.s 			page 47


 2130      643200
 2131              	.LASF37:
 2132 02ab 5F5F7061 		.string	"__pad3"
 2132      643300
 2133              	.LASF38:
 2134 02b2 5F5F7061 		.string	"__pad4"
 2134      643400
 2135              	.LASF39:
 2136 02b9 5F5F7061 		.string	"__pad5"
 2136      643500
 2137              	.LASF41:
 2138 02c0 5F756E75 		.string	"_unused2"
 2138      73656432 
 2138      00
 2139              	.LASF23:
 2140 02c9 5F494F5F 		.string	"_IO_backup_base"
 2140      6261636B 
 2140      75705F62 
 2140      61736500 
 2141              	.LASF51:
 2142 02d9 73746172 		.string	"start"
 2142      7400
 2143              	.LASF17:
 2144 02df 5F494F5F 		.string	"_IO_write_base"
 2144      77726974 
 2144      655F6261 
 2144      736500
 2145              	.LASF59:
 2146 02ee 6D657267 		.string	"merge"
 2146      6500
 2147              		.ident	"GCC: (GNU) 4.8.1 20130520 (prerelease)"
 2148              		.section	.note.GNU-stack,"",@progbits
