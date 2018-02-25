unit UWorkers;

interface
type
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
  const
    WorkFile = 'workers.brakh';

// ��������� � �������
procedure writeWorkList(const head:TWorkAdr);
procedure readFromFileWithContractors(const head: TWorkAdr; contr: string);
procedure insertWorkList(const head: TWorkAdr; const company:string; const Name:string;
        const Salary: Currency = 0; const ObjType: string = '1 Float House');
procedure saveWorkFile(const head:TWorkAdr);

implementation

  uses UContractors, System.SysUtils;

procedure readFromFileWithContractors(const head: TWorkAdr; contr: string);
var
  f: file of TWorkersInfo;
  Temp: TWorkAdr;
  TInfo: TWorkersInfo;
begin
  AssignFile(f, WorkFile);
  if fileExists(WorkFile) then
  begin
    Reset(f);
    Writeln('Read file ' + WorkFile);
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
    Writeln('Create File');
    close(f);
  end;
end;

procedure insertWorkList(const head: TWorkAdr; const company:string; const Name:string;
        const Salary: Currency = 0; const ObjType: string = '1 Float House');
var
  temp:TWorkAdr;
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
  temp^.Info.Company := company;
  temp^.Info.Salary := Salary;
  temp^.Info.ObjType := ObjType;
end;


procedure writeWorkList(const head:TWorkAdr);
var
  temp:TWorkAdr;
begin
  temp := head^.adr;
  while temp <> nil do
  begin
    writeln(temp^.INFO.Name);
    writeln(temp^.INFO.Salary);
    writeln(temp^.INFO.ObjType);
    temp:=temp^.adr;
  end;
end;

procedure saveWorkFile(const head:TWorkAdr);
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
end.
