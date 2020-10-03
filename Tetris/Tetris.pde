int ancho = 510;
int largo = 720;
int Fichalargo = 30;

void settings() {
  size(ancho, largo);
}
PFont f;
PFont g;
int Xcellamount = ancho/Fichalargo;
int Ycellamount = largo/Fichalargo;
int TotalCells = Xcellamount*Ycellamount;
int line = 0;
int Xcellpos;
int Ycellpos;
int[] Positions = {};
int[] PositionsFix = {};
int[] PositionsFailing = {0, 0, 0, 0};

void setup() {
  frameRate(60);
  f = createFont("Arial", 16, true);
  g = createFont("Arial", 8, true);
  for (int i = 0; i < TotalCells; i++) {
    Positions = append(Positions, 0);
    PositionsFix = append(PositionsFix, 0);
  }
}


float R, G, B;
int pos = (int)random(2, Xcellamount-2);
int state = 0;
int form = (int)random(7);
int rotation = 0;
int turn = 0;

void draw() {
  delay(100);
  state = 1;
  boolean Bottom = false;

  for (int i = 0; i <= 3; i++) {
    if (PositionsFailing[i]/Xcellamount >= Ycellamount-1) {
      Bottom = true;
    } else if ((PositionsFailing[i] + Xcellamount >= 0) && (PositionsFailing[i] + Xcellamount <= TotalCells-1)) {
      if ((PositionsFix[PositionsFailing[i] + Xcellamount] == 1)) {
        Bottom = true;
      }
    }
  }

  if (!Bottom) {
    pos += Xcellamount;
  } else {
    if (turn ==0) {
      turn = 1;
    } else if (turn == 1) {
      for (int i = 0; i <= 3; i++) {
        PositionsFix[PositionsFailing[i]] = 1;
        PositionsFailing[i] = 0;
      }
      pos = (int)random(2, Xcellamount-2);
      Bottom = false;
      form = (int)random(7);
      rotation = 0;
      turn =0;
    }
  }
  background(255);
  textFont(g);
  for (int i = 0; i <= TotalCells; i++) {
    Ycellpos = i/Xcellamount;
    Xcellpos = i%Xcellamount;
    fill(0);
    text(i, Xcellpos * Fichalargo + 10, Ycellpos * Fichalargo + 15);
  }
  for (int Y = 0; Y <= largo; Y += Fichalargo) {
    line(0, Y, ancho, Y);
  }
  for (int X = 0; X <= ancho; X += Fichalargo) {
    line(X, 0, X, largo);
  }
  for (int i = 0; i < TotalCells; i++) {
    Positions[i] =0;
  }
  fill(0, 100, 255);


  if (form == 0) {
    /* T */
    if (rotation == 0) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos+1;
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation == 1) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos+Xcellamount;
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation == 2) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos+1;
      PositionsFailing[3] = pos+Xcellamount;
    } else if (rotation == 3) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+1;
      PositionsFailing[2] = pos+Xcellamount;
      PositionsFailing[3] = pos-Xcellamount;
    }
  } else if (form == 1) {
    /* J */
    if (rotation == 0) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos-(2*Xcellamount);
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation == 1) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos-2;
      PositionsFailing[3] = pos+Xcellamount;
    } else if (rotation == 2) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+(2*Xcellamount);
      PositionsFailing[2] = pos+Xcellamount;
      PositionsFailing[3] = pos+1;
    } else if (rotation == 3) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+1;
      PositionsFailing[2] = pos+2;
      PositionsFailing[3] = pos-Xcellamount;
    }
  } else if (form == 2) {
    /*L */
    if (rotation == 0) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+1;
      PositionsFailing[2] = pos-(2*Xcellamount);
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation == 1) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos-2;
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation == 2) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos+Xcellamount;
      PositionsFailing[3] = pos+(2*Xcellamount);
    } else if (rotation == 3) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+1;
      PositionsFailing[2] = pos+2;
      PositionsFailing[3] = pos+Xcellamount;
    }
  } else if (form == 3) {
    /* Z */
    if (rotation%2 == 0) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+1;
      PositionsFailing[2] = pos-Xcellamount-1;
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation%2 == 1) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-Xcellamount;
      PositionsFailing[2] = pos-1;
      PositionsFailing[3] = pos+Xcellamount-1;
    }
  } else if (form == 4) {
    /* S */
    if (rotation%2 == 0) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos-Xcellamount;
      PositionsFailing[3] = pos-Xcellamount+1;
    } else if (rotation%2 == 1) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-Xcellamount-1;
      PositionsFailing[2] = pos-1;
      PositionsFailing[3] = pos+Xcellamount;
    }
  } else if (form == 5) {
    /* I */
    if (rotation%2 == 0) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-Xcellamount;
      PositionsFailing[2] = pos+Xcellamount;
      PositionsFailing[3] = pos-(2*Xcellamount);
    } else if (rotation%2 == 1) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-2;
      PositionsFailing[2] = pos-1;
      PositionsFailing[3] = pos+1;
    }
  } else if (form == 6) {
    /* SQ */
    PositionsFailing[0] = pos;
    PositionsFailing[1] = pos+1;
    PositionsFailing[2] = pos-Xcellamount+1;  
    PositionsFailing[3] = pos-Xcellamount;
  }

  for (int i = 0; i <= 3; i++) {
    if ((PositionsFailing[i]>= 0) && (PositionsFailing[i]<= TotalCells-1)) {
      Positions[PositionsFailing[i]] = 1;
    }
  }


  for (int i = 0; i <= TotalCells - 1; i++) {
    if ((Positions[i] == 1)|| (PositionsFix[i] == 1)) {
      square(i%Xcellamount *Fichalargo, (i/Xcellamount) * Fichalargo, Fichalargo);
    }
  }
  for (int i = 0; i <= Ycellamount-1; i++) {
    int line = 0;
    for (int j = 0; j <= Xcellamount-1; j++) {
      if (PositionsFix[i*Xcellamount + j] == 1) {
        line++;
      }
    }
    if (line ==Xcellamount) {
      for (int j = 0; j <= Xcellamount-1; j++) {
        PositionsFix[i*Xcellamount + j] = 0;
      }
      for (int k = i; k>=1; k--) {
        for (int m = 0; m <= 23; m++) {
          PositionsFix[k*Xcellamount + m] = PositionsFix[k*Xcellamount + m - Xcellamount];
        }
      }
    }
  }
}
void keyPressed() {
  for (int i = 0; i <= 3; i++) {
    if (PositionsFailing[i]%Xcellamount ==0) {
      Lside = true;}
    if ((PositionsFailing[i] - 1 >= 0) && (PositionsFailing[i] - 1 <= TotalCells-1)) {
      if ((PositionsFix[PositionsFailing[i] - 1] == 1)) {
        Lside = true;
      }
    }
    
    if (PositionsFailing[i]%Xcellamount == Xcellamount-1) {
      Rside = true;
    }
    if ((PositionsFailing[i] + 1 >= 0) && (PositionsFailing[i] + 1 <= TotalCells-1)) {
      if ((PositionsFix[PositionsFailing[i] + 1] == 1)) {
        Rside = true;
      }
    }

    if (PositionsFailing[i]/Xcellamount >= Ycellamount-2) {
      Bottom = true;
    }

  }
  if ((keyCode == LEFT)&& (!Lside) && (state == 1) && (turn <1)) {
    pos--;
    state = 0;
  } else if ((keyCode == RIGHT) && (!Rside) && (state == 1) && (turn <1)) {
    pos++;
    state = 0;
  } else if ((keyCode == 32) && (turn <1)) {
    rotation++;
    if (rotation >= 4) {
      rotation = rotation%4;
    }
  }
}
