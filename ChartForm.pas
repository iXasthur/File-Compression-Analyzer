unit ChartForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  Vcl.StdCtrls;

const
  dashCount = 7;

type
  TAlgRec = Record
    Name: String;
    Data: Integer;
  end;
  TGraphDataArray = Array of TAlgRec;
//  TSizeGraphArray = Array of TAlgRec;

type
  TForm2 = class(TForm)
    GridPanel1: TGridPanel;
    Label1: TLabel;
    TimeGraphImage: TImage;
    SizeGraphImage: TImage;
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

procedure LoadGraphData(TimeArr:TGraphDataArray;SizeArr:TGraphDataArray);

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


function calcY(I:TImage;offsetY,min,max:Integer;Element:TAlgRec):Integer;
var
  s,buff,yL,yPixelPos,yLengthData,yLengthPixels:Integer;
  k:Real;
  savePos:TPoint;
begin
  calcY:=I.Height - offsetY;
  yL:=((I.Height - 2*offsetY) div (dashCount+1));
  yPixelPos:=offsetY+yL;

  if Element.Data=max then
  begin
    calcY:=yPixelPos;
  end else
        if Element.Data=min then
        begin
          yPixelPos:=I.Height-yPixelPos;
          calcY:=yPixelPos;
        end else
            begin
              yLengthData:=max-min;
              yLengthPixels:=I.Height-2*(offsetY+yL);
              k:=yLengthPixels/yLengthData;

              yPixelPos:=max-Element.Data;
              yPixelPos:=round(yPixelPos*k);
              yPixelPos:=yPixelPos+offsetY+yL;

              calcY:=yPixelPos;
            end;


end;

procedure drawMinMax(I:TImage; offsetX,offsetY,min,max,T:Integer);
var
  yL,dy,s,textPos:Integer;
begin
  textPos:=offsetX+5;
  yL:=(I.height - 2*offsetY) div (dashCount+1);
  I.Canvas.MoveTo(textPos,offsetY);
  I.Canvas.Brush.Color:=clWhite;

  case T of
    1:
      begin
        dy:=(max-min) div (dashCount-1);
        for s := 0 to (dashCount-2) do
        begin
          I.Canvas.MoveTo(textPos,I.Canvas.PenPos.Y+yL);
          I.Canvas.TextOut(I.Canvas.PenPos.X,I.Canvas.PenPos.Y,FloatToStrF((max-dy*s)/1024,ffGeneral,4,4));
        end;
        I.Canvas.MoveTo(textPos,I.Canvas.PenPos.Y+yL);
        I.Canvas.TextOut(I.Canvas.PenPos.X,I.Canvas.PenPos.Y,FloatToStrF(min/1024,ffGeneral,4,4));
      end;
    2:
      begin
        dy:=(max-min) div (dashCount-1);
        for s := 0 to (dashCount-2) do
        begin
          I.Canvas.MoveTo(textPos,I.Canvas.PenPos.Y+yL);
          I.Canvas.TextOut(I.Canvas.PenPos.X,I.Canvas.PenPos.Y,IntToStr(max-dy*s));
        end;
        I.Canvas.MoveTo(textPos,I.Canvas.PenPos.Y+yL);
        I.Canvas.TextOut(I.Canvas.PenPos.X,I.Canvas.PenPos.Y,IntToStr(min));
      end;
  end;
end;

procedure drawPillars(I:TImage; offsetX,offsetY:Integer; DataArr:TGraphDataArray;T:Integer);
var
  count, s, xL, min, max,saveWidth:Integer;
  savePos: TPoint;
begin
  count:=Length(DataArr);
  I.Canvas.Pen.Width:=10;
  I.Canvas.MoveTo(offsetX,I.height - offsetY);
  xL:=(I.Width - 2*offsetX) div (count+1);

  min:=DataArr[0].Data;
  max:=DataArr[0].Data;
  for s := 1 to Length(DataArr)-1 do
  begin
    if DataArr[s].Data>max then
    begin
      max:=DataArr[s].Data;
    end else
          if DataArr[s].Data<min then
          begin
            min:=DataArr[s].Data;
          end;
  end;

  drawMinMax(I,offsetX,offsetY,min,max,T);

  I.Canvas.MoveTo(offsetX,I.height - offsetY);
  with I do
  begin
    for s := 0 to (count-1) do
    begin
      Canvas.MoveTo(Canvas.PenPos.X+xL,I.height - offsetY);

      savePos:=Canvas.PenPos;
      Canvas.TextOut(Canvas.PenPos.X-((Canvas.Font.Size div 2)*Length(DataArr[s].Name)-(Canvas.Font.Size div 4)),Canvas.PenPos.Y+10,DataArr[s].Name);
      Canvas.PenPos:=savePos;

      Canvas.LineTo(Canvas.PenPos.X,calcY(I,offsetY,min,max,DataArr[s]));

      savePos:=Canvas.PenPos;
      saveWidth:=Canvas.Pen.Width;
      Canvas.Pen.Width:=1;
      Canvas.Pen.Style:=psDash;
      Canvas.LineTo(offsetX,Canvas.PenPos.Y);
      Canvas.PenPos:=savePos;
      Canvas.Pen.Width:=saveWidth;
      Canvas.Pen.Style:=psSolid;
    end;
  end;

end;


procedure drawAxises(I:TImage;DA:TGraphDataArray;T:Integer);
var
  p:Array of TPoint;
  offsetX, offsetY:Integer;
begin
  setLength(p,3);
  offsetX:=I.width div 10;
  offsetY:=I.height div 10;
  I.Canvas.Font.Size:=10;
  I.Canvas.Font.Name:='Calibri';

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
  if length(DA)>0 then
  begin
    drawPillars(I,offsetX,offsetY,DA,T);
  end;
end;

procedure drawSizeGraph(I:TImage;SA:TGraphDataArray);
begin
  I.Picture:=nil;
  drawAxises(I,SA,1);
end;

procedure drawTimeGraph(I:TImage;TA:TGraphDataArray);
begin
  I.Picture:=nil;
  drawAxises(I,TA,2);
end;



var
  TimeArrG,SizeArrG:TGraphDataArray;

//------MAIN------
procedure LoadGraphData(TimeArr:TGraphDataArray;SizeArr:TGraphDataArray);
var
  i:Integer;
begin
  SetLength(TimeArrG,Length(TimeArr));
  SetLength(SizeArrG,Length(SizeArr));
  for i := 0 to Length(TimeArrG)-1 do
  begin
    TimeArrG[i]:=TimeArr[i];
  end;

  for i := 0 to Length(SizeArrG)-1 do
  begin
    SizeArrG[i]:=SizeArr[i];
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  i:Integer;
begin
  Self.DoubleBuffered:=True;

  SetLength(TimeArrG,0);
  SetLength(SizeArrG,0);
end;

procedure TForm2.FormPaint(Sender: TObject);
begin
  drawSizeGraph(Self.SizeGraphImage,SizeArrG);
  drawTimeGraph(Self.TimeGraphImage,TimeArrG);
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
