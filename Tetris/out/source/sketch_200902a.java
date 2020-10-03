import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_200902a extends PApplet {

public void settings(){
  size(1260,720);
}
PFont f;
PFont g;
int Xcellamount = 1260/30;
int Ycellamount = 720/30;
int TotalCells = Xcellamount*Ycellamount;
int line = 0;
int Xcellpos;
int Ycellpos;

class Squares {
  int PosX;
  int PosY;
  Squares(int tempPosX, int tempPosY) {
    PosX = tempPosX;
    PosY = tempPosY;    
  }
}

public void setup(){
  frameRate(30);
  f = createFont("Arial",16,true);
  g = createFont("Arial",8,true);
  int[] Positions = {};
  for (int i = 0; i < TotalCells; i++){
    Positions = append(Positions,0);
  }
}

int posX = 21; 
int posY = 0;
float R,G,B;
public void draw(){
  delay(500);
  if (posY < Ycellamount-1) {
  posY += 1;
  R = random(255);
  G = random(255);
  B = random(255);
  }
  background(255);
  textFont(g);
  for (int i = 0; i <= TotalCells; i++) {
  if (i%Xcellamount != 0){
    Ycellpos = i/Xcellamount;
  } else {
    Ycellpos = (i/Xcellamount)-1;
  }
  
  Xcellpos = (i-1)%Xcellamount;
  fill(0);
  text(i-1,Xcellpos * 30 + 10, Ycellpos * 30 + 15);
  }
  for (int Y = 0; Y <= 720; Y += 30){
    line(0, Y, 1280, Y);
  }
  for (int X = 0; X <= 1280; X += 30) {
    line(X,0,X,720);
  }
  fill(R,G,B);
  square(posX *30,posY * 30, 30);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_200902a" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
