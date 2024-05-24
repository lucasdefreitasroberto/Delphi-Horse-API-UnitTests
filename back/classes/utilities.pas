unit Utilities;

interface

uses
  Providers.Connection, FireDAC.Comp.Client, System.Variants, Data.DB,
  System.SysUtils, System.JSON, System.Classes;

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
    FOwnsConnection: Boolean;
    function CreateQuery: TFDQuery;
  public
    constructor Create(AConnection: TFDConnection = nil);
    destructor Destroy; override;
    function ExecuteScalar(const SQL: string): Variant;
    function ExecuteReader(const SQL: string): TDataSet;
    procedure ExecuteCommand(const SQL: string; const Params: array of Variant; const ParamNames: array of string);
  end;

implementation

{ TQueryExecutor }

constructor TQueryExecutor.Create(AConnection: TFDConnection = nil);
begin
  if Assigned(AConnection) then
  begin
    FConnection := AConnection;
    FOwnsConnection := False;
  end
  else
  begin
    FConnection := TFDConnection.Create(nil);
    FConnection.Params.Assign(ProviderConnection.con.Params);
    FOwnsConnection := True;
  end;
end;

function TQueryExecutor.CreateQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConnection;
end;

destructor TQueryExecutor.Destroy;
begin
  if FOwnsConnection then
    FConnection.Free;

  inherited;
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

procedure TQueryExecutor.ExecuteCommand(const SQL: string;
  const Params: array of Variant; const ParamNames: array of string);
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

end.
