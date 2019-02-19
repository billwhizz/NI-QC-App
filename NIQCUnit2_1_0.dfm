object Form1: TForm1
  Left = 680
  Top = 175
  Width = 937
  Height = 603
  Caption = 'Form1'
  Color = clBtnFace
  Constraints.MinHeight = 546
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = [fsBold]
  Menu = MainMenu1
  OldCreateOrder = False
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 35
    Top = 201
    Width = 34
    Height = 13
    Caption = 'Notes'
  end
  object gbSearch: TGroupBox
    Left = 32
    Top = 6
    Width = 569
    Height = 145
    Caption = 'Search'
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object rbExtSD43: TRadioButton
      Left = 14
      Top = 41
      Width = 82
      Height = 17
      Hint = '5102'
      Caption = 'Ext SD 4:3'
      TabOrder = 0
      OnClick = btSearchClick
      OnDblClick = btSearchClick
    end
    object rbExtHD: TRadioButton
      Left = 14
      Top = 18
      Width = 82
      Height = 17
      Hint = '5101'
      Caption = 'Ext HD'
      TabOrder = 1
      OnClick = btSearchClick
      OnDblClick = btSearchClick
    end
    object rbExtWav: TRadioButton
      Left = 14
      Top = 84
      Width = 82
      Height = 17
      Hint = '5104'
      Caption = 'Ext Wav'
      TabOrder = 2
      OnClick = btSearchClick
      OnDblClick = btSearchClick
    end
    object rbCinegySD: TRadioButton
      Left = 111
      Top = 40
      Width = 113
      Height = 17
      Hint = '5106'
      Caption = 'Cinegy SD'
      TabOrder = 3
      OnClick = btSearchClick
      OnDblClick = btSearchClick
    end
    object rbCinegyHD: TRadioButton
      Left = 111
      Top = 18
      Width = 113
      Height = 17
      Hint = '5105'
      Caption = 'Cinegy HD'
      TabOrder = 4
      OnClick = btSearchClick
      OnDblClick = btSearchClick
    end
    object btSearch: TButton
      Left = 381
      Top = 18
      Width = 75
      Height = 25
      Caption = 'Search'
      TabOrder = 5
      OnClick = btSearchClick
    end
    object btSearchNext: TButton
      Left = 381
      Top = 58
      Width = 75
      Height = 25
      Caption = 'SearchNext'
      Enabled = False
      TabOrder = 6
      OnClick = btSearchNextClick
    end
    object rbAny: TRadioButton
      Left = 111
      Top = 61
      Width = 57
      Height = 17
      Caption = 'Any'
      Checked = True
      TabOrder = 7
      TabStop = True
      OnClick = btSearchClick
    end
    object leRecords: TLabeledEdit
      Left = 472
      Top = 36
      Width = 57
      Height = 24
      EditLabel.Width = 78
      EditLabel.Height = 13
      EditLabel.Caption = 'Spools Found'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
    end
    object GroupBox4: TGroupBox
      Left = 200
      Top = 16
      Width = 129
      Height = 73
      Caption = '1% Full QC Select'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 9
      object cb1PcExport: TCheckBox
        Left = 13
        Top = 19
        Width = 108
        Height = 19
        Caption = '1% For Export'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        OnClick = cb1PcExportClick
      end
      object cb1PCQC: TCheckBox
        Left = 13
        Top = 43
        Width = 92
        Height = 19
        Caption = '1% For QC'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        OnClick = cb1PCQCClick
      end
    end
    object rbSearchSpool: TRadioButton
      Left = 14
      Top = 110
      Width = 57
      Height = 17
      Caption = 'Spool'
      TabOrder = 10
      OnClick = rbSearchSpoolClick
      OnDblClick = btSearchClick
    end
    object ebSearchSpool: TEdit
      Left = 80
      Top = 110
      Width = 89
      Height = 21
      Hint = '% can be used as a wildcard'
      TabOrder = 11
      OnKeyUp = ebSearchSpoolKeyUp
    end
    object cbNewest: TCheckBox
      Left = 384
      Top = 96
      Width = 97
      Height = 17
      Caption = 'Newest First'
      TabOrder = 12
    end
    object rbSearchQC: TRadioButton
      Left = 200
      Top = 112
      Width = 161
      Height = 17
      Hint = '5199'
      Caption = 'Search Incomplete QC'
      TabOrder = 13
      OnDblClick = btSearchClick
    end
    object rbExtSD169: TRadioButton
      Left = 14
      Top = 62
      Width = 92
      Height = 17
      Hint = '5103'
      Caption = 'Ext SD 16:9'
      TabOrder = 14
      OnClick = btSearchClick
      OnDblClick = btSearchClick
    end
  end
  object stDatabaseConn: TStatusBar
    Left = 0
    Top = 538
    Width = 929
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = True
  end
  object gbDatabase: TGroupBox
    Left = 672
    Top = 558
    Width = 201
    Height = 129
    Caption = 'gbDatabase'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    Visible = False
    object rbLiveDB: TRadioButton
      Left = 16
      Top = 24
      Width = 113
      Height = 17
      Caption = 'DB Live'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 0
    end
    object rbTestDB: TRadioButton
      Left = 16
      Top = 72
      Width = 113
      Height = 17
      Hint = 'nitracking_test 9gbb'
      Caption = 'DB Test'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rbPlayDB: TRadioButton
      Left = 16
      Top = 48
      Width = 113
      Height = 18
      Caption = 'DB Play'
      TabOrder = 2
    end
    object stDB: TStaticText
      Left = 96
      Top = 64
      Width = 83
      Height = 25
      AutoSize = False
      BevelKind = bkFlat
      TabOrder = 3
    end
    object rbDevDB: TRadioButton
      Left = 16
      Top = 96
      Width = 113
      Height = 17
      Hint = 'nitracking_test 127.0'
      Caption = 'DB Dev'
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 664
    Top = 8
    Width = 233
    Height = 217
    Caption = 'QC '
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 3
    object btFail: TButton
      Left = 136
      Top = 124
      Width = 75
      Height = 25
      Caption = 'Fail'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btPassClick
    end
    object btPass: TButton
      Left = 136
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Pass'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btPassClick
    end
    object StaticText1: TStaticText
      Left = 137
      Top = 96
      Width = 73
      Height = 9
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clLime
      ParentColor = False
      TabOrder = 2
    end
    object StaticText2: TStaticText
      Left = 137
      Top = 148
      Width = 73
      Height = 9
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clRed
      ParentColor = False
      TabOrder = 3
    end
    object cbTopTail: TCheckBox
      Left = 17
      Top = 96
      Width = 103
      Height = 17
      Caption = 'Content OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = cbTopTailClick
    end
    object cbMetaData: TCheckBox
      Left = 17
      Top = 72
      Width = 103
      Height = 17
      Caption = 'MetaData OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = cbTopTailClick
    end
    object btCancel: TButton
      Left = 137
      Top = 176
      Width = 73
      Height = 25
      Caption = 'Cancel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = btCancelClick
    end
    object btStart: TButton
      Left = 136
      Top = 20
      Width = 75
      Height = 25
      Caption = 'Start'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = btStartClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 32
    Top = 158
    Width = 569
    Height = 57
    Caption = 'Action'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 4
    object btCopySpoolNo: TButton
      Left = 30
      Top = 20
      Width = 107
      Height = 25
      Caption = 'Copy Spool No'
      TabOrder = 0
      OnClick = btCopySpoolNoClick
    end
    object stExportReq: TStaticText
      Left = 200
      Top = 13
      Width = 353
      Height = 39
      AutoSize = False
      BevelKind = bkFlat
      Caption = '  Req AS11 Cinegy Export'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object btExportConfirmed: TButton
      Left = 424
      Top = 19
      Width = 121
      Height = 25
      Caption = 'Export Confirmed'
      TabOrder = 2
      OnClick = btExportConfirmedClick
    end
  end
  object meSQL: TMemo
    Left = 32
    Top = 560
    Width = 617
    Height = 137
    Lines.Strings = (
      'meSQL')
    ScrollBars = ssBoth
    TabOrder = 5
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 32
    Top = 232
    Width = 865
    Height = 297
    Caption = 'File / Spool'
    Color = 12697066
    ParentColor = False
    TabOrder = 6
    object leSpool: TLabeledEdit
      Left = 18
      Top = 33
      Width = 153
      Height = 30
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = 'Spool No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object leProgNo: TLabeledEdit
      Left = 181
      Top = 33
      Width = 89
      Height = 21
      EditLabel.Width = 47
      EditLabel.Height = 13
      EditLabel.Caption = 'Prog No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object LeSerNo: TLabeledEdit
      Left = 277
      Top = 33
      Width = 65
      Height = 21
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'Ser No'
      ReadOnly = True
      TabOrder = 2
    end
    object leLocation: TLabeledEdit
      Left = 357
      Top = 33
      Width = 65
      Height = 21
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Location'
      ReadOnly = True
      TabOrder = 3
    end
    object st1PC: TStaticText
      Left = 413
      Top = 16
      Width = 25
      Height = 14
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkTile
      TabOrder = 4
    end
    object leDateTime: TLabeledEdit
      Left = 446
      Top = 31
      Width = 145
      Height = 21
      EditLabel.Width = 108
      EditLabel.Height = 13
      EditLabel.Caption = 'Location DateTime'
      ReadOnly = True
      TabOrder = 5
    end
    object leQCSource: TLabeledEdit
      Left = 618
      Top = 33
      Width = 65
      Height = 21
      EditLabel.Width = 115
      EditLabel.Height = 13
      EditLabel.Caption = 'QC Source Location'
      ReadOnly = True
      TabOrder = 6
    end
    object leQCLocationDesc: TLabeledEdit
      Left = 618
      Top = 57
      Width = 201
      Height = 21
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Location'
      ReadOnly = True
      TabOrder = 7
    end
    object leLocationDesc: TLabeledEdit
      Left = 357
      Top = 57
      Width = 193
      Height = 21
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Location'
      ReadOnly = True
      TabOrder = 8
    end
    object leProgTitle: TLabeledEdit
      Left = 17
      Top = 93
      Width = 479
      Height = 21
      EditLabel.Width = 56
      EditLabel.Height = 13
      EditLabel.Caption = 'Prog Title'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
    end
    object leEpisodeTitle: TLabeledEdit
      Left = 17
      Top = 133
      Width = 479
      Height = 21
      EditLabel.Width = 75
      EditLabel.Height = 13
      EditLabel.Caption = 'Episode Title'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 10
    end
    object gbNotres: TGroupBox
      Left = 16
      Top = 158
      Width = 761
      Height = 121
      Caption = 'Notes'
      TabOrder = 11
      object btNotesSave: TButton
        Left = 627
        Top = 23
        Width = 84
        Height = 25
        Caption = 'Notes Save'
        Enabled = False
        TabOrder = 0
        OnClick = btNotesSaveClick
      end
      object btNotesCancel: TButton
        Left = 627
        Top = 71
        Width = 84
        Height = 25
        Caption = 'Notes Cancel'
        TabOrder = 1
        OnClick = btNotesCancelClick
      end
      object stMemoWrite: TStaticText
        Left = 588
        Top = 27
        Width = 25
        Height = 62
        AutoSize = False
        BevelInner = bvLowered
        BevelKind = bkTile
        TabOrder = 2
      end
      object meNotes: TMemo
        Left = 16
        Top = 17
        Width = 553
        Height = 89
        ScrollBars = ssVertical
        TabOrder = 3
        OnKeyPress = meNotesKeyPress
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ZQuery1
    Left = 848
    Top = 326
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cGET_ACP
    UTF8StringsAsWideField = False
    AutoEncodeStrings = False
    HostName = '127.0.0.1'
    Port = 0
    User = 'NiDigitsUser'
    Password = 'n1dus3r'
    Protocol = 'mysql-5'
    Left = 560
    Top = 22
  end
  object ZSQLMonitor1: TZSQLMonitor
    Active = True
    MaxTraceCount = 100
    OnLogTrace = ZSQLMonitor1LogTrace
    Left = 560
    Top = 62
  end
  object ZQuery1: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 848
    Top = 294
  end
  object ZQueryManfEdit: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 880
    Top = 294
  end
  object DataSourceManfEdit: TDataSource
    DataSet = ZQueryManfEdit
    Left = 880
    Top = 326
  end
  object ZQuery2: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 904
    Top = 374
  end
  object DataSource2: TDataSource
    DataSet = ZQuery2
    Left = 904
    Top = 406
  end
  object tmrSearch: TTimer
    Enabled = False
    Interval = 600000
    Left = 880
    Top = 454
  end
  object MainMenu1: TMainMenu
    Left = 128
    Top = 65526
    object F1: TMenuItem
      Caption = 'File'
      object CLose1: TMenuItem
        Caption = 'CLose'
        OnClick = CLose1Click
      end
    end
    object DBase1: TMenuItem
      Caption = 'DBase'
      object Show1: TMenuItem
        Caption = 'Show'
        OnClick = Show1Click
      end
    end
  end
  object ZQueryDBQuery: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 864
    Top = 366
  end
  object DataSourceDBQuery: TDataSource
    DataSet = ZQueryDBQuery
    Left = 864
    Top = 398
  end
end
