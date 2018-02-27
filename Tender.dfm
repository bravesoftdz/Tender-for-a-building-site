object TenderForm: TTenderForm
  Left = 0
  Top = 0
  HorzScrollBar.Style = ssFlat
  HorzScrollBar.Visible = False
  Caption = 'TenderForm'
  ClientHeight = 314
  ClientWidth = 724
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 724
    Height = 314
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object ListTable: TStringGrid
      Left = 1
      Top = 1
      Width = 722
      Height = 247
      Align = alClient
      ColCount = 1
      Ctl3D = False
      DrawingStyle = gdsClassic
      FixedColor = clTeal
      FixedCols = 0
      GradientEndColor = clTeal
      GradientStartColor = clTeal
      GridLineWidth = 2
      ParentCtl3D = False
      TabOrder = 0
      OnMouseUp = ListTableMouseUp
      ColWidths = (
        64)
      RowHeights = (
        24
        24
        24
        24
        24)
    end
    object pnlBottom: TPanel
      Left = 1
      Top = 248
      Width = 722
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlBottom'
      Color = clInfoBk
      Ctl3D = True
      ParentBackground = False
      ParentCtl3D = False
      ShowCaption = False
      TabOrder = 1
      object btnAdd: TButton
        Left = 0
        Top = 0
        Width = 722
        Height = 65
        Align = alClient
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        DoubleBuffered = False
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = btnAddClick
      end
    end
  end
  object mm: TMainMenu
    Left = 352
    Top = 64
    object mnFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object mnSaveAll: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1089#1077
        OnClick = mnSaveAllClick
      end
    end
    object mnLists: TMenuItem
      Caption = #1057#1087#1080#1089#1082#1080
      object mnObjList: TMenuItem
        Caption = #1054#1073#1098#1077#1082#1090#1099
        OnClick = mnObjListClick
      end
      object mnContrList: TMenuItem
        Caption = #1055#1086#1076#1088#1103#1076#1095#1080#1082#1080
        OnClick = mnContrListClick
      end
      object mnWorkersList: TMenuItem
        Caption = #1056#1072#1073#1086#1095#1080#1077
        OnClick = mnWorkersListClick
      end
    end
    object mnTender: TMenuItem
      Caption = #1058#1077#1085#1076#1077#1088
      object mnNewTender: TMenuItem
        Caption = #1053#1086#1074#1099#1081' '#1090#1077#1085#1076#1077#1088
        OnClick = mnNewTenderClick
      end
    end
  end
end
