unit Utils;

interface

uses
  SysUtils, Classes;

function Max(a, b: Integer): Integer;
function Min(a, b: Integer): Integer;
procedure AddTrailingPathDelim(const s: String; var s2: String);
procedure AddExePath(Path: String; var Filename: String);

function ReadIniString(const AFileName, Section, Key, Default: String): String;
procedure WriteIniString(const AFileName, Section, Key, Value: String);
procedure DeleteIniSection(const AFileName: String; const ASection: String);

implementation

uses
  IniFiles, Windows;

function Max(a, b: Integer): Integer;
begin
  if a > b then
    Result := a
  else
    Result := b;
end;

function Min(a, b: Integer): Integer;
begin
  if a < b then
    Result := a
  else
    Result := b;
end;

procedure AddTrailingPathDelim(const S: String; var S2: String);
begin
  S2 := IncludeTrailingBackslash(S);
end;

procedure AddExePath(Path: String; var Filename: String);
var
  dir: string;
begin
  if Pos('\', Filename) = 0 then
  begin
    dir := '';
    
    if Path <> '' then
    begin
      AddTrailingPathDelim(Path, dir);
      Filename := dir + Filename;
    end else
    begin
      dir := ExtractFilePath(ParamStr(0));
      Path := dir;
      AddTrailingPathDelim(Path, dir);
      Filename := dir + Filename;
    end;

    while Pos('/', Filename) >= 1 do
    begin
      filename[Pos('/', Filename)] := '\';
      UniqueString(Filename);
    end;
  end;
end;

procedure LoadListFromIniFile(const Filename, Section: string; AList: TStrings);
var
  Count, I: Integer;
begin
  with TIniFile.Create(Filename) do
  try
    Count := ReadInteger(Section, 'Count', 0);
    for I := 1 to Count do
    begin
      AList.Add(ReadString(Section, IntToStr(I), ''));
    end;
  finally
    Free;
  end;
end;

// TODO: FUN_0044C330

procedure FUN_0044c3d8(s1: string; s2: String);
begin
  s2 := ParamStr(0);
  // TODO:    
end;

function EncryptString(const S: String): String;
var
  I: Integer;
begin
  SetLength(Result, Length(S));
  for I := 1 to Length(S) do
    Result[I] := Char(Ord(S[I]) + $7F);
end;

function DecryptString(const S: String): String;
var
  I: Integer;
begin
  SetLength(Result, Length(S));
  for I := 1 to Length(S) do
    Result[I] := Char(Ord(S[I]) - $7F);
end;

function ReadIniString(const AFileName, Section, Key, Default: String): String;
var
  Buffer: array[0..79] of Char;
begin
  GetPrivateProfileString(PChar(Section), PChar(Key), PChar(Default), Buffer, SizeOf(Buffer), PChar(AFileName));
  Result := StrPas(Buffer);
end;

procedure WriteIniString(const AFileName, Section, Key, Value: String);
begin
  WritePrivateProfileString(PChar(Section), PChar(Key), PChar(Value), PChar(AFileName));
end;

procedure DeleteIniSection(const AFileName: String; const ASection: String);
begin
  WritePrivateProfileString(PChar(ASection), nil, nil, PChar(AFileName));
end;

end.

