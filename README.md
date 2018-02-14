
# Ejercicio de Diseño - Microprocesador

[![Build Status](https://travis-ci.org/uqbar-project/eg-microprocesador-xtend.svg?branch=simple)](https://travis-ci.org/uqbar-project/eg-microprocesador-xtend) [![Coverage Status](https://coveralls.io/repos/github/uqbar-project/eg-microprocesador-xtend/badge.svg?branch=simple&service=github)](https://coveralls.io/github/uqbar-project/eg-microprocesador-xtend?branch=simple&service=github)

![image](images/microprocessor.png) 

## Dominio
* [Microprocesador, primera parte](https://docs.google.com/document/d/1-esJOhKb_yAABls-XdRrEYHzCv4yn-qqFtCu3xpgCg0/edit?usp=sharing)
* [Microprocesador, segunda parte](https://docs.google.com/document/d/1ILsxAvgZwPD4sTtB-rBq7wfJZf22e9G6qpllglAbT2g/edit?usp=sharing), con ejemplos creacionales

## Conceptos a ver

* Muestra cómo implementar una serie de patrones Command que simulan instrucciones para un Microprocesador. 
 * Se desarrolla también un Composite para modelar instrucciones múltiples. 
* En la parte creacional, hay que traducir un código de instrucción a un comando, y diferenciarlo de un dato, para lo cual
 * usamos un mapa para traducir de enteros a objetos comando
 * un iterator de un programa que permite diferenciar códigos de instrucción vs. parámetros de las operaciones
 * y de yapa, un builder para construir en forma más simple un programa

## Branches de git

* [__simple__](https://github.com/uqbar-project/eg-microprocesador-xtend/tree/simple): resuelve la primera parte del ejercicio (cada instrucción se implementa como un command pattern que permite ejecutarse y deshacerse)
* [__creacionales__](https://github.com/uqbar-project/eg-microprocesador-xtend/tree/creacionales): resuelve la segunda parte del ejercicio (builder de un programa, y un iterador de instrucciones que utiliza un mapa para transformar un entero en un command)
* [__factories__](https://github.com/uqbar-project/eg-microprocesador-xtend/tree/factories): resuelve la parte creacionales con un mapa de factories de instrucciones que tiene una jerarquía separada de las instrucciones, para evitar acoplar la instrucción con el iterador del programa.
* [__bloques__](https://github.com/uqbar-project/eg-microprocesador-xtend/tree/bloques): cada instrucción se modela como un bloque de código o closure en lugar de subclasificar el command. Pese a su flexibilidad, no se permite heredar código entre los closures y tampoco es fácil entender qué operación hace cada bloque.

