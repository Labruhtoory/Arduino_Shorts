#include "nRF24L01.h"
#include "RF24.h"
#include "SPI.h"

int igpin = 8
int SentMessage[1] = {000}; // Used to store value before being sent through the NRF24L01
RF24 radio(9,10); // NRF24L01 using SPI pins + Pin 9 and 10 on the NANO
const uint64_t pipe = 0xE6E6E6E6E6E6; // Needs to be the same for communicating between 2 NRF24L01 

String trueMess = "button has been pressed";
String noneMess = "not pressed";
String confirmMess = "Sent message"

void setup(){
  pinMode(igpin, INPUT_PULLUP); // Define the arcade switch NANO pin as an Input using Internal Pullups
  digitalWrite(igpin, HIGH); // Set Pin to HIGH at beginning
  radio.begin(); // Start the NRF24L01
  radio.openWritingPipe(pipe); // Get NRF24L01 ready to transmit
}

void loop(){
  if (digitalRead(igpin) == LOW){ // If Switch is Activated
    Serial.println(trueMess);
    SentMessage[0] = 111;
    radio.write(SentMessage, 1); // Send value through NRF24L01
    Serial.println(confirmMess);
  }else{
    SentMessage[0] = 000;
    Serial.println(nonMess)
    radio.write(SentMessage, 1);
    Serial.println(confirmMess);
  }
}
