import processing.video.*;

// Variable for capture device
Capture video;

// A variable for the color we are searching for.
color trackColor;

ColorTracker tracker;

Piano piano;
final int div = 7;
int p;

boolean showPiano = false;
//1366x768 es la resolución fullScreen de mi portatil (Alex)
// The request resolution is not supported 

void setup() {

  size(640, 480);

  p = width/div; //proporcion

  video = new Capture(this,width,height);

  video.start();
  trackColor = color(255, 0, 0);


  Minim[] minims = new Minim[7];
  for (int i = 0; i < 7; i++) {
    minims[i] = new Minim(this);
  }

  tracker = new ColorTracker();

  piano = new Piano(minims);
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  video.loadPixels();


  if (showPiano == false)
    image(video, 0, 0);
  else
    background(color(0, 0, 0));

  // Guardamos las coordenadas x e y obtenidas del tracker
  int[] coordenadas = tracker.trackColor(video);

  piano.display();

  piano.tocar(coordenadas[0]);

}


void keyPressed() {
  switch(keyCode) {
  case 83: //s
    showPiano = !showPiano;
    break;
  }
}

boolean pass = true;
int x1,y1,w,h;
void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
 // int loc = mouseX + mouseY*video.width;
  //trackColor = video.pixels[loc];
  
    if(!pass){
      int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
  }
  
  if(pass){
  println("press " + mouseX,mouseY);
  x1 = mouseX;
  y1 = mouseY;
  pass = false;
  }
}




void mouseDragged(){
   println("dragg " + mouseX,mouseY);  
   rect(x1,y1,mouseX-x1,mouseY-y1);
   w = mouseX-x1;
   h = mouseY-y1;
   p = w / 7; 
}