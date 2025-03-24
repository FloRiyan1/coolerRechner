import 'package:flutter/material.dart';
import '../Model/zaehler_daten.dart';
import '../Model/zaehler_daten_details.dart';
import 'zaehler_details_widget.dart';

class ZaehlerWidget extends StatefulWidget {
  final ZaehlerDaten daten;
  final ValueChanged<ZaehlerDaten> onChanged;
  final VoidCallback onDelete;

  const ZaehlerWidget({
    Key? key,
    required this.daten,
    required this.onChanged,
    required this.onDelete,
  }) : super(key: key);

  @override
  _ZaehlerWidgetState createState() => _ZaehlerWidgetState();
}

class _ZaehlerWidgetState extends State<ZaehlerWidget> {
  late TextEditingController _titelController;
  bool _showDetails = false;

  @override
  void initState() {
    super.initState();
    // Titel aus dem Modell in den Controller laden
    _titelController = TextEditingController(text: widget.daten.titel);
  }

  @override
  void dispose() {
    _titelController.dispose();
    super.dispose();
  }

  /// Summiert alle Details zu einem Gesamtwert
  int _berechneGesamtWert(List<ZaehlerDatenDetails> details) {
    // Beispiel: summe + (detail.schritt * detail.anzahl)
    // falls du ein anderes System hast, passe das hier an.
    return details.fold(0, (summe, detail) => summe + detail.schritt * detail.anzahl);
  }

  /// Meldet Änderungen (z.B. Titel oder Details) nach oben.
  /// Neue Summe wird berechnet und `widget.onChanged` aufgerufen.
  void _updateDaten({String? neuerTitel, List<ZaehlerDatenDetails>? neueDetails}) {
    final alteDetails = widget.daten.details;
    final aktuelleDetails = neueDetails ?? alteDetails;
    final titel = neuerTitel ?? widget.daten.titel;

    // Neue Summe auf Basis der aktuellen Details
    final neueSumme = _berechneGesamtWert(aktuelleDetails);

    final aktualisiert = ZaehlerDaten(
      id: widget.daten.id,
      titel: titel,
      wert: neueSumme,
      position: widget.daten.position,
      details: aktuelleDetails,
    );

    widget.onChanged(aktualisiert);
  }

  @override
  Widget build(BuildContext context) {
    final zaehler = widget.daten;

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Titelzeile
            Row(
              children: [
                // Titel-Bearbeitung
                Expanded(
                  child: TextField(
                    controller: _titelController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Zähler-Titel',
                    ),
                    onChanged: (value) {
                      _updateDaten(neuerTitel: value);
                    },
                  ),
                ),
                // Löschen
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: widget.onDelete,
                ),
              ],
            ),
            // Zeige aktuelle Summe
            Text(
              'Gesamt: ${zaehler.wert}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // Details ein- / ausklappen
            IconButton(
              icon: Icon(_showDetails ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              onPressed: () {
                setState(() {
                  _showDetails = !_showDetails;
                });
              },
            ),
            if (_showDetails)
              ZaehlerDetailsWidget(
                details: zaehler.details,
                onDetailsChanged: (neueDetails) {
                  // Neue Details => Summe neu berechnen
                  _updateDaten(neueDetails: neueDetails);
                },
              ),
          ],
        ),
      ),
    );
  }
}
