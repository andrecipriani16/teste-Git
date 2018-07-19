program Mapa_Vulcao;

uses
  Forms,
  UMenu in 'UMenu.pas' {fmMenu};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMenu, fmMenu);
  Application.Run;
end.
