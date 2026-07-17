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

        FBitmap: TBitmap;


    public

        constructor Create;

        destructor Destroy;
            override;


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


        procedure SetPixel(
            X,
            Y: Integer;
            Value: Byte
        );


        function GetPixel(
            X,
            Y: Integer
        ): Byte;


        procedure Assign(
            ASource: TMask
        );


        property Bitmap: TBitmap
            read FBitmap;

    end;


implementation


constructor TMask.Create;
begin
    inherited Create;


    FBitmap :=
        TBitmap.Create;


    FBitmap.PixelFormat :=
        pf24bit;
end;



destructor TMask.Destroy;
begin
    FBitmap.Free;


    inherited Destroy;
end;



procedure TMask.Clear;
begin
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
    if not FileExists(AFileName) then
    begin
        Exit;
    end;


    FBitmap.LoadFromFile(
        AFileName
    );


    FBitmap.PixelFormat :=
        pf24bit;
end;



procedure TMask.SaveToFile(
    const AFileName: String
);
begin
    FBitmap.SaveToFile(
        AFileName
    );
end;



procedure TMask.SetPixel(
    X,
    Y: Integer;
    Value: Byte
);
var
    C: TColor;

begin
    if (X < 0) or
       (Y < 0) or
       (X >= FBitmap.Width) or
       (Y >= FBitmap.Height) then
    begin
        Exit;
    end;


    C :=
        RGBToColor(
            Value,
            Value,
            Value
        );


    FBitmap.Canvas.Pixels[X,Y] :=
        C;
end;



function TMask.GetPixel(
    X,
    Y: Integer
): Byte;
var
    C: TColor;

begin
    Result :=
        0;


    if (X < 0) or
       (Y < 0) or
       (X >= FBitmap.Width) or
       (Y >= FBitmap.Height) then
    begin
        Exit;
    end;


    C :=
        FBitmap.Canvas.Pixels[X,Y];


    Result :=
        (Red(C) +
         Green(C) +
         Blue(C)) div 3;
end;



procedure TMask.Assign(
    ASource: TMask
);
begin
    if not Assigned(ASource) then
    begin
        Exit;
    end;


    FBitmap.Assign(
        ASource.Bitmap
    );
end;



end.
