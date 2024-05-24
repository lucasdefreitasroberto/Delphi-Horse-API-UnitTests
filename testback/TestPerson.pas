unit TestPerson;

interface

uses
  DUnitX.TestFramework, FireDAC.Comp.Client, Utilities, System.Classes, Person, Data.DB,
  System.Variants, System.SysUtils, System.JSON, Providers.Connection, TestFramework;

type
  [TestFixture]
  TestTPersonTest = class(TTestCase)
  private
    FPersonTest: TPersonTest;
    FPerson: TPerson;
    FConnection: TFDConnection;
  public
    [Setup]
    procedure SetUp;
    [TearDown]
    procedure TearDown;
  published
    [Test]
    procedure TestIDtreatment;
    procedure TestCPFCNPJtreatment;
  end;

implementation

procedure TestTPersonTest.SetUp;
begin
  FPerson := TPerson.Create;
  FPersonTest := TPersonTest.Create;
end;

procedure TestTPersonTest.TearDown;
begin
  FPersonTest.Free;
  FPerson.Free;
  FConnection.Free;
end;

procedure TestTPersonTest.TestIDtreatment;
var
  ReturnValue: integer;
  aValue : Integer;
begin
  aValue := 1;
  ReturnValue := FPersonTest.IDtreatment(aValue);
  Assert.IsTrue(ReturnValue >= 0, 'IDtreatment retornou um valor inválido');
end;

procedure TestTPersonTest.TestCPFCNPJtreatment;
var
  ReturnValue: string;
  aValue: string;
begin
  aValue := '123.123.123-123';
  ReturnValue := FPersonTest.CPFCNPJtreatment(aValue);
  Assert.AreEqual('123123123123', ReturnValue, 'CPFCNPJtreatment retornou um valor inválido');
end;

initialization
  RegisterTest(TestTPersonTest.Suite);
end.

