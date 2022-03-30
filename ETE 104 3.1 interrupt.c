#include <msp430.h>				
int j=0;                   //GLOBAL DEĞİŞKEN
void blink()               //YANIP SÖNME FONKSİYONU
{
        while (j<3)
        {
        P1OUT |= 0x01;
        __delay_cycles(50000);
        P1OUT &= !0x01;
        __delay_cycles(450000);
        }
  return 0;
}
void main(void)
{
	WDTCTL = WDTPW | WDTHOLD;		// stop watchdog timer
	volatile unsigned int i;		// volatile to prevent optimization

	       P1DIR |= 0x01;                  // P1 PORTU OUTPUT OLARAK AYARLANIYOR
	       P2DIR &= !BIT1;                 // P2 PORTU INPUT  OLARAK AYARLANIYOR
	       P2REN |= BIT1;                  // P2.1 PULL UP/DOWN AKTİF
	       P2OUT |= BIT1;                  // P2.1 PULL UP
	       P1OUT &=!BIT0;                  // IŞIĞI KAPIYORUM
	       P2IE  |= BIT1;                  // INTERRUPT AKTİF
	       P2IES |= BIT1;                  // HI/LOW SEÇİYORUM
	       _BIS_SR(GIE);                   // GLOBAL INTTERUPT ENABLE AÇIK
	       P2IFG &=!BIT1;                  // INTERRUPT FLAGINI SİLİYORUM
	       while (1)
	       {
           switch(j)
               {
               case 1:                   //BİRİNCİ DURUMDA IŞIK AÇILIYOR
                   P1OUT |= BIT0;    
                   break;
               case 2:                   //İKİNCİ DURUMDA YANIP SÖNÜYOR
                   blink();
                   j=0;                  //YANIP SÖNMEDEN ÇIKINCA DEĞİŞKEN SIFIRLANIYOR
                   P1OUT &= !0x01;       //IŞIK KAPANIYOR
                   break;
               }
	       }
}
#pragma vector=PORT2_VECTOR
__interrupt void Port_2(void)
{
    j=j+1;                            //HANGİ DURUMDA OLDUĞUNU ANLASIN DİYE DEĞİŞKENİ BİR ARTTIRIYORUM
    __delay_cycles(250000);           //250 MİLİSANİYE BEKLEME
    P2IFG &=!BIT1;                    //FLAG SIFIRLANIYOR
}
