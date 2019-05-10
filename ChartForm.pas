unit ChartForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  Vcl.StdCtrls;

const
  dashCount = 7;

type
  TForm2 = class(TForm)
    GridPanel1: TGridPanel;
    Label1: TLabel;
    SizeGraphImage: TImage;
    TimeGraphImage: TImage;
    SizeLabel: TLabel;
    TimeLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  chForm: TForm2;

implementation

{$R *.dfm}

procedure drawDashes(I:TImage;offsetX,offsetY:Integer);
var
  xL,yL,s: Integer;
begin
  xL:=(I.Width - 2*offsetX) div (dashCount+1);
  yL:=(I.Height - 2*offsetY) div (dashCount+1);

  with I do
  begin
    Canvas.MoveTo(offsetX+5,offsetY);
    for s := 1 to dashCount do
    begin
      Canvas.MoveTo(Canvas.PenPos.X-10,Canvas.PenPos.Y+yL);
      Canvas.LineTo(Canvas.PenPos.X+10,Canvas.PenPos.Y);
    end;

//    Canvas.MoveTo(Width - offsetX,Height - offsetY + 5);
//    for s := 1 to dashCount do
//    begin
//      Canvas.MoveTo(Canvas.PenPos.X-xL,Canvas.PenPos.Y-10);
//      Canvas.LineTo(Canvas.PenPos.X,Canvas.PenPos.Y+10);
//    end;

  end;
end;

procedure drawAxises(I:TImage);
var
  p:Array of TPoint;
  offsetX, offsetY:Integer;
begin
  setLength(p,3);
  offsetX:=I.width div 10;
  offsetY:=I.height div 20;

  with I do
  begin
    Canvas.Brush.Color:=Canvas.Pen.Color;
    Canvas.MoveTo(offsetX,offsetY);
    p[0]:=point(Canvas.PenPos.X,Canvas.PenPos.Y);
    p[1]:=point(Canvas.PenPos.X + 5,Canvas.PenPos.Y + 15);
    p[2]:=point(Canvas.PenPos.X - 5,Canvas.PenPos.Y + 15);
    Canvas.Polygon(p);
    Canvas.LineTo(Canvas.PenPos.X,height - Canvas.PenPos.Y);
    Canvas.LineTo(width - Canvas.PenPos.X,Canvas.PenPos.Y);

    p[0]:=point(Canvas.PenPos.X,Canvas.PenPos.Y);
    p[1]:=point(Canvas.PenPos.X - 15,Canvas.PenPos.Y - 5);
    p[2]:=point(Canvas.PenPos.X - 15,Canvas.PenPos.Y + 5);
    Canvas.Polygon(p);
  end;

  drawDashes(I,offsetX,offsetY);
end;

procedure drawSizeGraph(I:TImage);
begin
  I.Picture:=nil;
  drawAxises(I);
end;

procedure drawTimeGraph(I:TImage);
begin
  I.Picture:=nil;
  drawAxises(I);
end;




//------MAIN------
procedure TForm2.FormCreate(Sender: TObject);
begin
  Self.DoubleBuffered:=True;
end;

procedure TForm2.FormPaint(Sender: TObject);
begin
  drawTimeGraph(Self.TimeGraphImage);
  drawSizeGraph(Self.SizeGraphImage);
end;

procedure TForm2.FormResize(Sender: TObject);
begin
  Self.refresh;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  //
end;

end.
