unit Esp32.Form.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Bluetooth, System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.Layouts, System.Bluetooth.Components, FMX.ListBox,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Bluetooth1: TBluetooth;
    Layout1: TLayout;
    Layout3D1: TLayout3D;
    Layout2: TLayout;
    btnListarDispositivos: TButton;
    cbxDispositivos: TComboBox;
    Layout3: TLayout;
    btnConectar: TButton;
    lblStatus: TLabel;
    Switch1: TSwitch;
    procedure btnListarDispositivosClick(Sender: TObject);
    procedure btnConectarClick(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
  private
    FSocket: TBluetoothSocket;
    function ConectarDispositivo(pDeviceName: String): boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

const
  UUID = '{00001101-0000-1000-8000-00805F9B34FB}';

procedure TForm1.btnConectarClick(Sender: TObject);
begin
  if (cbxDispositivos.Selected <> nil) and (cbxDispositivos.Selected.Text <> '') then
  begin
    if ConectarDispositivo(cbxDispositivos.Selected.Text) then
      lblStatus.Text := 'Conectado'
    else
      lblStatus.Text := 'Desconectado';
  end else begin
    ShowMessage('Selecione um dispositivo');
  end;
end;

procedure TForm1.btnListarDispositivosClick(Sender: TObject);
var
  lDevice: TBluetoothDevice;
begin
  cbxDispositivos.Items.Clear;
  for lDevice in Bluetooth1.PairedDevices do
  begin
    cbxDispositivos.Items.Add(lDevice.DeviceName);
  end;
end;


function TForm1.ConectarDispositivo(pDeviceName: String): boolean;
var
  lDevice: TBluetoothDevice;
begin
  for lDevice in Bluetooth1.PairedDevices do
  begin
    if lDevice.DeviceName = pDeviceName then
    begin
      FSocket := lDevice.CreateClientSocket(StringToGUID(UUID),True);
      if FSocket <> nil then
      begin
        FSocket.Connect;
        Result := FSocket.Connected;
      end;
    end;
  end;
end;

procedure TForm1.Switch1Switch(Sender: TObject);
var
  lDados: TBytes;
begin
  if (FSocket <> nil) and (FSocket.Connected) then
  begin
    setLength(lDados,1);
    lDados[0] := Ord(Switch1.IsChecked);
    FSocket.SendData(lDados);
  end;
end;

end.
