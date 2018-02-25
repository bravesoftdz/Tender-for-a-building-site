unit UObjects;

interface
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
procedure writeObjList(const head:TObjAdr);

implementation
uses
  System.SysUtils;
const
    ObjFile = 'objects.brakh'; // ���� ��������
procedure readObjFile(const head:TObjAdr);
var
  f: file of TObjInfo;
  OTemp: TObjAdr;
begin
  AssignFile(f, ObjFile);
  if fileExists(ObjFile) then
  begin
    Reset(f);
    Writeln('Read file ' + ObjFile);
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
    Writeln('Create File');
    close(f);
  end;

end;
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
procedure writeObjList(const head:TObjAdr);
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

end.
