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


        function ResolveFilePath(
            const AFileName: String;
            const ABaseFolder: String
        ): String;


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



function TTraitLoader.ResolveFilePath(
    const AFileName: String;
    const ABaseFolder: String
): String;
begin
    if Trim(AFileName) = '' then
    begin
        Result := '';
        Exit;
    end;


    if AFileName[1] = PathDelim then
    begin
        Result :=
            ExpandFileName(
                AFileName
            );

        Exit;
    end;


    Result :=
        ExpandFileName(
            IncludeTrailingPathDelimiter(
                ABaseFolder
            ) +
            AFileName
        );
end;



procedure TTraitLoader.Load(
    const ATraits: TTraitCollection
);
var
    Search: TSearchRec;
begin
    if not DirectoryExists(FFolder) then
        Exit;


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
    BaseFolder: String;
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


            BaseFolder :=
                ExtractFilePath(
                    AFileName
                );


            Trait.ThumbnailFile :=
                ResolveFilePath(
                    Ini.ReadString(
                        'files',
                        'thumbnail',
                        ''
                    ),
                    BaseFolder
                );


            Trait.MaskFile :=
                ResolveFilePath(
                    Ini.ReadString(
                        'files',
                        'mask',
                        ''
                    ),
                    BaseFolder
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
