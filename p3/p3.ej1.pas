{Escribir un programa que:
a. Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro y: 
    i. Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor. 
    ii. Informe los datos del socio con el numero de socio mas chico. Debe invocar a un modulo recursivo que retorne dicho socio. 
    iii. Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor. 
    iv. Aumente en 1 la edad de todos los socios.
    v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
       retorne verdadero o falso.
    vi. Lea un nombre e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el nombre lei­do y 
        retorne verdadero o falso.
    vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.
    viii. Informe el promedio de edad de los socios. Debe invocar a un modulo recursivo que retorne dicho promedio.
    ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el arbol cuyo numero de socio se encuentra entre 
        los dos valores ingresados. Debe invocar a un modulo recursivo que reciba los dos valores leÃ­dos y retorne dicha cantidad. 
    x. Informe los numeros de socio en orden creciente. 
    xi. Informe los numeros de socio pares en orden decreciente.
}

Program p3.ej1;

type rangoEdad = 12..100;
     cadena15 = string [15];
     socio = record
               numero: integer;
               nombre: cadena15;
               edad: rangoEdad;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure GenerarArbol (var a: arbol);
{ Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. }

  Procedure LeerSocio (var s: socio);
  begin
    write ('Ingrese numero del socio: ');
    readln (s.numero);
    If (s.numero <> 0)
    then begin
           write ('Ingrese nombre del socio: ');
           readln (s.nombre);
           write ('Ingrese edad del socio: ');
           readln (s.edad);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) then begin
        new(a);
        a^.dato:= elem; 
        a^.HI:= nil; 
        a^.HD:= nil;
    end
    else if (elem.numero <= a^.dato.numero) then //Los repetidos se cargan a la izquierda.
              InsertarElemento(a^.HI, elem)
         else 
              InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
Begin
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 a:= nil;
 LeerSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   writeln;
   LeerSocio (unSocio);
  end;
 writeln;
 writeln ('-----------------------------------------------');
end;

procedure InformarNumeroSocioMasGrande (a: arbol);
{Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor.}

  function NumeroMasGrande (a: arbol): integer;
  begin
    if (a = nil) then 
      NumeroMasGrande:= -1
    else if (a^.HD = nil) then 
            NumeroMasGrande:= a^.dato.numero
         else 
            NumeroMasGrande:= NumeroMasGrande (a^.HD);
  end;
   
var max: integer;
begin
  writeln ('----- Informar Numero Socio Mas Grande ----->');
  max:= NumeroMasGrande (a);
  if (max = -1) then 
      writeln ('Arbol sin elementos')
  else begin
         writeln ('Numero de socio mas grande: ', max);
       end;
  writeln ('-----------------------------------------------');
end;

procedure InformarDatosSocioNumeroMasChico (a: arbol);
{ Informe los datos del socio con el numero de socio mas chico. Debe invocar a un modulo recursivo que retorne dicho socio. }
  
  function SocioMasChico (a: arbol): arbol;
  begin
    if ((a = nil) or (a^.HI = nil))then 
        SocioMasChico:= a
    else 
        SocioMasChico:= SocioMasChico (a^.HI);
  end;
   
var minSocio: arbol;
begin
  writeln ('----- Informar Datos Socio Numero Mas Chico ----->');
  minSocio:= SocioMasChico (a);
  if (minSocio = nil) then 
      writeln ('Arbol sin elementos')
  else begin
         writeln ('Socio con numero mas chico: ', minSocio^.dato.numero, ' Nombre: ', minSocio^.dato.nombre, ' Edad: ', minSocio^.dato.edad); 
       end;
  writeln ('-----------------------------------------------');
end;

procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then begin
		  maxValor := nuevoValor;
		  maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,
                      maxNum,
                      a^.dato.edad,
                      a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;
var maxEdad, maxNum: integer;
begin
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1)  then 
      writeln ('Arbol sin elementos')
  else begin
         writeln ('Numero de socio con mas edad: ', maxNum);
       end;
  writeln ('-----------------------------------------------');
end;

procedure AumentarEdad (a: arbol);
begin
 if (a <> nil)
 then begin
        a^.dato.edad:= a^.dato.edad + 1;
        AumentarEdad (a^.HI);
        AumentarEdad (a^.HD);
      end;
end;

procedure InformarExistenciaNumeroSocio (a: arbol);
{ Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
       retorne verdadero o falso. }
       
  function Buscar (a: arbol; num: integer): boolean;
  begin
    if (a = nil) 
    then Buscar:= false
    else If (a^.dato.numero = num) 
         then Buscar:= true
         else if (num < a^.dato.numero)then 
                  Buscar:= Buscar (a^.HI, num)
              else 
                  Buscar:= Buscar (a^.HD, num)
  end;
  
var numABuscar: integer;
begin
  writeln ('----- Informar Existencia Numero Socio ----->');
  write ('Ingrese numero de socio a buscar: ');
  Readln (numABuscar);
  writeln;
  if (Buscar (a, numABuscar)) then 
      writeln ('El numero ', numABuscar, ' existe')
  else 
      writeln ('El numero ', numABuscar, ' no existe');
  writeln ('-----------------------------------------------');
end;

//6--------------------------------------------
procedure InformarExistenciaNombreSocio (a: arbol);
  function Buscar (a: arbol; nom: String): boolean;
  begin
    if (a = nil) then 
        Buscar:= false
    else If (a^.dato.nombre = nom) then 
              Buscar:= true
         else begin
              Buscar:= Buscar (a^.HI, nom);
              Buscar:= Buscar (a^.HD, nom);
         end;  
  end;
  
var nomABuscar: String;
begin
  writeln ('----- Informar Existencia Numero Socio ----->');
  write ('Ingrese nombre de socio a buscar: ');
  Readln (nomABuscar);
  if (Buscar (a, nomABuscar)) then 
      writeln ('El nombre ', nomABuscar, ' existe')
  else 
      writeln ('El nombre ', nomABuscar, ' no existe');
  writeln ('-----------------------------------------------');
end;

//7----------------------------------
procedure InformarCantidadSocios (a: arbol; var cant:Integer);
begin
 if (a <> nil)
 then begin
        cant:=cant + 1;
        InformarCantidadSocios (a^.HI,cant);
        InformarCantidadSocios (a^.HD,cant);
      end;
end;
//8-------------------------------------
procedure InformarPromedioDeEdad (a: arbol; var pro:Integer{; var cant:Integer});
begin
 if (a <> nil)
 then begin
        pro:=pro + a^.dato.edad;
        //cant:=cant + 1;
        InformarPromedioDeEdad (a^.HI,pro);
        InformarPromedioDeEdad (a^.HD,pro);
      end;
end;
//9-------------------------------------------
procedure InformarCantidadSociosEnRango (a:arbol; inf:integer; sup:Integer; var cant:Integer);
begin
 if (a <> nil)then begin
     if(inf<=a^.dato.numero)then
         if(a^.dato.numero<=sup)then begin  
              cant:=cant + 1;
              InformarCantidadSociosEnRango(a^.HI,inf,sup,cant);
              InformarCantidadSociosEnRango(a^.HD,inf,sup,cant);
         end
         else InformarCantidadSociosEnRango(a^.HI,inf,sup,cant)
     else InformarCantidadSociosEnRango(a^.HD,inf,sup,cant);
  end;
end;
//10-------------------------------------------ç
procedure InformarNumerosSociosOrdenCreciente(a:arbol);
begin
  if(a<>Nil)then begin
      InformarNumerosSociosOrdenCreciente (a^.HI);
      Write('numSocio: ',a^.dato.numero,', ');
      InformarNumerosSociosOrdenCreciente (a^.HD);
  end;
end;
//11----------------------------------------------

procedure InformarNumerosSociosOrdenDeCreciente (a:arbol);
begin
  if(a<>Nil)then begin
      InformarNumerosSociosOrdenDeCreciente (a^.HI);
      InformarNumerosSociosOrdenDeCreciente (a^.HD);
      if(a^.dato.numero mod 2)=0 then
          Write('numSocio: ',a^.dato.numero,', ');
  end;
end;

var a: arbol; 
    cant:Integer;
    prom:Integer;
    num1:Integer;
    num2:Integer;
Begin
  GenerarArbol (a);
  InformarNumeroSocioMasGrande (a);
  InformarDatosSocioNumeroMasChico (a);
  InformarNumeroSocioConMasEdad (a);
  AumentarEdad (a);
  writeln('se aumeto la edad (+1) de los socios');
  InformarExistenciaNumeroSocio (a);
  //-------desarrollo
  //6
  InformarExistenciaNombreSocio (a);
  //7
  cant:=0;
  InformarCantidadSocios (a,cant);
  WriteLn('la cant de socios totales: ',cant);
  writeln ('-----------------------------------------------');
  //8
  prom:=0; //cant:=0;
  InformarPromedioDeEdad (a,prom{,cant});
  WriteLn('edad prom de todos los socios: ',prom/cant:2);
  writeln ('-----------------------------------------------');
  //9
  writeln ('-ingrese un num de socio inf y superior para buscar los socios q cumplen con el rango.-');
  write('num de socio inf'); read(num1);
  write('num de socio sup'); read(num2);
  cant:=0;
  InformarCantidadSociosEnRango (a,num1,num2,cant);
  WriteLn('cant de socios que cumplen: ',cant);
  writeln ('-----------------------------------------------');
  //10
  WriteLn('numero de socios en orden creciente: ');
  InformarNumerosSociosOrdenCreciente (a);
  writeln ();
  writeln ('-----------------------------------------------');
  //11
  WriteLn('numero de socios pares en orden decreciente: ');
  InformarNumerosSociosOrdenDeCreciente (a);
     
End.
