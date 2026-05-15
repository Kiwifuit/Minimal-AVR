#include <avr/io.h>
#include <avr/interrupt.h>

#define ONE_SECOND F_CPU / 1024 - 1

ISR(TIMER1_COMPA_vect)
{
  PORTB ^= (1 << PB5);
}

int main()
{
  DDRB |= (1 << PB5);
  TCCR1B |= (1 << WGM12) | (1 << CS12) | (1 << CS10);
  TIMSK1 = (1 << OCIE1A);
  // TIFR1 = (1 << ICF1);

  OCR1A = ONE_SECOND / 2;

  sei();
  while (1)
  {
  };
}
