program PassGen;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,
  sysutils;

procedure GenerateBytes(var Bytes: array of Byte);
var
  I: Integer;
begin
  Randomize;
  for I:=0 to Length(Bytes)-1 do
  begin
      Bytes[I] := Random(256);
  end;
end;

procedure WriteBytes(Bytes: array of Byte);
var
  B: Byte;
  S: string = '';
begin
  for B in Bytes do
    S := S + Format('%.2X',[B]);
  Write(S);
end;

var
  Password: array [1..16] of Byte;
begin
  Randomize;
  GenerateBytes(Password);
  WriteBytes(Password); Writeln;
end.

