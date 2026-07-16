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

    uApp,
    uTrait;


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


        ImagePanel: TPanel;
        SourceImagePreview: TImage;

        TraitPreviewPanel: TPanel;
        TraitPreview: TImage;


        OpenPictureDialog: TOpenPictureDialog;

        StatusBar: TStatusBar;


        procedure FormCreate(Sender: TObject);

        procedure FormDestroy(Sender: TObject);

        procedure OpenImageMenuItemClick(Sender: TObject);

        procedure ExitMenuItemClick(Sender: TObject);

        procedure AboutMenuItemClick(Sender: TObject);

        procedure TraitListSelectItem(
            Sender: TObject;
            Item: TListItem;
            Selected: Boolean
        );


    private

        FApp: TApp;


        procedure UpdateStatus(
            const AText: String
        );


        procedure InitializeInterface;


        procedure RefreshTraitList;


        procedure ShowSelectedTrait;


        procedure LoadTraitPreview(
            const ATrait: TTrait
        );


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


        FApp.Stop;


        FreeAndNil(
            FApp
        );
    end;
end;



procedure TMainForm.InitializeInterface;
begin
    TraitList.ViewStyle :=
        vsReport;


    TraitList.Columns.Clear;


    TraitList.Columns.Add.Caption :=
        'Trait';


    TraitList.Columns.Add.Caption :=
        'Category';


    TraitInfo.Clear;


    TraitInfo.Lines.Add(
        'Trait information'
    );


    TraitInfo.Lines.Add(
        'No trait selected.'
    );


    SourceImagePreview.Stretch :=
        True;


    SourceImagePreview.Proportional :=
        True;


    TraitPreview.Stretch :=
        True;


    TraitPreview.Proportional :=
        True;


    RefreshTraitList;
end;



procedure TMainForm.RefreshTraitList;
var
    I: Integer;
    Item: TListItem;
begin
    TraitList.Items.BeginUpdate;

    try

        TraitList.Items.Clear;


        for I := 0 to FApp.Traits.Count - 1 do
        begin
            Item :=
                TraitList.Items.Add;


            Item.Caption :=
                FApp.Traits.Items[I].Name;


            Item.SubItems.Add(
                FApp.Traits.Items[I].Category
            );
        end;


    finally

        TraitList.Items.EndUpdate;

    end;
end;



procedure TMainForm.ShowSelectedTrait;
var
    Index: Integer;
    Trait: TTrait;
begin
    if TraitList.Selected = nil then
    begin
        Exit;
    end;


    Index :=
        TraitList.Selected.Index;


    if (Index < 0) or
       (Index >= FApp.Traits.Count) then
    begin
        Exit;
    end;


    Trait :=
        FApp.Traits.Items[Index];


    TraitInfo.Clear;


    TraitInfo.Lines.Add(
        'Name: ' +
        Trait.Name
    );


    TraitInfo.Lines.Add(
        'Category: ' +
        Trait.Category
    );


    TraitInfo.Lines.Add(
        ''
    );


    TraitInfo.Lines.Add(
        'Description:'
    );


    TraitInfo.Lines.Add(
        Trait.Description
    );


    TraitInfo.Lines.Add(
        ''
    );


    TraitInfo.Lines.Add(
        'Thumbnail: ' +
        Trait.ThumbnailFile
    );


    TraitInfo.Lines.Add(
        'Mask: ' +
        Trait.MaskFile
    );


    LoadTraitPreview(
        Trait
    );
end;



procedure TMainForm.LoadTraitPreview(
    const ATrait: TTrait
);
begin
    TraitPreview.Picture.Clear;


    if not Assigned(ATrait) then
    begin
        Exit;
    end;


    if ATrait.ThumbnailFile = '' then
    begin
        Exit;
    end;


    if not FileExists(
        ATrait.ThumbnailFile
    ) then
    begin
        Exit;
    end;


    TraitPreview.Picture.LoadFromFile(
        ATrait.ThumbnailFile
    );
end;



procedure TMainForm.TraitListSelectItem(
    Sender: TObject;
    Item: TListItem;
    Selected: Boolean
);
begin
    if not Selected then
    begin
        Exit;
    end;


    ShowSelectedTrait;


    UpdateStatus(
        'Trait selected: ' +
        Item.Caption
    );
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


    FApp.Image.LoadFromFile(
        OpenPictureDialog.FileName
    );


    SourceImagePreview.Picture.Assign(
        FApp.Image.Picture
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
