unit uController.Person;

interface

uses
  Horse, Services.Person, DataSet.Serialize, System.JSON, System.SysUtils,
  Data.DB;

procedure Registry;

implementation

{$REGION ' DoListPerson'}

procedure DoListPerson(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  var
  LService := TServicesPerson.Create;
  try
    Res.Send<TJSONArray>(LService.ListAll.ToJSONArray()).Status(THTTPStatus.OK);
  finally
    LService.Free;
  end;
end;
{$ENDREGION}

{$REGION ' DoGetPerson'}

procedure DoGetPerson(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  var
  LService := TServicesPerson.Create;
  try
    var
    id := Req.Params['id'].ToInt64;

    if LService.GetById(id).IsEmpty then
      raise EHorseException.New.Error('Not found').Status(THTTPStatus.NotFound);

    Res.Send<TJSONObject>(LService.FDQuery.ToJSONObject());

  finally
    LService.Free;
  end;
end;
{$ENDREGION}

{$REGION ' DoPostPerson'}

procedure DoPostPerson(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  var
  LService := TServicesPerson.Create;

  try
    Res.Send<TJSONObject>(LService.Insert(Req.Body<TJSONObject>).ToJSONObject())
      .Status(THTTPStatus.Created);
  finally
   LService.Free;
  end;

end;

{$ENDREGION}

{$REGION ' DoPutPerson'}

procedure DoPutPerson(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  var
  LService := TServicesPerson.Create;
  try
    var
    id := Req.Params['id'].ToInt64;

    if LService.GetById(id).IsEmpty then
      raise EHorseException.New.Error('Not found').Status(THTTPStatus.NotFound);

    Res.Send<TJSONObject>(LService.Update(Req.Body<TJSONObject>).ToJSONObject());
  finally
    LService.Free;
  end;
end;
{$ENDREGION}

{$REGION ' DoDeletePerson'}

procedure DoDeletePerson(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService : TServicesPerson;
begin
  LService := TServicesPerson.Create;
  try
    var
      id := Req.Params['id'].ToInt64;

    if LService.GetById(id).IsEmpty then
      raise EHorseException.New.Error('Not found').Status(THTTPStatus.NotFound);

    if LService.Delete(id) then
    begin
      Res.Send('Deleted successfully').Status(THTTPStatus.NoContent);
    end;

  finally
    LService.Free;
  end;

end;
{$ENDREGION}

{$REGION ' Registry'}

procedure Registry;
begin
  THorse.Get('/person', DoListPerson);
  THorse.Get('/person/:id', DoGetPerson);
  THorse.Post('/person', DoPostPerson);
  THorse.Put('/person/:id', DoPutPerson);
  THorse.Delete('/person/:id', DoDeletePerson);
end;
{$ENDREGION}

end.
