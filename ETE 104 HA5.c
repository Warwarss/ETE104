#include <msp430.h>
volatile unsigned int j=0;
void control (long int n)
{
    volatile unsigned int i;
    for (n;n>0;n--)
    {
      if (( P2IN & BIT1 ) == 0)    //TUŞA BASILI TUTULDUĞUNDA P2IN xxxx xx0x Oluyor.
        {
         for(i=20000; i>0; i--);     //BEKLEME SÜRESİ
         if (P2IN & BIT1 )           //TUŞA BASILMADIĞINDA P2IN xxxx xx1x Oluyor.
            {
               j=j+1;
            }
        }
    };
}
int main(void)
{
       WDTCTL = WDTPW | WDTHOLD;       // stop watchdog timer
       P1DIR |= 0x01;                  // configure P1.0 as output
       P2DIR &= !BIT1;                 // P2.1 INPUT
       P2REN |= BIT1;                  // P2.1 PULL UP/DOWN AKTİF
       P2OUT |= BIT1;                  // P2.1 PULL UP
       P1OUT &=!BIT0;                  // IŞIĞI KAPIYORUM

       P7DIR |= BIT7;                            // MCLK set out to pins
       P7SEL |= BIT7;

       P5SEL |= BIT2+BIT3;                       // Port select XT2
       P5SEL |= BIT4+BIT5;                       // Port select XT1

       UCSCTL6 &= ~(XT2OFF);                       // Enable XT2
       UCSCTL6 &= ~(XT1OFF);                       // Enable X1
       UCSCTL6 |= XCAP_3;                          // Internal load cap

       do
       {
         UCSCTL7 &= ~(XT2OFFG + XT1LFOFFG + DCOFFG);
                                                 // Clear XT2,XT1,DCO fault flags
         SFRIFG1 &= ~OFIFG;                      // Clear fault flags
       }while (SFRIFG1&OFIFG);                   // Test oscillator fault flag

       UCSCTL6 &= ~(XT1DRIVE_3);                 // Xtal is now stable, reduce drive strength


       volatile unsigned int i;        // volatile to prevent optimization
       while(1)
           {
           control(10);
           switch (j)
           {
           case 1:
               P1OUT |= BIT0;
               break;
           case 2:
               P1OUT |= 0x01;
               control(1000);
               P1OUT &= !0x01;
               control(9000);
               break;
           case 3:
               UCSCTL4 |= SELM_5;
               P1OUT |= 0x01;
               control(1000);
               P1OUT &= !0x01;
               control(9000);
               UCSCTL6 &= ~XT2DRIVE0;
               break;
           case 4:
               UCSCTL4 &= ~SELM_7;
               UCSCTL4 |= SELM_0;
               P1OUT |= 0x01;
               control(1000);
               P1OUT &= !0x01;
               control(9000);
               UCSCTL6 &= ~XT1DRIVE0;
               break;
           case 5:
               P1OUT &=!BIT0;
               UCSCTL4 &= ~SELM_7;
               UCSCTL4 |= SELM_4;
               j=0;
               break;
           case 6:
               P1OUT &=!BIT0;
               UCSCTL4 &= ~SELM_7;
               UCSCTL4 |= SELM_4;
               j=0;
           }
           }
}

