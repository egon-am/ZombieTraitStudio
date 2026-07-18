  unit uImage;

  {$mode ObjFPC}{$H+}

  interface

  uses
      Classes,
      SysUtils,
      Graphics,

      uMask;


  type

      { TImageAsset }

      TImageAsset = class

      private

          FFileName: String;

          FWidth: Integer;

          FHeight: Integer;

          FPicture: TPicture;

          FMask: TMask;


          procedure UpdateDimensions;


      public

          constructor Create;

          destructor Destroy; override;


          procedure Clear;


          procedure LoadFromFile(
              const AFileName: String
          );


          procedure LoadMask(
              const AFileName: String
          );


          procedure ClearMask;


          function IsLoaded: Boolean;


          function HasMask: Boolean;


          property FileName: String
              read FFileName;


          property Width: Integer
              read FWidth;


          property Height: Integer
              read FHeight;


          property Picture: TPicture
              read FPicture;


          property Mask: TMask
              read FMask;

      end;


  implementation



  constructor TImageAsset.Create;
  begin
      inherited Create;


      FPicture :=
          TPicture.Create;


      FMask :=
          TMask.Create;


      Clear;
  end;



  destructor TImageAsset.Destroy;
  begin
      FreeAndNil(
          FMask
      );


      FreeAndNil(
          FPicture
      );


      inherited Destroy;
  end;



  procedure TImageAsset.Clear;
  begin
      FFileName :=
          '';


      FWidth :=
          0;


      FHeight :=
          0;


      FPicture.Clear;


      ClearMask;
  end;



  procedure TImageAsset.LoadFromFile(
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


      FPicture.LoadFromFile(
          AFileName
      );


      FFileName :=
          ExpandFileName(
              AFileName
          );


      UpdateDimensions;
  end;



  procedure TImageAsset.LoadMask(
      const AFileName: String
  );
  begin
      FMask.LoadFromFile(
          AFileName
      );
  end;



  procedure TImageAsset.ClearMask;
  begin
      FMask.Clear;
  end;



  procedure TImageAsset.UpdateDimensions;
  begin
      if Assigned(
          FPicture.Graphic
      ) then
      begin
          FWidth :=
              FPicture.Width;


          FHeight :=
              FPicture.Height;
      end;
  end;



  function TImageAsset.IsLoaded: Boolean;
  begin
      Result :=
          FFileName <> '';
  end;



  function TImageAsset.HasMask: Boolean;
  begin
      Result :=
          FMask.IsLoaded;
  end;



  end.
