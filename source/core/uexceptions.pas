unit uExceptions;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils;


type

    { Alap alkalmazási kivétel }

    EAppException = class(Exception);


    { Konfigurációs hiba }

    EConfigException = class(EAppException);


    { Fájlkezelési hiba }

    EFileException = class(EAppException);


    { Képkezelési hiba }

    EImageException = class(EAppException);


    { AI feldolgozási hiba }

    EAIException = class(EAppException);


    { ComfyUI kommunikációs hiba }

    EComfyException = class(EAppException);



implementation

end.
