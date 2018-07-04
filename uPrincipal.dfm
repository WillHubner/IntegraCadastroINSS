object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 417
  ClientWidth = 677
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 185
    Width = 202
    Height = 72
    AutoSize = True
    Center = True
  end
  object Captcha: TLabel
    Left = 8
    Top = 265
    Width = 40
    Height = 13
    Caption = 'Captcha'
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 133
    Height = 19
    Caption = 'Consulta Completa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 296
    Top = 8
    Width = 98
    Height = 19
    Caption = 'Passo a Passo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 531
    Top = 6
    Width = 72
    Height = 19
    Caption = 'Adicionais'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 319
    Width = 111
    Height = 19
    Caption = 'Memo Resposta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Shape1: TShape
    Left = 254
    Top = 45
    Width = 1
    Height = 269
  end
  object Shape2: TShape
    Left = 432
    Top = 45
    Width = 1
    Height = 269
  end
  object Shape3: TShape
    Left = 8
    Top = 35
    Width = 661
    Height = 1
  end
  object WebBrowser1: TWebBrowser
    Left = 456
    Top = 421
    Width = 350
    Height = 266
    TabOrder = 0
    OnDocumentComplete = WebBrowser1DocumentComplete
    ControlData = {
      4C0000002C2400007E1B00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object btnAbrir: TButton
    Left = 286
    Top = 45
    Width = 117
    Height = 25
    Caption = 'Abrir Site'
    TabOrder = 1
    OnClick = btnAbrirClick
  end
  object btnPreencher: TButton
    Left = 287
    Top = 107
    Width = 117
    Height = 25
    Caption = 'Preencher'
    TabOrder = 2
    OnClick = btnPreencherClick
  end
  object edNome: TEdit
    Left = 8
    Top = 45
    Width = 203
    Height = 21
    TabOrder = 3
    Text = 'Digite o Nome'
  end
  object edNascimento: TEdit
    Left = 8
    Top = 72
    Width = 203
    Height = 21
    TabOrder = 4
    Text = 'DD/MM/AAAA'
  end
  object edCPF: TEdit
    Left = 8
    Top = 99
    Width = 203
    Height = 21
    TabOrder = 5
    Text = 'Digite o CPF'
  end
  object edPIS: TEdit
    Left = 8
    Top = 126
    Width = 203
    Height = 21
    TabOrder = 6
    Text = 'Digite o NIS'
  end
  object btnIniciar: TButton
    Left = 287
    Top = 76
    Width = 117
    Height = 25
    Caption = 'Iniciar Consulta'
    TabOrder = 7
    OnClick = btnIniciarClick
  end
  object btnConsultar: TButton
    Left = 287
    Top = 138
    Width = 117
    Height = 25
    Caption = 'Consultar'
    TabOrder = 8
    OnClick = btnConsultarClick
  end
  object edCaptcha: TEdit
    Left = 54
    Top = 263
    Width = 156
    Height = 21
    TabOrder = 9
  end
  object btnCaptcha: TButton
    Left = 287
    Top = 200
    Width = 117
    Height = 25
    Caption = 'Preencher Captcha'
    TabOrder = 10
    OnClick = btnCaptchaClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 344
    Width = 661
    Height = 65
    Lines.Strings = (
      'Memo1')
    TabOrder = 11
  end
  object btnPegarHTML: TButton
    Left = 287
    Top = 231
    Width = 117
    Height = 25
    Caption = 'Pegar HTML'
    TabOrder = 12
    OnClick = btnPegarHTMLClick
  end
  object btnCopiar: TButton
    Left = 467
    Top = 43
    Width = 202
    Height = 25
    Caption = 'Procurar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnClick = btnCopiarClick
  end
  object edResultado: TEdit
    Left = 467
    Top = 74
    Width = 202
    Height = 21
    TabOrder = 14
  end
  object btnTratamento: TButton
    Left = 467
    Top = 260
    Width = 202
    Height = 25
    Caption = 'Tratamento'
    TabOrder = 15
    OnClick = btnTratamentoClick
  end
  object btnValidacao: TButton
    Left = 286
    Top = 262
    Width = 117
    Height = 25
    Caption = 'Valida'#231#227'o'
    TabOrder = 16
    OnClick = btnValidacaoClick
  end
  object memPalavras: TMemo
    Left = 467
    Top = 101
    Width = 202
    Height = 153
    Lines.Strings = (
      '<BR>'
      '<'
      '>'
      'TD'
      'class'
      '='
      'left'
      'SPAN'
      '/'
      'tamanho'
      '25')
    TabOrder = 17
  end
  object btnHTML: TButton
    Left = 287
    Top = 169
    Width = 117
    Height = 25
    Caption = 'HTML Captcha'
    TabOrder = 18
    OnClick = btnHTMLClick
  end
  object Button2: TButton
    Left = 8
    Top = 153
    Width = 203
    Height = 26
    Caption = 'Iniciar Consulta'
    TabOrder = 19
    WordWrap = True
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 289
    Width = 202
    Height = 24
    Caption = 'Consultar'
    TabOrder = 20
    OnClick = Button3Click
  end
end
