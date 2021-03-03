#include <ELECHOUSE_CC1101.h>

int igpin = 7;

#define size 60
byte buffer[100] = {0};
String initmess = String("IGNITING NOW!!! ");
String endmess = String("DONE !!!");

void setup() { 
  Serial.begin(9600);
  Serial.println("Listening..........");
  pinMode(igpin, OUTPUT);
  digitalWrite(igpin, LOW);
  ELECHOUSE_cc1101.Init(F_433);
  ELECHOUSE_cc1101.Init();
  ELECHOUSE_cc1101.SetReceive();
}

void loop() {
  if (ELECHOUSE_cc1101.CheckReceiveFlag()) {
    ELECHOUSE_cc1101.ReceiveData(buffer);
    String str((char*) buffer);
    Serial.println(str);
    int result = str.length();
    if (result == 9){
      Serial.println(initmess);
      digitalWrite(igpin, HIGH);
      delay(3000);
      digitalWrite(igpin, LOW);
      Serial.println(endmess);
      
    }
  }
  ELECHOUSE_cc1101.SetReceive(); 
}
