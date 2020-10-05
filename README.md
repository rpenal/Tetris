# Tetris
## Descripción basica del juego
El juego creado aquí asemeja un tetris muy basico.
El objetivo era poder desarrolllar un juego simple sin usar objetos ni clases
Aunque se usaron funciones.

El juego se centra en figuras que van callendo por un tablero, hasta topar con el fondo o con
alguna otra figura que hubiese caido antes.
El tablero se representa con un array llamado Positions, que son 0 si la celda que representa 
está vacia, o 1 en caso contrario.
Las fichas sobre las que el jugador tiene control son representadas mediante cuadrados 
y las posiciones de estos cuadrados almacenados en un array llamado PositionsFailing.
Las fichas sobre las que el jugador perdió control, las que estan "fijas", se almacenan en un 
array llamado PositionsFix

Cada vez que se consigue llenar una fila, esta se vacía y las fichas que estaban encima se desplazan
una fila hacia abajo. Tambien se aumenta el puntaje en 100.

Aprovechando como trabaja la función draw de Processing, se utiliza el framerate para dictar la velocidad del juego, ya que el loop draw se llama una vez por frame. Este framerate comienza con un valor de 5, pero aumenta en 1 por cada vez que el jugador completa una fila por cada 300 puntos que tenga.
Así, si el jugador tiene 100 puntos y completa una linea, el framerate no aumenta (ya que la puntuación seria 200). Si tiene 200 puntos y completa una linea, el framerate aumenta en 1 (ya que tendria 300 puntos). Si el jugador tiene 500 puntos, el framerate aumenta en 2 (Ya que tendria 600 puntos) cuando completa esa linea, y así sucesivamente. Por esto, es mejor completar varias lineas de golpe, ya que el aumento de velocidad se dará mas lentamente. En caso contrario, este aumento se da de modo casi exponencial.

Si alguna de las celdas en la segunda fila se ocupa, la partida se dá por terminada. 

---

## Controles
El jugador puede mover las fichas horizontalmente utilizando las flechas izquierda y derecha. Este movimiento se limita a una vez por frame para evitar que la ficha de saltos durante las fases tempranas del juego. 

Tambien puede rotar la ficha usando la barra espaciadora. Algunas fichas tienen tres rotaciones, otras solo una, y el cuadrado ninguna.

Igualmente, se puede acelerar el juego a 3 veces la velocidad actual oprimiendo la flecha hacia abajo.

---

## Errores conocidos.

*Si la figura se encuentra en alguno de los costados y se la intenta rotar, alguno de los extremos aparecerá al otro lado de la pantalla, y una fila por encima. Esto es así debido a la forma en que se calculan las posiciones y las rotaciones. Ademas, debido a como se verifica la colision a derecha e izquierda, la ficha no podrá moverse horizontalmente si no se la rota primero. para devolverla a su estado original.

*Cuando la partida termina, la ultima ficha en salir puede ser movida horizontalmente por el jugador, aunque no cae.