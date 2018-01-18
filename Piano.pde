class Piano { //<>// //<>//

  ArrayList<Tecla> teclas;
  Minim[] minims;
  String pianoKey = "pk", lastPianoKey = "lpk";

  Tecla teclaTocada;
  Tecla lastTeclaTocada;


  //--------------------------Juego-------------------------
  ArrayList<String> teclasTocadas = new ArrayList<String>(); //Todas las teclas tocadas
  ArrayList <Tecla> teclasJuego = new ArrayList <Tecla>(); //Tres teclas aleatorias para el juego
  int numTeclasTocadas;
  boolean modoJuego = false;
  Minim minimJuego;
  //--------------------------------------------------------

  public Piano(Minim[] _minims) {

    lastTeclaTocada = new Tecla("do.wav", _minims[1]);
    teclaTocada = new Tecla("la.wav", _minims[5]);

    minims = _minims;
    teclas = new ArrayList<Tecla>();

    // Poner la ruta de los ficheros para cada nota
    teclas.add(new Tecla("do.wav", minims[0]));
    teclas.add(new Tecla("re.wav", minims[1]));
    teclas.add(new Tecla("mi.wav", minims[2]));
    teclas.add(new Tecla("fa.wav", minims[3]));
    teclas.add(new Tecla("sol.wav", minims[4]));
    teclas.add(new Tecla("la.wav", minims[5]));
    teclas.add(new Tecla("si.wav", minims[6]));
  }

  void display() {
    for (int i=0; i < teclas.size(); i++) {
      teclas.get(i).display(i);
    }
  }

  // Determinas con la x que tecla se debe de reproducir y llamar al 
  // metodo tocar de dicha tecla
  void tocar(int maxx) {

    //--------------------Juego------------------------
    if (modoJuego == false) {
      numTeclasTocadas = teclasTocadas.size();
    }
    //-------------------------------------------------

    if (maxx == -1) {
      for (int i=0; i < teclas.size(); i++) {
        teclas.get(i).tocada = false;
      }
    } else {

      int indexTecla = 0;
      for (int i=0; i < div; i++) {
        if ((i*p) + x1 <= maxx&& maxx<=((i+1)*p)+x1) {
          indexTecla = i;
        }
      }

      lastTeclaTocada = teclaTocada;
      teclaTocada = teclas.get(indexTecla);

      if (!lastTeclaTocada.equals(teclaTocada)) {
        lastTeclaTocada.tocada = false;
        teclaTocada.tocada = true;
        teclaTocada.tocar();  

        //--------------------Juego-----------------------
        println("Tecla tocada: " + teclaTocada.song);
        teclasTocadas.add(teclaTocada.song);
        ultimasTeclas();
        //------------------------------------------------
      }
    }

    //-------------------Juego----------------------
    notas.add(new Nota(teclaTocada));
    //----------------------------------------------
  }



  //-----------------------------------Juego---------------------------------------------------
  void ultimasTeclas() {

    boolean correcto = true;
    if ((teclasTocadas.size() - numTeclasTocadas) == 3) {
      int num = teclasJuego.size() -1;
      for (int i = teclasTocadas.size() -1; i >= teclasTocadas.size() - 3; i--) {
        //println("U " + teclasTocadas.get(i));
        //println("R " + teclasJuego.get(num).song);

        if (teclasTocadas.get(i) != teclasJuego.get(num).song) {
          correcto = false;
        }
        num--;
      }

      if (correcto) {
        AudioPlayer player = minimJuego.loadFile("acierto.mp3");
        player.play();
      } else {
        AudioPlayer player = minimJuego.loadFile("error.mp3");
        player.play();
      }
    }
  }


  void modoJuego(Minim minimJuego) {

    this.minimJuego = minimJuego;

    for (int i = 0; i < 3; i++) {
      int random = (int)random(teclas.size());
      teclasJuego.add(teclas.get(random));
      teclas.get(random).tocar();
      
      //Para probar con do re mi
      /*teclasJuego.add(teclas.get(i));
      teclas.get(i).tocar();*/
      
      delay(500);
      println("NOTA: " + teclas.get(random).song);
    }
  }
  //------------------------------------------------------------------------------------
}