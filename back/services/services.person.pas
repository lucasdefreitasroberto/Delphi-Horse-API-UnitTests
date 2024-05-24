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

function TServicesPerson.Insert(const AProduct: TJSONObject): TFDQuery;   //   UpperCase(AProduct.Value);
begin
 var Person := TPerson.Create;

  try
    var NextID := Person.GetNextPersonID;

    NextID := 3;
    FDQuery.SQL.Add('where 1 <> 1');
    FDQuery.Open();

    AProduct.AddPair('id', NextID.ToString);
    FDQuery.LoadFromJSON(AProduct, False);

    Result := FDQuery;
  finally
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
begin
  FDQuery.MergeFromJSONObject(AProduct, False);

  Result := FDQuery;
end;
{$ENDREGION}

end.

