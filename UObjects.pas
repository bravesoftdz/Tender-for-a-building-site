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
  Vcl.Forms,Vcl.Grids, Vcl.Graphics;
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

procedure readObjFile(const head:TObjAdr);
procedure saveObjFile(const head:TObjAdr);
procedure insertObjList(const head: TObjAdr; tp:string = '1 Float House'; wk:integer = 0; mc:Currency = 0);
procedure writeObjList(Grid:TStringGrid; const head:TObjAdr);
function ObjAdrOf(head: TObjAdr; name: string):TObjAdr;

implementation
uses
 System.SysUtils,Vcl.Dialogs;

const
    ObjFile = 'objects.brakh'; // ���� ��������

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
    if temp^.Info.obType = name then
      Result:=temp;
    temp := temp^.Adr;
  end;
end;

{ ��������� readObjFile ������  �������������� ����, ���� ��� ���, ������� ���
� ��������� ������ �������� �� ����� }

procedure readObjFile(const head:TObjAdr);
var
  f: file of TObjInfo;
  OTemp: TObjAdr;
begin
  AssignFile(f, ObjFile);
  if fileExists(ObjFile) then
  begin
    Reset(f);
    //Writeln('Read file ' + ObjFile);
    OTemp := Head;
    while not EOF(f) do
    begin
      new(OTemp^.adr);
      OTemp:=OTemp^.adr;
      OTemp^.adr:=nil;
      read(f, OTemp^.Info);
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

{ ���������� ������ � �������������� ���� }
procedure saveObjFile(const head:TObjAdr);
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
  Grid.ColCount := 3;
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
    Grid.Cells[2,Grid.RowCount - 1] := CurrToStr(temp^.INFO.MatCost) + ' $';
    temp:=temp^.adr;
    Grid.RowCount := Grid.RowCount + 1;
  end;
  Grid.RowCount := Grid.RowCount - 1;
end;

end.
