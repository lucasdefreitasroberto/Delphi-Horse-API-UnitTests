unit middleware.global;

interface

uses
  Horse, Horse.Request, System.JSON, System.SysUtils;

procedure PostUpCase(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

procedure PostUpCase(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin

//  if Req.RawWebRequest.Method = 'POST' then
//  begin
//    Req.RawWebRequest.Content;
//  end;
//
//  if Req.RawWebRequest.Method = 'PUT' then
//  begin
//    UpperCase(Req.Body<string>);
//  end;
//
//  Next;

end;

end.

