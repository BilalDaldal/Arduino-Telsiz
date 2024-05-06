
#include <RF24.h>
#include <SPI.h>
#include "printf.h" 
#include <RF24Audio.h>


RF24 radio(7, 8); 
RF24Audio rfAudio(radio, 0); 

int talkButton = 3;

void setup() {
  Serial.begin(115200);

  printf_begin();
  radio.begin();
  radio.setChannel(13);
  radio.printDetails();
  rfAudio.begin();

  pinMode(talkButton, INPUT);

  attachInterrupt(digitalPinToInterrupt(talkButton), talk, CHANGE);
  
  rfAudio.receive();

}

void talk()
{

  if (digitalRead(talkButton)) {
    rfAudio.transmit();
    delay(10);
  }
  else {
    rfAudio.receive();
    delay(10);
  }
}


void loop()
{}
