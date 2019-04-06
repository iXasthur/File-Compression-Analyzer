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
    OnClick = Label1Click
    ExplicitLeft = 640
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
        Control = CheckBoxRLE
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
      end
      item
        Column = 4
        ColumnSpan = 4
        Control = DecompressionButton
        Row = 6
      end
      item
        Column = 4
        ColumnSpan = 2
        Control = CheckBoxExport
        Row = 7
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
    end
    object OpenLabel: TLabel
      Left = 79
      Top = 107
      Width = 91
      Height = 53
      Align = alLeft
      Alignment = taCenter
      Caption = 'OpenLabel'
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
      ExplicitWidth = 94
    end
    object LabelFilePath: TLabel
      Left = 79
      Top = 160
      Width = 542
      Height = 26
      Align = alTop
      Caption = 'LabelFilePath'
      ExplicitWidth = 114
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
      OnClick = CompressionButtonClick
      ExplicitLeft = 360
      ExplicitTop = 272
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
    object CheckBoxRLE: TCheckBox
      Left = 79
      Top = 213
      Width = 233
      Height = 53
      Align = alClient
      Caption = 'RLE'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object CheckBox2: TCheckBox
      Left = 79
      Top = 266
      Width = 233
      Height = 53
      Align = alClient
      Caption = 'Huffman'
      Checked = True
      State = cbChecked
      TabOrder = 2
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
    end
    object DecompressionButton: TSpeedButton
      AlignWithMargins = True
      Left = 322
      Top = 329
      Width = 289
      Height = 33
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alClient
      Caption = 'Decompress'
      OnClick = DecompressionButtonClick
      ExplicitLeft = 392
      ExplicitTop = 288
      ExplicitWidth = 23
      ExplicitHeight = 22
    end
    object CheckBoxExport: TCheckBox
      AlignWithMargins = True
      Left = 322
      Top = 375
      Width = 143
      Height = 47
      Margins.Left = 10
      Align = alLeft
      Caption = 'Export as .txt'
      TabOrder = 4
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Text|*.txt|Compressed File|*.xrle;*.xhfm|Any File|*'
    Left = 584
    Top = 440
  end
end
