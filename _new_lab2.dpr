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
  UContractors in 'UContractors.pas';

var
  ObjHead:TObjAdr;
  ContrHead: TContrAdr;

begin
  new(ObjHead);
  new(ContrHead);


  {ObjHead^.adr := nil;
  readObjFile(ObjHead);
  writeln;
  writeObjList(objHead);
  writeln;

 // insertObjList(ObjHead);
 // insertObjList(ObjHead,'Trading House', 45, 885);
  writeObjList(objHead);
  saveObjFile(objHead);    }

  Writeln('Contr: ');
  readContrFile(ContrHead);
  writeContrList(contrHead);
  writeln;
  insertContrList(ContrHead, 'BrakhMen');
  insertContrList(ContrHead, 'HorusMen');
  {insertWorkListFromCompany(ContrHead, 'BrakhMen', 'Alexandr Pankratiew', 3000.45, 'Developer');
  insertWorkListFromCompany(ContrHead, 'BrakhMen', 'Nikita Pilinko', 3000.451, 'Developer');
  insertWorkListFromCompany(ContrHead, 'BrakhMen', 'Kirill Holubeu', 3000.45, 'Developer');

  insertWorkListFromCompany(ContrHead, 'HorusMen', 'Paramonov Anton', 3.5, 'AI');
  }
  writeContrList(contrHead);
  writeln;

  saveContrFile(ContrHead);
  readln;
end.
