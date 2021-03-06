{*******************************************************}
{       WORKERS LIBRARY                                 }
{       Lab �2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}
unit UWorkers;

interface
uses
  Vcl.Forms,Vcl.Grids, Vcl.Graphics, Vcl.StdCtrls, UObjects;

type
 {  ***** ������ ������� ������ ***** }
    TWorkersInfo = record    // ���� ����������
      Name: string[30];        // ��� ��������
      Company: string[30];     // ��������, � ������� �� �������� (���������)
      Salary:Currency;         // ��������
      ObjType: TObjTypes;     // ��� �������, ������� �� ����� ����������
    end;
    TWorkAdr = ^TWorkersList;// ������ �� ������ �������
    TWorkersList = record    // ������ �������
      Info: TWorkersInfo;      // ���� ����������
      Adr: TWorkAdr;           // ����� ���� ������� ������
    end;
    {  ***** ������ ������� ����� ***** }


// ��������� � �������
procedure writeWorkList(Grid:TStringGrid; const head:TWorkAdr);
//procedure removeWorkList(var head:TContrAdr; const el:string);
procedure readFromFileWithContractors(const head: TWorkAdr; contr: string; const WorkFile:string);
function insertWorkList(const head: TWorkAdr; const company:string; const Name:string;
        const Salary: Currency;ObjType: TObjTypes):integer;
procedure saveWorkFile(const head:TWorkAdr; const WorkFile:string);
procedure writeSearchWorkListGrid(Grid: TStringGrid;var head:TWorkAdr; fio, comp, obj:string; salary: currency; n1,n2,n3,n4:byte);
procedure removeAllWorkerList(head:TWorkAdr);

implementation

  uses  System.SysUtils,  UContractors;



procedure readFromFileWithContractors(const head: TWorkAdr; contr: string; const WorkFile:string);
var
  f: file of TWorkersInfo;
  Temp: TWorkAdr;
  TInfo: TWorkersInfo;
begin
  AssignFile(f, WorkFile);
  if fileExists(WorkFile) then
  begin
    Reset(f);
    //Writeln('Read file ' + WorkFile);
    Head^.Adr := nil;
    Temp := Head;
    while not EOF(f) do
    begin
      read(f, TInfo);
      if (TInfo.Company = contr) then
      begin
        new(Temp^.adr);
        Temp:=Temp^.adr;
        Temp^.adr:=nil;
        Temp^.Info := TInfo;
      end;
    end;

    close(f);
  end
  else
  begin
    Rewrite(f);
    //Writeln('Create File');
    close(f);
  end;
end;

function insertWorkList(const head: TWorkAdr; const company:string; const Name:string;
        const Salary: Currency;ObjType: TObjTypes):integer;
var
  temp:TWorkAdr;
begin
  //if ObjAdrOf(_new_lab2.ObjHead, ObjType) = nil then

  temp := head;
  while temp^.adr <> nil do
  begin
    temp := temp^.adr;
  end;
  new(temp^.adr);
  temp:=temp^.adr;
  temp^.adr:=nil;
  temp^.Info.Name := name;
  temp^.Info.Company := company;
  temp^.Info.Salary := Salary;
  temp^.Info.ObjType := ObjType;
  Result:= Integer(temp);
end;


procedure writeWorkList(Grid:TStringGrid; const head:TWorkAdr);
var
  temp:TWorkAdr;
begin
  Grid.ColCount := 5;
  Grid.Cells[0,0] := '���';
  Grid.Cells[1,0] := '��������';
  Grid.Cells[2,0] := '��������';
  Grid.Cells[3,0] := '��� �������';

  temp := head^.adr;
  while temp <> nil do
  begin
    Grid.Cells[0,Grid.RowCount - 1] := temp^.INFO.Name;
    Grid.Cells[1,Grid.RowCount - 1] := temp^.Info.Company;
    Grid.Cells[2,Grid.RowCount - 1] := CurrToStr(temp^.INFO.Salary);
    Grid.Cells[3,Grid.RowCount - 1] := writeObjType( temp^.Info.ObjType );
    Grid.Cells[4,Grid.RowCount - 1] := IntToStr( Integer(temp) );
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
  end;
end;

procedure saveWorkFile(const head:TWorkAdr; const WorkFile:string);
var
  f: file of TWorkersInfo;
  temp: TWorkAdr;
begin
  AssignFile(f, WorkFile);
  Reset(f);
  Seek(f,FileSize(f));

  temp := head^.adr;
  while temp <> nil do
  begin
    write(f, temp^.Info);
    temp:=temp^.adr;
  end;
  close(F);
end;

procedure writeSearchWorkListGrid(Grid: TStringGrid;var head:TWorkAdr; fio, comp, obj:string; salary: currency; n1,n2,n3,n4:byte);
var
  temp:TWorkAdr;
  b1,b2,b3,b4: Boolean;
begin
  Grid.ColCount := 5;
  Grid.Cells[0,0] := '���';
  Grid.Cells[1,0] := '��������';
  Grid.Cells[2,0] := '��������';
  Grid.Cells[3,0] := '��� �������';

  temp := head^.adr;
  while temp <> nil do
  begin
    if fio = '' then
      b1 := true
    else
    begin
      case n1 of
        0: b1 := temp^.Info.Name = fio;
        1: b1 := Pos(AnsiUpperCase(fio), AnsiUpperCase(temp^.Info.Name)) > 0;
      end;
    end;
    if comp = '' then
      b2 := true
    else
    begin
      case n2 of
        0: b2 := temp^.Info.Company = comp;
        1: b2 := Pos(AnsiUpperCase(comp), AnsiUpperCase(temp^.Info.Company)) > 0;
      end;

    end;
    if obj = '' then
      b3 := True
    else
    begin
      case n4 of
        0: b3 := temp^.Info.ObjType = getObjType( obj );
        1: b3 := Pos(AnsiUpperCase(obj), AnsiUpperCase(writeObjType( temp^.Info.ObjType))) > 0;
      end;
    end;
    if salary = -1 then
      b4 := True
    else
    begin
      case n3 of
        0: b4 := temp^.Info.Salary = salary;
        1: b4 := temp^.Info.Salary < salary;
        2: b4 := temp^.Info.Salary > salary;
      end;

    end;

    if b1 and b2 and b3 and b4 then
    begin
      Grid.Cells[0,Grid.RowCount - 1] := temp^.INFO.Name;
      Grid.Cells[1,Grid.RowCount - 1] := temp^.Info.Company;
      Grid.Cells[2,Grid.RowCount - 1] := CurrToStr(temp^.INFO.Salary);
      Grid.Cells[3,Grid.RowCount - 1] := writeObjType( temp^.Info.ObjType );
      Grid.Cells[4,Grid.RowCount - 1] := IntToStr( Integer(temp) );
      Grid.RowCount := Grid.RowCount + 1;
    end;
    temp:=temp^.adr;

  end;
end;

procedure removeAllWorkerList(head:TWorkAdr);
var
  temp, temp2: TWorkAdr;
begin
  temp := head^.Adr;
  while temp <> nil do
  begin
    temp2:=temp^.Adr;
    dispose(temp);
    temp:=temp2;
  end;
  head.Adr := nil;
end;
end.
