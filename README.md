# Метрические алгоритмы классификации
Метрические алгоритмы классификации с обучающей выборкой ![alt text](https://github.com/elivam/ML0/blob/master/pictures/Xlformula.PNG) относят
u к тому классу , для которого суммарный вес ближайших обучающих объектов ![alt text](https://github.com/elivam/ML0/blob/master/pictures/WI(u,x)Text.PNG) наибольший
##  Алгоритм k-ближайших соседей                                  
### Метод 1: Метод ближайшего соседа (1nn)
Алгоритм ближайшего соседа (nearest neighbor, NN) является самым простым
алгоритмом классификации. Он относит классифицируемый объект u к тому
классу, которому принадлежит ближайший обучающий объект:

![alt text](https://github.com/elivam/ML0/blob/master/pictures/1nnFormula.PNG), 

где а - это алгоритм, ![alt text](https://github.com/elivam/ML0/blob/master/pictures/Xlformula.PNG) - обучающая выборка, u - классифицируемый объект, 
![alt text](https://github.com/elivam/ML0/blob/master/pictures/Yformula.PNG) - класс, которому алгоритм дает предпочтение при классификации объекта u

Обучение NN сводится к запоминанию выборки.

 **вход :** 
 
 Xl: matrix 
 
     обучающая выборка, на последнем месте метка класса;
 u:  vector
 
     классифицируемый объект;
	 
 q : расстояние
 
     определить функцию расстояния;
 
 **выход:** имя класса
 
 **Сам алгоритм:**
 1. находим расстояние от точки u до точек из выборки, образуя новый вектор
 2. находим минимальное расстояние в векторе и запоминаем точку А(это именно та точка расстояние до которой минимально)
 3. узнаем какому классу принадлежит точка А и относим u к тому классу какому принадлежит точка А
    
 На языке R алгоритм реализован следующим образом :
 [1NN.R](https://github.com/elivam/ML0/blob/master/1NN/1NN.R)
 
 Сслыка на shiny
 ### Метод k-ближайших соседей (knn)
 Чтобы сгладить влияние шумовых выбросов, будем классифицировать объекты путём голосования
по k ближайшим соседям.


![alt text](https://github.com/elivam/ML0/blob/master/pictures/knnFormula.PNG)
 
 **вход :** 
 
 Xl: matrix 
 
     обучающая выборка, на последнем месте метка класса
	 
 u:  vector
 
     классифицируемый объект
	 
 q : расстояниe
 
     определить функцию расстояния
	 
 k:  
 
	кол-во соседей  
	 
 **выход** имя класса
 
 Сам Алгоритм
 1. находим расстояния от точки u до k-ближайших-соседей образуя новый массив, 
   где будет записан класс этой k-точки-соседа и расстояние 
 2. сортируем этот массив 
 3. считаем какие классы соседей встречаются чаще всего и даем предпочтение одному классу
     
 На языке R алгоритм реализован следующим образом :
 [kNN.R](https://github.com/elivam/ML0/blob/master/task1/knnShiny.R)
 
ССлыка на Shiny
 
  ###  Найти оптимальное кол-во соседей методом LOO (критерий скользящего контроля)
  При k = 1 этот алгоритм совпадает с предыдущим, следовательно, неустойчив
к шуму. При k = l, наоборот, он чрезмерно устойчив и вырождается в константу.
Таким образом, крайние значения k нежелательны. На практике оптимальное значение параметра k 
определяют по критерию скользящего контроля с исключением
объектов по одному (leave-one-out, LOO). Для каждого объекта 
![alt text](https://github.com/elivam/ML0/blob/master/pictures/Xitext.PNG)  проверяется,
правильно ли он классифицируется по своим k ближайшим соседям
  
  ![alt text](https://github.com/elivam/ML0/blob/master/pictures/LOOFormula.PNG) 
  
 **вход :** 
 
 Xl: matrix 
 
     обучающая выборка, на последнем месте метка класса
	 
 k:  кол-во соседей
 
     определить оптимальное кол-во требуемых соседей , используя LOO 
	 
 **выход** 
 k, при котором допускается наименьшая ошибка   
 На языке R алгоритм реализован следующим образом :
 [kNN and LOO.R](https://github.com/elivam/ML0/blob/master/task1/kNNLOO.R)

 Далее построим карту классификации для метода kNN:
 [classMapkNN.R](https://github.com/elivam/ML0/blob/master/task1/classMapkNN.R)
  ![alt text](https://github.com/elivam/ML0/blob/master/pictures/classMapkNN.PNG)
  ###  Алгоритм k-взвешенных ближайших соседей
  
   Недостаток kNN в том, что максимальная сумма голосов может достигаться на нескольких классах одновременно.
В задачах с двумя классами этого можно избежать, если брать только нечётные значения k. Более общая тактика, которая годится и для случая многих классов — ввести
строго убывающую последовательность вещественных весов  ![alt text](https://github.com/elivam/ML0/blob/master/pictures/Witext.PNG), задающих вклад i-го соседа в классификацию

 На языке R алгоритм реализован следующим образом :
 [kwNN.R](https://github.com/elivam/ML0/blob/master/task1/kwn.R)
 
  Ccылка на shiny
 
 Далее построим карту классификации для метода kwNN:
	![alt text](https://github.com/elivam/ML0/blob/master/pictures/classMapkwNN.PNG)
 На языке R алгоритм реализован следующим образом :
 [classMapkwNN.R](https://github.com/elivam/ML0/blob/master/task1/classMapkwNN.R)
	
 
 ###  Найти оптимальное q методом LOO (критерий скользящего контроля)

	 ![alt text](https://github.com/elivam/ML0/blob/master/pictures/kwnLoo.PNG)
  Недостаток kNN в том, что максимальная сумма голосов может достигаться на нескольких классах одновременно. И тогда не понятно какой 
 класс выбирать. Приведем пример.
 ![alt text](https://github.com/elivam/ML0/blob/master/pictures/exampleKNN.PNG)
 ![alt text](https://github.com/elivam/ML0/blob/master/pictures/exampleKwnn.PNG)
 
 Таким образом более
 
 ##  Метод парзеновского окна
 