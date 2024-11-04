unit OPR_Lazarus;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, TAGraph, TASeries, TALegend, TACustomSeries;

type
    TFuncX = function(x:real):real;
  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    Chart1LineSeries3: TLineSeries;
    Chart1LineSeries4: TLineSeries;
    Chart1LineSeries5: TLineSeries;
    Chart1LineSeries6: TLineSeries;
    Chart1LineSeries7: TLineSeries;
    Chart1LineSeries8: TLineSeries;
    Chart1LineSeries9: TLineSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  mass: array[0..10] of real;
  func_t: TFuncX;
  res, x0 : real;

implementation

{$R *.lfm}

{ TForm1 }
function func_1(x:real):real;
         begin
              //func_1 := x*x;
              func_1 := 4 * x + exp(x); // a = -1, b = 1
         end;

function func_2(x:real):real;
         begin
	      func_2 := cos(x * x) - 10 * x; // a = 0, b = 1
         end;

function func_3(x:real):real;
         begin
              func_3 := 2 * sin(x) - x; // a = -5, b = 0
         end;

function approximation(a, b:real; func:TFuncX):real;
  var
    c, x_0:real;
  begin
    c := a - ((b - a) * func(a)) / (func(b) - func(a));

	  if ((func(a) * func(c)) < 0) then
		  x_0 := a
	  else if ((func(a) * func(c)) > 0) then
		  x_0 := b
	  else
		  x_0 := c;

  approximation := x_0;
  end;

procedure secant(a, b, eps:real; var res:real; var counter:integer; func:TFuncX);
  var
    x_0, x_1, temp:real;
  begin
    counter := 0;
    x_0 := approximation(a, b, func);

    if (x_0 = a) then
      begin
        x_1 := x_0 + eps;
        repeat
          begin
                              temp := x_1;
			      x_1 := x_1 - ((x_1 - x_0) * func(x_1)) / (func(x_1) - func(x_0));
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
			      x_1 := x_1 - ((x_1 - x_0) * func(x_1)) / (func(x_1) - func(x_0));
			      x_0 := temp;
                              mass[counter] := x_1;
			      inc(counter);
			    end;
			  until (abs(x_1 - x_0) < eps);
			end;

          res := x_1;
  end;

procedure TForm1.Button1Click(Sender: TObject);
var
   a, b, eps, i, j, c:real;
   counter:integer;
begin
     if(RadioButton1.Checked) then
            func_t := @func_1
     else if(RadioButton2.Checked) then
            func_t := @func_2
     else if(RadioButton3.Checked) then
            func_t := @func_3;

     Chart1LineSeries1.SeriesColor := clRed;
     Chart1LineSeries1.LinePen.Width := 3;

     Chart1LineSeries2.SeriesColor := clBlack;
     Chart1LineSeries2.LinePen.Width := 2;

     Chart1LineSeries3.SeriesColor := clBlue;
     Chart1LineSeries3.LinePen.Width := 7;

     Chart1LineSeries4.SeriesColor := clLime;
     Chart1LineSeries4.LinePen.Width := 7;

     Chart1LineSeries5.SeriesColor := clBlue;
     Chart1LineSeries5.LinePen.Width := 7;

     Chart1LineSeries6.SeriesColor := clBlue;
     Chart1LineSeries6.LinePen.Width := 7;

     Chart1LineSeries7.SeriesColor := clBlack;
     Chart1LineSeries7.LinePen.Width := 3;

     Chart1LineSeries8.SeriesColor := clBlack;
     Chart1LineSeries8.LinePen.Width := 2;

     Chart1LineSeries9.SeriesColor := clBlack;
     Chart1LineSeries9.LinePen.Width := 2;

     a := StrToFloat(Edit1.Text);
     b := StrToFloat(Edit2.Text);
     eps := StrToFloat(Edit3.Text);
     res := 0;
     counter := 0;

     secant(a, b, eps, res, counter, func_t);
     x0 := approximation(a, b, func_t);

     Edit4.Text:=FloatToStrF(res, ffFixed, 8, 4);
     Edit5.Text:=IntToStr(counter);
     Edit6.Text:=FloatToStrF(func_t(res), ffFixed, 8, 4);

     Chart1LineSeries1.Clear;
     Chart1LineSeries2.Clear;
     Chart1LineSeries3.Clear;
     Chart1LineSeries4.Clear;
     Chart1LineSeries5.Clear;
     Chart1LineSeries6.Clear;
     Chart1LineSeries7.Clear;
     Chart1LineSeries8.Clear;
     Chart1LineSeries9.Clear;

     i := a;
     while (i <= b) do
           begin
             i := i + 0.001;
             Chart1LineSeries1.AddXY(i, func_t(i));
             Chart1LineSeries2.AddXY(i, 0);
           end;

     j := -0.1;
     c := 0;
     while (j <= c) do
           begin
                   j := j + 0.1;
                   Chart1LineSeries3.AddXY(x0, j);
                   Chart1LineSeries4.AddXY(res, j);
                   Chart1LineSeries5.AddXY(mass[0], j);
                   Chart1LineSeries6.AddXY(mass[1], j);
           end;
     //секущая
     Chart1LineSeries7.AddXY(mass[1], func_t(mass[1]));
     Chart1LineSeries7.AddXY(x0, func_t(x0));
     //точка x0
     Chart1LineSeries8.AddXY(x0, 0);
     Chart1LineSeries8.AddXY(x0, func_t(x0));
     //точка x1
     Chart1LineSeries9.AddXY(mass[0], 0);
     Chart1LineSeries9.AddXY(mass[0], func_t(mass[0]));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;
end.

