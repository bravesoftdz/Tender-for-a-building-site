{*******************************************************}
{                                                       }
{       Lab �2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}

program _new_lab2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

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

  { *** ������ ����������� ������ *** }

    {  ***** ������ ������� ������ ***** }
    TWorkersInfo = record    // ���� ����������
      Name: string[30];        // ��� ��������
      Company: string[30];     // ��������, � ������� �� �������� (���������)
      Salary:Currency;         // ��������
      ObjType: string[30];     // ��� �������, ������� �� ����� ����������
    end;
    TWorkAdr = ^TWorkersList;// ������ �� ������ �������
    TWorkersList = record    // ������ �������
      Info: TWorkersInfo;      // ���� ����������
      Adr: TWorkAdr;           // ����� ���� ������� ������
    end;
    {  ***** ������ ������� ����� ***** }

  TContractorsInfo = record  // ���� ����������
    Name:string[30];            // �������� ����������
  end;
  TContrAdr = ^ TContractorsList; // ������ �� ������ �����������
  TContractorsList = record  // ������ �����������
    Info: TContractorsInfo;    // ���� ����������
    WorkersHead: TWorkAdr;     // ������ �� ������ ������ ������� ���� ��������
    Adr: TContrAdr             // ����� ����. �������� � ������
  end;
  { *** ������ ����������� ����� *** }
  const
    ObjFile = 'objects.brakh'; // ���� ��������
    WorkFile = 'workers.brakh'; // ���� ��������
    ContrFile = 'contractors.brakh'; // ���� ��������
var
  ObjHead:TObjAdr;
  //TObjects



procedure readObjFile;
var
  f: file of TObjInfo;
  OTemp: TObjAdr;
begin
  AssignFile(f, ObjFile);
  if fileExists(ObjFile) then
  begin
    Reset(f);
    Writeln('Read file');
    OTemp := ObjHead;
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
    Writeln('Create File');
    close(f);
  end;

end;

procedure saveObjFile(var head:TObjAdr);
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

procedure insertObjList(var head: TObjAdr; tp:string = '1 Float House'; wk:integer = 0; mc:Currency = 0);
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

procedure writeList(var head:TObjAdr);
var
  temp:TObjAdr;
begin
  temp := head^.adr;
  while temp <> nil do
  begin
    writeln(temp^.INFO.obType);
    writeln(temp^.INFO.Workers);
    writeln(CurrToStr(temp^.INFO.MatCost));
    temp:=temp^.adr;
  end;
end;

begin
  new(ObjHead);
  ObjHead^.adr := nil;
  readObjFile;
  writeln;
  writeList(objHead);
  writeln;

 // insertObjList(ObjHead);
 // insertObjList(ObjHead,'Trading House', 45, 885);
  writeList(objHead);
  saveObjFile(objHead);



  readln;
end.