unit UContractors;

interface
uses UWorkers;
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
procedure writeContrList(var head:TContrAdr);

implementation
uses
  System.SysUtils;
const
  ContrFile = 'contractors.brakh';


procedure readContrFile(const head:TContrAdr);
var
  f: file of TContractorsInfo;
  Temp: TContrAdr;
begin
  AssignFile(f, ContrFile);
  if fileExists(ContrFile) then
  begin
    Reset(f);
    Writeln('Read file ' + ContrFile);
    Temp := Head;
    while not EOF(f) do
    begin
      new(Temp^.adr);
      Temp:=Temp^.adr;
      Temp^.adr:=nil;
      read(f, Temp^.Info);
      new(Temp^.WorkersHead);
      Temp^.WorkersHead.Adr := nil;
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

procedure saveContrFile(const head:TContrAdr);
var
  f: file of TContractorsInfo;
  temp: TContrAdr;
begin
  AssignFile(f, ContrFile);
  rewrite(f);
  temp := head^.adr;
  while temp <> nil do
  begin
    write(f, temp^.Info);
    temp:=temp^.adr;
  end;
  close(F);
end;

procedure insertContrList(const head: TContrAdr; name:string);
var
  temp:TContrAdr;
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
end;

procedure writeContrList(var head:TContrAdr);
var
  temp:TContrAdr;
begin
  temp := head^.adr;
  while temp <> nil do
  begin
    writeln(temp^.INFO.Name);
    writeWorkList(temp^.WorkersHead);  // �� ����� UWORKERS
    temp:=temp^.adr;
  end;
end;

end.
