class Piano { //<>//

  ArrayList<Tecla> teclas;
  Minim[] minims;
  String pianoKey = "pk", lastPianoKey = "lpk";

  public Piano(Minim[] _minims) {

    minims = _minims;
    teclas = new ArrayList<Tecla>();

    // Poner la ruta de los ficheros para cada nota
    teclas.add(new Tecla("a.wav", minims[0]));
    teclas.add(new Tecla("s.wav", minims[1]));
    teclas.add(new Tecla("d.wav", minims[2]));
    teclas.add(new Tecla("f.wav", minims[3]));
    teclas.add(new Tecla("g.wav", minims[4]));
    teclas.add(new Tecla("h.wav", minims[5]));
    teclas.add(new Tecla("j.wav", minims[6])); //<>//
  }

  void display() {
    for (int i=0; i < teclas.size(); i++) {
      teclas.get(i).display(i);
    }
  }

  // Determinas con la x que tecla se debe de reproducir y llamar al 
  // metodo tocar de dicha tecla
  void tocar(int maxx) {

    //detectar el cuadrante

    //¿previamente se ha llamado a este cuadrante?
    //sí -> no hacer nada
    //no -> se tiene que llamar al método play

    int i = 0;

    for (i = 0; i < div; i++) {
      if (i*p <=maxx && maxx <= (i+1)*p) {
        switch (i) {
        case 0:
          pianoKey = "a";
          break;
        case 1:
          pianoKey = "s";
          break;
        case 2:
          pianoKey = "d";
          break;
        case 3:
          pianoKey = "f";
          break;
        case 4:
          pianoKey = "g";
          break;
        case 5:
          pianoKey = "h";
          break;
        case 6:
          pianoKey = "j";
          break;
        default:
          break;
        }
        break;
      }
    }

    if (!lastPianoKey.equalsIgnoreCase(pianoKey)) {
      teclas.get(i).tocar();
      lastPianoKey = pianoKey.toString();
    }
  }
}