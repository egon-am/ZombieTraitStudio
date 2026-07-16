unit uTrait;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils;


type

    { TTrait }

    TTrait = class

    private

        FId: String;

        FName: String;

        FCategory: String;


        FDescription: String;


        FThumbnailFile: String;

        FMaskFile: String;


    public

        constructor Create;


        property Id: String
            read FId
            write FId;


        property Name: String
            read FName
            write FName;


        property Category: String
            read FCategory
            write FCategory;


        property Description: String
            read FDescription
            write FDescription;


        property ThumbnailFile: String
            read FThumbnailFile
            write FThumbnailFile;


        property MaskFile: String
            read FMaskFile
            write FMaskFile;

    end;


implementation


constructor TTrait.Create;
begin
    inherited Create;


    FId :=
        '';


    FName :=
        '';


    FCategory :=
        '';


    FDescription :=
        '';


    FThumbnailFile :=
        '';


    FMaskFile :=
        '';
end;


end.
