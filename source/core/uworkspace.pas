unit uWorkspace;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,

    uImage,
    uMask,
    uTrait;


type

    { TWorkspace }

    TWorkspace = class

    private

        FImage: TImageAsset;

        FTrait: TTrait;

        FMask: TMask;


    public

        constructor Create;

        destructor Destroy; override;


        procedure Clear;


        procedure SetImage(
            const AImage: TImageAsset
        );


        procedure SetTrait(
            const ATrait: TTrait
        );


        procedure LoadMask(
            const AFileName: String
        );


        property Image: TImageAsset
            read FImage;


        property Trait: TTrait
            read FTrait;


        property Mask: TMask
            read FMask;

    end;


implementation



constructor TWorkspace.Create;
begin
    inherited Create;


    FImage :=
        TImageAsset.Create;


    FMask :=
        TMask.Create;


    FTrait :=
        nil;
end;



destructor TWorkspace.Destroy;
begin
    FreeAndNil(
        FMask
    );


    FreeAndNil(
        FImage
    );


    inherited Destroy;
end;



procedure TWorkspace.Clear;
begin
    FImage.Clear;


    FMask.Clear;


    FTrait :=
        nil;
end;



procedure TWorkspace.SetImage(
    const AImage: TImageAsset
);
begin
    if not Assigned(
        AImage
    ) then
    begin
        FImage.Clear;
        Exit;
    end;


    FImage.Picture.Assign(
        AImage.Picture
    );


    FImage.LoadMask(
        ''
    );
end;



procedure TWorkspace.SetTrait(
    const ATrait: TTrait
);
begin
    FTrait :=
        ATrait;


    FMask.Clear;


    if not Assigned(
        FTrait
    ) then
    begin
        Exit;
    end;


    if FileExists(
        FTrait.MaskFile
    ) then
    begin
        FMask.LoadFromFile(
            FTrait.MaskFile
        );
    end;
end;



procedure TWorkspace.LoadMask(
    const AFileName: String
);
begin
    FMask.LoadFromFile(
        AFileName
    );
end;



end.
