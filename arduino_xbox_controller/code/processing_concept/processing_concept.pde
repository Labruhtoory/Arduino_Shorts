String config = "xbscont1"; //This is the name of your config file from the GCP configurator
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


float slide1;
float slide2;
float slide3;
float pitch1;
float pitch2;
float yaw1;
float throt;
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
 slide1 = map(cont.getSlider("forwBack").getValue(), -2, 2, 0, 180); //
 slide3 = map(cont.getSlider("rightLeft").getValue(), -2, 2, 0, 180); //
 pitch1 = map(cont.getSlider("pitch").getValue(), -2, 2, 0, 180); //
 yaw1 = map(cont.getSlider("yaw").getValue(), -2, 2, 0, 180); // 
 throt = map(cont.getSlider("upDown").getValue(), -2, 2, 0, 180); // Change these to the names of the variable you 
 a = map(cont.getButton("butA").getValue(), -2, 2, 0, 180); // set in your config file. See "diagram2" 
 b = map(cont.getButton("butB").getValue(), -2, 2, 0, 180); // 
 x = map(cont.getButton("butX").getValue(), -2, 2, 0, 180); //
 y = map(cont.getButton("buY").getValue(), -2, 2, 0, 180); //
}



void draw(){
 getUserInput();
 
 slide2 = 180 - slide1;// Some math bc i have a preference of right > bright
 pitch2 = 180 - pitch1;// and left > dimm for the joysticks
 
 arduino.servoWrite(2, (int)slide2); //Toggle left joystick to the up & down to make brighter and dimmer 
 arduino.servoWrite(3, (int)slide3); //Toggle left joystick to the right & left to make brighter and dimmer
 arduino.servoWrite(4, (int)pitch2); //Toggle right joystick to the up & down to make brighter and dimmer
 arduino.servoWrite(5, (int)yaw1); //Toggle right joystick to the right & left to make brighter and dimmer
 arduino.servoWrite(6, (int)throt); //Toggle left and right triggers to make brighter and dimmer
 arduino.servoWrite(7, (int)a); //push A to make brighter
 arduino.servoWrite(8, (int)b); //push B to make brighter
 arduino.servoWrite(9, (int)x); //push X to make brighter
 arduino.servoWrite(10, (int)y); //push Y to make brighter
}
