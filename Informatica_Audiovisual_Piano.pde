import processing.video.*;
 
// Variable for capture device
Capture video;
 
// A variable for the color we are searching for.
color trackColor;

ColorTracker tracker;

Piano piano;
final int div = 7;
int p;

//1366x768 es la resolución fullScreen de mi portatil (Alex)
// The request resolution is not supported 
 
void setup() {
// size(1280,720);
 fullScreen();
 
  p = width/div; //proporcion
  
  String[] c = Capture.list();
  printArray(c);
  
//  video = new Capture(this, c[6]);
  video = new Capture(this,width,height);
  
  println(width + " " + height );
  
  video.start();
  trackColor = color(255, 0, 0);
  
  
  Minim[] minims = new Minim[7];
  for(int i = 0; i < 7; i++){
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
  
  
  image(video, 0, 0);
  
  //background(color(0, 0, 0));
  
  // Guardamos las coordenadas x e y obtenidas del tracker
  int[] coordenadas = tracker.trackColor(video);
  
  piano.display();
 
  if(coordenadas[0] != -1)
  piano.tocar(coordenadas[0]);
  
  
 // piano.tocar(mouseX);
  
  
}
 
void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}