#include "nRF24L01.h" 
#include "RF24.h"
#include "SPI.h"

int igpin = 8;

int ReceivedMessage[1] = {000}; // Used to store value received by the NRF24L01
RF24 radio(9,10); // NRF24L01 using SPI pins + Pin 9 and 10 on the UNO
const uint64_t pipe = 0xE6E6E6E6E6E6; // Needs to be the same for communicating between 2 NRF24L01 

String foundMess = "received a message"
String confirmMess = "Igniting!!!"
void setup(){
  digitalWrite(igpin, HIGH)
  radio.begin(); // Start the NRF24L01
  radio.openReadingPipe(1,pipe); // Get NRF24L01 ready to receive
  radio.startListening(); // Listen to see if information received
  pinMode(LED_PIN, OUTPUT); // Set RGB Stick UNO pin to an OUTPUT
}

void loop(void){
  while (radio.available()){
    radio.read(ReceivedMessage, 1);
    Serial.println(foundMess);
    if (ReceivedMessage[0] == 111){
      Serial.println(confirmMess);
      digitalWrite(igpin, HIGH);
      delay(3000);
      digitalWrite(igpin, LOW);
    }
  }
}
