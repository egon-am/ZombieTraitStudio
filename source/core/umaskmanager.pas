unit uMaskManager;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,

    uMask,
    uTrait;


type

    { TMaskManager }

    TMaskManager = class

    private

        FCurrentMask: TMask;


    public

        constructor Create;

        destructor Destroy;
            override;


        procedure Clear;


        procedure Load(
            const AFileName: String
        );


        procedure Save(
            const AFileName: String
        );


        procedure CreateEmpty(
            AWidth,
            AHeight: Integer
        );


        procedure AssignFromTrait(
            ATrait: TTrait
        );


        function HasMask: Boolean;


        property CurrentMask: TMask
            read FCurrentMask;

    end;


implementation



constructor TMaskManager.Create;
begin
    inherited Create;


    FCurrentMask :=
        TMask.Create;
end;



destructor TMaskManager.Destroy;
begin
    FCurrentMask.Free;


    inherited Destroy;
end;



procedure TMaskManager.Clear;
begin
    FCurrentMask.Clear;
end;



procedure TMaskManager.Load(
    const AFileName: String
);
begin
    FCurrentMask.LoadFromFile(
        AFileName
    );
end;



procedure TMaskManager.Save(
    const AFileName: String
);
begin
    FCurrentMask.SaveToFile(
        AFileName
    );
end;



procedure TMaskManager.CreateEmpty(
    AWidth,
    AHeight: Integer
);
begin
    FCurrentMask.CreateEmpty(
        AWidth,
        AHeight
    );
end;



procedure TMaskManager.AssignFromTrait(
    ATrait: TTrait
);
begin
    if not Assigned(ATrait) then
    begin
        Exit;
    end;


    if ATrait.MaskFile = '' then
    begin
        Clear;
        Exit;
    end;


    if not FileExists(
        ATrait.MaskFile
    ) then
    begin
        Clear;
        Exit;
    end;


    Load(
        ATrait.MaskFile
    );
end;



function TMaskManager.HasMask: Boolean;
begin
    Result :=
        Assigned(FCurrentMask.Bitmap)
        and
        (FCurrentMask.Bitmap.Width > 0)
        and
        (FCurrentMask.Bitmap.Height > 0);
end;



end.
