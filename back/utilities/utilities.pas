unit Utilities;

interface

uses
  Providers.Connection, FireDAC.Comp.Client, System.Variants, Data.DB,
  System.SysUtils;

type
  IQueryExecutor = interface
    ['{FD8231AB-EE6C-4B74-933D-5CE48B1C3024}']
    function ExecuteScalar(const SQL: string): Variant;
    function ExecuteReader(const SQL: string): TDataSet;
    procedure ExecuteCommand(const SQL: string; const Params: array of Variant; const ParamNames: array of string);
  end;

  TQueryExecutor = class(TInterfacedObject, IQueryExecutor)
  private
    FConnection: TFDConnection;
    function CreateQuery: TFDQuery;
  public
    constructor Create(AConnection: TFDConnection);
    function ExecuteScalar(const SQL: string): Variant;
    function ExecuteReader(const SQL: string): TDataSet;
    procedure ExecuteCommand(const SQL: string; const Params: array of Variant; const ParamNames: array of string);
  end;

  TMethods = class
  private
    FQueryExecutor: IQueryExecutor;
  public
    constructor Create(AQueryExecutor: IQueryExecutor);
    function GetNextPessoaID: Integer;
  end;

  TUtilitiesFacade = class
  private
    FQueryExecutor: IQueryExecutor;
    FMethods: TMethods;
  public
    constructor Create(AConnection: TFDConnection);
    destructor Destroy; override;
    function GetNextPessoaID: Integer;
  end;

implementation

{ TQueryExecutor }

constructor TQueryExecutor.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TQueryExecutor.CreateQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConnection;
end;

function TQueryExecutor.ExecuteScalar(const SQL: string): Variant;
var
  Query: TFDQuery;
begin
  Query := CreateQuery;
  try
    Query.SQL.Text := SQL;
    Query.Open;
    if not Query.Eof then
      Result := Query.Fields[0].Value
    else
      Result := Null;
  finally
    Query.Free;
  end;
end;

function TQueryExecutor.ExecuteReader(const SQL: string): TDataSet;
var
  Query: TFDQuery;
begin
  Query := CreateQuery;
  try
    Query.SQL.Text := SQL;
    Query.Open;
    Result := Query;
  except
    Query.Free;
    raise;
  end;
end;

procedure TQueryExecutor.ExecuteCommand(const SQL: string; const Params: array of Variant; const ParamNames: array of string);
var
  Query: TFDQuery;
  I: Integer;
begin
  Query := CreateQuery;
  try
    Query.SQL.Text := SQL;
    for I := Low(Params) to High(Params) do
      Query.ParamByName(ParamNames[I]).Value := Params[I];
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

{ TMethods }

constructor TMethods.Create(AQueryExecutor: IQueryExecutor);
begin
  FQueryExecutor := AQueryExecutor;
end;

function TMethods.GetNextPessoaID: Integer;
var
  NextID: Variant;
begin
  NextID := FQueryExecutor.ExecuteScalar('select coalesce(max(P.ID), 0) + 1 from PESSOA P');
  if VarIsNull(NextID) then
    Result := 1 // Caso não haja registros, retornar 1 como próximo ID
  else
    Result := NextID;
end;

{ TUtilitiesFacade }

constructor TUtilitiesFacade.Create(AConnection: TFDConnection);
begin
  FQueryExecutor := TQueryExecutor.Create(AConnection);
  FMethods := TMethods.Create(FQueryExecutor);
end;

destructor TUtilitiesFacade.Destroy;
begin
  FMethods.Free;
  FQueryExecutor := nil; // Liberar referência da interface
  inherited;
end;

function TUtilitiesFacade.GetNextPessoaID: Integer;
begin
  Result := FMethods.GetNextPessoaID;
end;

end.

