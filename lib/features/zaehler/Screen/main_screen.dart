// Datei: main_screen.dart

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/zaehler_daten.dart';
import '../Model/zaehler_daten_details.dart';
import '../Widgets/zaehler_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<ZaehlerDaten> _zaehlerListe = [];
  List<ZaehlerDaten> _originalListe = [];

  bool isDarkMode = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
    _loadZaehlerDaten();
  }

  // ---------- THEME ----------
  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _saveThemePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
  }

  // ---------- DATENBANK ----------
  Future<Database> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    String path = join(databasePath, 'zaehler.db');

    return openDatabase(
      path,
      onCreate: (db, version) async {
        // Tabelle 'zaehler'
        await db.execute(
          'CREATE TABLE zaehler('
              'id TEXT PRIMARY KEY, '
              'wert INTEGER, '
              'titel TEXT, '
              'position INTEGER'
              ')',
        );
        // Tabelle 'zaehlerDetails'
        await db.execute(
          'CREATE TABLE zaehlerDetails('
              'id TEXT PRIMARY KEY, '
              'zaehlerID TEXT, '
              'titel TEXT, '
              'wert INTEGER'
              ')',
        );
      },
      version: 1,
    );
  }

  // ---------- LADEN ----------
  Future<void> _loadZaehlerDaten() async {
    final db = await _initializeDatabase();

    // Zuerst alle Zaehler aus der Tabelle 'zaehler' holen
    final List<Map<String, dynamic>> zaehlerMaps = await db.query(
      'zaehler',
      orderBy: 'position ASC',
    );

    // Für jeden Zähler die zugehörigen Details aus 'zaehlerDetails' laden
    List<ZaehlerDaten> tempListe = [];
    for (final map in zaehlerMaps) {
      final zaehler = ZaehlerDaten.fromMap(map);

      final detailMaps = await db.query(
        'zaehlerDetails',
        where: 'zaehlerID = ?',
        whereArgs: [zaehler.id],
      );

      zaehler.details = detailMaps
          .map((m) => ZaehlerDatenDetails.fromMap(m))
          .toList();

      tempListe.add(zaehler);
    }

    setState(() {
      _zaehlerListe = tempListe;
      _originalListe = List.from(tempListe);
    });
  }

  // ---------- EINFÜGEN ----------
  Future<void> _insertZaehler(ZaehlerDaten zaehler) async {
    final db = await _initializeDatabase();

    // Haupt-Datensatz in 'zaehler'
    await db.insert(
      'zaehler',
      zaehler.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Alle Details in 'zaehlerDetails' (falls vorhanden)
    for (final detail in zaehler.details) {
      await db.insert(
        'zaehlerDetails',
        detail.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // ---------- UPDATEN ----------
  Future<void> _updateZaehler(ZaehlerDaten zaehler) async {
    final db = await _initializeDatabase();

    // Haupt-Datensatz
    await db.update(
      'zaehler',
      zaehler.toMap(),
      where: 'id = ?',
      whereArgs: [zaehler.id],
    );

    // Alte Details löschen ...
    await db.delete(
      'zaehlerDetails',
      where: 'zaehlerID = ?',
      whereArgs: [zaehler.id],
    );
    // ... und neu einfügen
    for (final detail in zaehler.details) {
      await db.insert(
        'zaehlerDetails',
        detail.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // ---------- LÖSCHEN ----------
  Future<void> _deleteZaehler(String id) async {
    final db = await _initializeDatabase();

    // Zähler entfernen
    await db.delete(
      'zaehler',
      where: 'id = ?',
      whereArgs: [id],
    );

    // Zugehörige Details ebenfalls löschen
    await db.delete(
      'zaehlerDetails',
      where: 'zaehlerID = ?',
      whereArgs: [id],
    );

    setState(() {
      _zaehlerListe.removeWhere((element) => element.id == id);
      _originalListe.removeWhere((element) => element.id == id);
    });
  }

  // ---------- UI & LOGIK ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Counter"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadZaehlerDaten,
          ),
        ],
      ),
      drawer: SizedBox(
        width: 150,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                color: Colors.cyan,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    child: const Text(
                      'Einstellungen',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 25),
                leading: Icon(isDarkMode
                    ? Icons.dark_mode
                    : Icons.light_mode),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (newValue) {
                    setState(() {
                      isDarkMode = newValue;
                      _saveThemePreference(newValue);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: ReorderableListView(
        onReorder: _onReorder,
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          for (int index = 0; index < _zaehlerListe.length; index++)
            KeyedSubtree(
              key: ValueKey(_zaehlerListe[index].id),
              child: ZaehlerWidget(
                daten: _zaehlerListe[index],
                onChanged: (neueDaten) {
                  setState(() {
                    final i = _zaehlerListe.indexWhere(
                            (element) => element.id == neueDaten.id);
                    if (i != -1) {
                      _zaehlerListe[i] = neueDaten;
                      _updateZaehler(neueDaten);
                    }
                  });
                },
                onDelete: () {
                  _deleteZaehler(_zaehlerListe[index].id);
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewZaehler,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNewZaehler() async {
    final neuerZaehler = ZaehlerDaten(
      id: UniqueKey().toString(),
      wert: 0,
      titel: 'Neuer Zähler',
      position: _zaehlerListe.length,
      details: [], // Startet mit leerer Liste
    );

    await _insertZaehler(neuerZaehler);

    setState(() {
      _zaehlerListe.add(neuerZaehler);
      _originalListe.add(neuerZaehler);
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _zaehlerListe.removeAt(oldIndex);
      _zaehlerListe.insert(newIndex, item);

      // Position aktualisieren
      for (int i = 0; i < _zaehlerListe.length; i++) {
        _zaehlerListe[i].position = i;
        _updateZaehler(_zaehlerListe[i]);
      }
    });
  }
}
