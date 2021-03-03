#include <ELECHOUSE_CC1101.h>
int i;
int senpin = 7;

void setup(){
  ELECHOUSE_cc1101.Init();
  Serial.begin(9600);
  Serial.println("Sending..........");
  ELECHOUSE_cc1101.Init(F_433);
}

void loop(){
  i++;
  int buttonState = digitalRead(senpin);
  if (buttonState == 1){
    delay(500);
    String tx_message = "IGNITE!!!";
    Serial.println(tx_message);
    int m_length = tx_message.length();
    byte txbyte[m_length];
    tx_message.getBytes(txbyte, m_length + 1);
    Serial.println((char *)txbyte);
    ELECHOUSE_cc1101.SendData(txbyte, m_length);
  }else if(buttonState == 0){
      Serial.println("not pressed...");
      delay(100);
  }
}
