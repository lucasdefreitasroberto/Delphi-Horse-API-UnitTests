program backend;

uses
  Vcl.Forms,
  Main in '..\src\Main.pas' {frmPrincipal},
  Providers.Connection in '..\providers\Providers.Connection.pas' {ProviderConnection: TDataModule},
  services.person in '..\services\services.person.pas' {ServicesPerson: TDataModule},
  uController.Person in '..\controllers\uController.Person.pas',
  horse.server in '..\src\horse.server.pas',
  server.control in '..\src\server.control.pas',
  middleware.global in '..\middleware\middleware.global.pas',
  utilities in '..\classes\utilities.pas',
  Person in '..\classes\Person.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TProviderConnection, ProviderConnection);
  Application.CreateForm(TServicesPerson, ServicesPerson);
  Application.Run;

end.
