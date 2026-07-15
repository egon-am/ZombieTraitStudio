unit uTypes;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils;

type

    { Általános alkalmazás állapot }

    TAppState = (
        asStarting,
        asReady,
        asProcessing,
        asStopping,
        asStopped
    );


    { Naplózási szintek }

    TLogLevel = (
        llInfo,
        llWarning,
        llError,
        llDebug
    );


    { Kép feldolgozási állapot }

    TImageState = (
        isUnknown,
        isLoaded,
        isAnalyzing,
        isProcessed,
        isSaved,
        isFailed
    );


    { Trait típusa }

    TTraitType = (
        ttUnknown,
        ttVisual,
        ttFace,
        ttPose,
        ttAccessory,
        ttBackground
    );


    { Generálási állapot }

    TGenerationState = (
        gsIdle,
        gsQueued,
        gsRunning,
        gsCompleted,
        gsFailed
    );


    { Egyszerű méret struktúra }

    TSizeInfo = record
        Width: Integer;
        Height: Integer;
    end;


    { Egyszerű képinformáció }

    TImageInfo = record
        FileName: String;
        Width: Integer;
        Height: Integer;
        Format: String;
        State: TImageState;
    end;


    { Trait alapadat }

    TTraitInfo = record
        Name: String;
        Description: String;
        TraitType: TTraitType;
        Confidence: Double;
        ThumbnailFile: String;
        MaskFile: String;
    end;


implementation

end.
