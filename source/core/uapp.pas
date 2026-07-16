unit uApp;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,

    uConfig,
    uLogger,
    uPaths,
    uImage;


type

    { TApp }

    TApp = class

    private

        FConfig: TAppConfig;

        FLogger: TLogger;

        FPaths: TPaths;

        FImage: TImageAsset;


    public

        constructor Create;

        destructor Destroy; override;


        procedure Start;

        procedure Stop;


        property Config: TAppConfig
            read FConfig;


        property Logger: TLogger
            read FLogger;


        property Paths: TPaths
            read FPaths;


        property Image: TImageAsset
            read FImage;

    end;


implementation


constructor TApp.Create;
begin
    inherited Create;


    FPaths :=
        TPaths.Create;


    FLogger :=
        TLogger.Create(
        FPaths.ApplicationFolder +
        'logs' +
        PathDelim +
        'application.log'
    );


    FConfig :=
        TAppConfig.Create(
        FPaths.ApplicationFolder +
        'config' +
        PathDelim +
        'app.ini'
    );


    FImage :=
        TImageAsset.Create;
end;


destructor TApp.Destroy;
begin
    FreeAndNil(
        FImage
    );


    FreeAndNil(
        FConfig
    );


    FreeAndNil(
        FLogger
    );


    FreeAndNil(
        FPaths
    );


    inherited Destroy;
end;


procedure TApp.Start;
begin
    FLogger.Info(
        'Application started'
    );
end;


procedure TApp.Stop;
begin
    FLogger.Info(
        'Application stopped'
    );
end;


end.
