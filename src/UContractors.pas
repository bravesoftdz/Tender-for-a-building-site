{*******************************************************}
{       CONTRACTORS LIBRARY                             }
{       Lab �2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}
unit UContractors;

interface
uses UWorkers, Vcl.Forms,Vcl.Grids, Vcl.Graphics,Vcl.Dialogs, Vcl.StdCtrls, UObjects;
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
procedure readContrFile(const head:TContrAdr; const ContrFile, WorkFile: string);
function WorkerAdrOf(const head:TContrAdr; const name:string; const comp:string):TWorkAdr;
procedure removeWorkList(var head:TContrAdr; const intadr:integer); overload;
//procedure removeWorkList(var head:TContrAdr; const obj:string); overload;
procedure editContrList(head:TContrAdr; name:string; newname:string);
procedure removeContrList(var head:TContrAdr; const el:string);
procedure saveContrFile(const head:TContrAdr; const ContrFile, WorkFile: string);
procedure insertContrList(const head: TContrAdr; name:string);
procedure writeContrList(Grid: TStringGrid;var head:TContrAdr);
function insertWorkListFromCompany(const head: TContrAdr; const company:string; const Name:string;
        const Salary: Currency; const ObjType: TObjTypes):integer;
function ContrAdrOf(const head: TContrAdr; name: string):TContrAdr;
procedure writeWorkListWithContr(Grid: TStringGrid;var head:TContrAdr; const company:string);
procedure writeAllWorkListWithContr(Grid: TStringGrid;var head:TContrAdr);
procedure getCBBContrList(CBB: TComboBox; const head: TContrAdr);
procedure editWorkList(const head:TContrAdr; const intadr: integer; const newname, newcomp: string; newobj:TObjTypes; const newsalary: Currency); overload;
procedure editWorkList(const head:TWorkAdr; newcompany:string); overload;
procedure searchContrList(head: TContrAdr; Grid:TStringGrid; name:string; n1:byte);
procedure searchWorkerList(Grid: TStringGrid;var head:TContrAdr; fio, comp, obj:string; salary: currency; n1,n2,n3,n4:byte);
procedure removeAllContrList(head: TContrAdr);
procedure removeOnlyAllWorkers(const head:TContrAdr);
procedure readOnlyWorkers(const head:TContrAdr; WorkFile:string);

implementation
uses
  System.SysUtils;


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
procedure readContrFile(const head:TContrAdr; const ContrFile, WorkFile: string);
var
  f: file of TContractorsInfo;
  Temp: TContrAdr;
begin
  AssignFile(f, ContrFile);
  if fileExists(ContrFile) then
  begin
    Reset(f);
    //Writeln('Read file ' + ContrFile);
    Head^.Adr := nil;
    head^.WorkersHead := nil;
    Temp := Head;
    while not EOF(f) do
    begin
      new(Temp^.adr);
      Temp:=Temp^.adr;
      Temp^.adr:=nil;
      read(f, Temp^.Info);
      new(Temp^.WorkersHead);
      Temp^.WorkersHead.Adr := nil;
      readFromFileWithContractors(temp^.WorkersHead, temp^.Info.Name, WorkFile);
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
procedure saveContrFile(const head:TContrAdr; const ContrFile, WorkFile: string);
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
    saveWorkFile(temp^.WorkersHead, WorkFile);
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
  Grid.ColCount := 3;
  Grid.RowCount := 2;
  Grid.Cells[0,0] := '��������';
  Grid.Cells[1,0] := '';
  Grid.Cells[2,0] := '';

  temp := head^.adr;

  while temp <> nil do
  begin
    Grid.Cells[0,Grid.RowCount - 1] := temp^.INFO.Name;
    Grid.Cells[1,Grid.RowCount - 1] := '�������� �����������';
    Grid.Cells[2,Grid.RowCount - 1] := '�������';
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
    {writeln(temp^.INFO.Name);
    writeWorkList(temp^.WorkersHead);  // �� ����� UWORKERS
    temp:=temp^.adr; }
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;

function insertWorkListFromCompany(const head: TContrAdr; const company:string; const Name:string;
        const Salary: Currency; const ObjType: TObjTypes):integer;
var
  temp:TContrAdr;
begin
  temp := head^.adr;
  while temp <> nil do
  begin
    //ShowMessage();
    if (temp^.Info.Name = company) then
    begin
      Result := insertWorkList(temp^.WorkersHead, company, Name, Salary, ObjType);
      Exit;
    end;
    temp:=temp^.Adr;
  end;
  ShowMessage('Company not found' + company);
end;


procedure writeWorkListWithContr(Grid: TStringGrid;var head:TContrAdr; const company:string);
var
  temp:TContrAdr;
  flag:boolean;
begin
  Grid.RowCount := 2;
  temp := head^.adr;
  flag:=true;
  while (temp <> nil) and flag do
  begin

    if temp^.Info.Name = company then
    begin
      WriteWorkList(Grid, temp^.WorkersHead);
      Grid.RowCount := Grid.RowCount - 1;
      flag := false;
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

procedure getCBBContrList(CBB: TComboBox; const head: TContrAdr);
var
  temp:TContrAdr;
begin
  CBB.Clear;
  CBB.Text := '������� ��������';
  temp := head^.adr;
  while temp <> nil do
  begin
    CBB.Items.Add(temp^.Info.Name);
    temp:=temp^.adr;
  end;
end;

procedure removeContrList(var head:TContrAdr; const el:string);
var
  temp,temp2:TContrAdr;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp2 := temp^.adr;
    if temp2^.Info.Name = el then
    begin
      temp^.adr := temp2^.adr;
      dispose(temp2);
    end
    else
      temp:= temp^.adr;
  end;
end;

procedure removeWorkList(var head:TContrAdr; const intadr:integer);
var
  t:TContrAdr;
  temp,temp2:TWorkAdr;
begin
  t:=head^.Adr;
  while t <> nil do
  begin
    temp := t.WorkersHead;
    while temp^.adr <> nil do
    begin
      temp2 := temp^.adr;
      if Integer(temp2) = intadr then
      begin
        temp^.adr := temp2^.adr;
        dispose(temp2);
      end
      else
        temp:= temp^.adr;
    end;
    t:=t^.Adr;
  end;
end;

function WorkerAdrOf(const head:TContrAdr; const name:string; const comp:string):TWorkAdr;
var
  t:TContrAdr;
  temp:TWorkAdr;
  flag:boolean;
begin
  t:=head^.Adr;
  Result := nil;
  flag := true;
  while (t <> nil) and flag do
  begin
    temp := t.WorkersHead;
    while (temp <> nil) and flag do
    begin
      if (temp^.Info.Name = name) and (temp^.Info.Company= comp) then
      begin
        Result := temp;
        flag := false;
      end;

      temp:= temp^.adr;
    end;
    t:=t^.Adr;
  end;
end;

procedure editContrList(head:TContrAdr; name:string; newname:string);
var
  temp:TContrAdr;
  flag: boolean;
begin
  temp:= head;
  flag := true;
  while (temp <> nil) and flag do
  begin
    if temp.Info.Name = name then
    begin
      temp.Info.Name := newname;
      flag := false;
    end;
    temp := temp^.Adr;
  end;
end;

procedure editWorkList(const head:TContrAdr; const intadr: integer; const newname, newcomp: string; newobj:TObjTypes; const newsalary: Currency);
var
  t:TContrAdr;
  temp:TWorkAdr;
  flag: Boolean;
begin
  t:=head^.Adr;
  flag := true;
  while (t <> nil) and flag do
  begin
    temp := t.WorkersHead;
    while (temp <> nil) and flag do
    begin
      if (Integer(temp) = intadr) then
      begin
        temp^.Info.Name := newname;
        temp^.Info.Company := newcomp;
        temp^.Info.Salary := newsalary;
        temp^.Info.ObjType := newobj;
        flag := false;
      end;

      temp:= temp^.adr;
    end;
    t:=t^.Adr;
  end;
end;
procedure editWorkList(const head:TWorkAdr; newcompany:string);
var
  Temp:TWorkAdr;
begin
  temp := head;
  while temp <> nil do
  begin
    Temp^.Info.Company := newcompany;
    Temp := Temp^.Adr;
  end;
end;

{procedure removeWorkList(var head:TContrAdr; const obj:string);
var
  t:TContrAdr;
  temp,temp2:TWorkAdr;
begin
  t:=head^.Adr;
  while t <> nil do
  begin
    temp := t.WorkersHead;
    while temp^.adr <> nil do
    begin
      temp2 := temp^.adr;
      if temp2.Info.ObjType = obj then
      begin
        temp^.adr := temp2^.adr;
        dispose(temp2);
      end
      else
        temp:= temp^.adr;
    end;
    t:=t^.Adr;
  end;
end;  }

procedure searchContrList(head: TContrAdr; Grid:TStringGrid; name:string; n1:byte);
var
  temp: TContrAdr;
  b1: Boolean;
begin
  Grid.ColCount := 3;
  Grid.RowCount := 2;
  Grid.Cells[0,0] := '��������';
  Grid.Cells[1,0] := '';
  Grid.Cells[2,0] := '';
  temp := head^.adr;
  while temp <> nil do
  begin
    if name = '' then
      b1 := true
    else
    begin
      case n1 of
        0: b1 := temp^.Info.Name = name;
        1: b1 := Pos(AnsiUpperCase(name),AnsiUpperCase(temp^.Info.Name)) > 0;
      end;

    end;
    if (b1) then
    begin
      Grid.Cells[0,Grid.RowCount - 1] := temp^.INFO.Name;
      Grid.Cells[1,Grid.RowCount - 1] := '�������� �����������';
      Grid.Cells[2,Grid.RowCount - 1] := '�������';
      Grid.RowCount := Grid.RowCount + 1;
    end;
    temp:=temp^.adr;

  end;
  Grid.RowCount := Grid.RowCount - 1;
end;

procedure searchWorkerList(Grid: TStringGrid;var head:TContrAdr; fio, comp, obj:string; salary: currency; n1,n2,n3,n4:byte);
var
  temp:TContrAdr;
begin
  Grid.RowCount := 2;
  temp := head^.adr;
  while temp <> nil do
  begin
    writeSearchWorkListGrid(Grid, temp^.WorkersHead, fio, comp, obj, salary,n1,n2,n3,n4);
    temp := temp^.Adr;
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;

procedure removeAllContrList(head: TContrAdr);
var
  temp, temp2: TContrAdr;
begin
  temp := head^.Adr;
  while temp <> nil do
  begin
    temp2:=temp^.Adr;
    //ShowMessage(temp^.Info.Name);
    dispose(temp);
    removeAllWorkerList(temp.WorkersHead);
    temp:=temp2;
  end;
  head.Adr := nil;
end;

procedure removeOnlyAllWorkers(const head:TContrAdr);
var
temp:TContrAdr;
begin
  temp := head^.adr;
  while temp <> nil do
  begin
    // ShowMessage(temp^.Info.Name);
    removeAllWorkerList(temp.WorkersHead);
    temp := temp^.Adr;
  end;
end;

procedure readOnlyWorkers(const head:TContrAdr; WorkFile:string);
var
temp:TContrAdr;
begin
  temp := head^.adr;
  while temp <> nil do
  begin
    readFromFileWithContractors(temp^.WorkersHead, temp^.Info.Name, WorkFile);
    temp := temp^.Adr;
  end;
end;


end.
