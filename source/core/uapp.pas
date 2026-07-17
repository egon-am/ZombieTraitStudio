unit uApp;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,

    uConfig,
    uLogger,
    uPaths,
    uImage,
    uTraitCollection,
    uTraitLoader,
    uMaskManager;


type

    { TApp }

    TApp = class

    private

        FConfig: TAppConfig;

        FLogger: TLogger;

        FPaths: TPaths;

        FImage: TImageAsset;

        FTraits: TTraitCollection;

        FTraitLoader: TTraitLoader;

        FMaskManager: TMaskManager;


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


        property Traits: TTraitCollection
            read FTraits;


        property Masks: TMaskManager
            read FMaskManager;

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


    FTraits :=
        TTraitCollection.Create;


    FTraitLoader :=
        TTraitLoader.Create(
            FPaths.ApplicationFolder +
            'traits' +
            PathDelim +
            'metadata'
        );


    FMaskManager :=
        TMaskManager.Create;
end;



destructor TApp.Destroy;
begin
    FreeAndNil(
        FMaskManager
    );


    FreeAndNil(
        FTraitLoader
    );


    FreeAndNil(
        FTraits
    );


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
    FConfig.Load;


    FTraitLoader.Load(
        FTraits
    );


    FLogger.Info(
        'Application started'
    );
end;



procedure TApp.Stop;
begin
    FConfig.Save;


    FLogger.Info(
        'Application stopped'
    );
end;



end.
