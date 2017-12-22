class Piano { //<>//

  ArrayList<Tecla> teclas;
  Minim[] minims;
  String pianoKey = "pk", lastPianoKey = "lpk";
  
  Tecla teclaTocada;
  Tecla lastTeclaTocada;

  public Piano(Minim[] _minims) {

    lastTeclaTocada = new Tecla("s.wav", _minims[1]);
    teclaTocada = new Tecla("h.wav", _minims[5]);

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
    
    if(maxx == -1){
      for (int i=0; i < teclas.size(); i++) {
        teclas.get(i).tocada = false;
      }
    
    } else{
    
        int indexTecla = 0;
        for (int i=0 ; i < div ; i++) {
          if ((i*p) + x1 <= maxx&& maxx<=((i+1)*p)+x1) {
            indexTecla = i;
          }
        }
      
        lastTeclaTocada = teclaTocada;
        teclaTocada = teclas.get(indexTecla);
            
        if(!lastTeclaTocada.equals(teclaTocada)){
          lastTeclaTocada.tocada = false;
          teclaTocada.tocada = true;
          teclaTocada.tocar();  
          
         }
    }
    
    notas.add(new Nota(teclaTocada));
  }
}