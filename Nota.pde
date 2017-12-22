class Nota {


  int y1;
  int y2;
  int y3;
  
  int x1, x2, x3;

  ArrayList <PImage> notas;

  Tecla teclaTocada;
  
  long nacimiento;

  public Nota(Tecla teclaTocada) {
    
    this.teclaTocada = teclaTocada;
    notas = teclaTocada.generarNotas();
    y1 = 150;
    y2 = 150;
    y3 = 150;
    nacimiento = System.currentTimeMillis();
  }

  void display() {
    if (System.currentTimeMillis() < nacimiento + 3000) {
    image(notas.get(0), teclaTocada.x+10 -x1 + teclaTocada.anchura/2 -5, y1);
    image(notas.get(1), teclaTocada.x-15 + x2 + teclaTocada.anchura/2 +15, y2);
    image(notas.get(2), teclaTocada.x - x3+ teclaTocada.anchura/2 -26, y3);
    }
  }
}