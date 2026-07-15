unit uLogger;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TLogLevel = (
    llInfo,
    llWarning,
    llError
  );

  TLogger = class
  private
    FLogFileName: string;

    procedure WriteLog(const ALevel: TLogLevel; const AMessage: string);
    function LevelToString(const ALevel: TLogLevel): string;

  public
    constructor Create(const ALogFileName: string);
    destructor Destroy; override;

    procedure Info(const AMessage: string);
    procedure Warning(const AMessage: string);
    procedure Error(const AMessage: string);

    property LogFileName: string read FLogFileName;
  end;

implementation

constructor TLogger.Create(const ALogFileName: string);
begin
  inherited Create;

  FLogFileName := ALogFileName;
end;

destructor TLogger.Destroy;
begin
  inherited Destroy;
end;

function TLogger.LevelToString(const ALevel: TLogLevel): string;
begin
  case ALevel of
    llInfo:
      Result := 'INFO';

    llWarning:
      Result := 'WARNING';

    llError:
      Result := 'ERROR';
  end;
end;

procedure TLogger.WriteLog(const ALevel: TLogLevel; const AMessage: string);
var
  F: TextFile;
begin
  AssignFile(F, FLogFileName);

  if FileExists(FLogFileName) then
    Append(F)
  else
    Rewrite(F);

  try
    WriteLn(
      F,
      Format(
        '%s [%s] %s',
        [
          FormatDateTime('yyyy-mm-dd hh:nn:ss', Now),
          LevelToString(ALevel),
          AMessage
        ]
      )
    );
  finally
    CloseFile(F);
  end;
end;

procedure TLogger.Info(const AMessage: string);
begin
  WriteLog(llInfo, AMessage);
end;

procedure TLogger.Warning(const AMessage: string);
begin
  WriteLog(llWarning, AMessage);
end;

procedure TLogger.Error(const AMessage: string);
begin
  WriteLog(llError, AMessage);
end;

end.
