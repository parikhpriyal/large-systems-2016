/**
 * oscP5message by andreas schlegel
 * example shows how to create osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
/*References
https://processing.org/discourse/beta/num_1211377747.html
http://learningprocessing.dreamhosters.com/examples/chapter-18/example-18-1/*/

//global variables 
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress Jasmine;

OscMessage myMessage; 

PFont f;

String typing = "";
String s = "";

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,8000);
  
  //Ip address of other laptop
  Jasmine = new NetAddress("127.0.0.1",8000);
  
  f = createFont("Arial",16,true);
}


void draw() {
  background(255);
  int indent = 25;
  textFont(f);
  fill(0);
  // Display everything
  text("Click in this applet and type. \nHit return to send the message. ", indent, 40);
  text(typing,indent,90);
  text("Friend says:", indent, 140);
  text(s,indent,170);
}

void keyPressed() {
  // If the return key is pressed, save the String and clear it
  if (key == '\n' ) {
     OscMessage myMessage = new OscMessage("/test");
     try {
        byte[] b=(new String(typing).getBytes("UTF-8"));
        myMessage.add(b);
      }
      catch(Exception e) {
      }
    oscP5.send(myMessage, Jasmine);
    // A String can be cleared by setting it equal to ""
    typing = "";
  } else {
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    typing = typing + key; 
  }
}

///* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  byte[] b=theOscMessage.get(0).bytesValue();
  try {
    s=new String(b,"UTF-8");
  }
   catch(Exception e){}
  println(s);
}