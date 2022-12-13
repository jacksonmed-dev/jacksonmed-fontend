// To parse this JSON data, do
//
//     final boditrakApi = boditrakApiFromJson(jsonString);

import 'dart:convert';

BoditrakApi boditrakApiFromJson(String str) =>
    BoditrakApi.fromJson(json.decode(str));

String boditrakApiToJson(BoditrakApi data) => json.encode(data.toJson());

class BoditrakApi {
  BoditrakApi({
    required this.device,
    required this.sensors,
    required this.frames,
    required this.filters,
    required this.time,
    required this.frequency,
    required this.calibrated,
    required this.firmware,
    required this.wifi,
  });

  Device device;
  List<Sensor> sensors;
  List<Frame> frames;
  Filters filters;
  DateTime time;
  int frequency;
  bool calibrated;
  Firmware firmware;
  Wifi wifi;

  factory BoditrakApi.fromJson(Map<String, dynamic> json) => BoditrakApi(
        device: Device.fromJson(json["device"]),
        sensors:
            List<Sensor>.from(json["sensors"].map((x) => Sensor.fromJson(x))),
        frames: List<Frame>.from(json["frames"].map((x) => Frame.fromJson(x))),
        filters: Filters.fromJson(json["filters"]),
        time: DateTime.parse(json["time"]),
        frequency: json["frequency"],
        calibrated: json["calibrated"],
        firmware: Firmware.fromJson(json["firmware"]),
        wifi: Wifi.fromJson(json["wifi"]),
      );

  Map<String, dynamic> toJson() => {
        "device": device.toJson(),
        "sensors": List<dynamic>.from(sensors.map((x) => x.toJson())),
        "frames": List<dynamic>.from(frames.map((x) => x.toJson())),
        "filters": filters.toJson(),
        "time": time.toIso8601String(),
        "frequency": frequency,
        "calibrated": calibrated,
        "firmware": firmware.toJson(),
        "wifi": wifi.toJson(),
      };
}

class Device {
  Device({
    required this.deviceClass,
    required this.name,
    required this.id,
    required this.address,
    required this.model,
  });

  String deviceClass;
  String name;
  String id;
  String address;
  String model;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        deviceClass: json["class"],
        name: json["name"],
        id: json["id"],
        address: json["address"],
        model: json["model"],
      );

  Map<String, dynamic> toJson() => {
        "class": deviceClass,
        "name": name,
        "id": id,
        "address": address,
        "model": model,
      };
}

class Filters {
  Filters({
    required this.spot,
    required this.smooth,
    required this.noise,
  });

  bool spot;
  bool smooth;
  bool noise;

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        spot: json["spot"],
        smooth: json["smooth"],
        noise: json["noise"],
      );

  Map<String, dynamic> toJson() => {
        "spot": spot,
        "smooth": smooth,
        "noise": noise,
      };
}

class Firmware {
  Firmware({
    required this.version,
  });

  String version;

  factory Firmware.fromJson(Map<String, dynamic> json) => Firmware(
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
      };
}

class Frame {
  Frame({
    required this.id,
    required this.time,
    required this.readings,
  });

  int id;
  DateTime time;
  List<List<int>> readings;

  factory Frame.fromJson(Map<String, dynamic> json) => Frame(
        id: json["id"],
        time: DateTime.parse(json["time"]),
        readings: List<List<int>>.from(
            json["readings"].map((x) => List<int>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time.toIso8601String(),
        "readings": List<dynamic>.from(
            readings.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class Sensor {
  Sensor({
    required this.name,
    required this.columns,
    required this.rows,
    required this.width,
    required this.height,
    required this.minimum,
    required this.maximum,
    required this.units,
  });

  String name;
  int columns;
  int rows;
  int width;
  int height;
  int minimum;
  int maximum;
  String units;

  factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
        name: json["name"],
        columns: json["columns"],
        rows: json["rows"],
        width: json["width"],
        height: json["height"],
        minimum: json["minimum"],
        maximum: json["maximum"],
        units: json["units"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "columns": columns,
        "rows": rows,
        "width": width,
        "height": height,
        "minimum": minimum,
        "maximum": maximum,
        "units": units,
      };
}

class Wifi {
  Wifi({
    required this.ssid,
    required this.mode,
    required this.apaddress,
    required this.list,
  });

  String ssid;
  String mode;
  String apaddress;
  List<String> list;

  factory Wifi.fromJson(Map<String, dynamic> json) => Wifi(
        ssid: json["ssid"],
        mode: json["mode"],
        apaddress: json["apaddress"],
        list: List<String>.from(json["list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ssid": ssid,
        "mode": mode,
        "apaddress": apaddress,
        "list": List<dynamic>.from(list.map((x) => x)),
      };
}
