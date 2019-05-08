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
begin
  with I do
  begin
    Canvas.MoveTo(clientWidth div 10,clientHeight div 10);
    Canvas.LineTo(Canvas.PenPos.X,clientHeight - Canvas.PenPos.Y);
    Canvas.LineTo(clientWidth - Canvas.PenPos.X,Canvas.PenPos.Y);
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
