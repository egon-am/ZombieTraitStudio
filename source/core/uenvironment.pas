unit uEnvironment;

{$mode ObjFPC}{$H+}

interface

uses
    Classes,
    SysUtils;

type

    { TEnvironment }

    TEnvironment = class
    public
        class function ApplicationPath: String;

        class function HomePath: String;

        class function TempPath: String;

        class function UserName: String;

        class function ComputerName: String;

        class function IsWindows: Boolean;

        class function IsLinux: Boolean;

        class function Is64Bit: Boolean;
    end;

implementation

class function TEnvironment.ApplicationPath: String;
begin
    Result :=
        IncludeTrailingPathDelimiter(
            ExtractFilePath(ParamStr(0))
        );
end;


class function TEnvironment.HomePath: String;
begin
    Result :=
        GetEnvironmentVariable('HOME');

    if Result <> '' then
    begin
        Result :=
            IncludeTrailingPathDelimiter(Result);
    end;
end;


class function TEnvironment.TempPath: String;
begin
    Result :=
        GetTempDir(True);
end;


class function TEnvironment.UserName: String;
begin
    Result :=
        GetEnvironmentVariable('USER');

    if Result = '' then
    begin
        Result :=
            GetEnvironmentVariable('USERNAME');
    end;
end;


class function TEnvironment.ComputerName: String;
begin
    Result :=
        GetEnvironmentVariable('HOSTNAME');

    if Result = '' then
    begin
        Result :=
            GetEnvironmentVariable('COMPUTERNAME');
    end;
end;


class function TEnvironment.IsWindows: Boolean;
begin
    {$IFDEF Windows}
    Result := True;
    {$ELSE}
    Result := False;
    {$ENDIF}
end;


class function TEnvironment.IsLinux: Boolean;
begin
    {$IFDEF Linux}
    Result := True;
    {$ELSE}
    Result := False;
    {$ENDIF}
end;


class function TEnvironment.Is64Bit: Boolean;
begin
    Result :=
        SizeOf(Pointer) = 8;
end;

end.
