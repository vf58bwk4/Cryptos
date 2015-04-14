program DEStest;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, Sysutils,
  DCPdes;

const
  MK2: array [1..16] of Byte =
    ($02,$FE,$A4,$47,$A7,$8C,$C8,$83, $69,$CF,$B1,$6B,$ED,$8F,$1C,$F2);
  IV: array [1..8] of Byte =
    ($11,$22,$33,$44,$55,$66,$77,$01);
  Src: array [1..120] of Byte =
    ($2F,$E2,$B5,$79,$61,$38,$60,$D7, $80,$73,$AB,$C0,$42,$08,$42,$0A,
     $81,$01,$22,$30,$14,$C5,$80,$66, $94,$C0,$07,$CA,$1E,$EE,$F5,$7F,
     $00,$4F,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00,
     $00,$01,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00,
     $00,$03,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00,
     $00,$05,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00,
     $00,$07,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00,
     $00,$09,$40,$00,$20,$40,$60,$80);

function HexByte(B: Byte): string;
const
  HexChar: array[0..15] of Char = '0123456789ABCDEF';
begin
  Result := HexChar[B shr 4] + HexChar[B and 15];
end;

function Bytes2Str(Bytes: array of Byte): string;
var
  I: Cardinal;
begin
  Result := '';
  for I:=Low(Bytes) to Length(Bytes)-1 do
  begin
    Result := Result + HexByte(Bytes[I]);
  end;
end;

var
  Cipher: TDCP_3des;
  Res: array of Byte;
begin
  SetLength(Res, Length(Src));
  Cipher := TDCP_3des.Create(nil);
  Cipher.Init(MK2, Length(MK2)*8, @IV);
  Cipher.EncryptCBC(Src, Res[Low(Res)], Length(Src));
  Writeln(Bytes2Str(Res));
end.

