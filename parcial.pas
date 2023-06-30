program parcial;
type
  int = integer;
  str = string[30];
  cant_premios=1..5;
  cant_categoria = array [cant_premios] of int;
  empleado = record
    dni:int;
    nombre:str;
    apellido:str;
    categoria:char;
    sueldo_b:real;
    premios:cant_premios;
    antiguedad:int;
  end;

  listaEmpleados = ^nodo;
  nodo = record
    empleados:empleado;
    siguiente:listaEmpleados;
  end;
  empleadoLiqui = record
    dni:int;
    sueldo_m:real;
  end;

  listaLiquidaciones=^nodo_b;
  nodo_b = record
    e_liqui:empleadoLiqui;
    siguiente:listaLiquidaciones;
  end;



procedure cargarEmpleado(var e:empleado);
begin


  read(e.dni);
  read(e.nombre);
  read(e.apellido);
  read(e.categoria);
  read(e.sueldo_b);
  read(e.premios);
  read(e.antiguedad);

end;

procedure cargarOrdenado(var l:listaEmpleados);
var
  actual, anterior, nuevo:listaEmpleados;
  e:empleado;
begin
  read(e.dni);
  while(e.dni <> -1) do begin
    cargarEmpleado(e);
    new(nuevo);
    nuevo^.empleados:=e;
    nuevo^.siguiente:=nil;
    if (l=nil) then begin
      l:=nuevo;
    end
    else begin
      actual:=l;
      anterior:=l;
      while (actual <> nil) and (actual^.empleados.dni < nuevo^.empleados.dni) do begin
        anterior:=actual;
        actual:=actual^.siguiente;
      end;

    end;
    if (actual=l) then begin
      nuevo^.siguiente:=l;
      l:=nuevo;
    end
    else if (actual <> nil) then begin
      anterior^.siguiente:=nuevo;
      nuevo^.siguiente:=actual;
    end
    else begin
      anterior^.siguiente:=nuevo;
      nuevo^.siguiente:=nil;
    end;
  end;
end;


procedure crearListaLiqui(var l:listaLiquidaciones; li:listaEmpleados; v:cant_categoria);
var
  nuevo:listaLiquidaciones;
  i:int;
begin
  while (li <> nil) do begin
  new(nuevo);
  nuevo^.e_liqui.dni:=li^.empleados.dni;
  if (li^.empleados.categoria >= 'A') AND (li^.empleados.categoria <= 'C') then begin
      nuevo^.e_liqui.sueldo_m:=li^.empleados.sueldo_b + li^.empleados.premios;
  end
     else begin
        nuevo^.e_liqui.sueldo_m:=li^.empleados.sueldo_b + li^.empleados.premios + (li^.empleados.antiguedad * 1000) ;
     end;
    case (li^.empleados.categoria) of
       'A':v[0]:=v[0]+1;
       'B':v[1]:=v[1]+1;
       'C':v[2]:=v[2]+1;
       'D':v[3]:=v[3]+1;
       'E':v[4]:=v[4]+1;
    end;
    li:=li^.siguiente;
  end;
  for i:=0 to 4 do begin
     writeln(v[i]);
end;
end;
procedure iniciarVector(var v:cant_categoria);
var
  i:int;
begin
     for i:=0 to 4 do begin
     v[i]:=0;
  end;
     end;

var
  l:listaEmpleados;
  li:listaLiquidaciones;
  v:cant_categoria;
begin
  l:=nil;
  li:=nil;
  iniciarVector(v);
  cargarOrdenado(l);
  crearListaLiqui(li,l,v);
  end.
