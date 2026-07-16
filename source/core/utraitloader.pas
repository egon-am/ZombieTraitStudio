unit uTraitLoader;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,
    IniFiles,

    uTrait,
    uTraitCollection;


type

    { TTraitLoader }

    TTraitLoader = class

    private

        FFolder: String;


        procedure LoadFile(
            const AFileName: String;
            const ATraits: TTraitCollection
        );


    public

        constructor Create(
            const AFolder: String
        );


        procedure Load(
            const ATraits: TTraitCollection
        );


        property Folder: String
            read FFolder;

    end;


implementation


constructor TTraitLoader.Create(
    const AFolder: String
);
begin
    inherited Create;


    FFolder :=
        IncludeTrailingPathDelimiter(
            ExpandFileName(
                AFolder
            )
        );
end;


procedure TTraitLoader.Load(
    const ATraits: TTraitCollection
);
var
    Search: TSearchRec;
begin
    if not DirectoryExists(FFolder) then
    begin
        Exit;
    end;


    if FindFirst(
        FFolder + '*.ini',
        faAnyFile,
        Search
    ) = 0 then
    begin
        try

            repeat

                LoadFile(
                    FFolder + Search.Name,
                    ATraits
                );


            until FindNext(Search) <> 0;


        finally

            FindClose(Search);

        end;
    end;
end;


procedure TTraitLoader.LoadFile(
    const AFileName: String;
    const ATraits: TTraitCollection
);
var
    Ini: TIniFile;
    Trait: TTrait;
begin
    Ini :=
        TIniFile.Create(
            AFileName
        );

    try

        Trait :=
            TTrait.Create;


        try

            Trait.Id :=
                Ini.ReadString(
                    'trait',
                    'id',
                    ''
                );


            Trait.Name :=
                Ini.ReadString(
                    'trait',
                    'name',
                    ''
                );


            Trait.Category :=
                Ini.ReadString(
                    'trait',
                    'category',
                    ''
                );


            Trait.Description :=
                Ini.ReadString(
                    'description',
                    'text',
                    ''
                );


            Trait.ThumbnailFile :=
                Ini.ReadString(
                    'files',
                    'thumbnail',
                    ''
                );


            Trait.MaskFile :=
                Ini.ReadString(
                    'files',
                    'mask',
                    ''
                );


            ATraits.Add(
                Trait
            );


        except

            Trait.Free;

            raise;

        end;


    finally

        Ini.Free;

    end;
end;


end.
