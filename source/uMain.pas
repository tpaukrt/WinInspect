// SPDX-License-Identifier: BSD-3-Clause
// Copyright (C) 2001 Tomas Paukrt

unit uMain;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls;

// *****************************************************************************
// *****************************************************************************

type
  TFormMain = class(TForm)
    ImageWindow     : TImage;
    ImageCross      : TImage;
    Panel           : TPanel;
    //
    GroupBox        : TGroupBox;
    LabelText       : TLabel;
    LabelClass      : TLabel;
    LabelChildText  : TLabel;
    LabelChildClass : TLabel;
    EditText        : TEdit;
    EditClass       : TEdit;
    EditChildText   : TEdit;
    EditChildClass  : TEdit;
    //
    procedure FormCreate(Sender : TObject);
    procedure ImageWindowMouseDown(Sender : TObject; Button : TMouseButton;
                                   Shift : TShiftState; X, Y : Integer);
    procedure ImageWindowMouseUp(Sender : TObject; Button : TMouseButton;
                                 Shift : TShiftState; X, Y : Integer);
    procedure ImageWindowMouseMove(Sender : TObject;
                                   Shift: TShiftState; X, Y : Integer);
  end;

var
  FormMain : TFormMain;

// *****************************************************************************
// *****************************************************************************

implementation

{$R *.DFM}

const
  crMyCursor = 10;

// *****************************************************************************
// *****************************************************************************

// -----------------------------------------------------------------------------
// event - mouse button pressed
procedure TFormMain.ImageWindowMouseDown(Sender : TObject; Button : TMouseButton;
                                         Shift : TShiftState; X, Y : Integer);
begin
  // hide the image of the cross
  ImageCross.Visible := False;

  // switch to the custom cursor
  Screen.Cursor := crMyCursor;

  // set the mouse capture
  SetCapture(Handle);
end;

// -----------------------------------------------------------------------------
// event - mouse button released
procedure TFormMain.ImageWindowMouseUp(Sender : TObject; Button : TMouseButton;
                                       Shift : TShiftState; X, Y : Integer);
begin
  // show the image of the cross 
  ImageCross.Visible := True;

  // switch to the default cursor
  Screen.Cursor := crDefault;

  // release the mouse capture
  ReleaseCapture;
end;

// -----------------------------------------------------------------------------
// event - mouse moved
procedure TFormMain.ImageWindowMouseMove(Sender : TObject;
                                         Shift : TShiftState; X, Y : Integer);
var
  H, HChild : THandle;
  P         : TPoint;
  S         : array [1..256] of char;
begin
  // exit if the cross is not being dragged
  if ImageCross.Visible then
    Exit;

  // get the absolute screen coordinates
  P.X := (Sender as TGraphicControl).Left + X;
  P.Y := (Sender as TGraphicControl).Top + Y;
  P := ClientToScreen(P);

  // get handles of windows on the absolute screen coordinates
  H := WindowFromPoint(P);
  if GetParent(H) = 0 then begin
    HChild := 0;
  end else begin
    HChild := H;
    while GetParent(H) <> 0 do
      H := GetParent(H);
  end;

  // get the text and the class name of the window
  GetWindowText(H, @S, SizeOf(S));
  EditText.Text := S;
  GetClassName(H, @S, SizeOf(S));
  EditClass.Text := S;

  // get the text and the class name of the child window
  if HChild <> 0 then begin
    GetWindowText(HChild, @S, SizeOf(S));
    EditChildText.Text := S;
    GetClassName(HChild, @S, SizeOf(S));
    EditChildClass.Text := S;
  end else begin
    EditChildText.Text := '';
    EditChildClass.Text := '';
  end;
end;

// -----------------------------------------------------------------------------
// event - form created
procedure TFormMain.FormCreate(Sender: TObject);
begin
  // assign the custom cursor
  Screen.Cursors[crMyCursor] := LoadCursor(HInstance, 'TARGET');
end;

// *****************************************************************************
// *****************************************************************************

end.
