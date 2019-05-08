unit ChartForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  Vcl.StdCtrls;

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

procedure drawAxises(I:TImage);
var
  p:Array of TPoint;
begin
  setLength(p,3);

  with I do
  begin
    Canvas.Brush.Color:=Canvas.Pen.Color;
    Canvas.MoveTo(width div 10,height div 20);
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
