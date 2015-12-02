GAS LISTING /tmp/ccD2n34x.s 			page 1


   1              		.file	"serial_merge.c"
   2              		.text
   3              	.Ltext0:
   4              		.p2align 4,,15
   5              		.type	merge_sort_helper, @function
   6              	merge_sort_helper:
   7              	.LFB21:
   8              		.file 1 "serial_merge.c"
   1:serial_merge.c **** #include "merge.h"
   2:serial_merge.c **** 
   3:serial_merge.c **** //merge two sorted arrays A and B into array C
   4:serial_merge.c **** static void merge(uint32_t* C, uint32_t* A, uint32_t* Aend, uint32_t* B, uint32_t* Bend) {
   5:serial_merge.c ****   while (A < Aend && B < Bend) {
   6:serial_merge.c ****     if (*A < *B) {
   7:serial_merge.c ****       *C++ = *A++;
   8:serial_merge.c ****     } else {
   9:serial_merge.c ****       *C++ = *B++;
  10:serial_merge.c ****     }
  11:serial_merge.c ****   }
  12:serial_merge.c ****   while (A < Aend) {
  13:serial_merge.c ****     *C++ = *A++;
  14:serial_merge.c ****   }
  15:serial_merge.c ****   while (B < Bend) {
  16:serial_merge.c ****     *C++ = *B++;
  17:serial_merge.c ****   }
  18:serial_merge.c **** }
  19:serial_merge.c **** 
  20:serial_merge.c **** static void merge_sort_helper(uint32_t* start, uint32_t* end, uint32_t* aux) {
   9              		.loc 1 20 0
  10              		.cfi_startproc
  11              	.LVL0:
  12 0000 4157     		pushq	%r15
  13              		.cfi_def_cfa_offset 16
  14              		.cfi_offset 15, -16
  15 0002 4156     		pushq	%r14
  16              		.cfi_def_cfa_offset 24
  17              		.cfi_offset 14, -24
  18 0004 4155     		pushq	%r13
  19              		.cfi_def_cfa_offset 32
  20              		.cfi_offset 13, -32
  21 0006 4989FD   		movq	%rdi, %r13
  22 0009 4154     		pushq	%r12
  23              		.cfi_def_cfa_offset 40
  24              		.cfi_offset 12, -40
  21:serial_merge.c ****   uint32_t n = (end - start);
  25              		.loc 1 21 0
  26 000b 4989F4   		movq	%rsi, %r12
  27 000e 4929FC   		subq	%rdi, %r12
  20:serial_merge.c ****   uint32_t n = (end - start);
  28              		.loc 1 20 0
  29 0011 55       		pushq	%rbp
  30              		.cfi_def_cfa_offset 48
  31              		.cfi_offset 6, -48
  32              		.loc 1 21 0
  33 0012 49C1FC02 		sarq	$2, %r12
  34              	.LVL1:
  20:serial_merge.c ****   uint32_t n = (end - start);
GAS LISTING /tmp/ccD2n34x.s 			page 2


  35              		.loc 1 20 0
  36 0016 53       		pushq	%rbx
  37              		.cfi_def_cfa_offset 56
  38              		.cfi_offset 3, -56
  39 0017 4889F3   		movq	%rsi, %rbx
  40 001a 4883EC08 		subq	$8, %rsp
  41              		.cfi_def_cfa_offset 64
  22:serial_merge.c ****   if (n == 1) {
  42              		.loc 1 22 0
  43 001e 4183FC01 		cmpl	$1, %r12d
  44 0022 0F840802 		je	.L1
  44      0000
  23:serial_merge.c ****     return;
  24:serial_merge.c ****   }
  25:serial_merge.c ****   int* mid = start + n/2;
  45              		.loc 1 25 0
  46 0028 4589E7   		movl	%r12d, %r15d
  47 002b 4989D6   		movq	%rdx, %r14
  48 002e 41D1EF   		shrl	%r15d
  49 0031 49C1E702 		salq	$2, %r15
  50 0035 4A8D2C3F 		leaq	(%rdi,%r15), %rbp
  51              	.LVL2:
  26:serial_merge.c **** 
  27:serial_merge.c ****   merge_sort_helper(start, mid, aux);
  52              		.loc 1 27 0
  53 0039 4889EE   		movq	%rbp, %rsi
  54              	.LVL3:
  55 003c E8BFFFFF 		call	merge_sort_helper
  55      FF
  56              	.LVL4:
  57              	.LVL5:
  28:serial_merge.c ****   merge_sort_helper(mid, end, aux + n/2);
  58              		.loc 1 28 0
  59 0041 4B8D143E 		leaq	(%r14,%r15), %rdx
  60 0045 4889DE   		movq	%rbx, %rsi
  61 0048 4889EF   		movq	%rbp, %rdi
  62 004b E8B0FFFF 		call	merge_sort_helper
  62      FF
  63              	.LVL6:
  64              	.LVL7:
  65              	.LBB4:
  66              	.LBB5:
   5:serial_merge.c ****     if (*A < *B) {
  67              		.loc 1 5 0
  68 0050 4939ED   		cmpq	%rbp, %r13
  69 0053 4D89F2   		movq	%r14, %r10
  70 0056 4889E8   		movq	%rbp, %rax
  71 0059 4C89E9   		movq	%r13, %rcx
  72 005c 733C     		jae	.L3
  73 005e 4839EB   		cmpq	%rbp, %rbx
  74 0061 770A     		ja	.L4
  75 0063 EB35     		jmp	.L3
  76              	.LVL8:
  77              		.p2align 4,,10
  78 0065 0F1F00   		.p2align 3
  79              	.L53:
  80 0068 4839CD   		cmpq	%rcx, %rbp
GAS LISTING /tmp/ccD2n34x.s 			page 3


  81 006b 762D     		jbe	.L3
  82              	.LVL9:
  83              	.L4:
   6:serial_merge.c ****       *C++ = *A++;
  84              		.loc 1 6 0
  85 006d 448B01   		movl	(%rcx), %r8d
  86 0070 448B08   		movl	(%rax), %r9d
   7:serial_merge.c ****     } else {
  87              		.loc 1 7 0
  88 0073 488D5104 		leaq	4(%rcx), %rdx
   9:serial_merge.c ****     }
  89              		.loc 1 9 0
  90 0077 4C8D5804 		leaq	4(%rax), %r11
  91 007b 4983C204 		addq	$4, %r10
  92 007f 4539C8   		cmpl	%r9d, %r8d
  93 0082 490F43C3 		cmovae	%r11, %rax
  94 0086 480F42CA 		cmovb	%rdx, %rcx
  95 008a 4539C1   		cmpl	%r8d, %r9d
  96 008d 450F46C1 		cmovbe	%r9d, %r8d
   5:serial_merge.c ****     if (*A < *B) {
  97              		.loc 1 5 0
  98 0091 4839C3   		cmpq	%rax, %rbx
  99 0094 458942FC 		movl	%r8d, -4(%r10)
 100              	.LVL10:
 101 0098 77CE     		ja	.L53
 102              	.LVL11:
 103              	.L3:
  12:serial_merge.c ****     *C++ = *A++;
 104              		.loc 1 12 0
 105 009a 4839CD   		cmpq	%rcx, %rbp
 106 009d 0F86A100 		jbe	.L5
 106      0000
 107 00a3 488D7503 		leaq	3(%rbp), %rsi
 108 00a7 488D5104 		leaq	4(%rcx), %rdx
 109 00ab 4829D6   		subq	%rdx, %rsi
 110 00ae 48C1EE02 		shrq	$2, %rsi
 111 00b2 4883C601 		addq	$1, %rsi
 112 00b6 4883FE0B 		cmpq	$11, %rsi
 113 00ba 0F868001 		jbe	.L6
 113      0000
 114 00c0 498D7A10 		leaq	16(%r10), %rdi
 115 00c4 4839F9   		cmpq	%rdi, %rcx
 116 00c7 488D7910 		leaq	16(%rcx), %rdi
 117 00cb 410F93C0 		setae	%r8b
 118 00cf 4939FA   		cmpq	%rdi, %r10
 119 00d2 400F93C7 		setae	%dil
 120 00d6 4108F8   		orb	%dil, %r8b
 121 00d9 0F846101 		je	.L6
 121      0000
 122 00df 4989F0   		movq	%rsi, %r8
 123 00e2 31D2     		xorl	%edx, %edx
 124 00e4 31FF     		xorl	%edi, %edi
 125 00e6 49C1E802 		shrq	$2, %r8
 126 00ea 4E8D0C85 		leaq	0(,%r8,4), %r9
 126      00000000 
 127              	.LVL12:
 128              	.L11:
GAS LISTING /tmp/ccD2n34x.s 			page 4


  13:serial_merge.c ****   }
 129              		.loc 1 13 0
 130 00f2 F30F6F04 		movdqu	(%rcx,%rdx), %xmm0
 130      11
 131 00f7 4883C701 		addq	$1, %rdi
 132 00fb F3410F7F 		movdqu	%xmm0, (%r10,%rdx)
 132      0412
 133 0101 4883C210 		addq	$16, %rdx
 134 0105 4939F8   		cmpq	%rdi, %r8
 135 0108 77E8     		ja	.L11
 136 010a 4A8D3C8D 		leaq	0(,%r9,4), %rdi
 136      00000000 
 137 0112 4801F9   		addq	%rdi, %rcx
 138 0115 4C39CE   		cmpq	%r9, %rsi
 139 0118 498D143A 		leaq	(%r10,%rdi), %rdx
 140 011c 7422     		je	.L12
 141              	.LVL13:
 142 011e 8B39     		movl	(%rcx), %edi
 143 0120 893A     		movl	%edi, (%rdx)
 144 0122 488D7904 		leaq	4(%rcx), %rdi
 145              	.LVL14:
  12:serial_merge.c ****     *C++ = *A++;
 146              		.loc 1 12 0
 147 0126 4839FD   		cmpq	%rdi, %rbp
 148 0129 7615     		jbe	.L12
 149              	.LVL15:
  13:serial_merge.c ****   }
 150              		.loc 1 13 0
 151 012b 8B7904   		movl	4(%rcx), %edi
 152 012e 897A04   		movl	%edi, 4(%rdx)
 153 0131 488D7908 		leaq	8(%rcx), %rdi
 154              	.LVL16:
  12:serial_merge.c ****     *C++ = *A++;
 155              		.loc 1 12 0
 156 0135 4839FD   		cmpq	%rdi, %rbp
 157 0138 7606     		jbe	.L12
 158              	.LVL17:
  13:serial_merge.c ****   }
 159              		.loc 1 13 0
 160 013a 8B4908   		movl	8(%rcx), %ecx
 161              	.LVL18:
 162 013d 894A08   		movl	%ecx, 8(%rdx)
 163              	.LVL19:
 164              	.L12:
 165 0140 4D8D14B2 		leaq	(%r10,%rsi,4), %r10
 166              	.L5:
 167              	.LVL20:
  15:serial_merge.c ****     *C++ = *B++;
 168              		.loc 1 15 0
 169 0144 4839C3   		cmpq	%rax, %rbx
 170 0147 0F869F00 		jbe	.L20
 170      0000
 171 014d 488D4B03 		leaq	3(%rbx), %rcx
 172 0151 488D5004 		leaq	4(%rax), %rdx
 173 0155 498D7210 		leaq	16(%r10), %rsi
 174 0159 4829D1   		subq	%rdx, %rcx
 175 015c 48C1E902 		shrq	$2, %rcx
GAS LISTING /tmp/ccD2n34x.s 			page 5


 176 0160 4883C101 		addq	$1, %rcx
 177 0164 4839F0   		cmpq	%rsi, %rax
 178 0167 488D7010 		leaq	16(%rax), %rsi
 179 016b 400F93C7 		setae	%dil
 180 016f 4939F2   		cmpq	%rsi, %r10
 181 0172 400F93C6 		setae	%sil
 182 0176 4008F7   		orb	%sil, %dil
 183 0179 0F849500 		je	.L23
 183      0000
 184 017f 4883F90B 		cmpq	$11, %rcx
 185 0183 0F868B00 		jbe	.L23
 185      0000
 186 0189 4889CF   		movq	%rcx, %rdi
 187 018c 31D2     		xorl	%edx, %edx
 188 018e 31F6     		xorl	%esi, %esi
 189 0190 48C1EF02 		shrq	$2, %rdi
 190 0194 4C8D04BD 		leaq	0(,%rdi,4), %r8
 190      00000000 
 191              	.LVL21:
 192              	.L21:
  16:serial_merge.c ****   }
 193              		.loc 1 16 0
 194 019c F30F6F04 		movdqu	(%rax,%rdx), %xmm0
 194      10
 195 01a1 4883C601 		addq	$1, %rsi
 196 01a5 F3410F7F 		movdqu	%xmm0, (%r10,%rdx)
 196      0412
 197 01ab 4883C210 		addq	$16, %rdx
 198 01af 4839F7   		cmpq	%rsi, %rdi
 199 01b2 77E8     		ja	.L21
 200 01b4 4A8D1485 		leaq	0(,%r8,4), %rdx
 200      00000000 
 201 01bc 4901D2   		addq	%rdx, %r10
 202 01bf 4801D0   		addq	%rdx, %rax
 203 01c2 4C39C1   		cmpq	%r8, %rcx
 204 01c5 7425     		je	.L20
 205              	.LVL22:
 206 01c7 8B10     		movl	(%rax), %edx
 207 01c9 418912   		movl	%edx, (%r10)
 208 01cc 488D5004 		leaq	4(%rax), %rdx
 209              	.LVL23:
  15:serial_merge.c ****     *C++ = *B++;
 210              		.loc 1 15 0
 211 01d0 4839D3   		cmpq	%rdx, %rbx
 212 01d3 7617     		jbe	.L20
 213              	.LVL24:
  16:serial_merge.c ****   }
 214              		.loc 1 16 0
 215 01d5 8B5004   		movl	4(%rax), %edx
 216 01d8 41895204 		movl	%edx, 4(%r10)
 217 01dc 488D5008 		leaq	8(%rax), %rdx
 218              	.LVL25:
  15:serial_merge.c ****     *C++ = *B++;
 219              		.loc 1 15 0
 220 01e0 4839D3   		cmpq	%rdx, %rbx
 221 01e3 7607     		jbe	.L20
 222              	.LVL26:
GAS LISTING /tmp/ccD2n34x.s 			page 6


  16:serial_merge.c ****   }
 223              		.loc 1 16 0
 224 01e5 8B4008   		movl	8(%rax), %eax
 225              	.LVL27:
 226 01e8 41894208 		movl	%eax, 8(%r10)
 227              	.LVL28:
 228              	.L20:
 229              	.LBE5:
 230              	.LBE4:
  29:serial_merge.c **** 
  30:serial_merge.c ****   merge(aux, start, mid, mid, end);
  31:serial_merge.c ****   memcpy(start, aux, n * sizeof(uint32_t));
  32:serial_merge.c **** }
 231              		.loc 1 32 0
 232 01ec 4883C408 		addq	$8, %rsp
 233              		.cfi_remember_state
 234              		.cfi_def_cfa_offset 56
 235 01f0 4589E4   		movl	%r12d, %r12d
  31:serial_merge.c **** }
 236              		.loc 1 31 0
 237 01f3 4C89EF   		movq	%r13, %rdi
 238              		.loc 1 32 0
 239 01f6 5B       		popq	%rbx
 240              		.cfi_def_cfa_offset 48
 241              	.LVL29:
 242 01f7 5D       		popq	%rbp
 243              		.cfi_def_cfa_offset 40
 244              	.LVL30:
  31:serial_merge.c **** }
 245              		.loc 1 31 0
 246 01f8 4A8D14A5 		leaq	0(,%r12,4), %rdx
 246      00000000 
 247 0200 4C89F6   		movq	%r14, %rsi
 248              		.loc 1 32 0
 249 0203 415C     		popq	%r12
 250              		.cfi_def_cfa_offset 32
 251              	.LVL31:
 252 0205 415D     		popq	%r13
 253              		.cfi_def_cfa_offset 24
 254              	.LVL32:
 255 0207 415E     		popq	%r14
 256              		.cfi_def_cfa_offset 16
 257              	.LVL33:
 258 0209 415F     		popq	%r15
 259              		.cfi_def_cfa_offset 8
 260              	.LVL34:
  31:serial_merge.c **** }
 261              		.loc 1 31 0
 262 020b E9000000 		jmp	memcpy
 262      00
 263              	.LVL35:
 264              	.LVL36:
 265              		.p2align 4,,10
 266              		.p2align 3
 267              	.L54:
 268              		.cfi_restore_state
 269 0210 4883C204 		addq	$4, %rdx
GAS LISTING /tmp/ccD2n34x.s 			page 7


 270              	.LVL37:
 271              	.L23:
 272              	.LBB8:
 273              	.LBB6:
  16:serial_merge.c ****   }
 274              		.loc 1 16 0
 275 0214 8B42FC   		movl	-4(%rdx), %eax
 276 0217 4983C204 		addq	$4, %r10
 277              	.LVL38:
  15:serial_merge.c ****     *C++ = *B++;
 278              		.loc 1 15 0
 279 021b 4839D3   		cmpq	%rdx, %rbx
  16:serial_merge.c ****   }
 280              		.loc 1 16 0
 281 021e 418942FC 		movl	%eax, -4(%r10)
  15:serial_merge.c ****     *C++ = *B++;
 282              		.loc 1 15 0
 283 0222 77EC     		ja	.L54
 284 0224 EBC6     		jmp	.L20
 285              	.LVL39:
 286 0226 662E0F1F 		.p2align 4,,10
 286      84000000 
 286      0000
 287              		.p2align 3
 288              	.L1:
 289              	.LBE6:
 290              	.LBE8:
 291              		.loc 1 32 0
 292 0230 4883C408 		addq	$8, %rsp
 293              		.cfi_remember_state
 294              		.cfi_def_cfa_offset 56
 295 0234 5B       		popq	%rbx
 296              		.cfi_def_cfa_offset 48
 297              	.LVL40:
 298 0235 5D       		popq	%rbp
 299              		.cfi_def_cfa_offset 40
 300 0236 415C     		popq	%r12
 301              		.cfi_def_cfa_offset 32
 302              	.LVL41:
 303 0238 415D     		popq	%r13
 304              		.cfi_def_cfa_offset 24
 305 023a 415E     		popq	%r14
 306              		.cfi_def_cfa_offset 16
 307 023c 415F     		popq	%r15
 308              		.cfi_def_cfa_offset 8
 309 023e C3       		ret
 310              	.LVL42:
 311 023f 90       		.p2align 4,,10
 312              		.p2align 3
 313              	.L6:
 314              		.cfi_restore_state
 315              	.LBB9:
 316              	.LBB7:
  12:serial_merge.c ****     *C++ = *A++;
 317              		.loc 1 12 0
 318 0240 4C89D1   		movq	%r10, %rcx
 319              	.LVL43:
GAS LISTING /tmp/ccD2n34x.s 			page 8


 320 0243 EB07     		jmp	.L13
 321              	.LVL44:
 322              		.p2align 4,,10
 323 0245 0F1F00   		.p2align 3
 324              	.L55:
 325 0248 4883C204 		addq	$4, %rdx
 326              	.LVL45:
 327              	.L13:
  13:serial_merge.c ****   }
 328              		.loc 1 13 0
 329 024c 8B7AFC   		movl	-4(%rdx), %edi
 330 024f 4883C104 		addq	$4, %rcx
 331              	.LVL46:
  12:serial_merge.c ****     *C++ = *A++;
 332              		.loc 1 12 0
 333 0253 4839D5   		cmpq	%rdx, %rbp
  13:serial_merge.c ****   }
 334              		.loc 1 13 0
 335 0256 8979FC   		movl	%edi, -4(%rcx)
  12:serial_merge.c ****     *C++ = *A++;
 336              		.loc 1 12 0
 337 0259 77ED     		ja	.L55
 338 025b E9E0FEFF 		jmp	.L12
 338      FF
 339              	.LBE7:
 340              	.LBE9:
 341              		.cfi_endproc
 342              	.LFE21:
 343              		.size	merge_sort_helper, .-merge_sort_helper
 344              		.p2align 4,,15
 345              		.globl	serial_merge_sort
 346              		.type	serial_merge_sort, @function
 347              	serial_merge_sort:
 348              	.LFB22:
  33:serial_merge.c **** 
  34:serial_merge.c **** void serial_merge_sort(uint32_t* arr, uint32_t* arrend) {
 349              		.loc 1 34 0
 350              		.cfi_startproc
 351              	.LVL47:
 352 0260 4154     		pushq	%r12
 353              		.cfi_def_cfa_offset 16
 354              		.cfi_offset 12, -16
 355 0262 48BAFCFF 		movabsq	$17179869180, %rdx
 355      FFFF0300 
 355      0000
 356 026c 4989F4   		movq	%rsi, %r12
 357 026f 55       		pushq	%rbp
 358              		.cfi_def_cfa_offset 24
 359              		.cfi_offset 6, -24
 360 0270 53       		pushq	%rbx
 361              		.cfi_def_cfa_offset 32
 362              		.cfi_offset 3, -32
 363              		.loc 1 34 0
 364 0271 4889FB   		movq	%rdi, %rbx
 365              	.LVL48:
  35:serial_merge.c ****   uint32_t n = arrend - arr;
 366              		.loc 1 35 0
GAS LISTING /tmp/ccD2n34x.s 			page 9


 367 0274 4889F7   		movq	%rsi, %rdi
 368              	.LVL49:
 369 0277 4829DF   		subq	%rbx, %rdi
  36:serial_merge.c ****   uint32_t *aux = (uint32_t*)malloc(sizeof(uint32_t) * (n)); //auxilliary memory for merge sort
 370              		.loc 1 36 0
 371 027a 4821D7   		andq	%rdx, %rdi
 372 027d E8000000 		call	malloc
 372      00
 373              	.LVL50:
 374              	.LVL51:
  37:serial_merge.c **** 
  38:serial_merge.c ****   merge_sort_helper(arr, arrend, aux);
 375              		.loc 1 38 0
 376 0282 4889DF   		movq	%rbx, %rdi
 377 0285 4C89E6   		movq	%r12, %rsi
 378 0288 4889C2   		movq	%rax, %rdx
  36:serial_merge.c ****   uint32_t *aux = (uint32_t*)malloc(sizeof(uint32_t) * (n)); //auxilliary memory for merge sort
 379              		.loc 1 36 0
 380 028b 4889C5   		movq	%rax, %rbp
 381              	.LVL52:
 382              		.loc 1 38 0
 383 028e E86DFDFF 		call	merge_sort_helper
 383      FF
 384              	.LVL53:
 385              	.LVL54:
  39:serial_merge.c **** 
  40:serial_merge.c ****   free(aux);
  41:serial_merge.c **** }
 386              		.loc 1 41 0
 387 0293 5B       		popq	%rbx
 388              		.cfi_def_cfa_offset 24
 389              	.LVL55:
  40:serial_merge.c **** }
 390              		.loc 1 40 0
 391 0294 4889EF   		movq	%rbp, %rdi
 392              		.loc 1 41 0
 393 0297 5D       		popq	%rbp
 394              		.cfi_def_cfa_offset 16
 395              	.LVL56:
 396 0298 415C     		popq	%r12
 397              		.cfi_def_cfa_offset 8
 398              	.LVL57:
  40:serial_merge.c **** }
 399              		.loc 1 40 0
 400 029a E9000000 		jmp	free
 400      00
 401              	.LVL58:
 402              	.LVL59:
 403              		.cfi_endproc
 404              	.LFE22:
 405              		.size	serial_merge_sort, .-serial_merge_sort
 406              	.Letext0:
 407              		.file 2 "/usr/include/stdint.h"
 408              		.file 3 "/afs/csail.mit.edu/proj/courses/6.172/cilkplus-4_8-install/lib/gcc/x86_64-unknown-linux-g
 409              		.file 4 "/usr/include/x86_64-linux-gnu/bits/types.h"
 410              		.file 5 "/usr/include/libio.h"
 411              		.file 6 "/usr/include/stdio.h"
GAS LISTING /tmp/ccD2n34x.s 			page 10


 412              		.section	.debug_info,"",@progbits
 413              	.Ldebug_info0:
 414 0000 F5030000 		.long	0x3f5
 415 0004 0400     		.value	0x4
 416 0006 00000000 		.long	.Ldebug_abbrev0
 417 000a 08       		.byte	0x8
 418 000b 01       		.uleb128 0x1
 419 000c 00000000 		.long	.LASF54
 420 0010 01       		.byte	0x1
 421 0011 00000000 		.long	.LASF55
 422 0015 00000000 		.long	.LASF56
 423 0019 00000000 		.quad	.Ltext0
 423      00000000 
 424 0021 9F020000 		.quad	.Letext0-.Ltext0
 424      00000000 
 425 0029 00000000 		.long	.Ldebug_line0
 426 002d 02       		.uleb128 0x2
 427 002e 01       		.byte	0x1
 428 002f 06       		.byte	0x6
 429 0030 00000000 		.long	.LASF0
 430 0034 02       		.uleb128 0x2
 431 0035 02       		.byte	0x2
 432 0036 05       		.byte	0x5
 433 0037 00000000 		.long	.LASF1
 434 003b 03       		.uleb128 0x3
 435 003c 04       		.byte	0x4
 436 003d 05       		.byte	0x5
 437 003e 696E7400 		.string	"int"
 438 0042 02       		.uleb128 0x2
 439 0043 08       		.byte	0x8
 440 0044 05       		.byte	0x5
 441 0045 00000000 		.long	.LASF2
 442 0049 02       		.uleb128 0x2
 443 004a 01       		.byte	0x1
 444 004b 08       		.byte	0x8
 445 004c 00000000 		.long	.LASF3
 446 0050 02       		.uleb128 0x2
 447 0051 02       		.byte	0x2
 448 0052 07       		.byte	0x7
 449 0053 00000000 		.long	.LASF4
 450 0057 04       		.uleb128 0x4
 451 0058 00000000 		.long	.LASF7
 452 005c 02       		.byte	0x2
 453 005d 33       		.byte	0x33
 454 005e 62000000 		.long	0x62
 455 0062 02       		.uleb128 0x2
 456 0063 04       		.byte	0x4
 457 0064 07       		.byte	0x7
 458 0065 00000000 		.long	.LASF5
 459 0069 02       		.uleb128 0x2
 460 006a 08       		.byte	0x8
 461 006b 07       		.byte	0x7
 462 006c 00000000 		.long	.LASF6
 463 0070 04       		.uleb128 0x4
 464 0071 00000000 		.long	.LASF8
 465 0075 03       		.byte	0x3
 466 0076 D4       		.byte	0xd4
GAS LISTING /tmp/ccD2n34x.s 			page 11


 467 0077 69000000 		.long	0x69
 468 007b 04       		.uleb128 0x4
 469 007c 00000000 		.long	.LASF9
 470 0080 04       		.byte	0x4
 471 0081 83       		.byte	0x83
 472 0082 42000000 		.long	0x42
 473 0086 04       		.uleb128 0x4
 474 0087 00000000 		.long	.LASF10
 475 008b 04       		.byte	0x4
 476 008c 84       		.byte	0x84
 477 008d 42000000 		.long	0x42
 478 0091 02       		.uleb128 0x2
 479 0092 08       		.byte	0x8
 480 0093 07       		.byte	0x7
 481 0094 00000000 		.long	.LASF11
 482 0098 05       		.uleb128 0x5
 483 0099 08       		.byte	0x8
 484 009a 06       		.uleb128 0x6
 485 009b 08       		.byte	0x8
 486 009c A0000000 		.long	0xa0
 487 00a0 02       		.uleb128 0x2
 488 00a1 01       		.byte	0x1
 489 00a2 06       		.byte	0x6
 490 00a3 00000000 		.long	.LASF12
 491 00a7 07       		.uleb128 0x7
 492 00a8 00000000 		.long	.LASF42
 493 00ac D8       		.byte	0xd8
 494 00ad 05       		.byte	0x5
 495 00ae F5       		.byte	0xf5
 496 00af 27020000 		.long	0x227
 497 00b3 08       		.uleb128 0x8
 498 00b4 00000000 		.long	.LASF13
 499 00b8 05       		.byte	0x5
 500 00b9 F6       		.byte	0xf6
 501 00ba 3B000000 		.long	0x3b
 502 00be 00       		.byte	0
 503 00bf 08       		.uleb128 0x8
 504 00c0 00000000 		.long	.LASF14
 505 00c4 05       		.byte	0x5
 506 00c5 FB       		.byte	0xfb
 507 00c6 9A000000 		.long	0x9a
 508 00ca 08       		.byte	0x8
 509 00cb 08       		.uleb128 0x8
 510 00cc 00000000 		.long	.LASF15
 511 00d0 05       		.byte	0x5
 512 00d1 FC       		.byte	0xfc
 513 00d2 9A000000 		.long	0x9a
 514 00d6 10       		.byte	0x10
 515 00d7 08       		.uleb128 0x8
 516 00d8 00000000 		.long	.LASF16
 517 00dc 05       		.byte	0x5
 518 00dd FD       		.byte	0xfd
 519 00de 9A000000 		.long	0x9a
 520 00e2 18       		.byte	0x18
 521 00e3 08       		.uleb128 0x8
 522 00e4 00000000 		.long	.LASF17
 523 00e8 05       		.byte	0x5
GAS LISTING /tmp/ccD2n34x.s 			page 12


 524 00e9 FE       		.byte	0xfe
 525 00ea 9A000000 		.long	0x9a
 526 00ee 20       		.byte	0x20
 527 00ef 08       		.uleb128 0x8
 528 00f0 00000000 		.long	.LASF18
 529 00f4 05       		.byte	0x5
 530 00f5 FF       		.byte	0xff
 531 00f6 9A000000 		.long	0x9a
 532 00fa 28       		.byte	0x28
 533 00fb 09       		.uleb128 0x9
 534 00fc 00000000 		.long	.LASF19
 535 0100 05       		.byte	0x5
 536 0101 0001     		.value	0x100
 537 0103 9A000000 		.long	0x9a
 538 0107 30       		.byte	0x30
 539 0108 09       		.uleb128 0x9
 540 0109 00000000 		.long	.LASF20
 541 010d 05       		.byte	0x5
 542 010e 0101     		.value	0x101
 543 0110 9A000000 		.long	0x9a
 544 0114 38       		.byte	0x38
 545 0115 09       		.uleb128 0x9
 546 0116 00000000 		.long	.LASF21
 547 011a 05       		.byte	0x5
 548 011b 0201     		.value	0x102
 549 011d 9A000000 		.long	0x9a
 550 0121 40       		.byte	0x40
 551 0122 09       		.uleb128 0x9
 552 0123 00000000 		.long	.LASF22
 553 0127 05       		.byte	0x5
 554 0128 0401     		.value	0x104
 555 012a 9A000000 		.long	0x9a
 556 012e 48       		.byte	0x48
 557 012f 09       		.uleb128 0x9
 558 0130 00000000 		.long	.LASF23
 559 0134 05       		.byte	0x5
 560 0135 0501     		.value	0x105
 561 0137 9A000000 		.long	0x9a
 562 013b 50       		.byte	0x50
 563 013c 09       		.uleb128 0x9
 564 013d 00000000 		.long	.LASF24
 565 0141 05       		.byte	0x5
 566 0142 0601     		.value	0x106
 567 0144 9A000000 		.long	0x9a
 568 0148 58       		.byte	0x58
 569 0149 09       		.uleb128 0x9
 570 014a 00000000 		.long	.LASF25
 571 014e 05       		.byte	0x5
 572 014f 0801     		.value	0x108
 573 0151 5F020000 		.long	0x25f
 574 0155 60       		.byte	0x60
 575 0156 09       		.uleb128 0x9
 576 0157 00000000 		.long	.LASF26
 577 015b 05       		.byte	0x5
 578 015c 0A01     		.value	0x10a
 579 015e 65020000 		.long	0x265
 580 0162 68       		.byte	0x68
GAS LISTING /tmp/ccD2n34x.s 			page 13


 581 0163 09       		.uleb128 0x9
 582 0164 00000000 		.long	.LASF27
 583 0168 05       		.byte	0x5
 584 0169 0C01     		.value	0x10c
 585 016b 3B000000 		.long	0x3b
 586 016f 70       		.byte	0x70
 587 0170 09       		.uleb128 0x9
 588 0171 00000000 		.long	.LASF28
 589 0175 05       		.byte	0x5
 590 0176 1001     		.value	0x110
 591 0178 3B000000 		.long	0x3b
 592 017c 74       		.byte	0x74
 593 017d 09       		.uleb128 0x9
 594 017e 00000000 		.long	.LASF29
 595 0182 05       		.byte	0x5
 596 0183 1201     		.value	0x112
 597 0185 7B000000 		.long	0x7b
 598 0189 78       		.byte	0x78
 599 018a 09       		.uleb128 0x9
 600 018b 00000000 		.long	.LASF30
 601 018f 05       		.byte	0x5
 602 0190 1601     		.value	0x116
 603 0192 50000000 		.long	0x50
 604 0196 80       		.byte	0x80
 605 0197 09       		.uleb128 0x9
 606 0198 00000000 		.long	.LASF31
 607 019c 05       		.byte	0x5
 608 019d 1701     		.value	0x117
 609 019f 2D000000 		.long	0x2d
 610 01a3 82       		.byte	0x82
 611 01a4 09       		.uleb128 0x9
 612 01a5 00000000 		.long	.LASF32
 613 01a9 05       		.byte	0x5
 614 01aa 1801     		.value	0x118
 615 01ac 6B020000 		.long	0x26b
 616 01b0 83       		.byte	0x83
 617 01b1 09       		.uleb128 0x9
 618 01b2 00000000 		.long	.LASF33
 619 01b6 05       		.byte	0x5
 620 01b7 1C01     		.value	0x11c
 621 01b9 7B020000 		.long	0x27b
 622 01bd 88       		.byte	0x88
 623 01be 09       		.uleb128 0x9
 624 01bf 00000000 		.long	.LASF34
 625 01c3 05       		.byte	0x5
 626 01c4 2501     		.value	0x125
 627 01c6 86000000 		.long	0x86
 628 01ca 90       		.byte	0x90
 629 01cb 09       		.uleb128 0x9
 630 01cc 00000000 		.long	.LASF35
 631 01d0 05       		.byte	0x5
 632 01d1 2E01     		.value	0x12e
 633 01d3 98000000 		.long	0x98
 634 01d7 98       		.byte	0x98
 635 01d8 09       		.uleb128 0x9
 636 01d9 00000000 		.long	.LASF36
 637 01dd 05       		.byte	0x5
GAS LISTING /tmp/ccD2n34x.s 			page 14


 638 01de 2F01     		.value	0x12f
 639 01e0 98000000 		.long	0x98
 640 01e4 A0       		.byte	0xa0
 641 01e5 09       		.uleb128 0x9
 642 01e6 00000000 		.long	.LASF37
 643 01ea 05       		.byte	0x5
 644 01eb 3001     		.value	0x130
 645 01ed 98000000 		.long	0x98
 646 01f1 A8       		.byte	0xa8
 647 01f2 09       		.uleb128 0x9
 648 01f3 00000000 		.long	.LASF38
 649 01f7 05       		.byte	0x5
 650 01f8 3101     		.value	0x131
 651 01fa 98000000 		.long	0x98
 652 01fe B0       		.byte	0xb0
 653 01ff 09       		.uleb128 0x9
 654 0200 00000000 		.long	.LASF39
 655 0204 05       		.byte	0x5
 656 0205 3201     		.value	0x132
 657 0207 70000000 		.long	0x70
 658 020b B8       		.byte	0xb8
 659 020c 09       		.uleb128 0x9
 660 020d 00000000 		.long	.LASF40
 661 0211 05       		.byte	0x5
 662 0212 3401     		.value	0x134
 663 0214 3B000000 		.long	0x3b
 664 0218 C0       		.byte	0xc0
 665 0219 09       		.uleb128 0x9
 666 021a 00000000 		.long	.LASF41
 667 021e 05       		.byte	0x5
 668 021f 3601     		.value	0x136
 669 0221 81020000 		.long	0x281
 670 0225 C4       		.byte	0xc4
 671 0226 00       		.byte	0
 672 0227 0A       		.uleb128 0xa
 673 0228 00000000 		.long	.LASF57
 674 022c 05       		.byte	0x5
 675 022d 9A       		.byte	0x9a
 676 022e 07       		.uleb128 0x7
 677 022f 00000000 		.long	.LASF43
 678 0233 18       		.byte	0x18
 679 0234 05       		.byte	0x5
 680 0235 A0       		.byte	0xa0
 681 0236 5F020000 		.long	0x25f
 682 023a 08       		.uleb128 0x8
 683 023b 00000000 		.long	.LASF44
 684 023f 05       		.byte	0x5
 685 0240 A1       		.byte	0xa1
 686 0241 5F020000 		.long	0x25f
 687 0245 00       		.byte	0
 688 0246 08       		.uleb128 0x8
 689 0247 00000000 		.long	.LASF45
 690 024b 05       		.byte	0x5
 691 024c A2       		.byte	0xa2
 692 024d 65020000 		.long	0x265
 693 0251 08       		.byte	0x8
 694 0252 08       		.uleb128 0x8
GAS LISTING /tmp/ccD2n34x.s 			page 15


 695 0253 00000000 		.long	.LASF46
 696 0257 05       		.byte	0x5
 697 0258 A6       		.byte	0xa6
 698 0259 3B000000 		.long	0x3b
 699 025d 10       		.byte	0x10
 700 025e 00       		.byte	0
 701 025f 06       		.uleb128 0x6
 702 0260 08       		.byte	0x8
 703 0261 2E020000 		.long	0x22e
 704 0265 06       		.uleb128 0x6
 705 0266 08       		.byte	0x8
 706 0267 A7000000 		.long	0xa7
 707 026b 0B       		.uleb128 0xb
 708 026c A0000000 		.long	0xa0
 709 0270 7B020000 		.long	0x27b
 710 0274 0C       		.uleb128 0xc
 711 0275 91000000 		.long	0x91
 712 0279 00       		.byte	0
 713 027a 00       		.byte	0
 714 027b 06       		.uleb128 0x6
 715 027c 08       		.byte	0x8
 716 027d 27020000 		.long	0x227
 717 0281 0B       		.uleb128 0xb
 718 0282 A0000000 		.long	0xa0
 719 0286 91020000 		.long	0x291
 720 028a 0C       		.uleb128 0xc
 721 028b 91000000 		.long	0x91
 722 028f 13       		.byte	0x13
 723 0290 00       		.byte	0
 724 0291 02       		.uleb128 0x2
 725 0292 08       		.byte	0x8
 726 0293 05       		.byte	0x5
 727 0294 00000000 		.long	.LASF47
 728 0298 0D       		.uleb128 0xd
 729 0299 00000000 		.long	.LASF58
 730 029d 01       		.byte	0x1
 731 029e 04       		.byte	0x4
 732 029f 01       		.byte	0x1
 733 02a0 D6020000 		.long	0x2d6
 734 02a4 0E       		.uleb128 0xe
 735 02a5 4300     		.string	"C"
 736 02a7 01       		.byte	0x1
 737 02a8 04       		.byte	0x4
 738 02a9 D6020000 		.long	0x2d6
 739 02ad 0E       		.uleb128 0xe
 740 02ae 4100     		.string	"A"
 741 02b0 01       		.byte	0x1
 742 02b1 04       		.byte	0x4
 743 02b2 D6020000 		.long	0x2d6
 744 02b6 0F       		.uleb128 0xf
 745 02b7 00000000 		.long	.LASF48
 746 02bb 01       		.byte	0x1
 747 02bc 04       		.byte	0x4
 748 02bd D6020000 		.long	0x2d6
 749 02c1 0E       		.uleb128 0xe
 750 02c2 4200     		.string	"B"
 751 02c4 01       		.byte	0x1
GAS LISTING /tmp/ccD2n34x.s 			page 16


 752 02c5 04       		.byte	0x4
 753 02c6 D6020000 		.long	0x2d6
 754 02ca 0F       		.uleb128 0xf
 755 02cb 00000000 		.long	.LASF49
 756 02cf 01       		.byte	0x1
 757 02d0 04       		.byte	0x4
 758 02d1 D6020000 		.long	0x2d6
 759 02d5 00       		.byte	0
 760 02d6 06       		.uleb128 0x6
 761 02d7 08       		.byte	0x8
 762 02d8 57000000 		.long	0x57
 763 02dc 10       		.uleb128 0x10
 764 02dd 00000000 		.long	.LASF59
 765 02e1 01       		.byte	0x1
 766 02e2 14       		.byte	0x14
 767 02e3 00000000 		.quad	.LFB21
 767      00000000 
 768 02eb 60020000 		.quad	.LFE21-.LFB21
 768      00000000 
 769 02f3 01       		.uleb128 0x1
 770 02f4 9C       		.byte	0x9c
 771 02f5 84030000 		.long	0x384
 772 02f9 11       		.uleb128 0x11
 773 02fa 00000000 		.long	.LASF50
 774 02fe 01       		.byte	0x1
 775 02ff 14       		.byte	0x14
 776 0300 D6020000 		.long	0x2d6
 777 0304 00000000 		.long	.LLST0
 778 0308 12       		.uleb128 0x12
 779 0309 656E6400 		.string	"end"
 780 030d 01       		.byte	0x1
 781 030e 14       		.byte	0x14
 782 030f D6020000 		.long	0x2d6
 783 0313 00000000 		.long	.LLST1
 784 0317 12       		.uleb128 0x12
 785 0318 61757800 		.string	"aux"
 786 031c 01       		.byte	0x1
 787 031d 14       		.byte	0x14
 788 031e D6020000 		.long	0x2d6
 789 0322 00000000 		.long	.LLST2
 790 0326 13       		.uleb128 0x13
 791 0327 6E00     		.string	"n"
 792 0329 01       		.byte	0x1
 793 032a 15       		.byte	0x15
 794 032b 57000000 		.long	0x57
 795 032f 00000000 		.long	.LLST3
 796 0333 13       		.uleb128 0x13
 797 0334 6D696400 		.string	"mid"
 798 0338 01       		.byte	0x1
 799 0339 19       		.byte	0x19
 800 033a 84030000 		.long	0x384
 801 033e 00000000 		.long	.LLST4
 802 0342 14       		.uleb128 0x14
 803 0343 98020000 		.long	0x298
 804 0347 00000000 		.quad	.LBB4
 804      00000000 
 805 034f 00000000 		.long	.Ldebug_ranges0+0
GAS LISTING /tmp/ccD2n34x.s 			page 17


 806 0353 01       		.byte	0x1
 807 0354 1E       		.byte	0x1e
 808 0355 15       		.uleb128 0x15
 809 0356 CA020000 		.long	0x2ca
 810 035a 00000000 		.long	.LLST5
 811 035e 15       		.uleb128 0x15
 812 035f C1020000 		.long	0x2c1
 813 0363 00000000 		.long	.LLST6
 814 0367 15       		.uleb128 0x15
 815 0368 B6020000 		.long	0x2b6
 816 036c 00000000 		.long	.LLST7
 817 0370 15       		.uleb128 0x15
 818 0371 AD020000 		.long	0x2ad
 819 0375 00000000 		.long	.LLST8
 820 0379 15       		.uleb128 0x15
 821 037a A4020000 		.long	0x2a4
 822 037e 00000000 		.long	.LLST9
 823 0382 00       		.byte	0
 824 0383 00       		.byte	0
 825 0384 06       		.uleb128 0x6
 826 0385 08       		.byte	0x8
 827 0386 3B000000 		.long	0x3b
 828 038a 16       		.uleb128 0x16
 829 038b 00000000 		.long	.LASF60
 830 038f 01       		.byte	0x1
 831 0390 22       		.byte	0x22
 832 0391 00000000 		.quad	.LFB22
 832      00000000 
 833 0399 3F000000 		.quad	.LFE22-.LFB22
 833      00000000 
 834 03a1 01       		.uleb128 0x1
 835 03a2 9C       		.byte	0x9c
 836 03a3 E2030000 		.long	0x3e2
 837 03a7 12       		.uleb128 0x12
 838 03a8 61727200 		.string	"arr"
 839 03ac 01       		.byte	0x1
 840 03ad 22       		.byte	0x22
 841 03ae D6020000 		.long	0x2d6
 842 03b2 00000000 		.long	.LLST10
 843 03b6 11       		.uleb128 0x11
 844 03b7 00000000 		.long	.LASF51
 845 03bb 01       		.byte	0x1
 846 03bc 22       		.byte	0x22
 847 03bd D6020000 		.long	0x2d6
 848 03c1 00000000 		.long	.LLST11
 849 03c5 13       		.uleb128 0x13
 850 03c6 6E00     		.string	"n"
 851 03c8 01       		.byte	0x1
 852 03c9 23       		.byte	0x23
 853 03ca 57000000 		.long	0x57
 854 03ce 00000000 		.long	.LLST12
 855 03d2 13       		.uleb128 0x13
 856 03d3 61757800 		.string	"aux"
 857 03d7 01       		.byte	0x1
 858 03d8 24       		.byte	0x24
 859 03d9 D6020000 		.long	0x2d6
 860 03dd 00000000 		.long	.LLST13
GAS LISTING /tmp/ccD2n34x.s 			page 18


 861 03e1 00       		.byte	0
 862 03e2 17       		.uleb128 0x17
 863 03e3 00000000 		.long	.LASF52
 864 03e7 06       		.byte	0x6
 865 03e8 A8       		.byte	0xa8
 866 03e9 65020000 		.long	0x265
 867 03ed 17       		.uleb128 0x17
 868 03ee 00000000 		.long	.LASF53
 869 03f2 06       		.byte	0x6
 870 03f3 A9       		.byte	0xa9
 871 03f4 65020000 		.long	0x265
 872 03f8 00       		.byte	0
 873              		.section	.debug_abbrev,"",@progbits
 874              	.Ldebug_abbrev0:
 875 0000 01       		.uleb128 0x1
 876 0001 11       		.uleb128 0x11
 877 0002 01       		.byte	0x1
 878 0003 25       		.uleb128 0x25
 879 0004 0E       		.uleb128 0xe
 880 0005 13       		.uleb128 0x13
 881 0006 0B       		.uleb128 0xb
 882 0007 03       		.uleb128 0x3
 883 0008 0E       		.uleb128 0xe
 884 0009 1B       		.uleb128 0x1b
 885 000a 0E       		.uleb128 0xe
 886 000b 11       		.uleb128 0x11
 887 000c 01       		.uleb128 0x1
 888 000d 12       		.uleb128 0x12
 889 000e 07       		.uleb128 0x7
 890 000f 10       		.uleb128 0x10
 891 0010 17       		.uleb128 0x17
 892 0011 00       		.byte	0
 893 0012 00       		.byte	0
 894 0013 02       		.uleb128 0x2
 895 0014 24       		.uleb128 0x24
 896 0015 00       		.byte	0
 897 0016 0B       		.uleb128 0xb
 898 0017 0B       		.uleb128 0xb
 899 0018 3E       		.uleb128 0x3e
 900 0019 0B       		.uleb128 0xb
 901 001a 03       		.uleb128 0x3
 902 001b 0E       		.uleb128 0xe
 903 001c 00       		.byte	0
 904 001d 00       		.byte	0
 905 001e 03       		.uleb128 0x3
 906 001f 24       		.uleb128 0x24
 907 0020 00       		.byte	0
 908 0021 0B       		.uleb128 0xb
 909 0022 0B       		.uleb128 0xb
 910 0023 3E       		.uleb128 0x3e
 911 0024 0B       		.uleb128 0xb
 912 0025 03       		.uleb128 0x3
 913 0026 08       		.uleb128 0x8
 914 0027 00       		.byte	0
 915 0028 00       		.byte	0
 916 0029 04       		.uleb128 0x4
 917 002a 16       		.uleb128 0x16
GAS LISTING /tmp/ccD2n34x.s 			page 19


 918 002b 00       		.byte	0
 919 002c 03       		.uleb128 0x3
 920 002d 0E       		.uleb128 0xe
 921 002e 3A       		.uleb128 0x3a
 922 002f 0B       		.uleb128 0xb
 923 0030 3B       		.uleb128 0x3b
 924 0031 0B       		.uleb128 0xb
 925 0032 49       		.uleb128 0x49
 926 0033 13       		.uleb128 0x13
 927 0034 00       		.byte	0
 928 0035 00       		.byte	0
 929 0036 05       		.uleb128 0x5
 930 0037 0F       		.uleb128 0xf
 931 0038 00       		.byte	0
 932 0039 0B       		.uleb128 0xb
 933 003a 0B       		.uleb128 0xb
 934 003b 00       		.byte	0
 935 003c 00       		.byte	0
 936 003d 06       		.uleb128 0x6
 937 003e 0F       		.uleb128 0xf
 938 003f 00       		.byte	0
 939 0040 0B       		.uleb128 0xb
 940 0041 0B       		.uleb128 0xb
 941 0042 49       		.uleb128 0x49
 942 0043 13       		.uleb128 0x13
 943 0044 00       		.byte	0
 944 0045 00       		.byte	0
 945 0046 07       		.uleb128 0x7
 946 0047 13       		.uleb128 0x13
 947 0048 01       		.byte	0x1
 948 0049 03       		.uleb128 0x3
 949 004a 0E       		.uleb128 0xe
 950 004b 0B       		.uleb128 0xb
 951 004c 0B       		.uleb128 0xb
 952 004d 3A       		.uleb128 0x3a
 953 004e 0B       		.uleb128 0xb
 954 004f 3B       		.uleb128 0x3b
 955 0050 0B       		.uleb128 0xb
 956 0051 01       		.uleb128 0x1
 957 0052 13       		.uleb128 0x13
 958 0053 00       		.byte	0
 959 0054 00       		.byte	0
 960 0055 08       		.uleb128 0x8
 961 0056 0D       		.uleb128 0xd
 962 0057 00       		.byte	0
 963 0058 03       		.uleb128 0x3
 964 0059 0E       		.uleb128 0xe
 965 005a 3A       		.uleb128 0x3a
 966 005b 0B       		.uleb128 0xb
 967 005c 3B       		.uleb128 0x3b
 968 005d 0B       		.uleb128 0xb
 969 005e 49       		.uleb128 0x49
 970 005f 13       		.uleb128 0x13
 971 0060 38       		.uleb128 0x38
 972 0061 0B       		.uleb128 0xb
 973 0062 00       		.byte	0
 974 0063 00       		.byte	0
GAS LISTING /tmp/ccD2n34x.s 			page 20


 975 0064 09       		.uleb128 0x9
 976 0065 0D       		.uleb128 0xd
 977 0066 00       		.byte	0
 978 0067 03       		.uleb128 0x3
 979 0068 0E       		.uleb128 0xe
 980 0069 3A       		.uleb128 0x3a
 981 006a 0B       		.uleb128 0xb
 982 006b 3B       		.uleb128 0x3b
 983 006c 05       		.uleb128 0x5
 984 006d 49       		.uleb128 0x49
 985 006e 13       		.uleb128 0x13
 986 006f 38       		.uleb128 0x38
 987 0070 0B       		.uleb128 0xb
 988 0071 00       		.byte	0
 989 0072 00       		.byte	0
 990 0073 0A       		.uleb128 0xa
 991 0074 16       		.uleb128 0x16
 992 0075 00       		.byte	0
 993 0076 03       		.uleb128 0x3
 994 0077 0E       		.uleb128 0xe
 995 0078 3A       		.uleb128 0x3a
 996 0079 0B       		.uleb128 0xb
 997 007a 3B       		.uleb128 0x3b
 998 007b 0B       		.uleb128 0xb
 999 007c 00       		.byte	0
 1000 007d 00       		.byte	0
 1001 007e 0B       		.uleb128 0xb
 1002 007f 01       		.uleb128 0x1
 1003 0080 01       		.byte	0x1
 1004 0081 49       		.uleb128 0x49
 1005 0082 13       		.uleb128 0x13
 1006 0083 01       		.uleb128 0x1
 1007 0084 13       		.uleb128 0x13
 1008 0085 00       		.byte	0
 1009 0086 00       		.byte	0
 1010 0087 0C       		.uleb128 0xc
 1011 0088 21       		.uleb128 0x21
 1012 0089 00       		.byte	0
 1013 008a 49       		.uleb128 0x49
 1014 008b 13       		.uleb128 0x13
 1015 008c 2F       		.uleb128 0x2f
 1016 008d 0B       		.uleb128 0xb
 1017 008e 00       		.byte	0
 1018 008f 00       		.byte	0
 1019 0090 0D       		.uleb128 0xd
 1020 0091 2E       		.uleb128 0x2e
 1021 0092 01       		.byte	0x1
 1022 0093 03       		.uleb128 0x3
 1023 0094 0E       		.uleb128 0xe
 1024 0095 3A       		.uleb128 0x3a
 1025 0096 0B       		.uleb128 0xb
 1026 0097 3B       		.uleb128 0x3b
 1027 0098 0B       		.uleb128 0xb
 1028 0099 27       		.uleb128 0x27
 1029 009a 19       		.uleb128 0x19
 1030 009b 20       		.uleb128 0x20
 1031 009c 0B       		.uleb128 0xb
GAS LISTING /tmp/ccD2n34x.s 			page 21


 1032 009d 01       		.uleb128 0x1
 1033 009e 13       		.uleb128 0x13
 1034 009f 00       		.byte	0
 1035 00a0 00       		.byte	0
 1036 00a1 0E       		.uleb128 0xe
 1037 00a2 05       		.uleb128 0x5
 1038 00a3 00       		.byte	0
 1039 00a4 03       		.uleb128 0x3
 1040 00a5 08       		.uleb128 0x8
 1041 00a6 3A       		.uleb128 0x3a
 1042 00a7 0B       		.uleb128 0xb
 1043 00a8 3B       		.uleb128 0x3b
 1044 00a9 0B       		.uleb128 0xb
 1045 00aa 49       		.uleb128 0x49
 1046 00ab 13       		.uleb128 0x13
 1047 00ac 00       		.byte	0
 1048 00ad 00       		.byte	0
 1049 00ae 0F       		.uleb128 0xf
 1050 00af 05       		.uleb128 0x5
 1051 00b0 00       		.byte	0
 1052 00b1 03       		.uleb128 0x3
 1053 00b2 0E       		.uleb128 0xe
 1054 00b3 3A       		.uleb128 0x3a
 1055 00b4 0B       		.uleb128 0xb
 1056 00b5 3B       		.uleb128 0x3b
 1057 00b6 0B       		.uleb128 0xb
 1058 00b7 49       		.uleb128 0x49
 1059 00b8 13       		.uleb128 0x13
 1060 00b9 00       		.byte	0
 1061 00ba 00       		.byte	0
 1062 00bb 10       		.uleb128 0x10
 1063 00bc 2E       		.uleb128 0x2e
 1064 00bd 01       		.byte	0x1
 1065 00be 03       		.uleb128 0x3
 1066 00bf 0E       		.uleb128 0xe
 1067 00c0 3A       		.uleb128 0x3a
 1068 00c1 0B       		.uleb128 0xb
 1069 00c2 3B       		.uleb128 0x3b
 1070 00c3 0B       		.uleb128 0xb
 1071 00c4 27       		.uleb128 0x27
 1072 00c5 19       		.uleb128 0x19
 1073 00c6 11       		.uleb128 0x11
 1074 00c7 01       		.uleb128 0x1
 1075 00c8 12       		.uleb128 0x12
 1076 00c9 07       		.uleb128 0x7
 1077 00ca 40       		.uleb128 0x40
 1078 00cb 18       		.uleb128 0x18
 1079 00cc 01       		.uleb128 0x1
 1080 00cd 13       		.uleb128 0x13
 1081 00ce 00       		.byte	0
 1082 00cf 00       		.byte	0
 1083 00d0 11       		.uleb128 0x11
 1084 00d1 05       		.uleb128 0x5
 1085 00d2 00       		.byte	0
 1086 00d3 03       		.uleb128 0x3
 1087 00d4 0E       		.uleb128 0xe
 1088 00d5 3A       		.uleb128 0x3a
GAS LISTING /tmp/ccD2n34x.s 			page 22


 1089 00d6 0B       		.uleb128 0xb
 1090 00d7 3B       		.uleb128 0x3b
 1091 00d8 0B       		.uleb128 0xb
 1092 00d9 49       		.uleb128 0x49
 1093 00da 13       		.uleb128 0x13
 1094 00db 02       		.uleb128 0x2
 1095 00dc 17       		.uleb128 0x17
 1096 00dd 00       		.byte	0
 1097 00de 00       		.byte	0
 1098 00df 12       		.uleb128 0x12
 1099 00e0 05       		.uleb128 0x5
 1100 00e1 00       		.byte	0
 1101 00e2 03       		.uleb128 0x3
 1102 00e3 08       		.uleb128 0x8
 1103 00e4 3A       		.uleb128 0x3a
 1104 00e5 0B       		.uleb128 0xb
 1105 00e6 3B       		.uleb128 0x3b
 1106 00e7 0B       		.uleb128 0xb
 1107 00e8 49       		.uleb128 0x49
 1108 00e9 13       		.uleb128 0x13
 1109 00ea 02       		.uleb128 0x2
 1110 00eb 17       		.uleb128 0x17
 1111 00ec 00       		.byte	0
 1112 00ed 00       		.byte	0
 1113 00ee 13       		.uleb128 0x13
 1114 00ef 34       		.uleb128 0x34
 1115 00f0 00       		.byte	0
 1116 00f1 03       		.uleb128 0x3
 1117 00f2 08       		.uleb128 0x8
 1118 00f3 3A       		.uleb128 0x3a
 1119 00f4 0B       		.uleb128 0xb
 1120 00f5 3B       		.uleb128 0x3b
 1121 00f6 0B       		.uleb128 0xb
 1122 00f7 49       		.uleb128 0x49
 1123 00f8 13       		.uleb128 0x13
 1124 00f9 02       		.uleb128 0x2
 1125 00fa 17       		.uleb128 0x17
 1126 00fb 00       		.byte	0
 1127 00fc 00       		.byte	0
 1128 00fd 14       		.uleb128 0x14
 1129 00fe 1D       		.uleb128 0x1d
 1130 00ff 01       		.byte	0x1
 1131 0100 31       		.uleb128 0x31
 1132 0101 13       		.uleb128 0x13
 1133 0102 52       		.uleb128 0x52
 1134 0103 01       		.uleb128 0x1
 1135 0104 55       		.uleb128 0x55
 1136 0105 17       		.uleb128 0x17
 1137 0106 58       		.uleb128 0x58
 1138 0107 0B       		.uleb128 0xb
 1139 0108 59       		.uleb128 0x59
 1140 0109 0B       		.uleb128 0xb
 1141 010a 00       		.byte	0
 1142 010b 00       		.byte	0
 1143 010c 15       		.uleb128 0x15
 1144 010d 05       		.uleb128 0x5
 1145 010e 00       		.byte	0
GAS LISTING /tmp/ccD2n34x.s 			page 23


 1146 010f 31       		.uleb128 0x31
 1147 0110 13       		.uleb128 0x13
 1148 0111 02       		.uleb128 0x2
 1149 0112 17       		.uleb128 0x17
 1150 0113 00       		.byte	0
 1151 0114 00       		.byte	0
 1152 0115 16       		.uleb128 0x16
 1153 0116 2E       		.uleb128 0x2e
 1154 0117 01       		.byte	0x1
 1155 0118 3F       		.uleb128 0x3f
 1156 0119 19       		.uleb128 0x19
 1157 011a 03       		.uleb128 0x3
 1158 011b 0E       		.uleb128 0xe
 1159 011c 3A       		.uleb128 0x3a
 1160 011d 0B       		.uleb128 0xb
 1161 011e 3B       		.uleb128 0x3b
 1162 011f 0B       		.uleb128 0xb
 1163 0120 27       		.uleb128 0x27
 1164 0121 19       		.uleb128 0x19
 1165 0122 11       		.uleb128 0x11
 1166 0123 01       		.uleb128 0x1
 1167 0124 12       		.uleb128 0x12
 1168 0125 07       		.uleb128 0x7
 1169 0126 40       		.uleb128 0x40
 1170 0127 18       		.uleb128 0x18
 1171 0128 01       		.uleb128 0x1
 1172 0129 13       		.uleb128 0x13
 1173 012a 00       		.byte	0
 1174 012b 00       		.byte	0
 1175 012c 17       		.uleb128 0x17
 1176 012d 34       		.uleb128 0x34
 1177 012e 00       		.byte	0
 1178 012f 03       		.uleb128 0x3
 1179 0130 0E       		.uleb128 0xe
 1180 0131 3A       		.uleb128 0x3a
 1181 0132 0B       		.uleb128 0xb
 1182 0133 3B       		.uleb128 0x3b
 1183 0134 0B       		.uleb128 0xb
 1184 0135 49       		.uleb128 0x49
 1185 0136 13       		.uleb128 0x13
 1186 0137 3F       		.uleb128 0x3f
 1187 0138 19       		.uleb128 0x19
 1188 0139 3C       		.uleb128 0x3c
 1189 013a 19       		.uleb128 0x19
 1190 013b 00       		.byte	0
 1191 013c 00       		.byte	0
 1192 013d 00       		.byte	0
 1193              		.section	.debug_loc,"",@progbits
 1194              	.Ldebug_loc0:
 1195              	.LLST0:
 1196 0000 00000000 		.quad	.LVL0-.Ltext0
 1196      00000000 
 1197 0008 40000000 		.quad	.LVL5-1-.Ltext0
 1197      00000000 
 1198 0010 0100     		.value	0x1
 1199 0012 55       		.byte	0x55
 1200 0013 40000000 		.quad	.LVL5-1-.Ltext0
GAS LISTING /tmp/ccD2n34x.s 			page 24


 1200      00000000 
 1201 001b 07020000 		.quad	.LVL32-.Ltext0
 1201      00000000 
 1202 0023 0100     		.value	0x1
 1203 0025 5D       		.byte	0x5d
 1204 0026 07020000 		.quad	.LVL32-.Ltext0
 1204      00000000 
 1205 002e 0F020000 		.quad	.LVL36-1-.Ltext0
 1205      00000000 
 1206 0036 0100     		.value	0x1
 1207 0038 55       		.byte	0x55
 1208 0039 0F020000 		.quad	.LVL36-1-.Ltext0
 1208      00000000 
 1209 0041 10020000 		.quad	.LVL36-.Ltext0
 1209      00000000 
 1210 0049 0400     		.value	0x4
 1211 004b F3       		.byte	0xf3
 1212 004c 01       		.uleb128 0x1
 1213 004d 55       		.byte	0x55
 1214 004e 9F       		.byte	0x9f
 1215 004f 10020000 		.quad	.LVL36-.Ltext0
 1215      00000000 
 1216 0057 26020000 		.quad	.LVL39-.Ltext0
 1216      00000000 
 1217 005f 0100     		.value	0x1
 1218 0061 5D       		.byte	0x5d
 1219 0062 26020000 		.quad	.LVL39-.Ltext0
 1219      00000000 
 1220 006a 3F020000 		.quad	.LVL42-.Ltext0
 1220      00000000 
 1221 0072 0100     		.value	0x1
 1222 0074 55       		.byte	0x55
 1223 0075 3F020000 		.quad	.LVL42-.Ltext0
 1223      00000000 
 1224 007d 60020000 		.quad	.LFE21-.Ltext0
 1224      00000000 
 1225 0085 0100     		.value	0x1
 1226 0087 5D       		.byte	0x5d
 1227 0088 00000000 		.quad	0
 1227      00000000 
 1228 0090 00000000 		.quad	0
 1228      00000000 
 1229              	.LLST1:
 1230 0098 00000000 		.quad	.LVL0-.Ltext0
 1230      00000000 
 1231 00a0 3C000000 		.quad	.LVL3-.Ltext0
 1231      00000000 
 1232 00a8 0100     		.value	0x1
 1233 00aa 54       		.byte	0x54
 1234 00ab 3C000000 		.quad	.LVL3-.Ltext0
 1234      00000000 
 1235 00b3 F7010000 		.quad	.LVL29-.Ltext0
 1235      00000000 
 1236 00bb 0100     		.value	0x1
 1237 00bd 53       		.byte	0x53
 1238 00be F7010000 		.quad	.LVL29-.Ltext0
 1238      00000000 
GAS LISTING /tmp/ccD2n34x.s 			page 25


 1239 00c6 10020000 		.quad	.LVL36-.Ltext0
 1239      00000000 
 1240 00ce 0400     		.value	0x4
 1241 00d0 F3       		.byte	0xf3
 1242 00d1 01       		.uleb128 0x1
 1243 00d2 54       		.byte	0x54
 1244 00d3 9F       		.byte	0x9f
 1245 00d4 10020000 		.quad	.LVL36-.Ltext0
 1245      00000000 
 1246 00dc 35020000 		.quad	.LVL40-.Ltext0
 1246      00000000 
 1247 00e4 0100     		.value	0x1
 1248 00e6 53       		.byte	0x53
 1249 00e7 35020000 		.quad	.LVL40-.Ltext0
 1249      00000000 
 1250 00ef 3F020000 		.quad	.LVL42-.Ltext0
 1250      00000000 
 1251 00f7 0100     		.value	0x1
 1252 00f9 54       		.byte	0x54
 1253 00fa 3F020000 		.quad	.LVL42-.Ltext0
 1253      00000000 
 1254 0102 60020000 		.quad	.LFE21-.Ltext0
 1254      00000000 
 1255 010a 0100     		.value	0x1
 1256 010c 53       		.byte	0x53
 1257 010d 00000000 		.quad	0
 1257      00000000 
 1258 0115 00000000 		.quad	0
 1258      00000000 
 1259              	.LLST2:
 1260 011d 00000000 		.quad	.LVL0-.Ltext0
 1260      00000000 
 1261 0125 40000000 		.quad	.LVL5-1-.Ltext0
 1261      00000000 
 1262 012d 0100     		.value	0x1
 1263 012f 51       		.byte	0x51
 1264 0130 40000000 		.quad	.LVL5-1-.Ltext0
 1264      00000000 
 1265 0138 09020000 		.quad	.LVL33-.Ltext0
 1265      00000000 
 1266 0140 0100     		.value	0x1
 1267 0142 5E       		.byte	0x5e
 1268 0143 09020000 		.quad	.LVL33-.Ltext0
 1268      00000000 
 1269 014b 0F020000 		.quad	.LVL36-1-.Ltext0
 1269      00000000 
 1270 0153 0100     		.value	0x1
 1271 0155 54       		.byte	0x54
 1272 0156 0F020000 		.quad	.LVL36-1-.Ltext0
 1272      00000000 
 1273 015e 10020000 		.quad	.LVL36-.Ltext0
 1273      00000000 
 1274 0166 0400     		.value	0x4
 1275 0168 F3       		.byte	0xf3
 1276 0169 01       		.uleb128 0x1
 1277 016a 51       		.byte	0x51
 1278 016b 9F       		.byte	0x9f
GAS LISTING /tmp/ccD2n34x.s 			page 26


 1279 016c 10020000 		.quad	.LVL36-.Ltext0
 1279      00000000 
 1280 0174 26020000 		.quad	.LVL39-.Ltext0
 1280      00000000 
 1281 017c 0100     		.value	0x1
 1282 017e 5E       		.byte	0x5e
 1283 017f 26020000 		.quad	.LVL39-.Ltext0
 1283      00000000 
 1284 0187 3F020000 		.quad	.LVL42-.Ltext0
 1284      00000000 
 1285 018f 0100     		.value	0x1
 1286 0191 51       		.byte	0x51
 1287 0192 3F020000 		.quad	.LVL42-.Ltext0
 1287      00000000 
 1288 019a 60020000 		.quad	.LFE21-.Ltext0
 1288      00000000 
 1289 01a2 0100     		.value	0x1
 1290 01a4 5E       		.byte	0x5e
 1291 01a5 00000000 		.quad	0
 1291      00000000 
 1292 01ad 00000000 		.quad	0
 1292      00000000 
 1293              	.LLST3:
 1294 01b5 16000000 		.quad	.LVL1-.Ltext0
 1294      00000000 
 1295 01bd 05020000 		.quad	.LVL31-.Ltext0
 1295      00000000 
 1296 01c5 0100     		.value	0x1
 1297 01c7 5C       		.byte	0x5c
 1298 01c8 05020000 		.quad	.LVL31-.Ltext0
 1298      00000000 
 1299 01d0 07020000 		.quad	.LVL32-.Ltext0
 1299      00000000 
 1300 01d8 0900     		.value	0x9
 1301 01da F3       		.byte	0xf3
 1302 01db 01       		.uleb128 0x1
 1303 01dc 54       		.byte	0x54
 1304 01dd 7D       		.byte	0x7d
 1305 01de 00       		.sleb128 0
 1306 01df 1C       		.byte	0x1c
 1307 01e0 32       		.byte	0x32
 1308 01e1 26       		.byte	0x26
 1309 01e2 9F       		.byte	0x9f
 1310 01e3 07020000 		.quad	.LVL32-.Ltext0
 1310      00000000 
 1311 01eb 0F020000 		.quad	.LVL36-1-.Ltext0
 1311      00000000 
 1312 01f3 0900     		.value	0x9
 1313 01f5 F3       		.byte	0xf3
 1314 01f6 01       		.uleb128 0x1
 1315 01f7 54       		.byte	0x54
 1316 01f8 75       		.byte	0x75
 1317 01f9 00       		.sleb128 0
 1318 01fa 1C       		.byte	0x1c
 1319 01fb 32       		.byte	0x32
 1320 01fc 26       		.byte	0x26
 1321 01fd 9F       		.byte	0x9f
GAS LISTING /tmp/ccD2n34x.s 			page 27


 1322 01fe 0F020000 		.quad	.LVL36-1-.Ltext0
 1322      00000000 
 1323 0206 10020000 		.quad	.LVL36-.Ltext0
 1323      00000000 
 1324 020e 0A00     		.value	0xa
 1325 0210 F3       		.byte	0xf3
 1326 0211 01       		.uleb128 0x1
 1327 0212 54       		.byte	0x54
 1328 0213 F3       		.byte	0xf3
 1329 0214 01       		.uleb128 0x1
 1330 0215 55       		.byte	0x55
 1331 0216 1C       		.byte	0x1c
 1332 0217 32       		.byte	0x32
 1333 0218 26       		.byte	0x26
 1334 0219 9F       		.byte	0x9f
 1335 021a 10020000 		.quad	.LVL36-.Ltext0
 1335      00000000 
 1336 0222 38020000 		.quad	.LVL41-.Ltext0
 1336      00000000 
 1337 022a 0100     		.value	0x1
 1338 022c 5C       		.byte	0x5c
 1339 022d 38020000 		.quad	.LVL41-.Ltext0
 1339      00000000 
 1340 0235 3F020000 		.quad	.LVL42-.Ltext0
 1340      00000000 
 1341 023d 0800     		.value	0x8
 1342 023f 74       		.byte	0x74
 1343 0240 00       		.sleb128 0
 1344 0241 75       		.byte	0x75
 1345 0242 00       		.sleb128 0
 1346 0243 1C       		.byte	0x1c
 1347 0244 32       		.byte	0x32
 1348 0245 26       		.byte	0x26
 1349 0246 9F       		.byte	0x9f
 1350 0247 3F020000 		.quad	.LVL42-.Ltext0
 1350      00000000 
 1351 024f 60020000 		.quad	.LFE21-.Ltext0
 1351      00000000 
 1352 0257 0100     		.value	0x1
 1353 0259 5C       		.byte	0x5c
 1354 025a 00000000 		.quad	0
 1354      00000000 
 1355 0262 00000000 		.quad	0
 1355      00000000 
 1356              	.LLST4:
 1357 026a 39000000 		.quad	.LVL2-.Ltext0
 1357      00000000 
 1358 0272 F8010000 		.quad	.LVL30-.Ltext0
 1358      00000000 
 1359 027a 0100     		.value	0x1
 1360 027c 56       		.byte	0x56
 1361 027d F8010000 		.quad	.LVL30-.Ltext0
 1361      00000000 
 1362 0285 07020000 		.quad	.LVL32-.Ltext0
 1362      00000000 
 1363 028d 0600     		.value	0x6
 1364 028f 7D       		.byte	0x7d
GAS LISTING /tmp/ccD2n34x.s 			page 28


 1365 0290 00       		.sleb128 0
 1366 0291 7F       		.byte	0x7f
 1367 0292 00       		.sleb128 0
 1368 0293 22       		.byte	0x22
 1369 0294 9F       		.byte	0x9f
 1370 0295 07020000 		.quad	.LVL32-.Ltext0
 1370      00000000 
 1371 029d 0B020000 		.quad	.LVL34-.Ltext0
 1371      00000000 
 1372 02a5 0600     		.value	0x6
 1373 02a7 75       		.byte	0x75
 1374 02a8 00       		.sleb128 0
 1375 02a9 7F       		.byte	0x7f
 1376 02aa 00       		.sleb128 0
 1377 02ab 22       		.byte	0x22
 1378 02ac 9F       		.byte	0x9f
 1379 02ad 0B020000 		.quad	.LVL34-.Ltext0
 1379      00000000 
 1380 02b5 0F020000 		.quad	.LVL36-1-.Ltext0
 1380      00000000 
 1381 02bd 1600     		.value	0x16
 1382 02bf F3       		.byte	0xf3
 1383 02c0 01       		.uleb128 0x1
 1384 02c1 54       		.byte	0x54
 1385 02c2 75       		.byte	0x75
 1386 02c3 00       		.sleb128 0
 1387 02c4 1C       		.byte	0x1c
 1388 02c5 32       		.byte	0x32
 1389 02c6 26       		.byte	0x26
 1390 02c7 31       		.byte	0x31
 1391 02c8 25       		.byte	0x25
 1392 02c9 0C       		.byte	0xc
 1393 02ca FFFFFFFF 		.long	0xffffffff
 1394 02ce 1A       		.byte	0x1a
 1395 02cf 32       		.byte	0x32
 1396 02d0 24       		.byte	0x24
 1397 02d1 75       		.byte	0x75
 1398 02d2 00       		.sleb128 0
 1399 02d3 22       		.byte	0x22
 1400 02d4 9F       		.byte	0x9f
 1401 02d5 0F020000 		.quad	.LVL36-1-.Ltext0
 1401      00000000 
 1402 02dd 10020000 		.quad	.LVL36-.Ltext0
 1402      00000000 
 1403 02e5 1800     		.value	0x18
 1404 02e7 F3       		.byte	0xf3
 1405 02e8 01       		.uleb128 0x1
 1406 02e9 54       		.byte	0x54
 1407 02ea F3       		.byte	0xf3
 1408 02eb 01       		.uleb128 0x1
 1409 02ec 55       		.byte	0x55
 1410 02ed 1C       		.byte	0x1c
 1411 02ee 32       		.byte	0x32
 1412 02ef 26       		.byte	0x26
 1413 02f0 31       		.byte	0x31
 1414 02f1 25       		.byte	0x25
 1415 02f2 0C       		.byte	0xc
GAS LISTING /tmp/ccD2n34x.s 			page 29


 1416 02f3 FFFFFFFF 		.long	0xffffffff
 1417 02f7 1A       		.byte	0x1a
 1418 02f8 32       		.byte	0x32
 1419 02f9 24       		.byte	0x24
 1420 02fa F3       		.byte	0xf3
 1421 02fb 01       		.uleb128 0x1
 1422 02fc 55       		.byte	0x55
 1423 02fd 22       		.byte	0x22
 1424 02fe 9F       		.byte	0x9f
 1425 02ff 10020000 		.quad	.LVL36-.Ltext0
 1425      00000000 
 1426 0307 26020000 		.quad	.LVL39-.Ltext0
 1426      00000000 
 1427 030f 0100     		.value	0x1
 1428 0311 56       		.byte	0x56
 1429 0312 3F020000 		.quad	.LVL42-.Ltext0
 1429      00000000 
 1430 031a 60020000 		.quad	.LFE21-.Ltext0
 1430      00000000 
 1431 0322 0100     		.value	0x1
 1432 0324 56       		.byte	0x56
 1433 0325 00000000 		.quad	0
 1433      00000000 
 1434 032d 00000000 		.quad	0
 1434      00000000 
 1435              	.LLST5:
 1436 0335 50000000 		.quad	.LVL7-.Ltext0
 1436      00000000 
 1437 033d F7010000 		.quad	.LVL29-.Ltext0
 1437      00000000 
 1438 0345 0100     		.value	0x1
 1439 0347 53       		.byte	0x53
 1440 0348 F7010000 		.quad	.LVL29-.Ltext0
 1440      00000000 
 1441 0350 10020000 		.quad	.LVL36-.Ltext0
 1441      00000000 
 1442 0358 0400     		.value	0x4
 1443 035a F3       		.byte	0xf3
 1444 035b 01       		.uleb128 0x1
 1445 035c 54       		.byte	0x54
 1446 035d 9F       		.byte	0x9f
 1447 035e 10020000 		.quad	.LVL36-.Ltext0
 1447      00000000 
 1448 0366 26020000 		.quad	.LVL39-.Ltext0
 1448      00000000 
 1449 036e 0100     		.value	0x1
 1450 0370 53       		.byte	0x53
 1451 0371 3F020000 		.quad	.LVL42-.Ltext0
 1451      00000000 
 1452 0379 60020000 		.quad	.LFE21-.Ltext0
 1452      00000000 
 1453 0381 0100     		.value	0x1
 1454 0383 53       		.byte	0x53
 1455 0384 00000000 		.quad	0
 1455      00000000 
 1456 038c 00000000 		.quad	0
 1456      00000000 
GAS LISTING /tmp/ccD2n34x.s 			page 30


 1457              	.LLST6:
 1458 0394 50000000 		.quad	.LVL7-.Ltext0
 1458      00000000 
 1459 039c 65000000 		.quad	.LVL8-.Ltext0
 1459      00000000 
 1460 03a4 0100     		.value	0x1
 1461 03a6 56       		.byte	0x56
 1462 03a7 C7010000 		.quad	.LVL22-.Ltext0
 1462      00000000 
 1463 03af D0010000 		.quad	.LVL23-.Ltext0
 1463      00000000 
 1464 03b7 0300     		.value	0x3
 1465 03b9 70       		.byte	0x70
 1466 03ba 04       		.sleb128 4
 1467 03bb 9F       		.byte	0x9f
 1468 03bc D0010000 		.quad	.LVL23-.Ltext0
 1468      00000000 
 1469 03c4 D5010000 		.quad	.LVL24-.Ltext0
 1469      00000000 
 1470 03cc 0100     		.value	0x1
 1471 03ce 51       		.byte	0x51
 1472 03cf D5010000 		.quad	.LVL24-.Ltext0
 1472      00000000 
 1473 03d7 E0010000 		.quad	.LVL25-.Ltext0
 1473      00000000 
 1474 03df 0300     		.value	0x3
 1475 03e1 70       		.byte	0x70
 1476 03e2 08       		.sleb128 8
 1477 03e3 9F       		.byte	0x9f
 1478 03e4 E0010000 		.quad	.LVL25-.Ltext0
 1478      00000000 
 1479 03ec E5010000 		.quad	.LVL26-.Ltext0
 1479      00000000 
 1480 03f4 0100     		.value	0x1
 1481 03f6 51       		.byte	0x51
 1482 03f7 E5010000 		.quad	.LVL26-.Ltext0
 1482      00000000 
 1483 03ff E8010000 		.quad	.LVL27-.Ltext0
 1483      00000000 
 1484 0407 0300     		.value	0x3
 1485 0409 70       		.byte	0x70
 1486 040a 0C       		.sleb128 12
 1487 040b 9F       		.byte	0x9f
 1488 040c E8010000 		.quad	.LVL27-.Ltext0
 1488      00000000 
 1489 0414 EC010000 		.quad	.LVL28-.Ltext0
 1489      00000000 
 1490 041c 0300     		.value	0x3
 1491 041e 71       		.byte	0x71
 1492 041f 04       		.sleb128 4
 1493 0420 9F       		.byte	0x9f
 1494 0421 10020000 		.quad	.LVL36-.Ltext0
 1494      00000000 
 1495 0429 14020000 		.quad	.LVL37-.Ltext0
 1495      00000000 
 1496 0431 0100     		.value	0x1
 1497 0433 51       		.byte	0x51
GAS LISTING /tmp/ccD2n34x.s 			page 31


 1498 0434 1B020000 		.quad	.LVL38-.Ltext0
 1498      00000000 
 1499 043c 26020000 		.quad	.LVL39-.Ltext0
 1499      00000000 
 1500 0444 0100     		.value	0x1
 1501 0446 51       		.byte	0x51
 1502 0447 00000000 		.quad	0
 1502      00000000 
 1503 044f 00000000 		.quad	0
 1503      00000000 
 1504              	.LLST7:
 1505 0457 50000000 		.quad	.LVL7-.Ltext0
 1505      00000000 
 1506 045f F8010000 		.quad	.LVL30-.Ltext0
 1506      00000000 
 1507 0467 0100     		.value	0x1
 1508 0469 56       		.byte	0x56
 1509 046a F8010000 		.quad	.LVL30-.Ltext0
 1509      00000000 
 1510 0472 07020000 		.quad	.LVL32-.Ltext0
 1510      00000000 
 1511 047a 0600     		.value	0x6
 1512 047c 7D       		.byte	0x7d
 1513 047d 00       		.sleb128 0
 1514 047e 7F       		.byte	0x7f
 1515 047f 00       		.sleb128 0
 1516 0480 22       		.byte	0x22
 1517 0481 9F       		.byte	0x9f
 1518 0482 07020000 		.quad	.LVL32-.Ltext0
 1518      00000000 
 1519 048a 0B020000 		.quad	.LVL34-.Ltext0
 1519      00000000 
 1520 0492 0600     		.value	0x6
 1521 0494 75       		.byte	0x75
 1522 0495 00       		.sleb128 0
 1523 0496 7F       		.byte	0x7f
 1524 0497 00       		.sleb128 0
 1525 0498 22       		.byte	0x22
 1526 0499 9F       		.byte	0x9f
 1527 049a 0B020000 		.quad	.LVL34-.Ltext0
 1527      00000000 
 1528 04a2 0F020000 		.quad	.LVL36-1-.Ltext0
 1528      00000000 
 1529 04aa 1600     		.value	0x16
 1530 04ac F3       		.byte	0xf3
 1531 04ad 01       		.uleb128 0x1
 1532 04ae 54       		.byte	0x54
 1533 04af 75       		.byte	0x75
 1534 04b0 00       		.sleb128 0
 1535 04b1 1C       		.byte	0x1c
 1536 04b2 32       		.byte	0x32
 1537 04b3 26       		.byte	0x26
 1538 04b4 31       		.byte	0x31
 1539 04b5 25       		.byte	0x25
 1540 04b6 0C       		.byte	0xc
 1541 04b7 FFFFFFFF 		.long	0xffffffff
 1542 04bb 1A       		.byte	0x1a
GAS LISTING /tmp/ccD2n34x.s 			page 32


 1543 04bc 32       		.byte	0x32
 1544 04bd 24       		.byte	0x24
 1545 04be 75       		.byte	0x75
 1546 04bf 00       		.sleb128 0
 1547 04c0 22       		.byte	0x22
 1548 04c1 9F       		.byte	0x9f
 1549 04c2 0F020000 		.quad	.LVL36-1-.Ltext0
 1549      00000000 
 1550 04ca 10020000 		.quad	.LVL36-.Ltext0
 1550      00000000 
 1551 04d2 1800     		.value	0x18
 1552 04d4 F3       		.byte	0xf3
 1553 04d5 01       		.uleb128 0x1
 1554 04d6 54       		.byte	0x54
 1555 04d7 F3       		.byte	0xf3
 1556 04d8 01       		.uleb128 0x1
 1557 04d9 55       		.byte	0x55
 1558 04da 1C       		.byte	0x1c
 1559 04db 32       		.byte	0x32
 1560 04dc 26       		.byte	0x26
 1561 04dd 31       		.byte	0x31
 1562 04de 25       		.byte	0x25
 1563 04df 0C       		.byte	0xc
 1564 04e0 FFFFFFFF 		.long	0xffffffff
 1565 04e4 1A       		.byte	0x1a
 1566 04e5 32       		.byte	0x32
 1567 04e6 24       		.byte	0x24
 1568 04e7 F3       		.byte	0xf3
 1569 04e8 01       		.uleb128 0x1
 1570 04e9 55       		.byte	0x55
 1571 04ea 22       		.byte	0x22
 1572 04eb 9F       		.byte	0x9f
 1573 04ec 10020000 		.quad	.LVL36-.Ltext0
 1573      00000000 
 1574 04f4 26020000 		.quad	.LVL39-.Ltext0
 1574      00000000 
 1575 04fc 0100     		.value	0x1
 1576 04fe 56       		.byte	0x56
 1577 04ff 3F020000 		.quad	.LVL42-.Ltext0
 1577      00000000 
 1578 0507 60020000 		.quad	.LFE21-.Ltext0
 1578      00000000 
 1579 050f 0100     		.value	0x1
 1580 0511 56       		.byte	0x56
 1581 0512 00000000 		.quad	0
 1581      00000000 
 1582 051a 00000000 		.quad	0
 1582      00000000 
 1583              	.LLST8:
 1584 0522 50000000 		.quad	.LVL7-.Ltext0
 1584      00000000 
 1585 052a 65000000 		.quad	.LVL8-.Ltext0
 1585      00000000 
 1586 0532 0100     		.value	0x1
 1587 0534 5D       		.byte	0x5d
 1588 0535 65000000 		.quad	.LVL8-.Ltext0
 1588      00000000 
GAS LISTING /tmp/ccD2n34x.s 			page 33


 1589 053d 6D000000 		.quad	.LVL9-.Ltext0
 1589      00000000 
 1590 0545 0100     		.value	0x1
 1591 0547 52       		.byte	0x52
 1592 0548 98000000 		.quad	.LVL10-.Ltext0
 1592      00000000 
 1593 0550 F2000000 		.quad	.LVL12-.Ltext0
 1593      00000000 
 1594 0558 0100     		.value	0x1
 1595 055a 52       		.byte	0x52
 1596 055b 1E010000 		.quad	.LVL13-.Ltext0
 1596      00000000 
 1597 0563 26010000 		.quad	.LVL14-.Ltext0
 1597      00000000 
 1598 056b 0300     		.value	0x3
 1599 056d 72       		.byte	0x72
 1600 056e 04       		.sleb128 4
 1601 056f 9F       		.byte	0x9f
 1602 0570 26010000 		.quad	.LVL14-.Ltext0
 1602      00000000 
 1603 0578 2B010000 		.quad	.LVL15-.Ltext0
 1603      00000000 
 1604 0580 0100     		.value	0x1
 1605 0582 55       		.byte	0x55
 1606 0583 2B010000 		.quad	.LVL15-.Ltext0
 1606      00000000 
 1607 058b 35010000 		.quad	.LVL16-.Ltext0
 1607      00000000 
 1608 0593 0300     		.value	0x3
 1609 0595 72       		.byte	0x72
 1610 0596 08       		.sleb128 8
 1611 0597 9F       		.byte	0x9f
 1612 0598 35010000 		.quad	.LVL16-.Ltext0
 1612      00000000 
 1613 05a0 3A010000 		.quad	.LVL17-.Ltext0
 1613      00000000 
 1614 05a8 0100     		.value	0x1
 1615 05aa 55       		.byte	0x55
 1616 05ab 3A010000 		.quad	.LVL17-.Ltext0
 1616      00000000 
 1617 05b3 3D010000 		.quad	.LVL18-.Ltext0
 1617      00000000 
 1618 05bb 0300     		.value	0x3
 1619 05bd 72       		.byte	0x72
 1620 05be 0C       		.sleb128 12
 1621 05bf 9F       		.byte	0x9f
 1622 05c0 3D010000 		.quad	.LVL18-.Ltext0
 1622      00000000 
 1623 05c8 40010000 		.quad	.LVL19-.Ltext0
 1623      00000000 
 1624 05d0 0300     		.value	0x3
 1625 05d2 75       		.byte	0x75
 1626 05d3 04       		.sleb128 4
 1627 05d4 9F       		.byte	0x9f
 1628 05d5 3F020000 		.quad	.LVL42-.Ltext0
 1628      00000000 
 1629 05dd 43020000 		.quad	.LVL43-.Ltext0
GAS LISTING /tmp/ccD2n34x.s 			page 34


 1629      00000000 
 1630 05e5 0100     		.value	0x1
 1631 05e7 52       		.byte	0x52
 1632 05e8 43020000 		.quad	.LVL43-.Ltext0
 1632      00000000 
 1633 05f0 45020000 		.quad	.LVL44-.Ltext0
 1633      00000000 
 1634 05f8 0300     		.value	0x3
 1635 05fa 71       		.byte	0x71
 1636 05fb 7C       		.sleb128 -4
 1637 05fc 9F       		.byte	0x9f
 1638 05fd 45020000 		.quad	.LVL44-.Ltext0
 1638      00000000 
 1639 0605 4C020000 		.quad	.LVL45-.Ltext0
 1639      00000000 
 1640 060d 0100     		.value	0x1
 1641 060f 51       		.byte	0x51
 1642 0610 53020000 		.quad	.LVL46-.Ltext0
 1642      00000000 
 1643 0618 60020000 		.quad	.LFE21-.Ltext0
 1643      00000000 
 1644 0620 0100     		.value	0x1
 1645 0622 51       		.byte	0x51
 1646 0623 00000000 		.quad	0
 1646      00000000 
 1647 062b 00000000 		.quad	0
 1647      00000000 
 1648              	.LLST9:
 1649 0633 50000000 		.quad	.LVL7-.Ltext0
 1649      00000000 
 1650 063b 65000000 		.quad	.LVL8-.Ltext0
 1650      00000000 
 1651 0643 0100     		.value	0x1
 1652 0645 5E       		.byte	0x5e
 1653 0646 65000000 		.quad	.LVL8-.Ltext0
 1653      00000000 
 1654 064e 6D000000 		.quad	.LVL9-.Ltext0
 1654      00000000 
 1655 0656 0100     		.value	0x1
 1656 0658 5A       		.byte	0x5a
 1657 0659 98000000 		.quad	.LVL10-.Ltext0
 1657      00000000 
 1658 0661 F2000000 		.quad	.LVL12-.Ltext0
 1658      00000000 
 1659 0669 0100     		.value	0x1
 1660 066b 5A       		.byte	0x5a
 1661 066c 1E010000 		.quad	.LVL13-.Ltext0
 1661      00000000 
 1662 0674 2B010000 		.quad	.LVL15-.Ltext0
 1662      00000000 
 1663 067c 0300     		.value	0x3
 1664 067e 71       		.byte	0x71
 1665 067f 04       		.sleb128 4
 1666 0680 9F       		.byte	0x9f
 1667 0681 2B010000 		.quad	.LVL15-.Ltext0
 1667      00000000 
 1668 0689 3A010000 		.quad	.LVL17-.Ltext0
GAS LISTING /tmp/ccD2n34x.s 			page 35


 1668      00000000 
 1669 0691 0300     		.value	0x3
 1670 0693 71       		.byte	0x71
 1671 0694 08       		.sleb128 8
 1672 0695 9F       		.byte	0x9f
 1673 0696 3A010000 		.quad	.LVL17-.Ltext0
 1673      00000000 
 1674 069e 40010000 		.quad	.LVL19-.Ltext0
 1674      00000000 
 1675 06a6 0300     		.value	0x3
 1676 06a8 71       		.byte	0x71
 1677 06a9 0C       		.sleb128 12
 1678 06aa 9F       		.byte	0x9f
 1679 06ab 44010000 		.quad	.LVL20-.Ltext0
 1679      00000000 
 1680 06b3 9C010000 		.quad	.LVL21-.Ltext0
 1680      00000000 
 1681 06bb 0100     		.value	0x1
 1682 06bd 5A       		.byte	0x5a
 1683 06be C7010000 		.quad	.LVL22-.Ltext0
 1683      00000000 
 1684 06c6 D5010000 		.quad	.LVL24-.Ltext0
 1684      00000000 
 1685 06ce 0300     		.value	0x3
 1686 06d0 7A       		.byte	0x7a
 1687 06d1 04       		.sleb128 4
 1688 06d2 9F       		.byte	0x9f
 1689 06d3 D5010000 		.quad	.LVL24-.Ltext0
 1689      00000000 
 1690 06db E5010000 		.quad	.LVL26-.Ltext0
 1690      00000000 
 1691 06e3 0300     		.value	0x3
 1692 06e5 7A       		.byte	0x7a
 1693 06e6 08       		.sleb128 8
 1694 06e7 9F       		.byte	0x9f
 1695 06e8 E5010000 		.quad	.LVL26-.Ltext0
 1695      00000000 
 1696 06f0 EC010000 		.quad	.LVL28-.Ltext0
 1696      00000000 
 1697 06f8 0300     		.value	0x3
 1698 06fa 7A       		.byte	0x7a
 1699 06fb 0C       		.sleb128 12
 1700 06fc 9F       		.byte	0x9f
 1701 06fd 10020000 		.quad	.LVL36-.Ltext0
 1701      00000000 
 1702 0705 26020000 		.quad	.LVL39-.Ltext0
 1702      00000000 
 1703 070d 0100     		.value	0x1
 1704 070f 5A       		.byte	0x5a
 1705 0710 3F020000 		.quad	.LVL42-.Ltext0
 1705      00000000 
 1706 0718 45020000 		.quad	.LVL44-.Ltext0
 1706      00000000 
 1707 0720 0100     		.value	0x1
 1708 0722 5A       		.byte	0x5a
 1709 0723 45020000 		.quad	.LVL44-.Ltext0
 1709      00000000 
GAS LISTING /tmp/ccD2n34x.s 			page 36


 1710 072b 60020000 		.quad	.LFE21-.Ltext0
 1710      00000000 
 1711 0733 0100     		.value	0x1
 1712 0735 52       		.byte	0x52
 1713 0736 00000000 		.quad	0
 1713      00000000 
 1714 073e 00000000 		.quad	0
 1714      00000000 
 1715              	.LLST10:
 1716 0746 60020000 		.quad	.LVL47-.Ltext0
 1716      00000000 
 1717 074e 77020000 		.quad	.LVL49-.Ltext0
 1717      00000000 
 1718 0756 0100     		.value	0x1
 1719 0758 55       		.byte	0x55
 1720 0759 77020000 		.quad	.LVL49-.Ltext0
 1720      00000000 
 1721 0761 94020000 		.quad	.LVL55-.Ltext0
 1721      00000000 
 1722 0769 0100     		.value	0x1
 1723 076b 53       		.byte	0x53
 1724 076c 94020000 		.quad	.LVL55-.Ltext0
 1724      00000000 
 1725 0774 9F020000 		.quad	.LFE22-.Ltext0
 1725      00000000 
 1726 077c 0400     		.value	0x4
 1727 077e F3       		.byte	0xf3
 1728 077f 01       		.uleb128 0x1
 1729 0780 55       		.byte	0x55
 1730 0781 9F       		.byte	0x9f
 1731 0782 00000000 		.quad	0
 1731      00000000 
 1732 078a 00000000 		.quad	0
 1732      00000000 
 1733              	.LLST11:
 1734 0792 60020000 		.quad	.LVL47-.Ltext0
 1734      00000000 
 1735 079a 81020000 		.quad	.LVL51-1-.Ltext0
 1735      00000000 
 1736 07a2 0100     		.value	0x1
 1737 07a4 54       		.byte	0x54
 1738 07a5 81020000 		.quad	.LVL51-1-.Ltext0
 1738      00000000 
 1739 07ad 9A020000 		.quad	.LVL57-.Ltext0
 1739      00000000 
 1740 07b5 0100     		.value	0x1
 1741 07b7 5C       		.byte	0x5c
 1742 07b8 9A020000 		.quad	.LVL57-.Ltext0
 1742      00000000 
 1743 07c0 9F020000 		.quad	.LFE22-.Ltext0
 1743      00000000 
 1744 07c8 0400     		.value	0x4
 1745 07ca F3       		.byte	0xf3
 1746 07cb 01       		.uleb128 0x1
 1747 07cc 54       		.byte	0x54
 1748 07cd 9F       		.byte	0x9f
 1749 07ce 00000000 		.quad	0
GAS LISTING /tmp/ccD2n34x.s 			page 37


 1749      00000000 
 1750 07d6 00000000 		.quad	0
 1750      00000000 
 1751              	.LLST12:
 1752 07de 74020000 		.quad	.LVL48-.Ltext0
 1752      00000000 
 1753 07e6 77020000 		.quad	.LVL49-.Ltext0
 1753      00000000 
 1754 07ee 0800     		.value	0x8
 1755 07f0 74       		.byte	0x74
 1756 07f1 00       		.sleb128 0
 1757 07f2 75       		.byte	0x75
 1758 07f3 00       		.sleb128 0
 1759 07f4 1C       		.byte	0x1c
 1760 07f5 34       		.byte	0x34
 1761 07f6 1B       		.byte	0x1b
 1762 07f7 9F       		.byte	0x9f
 1763 07f8 77020000 		.quad	.LVL49-.Ltext0
 1763      00000000 
 1764 0800 81020000 		.quad	.LVL51-1-.Ltext0
 1764      00000000 
 1765 0808 0800     		.value	0x8
 1766 080a 74       		.byte	0x74
 1767 080b 00       		.sleb128 0
 1768 080c 73       		.byte	0x73
 1769 080d 00       		.sleb128 0
 1770 080e 1C       		.byte	0x1c
 1771 080f 34       		.byte	0x34
 1772 0810 1B       		.byte	0x1b
 1773 0811 9F       		.byte	0x9f
 1774 0812 81020000 		.quad	.LVL51-1-.Ltext0
 1774      00000000 
 1775 081a 94020000 		.quad	.LVL55-.Ltext0
 1775      00000000 
 1776 0822 0800     		.value	0x8
 1777 0824 7C       		.byte	0x7c
 1778 0825 00       		.sleb128 0
 1779 0826 73       		.byte	0x73
 1780 0827 00       		.sleb128 0
 1781 0828 1C       		.byte	0x1c
 1782 0829 34       		.byte	0x34
 1783 082a 1B       		.byte	0x1b
 1784 082b 9F       		.byte	0x9f
 1785 082c 94020000 		.quad	.LVL55-.Ltext0
 1785      00000000 
 1786 0834 9A020000 		.quad	.LVL57-.Ltext0
 1786      00000000 
 1787 083c 0900     		.value	0x9
 1788 083e 7C       		.byte	0x7c
 1789 083f 00       		.sleb128 0
 1790 0840 F3       		.byte	0xf3
 1791 0841 01       		.uleb128 0x1
 1792 0842 55       		.byte	0x55
 1793 0843 1C       		.byte	0x1c
 1794 0844 34       		.byte	0x34
 1795 0845 1B       		.byte	0x1b
 1796 0846 9F       		.byte	0x9f
GAS LISTING /tmp/ccD2n34x.s 			page 38


 1797 0847 9A020000 		.quad	.LVL57-.Ltext0
 1797      00000000 
 1798 084f 9F020000 		.quad	.LFE22-.Ltext0
 1798      00000000 
 1799 0857 0A00     		.value	0xa
 1800 0859 F3       		.byte	0xf3
 1801 085a 01       		.uleb128 0x1
 1802 085b 54       		.byte	0x54
 1803 085c F3       		.byte	0xf3
 1804 085d 01       		.uleb128 0x1
 1805 085e 55       		.byte	0x55
 1806 085f 1C       		.byte	0x1c
 1807 0860 34       		.byte	0x34
 1808 0861 1B       		.byte	0x1b
 1809 0862 9F       		.byte	0x9f
 1810 0863 00000000 		.quad	0
 1810      00000000 
 1811 086b 00000000 		.quad	0
 1811      00000000 
 1812              	.LLST13:
 1813 0873 8E020000 		.quad	.LVL52-.Ltext0
 1813      00000000 
 1814 087b 92020000 		.quad	.LVL54-1-.Ltext0
 1814      00000000 
 1815 0883 0100     		.value	0x1
 1816 0885 50       		.byte	0x50
 1817 0886 92020000 		.quad	.LVL54-1-.Ltext0
 1817      00000000 
 1818 088e 98020000 		.quad	.LVL56-.Ltext0
 1818      00000000 
 1819 0896 0100     		.value	0x1
 1820 0898 56       		.byte	0x56
 1821 0899 98020000 		.quad	.LVL56-.Ltext0
 1821      00000000 
 1822 08a1 9E020000 		.quad	.LVL59-1-.Ltext0
 1822      00000000 
 1823 08a9 0100     		.value	0x1
 1824 08ab 55       		.byte	0x55
 1825 08ac 00000000 		.quad	0
 1825      00000000 
 1826 08b4 00000000 		.quad	0
 1826      00000000 
 1827              		.section	.debug_aranges,"",@progbits
 1828 0000 2C000000 		.long	0x2c
 1829 0004 0200     		.value	0x2
 1830 0006 00000000 		.long	.Ldebug_info0
 1831 000a 08       		.byte	0x8
 1832 000b 00       		.byte	0
 1833 000c 0000     		.value	0
 1834 000e 0000     		.value	0
 1835 0010 00000000 		.quad	.Ltext0
 1835      00000000 
 1836 0018 9F020000 		.quad	.Letext0-.Ltext0
 1836      00000000 
 1837 0020 00000000 		.quad	0
 1837      00000000 
 1838 0028 00000000 		.quad	0
GAS LISTING /tmp/ccD2n34x.s 			page 39


 1838      00000000 
 1839              		.section	.debug_ranges,"",@progbits
 1840              	.Ldebug_ranges0:
 1841 0000 50000000 		.quad	.LBB4-.Ltext0
 1841      00000000 
 1842 0008 EC010000 		.quad	.LBE4-.Ltext0
 1842      00000000 
 1843 0010 14020000 		.quad	.LBB8-.Ltext0
 1843      00000000 
 1844 0018 30020000 		.quad	.LBE8-.Ltext0
 1844      00000000 
 1845 0020 40020000 		.quad	.LBB9-.Ltext0
 1845      00000000 
 1846 0028 60020000 		.quad	.LBE9-.Ltext0
 1846      00000000 
 1847 0030 00000000 		.quad	0
 1847      00000000 
 1848 0038 00000000 		.quad	0
 1848      00000000 
 1849              		.section	.debug_line,"",@progbits
 1850              	.Ldebug_line0:
 1851 0000 5D010000 		.section	.debug_str,"MS",@progbits,1
 1851      0200F800 
 1851      00000101 
 1851      FB0E0D00 
 1851      01010101 
 1852              	.LASF21:
 1853 0000 5F494F5F 		.string	"_IO_buf_end"
 1853      6275665F 
 1853      656E6400 
 1854              	.LASF29:
 1855 000c 5F6F6C64 		.string	"_old_offset"
 1855      5F6F6666 
 1855      73657400 
 1856              	.LASF24:
 1857 0018 5F494F5F 		.string	"_IO_save_end"
 1857      73617665 
 1857      5F656E64 
 1857      00
 1858              	.LASF1:
 1859 0025 73686F72 		.string	"short int"
 1859      7420696E 
 1859      7400
 1860              	.LASF8:
 1861 002f 73697A65 		.string	"size_t"
 1861      5F7400
 1862              	.LASF11:
 1863 0036 73697A65 		.string	"sizetype"
 1863      74797065 
 1863      00
 1864              	.LASF34:
 1865 003f 5F6F6666 		.string	"_offset"
 1865      73657400 
 1866              	.LASF54:
 1867 0047 474E5520 		.string	"GNU C 4.8.1 20130520 (prerelease) -mtune=generic -march=x86-64 -g -O3 -std=c99 -fcilkplus
 1867      4320342E 
 1867      382E3120 
GAS LISTING /tmp/ccD2n34x.s 			page 40


 1867      32303133 
 1867      30353230 
 1868              	.LASF55:
 1869 00a1 73657269 		.string	"serial_merge.c"
 1869      616C5F6D 
 1869      65726765 
 1869      2E6300
 1870              	.LASF58:
 1871 00b0 6D657267 		.string	"merge"
 1871      6500
 1872              	.LASF18:
 1873 00b6 5F494F5F 		.string	"_IO_write_ptr"
 1873      77726974 
 1873      655F7074 
 1873      7200
 1874              	.LASF13:
 1875 00c4 5F666C61 		.string	"_flags"
 1875      677300
 1876              	.LASF20:
 1877 00cb 5F494F5F 		.string	"_IO_buf_base"
 1877      6275665F 
 1877      62617365 
 1877      00
 1878              	.LASF25:
 1879 00d8 5F6D6172 		.string	"_markers"
 1879      6B657273 
 1879      00
 1880              	.LASF15:
 1881 00e1 5F494F5F 		.string	"_IO_read_end"
 1881      72656164 
 1881      5F656E64 
 1881      00
 1882              	.LASF60:
 1883 00ee 73657269 		.string	"serial_merge_sort"
 1883      616C5F6D 
 1883      65726765 
 1883      5F736F72 
 1883      7400
 1884              	.LASF51:
 1885 0100 61727265 		.string	"arrend"
 1885      6E6400
 1886              	.LASF47:
 1887 0107 6C6F6E67 		.string	"long long int"
 1887      206C6F6E 
 1887      6720696E 
 1887      7400
 1888              	.LASF33:
 1889 0115 5F6C6F63 		.string	"_lock"
 1889      6B00
 1890              	.LASF2:
 1891 011b 6C6F6E67 		.string	"long int"
 1891      20696E74 
 1891      00
 1892              	.LASF30:
 1893 0124 5F637572 		.string	"_cur_column"
 1893      5F636F6C 
 1893      756D6E00 
GAS LISTING /tmp/ccD2n34x.s 			page 41


 1894              	.LASF46:
 1895 0130 5F706F73 		.string	"_pos"
 1895      00
 1896              	.LASF59:
 1897 0135 6D657267 		.string	"merge_sort_helper"
 1897      655F736F 
 1897      72745F68 
 1897      656C7065 
 1897      7200
 1898              	.LASF45:
 1899 0147 5F736275 		.string	"_sbuf"
 1899      6600
 1900              	.LASF42:
 1901 014d 5F494F5F 		.string	"_IO_FILE"
 1901      46494C45 
 1901      00
 1902              	.LASF3:
 1903 0156 756E7369 		.string	"unsigned char"
 1903      676E6564 
 1903      20636861 
 1903      7200
 1904              	.LASF0:
 1905 0164 7369676E 		.string	"signed char"
 1905      65642063 
 1905      68617200 
 1906              	.LASF7:
 1907 0170 75696E74 		.string	"uint32_t"
 1907      33325F74 
 1907      00
 1908              	.LASF5:
 1909 0179 756E7369 		.string	"unsigned int"
 1909      676E6564 
 1909      20696E74 
 1909      00
 1910              	.LASF43:
 1911 0186 5F494F5F 		.string	"_IO_marker"
 1911      6D61726B 
 1911      657200
 1912              	.LASF32:
 1913 0191 5F73686F 		.string	"_shortbuf"
 1913      72746275 
 1913      6600
 1914              	.LASF17:
 1915 019b 5F494F5F 		.string	"_IO_write_base"
 1915      77726974 
 1915      655F6261 
 1915      736500
 1916              	.LASF41:
 1917 01aa 5F756E75 		.string	"_unused2"
 1917      73656432 
 1917      00
 1918              	.LASF14:
 1919 01b3 5F494F5F 		.string	"_IO_read_ptr"
 1919      72656164 
 1919      5F707472 
 1919      00
 1920              	.LASF50:
GAS LISTING /tmp/ccD2n34x.s 			page 42


 1921 01c0 73746172 		.string	"start"
 1921      7400
 1922              	.LASF4:
 1923 01c6 73686F72 		.string	"short unsigned int"
 1923      7420756E 
 1923      7369676E 
 1923      65642069 
 1923      6E7400
 1924              	.LASF48:
 1925 01d9 41656E64 		.string	"Aend"
 1925      00
 1926              	.LASF12:
 1927 01de 63686172 		.string	"char"
 1927      00
 1928              	.LASF44:
 1929 01e3 5F6E6578 		.string	"_next"
 1929      7400
 1930              	.LASF35:
 1931 01e9 5F5F7061 		.string	"__pad1"
 1931      643100
 1932              	.LASF36:
 1933 01f0 5F5F7061 		.string	"__pad2"
 1933      643200
 1934              	.LASF37:
 1935 01f7 5F5F7061 		.string	"__pad3"
 1935      643300
 1936              	.LASF38:
 1937 01fe 5F5F7061 		.string	"__pad4"
 1937      643400
 1938              	.LASF39:
 1939 0205 5F5F7061 		.string	"__pad5"
 1939      643500
 1940              	.LASF6:
 1941 020c 6C6F6E67 		.string	"long unsigned int"
 1941      20756E73 
 1941      69676E65 
 1941      6420696E 
 1941      7400
 1942              	.LASF19:
 1943 021e 5F494F5F 		.string	"_IO_write_end"
 1943      77726974 
 1943      655F656E 
 1943      6400
 1944              	.LASF49:
 1945 022c 42656E64 		.string	"Bend"
 1945      00
 1946              	.LASF10:
 1947 0231 5F5F6F66 		.string	"__off64_t"
 1947      6636345F 
 1947      7400
 1948              	.LASF9:
 1949 023b 5F5F6F66 		.string	"__off_t"
 1949      665F7400 
 1950              	.LASF26:
 1951 0243 5F636861 		.string	"_chain"
 1951      696E00
 1952              	.LASF23:
GAS LISTING /tmp/ccD2n34x.s 			page 43


 1953 024a 5F494F5F 		.string	"_IO_backup_base"
 1953      6261636B 
 1953      75705F62 
 1953      61736500 
 1954              	.LASF52:
 1955 025a 73746469 		.string	"stdin"
 1955      6E00
 1956              	.LASF28:
 1957 0260 5F666C61 		.string	"_flags2"
 1957      67733200 
 1958              	.LASF56:
 1959 0268 2F616673 		.string	"/afs/athena.mit.edu/user/w/q/wqian94/JuliaCMerge/src/c"
 1959      2F617468 
 1959      656E612E 
 1959      6D69742E 
 1959      6564752F 
 1960              	.LASF40:
 1961 029f 5F6D6F64 		.string	"_mode"
 1961      6500
 1962              	.LASF16:
 1963 02a5 5F494F5F 		.string	"_IO_read_base"
 1963      72656164 
 1963      5F626173 
 1963      6500
 1964              	.LASF31:
 1965 02b3 5F767461 		.string	"_vtable_offset"
 1965      626C655F 
 1965      6F666673 
 1965      657400
 1966              	.LASF22:
 1967 02c2 5F494F5F 		.string	"_IO_save_base"
 1967      73617665 
 1967      5F626173 
 1967      6500
 1968              	.LASF27:
 1969 02d0 5F66696C 		.string	"_fileno"
 1969      656E6F00 
 1970              	.LASF53:
 1971 02d8 7374646F 		.string	"stdout"
 1971      757400
 1972              	.LASF57:
 1973 02df 5F494F5F 		.string	"_IO_lock_t"
 1973      6C6F636B 
 1973      5F7400
 1974              		.ident	"GCC: (GNU) 4.8.1 20130520 (prerelease)"
 1975              		.section	.note.GNU-stack,"",@progbits
