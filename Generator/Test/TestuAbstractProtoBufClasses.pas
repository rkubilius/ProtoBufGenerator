unit TestuAbstractProtoBufClasses;

interface

uses
  {$IFDEF FPC}
  fpcunit, testregistry,
  {$ELSE}
  System.Generics.Collections,
  {$ENDIF}
  uAbstractProtoBufClasses,
  SysUtils,
  Classes;

type
  TestTAbstractProtoBufClass = class(TTestCase)
  published
    procedure TestCopyFrom;
  end;

implementation

uses
  Math,
  test1;

{ TestTAbstractProtoBufClass }

procedure TestTAbstractProtoBufClass.TestCopyFrom;
var
  tmSource: TTestMsg1;
  tmCopy: TAbstractProtoBufClass;
  msSource, msCopy: TMemoryStream;
begin
  msSource:= TMemoryStream.Create;
  msCopy:= TMemoryStream.Create;
  tmSource:= TTestMsg1.Create;
  tmCopy:= nil;
  try
    //change some fields based on their default value
    tmSource.DefField1:= tmSource.DefField1 + 1;
    tmSource.DefField2:= tmSource.DefField2 - 25;
    tmSource.DefField3:= 'And now for something completely different';
    tmSource.DefField4:= tmSource.DefField4 * 3.14;
    tmSource.DefField5:= not tmSource.DefField5;
    tmSource.DefField6:= g1;

    tmCopy:= tmSource.Copy;

    Check(tmCopy.ClassType = tmSource.ClassType, 'ClassType not identical');

    tmSource.SaveToStream(msSource);
    tmCopy.SaveToStream(msCopy);

    Check(msSource.Size > 0, 'Source has no size');
    CheckEquals(msSource.Size, msCopy.Size, 'Stream size mismatch');
    Check(CompareMem(msSource.Memory, msCopy.Memory, msSource.Size), 'Stream content mismatch');

    //now double check that modifying the source will make it fail
    msCopy.Clear;
    TTestMsg1(tmCopy).DefField1:= TTestMsg1(tmCopy).DefField1 + 300;
    tmCopy.SaveToStream(msCopy);

    CheckFalse(CompareMem(msSource.Memory, msCopy.Memory, Min(msSource.Size, msCopy.Size)), 'Stream content does not mismatch');
  finally
    tmSource.Free;
    tmCopy.Free;
    msSource.Free;
    msCopy.Free;
  end;
end;

initialization
  RegisterTest('uAbstractProtBufClasses', TestTAbstractProtoBufClass.Suite);
end.
