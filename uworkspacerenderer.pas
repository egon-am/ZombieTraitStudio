unit uWorkspaceRenderer;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,
    Graphics,

    BGRABitmap,
    BGRABitmapTypes,

    uImage,
    uMask;

type

    { TWorkspaceRenderer }

    TWorkspaceRenderer = class

    private

        FBitmap: TBGRABitmap;

    public

        constructor Create;

        destructor Destroy; override;


        procedure Clear;


        procedure Render(
            AImage: TImageAsset;
            AMask: TMask
        );


        procedure DrawToCanvas(
            ACanvas: TCanvas;
            X,
            Y: Integer
        );


        property Bitmap: TBGRABitmap
            read FBitmap;

    end;

implementation

constructor TWorkspaceRenderer.Create;
begin
    inherited Create;

    FBitmap :=
        nil;
end;



destructor TWorkspaceRenderer.Destroy;
begin
    FreeAndNil(
        FBitmap
    );

    inherited Destroy;
end;



procedure TWorkspaceRenderer.Clear;
begin
    FreeAndNil(
        FBitmap
    );
end;



procedure TWorkspaceRenderer.Render(
    AImage: TImageAsset;
    AMask: TMask
);

var
    MaskBGRA: TBGRABitmap;

    x: Integer;
    y: Integer;

    C: TColor;

begin

    Clear;


    if (AImage = nil) or
       (not AImage.IsLoaded) then
    begin
        Exit;
    end;


    FBitmap :=
        TBGRABitmap.Create(
            AImage.Picture.Bitmap
        );


    if (AMask = nil) or
       (not AMask.IsLoaded) then
    begin
        Exit;
    end;


    MaskBGRA :=
        TBGRABitmap.Create(
            AMask.Bitmap
        );

    try

        for y := 0 to MaskBGRA.Height - 1 do
        begin
            for x := 0 to MaskBGRA.Width - 1 do
            begin

                C :=
                    AMask.Bitmap.Canvas.Pixels[
                        x,
                        y
                    ];


                if C <> clBlack then
                begin
                    FBitmap.FillRect(
                        x,
                        y,
                        x + 1,
                        y + 1,
                        BGRA(
                            255,
                            0,
                            0,
                            120
                        ),
                        dmDrawWithTransparency
                    );
                end;

            end;
        end;

    finally

        MaskBGRA.Free;

    end;

end;



procedure TWorkspaceRenderer.DrawToCanvas(
    ACanvas: TCanvas;
    X,
    Y: Integer
);
begin
    if not Assigned(
        FBitmap
    ) then
    begin
        Exit;
    end;


    FBitmap.Draw(
        ACanvas,
        X,
        Y,
        True
    );
end;

end.
