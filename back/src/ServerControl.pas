unit ServerControl;

interface

type
  TServerControl = class
  public
    class procedure StartServer(Port: Integer);
    class procedure StopServer;
    class function VerifyStartingHorse: Boolean;
  end;

implementation

uses
  HorseServer;

class procedure TServerControl.StartServer(Port: Integer);
begin
  THorseServer.StartServer(Port);
end;

class procedure TServerControl.StopServer;
begin
  THorseServer.StopServer;
end;

class function TServerControl.VerifyStartingHorse: Boolean;
begin
  Result := THorseServer.VerifyStartingHorse;
end;

end.

