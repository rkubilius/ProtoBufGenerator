program ProtoBufGeneratorTestsFPC;

{$mode Delphi}{$H+}
{$modeswitch unicodestrings}

uses
  Interfaces, Forms, GuiTestRunner,
  TestGeneratedProtoBufPas,
  TestuAbstractProtoBufClasses,
  TestuProtoBufRawIO;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

