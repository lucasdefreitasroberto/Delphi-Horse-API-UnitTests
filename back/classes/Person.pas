unit Person;

interface

uses
  Providers.Connection, FireDAC.Comp.Client, System.Variants, Data.DB,
  System.SysUtils, System.JSON, System.Classes, Utilities;

type
  TPerson = class
  private
    FQueryExecutor: TQueryExecutor;
  public
    constructor Create(AConnection: TFDConnection = nil);
    destructor Destroy; override;

    function GetNextPersonID: Integer;
  end;

  TPersonTest = class
  private
    FPerson: TPerson;
  public
    constructor Create;
    destructor Destroy; override;

    function IDtreatment(aValue: Integer): Integer;
    function CPFCNPJtreatment(aValue: string): string;
  end;

implementation

{ TPerson }

constructor TPerson.Create;
begin
  FQueryExecutor := TQueryExecutor.Create(AConnection);
end;

destructor TPerson.Destroy;
begin
  if Assigned(FQueryExecutor) then
    FQueryExecutor.Free;

  inherited;
end;

function TPerson.GetNextPersonID: Integer;
var
  NextID: Variant;
begin
  //Esta parte de criar TQueryExecutor novamente e para o Teste Unitario
  //FQueryExecutor := TQueryExecutor.Create();

  NextID := FQueryExecutor.ExecuteScalar
    ('select coalesce(max(P.ID), 0) + 1 from PESSOA P');
  if VarIsNull(NextID) then
    Result := 1
  else
    Result := NextID;
end;

{ TPersonTest }

constructor TPersonTest.Create;
begin
  FPerson := TPerson.Create;
end;

destructor TPersonTest.Destroy;
begin
  if Assigned(FPerson) then
    FPerson.Free;

  inherited;
end;

function TPersonTest.IDtreatment(aValue: Integer): Integer;
var
  StrValue: string;
  I: Integer;
begin
  Result := 0;
  StrValue := IntToStr(aValue);
  for I := 1 to Length(StrValue) do
  begin
    if StrValue[I] in ['0'..'9'] then
      Result := Result + StrToInt(StrValue[I]);
  end;
end;

function TPersonTest.CPFCNPJtreatment(aValue: string): string;
begin
  for var I := 1 to Length(aValue) do
  begin
    if aValue[I] in ['0'..'9'] then
      Result := Result + (aValue[I]);
  end;
end;
end.
