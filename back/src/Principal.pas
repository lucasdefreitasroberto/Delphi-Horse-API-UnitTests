unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Horse, Horse.CORS, Horse.Jhonson,
  System.JSON, Vcl.AppEvnts, Vcl.Menus, Providers.Connection, ShellApi;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    btnUrl: TBitBtn;
    btnStart: TButton;
    pnlTitle: TPanel;
    pnlStatus: TPanel;
    pm: TPopupMenu;
    Abrir: TMenuItem;
    Sair: TMenuItem;
    appEvent: TApplicationEvents;
    trycn: TTrayIcon;
    procedure SairClick(Sender: TObject);
    procedure AbrirClick(Sender: TObject);
    procedure appEventMinimize(Sender: TObject);
    procedure trycnDblClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnUrlClick(Sender: TObject);
  private
    procedure OpenAppMinimized;
    procedure MinimizeApp;
    procedure ConfigureMiddlewares;
    procedure RegisterRoutes;
    procedure StartServer;
    procedure StopServer;
  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uController.Person;

{$R *.dfm}
{ TfrmPrincipal }

procedure TfrmPrincipal.OpenAppMinimized;
begin
  trycn.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TfrmPrincipal.MinimizeApp;
begin
  Hide;
  WindowState := wsMaximized;
  trycn.Visible := True;
  trycn.Animate := True;
  trycn.ShowBalloonHint;
end;

procedure TfrmPrincipal.btnStartClick(Sender: TObject);
begin
  if (THorse.IsRunning = False) then
  begin
    THorse.Listen(9000);
    Self.ConfigureMiddlewares();
    Self.RegisterRoutes();
    Self.StartServer();
  end
  else
    Self.StopServer();
end;

procedure TfrmPrincipal.btnUrlClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://localhost:9000/', nil, nil,
    SW_SHOWMAXIMIZED);
end;

procedure TfrmPrincipal.ConfigureMiddlewares;
begin
  THorse.Use(Jhonson());
  THorse.Use(CORS);
end;

procedure TfrmPrincipal.RegisterRoutes;
begin
  THorse.Get('/',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('<h4>API running.</h4>');
    end);

  uController.Person.Registry;
end;

procedure TfrmPrincipal.SairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.StartServer;
begin
  if not THorse.IsRunning then
    Exit;

  THorse.IsRunning;

  btnStart.Caption := 'Pause';
  pnlStatus.Caption := 'Server running on port ' + THorse.Port.ToString;
  btnUrl.Enabled := True;
  btnUrl.Visible := True;
end;

procedure TfrmPrincipal.StopServer;
begin
  THorse.StopListen;

  btnStart.Caption := 'Start';
  pnlStatus.Caption := 'Server paused';
  btnUrl.Enabled := False;
  btnUrl.Visible := False;
end;

procedure TfrmPrincipal.trycnDblClick(Sender: TObject);
begin
  Self.OpenAppMinimized();
end;

procedure TfrmPrincipal.AbrirClick(Sender: TObject);
begin
  Self.OpenAppMinimized();
end;

procedure TfrmPrincipal.appEventMinimize(Sender: TObject);
begin
  Self.MinimizeApp();
end;

end.
