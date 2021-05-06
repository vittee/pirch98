unit PageControl98_Design;

interface

Uses
  Classes, DesignIntf, DesignEditors, TypInfo;

type

  { TActivePage98Property }
  TActivePage98Property = class(TComponentProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TPageControl98Editor }

  TPageControl98Editor = class(TDefaultEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): Ansistring; override;
    function GetVerbCount: Integer; override;
  end;

procedure Register;

implementation

uses
  PageControl98;

const
  StrAddPage = 'New Sheet';
  StrNextPage = 'Next Sheet';
  StrPrevPage = 'Prev Sheet';

function TActivePage98Property.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TActivePage98Property.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Component: TComponent;
begin
  for I := 0 to Designer.Root.ComponentCount - 1 do
  begin
    Component := Designer.Root.Components[I];
    if (Component.Name <> '') and (Component is TTabSheet98) and
      (TTabSheet98(Component).PageControl = GetComponent(0)) then
      Proc(Component.Name);
  end;
end;

procedure TPageControl98Editor.ExecuteVerb(Index: Integer);
var
  PageControl: TCustomPageControl98;
  Page: TTabSheet98;
  Designer: IDesigner;
begin
  if Component is TTabSheet98 then
    PageControl := TTabSheet98(Component).PageControl else
    PageControl := TPageControl98(Component);
  if PageControl <> nil then
  begin
    Designer := Self.Designer;
    if Index = 0 then
    begin
      Page := TTabSheet98.Create(Designer.Root);
      try
        Page.Name := Designer.UniqueName(TTabSheet98.ClassName);
        Page.Parent := PageControl;
        Page.PageControl := PageControl;
      except
        Page.Free;
        raise;
      end;
      PageControl.ActivePage := Page;
      Designer.SelectComponent(Page);
      Designer.Modified;
    end else
    begin
      Page := PageControl.FindNextPage(PageControl.ActivePage,
        Index = 1, False);
      if (Page <> nil) and (Page <> PageControl.ActivePage) then
      begin
        PageControl.ActivePage := Page;
        if Component is TTabSheet98 then Designer.SelectComponent(Page);
        Designer.Modified;
      end;
    end;
  end;
end;

function TPageControl98Editor.GetVerb(Index: Integer): AnsiString;
begin
  case Index of
    0 : Result:= StrAddPage;
    1 : Result:= StrNextPage;
    2 : Result:= StrPrevPage;
  end;
end;

function TPageControl98Editor.GetVerbCount: Integer;
begin
  Result := 3;
end;

procedure Register;
begin
  RegisterComponents('Travail', [TPageControl98]);
  RegisterClasses([TTabSheet98]);
  RegisterComponentEditor(TPageControl98, TPageControl98Editor);
  RegisterComponentEditor(TTabSheet98, TPageControl98Editor);
  RegisterPropertyEditor(TypeInfo(TTabSheet98), TPageControl98, 'ActivePage', TActivePage98Property);
end;

end.
