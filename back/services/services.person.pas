unit services.person;

interface

uses
  System.SysUtils, System.Classes, Providers.Connection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Phys.IBBase, DataSet.Serialize, System.JSON;

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

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TServicesPerson }

function TServicesPerson.Delete(const AId: Int64): Boolean;
begin
  FDQuery.Delete;

  Result := FDQuery.IsEmpty;
end;

function TServicesPerson.GetById(const AId: Int64): TFDQuery;
begin
  FDQuery.SQL.Add('where id = :id');
  FDQuery.ParamByName('id').AsLargeInt := AId;
  FDQuery.Open();

  Result := FDQuery;
end;

function TServicesPerson.Insert(const AProduct: TJSONObject): TFDQuery;
begin
  var
  id := StrToInt(ProviderConnection.ExecuteScalar
    ('select max(P.ID) + 1 from PESSOA P'));

  FDQuery.SQL.Add('where 1 <> 1');
  FDQuery.Open();

  AProduct.AddPair('id', id.ToString);
  FDQuery.LoadFromJSON(AProduct, False);

  Result := FDQuery;
end;

function TServicesPerson.ListAll: TFDQuery;
begin
  FDQuery.SQL.Add('order by ID');
  FDQuery.Open();

  Result := FDQuery;
end;

function TServicesPerson.Update(const AProduct: TJSONObject): TFDQuery;
begin
  FDQuery.MergeFromJSONObject(AProduct, False);

  Result := FDQuery;
end;

end.
