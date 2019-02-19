program NIQCApp2_1_0;

{%ToDo 'NIQCApp2_1_0.todo'}

uses
  Forms,
  NIQCUnit2_1_0 in 'NIQCUnit2_1_0.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
