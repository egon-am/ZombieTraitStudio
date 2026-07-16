unit uUtils;

{$mode ObjFPC}{$H+}

interface

uses
    SysUtils;

function EnsureTrailingPathDelimiter(const APath: String): String;

function IsNullOrWhiteSpace(const AText: String): Boolean;

function BoolToYesNo(const AValue: Boolean): String;

function BoolToOnOff(const AValue: Boolean): String;

implementation

function EnsureTrailingPathDelimiter(const APath: String): String;
begin
    Result := IncludeTrailingPathDelimiter(APath);
end;

function IsNullOrWhiteSpace(const AText: String): Boolean;
begin
    Result := Trim(AText) = '';
end;

function BoolToYesNo(const AValue: Boolean): String;
begin
    if AValue then
    begin
        Result := 'Yes';
    end
    else
    begin
        Result := 'No';
    end;
end;

function BoolToOnOff(const AValue: Boolean): String;
begin
    if AValue then
    begin
        Result := 'On';
    end
    else
    begin
        Result := 'Off';
    end;
end;

end.
