class ZaehlerDatenDetails {
  final String id;
  String zaehlerID;   // Welchem Zaehler gehören wir?
  String titel;       // z.B. "Schwerter"
  int schritt;        // z.B. 4
  int anzahl;         // z.B. 3 (heißt 3 * 4 = 12)

  ZaehlerDatenDetails({
    required this.id,
    required this.zaehlerID,
    required this.titel,
    required this.schritt,
    required this.anzahl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'zaehlerID': zaehlerID,
      'titel': titel,
      'schritt': schritt,
      'anzahl': anzahl,
    };
  }

  factory ZaehlerDatenDetails.fromMap(Map<String, dynamic> map) {
    return ZaehlerDatenDetails(
      id: map['id'] as String,
      zaehlerID: map['zaehlerID'] as String,
      titel: map['titel'] as String,
      schritt: map['schritt'] as int,
      anzahl: map['anzahl'] as int,
    );
  }
}
