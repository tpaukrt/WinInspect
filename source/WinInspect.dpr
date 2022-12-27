// SPDX-License-Identifier: BSD-3-Clause
// Copyright (C) 2001 Tomas Paukrt

program WinInspect;

uses
  Forms,
  uMain in 'uMain.pas' {FormMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Window Inspector';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
