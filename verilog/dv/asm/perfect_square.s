// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

// SQ_root of number
#include "defines.h"

#define STDOUT 0xd0580000


// Code to execute
.section .text
.global _start
_start:


    csrw minstret, zero
    csrw minstreth, zero

    li x4, 4        // Neccessary for terminating code
    csrw 0x7f9 ,x4  // Neccessary for terminating code
     
    li x8, 0xf0040000 // dccm address
    li x3, STDOUT // axi address	
    li x13, 0  // initial value     
    li x12, 25  // sqrt number
    addi x6, x0, 0 // counter
    li x11, 200

    
sq_root:
    addi x6, x6, 1
    mul x9, x6, x6
    beq x11, x6, _finish
    bne x12, x9, sq_root
    sw x6, 0(x8)
    sw x6, 0(x3)
  
// Write 0xff to STDOUT for TB to termiate test.
_finish:
    li x3, STDOUT
    addi x5, x0, 0xff
    sb x5, 0(x3)
    beq x0, x0, _finish
.rept 100
    nop
.endr
