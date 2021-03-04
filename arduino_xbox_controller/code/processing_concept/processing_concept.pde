String config = "xboxcontrollerHID"; //This is the name of your config file from the GCP configurator
String errmess1 = "could not connect to the controller";

/*
For this program, you need to install these folowing libraries:
 - Arduino
 - G4P
 - Game Control Plus
*/

import processing.serial.*;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import cc.arduino.*; 
import org.firmata.*;

ControlDevice cont;
ControlIO control;
Arduino arduino;


float slideFB;
float slideFB2;
float slideRL;
float rotFB;
float rotFB2;
float rotRL;
float throtUD;
float a;
float b;
float x;
float y;


void setup() {
  control = ControlIO.getInstance(this);
  cont = control.getMatchedDevice(config);
   if (cont == null) {
    println(errmess1);
    System.exit(-1);
  }
  
  //println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[2], 57600);
  arduino.pinMode(2, Arduino.SERVO); //
  arduino.pinMode(3, Arduino.SERVO); //
  arduino.pinMode(4, Arduino.SERVO); //
  arduino.pinMode(5, Arduino.SERVO); // 
  arduino.pinMode(6, Arduino.SERVO); // Setup Pins to be used
  arduino.pinMode(7, Arduino.SERVO); //
  arduino.pinMode(8, Arduino.SERVO); //
  arduino.pinMode(9, Arduino.SERVO); //
  arduino.pinMode(10, Arduino.SERVO); //
}


public void getUserInput(){                   //get input from controller and assign a value
 slideFB = map(cont.getSlider("slideFB").getValue(), -1, 1, 0, 180); //
 slideRL = map(cont.getSlider("slideRL").getValue(), -1, 1, 0, 180); //
 rotFB = map(cont.getSlider("rotFB").getValue(), -1, 1, 0, 180); //
 rotRL = map(cont.getSlider("rotRL").getValue(), -1, 1, 0, 180); // 
 throtUD = map(cont.getSlider("throtUD").getValue(), -1, 1, 0, 180); // Change these to the names of the variable you 
 a = map(cont.getButton("butA").getValue(), -1, 1, 0, 180); // set in your config file. See "diagram2" 
 b = map(cont.getButton("butB").getValue(), -1, 1, 0, 180); // 
 x = map(cont.getButton("butX").getValue(), -1, 1, 0, 180); //
 y = map(cont.getButton("butY").getValue(), -1, 1, 0, 180); //
}



void draw(){
 getUserInput();
 
 slideFB2 = 180 - slideFB;// Some math bc i have a preference of right > bright
 rotFB2 = 180 - rotFB;// and left > dimm for the joysticks
 
 arduino.servoWrite(2, (int)slideFB2); //Toggle left joystick to the up & down to make brighter and dimmer 
 arduino.servoWrite(3, (int)slideRL); //Toggle left joystick to the right & left to make brighter and dimmer
 arduino.servoWrite(4, (int)rotFB2); //Toggle right joystick to the up & down to make brighter and dimmer
 arduino.servoWrite(5, (int)rotRL); //Toggle right joystick to the right & left to make brighter and dimmer
 arduino.servoWrite(6, (int)throtUD); //Toggle left and right triggers to make brighter and dimmer
 arduino.servoWrite(7, (int)a); //push A to make brighter
 arduino.servoWrite(8, (int)b); //push B to make brighter
 arduino.servoWrite(9, (int)x); //push X to make brighter
 arduino.servoWrite(10, (int)y); //push Y to make brighter
}
