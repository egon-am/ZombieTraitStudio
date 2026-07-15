unit uPaths;

{$mode ObjFPC}{$H+}

interface

uses 
    SysUtils;


type

    { Projekt útvonalkezelő }

    TPaths = class
    private
        FApplicationFolder: String;
        FSourceFolder: String;

        FDocsFolder: String;
        FExamplesFolder: String;
        FOutputFolder: String;
        FTempFolder: String;
        FWorkflowsFolder: String;

        FTraitsFolder: String;
        FTraitThumbnailFolder: String;
        FTraitMaskFolder: String;
        FTraitMetadataFolder: String;

        FThirdPartyFolder: String;
        FToolsFolder: String;
        FTestsFolder: String;

        procedure InitializePaths;

    public

        constructor Create;
        destructor Destroy; override;


        property ApplicationFolder: String
            read FApplicationFolder;

        property SourceFolder: String
            read FSourceFolder;


        property DocsFolder: String
            read FDocsFolder;

        property ExamplesFolder: String
            read FExamplesFolder;

        property OutputFolder: String
            read FOutputFolder;

        property TempFolder: String
            read FTempFolder;

        property WorkflowsFolder: String
            read FWorkflowsFolder;


        property TraitsFolder: String
            read FTraitsFolder;

        property TraitThumbnailFolder: String
            read FTraitThumbnailFolder;

        property TraitMaskFolder: String
            read FTraitMaskFolder;

        property TraitMetadataFolder: String
            read FTraitMetadataFolder;


        property ThirdPartyFolder: String
            read FThirdPartyFolder;

        property ToolsFolder: String
            read FToolsFolder;

        property TestsFolder: String
            read FTestsFolder;

    end;


implementation


constructor TPaths.Create;
begin
    inherited Create;

    InitializePaths;
end;


destructor TPaths.Destroy;
begin
    inherited Destroy;
end;


procedure TPaths.InitializePaths;
begin
    FApplicationFolder :=
        IncludeTrailingPathDelimiter(
            ExtractFilePath(ParamStr(0))
        );


    FSourceFolder :=
        FApplicationFolder + 'source' + PathDelim;


    FDocsFolder :=
        FApplicationFolder + 'docs' + PathDelim;


    FExamplesFolder :=
        FApplicationFolder + 'examples' + PathDelim;


    FOutputFolder :=
        FApplicationFolder + 'output' + PathDelim;


    FTempFolder :=
        FApplicationFolder + 'temp' + PathDelim;


    FWorkflowsFolder :=
        FApplicationFolder + 'workflows' + PathDelim;


    FTraitsFolder :=
        FApplicationFolder + 'traits' + PathDelim;


    FTraitThumbnailFolder :=
        FTraitsFolder + 'thumbnails' + PathDelim;


    FTraitMaskFolder :=
        FTraitsFolder + 'masks' + PathDelim;


    FTraitMetadataFolder :=
        FTraitsFolder + 'metadata' + PathDelim;


    FThirdPartyFolder :=
        FApplicationFolder + 'thirdparty' + PathDelim;


    FToolsFolder :=
        FApplicationFolder + 'tools' + PathDelim;


    FTestsFolder :=
        FApplicationFolder + 'tests' + PathDelim;
end;


end.
