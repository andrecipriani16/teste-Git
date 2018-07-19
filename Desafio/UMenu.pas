unit UMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBClient, StdCtrls, Buttons, ExtCtrls, MidasLib;

type
  Matriz_7x8 = record
   x: integer;
   y: integer;
   versao: Integer;
   tipo: String;
  end;

type
  TipoInfo = (tpLimpo, tpNuvem, tpAeroporto);

  TfmMenu = class(TForm)
    BitBtn2: TBitBtn;
    ScrollBox1: TScrollBox;
    StringGrid1: TStringGrid;
    laInfo: TLabel;
    procedure BitBtn2Click(Sender: TObject);

  private
    { Private declarations }
    function  TipoInfoToStr(const Tipo: TipoInfo): String;

  public
    { Public declarations }
  end;

var
  fmMenu: TfmMenu;

implementation

{$R *.dfm}

{ TfmMenu }



function TfmMenu.TipoInfoToStr(const Tipo: TipoInfo): String;
begin

  case Tipo of
    tpLimpo     : Result := '.';
    tpNuvem     : Result := '*';
    tpAeroporto : Result := 'A';
  end; //

end;


procedure TfmMenu.BitBtn2Click(Sender: TObject);
var
  i, j, c, l: Integer;
  StGrid    : TStringGrid;
  TopAx, VersaoBase, TotalDiasTodosA, TotalAeroportoAux: Integer;

  Matriz: array of array of Matriz_7x8;
  iBase, jBase: Integer;

  FirstDiaAeroFechado, TotalDiaAeroFechado, DiaN: integer;
  mh, mv: Boolean;

begin

  FirstDiaAeroFechado := 0;
  TotalDiaAeroFechado := 0;

  // definir o tamanho
  SetLength(Matriz, 7, 8);

  // Carregar os valores iniciais...
  // Guardar as informações da Matriz_7x8
  for i := 0 to 6 do
    for j := 0 to 7 do begin
      Matriz[i][j].x := i;
      Matriz[i][j].y := j;
      Matriz[i][j].versao := 0; //  0 como default
      Matriz[i][j].tipo := TipoInfoToStr(tpLimpo);
    end; // for j := 1 to 8 do begin

  Matriz[0][2].tipo := TipoInfoToStr(tpNuvem);
  Matriz[0][6].tipo := TipoInfoToStr(tpNuvem);
  Matriz[0][7].tipo := TipoInfoToStr(tpNuvem);
  Matriz[1][1].tipo := TipoInfoToStr(tpNuvem);
  Matriz[1][2].tipo := TipoInfoToStr(tpNuvem);
  Matriz[2][0].tipo := TipoInfoToStr(tpNuvem);
  Matriz[2][2].tipo := TipoInfoToStr(tpNuvem);
  Matriz[2][2].tipo := TipoInfoToStr(tpNuvem);
  Matriz[3][1].tipo := TipoInfoToStr(tpNuvem);
  Matriz[4][1].tipo := TipoInfoToStr(tpNuvem);

  Matriz[2][4].tipo := TipoInfoToStr(tpAeroporto);
  Matriz[2][7].tipo := TipoInfoToStr(tpAeroporto);
  Matriz[4][6].tipo := TipoInfoToStr(tpAeroporto);
  Matriz[5][2].tipo := TipoInfoToStr(tpAeroporto);

  for i := Low(Matriz) to High(Matriz) do
    for j := Low(Matriz[i]) to High(Matriz[i]) do begin
      StringGrid1.Cells[j, i] := Matriz[i][j].tipo;
    end;
  
  TopAx := StringGrid1.Top + StringGrid1.Height + 20;

  TotalDiasTodosA := 4;
  versaoBase      := 0;

  DiaN  := 1;
  iBase := 0;
  jBase := 0;

  while TotalDiasTodosA > 0 do begin
      
    for i := Low(Matriz) to High(Matriz) do begin

      for j := Low(Matriz[i]) to High(Matriz[i]) do begin

        if (Matriz[i][j].tipo = TipoInfoToStr(tpNuvem)) then begin
          //if (Matriz[i][j].versao = VersaoBase) then begin

          // mover pra cima
          l := i - 1;
          //l := iBase - 1;
          //l := Matriz[i][j].x - 1;
          if (l >= 0) and (Matriz[l][j].tipo <> TipoInfoToStr(tpNuvem)) then begin
            Matriz[l][j].x := i;
            Matriz[l][j].y := j;
            Matriz[l][j].tipo := TipoInfoToStr(tpNuvem);
            //Matriz[l][j].versao := Matriz[l][j].versao + 1;
          end; // if (l >= 0) and (Matriz[l][j].tipo <> '*') then begin

          // mover pra direita
          c := j + 1;
          //c := Matriz[i][j].y + 1;
          //if (c < Matriz[i][c].y) and (Matriz[i][c].tipo <> '*') then begin
          if (c < jBase) and (Matriz[i][c].tipo <> TipoInfoToStr(tpNuvem)) then begin
            Matriz[i][c].x := i;
            Matriz[i][c].y := j;
            Matriz[i][c].tipo := TipoInfoToStr(tpNuvem);
            //Matriz[i][c].versao := Matriz[i][c].versao + 1;
          end; // if (l >= 0) and (Matriz[l][j].tipo <> '*') then begin

          // mover pra baixo
          l := i + 1;
          //l := Matriz[i][j].x + 1;
          //if (l < Matriz[l][j].x) and (Matriz[l][j].tipo <> '*') then begin
          if (l < iBase) and (Matriz[l][j].tipo <> TipoInfoToStr(tpNuvem)) then begin
            Matriz[l][j].x := i;
            Matriz[l][j].y := j;
            Matriz[l][j].tipo := TipoInfoToStr(tpNuvem);
            //Matriz[l][j].versao := Matriz[l][j].versao + 1;
          end; // if (l >= 0) and (Matriz[l][j].tipo <> '*') then begin

          // Mover para esquerda
          c := j - 1;
          //c := jBase - 1;
          //c := Matriz[i][j].y - 1;
          if (c >= 0) and (Matriz[i][c].tipo <> TipoInfoToStr(tpNuvem)) then begin
            Matriz[i][c].x := i;
            Matriz[i][c].y := j;
            Matriz[i][c].tipo := TipoInfoToStr(tpNuvem);
            //Matriz[i][c].versao := Matriz[i][c].versao + 1;
          end; // if (l >= 0) and (Matriz[l][j].tipo <> '*') then begin

          //Matriz[i][j].versao := Matriz[i][j].versao + 1;

        end // if (Matriz[i][j].tipo = '*') and (Matriz[i][j].versao = VersaoBase) then begin
        else begin

          iBase := Matriz[i][j].x;
          jBase := Matriz[i][j].y;

        end; // else begin

      end; // for j := Low(Matriz[i]) to High(Matriz[i]) do begin

    end; // for i := Low(Matriz) to High(Matriz) do begin

    StGrid := TStringGrid.Create(nil);
    StGrid.Parent := ScrollBox1;
    StGrid.Name := 'st_' + IntToStr(TopAx);

    StGrid.Top      := TopAx;
    StGrid.Height   := StringGrid1.Height;
    StGrid.ColCount := StringGrid1.ColCount;
    StGrid.RowCount := StringGrid1.RowCount;
    StGrid.Width    := StringGrid1.Width;

    // Lendo
    for i := Low(Matriz) to High(Matriz) do
      for j := Low(Matriz[i]) to High(Matriz[i]) do begin
        StGrid.Cells[j, i] := Matriz[i][j].tipo;
      end; // for j := Low(Matriz[i]) to High(Matriz[i]) do begin

    TopAx := StGrid.Top + StGrid.Height + 20;
  
    Inc(DiaN);

    // buscar o total de Aeroporto aberto...
    TotalAeroportoAux := 0;
    for i := 0 to 6 do begin
      for j := 0 to 7 do begin
        if Matriz[i][j].tipo = TipoInfoToStr(tpAeroporto) then
          Inc(TotalAeroportoAux);
      end; // for j := 0 to 7 do begin
    end; // for i := 0 to 6 do begin

    if TotalDiasTodosA <> TotalAeroportoAux then
      if FirstDiaAeroFechado <= 0 then
        FirstDiaAeroFechado := DiaN;

    TotalDiasTodosA := TotalAeroportoAux;

    if TotalDiasTodosA = 0 then
      TotalDiaAeroFechado := DiaN;

    Inc(VersaoBase);
    
    // Pra testes...
    if VersaoBase = 10 then
      Break;

 end; //  while TotalDiasTodosA > 0 do begin


 laInfo.Caption := '1º Aeroporto fechado em ' + IntToStr(FirstDiaAeroFechado) + ' dias.' + #13 +
                   'Todos os Aeroportos fechados no dia ' + IntToStr(TotalDiaAeroFechado);


end;

end.
