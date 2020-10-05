int PScreenwidth = 360;
int PScreenlenght = 540;
int TScreenwidth = 560;
int Squaresidelenght = 30;

void settings() {
  size(TScreenwidth, PScreenlenght);
}
PFont l, debug, p;
int Xcellamount = PScreenwidth/Squaresidelenght;
int Ycellamount = PScreenlenght/Squaresidelenght;
int Totalcellamount = Xcellamount*Ycellamount;
int Xcellpos, Ycellpos;
int framerate = 5;
int[] Positions = {};
int[] PositionsFix = {};
int[] PositionsFailing = {0, 0, 0, 0};

void setup() {
  l = createFont("Arial", 40, true);
  p = createFont("Arial", 20, true);
  for (int i = 0; i < Totalcellamount; i++) {
    Positions = append(Positions, 0);
    PositionsFix = append(PositionsFix, 0);
  }
}


float R, G, B;
int pos = (int)random(2, Xcellamount-2);
int state; 
int points = 0;
int next =(int)random(7);
int form =(int)random(7);
int rotation = 0;
int turn = 0;
boolean Lside, Rside, Bottom, lose;

void draw() {
  frameRate(framerate);
  state = 1;
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
  if ((!Bottom) && (!lose)) {
    pos += Xcellamount;
  } else if ((Bottom) && (!lose)) {
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
      form = next;
      next =(int)random(7);
      rotation = 0;
      turn =0;
    }
  }
  background(255);
  fill(0);
  DrawUI();
  debug();
  for (int Y = 0; Y <= PScreenlenght; Y += Squaresidelenght) {
    line(0, Y, PScreenwidth, Y);
  }
  for (int X = 0; X <= PScreenwidth; X += Squaresidelenght) {
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
      square(i%Xcellamount *Squaresidelenght, (i/Xcellamount) * Squaresidelenght, Squaresidelenght);
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
        for (int m = 0; m <= Xcellamount-1; m++) {
          PositionsFix[k*Xcellamount + m] = PositionsFix[k*Xcellamount + m - Xcellamount];
        }
      }
      framerate += points/300;
    }
  }
  if (lose) {
    noLoop();
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
  } else if (keyCode == DOWN) {
      frameRate(3*framerate);
    }
}

Boolean CheckLside() {
  for (int i = 0; i <= 3; i++) {
    if (PositionsFailing[i]%Xcellamount ==0) {
      return true;
    }
    if (((PositionsFailing[i] - 1 >= 0) && (PositionsFailing[i] - 1 <= Totalcellamount-1)  && (PositionsFix[PositionsFailing[i] - 1] == 1)) || (((PositionsFailing[i] + Xcellamount - 1 >= 0) && (PositionsFailing[i] + Xcellamount -  1 <= Totalcellamount-1))  && (PositionsFix[PositionsFailing[i] + Xcellamount - 1] == 1))) {
        return true;
    }
  }
  return false;
}

Boolean CheckRside() {
  for (int i = 0; i <= 3; i++) {
    if (PositionsFailing[i]%Xcellamount == Xcellamount-1) {
      return true;
    }
    if (((PositionsFailing[i] + 1 >= 0) && (PositionsFailing[i] + 1 <= Totalcellamount-1)  && (PositionsFix[PositionsFailing[i] + 1] == 1)) || (((PositionsFailing[i] + Xcellamount + 1 >= 0) && (PositionsFailing[i] + Xcellamount +  1 <= Totalcellamount-1)  && (PositionsFix[PositionsFailing[i] + Xcellamount + 1] == 1)))) {
        return true;
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

void DrawUI() {
  push();
  fill(68);
  rect(Xcellamount*Squaresidelenght, 0, TScreenwidth-PScreenwidth, PScreenlenght);
  push();
  stroke(255);
  rectMode(CENTER);
  rect(Xcellamount*Squaresidelenght + (TScreenwidth-PScreenwidth)/2, 3*Squaresidelenght, 2.7*Squaresidelenght, 2.7*Squaresidelenght, 7);
  pop();
  textFont(p);
  fill(255);
  text("Next", (Xcellamount+2.5)*Squaresidelenght, Squaresidelenght);
  text("Score " + points, (Xcellamount+2)*Squaresidelenght, 7*Squaresidelenght);
  text("Rotate with \n spacebar", (Xcellamount+1.5)*Squaresidelenght, 9*Squaresidelenght);
  text("\n Move with left\nand right arrows. \n", (Xcellamount+1.25)*Squaresidelenght, 11*Squaresidelenght);
  text(" \n Accelerate \n with down", (Xcellamount+1.25)*Squaresidelenght, 14*Squaresidelenght);
  fill(0, 100, 255);
  if (next == 0) {
    /* T */
    square((Xcellamount+3+0+0)*Squaresidelenght, Squaresidelenght*(3+0+0), Squaresidelenght/2);
    square((Xcellamount+3+0-0.5)*Squaresidelenght, Squaresidelenght*(3+0+0), Squaresidelenght/2);
    square((Xcellamount+3+0+0.5)*Squaresidelenght, Squaresidelenght*(3+0+0), Squaresidelenght/2);
    square((Xcellamount+3+0+0)*Squaresidelenght, Squaresidelenght*(3+0-0.5), Squaresidelenght/2);
  } else if (next == 1) {
    /* J */
    square((Xcellamount+3+0.2+0)*Squaresidelenght, Squaresidelenght*(3+0.2+0), Squaresidelenght/2);
    square((Xcellamount+3+0.2-0.5)*Squaresidelenght, Squaresidelenght*(3+0.2+0), Squaresidelenght/2);
    square((Xcellamount+3+0.2+0)*Squaresidelenght, Squaresidelenght*(3+0.2-1), Squaresidelenght/2);
    square((Xcellamount+3+0.2+0)*Squaresidelenght, Squaresidelenght*(3+0.2-0.5), Squaresidelenght/2);
  } else if (next == 2) {
    /*L */
    square((Xcellamount+3-0.2+0)*Squaresidelenght, Squaresidelenght*(3+0.2+0), Squaresidelenght/2);
    square((Xcellamount+3-0.2+0.5)*Squaresidelenght, Squaresidelenght*(3+0.2+0), Squaresidelenght/2);
    square((Xcellamount+3-0.2+0)*Squaresidelenght, Squaresidelenght*(3+0.2-1), Squaresidelenght/2);
    square((Xcellamount+3-0.2+0)*Squaresidelenght, Squaresidelenght*(3+0.2-0.5), Squaresidelenght/2);
  } else if (next == 3) {
    /* Z */
    square((Xcellamount+3+0+0)*Squaresidelenght, Squaresidelenght*(3+0+0), Squaresidelenght/2);
    square((Xcellamount+3+0-0.5)*Squaresidelenght, Squaresidelenght*(3+0-0.5), Squaresidelenght/2);
    square((Xcellamount+3+0+0.5)*Squaresidelenght, Squaresidelenght*(3+0+0), Squaresidelenght/2);
    square((Xcellamount+3+0+0)*Squaresidelenght, Squaresidelenght*(3+0-0.5), Squaresidelenght/2);
  } else if (next == 4) {
    /* S */
    square((Xcellamount+3+0+0)*Squaresidelenght, Squaresidelenght*(3+0+0), Squaresidelenght/2);
    square((Xcellamount+3+0-0.5)*Squaresidelenght, Squaresidelenght*(3+0+0), Squaresidelenght/2);
    square((Xcellamount+3+0+0.5)*Squaresidelenght, Squaresidelenght*(3+0-0.5), Squaresidelenght/2);
    square((Xcellamount+3+0+0)*Squaresidelenght, Squaresidelenght*(3+0-0.5), Squaresidelenght/2);
  } else if (next == 5) {
    /* I */
    square((Xcellamount+3+0+0)*Squaresidelenght, Squaresidelenght*(3+0+0.5), Squaresidelenght/2);
    square((Xcellamount+3+0+0)*Squaresidelenght, Squaresidelenght*(3+0+0), Squaresidelenght/2);
    square((Xcellamount+3+0+0)*Squaresidelenght, Squaresidelenght*(3+0-1), Squaresidelenght/2);
    square((Xcellamount+3+0+0)*Squaresidelenght, Squaresidelenght*(3+0-0.5), Squaresidelenght/2);
  } else if (next == 6) {
    /* SQ */
    square((Xcellamount+3-0.2+0.5)*Squaresidelenght, Squaresidelenght*(3+0-0.5), Squaresidelenght/2);
    square((Xcellamount+3-0.2+0.5)*Squaresidelenght, Squaresidelenght*(3+0+0), Squaresidelenght/2);
    square((Xcellamount+3-0.2+0)*Squaresidelenght, Squaresidelenght*(3+0+0), Squaresidelenght/2);
    square((Xcellamount+3-0.2+0)*Squaresidelenght, Squaresidelenght*(3+0-0.5), Squaresidelenght/2);
  }
  pop();
}
