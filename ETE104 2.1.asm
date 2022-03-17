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
main        mov #100,R13
            mov #0,R14
            mov #0,R15
            call #function
            nop

function     sub #1,R13      ;Sıfır mı değil mi kontrol ediyorum
             jn Zero_Check   ;Sıfırsa Return komudu
             add #1,R13      ;Çıkardığım sayıyı tekrar düzeltiyorum
             add R13,R14
Carry_Return jc Carry_Condition  ;Register'i aşıyorsa jump komudu
             sub #1,R13          ;Fonksiyon
             call #function

             ret

Carry_Condition add #1,R15            ;R15'e bir ekleniyor
                jc  Bigger_Than_32Bit ;32'bit ile gösterilemeyecek kadar büyükse es geçiyor
                clrc                  ;Carry bit rest
                jmp Carry_Return      ;Geri dönüyorum



Zero_Check        nop
Bigger_Than_32Bit nop

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
            
