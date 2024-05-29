unit middleware.global;

interface

uses
  Horse, Horse.Request, System.JSON, System.SysUtils;

procedure PostUpCase(Req: THorseRequest; Res: THorseResponse; Next: TProc);


procedure TreatValue(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure PostUpCase(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JsonObj: TJSONObject;
  Pair: TJSONPair;
  ParamName: string;
  ParamValue: string;
  ModifiedJson: TJSONObject;
begin

  if (Req.RawWebRequest.Method = 'PUT') or (Req.RawWebRequest.Method = 'POST') then
  begin
    JsonObj := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
    if Assigned(JsonObj) then
    try
      ModifiedJson := TJSONObject.Create;
      try
        for Pair in JsonObj do
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
        Res.Send <TJSONObject>(ModifiedJson);
      finally
        ModifiedJson.Free;
      end;
    finally
      JsonObj.Free;
    end;
  end;
   Next;
end;




procedure TreatValue(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
//  if Req.RawWebRequest.Method = 'POST' then
//  begin
//    for var I := 0 to Req.Params.Count - 1 do
//    begin
//      var ParamName := Req.Params.Field('');
//      var ParamValue := Req.Params[ParamName];
//
//      if ParamValue.IsEmpty then
//      begin
//        // Assume que se o parâmetro não tem valor, é nulo e deve ser tratado
//        if Req.Query.TryGetValue(ParamName, ParamValue) then
//        begin
//          // Determina o tipo do valor
//          try
//            // Tentativa de conversão para inteiro
//            var IntValue: Integer;
//            if TryStrToInt(ParamValue, IntValue) then
//              Req.Params[ParamName] := '0'
//            else
//              Req.Params[ParamName] := '';
//          except
//            // Se ocorrer uma exceção durante a conversão, trata como string
//            Req.Params[ParamName] := '';
//          end;
//        end
//        else
//        begin
//          // Caso o parâmetro não exista na query, trata como string vazia
//          Req.Params[ParamName] := '';
//        end;
//      end;
//    end;
//  end;
//
//  Next;
end;


end.

