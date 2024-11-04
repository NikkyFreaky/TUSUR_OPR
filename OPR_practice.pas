var
  mass: array[0..20] of real;

function func_1(x:real):real;
  begin
	  func_1 := 4 * x + exp(x);
  end;
  
function approximation(a, b:real):real;
  var
    c, x_0:real;
  begin
    c := a - ((b - a) * func_1(a)) / (func_1(b) - func_1(a));
    
	  if ((func_1(a) * func_1(c)) < 0) then
		  x_0 := a
	  else if ((func_1(a) * func_1(c)) > 0) then
		  x_0 := b
	  else
		  x_0 := c;

  approximation := x_0;
  end;
  
procedure secant(a, b, eps:real);
  var
    counter:integer;
    x_0, x_1, temp:real;
  begin
    x_0 := approximation(a, b);
    
    if (x_0 = a) then
      begin
        x_1 := x_0 + eps;
        repeat
          begin
            temp := x_1;
			      x_1 := x_1 - ((x_1 - x_0) * func_1(x_1)) / (func_1(x_1) - func_1(x_0));
			      x_0 := temp;
			      mass[counter] := x_1;
			      inc(counter);
			    end;
			  until (abs(x_1 - x_0) < eps);
			end
		else if (x_0 = b) then
		  begin
		    x_1 := x_0 - eps;
		    repeat
		      begin
		        temp := x_1;
			      x_1 := x_1 - ((x_1 - x_0) * func_1(x_1)) / (func_1(x_1) - func_1(x_0));
			      x_0 := temp;
			      mass[counter] := x_1;
			      inc(counter);
			    end;
			  until (abs(x_1 - x_0) < eps);
			end;
			
	  writeln('Кол-во итераций = ', counter);
	  writeln('x = ', x_1);
	  writeln('F(x) = ', func_1(x_1));
  end;
 
var
  a, b, eps:real;
  i:integer;
begin
  a := -1;
  b := 1;
  eps := 0.0001;
  
  secant(a, b, eps);
  for i:=0 to 20 do
    writeln('mass = ', mass[i]);
end.