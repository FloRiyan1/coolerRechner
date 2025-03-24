import 'package:myapp/features/zaehler/Model/zaehler_daten_details.dart';

class ZaehlerDaten {
  final String id;
  String titel;
  int position;
  // => Dieser Wert wird als „Gesamtsumme“ gespeichert.
  int wert;
  // Liste der Detail-Einträge
  List<ZaehlerDatenDetails> details;

  ZaehlerDaten({
    required this.id,
    required this.titel,
    required this.position,
    required this.wert,      // wird später als Summe berechnet
    required this.details,
  });

  // Zum Speichern in 'zaehler' – details kommt in eigene Tabelle
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titel': titel,
      'wert': wert,
      'position': position,
    };
  }

  // Beim Laden aus 'zaehler'
  factory ZaehlerDaten.fromMap(Map<String, dynamic> map) {
    return ZaehlerDaten(
      id: map['id'] as String,
      titel: map['titel'] as String,
      wert: map['wert'] as int,
      position: map['position'] as int,
      details: [],
    );
  }
}
