unit uConfig;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,
    IniFiles;


type

    { Alkalmazás konfiguráció }

    TAppConfig = class
    private
        FFileName: String;

        FApplicationName: String;
        FApplicationVersion: String;

        FOutputFolder: String;
        FTempFolder: String;

        FComfyHost: String;
        FComfyPort: Integer;

        FDefaultModel: String;
        FDefaultWorkflow: String;

        procedure SetDefaults;

        procedure LoadValues(
            const Ini: TIniFile
        );

        procedure SaveValues(
            const Ini: TIniFile
        );

    public

        constructor Create(
            const AFileName: String
        );


        procedure Load;

        procedure Save;


        property FileName: String
            read FFileName;


        property ApplicationName: String
            read FApplicationName
            write FApplicationName;


        property ApplicationVersion: String
            read FApplicationVersion
            write FApplicationVersion;


        property OutputFolder: String
            read FOutputFolder
            write FOutputFolder;


        property TempFolder: String
            read FTempFolder
            write FTempFolder;


        property ComfyHost: String
            read FComfyHost
            write FComfyHost;


        property ComfyPort: Integer
            read FComfyPort
            write FComfyPort;


        property DefaultModel: String
            read FDefaultModel
            write FDefaultModel;


        property DefaultWorkflow: String
            read FDefaultWorkflow
            write FDefaultWorkflow;

    end;


implementation


constructor TAppConfig.Create(
    const AFileName: String
);
begin
    inherited Create;

    FFileName :=
        ExpandFileName(AFileName);

    SetDefaults;
end;


procedure TAppConfig.SetDefaults;
begin
    FApplicationName :=
        'Zombie Trait Studio';

    FApplicationVersion :=
        '0.1';


    FOutputFolder :=
        'output' + PathDelim;


    FTempFolder :=
        'temp' + PathDelim;


    FComfyHost :=
        '127.0.0.1';


    FComfyPort :=
        8188;


    FDefaultModel :=
        '';


    FDefaultWorkflow :=
        '';
end;


procedure TAppConfig.Load;
var
    Ini: TIniFile;
begin
    if not FileExists(FFileName) then
    begin
        Save;
        Exit;
    end;


    Ini :=
        TIniFile.Create(FFileName);

    try
        LoadValues(Ini);

    finally
        Ini.Free;
    end;
end;


procedure TAppConfig.Save;
var
    Ini: TIniFile;
    Folder: String;
begin
    Folder :=
        ExtractFilePath(FFileName);


    if (Folder <> '') and
       (not DirectoryExists(Folder)) then
    begin
        ForceDirectories(Folder);
    end;


    Ini :=
        TIniFile.Create(FFileName);

    try
        SaveValues(Ini);

    finally
        Ini.Free;
    end;
end;


procedure TAppConfig.LoadValues(
    const Ini: TIniFile
);
begin
    FApplicationName :=
        Ini.ReadString(
            'Application',
            'Name',
            FApplicationName
        );


    FApplicationVersion :=
        Ini.ReadString(
            'Application',
            'Version',
            FApplicationVersion
        );


    FOutputFolder :=
        Ini.ReadString(
            'Paths',
            'Output',
            FOutputFolder
        );


    FTempFolder :=
        Ini.ReadString(
            'Paths',
            'Temp',
            FTempFolder
        );


    FComfyHost :=
        Ini.ReadString(
            'ComfyUI',
            'Host',
            FComfyHost
        );


    FComfyPort :=
        Ini.ReadInteger(
            'ComfyUI',
            'Port',
            FComfyPort
        );


    FDefaultModel :=
        Ini.ReadString(
            'AI',
            'Model',
            FDefaultModel
        );


    FDefaultWorkflow :=
        Ini.ReadString(
            'AI',
            'Workflow',
            FDefaultWorkflow
        );
end;


procedure TAppConfig.SaveValues(
    const Ini: TIniFile
);
begin
    Ini.WriteString(
        'Application',
        'Name',
        FApplicationName
    );


    Ini.WriteString(
        'Application',
        'Version',
        FApplicationVersion
    );


    Ini.WriteString(
        'Paths',
        'Output',
        FOutputFolder
    );


    Ini.WriteString(
        'Paths',
        'Temp',
        FTempFolder
    );


    Ini.WriteString(
        'ComfyUI',
        'Host',
        FComfyHost
    );


    Ini.WriteInteger(
        'ComfyUI',
        'Port',
        FComfyPort
    );


    Ini.WriteString(
        'AI',
        'Model',
        FDefaultModel
    );


    Ini.WriteString(
        'AI',
        'Workflow',
        FDefaultWorkflow
    );
end;


end.
