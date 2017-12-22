import ddf.minim.*;
AudioPlayer player;

class Tecla {
  Minim minim;
  AudioPlayer player;
  boolean tocada;

  private int altura, anchura;
  public int x, y;



  public Tecla (String song, Minim _minim) {
    minim = _minim;
    player = minim.loadFile(song);
    altura = (2/3) * h;
    y =  height - altura;
  }

  public void tocar() {
    player.play();
    player.rewind();
    tocada = true;
  }


  public void display(int collectionPosition) {


    if (showPiano) {
      anchura = width * 1/7;
      altura = height * 2/3;
      x = collectionPosition*anchura;


      if (showPiano) {
        if (tocada) fill(color(0, 0, 0, 30));
        else fill(color(255, 255, 255));
      } else {
        fill(color(255, 255, 0, 10));
      }
      rect(x, height - altura, anchura, altura);
    } else {
      anchura = w * 1/7;
      altura = h * 2/3;
      x = collectionPosition*anchura;

      if (showPiano) {
        if (tocada) fill(color(0, 0, 0, 30));
        else fill(color(255, 255, 255));
      } else {
        fill(color(255, 255, 0, 10));
      }
      rect(x+x1, y1 - altura, anchura, altura);
    }
  }
  
  
  
  public ArrayList <PImage> generarNotas() {

    ArrayList <PImage> notas = new ArrayList <PImage> ();
    
    PImage nota1;
    PImage nota2;
    PImage nota3;

    String[] nombres =new  String[3];
    nombres[0] = "nota1.png";
    nombres[1] = "nota2.png";
    nombres[2] = "nota3.png";

    String random = nombres[(int)random(3)];

    nota1 = loadImage(random);
    
    random = nombres[(int)random(3)];
    
    nota2 = loadImage(random);
    
    random = nombres[(int)random(3)];
    
    nota3 = loadImage(random);
    nota1.resize(60, 60);
    nota2.resize(60, 60);
    nota3.resize(60, 60);


    notas.add(nota1);
    notas.add(nota2);
    notas.add(nota3);

  
    return notas;

  }

}