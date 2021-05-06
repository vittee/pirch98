unit Tips;


interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, FormTips, Registry;

type
  TLanguage = (laEnglish, laGerman);
  TTips = class(TComponent)
  private
    FAppName : String;
    FHeader : String;
    FTipHelp : String;
    FTitle : String;
    FSaveKey : String;
    FShowAtStart : Boolean;
    FSaveShowAtStart : Boolean;
    FTips : TStringList;
    FLanguage : Tlanguage;
    FBackColor : TColor;
  function GetTipsCount: word;
  procedure SetTips(Value : TStringList);
  protected
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    Function Execute : boolean;
    procedure SaveToRegistry(Value : Boolean);
    function LoadFromRegistry: Boolean;
  published
    Property AppName : string read FAppName write FAppName;
    Property SaveShowAtStart : Boolean read FSaveShowAtStart write FSaveShowAtStart;
    Property SaveKey : String read FSaveKey write FSaveKey;
    Property Language : TLanguage read FLanguage write FLanguage;
    Property TipBackground : TColor read FBackColor write FBackColor;
    Property Header : string read FHeader write FHeader;
    Property Title : string read FTitle write FTitle;
    Property TipHelp : string read FTipHelp write FTipHelp;
    Property ShowAtStart : boolean read FShowAtStart write FShowAtStart;
    Property Tips : TStringList read FTips write SetTips;
    Property TipsCount : word read GetTipsCount;
end;

Var
  TipsDlg : TTipForm;
  Reg : TRegistry;

procedure Register;

implementation

procedure Register;
begin
  { Register component }
  RegisterComponents('Samples',[TTIPS]);
end;

constructor TTips.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  { Create TStringList to store Tips }
  FTips := TStringList.Create;
end;

destructor TTips.Destroy;
begin
  { Free TStringList }
  FTips.Free;
  inherited Destroy;
end;

procedure TTips.SetTips(Value:TStringList);
begin
  If FTips <> Value then
     FTips.Assign( Value )
end;

function TTips.GetTipsCount:Word;
begin
  Result := Tips.Count;
end;

procedure TTips.SaveToRegistry(Value : Boolean);
begin
// Store ShowAtStart Value in Registry
if FSaveShowAtStart then begin
 Try
  Reg:= TRegistry.Create;
  Reg.RootKey:= HKEY_CURRENT_USER;
  Reg.OpenKey(FSaveKey, True);
  Reg.WriteBool('ShowAtStart', Value);
 Finally
  Reg.Free;
 End;
End;

end; {SetShowAtStart}

function TTips.LoadFromRegistry : Boolean;
begin
 Try
  Reg:= TRegistry.Create;
  Reg.RootKey:= HKEY_CURRENT_USER;
  Reg.OpenKey(FSaveKey, False);
  if Reg.ValueExists('ShowAtStart') then Result:= Reg.ReadBool('ShowAtStart')
   else Result:= FShowAtStart;
 Finally
  Reg.Free;
 End;

end;

function TTips.Execute: Boolean;
begin
     { Create tips dialog in memory }
     TipsDlg := TTipForm.Create(Application);

     { Place property values }
      TipsDlg.Caption := Title;

      TipsDlg.Header.Caption:= FHeader;

      if FAppName <> '' then begin
         if FLanguage = laEnglish then
          TipsDlg.ShowAtStart.Caption:= '&Show this dialog on next Start of '+ FAppName
         else
          TipsDlg.ShowAtStart.Caption:= Format('&Beim n‰chsten Start von %s zeigen', [FAppName]);
      end else begin
         if FLanguage = laEnglish then
          TipsDlg.ShowAtStart.Caption:= '&Show this dialog on next Start'
         else
          TipsDlg.ShowAtStart.Caption:= '&Dieses Dialogfeld beim n‰chsten Start zeigen';
      end;

      if FLanguage = laEnglish then begin
          TipsDlg.Next.Caption:= '&Next >';
          TipsDlg.CloseBtn.Caption:= '&Close';
         end else begin
          TipsDlg.Next.Caption:= '&N‰chster >';
          TipsDlg.CloseBtn.Caption:= '&Schlieﬂen';
      end;

      TipsDlg.TipHelp.Caption := TipHelp;
      TipsDlg.Panel1.Color:= FBackColor;
      TipsDlg.ShowAtStart.Checked := LoadFromRegistry;
      TipsDlg.TipText.Caption := '';
      TipsDlg.Tips.Assign(Tips);

 With TipsDlg do Begin
     Result := (ShowModal <> 0);
 End;

     { Store value from dialog before freeing}
     ShowAtStart := TipsDlg.ShowAtStart.Checked;

     { Store ShowAtStart in Registry }
     SaveToRegistry(ShowAtStart);

     { Free tips dialog from memory }
     TipsDlg.Free;
end;


end.

