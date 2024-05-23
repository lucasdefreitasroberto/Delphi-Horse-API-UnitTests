program backend;

uses
  Vcl.Forms,
  Principal in '..\src\Principal.pas' {frmPrincipal},
  Providers.Connection in '..\providers\Providers.Connection.pas' {ProviderConnection: TDataModule},
  services.person in '..\services\services.person.pas' {ServicesPerson: TDataModule},
  uController.Person in '..\controllers\uController.Person.pas',
  utilities in '..\utilities\utilities.pas',
  HorseServer in '..\src\HorseServer.pas',
  ServerControl in '..\src\ServerControl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TProviderConnection, ProviderConnection);
  Application.CreateForm(TServicesPerson, ServicesPerson);
  Application.Run;

end.
