unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  System.ImageList, Vcl.ImgList, Vcl.Buttons;

type
  TText = TStringList;
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
    CheckBoxRLE: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    DecompressionButton: TSpeedButton;
    CheckBoxExport: TCheckBox;
    procedure OpenButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure CompressionButtonClick(Sender: TObject);
    procedure DecompressionButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function GetFileSize(FileName: String): Int64;
var FS: TFileStream;
begin
  FS := TFileStream.Create(FileName, fmOpenRead);
  Result := FS.Size;
  FS.Free;
end;

//n-Full File Path
procedure printFileInfo(n:String);
begin
  Writeln('File Info:');
  writeln('Drive      = '+ExtractFileDrive (n));
  writeln('Catalog    = '+ExtractFileDir   (n));
  writeln('Path       = '+ExtractFilePath  (n));
  writeln('Name       = '+ExtractFileName  (n));
  writeln('Extention  = '+ExtractFileExt   (n));
  writeln('Size       = '+IntToStr(GetFileSize(n)));
end;




function RLECompressString(str: String):String;
var
  i: Integer;
  buffChar: Char;
begin



  RLECompressString:=IntToStr(length(str));
end;


procedure RLECompress(strs:TText; newPath:String);
var
  i: Integer;
  F: TFile;
begin
  AssignFile(F,newPath);
  Rewrite(F);

  if strs.Count>1 then
  begin
    for i:=0 to strs.Count-2 do
    begin
      writeln(F,RLECompressString(strs[i]));
    end;
    write(F,RLECompressString(strs[i]));
  end else
        if strs.Count=1 then
        begin
          write(F,RLECompressString(strs[0]));
        end;

  CloseFile(F);
end;



procedure CompressionStart(strs:TText;z:integer);
var
  i,p: Integer;
  F:TFile;
  newPath,newName: String;
begin
  newPath:=ExtractFilePath(Form1.OpenDialog1.FileName);
  newName:=ExtractFileName(Form1.OpenDialog1.FileName);
  p:=pos(ExtractFileExt(Form1.OpenDialog1.FileName),newName);
  if p<>0 then
  begin
    Delete(newName,p,length(ExtractFileExt(Form1.OpenDialog1.FileName)));
  end;




  case z of
    1:
      begin
        newName:=newName+'.fyRLE';
        newPath:=newPath+newName;

        RLECompress(strs,newPath);
        write('RLE ');
      end;
    2:
      begin

      end;
    3:
      begin

      end;
  end;


  strs.LoadFromFile(newPath);
  writeln('Compression Result:');
  for i := 0 to strs.Count-1 do
  begin
    writeln(strs[i]);
  end;


  writeln;
  printFileInfo(newPath);
  writeln;
  writeln;
end;


procedure TForm1.CompressionButtonClick(Sender: TObject);
var
  txt: TText;
  i:integer;
begin
  txt:= TStringList.Create;
  txt.LoadFromFile(Self.OpenDialog1.FileName);

  AllocConsole;
  writeln('Uncompressed text:');
  for i := 0 to txt.Count-1 do
  begin
    writeln(txt[i]);
  end;

  writeln;
  printFileInfo(Self.OpenDialog1.FileName);
  writeln;
  writeln;

  if Self.CheckBoxRLE.Checked then
  begin
    CompressionStart(txt,1);
  end;
  //FreeConsole;
end;






procedure decompressRLE(path:String);
var
  i: Integer;
begin

end;


procedure TForm1.DecompressionButtonClick(Sender: TObject);
begin
  if (Self.OpenDialog1.FileName<>'') and (ExtractFileExt(Form1.OpenDialog1.FileName)='.fyRLE') then
  begin
    decompressRLE(Self.OpenDialog1.FileName);
  end;

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

  Self.CheckBoxRLE.Enabled:=False;
  Self.CheckBox2.Enabled:=False;
  Self.CheckBox3.Enabled:=False;
  Self.CheckBoxExport.Enabled:=False;

  Self.CompressionButton.Enabled:=False;
  Self.DecompressionButton.Enabled:=False;

end;

procedure TForm1.OpenButtonClick(Sender: TObject);
var
  s:integer;
begin
  if OpenDialog1.Execute() then
  begin
    Self.Memo1.Lines.LoadFromFile(Self.OpenDialog1.FileName);

    Self.OpenButton.Caption:='Open another file';
    Self.OpenLabel.Hide;

    Self.LabelFilePath.Show;
    Self.LabelFilePath.Caption:='File path: ' + OpenDialog1.FileName;

    s:=0;
    if ExtractFileExt(Self.OpenDialog1.FileName)='.fyRLE' then
    begin
      s:=1;
    end;


    case s of
    1:
      begin
        Self.DecompressionButton.Enabled:=True;
        Self.DecompressionButton.Caption:='Decompress(RLE)';

        Self.CompressionButton.Enabled:=False;

        Self.CheckBoxRLE.Enabled:=False;
        Self.CheckBox2.Enabled:=False;
        Self.CheckBox3.Enabled:=False;
        Self.CheckBoxExport.Enabled:=True;
      end;
    else
      begin
        Self.DecompressionButton.Enabled:=False;
        Self.DecompressionButton.Caption:='Decompress';

        Self.CompressionButton.Enabled:=True;

        Self.CheckBoxRLE.Enabled:=True;
        Self.CheckBox2.Enabled:=True;
        Self.CheckBox3.Enabled:=True;
        Self.CheckBoxExport.Enabled:=False;
      end;
    end;
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
