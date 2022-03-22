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
            mov    #0x2400,R10     ;Pointeri ayarlıyorum

            mov    #0,2(R10)       ;İlk sayıyı sıfırlıyorum
            mov    #0,0(R10)

            mov    #0,6(R10)       ;İkinci sıradakı sayıyı 1 yapıyorum
            mov    #1,4(R10)


Loop
            push   6(R10)           ;İkinci sayının büyük kısmını Stack'e yazıyorum
            add    2(R10),6(R10)    ;Birinci sayının büyük kısmı ile ikinci sayının büyük kısmı toplanıyor
            mov    6(R10),10(R10)   ;Ve sonuç üçüncü sayının büyük kısmına yazılıyor
            pop    6(R10)           ;İkinci sayının büyük kısmını geri yazıyorum

            push   4(R10)           ;İkinci sayının küçük kısmını Stack'e yazıyorum
            add    0(R10),4(R10)    ;Birinci sayıyla ikinci sayının küçük kısmı toplanıyor
            adc    10(R10)          ;Eğer carry bit varsa üçüncü sayının büyük kısmına ekleniyor
            mov    4(R10),8(R10)    ;Toplam, üçüncü sayının küçük kısmına yazılıyor
            pop    4(R10)           ;Stack'e kaydettiğim sayıyı geri yazıyorum

            add    #0x0004,R10      ;Pointeri 4 arttırıyorum
            jmp    Loop             ;Loop










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
            
