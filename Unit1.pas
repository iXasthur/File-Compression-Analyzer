unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  System.ImageList, Vcl.ImgList, Vcl.Buttons;



type
  TText = TStringList;
  TFile = TextFile;

  THuffArrayElement = Record
    symbolCode: Integer;
    count: Integer;
  end;
  THuffArray = Array of THuffArrayElement;

  HUFFTreePointer = ^HUFFTreeNode;
  HUFFTreeNode = Record
    symbol: Integer;
    left: HUFFTreePointer;
    right: HUFFTreePointer;
  end;



type
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
    CheckBoxHUFF: TCheckBox;
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



//-------RLE-------
function RLECompressString(str: String):String;
var
  s: Integer;
  buffChar: Char;
  buffStr: String;
begin
  buffStr:='';
  if length(str)>1 then
  begin
    while length(str)>=1 do
    begin
      s:=0;
      buffChar:=str[1];

      while (length(str)>=1) and (str[1]=buffChar) and (s<>9) do
      begin
        s:=s+1;
        delete(str,1,1);
      end;

      buffStr:=buffStr+IntToStr(s);
      buffStr:=buffStr+buffChar;
    end;
  end else
        if length(str)=1 then
        begin
          buffChar:=str[1];
          buffStr:='1';
          buffStr:=buffStr+buffChar;
        end;


//  RLECompressString:=IntToStr(length(str));
  RLECompressString:=buffStr;
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
//-----------------



//-----HUFFMAN-----
function HUFFCompressString(str: String):String;
var
  i: Integer;
begin

end;


function HUFFGetCount(var arr:THuffArray; str: String):integer;
var
  i,n: Integer;
  buffChar: char;
  check: boolean;
begin
  n:=-1;
  while length(str)>0 do
  begin
    n:=n+1;
    buffChar:=str[1];
    arr[n].symbolCode:=ord(buffChar);
    while pos(buffChar,str)<>0 do
    begin
      arr[n].count:=arr[n].count+1;
      delete(str, pos(buffChar,str), 1);
    end;

  end;
  HUFFGetCount:=n+1;
end;


procedure HUFFSort(var arr:THuffArray);
var
  i: integer;
  save:THuffArrayElement;
  check:Boolean;
begin
  check:=false;
  while check=false do
  begin
    check:=true;
    for i := 0 to length(arr)-2 do
    begin
      if arr[i].count<arr[i+1].count then
      begin
        save:=arr[i];
        arr[i]:=arr[i+1];
        arr[i+1]:=save;
        check:=false;
      end;
    end;
  end;
end;

procedure HUFFCreateTree(var head: HuffTreePointer; arr:THuffArray);
var
  elementL,elementR: HuffTreePointer;
  n:integer;
begin
  n:=0;

  new(head);
  head.symbol:=-1;
  head.left:=nil;
  head.right:=nil;

  elementL:=head;
  elementR:=head;

  while n<length(arr)-2 do
  begin
    new(elementL.left);
    elementL:=elementL.left;

    elementL.symbol:=-1;
    elementL.left:=nil;

    new(elementL.right);
    elementL.right.right:=nil;
    elementL.right.left:=nil;
    elementL.right.symbol:=arr[n].symbolCode;
    n:=n+1;

    if n<length(arr)-2 then
    begin
      new(elementR.right);
      elementR:=elementR.left;
      elementR.symbol:=-1;
      elementR.left:=nil;

      new(elementR.right);
      elementR.right.right:=nil;
      elementR.right.left:=nil;
      elementR.right.symbol:=arr[n].symbolCode;
      n:=n+1;
    end;
  end;

  new(elementR.left);
  elementR:=elementR.left;
  elementR.right:=nil;
  elementR.left:=nil;
  elementR.symbol:=arr[n].symbolCode;

  new(elementL.left);
  elementL:=elementL.left;
  elementL.right:=nil;
  elementL.left:=nil;
  elementL.symbol:=arr[n+1].symbolCode;


end;

procedure OutputTree(head:HuffTreePointer);
var
  elementL,elementR: HuffTreePointer;
  check: Boolean;
  i: integer;
begin
  check:=true;
  elementL:=head;
  elementR:=head;

//  while check do
//  begin
//
//  end;

end;

procedure HUFFCompress(strs:TText; newPath:String);
var
  i,n: Integer;
  s: String;
  F: TFile;
  arr: THuffArray;
  treeHead: HuffTreePointer;
begin
  s:=strs.Text;
  delete(s,length(s)-1,2); //Deletes last #13#10

  SetLength(arr,254);
  n:=HUFFGetCount(arr,s);
  SetLength(arr,n);
  HUFFSort(arr);

  HUFFCreateTree(treeHead,arr);
  OutputTree(treeHead);

  AssignFile(F,newPath);
  Rewrite(F);

  //HuffTable in file
  for i := 0 to length(arr)-1 do
  begin
    writeln('#',arr[i].symbolCode,' - ',arr[i].count);
//    write(F,Chr(arr[i].symbolCode),IntToStr(arr[i].count),#27);
    write(F,Chr(arr[i].symbolCode));
  end;
  write(F,#27,#27);
  //





  CloseFile(F);
  //ClearTree!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Finalize(arr);
end;
//-----------------










procedure CompressionStart(strs:TText;z:integer);
var
  i,p: Integer;
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
        newName:=newName+'.xrle';
        newPath:=newPath+newName;

        RLECompress(strs,newPath);
        write('RLE ');
      end;
    2:
      begin
        newName:=newName+'.xhfm';
        newPath:=newPath+newName;

        HUFFCompress(strs,newPath);
        write('Huffman ');
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

  if Self.CheckBoxHUFF.Checked then
  begin
    CompressionStart(txt,2);
  end;

  txt.Free;
  //FreeConsole;
end;




//-------RLE-------
function decompressRLEString(str:String):String;
var
  s,i: Integer;
  buffChar: Char;
  buffCount: Integer;
  buffStr: String;
begin
  buffStr:='';
  if length(str)>2 then
  begin
    while length(str)>=2 do
    begin
      buffCount:=StrToInt(str[1]);
      buffChar:=str[2];
      for i:=1 to buffCount do
      begin
        buffStr:=buffStr+buffChar;
      end;
      delete(str,1,2);
    end;
  end else
        if length(str)=2 then
        begin
          buffCount:=StrToInt(str[1]);
          buffChar:=str[2];
          for i:=1 to buffCount do
          begin
            buffStr:=buffStr+buffChar;
          end;

        end;


  decompressRLEString:=buffStr;
end;


procedure decompressRLE(txt:TText;newPath:String);
var
  F:TFile;
  i:integer;
begin
  AssignFile(F,newPath);
  Rewrite(F);

  if txt.Count>1 then
  begin
    for i:=0 to txt.Count-2 do
    begin
      writeln(F,decompressRLEString(txt[i]));
    end;
    write(F,decompressRLEString(txt[i]));
  end else
        if txt.Count=1 then
        begin
        write(F,decompressRLEString(txt[0]));
        end;


  CloseFile(F);
end;
//-----------------




//-----HUFFMAN-----
function decompressHFMString(str:String):String;
var
  i: Integer;
begin

end;


procedure decompressHFM(txt:TText;newPath:String);
var
  F:TFile;
  i:integer;
begin
  AssignFile(F,newPath);
  Rewrite(F);


  CloseFile(F);
end;
//-----------------



procedure StartDecompression(path:String;z:integer);
var
  i,p: Integer;
  txt:TText;
  newPath,newName: String;
begin
  AllocConsole;

  Form1.Memo1.Clear;
  txt:= TStringList.Create;
  txt.LoadFromFile(path);

  newPath:=ExtractFilePath(path);
  newName:=ExtractFileName(path);
  p:=pos(ExtractFileExt(path),newName);
  if p<>0 then
  begin
    Delete(newName,p,length(ExtractFileExt(path)));
  end;
  newName:='D_' + newName;
  newName:=newName+'.txt';
  newPath:=newPath+newName;

  case z of
    1:
      begin
        decompressRLE(txt,newPath);
        write('RLE ');
      end;
    2:
      begin
        decompressHFM(txt,newPath);
        write('Huffman ');
      end;
    3:
      begin

      end;
  end;

  txt.clear;
  txt.LoadFromFile(newPath);
  Form1.Memo1.Lines:=txt;

  writeln('Decompression Result:');
  for i := 0 to txt.Count-1 do
  begin
    writeln(txt[i]);
  end;


  writeln;
  printFileInfo(newPath);
  writeln;
  writeln;

  if Form1.CheckBoxExport.Checked=false then
  begin
    DeleteFile(newPath);
  end;

  txt.Free;
end;


procedure TForm1.DecompressionButtonClick(Sender: TObject);
begin
  if (Self.OpenDialog1.FileName<>'') then
  begin
    if ExtractFileExt(Form1.OpenDialog1.FileName)='.xrle' then
    begin
      StartDecompression(Self.OpenDialog1.FileName,1);
    end else
          if ExtractFileExt(Form1.OpenDialog1.FileName)='.xhfm' then
          begin
            StartDecompression(Self.OpenDialog1.FileName,2);
          end;
  end

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
  Self.CheckBoxHUFF.Enabled:=False;
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
    if ExtractFileExt(Self.OpenDialog1.FileName)='.xrle' then
    begin
      s:=1;
    end else
          if ExtractFileExt(Self.OpenDialog1.FileName)='.xhfm' then
          begin
            s:=2;
          end;


    case s of
    1:
      begin
        Self.DecompressionButton.Enabled:=True;
        Self.DecompressionButton.Caption:='Decompress(RLE)';

        Self.CompressionButton.Enabled:=False;

        Self.CheckBoxRLE.Enabled:=False;
        Self.CheckBoxHUFF.Enabled:=False;
        Self.CheckBox3.Enabled:=False;
        Self.CheckBoxExport.Enabled:=True;
      end;
    2:
      begin
        Self.DecompressionButton.Enabled:=True;
        Self.DecompressionButton.Caption:='Decompress(Huffman)';

        Self.CompressionButton.Enabled:=False;

        Self.CheckBoxRLE.Enabled:=False;
        Self.CheckBoxHUFF.Enabled:=False;
        Self.CheckBox3.Enabled:=False;
        Self.CheckBoxExport.Enabled:=True;
      end;
    else
      begin
        Self.DecompressionButton.Enabled:=False;
        Self.DecompressionButton.Caption:='Decompress';

        Self.CompressionButton.Enabled:=True;

        Self.CheckBoxRLE.Enabled:=True;
        Self.CheckBoxHUFF.Enabled:=True;
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
