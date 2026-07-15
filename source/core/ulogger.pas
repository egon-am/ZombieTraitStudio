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

  TLogEvent = procedure(
    Sender: TObject;
    const ATimeStamp: TDateTime;
    const ALevel: TLogLevel;
    const AMessage: string
  ) of object;

  TLogger = class
  private
    FLogFileName: string;
    FOnLog: TLogEvent;

    procedure WriteLog(
      const ALevel: TLogLevel;
      const AMessage: string
    );

    function LevelToString(
      const ALevel: TLogLevel
    ): string;

    procedure EnsureLogFolder;

  public
    constructor Create(
      const ALogFileName: string
    );

    destructor Destroy; override;

    procedure Info(const AMessage: string);
    procedure Warning(const AMessage: string);
    procedure Error(const AMessage: string);

    property LogFileName: string
      read FLogFileName;

    property OnLog: TLogEvent
      read FOnLog
      write FOnLog;
  end;

implementation

constructor TLogger.Create(const ALogFileName: string);
begin
  inherited Create;

  FLogFileName := ExpandFileName(ALogFileName);

  EnsureLogFolder;
end;

destructor TLogger.Destroy;
begin
  inherited Destroy;
end;

procedure TLogger.EnsureLogFolder;
var
  Dir: String;
begin
  Dir := ExtractFilePath(FLogFileName);

  if (Dir <> '') and (not DirectoryExists(Dir)) then
    ForceDirectories(Dir);
end;

function TLogger.LevelToString(
  const ALevel: TLogLevel
): string;
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

procedure TLogger.WriteLog(
  const ALevel: TLogLevel;
  const AMessage: string
);
var
  F : TextFile;
  TS : TDateTime;
  S : String;
begin
  TS := Now;

  S := Format(
    '%s [%s] %s',
    [
      FormatDateTime(
        'yyyy-mm-dd hh:nn:ss',
        TS
      ),
      LevelToString(ALevel),
      AMessage
    ]
  );

  AssignFile(F, FLogFileName);

  if FileExists(FLogFileName) then
    Append(F)
  else
    Rewrite(F);

  try
    WriteLn(F, S);
  finally
    CloseFile(F);
  end;

  if Assigned(FOnLog) then
    FOnLog(
      Self,
      TS,
      ALevel,
      AMessage
    );
end;

procedure TLogger.Info(
  const AMessage: string
);
begin
  WriteLog(llInfo, AMessage);
end;

procedure TLogger.Warning(
  const AMessage: string
);
begin
  WriteLog(llWarning, AMessage);
end;

procedure TLogger.Error(
  const AMessage: string
);
begin
  WriteLog(llError, AMessage);
end;

end.
