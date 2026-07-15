unit uApp;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,
    uPaths,
    uConfig,
    uLogger;


type

    { Alkalmazás vezérlő }

    TApp = class
    private
        FPaths: TPaths;
        FConfig: TAppConfig;
        FLogger: TLogger;

        procedure Initialize;

    public

        constructor Create;
        destructor Destroy; override;


        procedure Start;

        procedure Shutdown;


        property Paths: TPaths
            read FPaths;


        property Config: TAppConfig
            read FConfig;


        property Logger: TLogger
            read FLogger;

    end;


implementation


constructor TApp.Create;
begin
    inherited Create;

    Initialize;
end;


destructor TApp.Destroy;
begin
    Shutdown;

    inherited Destroy;
end;


procedure TApp.Initialize;
var
    ConfigFile: String;
    LogFile: String;
begin
    FPaths :=
        TPaths.Create;


    ConfigFile :=
        FPaths.ApplicationFolder +
        'config' +
        PathDelim +
        'zombietraitstudio.ini';


    LogFile :=
        FPaths.ApplicationFolder +
        'logs' +
        PathDelim +
        'application.log';


    FConfig :=
        TAppConfig.Create(
            ConfigFile
        );


    FConfig.Load;


    FLogger :=
        TLogger.Create(
            LogFile
        );


    FLogger.Info(
        'Zombie Trait Studio initialized'
    );
end;


procedure TApp.Start;
begin
    FLogger.Info(
        'Application started'
    );
end;


procedure TApp.Shutdown;
begin
    if Assigned(FLogger) then
    begin
        FLogger.Info(
            'Application shutdown'
        );
    end;


    FreeAndNil(
        FLogger
    );


    FreeAndNil(
        FConfig
    );


    FreeAndNil(
        FPaths
    );
end;


end.
