
import processing.net.*;

int port = 8000;
boolean myServerRunning = true;
int bgColor = 0;
int direction = 1;
int textLine = 60;
String typing = "";

Server myServer;

void setup()
{
  size(400, 400);
  textFont(createFont("SanSerif", 16));
  myServer = new Server(this, 8000); // Starts a myServer on port 10002
  background(0);
}

void draw(){
  println("Server started on " + myServer);
  
  Client thisClient = myServer.available();
  if (thisClient != null) {
      text("client says: " + thisClient.readString(), 15, textLine);
      textLine = textLine + 35;
  }
}

void keyPressed() {
   if (myServerRunning == true){
     if (key == '\n' ) {
       //typing = "";
       myServer.write(typing);
       text("", 15, textLine);
       textLine = textLine + 35;
       typing = "";
     } else{
       typing = typing + key;
       text("server: "+typing, 15, textLine);
     }
    
    } 
  else{
    text("stopped", 15, 65);
  }
}