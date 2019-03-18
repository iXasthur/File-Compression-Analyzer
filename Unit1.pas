unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  System.ImageList, Vcl.ImgList, Vcl.Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    GridPanel1: TGridPanel;
    OpenDialog1: TOpenDialog;
    ImageList1: TImageList;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Label1Click(Sender: TObject);
begin
  if Label1.Caption = '(c)Mikhail Kavaleuski ' then
  begin
    Label1.Caption := '¡¿Õ! '
  end else
      begin
        Label1.Caption := '(c)Mikhail Kavaleuski '
      end;
end;

end.
