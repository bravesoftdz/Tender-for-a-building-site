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
  {insertContrList(ContrHead, 'BrakhMen');
  insertContrList(ContrHead, 'HorusMen');}
  writeContrList(contrHead);
  writeln;
  saveContrFile(ContrHead);

  readln;
end.
