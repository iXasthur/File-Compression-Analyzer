object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'File Compression Analyser'
  ClientHeight = 553
  ClientWidth = 782
  Color = 16118015
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 26
  object Label1: TLabel
    Left = 0
    Top = 534
    Width = 782
    Height = 19
    Align = alBottom
    Alignment = taRightJustify
    Caption = '(c)Mikhail Kavaleuski '
    Color = clWindowFrame
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ExplicitLeft = 595
    ExplicitTop = 569
    ExplicitWidth = 142
  end
  object GridPanelMain: TGridPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 534
    Align = alClient
    ColumnCollection = <
      item
        Value = 10.000000000000010000
      end
      item
        Value = 10.000000000000010000
      end
      item
        Value = 10.000000000000000000
      end
      item
        Value = 9.999999999999996000
      end
      item
        Value = 9.999999999999995000
      end
      item
        Value = 9.999999999999995000
      end
      item
        Value = 9.999999999999996000
      end
      item
        Value = 10.000000000000000000
      end
      item
        Value = 10.000000000000000000
      end
      item
        Value = 10.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 1
        ColumnSpan = 2
        Control = OpenButton
        Row = 1
      end
      item
        Column = 4
        ColumnSpan = 4
        Control = Memo1
        Row = 1
        RowSpan = 2
      end
      item
        Column = 1
        ColumnSpan = 2
        Control = OpenLabel
        Row = 2
      end
      item
        Column = 4
        ColumnSpan = 4
        Control = LabelFilePreview
        Row = 0
      end
      item
        Column = 1
        ColumnSpan = 7
        Control = LabelFilePath
        Row = 3
      end
      item
        Column = 4
        ColumnSpan = 4
        Control = CompressionButton
        Row = 4
      end
      item
        Column = 1
        ColumnSpan = 3
        Control = CheckBox1
        Row = 4
      end
      item
        Column = 1
        ColumnSpan = 3
        Control = CheckBox2
        Row = 5
      end
      item
        Column = 4
        ColumnSpan = 4
        Control = CheckBox3
        Row = 5
      end>
    ParentBackground = False
    RowCollection = <
      item
        Value = 10.000000000000020000
      end
      item
        Value = 9.999999999999995000
      end
      item
        Value = 9.999999999999986000
      end
      item
        Value = 9.999999999999982000
      end
      item
        Value = 9.999999999999986000
      end
      item
        Value = 9.999999999999995000
      end
      item
        Value = 10.000000000000010000
      end
      item
        Value = 10.000000000000010000
      end
      item
        Value = 10.000000000000010000
      end
      item
        Value = 9.999999999999995000
      end>
    TabOrder = 0
    ExplicitWidth = 737
    ExplicitHeight = 569
    object OpenButton: TSpeedButton
      Left = 79
      Top = 54
      Width = 156
      Height = 53
      Align = alClient
      Caption = 'Open File'
      OnClick = OpenButtonClick
      ExplicitLeft = 74
      ExplicitTop = 51
      ExplicitWidth = 146
      ExplicitHeight = 56
    end
    object Memo1: TMemo
      Left = 312
      Top = 54
      Width = 309
      Height = 106
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Calibri'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitLeft = 293
      ExplicitTop = 57
      ExplicitWidth = 292
      ExplicitHeight = 112
    end
    object OpenLabel: TLabel
      Left = 79
      Top = 107
      Width = 116
      Height = 53
      Align = alLeft
      Alignment = taCenter
      Caption = 'OpenLabel'
      ExplicitLeft = 74
      ExplicitTop = 113
      ExplicitWidth = 91
      ExplicitHeight = 26
    end
    object LabelFilePreview: TLabel
      Left = 312
      Top = 37
      Width = 309
      Height = 17
      Align = alBottom
      Caption = 'LabelFilePreview'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 293
      ExplicitTop = 40
      ExplicitWidth = 94
    end
    object LabelFilePath: TLabel
      Left = 79
      Top = 160
      Width = 542
      Height = 40
      Align = alTop
      Caption = 'LabelFilePath'
      ExplicitLeft = 59
      ExplicitTop = 130
      ExplicitWidth = 402
    end
    object CompressionButton: TSpeedButton
      AlignWithMargins = True
      Left = 322
      Top = 223
      Width = 289
      Height = 33
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Caption = 'Compress'
      ExplicitLeft = 360
      ExplicitTop = 272
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
    object CheckBox1: TCheckBox
      Left = 79
      Top = 213
      Width = 233
      Height = 53
      Align = alClient
      Caption = 'Compression1'
      TabOrder = 1
      ExplicitLeft = 74
      ExplicitTop = 281
      ExplicitWidth = 146
      ExplicitHeight = 56
    end
    object CheckBox2: TCheckBox
      Left = 79
      Top = 266
      Width = 233
      Height = 53
      Align = alClient
      Caption = 'Compression2'
      TabOrder = 2
      ExplicitLeft = 328
      ExplicitTop = 312
      ExplicitWidth = 97
      ExplicitHeight = 17
    end
    object CheckBox3: TCheckBox
      AlignWithMargins = True
      Left = 322
      Top = 269
      Width = 279
      Height = 47
      Margins.Left = 10
      Align = alLeft
      Caption = 'Analyse'
      TabOrder = 3
      ExplicitLeft = 303
      ExplicitTop = 284
      ExplicitHeight = 53
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Text|*.txt|AnyFile|*'
    Left = 584
    Top = 440
  end
end
