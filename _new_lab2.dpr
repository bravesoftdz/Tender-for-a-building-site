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
  System.SysUtils,
  UObjects in 'UObjects.pas',
  UWorkers in 'UWorkers.pas',
  UContractors in 'UContractors.pas',
  UTender in 'UTender.pas';

var
  ObjHead:TObjAdr;
  ContrHead: TContrAdr;
  tenderHead: TTendAdr;
  N:integer;

begin
  new(ObjHead);
  new(ContrHead);
  readObjFile(ObjHead);
  readContrFile(ContrHead);
  {ObjHead^.adr := nil;

  writeln;
  writeObjList(objHead);
  writeln;

 // insertObjList(ObjHead);
 // insertObjList(ObjHead,'Trading House', 45, 885);
  writeObjList(objHead);
  saveObjFile(objHead);    }

  Writeln('Contr: ');

  writeContrList(contrHead);
  writeln;
  insertContrList(ContrHead, 'BrakhMen');
  insertContrList(ContrHead, 'NoNames');
  {insertWorkListFromCompany(ContrHead, 'BrakhMen', 'Alexandr Pankratiew', 3000.45, 'Developer');
  insertWorkListFromCompany(ContrHead, 'BrakhMen', 'Nikita Pilinko', 3000.451, 'Developer');
  insertWorkListFromCompany(ContrHead, 'BrakhMen', 'Kirill Holubeu', 3000.45, 'Developer');

  insertWorkListFromCompany(ContrHead, 'HorusMen', 'Paramonov Anton', 3.5, 'AI');
  }
  //insertWorkListFromCompany(ContrHead, 'HorusMen', 'Komrakov', 3.5, 'Developer');



  //writeContrList(contrHead);
  writeln;
  insertObjList(ObjHead,'Developer', 45, 885);
  newTender(N,TenderHead, ObjHead, ContrHead, 'Developer');
  writeTendList(TenderHead);
  Writeln;
  sortTenders(tenderHead);
  writeTendList(tenderHead);
  //saveContrFile(ContrHead);
  readln;
end.
