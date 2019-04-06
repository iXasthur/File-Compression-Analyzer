unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  System.ImageList, Vcl.ImgList, Vcl.Buttons;

type
  TString = TStrings;
  TFile = TextFile;
  TForm1 = class(TForm)
    Label1: TLabel;
    GridPanelMain: TGridPanel;
    OpenDialog1: TOpenDialog;
    OpenButton: TSpeedButton;
    Memo1: TMemo;
    OpenLabel: TLabel;
    LabelFilePreview: TLabel;
    LabelFilePath: TLabel;
    CompressionButton: TSpeedButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    procedure OpenButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure CompressionButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.CompressionButtonClick(Sender: TObject);
var
  txt: TString;
  F: TFile;
  i:integer;
begin
//  AssignFile(F,OpenDialog1.FileName);
//  Reset(F);
//  while not eof(F) do
//  begin
//    Readln(F,buffStr);
//    str:=str+buffStr;
//  end;
//  CloseFile(F);
  txt:=Self.Memo1.Lines;

  AllocConsole;
  writeln('Uncompressed text:');
  for i := 0 to Self.Memo1.Lines.Count-1 do
  begin
    writeln(txt[i]);
  end;
  writeln;
  //FreeConsole;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.GridPanelMain.Color:=clWebSeashell;
  Self.OpenLabel.Caption:='File isn''t open';
  openDialog1.InitialDir := GetCurrentDir;
  Self.Memo1.Color:=clWebLavender;
  Self.Memo1.Text:='';
  Self.LabelFilePath.Hide;
  Self.LabelFilePreview.Caption:='File preview';

  Self.CheckBox1.Enabled:=False;
  Self.CheckBox2.Enabled:=False;
  Self.CheckBox3.Enabled:=False;

  Self.CompressionButton.Enabled:=False;
end;

procedure TForm1.OpenButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute() then
  begin
    Self.Memo1.Lines.LoadFromFile(OpenDialog1.FileName);

    Self.OpenButton.Caption:='Open another file';
    Self.OpenLabel.Hide;

    Self.LabelFilePath.Show;
    Self.LabelFilePath.Caption:='File path: ' + OpenDialog1.FileName;

    Self.CheckBox1.Enabled:=True;
    Self.CheckBox2.Enabled:=True;
    Self.CheckBox3.Enabled:=True;

    Self.CompressionButton.Enabled:=True;

  end;
end;


procedure TForm1.Label1Click(Sender: TObject);
begin
  if Self.Label1.Caption='(c)Mikhail Kavaleuski ' then
  begin
    Self.Label1.Caption:='Ты напоролся на БАН! '
  end else
      begin
        Self.Label1.Caption:='(c)Mikhail Kavaleuski '
      end;

end;



end.
