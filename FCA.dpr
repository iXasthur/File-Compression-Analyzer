program FCA;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {Form1},
  ChartForm in 'ChartForm.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TchForm, chForm);
  Application.Run;
end.
