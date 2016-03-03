import processing.net.*;

int port = 8000;
boolean myServerRunning = true;
int bgColor = 0;
int direction = 1;
int textLine = 60;
String typing = "";

Server myServer;
Client thisClient;

void setup()
{
  size(400, 400);
  textFont(createFont("SanSerif", 16));
  thisClient = new Client(this, "127.0.0.1", 8000); // Starts a myServer on port 10002
  background(0);
}

void draw(){
  if (myServerRunning == true){
    if (thisClient.available() > 0) {
         text("server:  " + thisClient.readString(), 15, textLine);
         textLine = textLine + 35;
        }
  }

}

void keyPressed() {
   if (myServerRunning == true){
     if (key == '\n' ) {
       thisClient.write(typing);
       text("", 15, textLine);
       textLine = textLine + 35;
       typing = "";
     } else{
       typing = typing + key;
       text("client: " + typing, 15, textLine);
       
     }
     
    } 
  else{
    text("stopped", 15, 65);
  }
}