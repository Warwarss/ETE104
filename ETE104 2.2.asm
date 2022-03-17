;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
            mov    #0x2400,R10
            mov    #1,R9
            mov    #1,R8
            mov    #0,R7
            mov    #0,R6

            mov    #0,2(R10)
            mov    #1,0(R10)

            mov    #0,6(R10)
            mov    #1,4(R10)


Loop        push   6(R10)
            add    2(R10),6(R10)
            adc    8(R10)
            mov    6(R10),10(R10)
            pop    6(R10)

            push   8(R10)
            add    4(R10),8(R10)
            mov    8(R10),12(R10)
            pop    8(R10)
            add    #0x0004,R10
            jmp    Loop










;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
