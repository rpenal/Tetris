//Declaramos variables globales que serviaran para determinar el tamaño de
// el tablero de juego (PScreenwidth y PScreenlenght) y la longitud de la
//pantalla, tomando en cuenta la sección dedicada a la interfaz de ususario (TScreenwidth)
//Asi como declarar el tamaño del lado de la ficha que compondrá los tetrominós (Squaresidelenght)
int PScreenwidth = 360;
int PScreenlenght = 540;
int TScreenwidth = PScreenlenght+20;
int Squaresidelenght = 30;

//Inicializamos la pantalla
void settings() {
  size(TScreenwidth, PScreenlenght);
}

//Declaramos variables globales que cumpliran objetivos dentro del
//juego como tal.
//PFont l y p son fuentes de texto
//Xcellamount y Ycellamount serán la cantidad de celdas en X (columnas) y Y(filas), respectivamente
//Totalcellamount nos dará el total celdas del tablero
//framerate será util para dictar la velocidad del juego
//Positions servirá para representar el tablero
//PositionsFix servirá para representar las fichas que el jugador no puede mover
//PositionsFailing servirá para representar las fichas sobre las que el jugador tiene control.
//Se inicializa en {0,0,0,0}, ya que su longitud no depende de factores externos. Cada "0" representa una de las fichas del tetrominó
//pos representa la posicion "base" del tetrominó que el jugador controla. Las demas posiciones de las fichas 
//del tetrominó serán dadas en base a esta. Se genera aleatoriamente en un margen de dos fichas alejado de los bordes
//del tablero para así poder evitar errores
//state servirá para limitar la cantidad de veces que el jugador puede mover la ficha lateralmente por frame
//points servirá para llevar la cuenta del puntaje
//next representa el siguiente tetrominó que va a salir
//form representa el tetrominó actual
//rotation representa en cual de las rotaciones se encuentra el tetrominó
//turn sirve para permitir al jugador una pequeña ventana cuando el tetrominó toque el fondo durante la cual
//el jugador puede moverlo horizontalmente
//Los booleanos Lside, Rside, Bottom y lose detectaran si el tetrominó está colisionando a izquierda, derecha, debajo o
//si el jugador ya ha perdido, respectivamente.
PFont l, p;
int Xcellamount = PScreenwidth/Squaresidelenght;
int Ycellamount = PScreenlenght/Squaresidelenght;
int Totalcellamount = Xcellamount*Ycellamount;
int framerate = 5;
int[] Positions = {};
int[] PositionsFix = {};
int[] PositionsFailing = {0, 0, 0, 0};
int pos = (int)random(2, Xcellamount-2);
int state; 
int points = 0;
int next =(int)random(7);
int form =(int)random(7);
int rotation = 0;
int turn = 0;
boolean Lside, Rside, Bottom, lose;

void setup() {
  //Definimos las dos fuentes l y p
  l = createFont("Arial", 40, true);
  p = createFont("Arial", 20, true);
  //Y le damos a los arrays Positions y PositionsFix una longitud igual a la cantidad del celdas del tablero
  for (int i = 0; i < Totalcellamount; i++) {
    Positions = append(Positions, 0);
    PositionsFix = append(PositionsFix, 0);
  }
}

void draw() {
  //Establecemos el framerate del juego, ya que la función draw se ejecuta una vez por frame
  //esto limita la cantidad de veces que se ejecuta por segundo
  frameRate(framerate);
  //Establecemos la variable state a 1 para permitir un movimiento horizontal por frame
  //y Bottom a false, ya que asumimos que la ficha no está colisionando por debajo
  state = 1;
  Bottom = false;
  //Por cada indice en PositionsFailing, verificar si su posicion en Y es mayor o igual la cantidad de filas
  //del tablero, ya que este numero aumenta a medida que la ficha cae. Se le resta 1 ya que la primera fila 
  //debe ser entendida como la fila 0, no como la 1.
  //En caso de que esto no se cumpla, se verifica que la posicion que esta contiene sea mayor que 0 pero menor al 
  //numero total de celdas del tablero menos una, ya que este conteo inicia en 0, para así verificar que esté dentro del tablero.
  //Si es así, se verifica si alguna de las fichas del tetrominó está por encima de alguna ficha "fija"
  //Esto se hace sumando Xcellamount a la posicion actual, ya que está variable representa la cantidad de columnas
  //por cada fila. Si en el array PositionsFailing, el indice correspondiente está ocupado
  //se detecta que la ficha llegó al fondo, y Bottom se establece a true.
  for (int i = 0; i <= 3; i++) {
    if (PositionsFailing[i]/Xcellamount >= Ycellamount-1) {
      Bottom = true;
    } else if ((PositionsFailing[i] + Xcellamount >= 0) && (PositionsFailing[i] + Xcellamount <= Totalcellamount-1)) {
      if ((PositionsFix[PositionsFailing[i] + Xcellamount] == 1)) {
        Bottom = true;
      }
    }
  }
  //Se verifica si se da la condición de perdida, a través de la función Checklose (definida al fondo)
  lose = Checklose();
  //Si la ficha está al fondo y no se ha perdido, se aumenta la variable pos en Xcellamount, ya que estó la hace
  //desplazarse una fila hacia abajo
  //Si se ha llegado al fondo, pero no se ha perdido, en caso de que la variable turn sea 0
  //se cambia a uno y se prosigue con ese frame. Esto permite al jugador mover el tetrominó hacia la derecha o izquierda 
  //durante un corto momento cuando este ya ha llegado al fondo
  //Ya que el tiempo que se da es un frame, a medida que le juego acelera, esta ventana de tiempo se resume
  //en caso de que turn sea 1 (la ventana para mover la ficha ya ha terminado)
  //por cada indice en PositionsFailing, se verifica que esté dentro del tablero, y luego se procede a
  //Establecer dicho indice a 1 en el array PositionsFix, lo cual significa que esa posición está fija
  //y fuera del control del jugador
  //Se crea una nueva posición aleatoria inicial para el nuevo tetrominó
  //la variable form toma el valor que está almacenado en next, para crear el tetrominó que se habia
  //anunciado previamente, y la variable next toma un nuevo valor aleatorio.
  //Se establecen las variables rotation y turn a 0 nuevamente.
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
  //Se limpia el tablero
  background(255);
  //El color de trazos y figuras se establece en negro (0,0,0)
  fill(0);
  //Se llama a la función DrawUI, que se encarga de dibujar la interfaz de usuario (Definida más abajo)
  DrawUI();
  //Se crea la cuadricula del tablero. Por una cordenada Y, se dibuja una linea que va desde (0,Y) hasta
  //(Pscreenwidht,Y) lo cual crea una linea horizontal en una coordenada Y que va desde el costado izquierdo
  //hasta el final del tablero. La coordenada Y de esta linea va aumentando en Squaresidelenght
  //para que la separación tenga el mismo tamaño que la ficha.
  //Se realiza un proceso similar, se crean las lineas verticales, dibujando una linea que va desde (X,0) hasta
  //(X,Pscreenlenght). Esto crea una linea vertical que va desde la parte de arriba hasta el fondo del tablero. La
  //coordenada X de esta linea va aumentando en Squaresidelenght
  //para que la separación tenga el mismo tamaño que la ficha.
  for (int Y = 0; Y <= PScreenlenght; Y += Squaresidelenght) {
    line(0, Y, PScreenwidth, Y);
  }
  for (int X = 0; X <= PScreenwidth; X += Squaresidelenght) {
    line(X, 0, X, PScreenlenght);
  }
  //Se limpia el array Positions, estableciendo todos los valores a 0
  for (int i = 0; i < Totalcellamount; i++) {
    Positions[i] =0;
  }
  //Se cambia el color de trazos y figuras a azul.
  fill(0, 100, 255);
  //Si el valor de form es 0, se crea el tetrominó T
  if (form == 0) {
    // T 
    //Si la rotación es 0, se crean fichas una celda a la izquierda (pos-1) y una ficha a la derecha (pos+1)
    //Así como una por encima (pos-Xcellamount) (Se resta Xcellamount, ya que a mayor sea el valor de pos, más abajo está el tetrominó)
    if (rotation == 0) {
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos+1;
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation == 1) {
      //Si la rotación es 1, se crean fichas una celda a la izquierda (pos-1)
      //una por encima (pos-Xcellamount), y una por debajo (pos+Xcellamount)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos+Xcellamount;
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation == 2) {
      //Si la rotación es 2, se crean fichas una celda a la izquierda (pos-1)
      //una a la derecha (pos+1) y una por debajo (pos+Xcellamount)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos+1;
      PositionsFailing[3] = pos+Xcellamount;
    } else if (rotation == 3) {
      //Finalmente, si la rotación es 3, se crean fichas una celda a la derecha (pos+1)
      //una por encima (pos-Xcellamount), y una por debajo (pos+Xcellamount)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+1;
      PositionsFailing[2] = pos+Xcellamount;
      PositionsFailing[3] = pos-Xcellamount;
    }
  } else if (form == 1) {
    //J
    //Si el valor de form es 1, se crea el tetrominó J
    if (rotation == 0) {
    //Si la rotación es 0, se crean fichas una celda a la izquierda (pos-1), dos filas por encima
    //(pos-(2*Xcellamount)) y una fila por encima (pos-Xcellamount)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos-(2*Xcellamount);
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation == 1) {
      //Si la rotación es 1, se crean fichas una celda a la izquierda (pos-1), dos celdas a la 
      // izquierda (pos-2) y una fila por debajo (pos+Xcellamount)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos-2;
      PositionsFailing[3] = pos+Xcellamount;
    } else if (rotation == 2) {
      //Si la rotación es 2, se crean fichas dos filas por debajo (pos+(2*Xcellamount)), una fila por 
      // debajo (pos+Xcellamount) y una celda a la derecha (pos+1)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+(2*Xcellamount);
      PositionsFailing[2] = pos+Xcellamount;
      PositionsFailing[3] = pos+1;
    } else if (rotation == 3) {
      //Si la rotación es 2, se crean fichas una celda a la derecha, dos celdas a la derecha 
      // (pos+2) y una fila por encima (pos-Xcellamount)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+1;
      PositionsFailing[2] = pos+2;
      PositionsFailing[3] = pos-Xcellamount;
    }
  } else if (form == 2) {
    //L
    //Si el valor de form es 2, se crea el terominó L
    if (rotation == 0) {
      //Si la rotación es 0, se crean fichas una celda a la derecha (pos+1), una fila por
      // encima (pos-Xcellamount) y dos filas por encima (pos-(2*Xcellamount))
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+1;
      PositionsFailing[2] = pos-(2*Xcellamount);
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation == 1) {
      //Si la rotación es 1, se crean fichas una celda a la izquierda (pos-1), dos celdas
      // a la izquierda (pos-2) y una fila por encima (pos-Xcellamount)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos-2;
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation == 2) {
      //Si la rotación es 2, se crean fichas una celda a la izquierda (pos-1), dos celdas
      // una fila por debajo (pos+Xcellamount) y dos filas por debajo (pos+(2*Xcellamount))
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos+Xcellamount;
      PositionsFailing[3] = pos+(2*Xcellamount);
    } else if (rotation == 3) {
      //Si la rotación es 3, se crean fichas una celda a la derecha (pos+1), dos celdas
      // a la derecha (pos+2) y una fila por debajo (pos+Xcellamount)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+1;
      PositionsFailing[2] = pos+2;
      PositionsFailing[3] = pos+Xcellamount;
    }
  } else if (form == 3) {
    //Z
    //Si el valor de form es 3, se crea el terominó Z
    //Ya que dos de las rotaciones de este tetrominó son iguales a las otras dos, se diferencia entre rotaciones pares e impares
    if (rotation%2 == 0) {
      //Si el modulo 2 de la rotación es 0 (rotación par), se crean fichas una celda a la derecha (pos+1), una fila por encima y una celda
      //a al izquierda (pos-Xcellamount-1) y una fila por encima (pos-Xcellamount)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos+1;
      PositionsFailing[2] = pos-Xcellamount-1;
      PositionsFailing[3] = pos-Xcellamount;
    } else if (rotation%2 == 1) {
      //Si el modulo 2 de la rotación es 1 (rotación impar), se crean fichas una fila por encima (pos-Xcellamount), una celda
      //a al izquierda (pos-1) y una fila por debajo y una celda a la izquierda (pos+Xcellamount-1)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-Xcellamount;
      PositionsFailing[2] = pos-1;
      PositionsFailing[3] = pos+Xcellamount-1;
    }
  } else if (form == 4) {
    //S
    //Si el valor de form es 4, se crea el terominó S
    //Ya que dos de las rotaciones de este tetrominó son iguales a las otras dos, se diferencia entre rotaciones pares e impares
    if (rotation%2 == 0) {
      //Si el modulo 2 de la rotación es 0 (rotación par), se crean fichas una celda a la izquierda (pos-1), una fila por encima (pos-Xcellamount)
      //y una fila por encima y una celda a la derecha (pos-Xcellamount+1)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-1;
      PositionsFailing[2] = pos-Xcellamount;
      PositionsFailing[3] = pos-Xcellamount+1;
    } else if (rotation%2 == 1) {
      //Si el modulo 2 de la rotación es 1 (rotación impar), se crean fichas una fila por encima y una celda a la izquierda (pos-Xcellamount -1), una celda
      //a al izquierda (pos-1) y una fila por debajo (pos+Xcellamount)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-Xcellamount-1;
      PositionsFailing[2] = pos-1;
      PositionsFailing[3] = pos+Xcellamount;
    }
  } else if (form == 5) {
    // I
    //Si el valor de form es 5, se crea el terominó I
    //Ya que dos de las rotaciones de este tetrominó son iguales a las otras dos, se diferencia entre rotaciones pares e impares
    if (rotation%2 == 0) {
      //Si el modulo 2 de la rotación es 0 (rotación par), se crean fichas una fila por encima (pos-Xcellamount), una fila por debajo (pos+Xcellamount)
      //y dos filas por encima (pos-(2*Xcellamount))
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-Xcellamount;
      PositionsFailing[2] = pos+Xcellamount;
      PositionsFailing[3] = pos-(2*Xcellamount);
    } else if (rotation%2 == 1) {
       //Si el modulo 2 de la rotación es 1 (rotación impar), se crean fichas dos celdas a la izquierda (pos-2), una celda a la izquierda (pos-1)
      //y una celda a la derecha (pos+1)
      PositionsFailing[0] = pos;
      PositionsFailing[1] = pos-2;
      PositionsFailing[2] = pos-1;
      PositionsFailing[3] = pos+1;
    }
  } else if (form == 6) {
    // SQ 
    //Si el valor de form es 5, se crea el terominó SQ, el cuadrado (SQuare)
    //Este tetrominó no tiene rotaciones ya que todas son iguales
    PositionsFailing[0] = pos;
    PositionsFailing[1] = pos+1;
    PositionsFailing[2] = pos-Xcellamount+1;  
    PositionsFailing[3] = pos-Xcellamount;
  }
  //Por cada indice en PositionsFailing, se verifica que esté dentro del tablero
  //En caso tal, se establece dicha posicion dentro del array Positions a 1
  for (int i = 0; i <= 3; i++) {
    if ((PositionsFailing[i]>= 0) && (PositionsFailing[i]<= Totalcellamount-1)) {
      Positions[PositionsFailing[i]] = 1;
    }
  }

  //Por cada posicion dentro del tablero, se verifica si tiene un 1 asignado ya sea en el
  // array Positions o en el array PositionsFailing
  //En caso tal, se crea un cuadrado en esa posicion.
  //La posicion en X la da i%Xcellamount, ya que la columna se puede entander como el modulo del indice con la cantidad de 
  //columnas. Se multiplica por Squaresidelenght, para poder tranformar el indice en las coordenadas dentro del tablero
  //que este representa
  //La posicion en Y la da i/Xcellamount, ya que la fila se puede entender como la división del indice por la cantidad de columnas
  //Ya que ambos valores son enteros, Processing devuelve un entero. Este valor se multiplica por Squaresidelenght, para poder 
  //tranformar el indice en las coordenadas dentro del tablero que este representa
  //El largo del cuadrado es Squaresidelenght, variable creada para este proposito.
  for (int i = 0; i <= Totalcellamount - 1; i++) {
    if ((Positions[i] == 1)|| (PositionsFix[i] == 1)) {
      square(i%Xcellamount *Squaresidelenght, (i/Xcellamount) * Squaresidelenght, Squaresidelenght);
    }
  }
  
  //Por cada fila en el tablero, se verifica si esta se halla llena
  //El valor i representa la fila en la que se está
  for (int i = 0; i <= Ycellamount-1; i++) {
    //Se crea una variable line para llevar la cuenta de cuantas celdas
    //de esta fila estan ocupadas
    int line = 0;
    //Por cada columna en esta fila
    for (int j = 0; j <= Xcellamount-1; j++) {
      //Si la celda se encuentra ocupada  (Si PositionsFix para ese indice es 1)
      //Se aumenta la variable line en 1
      if (PositionsFix[i*Xcellamount + j] == 1) {
        line++;
      }
    }
    //Si line es igual a la cantidad de columnas
    if (line ==Xcellamount) {
      //Se sabe que la fila está llena.
      //Se aumentan el puntaje en 100
      points += 100;
      //Por cada columna en esta fila 
      for (int j = 0; j <= Xcellamount-1; j++) {
        //Su indice en PositionsFix se establece a 0 ("Vaciando" la celda)
        PositionsFix[i*Xcellamount + j] = 0;
      }
      //Por cada fila desde la que estabamos comprobando hasta la segunda, en orden ascendente
      for (int k = i; k>=1; k--) {
        //Por cada columna en estas filas
        for (int m = 0; m <= Xcellamount-1; m++) {
          //Su valor en PositionsFix será reemplazado por la celda que está imediatamente encima.
          //Haciendo bajar todo el tablero.
          PositionsFix[k*Xcellamount + m] = PositionsFix[k*Xcellamount + m - Xcellamount];
        }
      }
      //El framerate se aumenta por los puntos dividios entre 300, lo que a efectos practicos aumenta
      //la velocidad del juego
      //Ya que esta division devuelve enteros, el framerate aumentara primero cuando los puntos lleguen a 300
      //A partir de ahí, cada vez que se complete una fila, el framerate aumentará
      //Si el jugador tiene un puntaje entre 300 y 599, el framerate aumentará en 1 por cada fila que limpie
      //Si el jugador tiene un puntaje entre 600 y 899, el framerate aumentará en 2 por cada fila que limpie
      //Y así sucesivamente...
      framerate += points/300;
    }
  }
  //Si la variable lose es verdad, se termina el loop draw
  //Y se llama la funcion lose (Definida más abajo).
  if (lose) {
    noLoop();
    lose();
  }
}

//Cada vez que se presione una tecla
void keyPressed() {
  //Se verifica si hay colisiones a izquierda (Lside) o derecha (Rside)
  //a través de las funciones CheckLside y CheckRside, respectivamente
  //Ambas definidas más abajo
  Lside = CheckLside();
  Rside = CheckRside();
  
  //Si la tecla presionada es la flecha izquierda, y no hay colision a izquierda, y el estado es 1 y el turno es menor que 1
  if ((keyCode == LEFT)&& (!Lside) && (state == 1) && (turn <1)) {
    //Se reduce pos en 1, moviendo la ficha una celda a la izquierda
    //y se establece state a 0, impidiendo que este movimiento ocurra más de una vez por frame.
    pos--;
    state = 0;
  }
  //En caso de que la tecla presionada sea la flecha derecha, y no hay colision a derecha, y el estado es 1 y el turno es menor que 1
  else if ((keyCode == RIGHT) && (!Rside) && (state == 1) && (turn <1)) {
    //Se aumenta pos en 1, moviendo la ficha una celda a la derecha
    //y se establece state a 0, impidiendo que este movimiento ocurra más de una vez por frame.
    pos++;
    state = 0;
  } 
  //En caso de que la tecla presionada sea la barra espaciadora, y el turno sea menor que 1
  else if ((keyCode == 32) && (turn <1)) {
    //Se aumenta la rotación en 1
    rotation++;
    //En caso que la rotación sea mayor que 4
    if (rotation >= 4) {
      //Se cambia la rotación por su valor modulo 4
      //Evitando así que la rotación tome valores iguales o mayores que 4
      rotation = rotation%4;
    }
  } 
  //En caso de que la tecla presionada sea la fecha hacia abajo
  else if (keyCode == DOWN) {
    //Se triplica el framerate y con esto se triplica a su vez la velocidad del juego
    frameRate(3*framerate);
  }
}

//Definimos la función CheckLside
//Usada para verificar si hay colisión a izquierda. Así, esta función devuelve solo true en caso
// de que haya colisión, o false en caso contrario.
Boolean CheckLside() {
  //Por cada indice en PositionsFailing
  for (int i = 0; i <= 3; i++) {
    //Si el modulo con la cantidad de columnas es 0 (la ficha está en el costado izquierdo)
    if (PositionsFailing[i]%Xcellamount ==0) {
      //Se devuelve true
      return true;
    }
    //Si el indice a la izquierda dentro del tablero, y el indice a la izquierda en PositionsFix es 1 (la celda a la izquierda está dentro del tablero y está ocupada por una ficha fija)
    // O si el indice una fila por debajo y una celda a la izquierda dentro del tablero, y este indice en PositionsFix es 1 (la celda una fila por debajo y una celda a la izquierda está dentro del tablero 
    //y está ocupada por una ficha fija)
    if (((PositionsFailing[i] - 1 >= 0) && (PositionsFailing[i] - 1 <= Totalcellamount-1)  && (PositionsFix[PositionsFailing[i] - 1] == 1)) || (((PositionsFailing[i] + Xcellamount - 1 >= 0) && (PositionsFailing[i] + Xcellamount -  1 <= Totalcellamount-1))  && (PositionsFix[PositionsFailing[i] + Xcellamount - 1] == 1))) {
      // Se devuelve true
      return true;
    }
  }
  //Si no se cumple ninguno de estos dos casos, se devuelve false
  return false;
}

//Definimos la función CheckRside
//Usada para verificar si hay colisión a derecha. Así, esta función devuelve solo true en caso
// de que haya colisión, o false en caso contrario.
Boolean CheckRside() {
  //Por cada indice en PositionsFailing
  for (int i = 0; i <= 3; i++) {
    //Si el modulo con la cantidad de columnas es 23 (la ficha está en el costado derecho)
    if (PositionsFailing[i]%Xcellamount == Xcellamount-1) {
      //Se devuelve true
      return true;
    }
    //Si el indice a la derecha está dentro del tablero, y el indice a la derecha en PositionsFix es 1 (la celda a la derecha está dentro del tablero y está ocupada por una ficha fija)
    // O si el indice una fila por debajo y una celda a la derecha dentro del tablero, y este indice en PositionsFix es 1 (la celda una fila por debajo y una celda a la derecha está dentro del tablero 
    //y está ocupada por una ficha fija)
    if (((PositionsFailing[i] + 1 >= 0) && (PositionsFailing[i] + 1 <= Totalcellamount-1)  && (PositionsFix[PositionsFailing[i] + 1] == 1)) || (((PositionsFailing[i] + Xcellamount + 1 >= 0) && (PositionsFailing[i] + Xcellamount +  1 <= Totalcellamount-1)  && (PositionsFix[PositionsFailing[i] + Xcellamount + 1] == 1)))) {
      //Se devuelve true
      return true;
    }
  }
  //Si no se cumple ninguno de estos dos casos, se devuelve false
  return false;
}

//Definimos la función Checklose
//Usada para verificar el jugador ha perdido. Así, esta función devuelve solo true en caso el jugador haya perdido, o false en caso contrario.
Boolean Checklose() {
  //Por cada columna en el tablero
  for (int i = 0; i <= Xcellamount-1; i++) {
    //Si esta la celda de esta columna en la segunda fila está ocupada
    if (PositionsFix[Xcellamount + i] == 1) {
      //Se devuelve true
      return true;
    }
  }
  //En caso contrario se devuelve false
  return false;
}

//Se define la función lose
//Que se ejecuta una vez el jugador ha perdido
//Esta funciónn no devuelve ningun valor
void lose() {
  //Se cambia la fuente del texto a l
  textFont(l);
  //Se cambia el color de trazo, texto y figuras a negro
  fill(0);
  //Se muestra el texto "Fin del juego" en negro en la pantalla
  text("Fin del juego", PScreenwidth/5, PScreenlenght/2);
}

//Se define la función DrawUI
//Que es la función encargada de dibujar la interfaz de usuario
//Esta función no devuelve ningun valor
void DrawUI() {
  //Se guarda el estado que vino antes de llamar esta función
  push();
  //Se establece el color de trazo, texto y figuras a gris.
  fill(68);
  //Se crea un rectangulo en la parte derecha de la pantalla
  //Xcellamount*Squaresidelenght devuelve la coordenada en X al limite derecho del tablero
  //TScreenwidth-Pscreenwidth nos da la longitud de la sección dedicada a la interfaz de usuario
  //Restando a la longitud total de la ventana la longitud del tablero
  //PScreenlength es el largo de la ventana
  rect(Xcellamount*Squaresidelenght, 0, TScreenwidth-PScreenwidth, PScreenlenght);
  //Se guarda este estado
  push();
  //Se cambia el color del trazo a blanco
  stroke(255);
  //Se cambia la forma en que se dan las coordenadas a la hora de crear un rectangulo
  //Haciendo que las coordenadas dadas sean el centro del rectangulo
  rectMode(CENTER);
  //Se crea un rectangulo de en el centro superior de la sección dedicada a la interfaz de usuario
  //Se ajusta con algunas constantes para lograr un efecto estetico deseado
  //Este cuadrado mostrará la proxima figura
  rect(Xcellamount*Squaresidelenght + (TScreenwidth-PScreenwidth)/2, 3*Squaresidelenght, 2.7*Squaresidelenght, 2.7*Squaresidelenght, 7);
  //Se llama al estado anterior
  pop();
  //Se define la fuente de texto a p
  textFont(p);
  //Se cambia el color de figuras, trazos y texto a negro
  fill(255);
  //Se crea texto para marcar el cuadrado creado anteriormente
  //Que mostrará la proxima figura
  text("Next", (Xcellamount+2.5)*Squaresidelenght, Squaresidelenght);
  //Se crea texto para mostrar el puntaje
  text("Score " + points, (Xcellamount+2)*Squaresidelenght, 7*Squaresidelenght);
  //Se crean las instrucciones para rotar, mover horizontalmente y acelerar
  text("Rotate with \n spacebar", (Xcellamount+1.5)*Squaresidelenght, 9*Squaresidelenght);
  text("\n Move with left\nand right arrows. \n", (Xcellamount+1.25)*Squaresidelenght, 11*Squaresidelenght);
  text(" \n Accelerate \n with down", (Xcellamount+1.25)*Squaresidelenght, 14*Squaresidelenght);
  //Se cambia el color de trazos, figuras y textos a azul
  fill(0, 100, 255);
  //Usando un sistema similar al que se usa para crear las figuras en el tablero
  //Se crean versiones más pequeñas dentro del cuadro destinado a mostrar la siguiente figura
  //Creando pequeños cuadrados dentro de la sección de interfaz de usuario
  //Estas se ajustan con varias constantes para lograr el efecto estetico deseado
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
  //Se restaura el estado que existia antes de llamar esta función
  pop();
}
