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

// ��������� � �������
procedure writeWorkList(var head:TWorkAdr);

implementation
  uses UContractors;
  const
    WorkFile = 'workers.brakh';


procedure writeWorkList(var head:TWorkAdr);
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
end.