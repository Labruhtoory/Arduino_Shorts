#include <ELECHOUSE_CC1101.h>
int i;
int senpin = 7;

void setup(){
  ELECHOUSE_cc1101.Init();
  Serial.begin(9600);
  Serial.println("Sending..........");
  ELECHOUSE_cc1101.Init(F_433); //433mhz
}

void loop(){
  i++;
  int buttonState = digitalRead(senpin); //connect a button or switch to the senpin Pin# and this determines whether the circuit on that pin is complete or not.
  if (buttonState == 1){
    delay(500);
    String tx_message = "IGNITE!!!"; //this is the message that will be broadcast
    Serial.println(tx_message);
    int m_length = tx_message.length();
    byte txbyte[m_length];
    tx_message.getBytes(txbyte, m_length + 1);
    Serial.println((char *)txbyte);
    ELECHOUSE_cc1101.SendData(txbyte, m_length); //the receiver part of this setup will parse the message and determine whether to ignite or not.
  }else if(buttonState == 0){
      Serial.println("not pressed...");
      delay(100);
  }
}
