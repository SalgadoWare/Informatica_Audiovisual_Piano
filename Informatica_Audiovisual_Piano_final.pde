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

Tecla teclaTocada;

ArrayList <Nota> notas = new ArrayList<Nota>();

boolean mostrarNotas = false;

int contadorFrame = 0;

// Utilizado para la grabación de audio
Minim minim;
AudioInput in;
AudioRecorder recorder;
boolean recording = false;

//-----------------Juego--------------------
boolean modoJuego = false;
Minim minimJuego;
//------------------------------------------

PFont f;

void setup() {

  size(1280, 960);

  p = width/div; //proporcion

  video = new Capture(this, width, height);

  video.start();
  trackColor = color(255, 0, 0);


  Minim[] minims = new Minim[7];
  for (int i = 0; i < 7; i++) {
    minims[i] = new Minim(this);
  }

  tracker = new ColorTracker();

  piano = new Piano(minims);
  
  //---------------Juego------------------
  minimJuego = new Minim(this);
  //--------------------------------------

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048);
  recorder = minim.createRecorder(in, "grabacionAudio.wav");

  f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
  textFont(f,36);
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {

  background(0);
  video.loadPixels();


  if (showPiano == false)
    image(video, 0, 0);
  else
    background(color(0, 0, 0));

  // Guardamos las coordenadas x e y obtenidas del tracker
  int[] coordenadas = tracker.trackColor(video);

  piano.display();

  piano.tocar(coordenadas[0]);

  if (recording) {
     fill(255);
     text("Grabando audio (Pulsa g para finalizar)",100,100);
  }

  if (showPiano) {
    mostrarNotas();
  }
}


void keyPressed() {
  switch(keyCode) {
  case 83: //s
    showPiano = !showPiano;
    break;
  case UP:
    tracker.threshold++;
    break;
  case DOWN:
    tracker.threshold--;
    break;
  case LEFT:
    tracker.worldRecord += 10 ;
    break;
  case RIGHT:
    tracker.worldRecord -= 10 ;
    break;
    
  //---------------------Juego---------------------
  case 80: //letra p
    if(modoJuego == false){
      modoJuego = true;
      piano.modoJuego = true;
      piano.modoJuego(minimJuego);
    }
    else{
      piano.modoJuego = false;
      modoJuego = false;
    }
     break;
     
  //-------------------------------------------------
  
  case 67:
    saveFrame("captura" + contadorFrame + ".png");
  break;
  
  case 71:
    if (recording) {
      recording = false;
      recorder.endRecord();
    } else {
      recording = true;
      recorder.beginRecord();
    }
  break;
  
  }

  if(key == 'n')
    mostrarNotas = true;

   
  //println(tracker.threshold +" " +tracker.worldRecord);
}


boolean pass = true;
int x1, y1, w, h;
void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  // int loc = mouseX + mouseY*video.width;
  //trackColor = video.pixels[loc];

  if (!pass) {
    int loc = mouseX + mouseY*video.width;
    trackColor = video.pixels[loc];
  }

  if (pass) {
    x1 = mouseX;
    y1 = mouseY;
    pass = false;
  }
}

void mouseDragged() {  
  w = mouseX-x1;
  h = mouseY-y1;
  p = w / 7;
}

void mostrarNotas() {


  for (int i = 0; i < notas.size(); i++) {
    notas.get(i).y1 -= random(-3, 5);
    notas.get(i).y2 -= random(-6, 6);
    notas.get(i).y3 -= random(-5, 5);
    notas.get(i).x1 -= random(-4, 4);
    notas.get(i).x2 += random(5);
    notas.get(i).x3 -= random(0, 7);

    notas.get(i).display();
  }
}