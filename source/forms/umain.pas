unit uMain;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,
    Forms,
    Controls,
    Graphics,
    Dialogs,
    ExtDlgs,
    ExtCtrls,
    ComCtrls,
    StdCtrls,
    Menus,

    uApp;


type

    { TMainForm }

    TMainForm = class(TForm)

        MainMenu: TMainMenu;

        FileMenu: TMenuItem;
        OpenImageMenuItem: TMenuItem;
        SeparatorMenuItem: TMenuItem;
        ExitMenuItem: TMenuItem;

        ToolsMenu: TMenuItem;
        SettingsMenuItem: TMenuItem;

        HelpMenu: TMenuItem;
        AboutMenuItem: TMenuItem;


        TraitPanel: TPanel;
        TraitSplitter: TSplitter;

        InfoPanel: TPanel;
        InfoSplitter: TSplitter;

        TraitList: TListView;
        TraitInfo: TMemo;

        ImagePreview: TImage;

        OpenPictureDialog: TOpenPictureDialog;

        StatusBar: TStatusBar;


        procedure FormCreate(Sender: TObject);

        procedure FormDestroy(Sender: TObject);

        procedure OpenImageMenuItemClick(Sender: TObject);

        procedure ExitMenuItemClick(Sender: TObject);

        procedure AboutMenuItemClick(Sender: TObject);


    private

        FApp: TApp;


        procedure UpdateStatus(
            const AText: String
        );


        procedure InitializeInterface;


    public

    end;


var
    MainForm: TMainForm;


implementation


{$R *.lfm}


procedure TMainForm.FormCreate(Sender: TObject);
begin
    FApp :=
        TApp.Create;


    FApp.Start;


    InitializeInterface;


    UpdateStatus(
        'Zombie Trait Studio ready'
    );


    FApp.Logger.Info(
        'Main form initialized'
    );
end;


procedure TMainForm.FormDestroy(Sender: TObject);
begin
    if Assigned(FApp) then
    begin
        FApp.Logger.Info(
            'Main form destroyed'
        );


        FreeAndNil(FApp);
    end;
end;


procedure TMainForm.InitializeInterface;
begin
    TraitList.ViewStyle :=
        vsReport;


    TraitList.Columns.Clear;


    TraitList.Columns.Add.Caption :=
        'Trait';


    TraitInfo.Clear;


    TraitInfo.Lines.Add(
        'Trait information'
    );


    TraitInfo.Lines.Add(
        'No trait selected.'
    );


    ImagePreview.Stretch :=
        True;


    ImagePreview.Proportional :=
        True;
end;


procedure TMainForm.UpdateStatus(
    const AText: String
);
begin
    StatusBar.SimpleText :=
        AText;
end;


procedure TMainForm.OpenImageMenuItemClick(
    Sender: TObject
);
begin
    if not OpenPictureDialog.Execute then
    begin
        Exit;
    end;


    ImagePreview.Picture.LoadFromFile(
        OpenPictureDialog.FileName
    );


    UpdateStatus(
        'Loaded: ' +
        ExtractFileName(
            OpenPictureDialog.FileName
        )
    );


    FApp.Logger.Info(
        'Image loaded: ' +
        OpenPictureDialog.FileName
    );
end;


procedure TMainForm.ExitMenuItemClick(
    Sender: TObject
);
begin
    Close;
end;


procedure TMainForm.AboutMenuItemClick(
    Sender: TObject
);
begin
    ShowMessage(
        'Zombie Trait Studio'#13#10 +
        'Version 0.1.0'
    );
end;


end.
