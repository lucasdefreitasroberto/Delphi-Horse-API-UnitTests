unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.Menus, ShellApi,
  ServerControl;

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
    procedure trycnDblClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnUrlClick(Sender: TObject);
    procedure appEventMinimize(Sender: TObject);
  private
    procedure OpenAppMinimized;
    procedure MinimizeApp;
  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

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

procedure TfrmPrincipal.appEventMinimize(Sender: TObject);
begin
  MinimizeApp();
end;

procedure TfrmPrincipal.btnStartClick(Sender: TObject);
begin
  if not TServerControl.VerifyStartingHorse then
  begin
    TServerControl.StartServer(9000);
    btnStart.Caption := 'Pause';
    pnlStatus.Caption := 'Server running on port 9000';
    btnUrl.Enabled := True;
    btnUrl.Visible := True;
  end
  else
  begin
    TServerControl.StopServer;
    btnStart.Caption := 'Start';
    pnlStatus.Caption := 'Server paused';
    btnUrl.Enabled := False;
    btnUrl.Visible := False;
  end;
end;

procedure TfrmPrincipal.btnUrlClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://localhost:9000/', nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TfrmPrincipal.SairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.trycnDblClick(Sender: TObject);
begin
  OpenAppMinimized();
end;

procedure TfrmPrincipal.AbrirClick(Sender: TObject);
begin
  OpenAppMinimized();
end;

end.

