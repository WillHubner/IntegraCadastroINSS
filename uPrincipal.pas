unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw, MSHTML,
  Vcl.Samples.Spin, System.MaskUtils, Vcl.ExtCtrls, jpeg, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TStatusConsulta = (scInicio, scConsultando, scPreenchido, scConsultaPreenchido, scCaptcha, scConsultado);

  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    btnAbrir: TButton;
    btnPreencher: TButton;
    edNome: TEdit;
    edNascimento: TEdit;
    edCPF: TEdit;
    edPIS: TEdit;
    btnIniciar: TButton;
    btnConsultar: TButton;
    edCaptcha: TEdit;
    btnCaptcha: TButton;
    Memo1: TMemo;
    btnPegarHTML: TButton;
    btnCopiar: TButton;
    edResultado: TEdit;
    btnTratamento: TButton;
    btnValidacao: TButton;
    memPalavras: TMemo;
    Image1: TImage;
    Captcha: TLabel;
    btnHTML: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    procedure btnAbrirClick(Sender: TObject);
    procedure btnPreencherClick(Sender: TObject);
    procedure btnIniciarClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnCaptchaClick(Sender: TObject);
    procedure btnPegarHTMLClick(Sender: TObject);
    procedure btnCopiarClick(Sender: TObject);
    procedure btnValidacaoClick(Sender: TObject);
    procedure btnTratamentoClick(Sender: TObject);
    procedure btnHTMLClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
  private
    PegarHTML : Boolean;
    Status : TStatusConsulta;
    function StripHTML(S: string): string;
    function SoNumero(fField : String): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.SoNumero(fField : String): String;
var
  I : Byte;
begin
   Result := '';
   for I := 1 To Length(fField) do
       if fField [I] In ['0'..'9'] Then
            Result := Result + fField [I];
end;

function TForm1.StripHTML(S: string): string;
var
  TagBegin, TagEnd, TagLength: integer;
begin
  TagBegin := Pos('<', S);

  while (TagBegin > 0) do
    begin
      TagEnd := Pos('>', S);
      TagLength := TagEnd - TagBegin + 1;
      Delete(S, TagBegin, TagLength);
      TagBegin := Pos('<', S);
    end;

  Result := S;
end;

procedure TForm1.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
var
  Seguir : Boolean;
begin
  if (Status = scInicio) then
    begin
      Application.ProcessMessages;
      btnIniciar.Click;
      exit;
    end;
  if (Status = scConsultando) then
    begin
      Application.ProcessMessages;

      try
        WebBrowser1.OleObject.Document.all.Item('formQualificacaoCadastral:nome', 0).value := edNome.Text;
      except
        exit;
      end;

      btnPreencher.Click;
      exit;
    end;
  if (Status = scPreenchido) then
    begin
      Application.ProcessMessages;

      try
        WebBrowser1.OleObject.Document.all.Item('formValidacao2:botaoValidar2', 0).click;
      except
        exit;
      end;

      btnConsultar.Click;
      exit;
    end;
  if (Status = scConsultaPreenchido) then
    begin
      Application.ProcessMessages;

      try
        WebBrowser1.OleObject.Document.all.Item('captcha_campo_resposta', 0).value := '0';
      except
        exit;
      end;

      btnHTML.Click;
      exit;
    end;

  if (Status = scCaptcha) then
    begin
      Application.ProcessMessages;

      btnPegarHTML.Click;

      if (pos('não corresponde ao desafio gerado', Memo1.Text) <> 0) then
        begin
          ShowMessage('Captcha Incorreto!!');

          btnHTML.Click;

          edCaptcha.SetFocus;

          exit;
        end;

      Seguir := not (pos('Resultado da Consulta', Memo1.Text) = 0);

      if Seguir then btnValidacao.Click;
    end;
end;

procedure TForm1.btnCaptchaClick(Sender: TObject);
begin
  WebBrowser1.OleObject.Document.all.Item('captcha_campo_resposta', 0).value := edCaptcha.Text;
  WebBrowser1.OleObject.Document.all.Item('formValidacao:botaoValidar', 0).click;
end;

procedure TForm1.btnConsultarClick(Sender: TObject);
begin
  WebBrowser1.OleObject.Document.all.Item('formValidacao2:botaoValidar2', 0).click;
  Status := scConsultaPreenchido;
end;

procedure TForm1.btnCopiarClick(Sender: TObject);
var
  Str : String;
begin
  Str := FormatMaskText('0\.000\.000\.000\-0;0;', SoNumero(edPIS.Text));

  edResultado.Text := Copy(memo1.Text, POS(Str, Memo1.Text), 200);

  memPalavras.Lines.Add(Str);

  btnTratamento.Click;
end;

procedure TForm1.btnHTMLClick(Sender: TObject);
var
  Jpeg: TJpegImage;
  imgStream: TMemoryStream;
  i : integer;
  IdHttp : TIdHTTP;
  URL_CAPTCHA : String;
begin
  for i := 0 to WebBrowser1.OleObject.Document.Images.Length - 1 do
    begin
      if Pos('api/imagem', copy(WebBrowser1.OleObject.Document.Images.Item(i).Src, 1, 500)) > 0 then
        begin
          URL_CAPTCHA := copy(WebBrowser1.OleObject.Document.Images.Item(i).Src, 1, 500);

          Jpeg := TJpegImage.Create;
          imgStream := TMemoryStream.Create;
          IdHttp := TIdHTTP.Create;

          try
            IdHttp.Get(URL_CAPTCHA, imgStream);

            if (imgStream.Size > 0) then
              begin
                imgStream.Position := 0;
                Jpeg.LoadFromStream(imgStream);
                Image1.Picture.Assign(Jpeg);
              end;
          finally
            imgStream.Free;
            Jpeg.Free;
            IdHttp.Free;
          end;
        end;
    end;
end;

procedure TForm1.btnIniciarClick(Sender: TObject);
begin
  WebBrowser1.OleObject.Document.all.Item('indexForm1:botaoConsultar', 0).click;
  Status := scConsultando;
end;

procedure TForm1.btnPegarHTMLClick(Sender: TObject);
var
  textoNFe: IHTMLDocument2;
begin
  textoNFe := WebBrowser1.Document as IHTMLDocument2;

  repeat

  until
    Assigned(textoNFe.body);

  Memo1.Lines.Text := textoNFe.body.innerHTML;
end;

procedure TForm1.btnPreencherClick(Sender: TObject);
begin
  WebBrowser1.OleObject.Document.all.Item('formQualificacaoCadastral:nome', 0).value := edNome.Text;
  WebBrowser1.OleObject.Document.all.Item('formQualificacaoCadastral:dataNascimento', 0).value := edNascimento.Text;
  WebBrowser1.OleObject.Document.all.Item('formQualificacaoCadastral:cpf', 0).value := edCPF.Text;
  WebBrowser1.OleObject.Document.all.Item('formQualificacaoCadastral:nis', 0).value := edPIS.Text;
  WebBrowser1.OleObject.Document.all.Item('formQualificacaoCadastral:btAdicionar', 0).click;
  Status := scPreenchido;
end;

procedure TForm1.btnValidacaoClick(Sender: TObject);
begin
  if (POS('Os dados estão corretos.', Memo1.Text) > 0) then
    ShowMessage('Cadastro OK')
  else
    ShowMessage('Cadastro Inválido!');

  btnCopiar.Click;
end;

procedure TForm1.btnTratamentoClick(Sender: TObject);
var
  i : integer;
  Ver : Boolean;
begin
  Ver := false;

  while not ver do
    begin
      for I := 0 to Pred(memPalavras.Lines.Count) do
        edResultado.Text := StringReplace(EdResultado.Text, memPalavras.Lines[i], '', []);

      for I := 0 to Pred(memPalavras.Lines.Count) do
        begin
          Ver := (Pos(memPalavras.Lines[i], EdResultado.Text) = 0);

          if not ver then break;
        end;
    end;

  edResultado.Text := Trim(edResultado.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  btnAbrir.Click;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  btnCaptcha.Click;
  Status := scCaptcha;
end;

procedure TForm1.btnAbrirClick(Sender: TObject);
begin
  WebBrowser1.Navigate('http://consultacadastral.inss.gov.br/Esocial/pages/index.xhtml;');
  Status := scInicio;
end;

end.
