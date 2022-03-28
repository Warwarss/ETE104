#include <stdio.h>
#include <msp430.h>
void blink()
{
    int i=0;
    int j=0;
    while(j<1)
    {
    P1OUT |= 0x01;
    for(i=10000; i>0; i--);
    P1OUT &= !0x01;
    for(i=10000; i>0; i--);
      while (P2IN==0xFD)
                  {
                      for(i=10000; i>0; i--);
                      if (P2IN==0xFF)
                      {
                      j=j+1;
                      }
                  }
    }
    return 0;
};
int main(void)
{
       WDTCTL = WDTPW | WDTHOLD;       // stop watchdog timer
       P1DIR |= 0x01;                  // configure P1.0 as output
       P2DIR &= !BIT1;                 // P2.1 AS INPUT
       P2REN |= BIT1;                  // P2.1 PULL UP/DOWN ACTIVE
       P2OUT |= BIT1;                  // P2.1 PULL UP
       P1OUT &=!BIT0;                  // P1.0 SET AS 0
       volatile unsigned int i;        // volatile to prevent optimization
       volatile unsigned int j=0;
           while(1)
           {
           //  P1OUT &= !0x01;
              for(i=10000; i>0; i--);
              while (P2IN==0xFD)
              {
                  for(i=10000; i>0; i--);
                  if (P2IN==0xFF)
                  {
                      j=j+1;
                      switch (j)
        {
                      case 1:
                          P1OUT |= 0x01;
                          break;
                      case 2:
                          blink();
                          P1OUT &=!BIT0;
                          j=j+1;

                      case 3:
                          j=0;
                          break;

        }
                  }
              }
           }
}
