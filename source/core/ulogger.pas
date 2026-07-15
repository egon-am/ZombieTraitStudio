unit uLogger;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,
    uTypes;


type

    { Napló esemény }

    TLogEvent = procedure(
        Sender: TObject;
        const ALevel: TLogLevel;
        const AMessage: String
    ) of object;


    { Alkalmazás naplózó }

    TLogger = class
    private
        FLogFileName: String;
        FOnLog: TLogEvent;

        procedure EnsureLogFolder;

        function LevelToString(
            const ALevel: TLogLevel
        ): String;

        procedure WriteLog(
            const ALevel: TLogLevel;
            const AMessage: String
        );

    public

        constructor Create(
            const AFileName: String
        );


        procedure Info(
            const AMessage: String
        );

        procedure Warning(
            const AMessage: String
        );

        procedure Error(
            const AMessage: String
        );

        procedure Debug(
            const AMessage: String
        );


        property LogFileName: String
            read FLogFileName;


        property OnLog: TLogEvent
            read FOnLog
            write FOnLog;

    end;


implementation


constructor TLogger.Create(
    const AFileName: String
);
begin
    inherited Create;

    FLogFileName :=
        ExpandFileName(AFileName);

    EnsureLogFolder;
end;


procedure TLogger.EnsureLogFolder;
var
    LogFolder: String;
begin
    LogFolder :=
        ExtractFilePath(FLogFileName);

    if (LogFolder <> '') and
       (not DirectoryExists(LogFolder)) then
    begin
        ForceDirectories(LogFolder);
    end;
end;


function TLogger.LevelToString(
    const ALevel: TLogLevel
): String;
begin
    case ALevel of

        llInfo:
            Result := 'INFO';

        llWarning:
            Result := 'WARNING';

        llError:
            Result := 'ERROR';

        llDebug:
            Result := 'DEBUG';

    else
        Result := 'UNKNOWN';

    end;
end;


procedure TLogger.WriteLog(
    const ALevel: TLogLevel;
    const AMessage: String
);
var
    LogFile: TextFile;
    Line: String;
begin
    Line :=
        Format(
            '%s [%s] %s',
            [
                FormatDateTime(
                    'yyyy-mm-dd hh:nn:ss',
                    Now
                ),
                LevelToString(ALevel),
                AMessage
            ]
        );


    AssignFile(
        LogFile,
        FLogFileName
    );


    if FileExists(FLogFileName) then
        Append(LogFile)
    else
        Rewrite(LogFile);


    try
        WriteLn(
            LogFile,
            Line
        );
    finally
        CloseFile(LogFile);
    end;


    if Assigned(FOnLog) then
    begin
        FOnLog(
            Self,
            ALevel,
            AMessage
        );
    end;
end;


procedure TLogger.Info(
    const AMessage: String
);
begin
    WriteLog(
        llInfo,
        AMessage
    );
end;


procedure TLogger.Warning(
    const AMessage: String
);
begin
    WriteLog(
        llWarning,
        AMessage
    );
end;


procedure TLogger.Error(
    const AMessage: String
);
begin
    WriteLog(
        llError,
        AMessage
    );
end;


procedure TLogger.Debug(
    const AMessage: String
);
begin
    WriteLog(
        llDebug,
        AMessage
    );
end;


end.
