import processing.video.*;

// Variable for capture device
Capture video;

ColorTrakerImproved tracker;

Piano piano;

final int total_notas = 7;
public int proporcion_relativa;
private OpenCV _opencv;
boolean pass = true;
int x1, y1, w, h;
boolean filtro = false;

boolean showPiano = false;

void setup() {

  size(1280, 720, P2D);

  proporcion_relativa = width/total_notas; //proporcion

  video = new Capture(this, width, height);
  _opencv = new OpenCV(this, video.width, video.height);

  Minim[] minims = new Minim[7];
  for (int i = 0; i < 7; i++) {
    minims[i] = new Minim(this);
  }

  video.start();

  tracker = new ColorTrakerImproved(video, _opencv);

  piano = new Piano(minims);
}

void draw() {
  int coordenadaXReferencia;
  
  coordenadaXReferencia = tracker.procesaVideo();

  piano.display();

  piano.tocar(coordenadaXReferencia);
}


void keyPressed() {
  switch(keyCode) {
  case 83: //s
    showPiano = !showPiano;
    break;
  }
  
  if(key == 'f'){
  filtro = !filtro;
  }
}

void mousePressed() {
  if (!pass) {
    color c = get(mouseX, mouseY);
    println("r: " + red(c) + " g: " + green(c) + " b: " + blue(c));

    int hue = int(map(hue(c), 0, 255, 0, 180));
    println("hue to detect: " + hue);

    tracker.rangeLow = hue - 5;
    tracker.rangeHigh = hue + 5;
  }

  if (pass) {
    println("press " + mouseX, mouseY);
    x1 = mouseX;
    y1 = mouseY;
    pass = false;
  }
}

void mouseDragged() {
  println("dragg " + mouseX, mouseY);  
  w = mouseX-x1;
  h = mouseY-y1;
  proporcion_relativa = w / 7;
}