unit uTraitCollection;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils,
    Contnrs,

    uTrait;


type

    { TTraitCollection }

    TTraitCollection = class

    private

        FItems: TObjectList;


        function GetCount: Integer;

        function GetItem(
            Index: Integer
        ): TTrait;


    public

        constructor Create;

        destructor Destroy; override;


        procedure Clear;


        procedure Add(
            ATrait: TTrait
        );


        procedure Delete(
            Index: Integer
        );


        function FindById(
            const AId: String
        ): TTrait;


        property Count: Integer
            read GetCount;


        property Items[Index: Integer]: TTrait
            read GetItem;

    end;


implementation


constructor TTraitCollection.Create;
begin
    inherited Create;


    FItems :=
        TObjectList.Create(
            True
        );
end;


destructor TTraitCollection.Destroy;
begin
    FreeAndNil(
        FItems
    );


    inherited Destroy;
end;


procedure TTraitCollection.Clear;
begin
    FItems.Clear;
end;


procedure TTraitCollection.Add(
    ATrait: TTrait
);
begin
    if Assigned(ATrait) then
    begin
        FItems.Add(
            ATrait
        );
    end;
end;


procedure TTraitCollection.Delete(
    Index: Integer
);
begin
    if (Index >= 0) and
       (Index < FItems.Count) then
    begin
        FItems.Delete(
            Index
        );
    end;
end;


function TTraitCollection.GetCount: Integer;
begin
    Result :=
        FItems.Count;
end;


function TTraitCollection.GetItem(
    Index: Integer
): TTrait;
begin
    Result := nil;


    if (Index >= 0) and
       (Index < FItems.Count) then
    begin
        Result :=
            TTrait(
                FItems[Index]
            );
    end;
end;


function TTraitCollection.FindById(
    const AId: String
): TTrait;
var
    I: Integer;
begin
    Result :=
        nil;


    for I := 0 to Count - 1 do
    begin
        if SameText(
            Items[I].Id,
            AId
        ) then
        begin
            Result :=
                Items[I];

            Exit;
        end;
    end;
end;


end.
