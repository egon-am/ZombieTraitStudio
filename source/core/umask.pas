unit uMask;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,
    Graphics;


type

    { TMask }

    TMask = class

    private

        FFileName: String;

        FBitmap: TBitmap;


    public

        constructor Create;

        destructor Destroy; override;


        procedure Clear;


        procedure CreateEmpty(
            AWidth,
            AHeight: Integer
        );


        procedure LoadFromFile(
            const AFileName: String
        );


        procedure SaveToFile(
            const AFileName: String
        );


        function IsLoaded: Boolean;


        property FileName: String
            read FFileName;


        property Bitmap: TBitmap
            read FBitmap;

    end;


implementation



constructor TMask.Create;
begin
    inherited Create;


    FBitmap :=
        TBitmap.Create;


    Clear;
end;



destructor TMask.Destroy;
begin
    FreeAndNil(
        FBitmap
    );


    inherited Destroy;
end;



procedure TMask.Clear;
begin
    FFileName :=
        '';


    FBitmap.SetSize(
        0,
        0
    );
end;



procedure TMask.CreateEmpty(
    AWidth,
    AHeight: Integer
);
begin
    Clear;


    FBitmap.SetSize(
        AWidth,
        AHeight
    );


    FBitmap.PixelFormat :=
        pf24bit;


    FBitmap.Canvas.Brush.Color :=
        clBlack;


    FBitmap.Canvas.FillRect(
        0,
        0,
        AWidth,
        AHeight
    );
end;



procedure TMask.LoadFromFile(
    const AFileName: String
);
begin
    Clear;


    if not FileExists(
        AFileName
    ) then
    begin
        Exit;
    end;


    FBitmap.LoadFromFile(
        AFileName
    );


    FFileName :=
        ExpandFileName(
            AFileName
        );
end;



procedure TMask.SaveToFile(
    const AFileName: String
);
begin
    if not Assigned(
        FBitmap
    ) then
    begin
        Exit;
    end;


    FBitmap.SaveToFile(
        AFileName
    );


    FFileName :=
        ExpandFileName(
            AFileName
        );
end;



function TMask.IsLoaded: Boolean;
begin
    Result :=
        (FFileName <> '')
        and
        Assigned(FBitmap)
        and
        (FBitmap.Width > 0)
        and
        (FBitmap.Height > 0);
end;



end.
