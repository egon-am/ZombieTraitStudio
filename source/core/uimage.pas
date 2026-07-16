unit uImage;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,
    Graphics;


type

    { TImageAsset }

    TImageAsset = class

    private

        FFileName: String;

        FWidth: Integer;

        FHeight: Integer;

        FPicture: TPicture;


        procedure UpdateDimensions;


    public

        constructor Create;

        destructor Destroy; override;


        procedure Clear;


        procedure LoadFromFile(
            const AFileName: String
        );


        function IsLoaded: Boolean;


        property FileName: String
            read FFileName;


        property Width: Integer
            read FWidth;


        property Height: Integer
            read FHeight;


        property Picture: TPicture
            read FPicture;

    end;


implementation


constructor TImageAsset.Create;
begin
    inherited Create;


    FPicture :=
        TPicture.Create;


    Clear;
end;


destructor TImageAsset.Destroy;
begin
    FreeAndNil(
        FPicture
    );


    inherited Destroy;
end;


procedure TImageAsset.Clear;
begin
    FFileName :=
        '';


    FWidth :=
        0;


    FHeight :=
        0;


    FPicture.Clear;
end;


procedure TImageAsset.LoadFromFile(
    const AFileName: String
);
begin
    Clear;


    FPicture.LoadFromFile(
        AFileName
    );


    FFileName :=
        ExpandFileName(
            AFileName
        );


    UpdateDimensions;
end;


procedure TImageAsset.UpdateDimensions;
begin
    if Assigned(
        FPicture.Graphic
    ) then
    begin
        FWidth :=
            FPicture.Width;


        FHeight :=
            FPicture.Height;
    end;
end;


function TImageAsset.IsLoaded: Boolean;
begin
    Result :=
        FFileName <> '';
end;


end.
