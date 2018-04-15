%Funcion de Regresion Lineal
%T = 6.35 seg con los valores dados


%Valores iniciales de la fórmula
a = 1;
b = 1;
w = (2*pi)/6.35;


%Generamos la onda de oscilación
for i = 1 : 100
	Z(i,1) = a*cos(w*(i/10)) + b*sin(w*(i/10));
end


%Generamos los valores de la matriz que usaremos en
%la regresion lineal, separamos los valores donde
%estan a y b
for i = 1 : 100
	z(i,1) = a*cos(w*(i/10));
	z(i,2) = b*sin(w*(i/10));
end


%Alteramos los resultados originales con numeros
%al azar entre 0 y 1 para no distorsionar demasiado
Z2 = Z + abs(randn);


%Tomamos muestras para el cálculo
Y = resample(Z2, 1, 5);
y = resample(z, 1, 5);

%Generamos la formula para la regresion lineal
%([Z]T [Z])-1[Z]T [Y]
%Se hace por partes para verificar el tamaño de
%las matrices
temp = y' * y;
temp2 = inv(temp);
temp3 = y' * Y;
A = temp2 * temp3;


%Con A obtenido, podemos actualizar los
%valores de a y b
a1 = A(1);
b1 = A(2);


%Con los nuevos valores re-hacemos la oscilación
%para comparar resultados
for i = 1 : 100
	Z1(i,1) = a1*cos(w*(i/10)) + b1*sin(w*(i/10));
end


%Graficamos simultaneamente las oscilaciones,
%tanto la original como la recuperada
subplot(2,1,1); plot(Z,'r o'); title('Original');

subplot(2,1,2); plot(Z1,'b--x'); title('Recuperada');