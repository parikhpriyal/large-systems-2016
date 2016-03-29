//code help from https://processing.org/examples/keyboardfunctions.html and http://www.openprocessing.org/sketch/47481

import oscP5.*;
import netP5.*;

//osc variables
OscP5 oscp5;
NetAddress mrl;
OscMessage send;

//paddle and ball variables
float pad1, pad2, posX, posY;
int radius = 20;
int padHeight = 100;
float speedX = random(3, 5);
float speedY = random(3, 5); 

//game variables
boolean startPong = false;
float begin = 0;
int player1 = 0;
int player2 = 0;

void setup(){
   size(500, 500);   
   oscp5 = new OscP5(this, 7000);
   mrl = new NetAddress("127.0.0.1", 7000);
   posX = width/2;
   posY = height/2;
}

void draw(){
  background(0);
  //interface
  strokeWeight(1);
  stroke(255);
  line(250, 0, 250, 500);
  //start game
  if(startPong == true){
    moveBall();
  }
  //paddles position
  paddles();
  //show score
  text(player1, 120,20);
  text(player2, 360,20);
}

//check message to start game and player position
void oscEvent(OscMessage received){
  print("received an osc message");
  print("message: " + received.addrPattern());
  println(" typetag: " + received.typetag());
  
  if(received.checkAddrPattern("start")){
    println("startgame");
    begin = 1;
    if (begin == 1.0)
    startPong = true;
    else
    startPong = false;
    println("StartPong is set to:" + startPong);
  }
  
  if(received.checkAddrPattern("player")){
    pad2 = received.get(0).floatValue();
  }
}

//start game
void keyPressed(){
  if(key == 's'){
    send = new OscMessage("start");
    send.add(1.0);
    oscp5.send(send, mrl);
  }
}

//game conditions
void moveBall(){
  //ball posiiton co-ordinates
  posX = posX + speedX;
  posY = posY + speedY;
  
  //binding conditions
  if(posX>480 && posY > pad2 && posY < pad2+padHeight){
    player2++;
    speedX = speedX * -1;
    posX = posX + speedX;
  }
  else if(posX < 20 && posY > pad1 && posY< pad1+padHeight){
    player1++;
    speedX = speedX * -1;
    posX = posX + speedX;
  }
  
  if(posY>height-5 || posY<5){
    speedY = speedY * -1;
    posY = posY + speedY;
  }
  //restart game
  if(posX > width || posX <0){
    startPong = false;
    posX = width/2;
    posY = height/2;
    player1 = 0;
    player2 = 0;
  }
}

//paddles move
void paddles(){
  //define own paddle position
  pad1 = mouseY;
  //paddle1
  rect(0, pad1, 10, padHeight);
  //paddle2
  rect(490, pad2, 10, padHeight);
  //ball position
  ellipse(posX, posY, radius, radius);
  //send own paddle position
  OscMessage message = new OscMessage("player");
  message.add(pad1);
  oscp5.send(message, mrl);
}