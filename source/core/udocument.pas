unit uDocument;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,
    Graphics;


type

    { TDocument }

    TDocument = class

    private

        FFileName: String;

        FImage: TPicture;


    public

        constructor Create;

        destructor Destroy; override;


        procedure Clear;


        procedure LoadImage(
            const AFileName: String
        );


        function HasImage: Boolean;


        property FileName: String
            read FFileName;


        property Image: TPicture
            read FImage;

    end;


implementation


constructor TDocument.Create;
begin
    inherited Create;


    FImage :=
        TPicture.Create;


    Clear;
end;


destructor TDocument.Destroy;
begin
    FreeAndNil(
        FImage
    );


    inherited Destroy;
end;


procedure TDocument.Clear;
begin
    FFileName :=
        '';


    FImage.Clear;
end;


procedure TDocument.LoadImage(
    const AFileName: String
);
begin
    FImage.LoadFromFile(
        AFileName
    );


    FFileName :=
        AFileName;
end;


function TDocument.HasImage: Boolean;
begin
    Result :=
        FFileName <> '';
end;


end.
