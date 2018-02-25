{*******************************************************}
{       CONTRACTORS LIBRARY                             }
{       Lab �2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}
unit UContractors;

interface
uses UWorkers, Vcl.Forms,Vcl.Grids, Vcl.Graphics,Vcl.Dialogs;
type
  { *** ������ ����������� ������ *** }
  TContractorsInfo = record  // ���� ����������
    Name:string[30];            // �������� ����������
  end;
  TContrAdr = ^ TContractorsList; // ������ �� ������ �����������
  TContractorsList = record  // ������ �����������
    Info: TContractorsInfo;    // ���� ����������
    WorkersHead: TWorkAdr;     // ������ �� ������ ������ ������� ���� ��������
    Adr: TContrAdr;            // ����� ����. �������� � ������
  end;
  { *** ������ ����������� ����� *** }

// ��������� � �������
procedure readContrFile(const head:TContrAdr);
procedure saveContrFile(const head:TContrAdr);
procedure insertContrList(const head: TContrAdr; name:string);
procedure writeContrList(Grid: TStringGrid;var head:TContrAdr);
procedure insertWorkListFromCompany(const head: TContrAdr; const company:string; const Name:string;
        const Salary: Currency = 0; const ObjType: string = '1 Float House');
function ContrAdrOf(const head: TContrAdr; name: string):TContrAdr;
procedure writeWorkListWithContr(Grid: TStringGrid;var head:TContrAdr; const company:string);
procedure writeAllWorkListWithContr(Grid: TStringGrid;var head:TContrAdr);

implementation
uses
  System.SysUtils;
const
  ContrFile = 'contractors.brakh';

{ ������� ContrAdrOf ���������� ����� �������� ������ � ������ ����� name
  ���� �������� �� �������, ������������ nil }
function ContrAdrOf(const head: TContrAdr; name: string):TContrAdr;
var
  temp: TContrAdr;
begin
  temp := head;
  Result := nil;
  while(temp <> nil) do
  begin
    if temp^.Info.Name = name then
      Result:=temp;
    temp := temp^.Adr;
  end;
end;

{ ������ �� ��������������� ����� ������ � ������� ������ }
procedure readContrFile(const head:TContrAdr);
var
  f: file of TContractorsInfo;
  Temp: TContrAdr;
begin
  AssignFile(f, ContrFile);
  if fileExists(ContrFile) then
  begin
    Reset(f);
    //Writeln('Read file ' + ContrFile);
    Temp := Head;
    while not EOF(f) do
    begin
      new(Temp^.adr);
      Temp:=Temp^.adr;
      Temp^.adr:=nil;
      read(f, Temp^.Info);
      new(Temp^.WorkersHead);
      Temp^.WorkersHead.Adr := nil;
      readFromFileWithContractors(temp^.WorkersHead, temp^.Info.Name);
      // ������ �� ����� ���������� ����������
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

{ ��������� ������ � �������������� ����}
procedure saveContrFile(const head:TContrAdr);
var
  f: file of TContractorsInfo;
  f2: file of TWorkersInfo;
  temp: TContrAdr;
begin
  AssignFile(f2, WorkFile);
  Rewrite(f2);
  Close(f2);
  AssignFile(f, ContrFile);
  rewrite(f);
  temp := head^.adr;
  while temp <> nil do
  begin
    write(f, temp^.Info);
    saveWorkFile(temp^.WorkersHead);
    temp:=temp^.adr;
  end;
  close(F);
end;

procedure insertContrList(const head: TContrAdr; name:string);
var
  temp:TContrAdr;
begin
  if (ContrAdrOf(head,name) = nil) then
  begin
    temp := head;
    while temp^.adr <> nil do
    begin
      temp := temp^.adr;
    end;
    new(temp^.adr);
    temp:=temp^.adr;
    temp^.adr:=nil;
    temp^.Info.Name := name;
    New(temp^.WorkersHead);
    temp^.WorkersHead.Adr := nil;

  end
  else
    ShowMessage('The company is already registered');
end;

procedure writeContrList(Grid: TStringGrid;var head:TContrAdr);
var
  temp:TContrAdr;
begin
  Grid.ColCount := 2;
  Grid.RowCount := 2;
  Grid.Cells[0,0] := '��������';
  Grid.Cells[1,0] := '';
  temp := head^.adr;
  while temp <> nil do
  begin
    Grid.Cells[0,Grid.RowCount - 1] := temp^.INFO.Name;
    Grid.Cells[1,Grid.RowCount - 1] := '�������� �����������';
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
    {writeln(temp^.INFO.Name);
    writeWorkList(temp^.WorkersHead);  // �� ����� UWORKERS
    temp:=temp^.adr; }
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;

procedure insertWorkListFromCompany(const head: TContrAdr; const company:string; const Name:string;
        const Salary: Currency = 0; const ObjType: string = '1 Float House');
var
  temp:TContrAdr;
begin
  temp := head;
  while temp <> nil do
  begin
    if (temp^.Info.Name = company) then
    begin
      insertWorkList(temp^.WorkersHead, company, Name, Salary, ObjType);
      Exit;
    end;
    temp:=temp^.Adr;
  end;
  ShowMessage('Company not found');
end;


procedure writeWorkListWithContr(Grid: TStringGrid;var head:TContrAdr; const company:string);
var
  temp:TContrAdr;
begin
  Grid.RowCount := 2;
  temp := head^.adr;
  while temp <> nil do
  begin

    if temp^.Info.Name = company then
    begin
      WriteWorkList(Grid, temp^.WorkersHead);
      Grid.RowCount := Grid.RowCount - 1;
      exit;
    end;
    temp := temp^.Adr;
  end;

end;

procedure writeAllWorkListWithContr(Grid: TStringGrid;var head:TContrAdr);
var
  temp:TContrAdr;
begin
  Grid.RowCount := 2;
  temp := head^.adr;
  while temp <> nil do
  begin
    WriteWorkList(Grid, temp^.WorkersHead);
    temp := temp^.Adr;
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;

end.
