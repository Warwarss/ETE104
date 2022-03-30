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
             ;EMÝRHAN ÜZÜM 200504055 HA1 ETE104 ALLE AUFGABEN


Aufgabe1     nop              ;Aufgabe 1
             mov #100,R6      ;R6 registerýna 100 yazýldý
             mov #0,R5        ;R5 sýfýrlandý
Loop1        add R6,R5        ;R6+R5=R5
             sub #1,R6        ;R5'den bir çýkarýyoruz
             jz  Aufgabe2     ;Sayý sýfýrlanýnca sonraki göreve geçiyor
             jmp Loop1        ;Loop'a giriyor

Aufgabe2     nop

             mov #1000,R6    ;R6 registerýna 1000 yazýldý
             mov #0,R5
             mov #0,R4       ;Kullanacaðým registerlarý sýfýrlýyorum
Loop2        add R6,R5
CarryReturn2 jc Carry2       ;R6+R5=R5
             sub #1,R6
             jz Aufgabe3     ;Sayý sýfýrlanýnca sonraki göreve geçiyor
             jmp Loop2       ;R5'den bir çýkarýyoruz

Carry2       add #1,R4      ; R15'e bir ekliyoruz
             clrc            ; Carry bit Resetlendi
             jmp CarryReturn2;Subroutine'e geri dönmek için



Aufgabe3     mov   #500,R13  ; N'yi burada belirliyoruz
             mov   #0,R14
             mov   #0,R15    ; R14 ve R15 sýfýrlanýyor hata olmasýn diye
             clrc            ; Carry Bit Sýfýrlanýyor
             call  #Summing  ; Subroutine'i çaðýran satýr
             jmp   Complete  ; Subroutine'den sonra tekrar loopa girmesin diye Atlama komudu

Summing      add   R13,R14   ; R13+R14=R14
Carry_Return jc    Carry3     ; Carry bit setlenirse jump
             sub   #1,R13    ; R13'den bir çýkarýyoruz
             jz    Return    ; Tüm sayýlar toplanýrsa Subroutine'den çýkma komudu
             jmp   Summing   ; Loop
Return       ret

Carry3       add #1,R15      ; R15'e bir ekliyoruz
             clrc            ; Carry bit Resetlendi
             jmp Carry_Return;Subroutine'e geri dönmek için

Complete     nop

                                            

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
            
