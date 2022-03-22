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
main        mov #65535,R13
            call #function
            nop

function     cmp #0,R13      ;Sıfır mı değil mi kontrol ediyorum
             jz Zero_Check   ;Sıfırsa fonksiyondan çıkıyor

             push #0         ;Stack'e toplayacağım sayıların sonucunu yazacağım için sıfırlıyorum
             push #0

             add  R13,&0x43FC  ;R14'e göndereceğim değeri RAM'e yazıyorum
             adc  &0x43FA      ;Carry bitleri buraya gönderiyorum

             jc   Bigger_Than_32Bit ;Sonuç 32 bitten büyük çıkacaksa buraya takılıyor

             mov  #17300,SP    ;Stack bitmesin diye Pointeri sabit tutuyorum


             sub #1,R13      ;Fonksiyon
             call #function  ;Rekursive

             ret


Bigger_Than_32Bit mov #0,R14
                  mov #0,R15      ;32 Bitten büyükse sayı registerlara sıfır yazılıyor
                  jmp Complete

Zero_Check
                  mov &0x43FC,R14 ;Sonucu yazıyorum
                  mov &0x43FA,R15 ;Sonucu yazıyorum

Complete          nop


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
            
