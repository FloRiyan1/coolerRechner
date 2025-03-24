import 'package:flutter/material.dart';
import '../Model/zaehler_daten_details.dart';

/// Zeigt mehrere "Detail-Einträge" an, z.B. mit Schritt und Anzahl.
/// Berechnet den Wert pro Detail = schritt * anzahl.
class ZaehlerDetailsWidget extends StatefulWidget {
  final List<ZaehlerDatenDetails> details;
  final ValueChanged<List<ZaehlerDatenDetails>> onDetailsChanged;

  const ZaehlerDetailsWidget({
    Key? key,
    required this.details,
    required this.onDetailsChanged,
  }) : super(key: key);

  @override
  State<ZaehlerDetailsWidget> createState() => _ZaehlerDetailsWidgetState();
}

class _ZaehlerDetailsWidgetState extends State<ZaehlerDetailsWidget> {
  late List<ZaehlerDatenDetails> _detailsLocal;

  @override
  void initState() {
    super.initState();
    // Lokale Kopie, damit wir nicht direkt auf widget.details schreiben.
    _detailsLocal = widget.details.map((d) => ZaehlerDatenDetails(
      id: d.id,
      zaehlerID: d.zaehlerID,
      titel: d.titel,
      schritt: d.schritt,
      anzahl: d.anzahl,
    )).toList();
  }

  void _updateParent() {
    widget.onDetailsChanged(_detailsLocal);
  }

  /// Neues Detail hinzufügen
  void _addDetail() {
    setState(() {
      _detailsLocal.add(
        ZaehlerDatenDetails(
          id: UniqueKey().toString(),
          zaehlerID: '', // hier kann man später die korrekte zaehlerID setzen
          titel: '',
          schritt: 1,
          anzahl: 0,
        ),
      );
    });
    _updateParent();
  }

  /// Entfernt ein Detail aus der Liste
  void _removeDetail(int index) {
    setState(() {
      _detailsLocal.removeAt(index);
    });
    _updateParent();
  }

  /// Bearbeitet einzelne Felder des Details
  void _updateDetail(int index, {String? titel, int? schritt, int? anzahl}) {
    setState(() {
      final alt = _detailsLocal[index];
      _detailsLocal[index] = ZaehlerDatenDetails(
        id: alt.id,
        zaehlerID: alt.zaehlerID,
        titel: titel ?? alt.titel,
        schritt: schritt ?? alt.schritt,
        anzahl: anzahl ?? alt.anzahl,
      );
    });
    _updateParent();
  }

  /// Erhöht `anzahl` um 1
  void _increment(int index) {
    final current = _detailsLocal[index];
    _updateDetail(index, anzahl: current.anzahl + 1);
  }

  /// Verringert `anzahl` um 1 (bis min. 0)
  void _decrement(int index) {
    final current = _detailsLocal[index];
    if (current.anzahl > 0) {
      _updateDetail(index, anzahl: current.anzahl - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade50,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Details (individuelle Schritte)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addDetail,
              ),
            ],
          ),
          // Anzeige aller Details
          for (int i = 0; i < _detailsLocal.length; i++)
            Row(
              children: [
                // Titel
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Titel',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    controller: TextEditingController(
                      text: _detailsLocal[i].titel,
                    ),
                    onChanged: (value) => _updateDetail(i, titel: value),
                  ),
                ),
                // Schritt
                SizedBox(
                  width: 50,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: '+/-',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                      text: _detailsLocal[i].schritt.toString(),
                    ),
                    onChanged: (value) {
                      final parsed = int.tryParse(value) ?? 1;
                      _updateDetail(i, schritt: parsed);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => _decrement(i),
                ),
                Text(_detailsLocal[i].anzahl.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _increment(i),
                ),
                // Kleinere Anzeige: (schritt * anzahl)
                Text(' = ${_detailsLocal[i].schritt * _detailsLocal[i].anzahl}'),
                // Löschen
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeDetail(i),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
