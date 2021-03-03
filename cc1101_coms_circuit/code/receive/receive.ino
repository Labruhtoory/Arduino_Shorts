#include <ELECHOUSE_CC1101.h>

int igpin = 7; //define a pin for performing an electrical function.
               //in this case, I used this pin to activate a relay.

#define size 60
byte buffer[100] = {0};
String initmess = String("IGNITING NOW!!! "); //this message is really for debugging
String endmess = String("DONE !!!"); //this message is also for debugging

void setup() { 
  Serial.begin(9600);
  Serial.println("Listening..........");
  pinMode(igpin, OUTPUT);
  digitalWrite(igpin, LOW);
  ELECHOUSE_cc1101.Init(F_433); //433mhz
  ELECHOUSE_cc1101.Init();
  ELECHOUSE_cc1101.SetReceive(); //make sure the cc1101 is in receive mode
}

void loop() {
  if (ELECHOUSE_cc1101.CheckReceiveFlag()) {
    ELECHOUSE_cc1101.ReceiveData(buffer);
    String str((char *) buffer);
    Serial.println(str);
    int result = str.length();
    if (result == 9){           //This filter is just to help with any noise
      Serial.println(initmess);
      digitalWrite(igpin, HIGH);
      delay(3000);               //The contents of this if statement is just what the arduino does if it recieves 
      digitalWrite(igpin, LOW);  //the right signal. This you will probably change for different applications.
      Serial.println(endmess);
      
    }
  }
  ELECHOUSE_cc1101.SetReceive(); //making sure to put the module back in receive mode, I put I here bc sometimes my external circuit (on the relay) would not ignite on the first go.
}
