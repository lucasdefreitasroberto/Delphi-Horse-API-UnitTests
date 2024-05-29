unit Services.Person;

interface

uses
  System.SysUtils, System.Classes, Providers.Connection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Phys.IBBase, DataSet.Serialize, System.JSON;

type
  TServicesPerson = class(TProviderConnection)
  public
    function ListAll: TFDQuery;
    function GetById(const AId: Int64): TFDQuery;
    function Insert(const AProduct: TJSONObject): TFDQuery;
    function Update(const AProduct: TJSONObject): TFDQuery;
    function Delete(const AId: Int64): Boolean;
  end;

var
  ServicesPerson: TServicesPerson;

implementation

uses
  Person;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TServicesPerson }

{$REGION ' Delete'}

function TServicesPerson.Delete(const AId: Int64): Boolean;
begin
  FDQuery.Delete;

  Result := FDQuery.IsEmpty;
end;
{$ENDREGION}

{$REGION ' GetById'}

function TServicesPerson.GetById(const AId: Int64): TFDQuery;
begin
  FDQuery.SQL.Add('where id = :id');
  FDQuery.ParamByName('id').AsLargeInt := AId;
  FDQuery.Open();

  Result := FDQuery;
end;
{$ENDREGION}

{$REGION ' Insert'}

function TServicesPerson.Insert(const AProduct: TJSONObject): TFDQuery;
var
  ParamName: string;
  ParamValue: string;
  ModifiedJson: TJSONObject;
  Person: TPerson;
begin
  ModifiedJson := TJSONObject.Create;
  Person := TPerson.Create;
  try
    // Iterar sobre os pares no JSON de entrada
    for var Pair in AProduct do
    begin
      if Pair.JsonValue is TJSONString then
      begin
        ParamName := Pair.JsonString.Value;
        ParamValue := TJSONString(Pair.JsonValue).Value;
        ModifiedJson.AddPair(ParamName, TJSONString.Create(UpperCase(ParamValue)));
      end
      else
      begin
        ModifiedJson.AddPair(Pair.JsonString.Clone as TJSONString, Pair.JsonValue.Clone as TJSONValue);
      end;
    end;

    // Adicionar o ID ao JSON modificado
    var NextID := Person.GetNextPersonID;
    ModifiedJson.AddPair('id', NextID.ToString);

    // Preparar a consulta do FireDAC
    FDQuery.SQL.Add('where 1 <> 1');
    FDQuery.Open();

    // Carregar o JSON modificado na consulta
    FDQuery.LoadFromJSON(ModifiedJson, False);

    // Retornar a consulta modificada
    Result := FDQuery;

  finally
    // Liberar a memória usada pelo JSON modificado e pelo objeto Person
    ModifiedJson.Free;
    Person.Free;
  end;
end;

{$ENDREGION}

{$REGION ' ListAll'}

function TServicesPerson.ListAll: TFDQuery;
begin
  FDQuery.SQL.Add('order by ID');
  FDQuery.Open();

  Result := FDQuery;
end;
{$ENDREGION}

{$REGION ' Update'}
function TServicesPerson.Update(const AProduct: TJSONObject): TFDQuery;
var
  ParamName: string;
  ParamValue: string;
  ModifiedJson: TJSONObject;
begin
  // Criar o objeto JSON modificado
  ModifiedJson := TJSONObject.Create;
  try
    // Iterar sobre os pares no JSON de entrada
    for var Pair in AProduct do
    begin
      if Pair.JsonValue is TJSONString then
      begin
        ParamName := Pair.JsonString.Value;
        ParamValue := TJSONString(Pair.JsonValue).Value;
        ModifiedJson.AddPair(ParamName, TJSONString.Create(UpperCase(ParamValue)));
      end
      else
      begin
        ModifiedJson.AddPair(Pair.JsonString.Clone as TJSONString, Pair.JsonValue.Clone as TJSONValue);
      end;
    end;

    // Chamar o método de atualização do FireDAC com o JSON modificado
    FDQuery.MergeFromJSONObject(ModifiedJson, False);

    // Retornar a consulta modificada
    Result := FDQuery;

  finally
    // Liberar a memória usada pelo JSON modificado
    ModifiedJson.Free;
  end;
end;

{$ENDREGION}

end.

