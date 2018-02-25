{*******************************************************}
{       TENDER LIBRARY                                  }
{       Lab �2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}
unit UTender;

interface
uses System.SysUtils, UObjects, UContractors, UWorkers;

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
procedure newTender(var N:integer;var TendHead:TTendAdr; const OHead: TObjAdr;const ContHead: TContrAdr; const obj: string);
procedure writeTendList(const head:TTendAdr);
procedure sortTenders(const head:TTendAdr);

implementation

procedure newTender(var N:integer;var TendHead:TTendAdr; const OHead: TObjAdr;const ContHead: TContrAdr; const obj: string);
var
  ContTemp: TContrAdr;
  TendTemp: TTendAdr;
  OTemp :  TObjAdr;
  WorkTemp: TWorkAdr;
  Workers:integer;
  Money:Currency;
begin
  Otemp := ObjAdrOf(OHead, obj);
  N := 0;
  if (Otemp <> nil) then
  begin
    New(TendHead);
    TendHead^.adr := nil;
    TendTemp := TendHead;
    ContTemp := ContHead^.adr;
    while ContTemp <> nil do
    begin
      WorkTemp := ContTemp^.WorkersHead;

      Money:= 0;
      Workers := 0;
      while WorkTemp <> nil do
      begin
        if ( (WorkTemp^.Info.ObjType = obj) and (WorkTemp^.Info.Company = ContTemp^.Info.Name)) then
        begin
          Inc(Workers);
          Inc(N);
          Money := money + WorkTemp^.Info.Salary;
        end;
        WorkTemp := WorkTemp^.Adr;
      end;
      if Workers <> 0 then
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
    writeln('Object not found');
  end;
end;

procedure sortTenders(const head:TTendAdr);
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
      if (temp2.adr^.info.Money < temp.adr^.info.Money) then
      begin

        t1 := temp2^.adr;
        temp2^.adr := temp^.adr;
        temp^.adr := t1;

        t1 := temp^.adr^.adr;
        temp^.adr^.adr := temp2^.adr.adr;
        temp2^.adr^.adr := t1;
        Writeln('kek');
        temp2 := temp;
      end;
      temp2 := temp2^.adr;
    end;
    temp := temp^.adr;
  end;
end;

procedure writeTendList(const head:TTendAdr);
var
  temp:TTendAdr;
begin
  Writeln('write tender list');
  temp := head^.adr;
  while temp <> nil do
  begin
    writeln(temp^.info.Company);
    writeln(temp^.INFO.Workers);
    writeln(CurrToStr(temp^.INFO.Money));
    temp:=temp^.adr;
  end;
end;

end.
