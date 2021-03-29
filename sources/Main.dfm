object MainForm: TMainForm
  Left = 194
  Top = 111
  Caption = 'CRM: '#1087#1086#1076#1075#1086#1090#1086#1074#1082#1072' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 112
  ClientWidth = 484
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 93
    Width = 484
    Height = 19
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    AutoHint = True
    Panels = <>
    SimplePanel = True
  end
  object dtStart: TDateTimePicker
    Left = 17
    Top = 12
    Width = 164
    Height = 24
    Date = 42906.698826412040000000
    Time = 42906.698826412040000000
    TabOrder = 1
  end
  object progress: TProgressBar
    Left = 0
    Top = 76
    Width = 484
    Height = 17
    Align = alBottom
    Step = 1
    TabOrder = 2
  end
  object dtEnd: TDateTimePicker
    Left = 190
    Top = 12
    Width = 164
    Height = 24
    Date = 42909.584939166660000000
    Time = 42909.584939166660000000
    TabOrder = 3
  end
  object btnCreateIt: TButton
    Left = 368
    Top = 12
    Width = 97
    Height = 58
    Caption = 'DOIT!'
    TabOrder = 4
    OnClick = btnCreateItClick
  end
  object Query1: TQuery
    Left = 128
    Top = 40
  end
  object Table1: TTable
    AutoCalcFields = False
    DefaultIndex = False
    TableName = 'importfiz'
    TableType = ttDBase
    Left = 16
    Top = 40
  end
  object Table2: TTable
    AutoCalcFields = False
    TableName = 'impfirm'
    TableType = ttDBase
    Left = 72
    Top = 40
  end
end
