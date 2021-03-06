{*******************************************************}
{       TENDER LIBRARY                                  }
{       Lab �2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}
unit UTender;

interface

uses System.SysUtils, UObjects, UContractors, UWorkers, Vcl.Forms,Vcl.Grids, Vcl.Graphics,Vcl.Dialogs;

type
  TTenderInfo =
  record
    Company: string[30];
    Money: Currency;
    Workers: Integer;
  end;
  TTendAdr = ^TTenderList;
  TTenderList = record
    info: TTenderInfo;
    adr: TTendAdr;
  end;
  TSortMode = function(r1, r2: TTenderInfo): Boolean;
function newTender(var N:integer;var TendHead:TTendAdr; const OHead: TObjAdr;const ContHead: TContrAdr; const obj: string): integer;
procedure writeTendList(Grid:TStringGrid; const head:TTendAdr);
procedure sortTenders(const head:TTendAdr; mode: TSortMode);
procedure removeTender(TendHead: TTendAdr);
function field2sort (r1, r2: TTenderInfo): Boolean;
function field3sort (r1, r2: TTenderInfo): Boolean;

implementation

function newTender(var N:integer;var TendHead:TTendAdr; const OHead: TObjAdr;const ContHead: TContrAdr; const obj: string): integer;
var
  ContTemp: TContrAdr;
  TendTemp: TTendAdr;
  OTemp :  TObjAdr;
  WorkTemp: TWorkAdr;
  Workers:integer;
  Money:Currency;

begin
  Otemp := ObjAdrOfName(OHead, obj);
  N := 0;
  if (Otemp <> nil) then
  begin
    New(TendHead);
    TendHead^.adr := nil;
    TendTemp := TendHead;
    ContTemp := ContHead^.adr;
    Result := 0;
    while ContTemp <> nil do
    begin
      WorkTemp := ContTemp^.WorkersHead;
      Money:= 0;
      Workers := 0;
      while WorkTemp <> nil do
      begin

        if ( (WorkTemp^.Info.ObjType = Otemp^.Info.obType) and (WorkTemp^.Info.Company = ContTemp^.Info.Name)) then
        begin
          inc(Result);
          Inc(Workers);
          Inc(N);
          Money := money + WorkTemp^.Info.Salary;
        end;
        WorkTemp := WorkTemp^.Adr;
      end;
      if Workers >= OTemp.Info.Workers then
      begin
        New(TendTemp.adr);
        TendTemp := TendTemp^.adr;
        TendTemp^.adr := nil;
        TendTemp^.info.Company := ContTemp^.Info.Name;
        TendTemp^.info.Money := money + OTemp.Info.MatCost;
        TendTemp^.info.Workers := Workers;
      end;
      ContTemp:= ContTemp^.adr;
    end;
  end
  else
  begin
    Result := -1;
  end;
end;

function field2sort (r1, r2: TTenderInfo): Boolean;
begin
   Result:= r1.Workers > r2.Workers;
end;

function field3sort (r1, r2: TTenderInfo): Boolean;
begin
   Result:= r1.Money < r2.Money;
end;

procedure sortTenders(const head:TTendAdr; mode: TSortMode);
var
  i:integer;
  temp: TTendAdr;
  temp2: TTendAdr;
  t1:TTendAdr;
begin
  temp := head;
  while temp.adr <> nil do
  begin
    temp2 := temp.adr;
    while temp2.adr <> nil do
    begin
      if (mode(temp2^.Adr.info, temp^.Adr.info)) then
      //
      begin

        t1 := temp2^.adr;
        temp2^.adr := temp^.adr;
        temp^.adr := t1;

        t1 := temp^.adr^.adr;
        temp^.adr^.adr := temp2^.adr.adr;
        temp2^.adr^.adr := t1;

        temp2 := temp;
      end;
      temp2 := temp2^.adr;
    end;
    temp := temp^.adr;
  end;
end;

procedure writeTendList(Grid:TStringGrid; const head:TTendAdr);
var
  temp:TTendAdr;
begin
  //ShowMessage('kek');
  Grid.ColCount := 3;
  Grid.RowCount := 2;
  Grid.Cells[0,0] := '��������';
  Grid.Cells[1,0] := '�������';
  Grid.Cells[2,0] := '���������';
  //Writeln('write tender list');
  temp := head^.adr;
  while temp <> nil do
  begin
    Grid.Cells[0,Grid.RowCount - 1] := temp^.info.Company;
    Grid.Cells[1,Grid.RowCount - 1] := IntToStr(temp^.INFO.Workers);
    Grid.Cells[2,Grid.RowCount - 1] := CurrToStr(temp^.INFO.Money) + ' $';
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;

procedure removeTender(TendHead: TTendAdr);
var
  temp, temp2: TTendAdr;
begin
  temp := TendHead;
  while temp <> nil do
  begin
    temp2:=temp^.adr;
    Dispose(temp);
    temp := temp2;
  end;
end;

end.
