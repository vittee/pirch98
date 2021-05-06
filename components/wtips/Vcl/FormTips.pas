unit FormTips;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TTipForm = class(TForm)
    Panel1: TPanel;
    TipText: TLabel;
    ShowAtStart: TCheckBox;
    Next: TButton;
    Image1: TImage;
    TipHelp: TLabel;
    CloseBtn: TButton;
    Bevel1: TBevel;
    Header: TLabel;
    procedure OkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NextClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
     Tips : TStringList;
    { Public declarations }
  end;

implementation

{$R *.DFM}

Var
  NumTip : Word;

procedure TTipForm.OkClick(Sender: TObject);
begin
  ModalResult:= mrOK;
  Close;
end;

procedure TTipForm.FormCreate(Sender: TObject);
begin
  Tips := TStringList.Create;
end;

procedure TTipForm.FormShow(Sender: TObject);
begin
  If Tips.Count = 0 Then
   Tips.Add('No tips available !');

  If Tips.Count = 1 Then
     Next.Enabled := False;

  Randomize;
  NumTip := Random( Tips.Count );
  TipText.Caption := Tips.Strings[ NumTip ];
end;

procedure TTipForm.NextClick(Sender: TObject);
begin
  NumTip := Random( Tips.Count );
  TipText.Caption := Tips.Strings[ NumTip ];
end;

procedure TTipForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Tips.Free;
end;

end.
