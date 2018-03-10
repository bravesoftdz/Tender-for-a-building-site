{*******************************************************}
{       OBJECTS LIBRARY                                 }
{       Lab �2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}
unit UObjects;

interface
uses
  Vcl.Forms,Vcl.Grids, Vcl.Graphics,Vcl.Dialogs, Vcl.StdCtrls;
type
  { *** ������ �������� ������ *** }
  TObjInfo = record    // ���� ����������
    obType:string[30];  // ��� �������
    Workers:integer;    // ����������� ���������� �������
    MatCost:Currency;   // ��������� ����������
  end;
  TObjAdr = ^TObjList; // ������ �� ������ ��������
  TObjList = record    // ������ ��������
    Info: TObjInfo;
    Adr: TObjAdr;
  end;
  { *** ������ �������� �����  *** }

// ��������� � �������
procedure getCBBObjectsList(CBB: TComboBox; const head: TObjAdr);
procedure readObjFile(const head:TObjAdr; ObjFile:string);
procedure saveObjFile(const head:TObjAdr; ObjFile:string);
procedure removeObjList(var head:TObjAdr; const el:string);
procedure insertObjList(const head: TObjAdr; tp:string = '1 Float House'; wk:integer = 0; mc:Currency = 0);
procedure writeObjList(Grid:TStringGrid; const head:TObjAdr);
function ObjAdrOf(head: TObjAdr; name: string):TObjAdr;
procedure editObjList(head:TObjAdr; name:string; newname:string; newwork: integer; newmoney: Currency );
procedure searchObjList(head:TObjAdr;Grid:TStringGrid;obj:string; minwork: integer; money: Currency; n1,n2,n3:integer);
procedure removeAllObjList(head:TObjAdr);

implementation
uses
 System.SysUtils, tender;

//const
    //ObjFile = 'objects.brakh'; // ���� ��������

{ ������� ObjAdrOf ���������� ����� �������� ������ � ������ ����� name
  ���� �������� �� �������, ������������ nil }
function ObjAdrOf(head: TObjAdr; name: string):TObjAdr;
var
  temp: TObjAdr;
begin

  temp := head;
  Result := nil;
  while(temp <> nil) do
  begin
    //ShowMessage(name + ' / ' + temp^.Info.obType);
    if temp^.Info.obType = name then
      Result:=temp;
    temp := temp^.Adr;
  end;
end;

{ ��������� readObjFile ������  �������������� ����, ���� ��� ���, ������� ���
� ��������� ������ �������� �� ����� }

procedure readObjFile(const head:TObjAdr; ObjFile:string);
var
  f: file of TObjInfo;
  OTemp: TObjAdr;
begin
  AssignFile(f, ObjFile);
  if fileExists(ObjFile) then
  begin
    Reset(f);
    //ShowMessage(objfile);
    //Writeln('Read file ' + ObjFile);
    OTemp := Head;
    head^.Adr := nil;
    while not EOF(f) do
    begin
      new(OTemp^.adr);
      OTemp:=OTemp^.adr;
      OTemp^.adr:=nil;

      read(f, OTemp^.Info);
      //ShowMessage(otemp^.Info.obType);
      //OTemp^.Info

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

// ���������� ������ � �������������� ���� }
procedure saveObjFile(const head:TObjAdr; ObjFile:string);
var
  f: file of TObjInfo;
  temp: TObjAdr;
begin
  AssignFile(f, ObjFile);
  rewrite(f);
  temp := head^.adr;
  while temp <> nil do
  begin
    write(f, temp^.Info);
    temp:=temp^.adr;
  end;
  close(F);
end;

{ ������� �������� � ����� ������}
procedure insertObjList(const head: TObjAdr; tp:string = '1 Float House'; wk:integer = 0; mc:Currency = 0);
var
  temp:TObjAdr;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp := temp^.adr;
  end;
  new(temp^.adr);
  temp:=temp^.adr;
  temp^.adr:=nil;
  temp^.Info.obType := tp;
  temp^.Info.Workers := wk;
  temp^.Info.MatCost := mc;
end;

procedure writeObjList(Grid:TStringGrid; const head:TObjAdr);
var
  temp:TObjAdr;
begin
  Grid.ColCount := 4;
  Grid.RowCount := 2;
  Grid.Font.Color:= clWhite;
  Grid.Cells[0,0] := '��� �������';
  Grid.Cells[1,0] := '���. ���-�� �������';
  Grid.Cells[2,0] := '��������� ����������';
  Grid.Font.Color:= clBlack;
  //ShowMessage('kek');
  temp := head^.adr;
  while temp <> nil do
  begin
    Grid.Cells[0,Grid.RowCount - 1] := temp^.INFO.obType;
    Grid.Cells[1,Grid.RowCount - 1] := IntToStr(temp^.INFO.Workers);
    Grid.Cells[2,Grid.RowCount - 1] := CurrToStr(temp^.INFO.MatCost);
    Grid.Cells[3,Grid.RowCount - 1] := '�������';
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;

procedure getCBBObjectsList(CBB: TComboBox; const head: TObjAdr);
var
  temp:TObjAdr;
begin
  CBB.Clear;
  CBB.Text := '������� ������';
  temp := head^.adr;
  while temp <> nil do
  begin
    CBB.Items.Add(temp^.Info.obType);
    temp:=temp^.adr;
  end;
end;

procedure removeObjList(var head:TObjAdr; const el:string);
var
  temp,temp2:TObjAdr;
begin
  temp := head;
  while temp^.adr <> nil do
  begin
    temp2 := temp^.adr;
    if temp2^.Info.obType = el then
    begin
      temp^.adr := temp2^.adr;
      dispose(temp2);
    end
    else
      temp:= temp^.adr;
  end;
end;

procedure editObjList(head:TObjAdr; name:string; newname:string; newwork: integer; newmoney: Currency );
var
  temp:TObjAdr;
  flag: boolean;
begin
  temp:= head;
  flag := true;
  while (temp <> nil) and flag do
  begin
    if temp.Info.obType = name then
    begin
      temp.Info.obType := newname;
      temp.Info.Workers := newwork;
      temp.Info.MatCost := newmoney;
      flag := false;
    end;
    temp := temp^.Adr;
  end;
end;

procedure searchObjList(head:TObjAdr;Grid:TStringGrid;obj:string; minwork: integer; money: Currency; n1,n2,n3:integer);
var
  b1,b2,b3:Boolean;
  temp:TObjAdr;
begin
  Grid.ColCount := 4;
  Grid.RowCount := 2;
  Grid.Cells[0,0] := '��� �������';
  Grid.Cells[1,0] := '���. ���-�� �������';
  Grid.Cells[2,0] := '��������� ����������';
  temp:=head;
  while temp <> nil do
  begin
    if obj = '' then
      b1 := true
    else
    begin
      if n1 = 0 then
        b1 := temp^.Info.obType = obj
      else
      begin
        b1 := Pos(AnsiUpperCase(obj),AnsiUpperCase(temp^.Info.obType)) > 0;
      end;

    end;
    if minwork = -1 then
      b2 := True
    else
    begin
      b2 := temp^.Info.Workers = minwork;
      case n2 of
        0: b2 := temp^.Info.Workers = minwork;
        1: b2 := temp^.Info.Workers < minwork;
        2: b2 := temp^.Info.Workers > minwork;
      end;
    end;
    if money = -1 then
      b3:= True
    else
    begin
      case n3 of
        0: b3 := temp^.Info.MatCost = money;
        1: b3 := temp^.Info.MatCost < money;
        2: b3 := temp^.Info.MatCost > money;
      end;
    end;

    if b1 and b2 and b3 then
    begin
      Grid.Cells[0,Grid.RowCount - 1] := temp^.INFO.obType;
      Grid.Cells[1,Grid.RowCount - 1] := IntToStr(temp^.INFO.Workers);
      Grid.Cells[2,Grid.RowCount - 1] := CurrToStr(temp^.INFO.MatCost);
      Grid.Cells[3,Grid.RowCount - 1] := '�������';
      Grid.RowCount := Grid.RowCount + 1;
    end;

    temp:= temp^.Adr;
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;
procedure removeAllObjList(head:TObjAdr);
var
  temp, temp2: tobjadr;
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
