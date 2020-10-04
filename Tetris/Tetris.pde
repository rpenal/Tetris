int PScreenwidth = 360;
int PScreenlenght = 540;
int FichaPScreenlenght = 30;

void settings() {
  size(PScreenwidth, PScreenlenght);
}
PFont l, debug, p;
int Xcellamount = PScreenwidth/FichaPScreenlenght;
int Ycellamount = PScreenlenght/FichaPScreenlenght;
int Totalcellamount = Xcellamount*Ycellamount;
int Xcellpos, Ycellpos;
int[] Positions = {};
int[] PositionsFix = {};
int[] PositionsFailing = {0, 0, 0, 0};

void setup() {
  frameRate(10);
  l = createFont("Arial", 40, true);
  debug = createFont("Arial", 8, true);
  p = createFont("Arial", 15, true);
  for (int i = 0; i < Totalcellamount; i++) {
    Positions = append(Positions, 0);
    PositionsFix = append(PositionsFix, 0);
  }
}


float R, G, B;
int pos = (int)random(2, Xcellamount-2);
int state, points;
int form = (int)random(7);
int rotation = 0;
int turn = 0;
boolean Lside, Rside, Bottom, lose;

void draw() {
  state = 1;
  points = 0;
  Bottom = false;
  for (int i = 0; i <= 3; i++) {
    if (PositionsFailing[i]/Xcellamount >= Ycellamount-1) {
      Bottom = true;
    } else if ((PositionsFailing[i] + Xcellamount >= 0) && (PositionsFailing[i] + Xcellamount <= Totalcellamount-1)) {
      if ((PositionsFix[PositionsFailing[i] + Xcellamount] == 1)) {
        Bottom = true;
      }
    }
  }
  lose = Checklose();
  println(lose);
  if ((!Bottom) && (!lose)) {
    pos += Xcellamount;
  } else if ((Bottom) && (!lose)){
    if (turn ==0) {
      turn = 1;
    } else if (turn == 1) {
      for (int i = 0; i <= 3; i++) {
        if ((PositionsFailing[i] >= 0) && (PositionsFailing[i] <= Totalcellamount-1)) {
        PositionsFix[PositionsFailing[i]] = 1;
        }
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
  fill(0);
  textFont(p);
  text("Points =" + points,10, 15);
  textFont(debug);
  for (int i = 0; i <= Totalcellamount; i++) {
    Ycellpos = i/Xcellamount;
    Xcellpos = i%Xcellamount;
    text(i, Xcellpos * FichaPScreenlenght + 10, Ycellpos * FichaPScreenlenght + 15);
  }
  for (int Y = 0; Y <= PScreenlenght; Y += FichaPScreenlenght) {
    line(0, Y, PScreenwidth, Y);
  }
  for (int X = 0; X <= PScreenwidth; X += FichaPScreenlenght) {
    line(X, 0, X, PScreenlenght);
  }
  for (int i = 0; i < Totalcellamount; i++) {
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
    if ((PositionsFailing[i]>= 0) && (PositionsFailing[i]<= Totalcellamount-1)) {
      Positions[PositionsFailing[i]] = 1;
    }
  }


  for (int i = 0; i <= Totalcellamount - 1; i++) {
    if ((Positions[i] == 1)|| (PositionsFix[i] == 1)) {
      square(i%Xcellamount *FichaPScreenlenght, (i/Xcellamount) * FichaPScreenlenght, FichaPScreenlenght);
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
      points += 100;
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
  if (lose) {
      noLoop();
      delay(1000);
      lose();
  }
}
void keyPressed() {
  Lside = CheckLside();
  Rside = CheckRside();
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

Boolean CheckLside() {
  for (int i = 0; i <= 3; i++) {
    if (PositionsFailing[i]%Xcellamount ==0) {
      return true;
    }
    if ((PositionsFailing[i] - 1 >= 0) && (PositionsFailing[i] - 1 <= Totalcellamount-1) && (PositionsFailing[i] + Xcellamount - 1 >= 0) && (PositionsFailing[i] + Xcellamount -  1 <= Totalcellamount-1)) {
      if ((PositionsFix[PositionsFailing[i] - 1] == 1) || (PositionsFix[PositionsFailing[i] + Xcellamount - 1] == 1)) {
        return true;
      }
    }
  }
  return false;
}

Boolean CheckRside() {
  for (int i = 0; i <= 3; i++) {
    if (PositionsFailing[i]%Xcellamount == Xcellamount-1) {
      return true;
    }
    if ((PositionsFailing[i] + 1 >= 0) && (PositionsFailing[i] + 1 <= Totalcellamount-1) && (PositionsFailing[i] + Xcellamount + 1 >= 0) && (PositionsFailing[i] + Xcellamount+  1 <= Totalcellamount-1)) {
      if ((PositionsFix[PositionsFailing[i] + 1] == 1) || (PositionsFix[PositionsFailing[i] + Xcellamount + 1] == 1)) {
        return true;
      }
    }
  }
  return false;
}

Boolean Checklose() {
    for (int i = 0; i <= Xcellamount-1; i++) {
      if (PositionsFix[Xcellamount + i] == 1) {
        return true;
      }
    }
      return false;
  }
  
void lose() {
      textFont(l);
      fill(0);
      text("Fin del juego", PScreenwidth/5, PScreenlenght/2);
}
