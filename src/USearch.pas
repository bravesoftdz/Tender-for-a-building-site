{*******************************************************}
{       SEARCH ELEMENTS WITH FILTER                     }
{       Lab �2. Dynamic Lists                           }
{       Copyright (c) 2018 BSUIR                        }
{       Created by Parnkratiew Alexandr                 }
{                                                       }
{*******************************************************}
unit USearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AddList, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSearchForm = class(TForm)
    pnlMain: TPanel;
    Label1: TLabel;
    edt1: TEdit;
    Label2: TLabel;
    edt2: TEdit;
    Label3: TLabel;
    edt3: TEdit;
    Label4: TLabel;
    edt4: TEdit;
    btnSearch: TButton;
    cbb1: TComboBox;
    cbb2: TComboBox;
    cbb3: TComboBox;
    cbb4: TComboBox;
    lblHelp: TLabel;
    lblHelpText: TLabel;
    pnlSidebar: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure clearAll;
    procedure btnSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SearchForm: TSearchForm;

implementation

uses Tender;

var mode:TMode;
{$R *.dfm}

procedure TSearchForm.btnSearchClick(Sender: TObject);
var f1,f2,f3,f4:string;
  n1,n2,n3,n4:byte;
begin

  f1:= edt1.Text;
  f2:= edt2.Text;
  f3:= edt3.Text;
  f4:= edt4.Text;
  n1 := cbb1.ItemIndex;
  n2 := cbb2.ItemIndex;
  n3 := cbb3.ItemIndex;
  n4 := cbb4.ItemIndex;
  // ShowMessage( IntToStr(n1));
  case TenderForm.SearchMode of
    MObjList:
    begin
      if f2 = '' then f2 := '-1';
      if f3 = '' then f3 := '-1';

      try

        TenderForm.SearchObj(f1, StrToInt(f2), StrToCurr(f3), f4, n1, n2,n3);
        Self.Close;
      except on E: Exception do
        ShowMessage('������������ ����')
      end;
    end;
    MContrList:
    begin
      TenderForm.SearchContr(f1,n1);
      Self.Close;
    end;
    MWorkList:
    begin
      if f3 = '' then f3 := '-1';
      try
        TenderForm.SearchWorker(f1,f2,f4,StrToCurr(f3), n1,n2,n3,n4);
        Self.Close;
      except on E: Exception do
        ShowMessage('������������ ����')
      end;
    end;
  end;

end;

procedure TSearchForm.clearAll;
begin
  Label1.Visible := false;
  Label2.Visible := false;
  Label3.Visible := false;
  Label4.Visible := false;
  edt1.Visible := false;
  edt1.Text := '';
  edt2.Text := '';
  edt3.Text := '';
  edt4.Text := '';
  edt2.Visible := false;
  edt3.Visible := False;
  edt4.Visible := false;
  cbb1.Visible := false;
  cbb1.Clear;
  cbb2.Visible := false;
  cbb2.Clear;
  cbb3.Visible := false;
  cbb3.Clear;
  cbb4.Visible := false;
  cbb4.Clear;
end;

procedure TSearchForm.FormActivate(Sender: TObject);
begin
  clearAll;
  case TenderForm.SearchMode of
    MObjList:
    begin
      Label1.Visible := true;
      Label2.Visible := true;
      Label3.Visible := true;
      Label4.Visible := true;
      edt1.Visible := true;
      edt2.Visible := true;
      edt3.Visible := true;
      edt4.Visible := true;
      Label1.Caption := '�������� �������';
      Label2.Caption := '����������� ���������� ����c���';
      Label3.Caption := '���� �� ���������';
      Label4.Caption := '��� �������';
      cbb1.Visible := true;
      cbb1.Items.Add('������ ���������');
      cbb1.Items.Add('���������');
      cbb1.ItemIndex := 0;
      cbb2.Visible := true;
      cbb2.Items.Add('=');
      cbb2.Items.Add('<');
      cbb2.Items.Add('>');
      cbb2.ItemIndex := 0;
      cbb3.Visible := true;
      cbb3.Items.Add('=');
      cbb3.Items.Add('<');
      cbb3.Items.Add('>');
      cbb3.ItemIndex := 0;


    end;
    MContrList:
    begin
      Label1.Visible := True;
      edt1.Visible := True;
      Label1.Caption := '�������� ����������';
      cbb1.Visible := true;
      cbb1.Items.Add('������ ���������');
      cbb1.Items.Add('���������');
      cbb1.ItemIndex := 0;
    end;
    MWorkList:
    begin
      Label1.Visible := true;
      Label2.Visible := true;
      Label3.Visible := true;
      Label4.Visible := True;
      edt1.Visible := true;
      edt2.Visible := true;
      edt3.Visible := true;
      edt4.Visible := True;
      Label1.Caption := '���';
      Label2.Caption := '��������';
      Label3.Caption := '��������';
      Label4.Caption := '������';
      cbb1.Visible := true;
      cbb1.Items.Add('������ ���������');
      cbb1.Items.Add('���������');
      cbb1.ItemIndex := 0;
      cbb2.Visible := true;
      cbb2.Items.Add('������ ���������');
      cbb2.Items.Add('���������');
      cbb2.ItemIndex := 0;
      cbb3.Visible := true;
      cbb3.Items.Add('=');
      cbb3.Items.Add('<');
      cbb3.Items.Add('>');
      cbb3.ItemIndex := 0;
      cbb4.Visible := true;
      cbb4.Items.Add('������ ���������');
      cbb4.Items.Add('���������');
      cbb4.ItemIndex := 0;
    end;
  end;
end;

end.
