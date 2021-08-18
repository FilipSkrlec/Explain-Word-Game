import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explain Word Game',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Explain Word Game')),
        body: Center(
          child: LobbyScreen(),
        ));
  }
}

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({Key? key}) : super(key: key);

  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final teamsInputController = TextEditingController();
  List<String> currentTeams = [];
  Map<String, int> teamsScores = {};

  void navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GameScreen(
            teams: this.currentTeams, teamsScores: this.teamsScores)));
  }

  void addTeam() {
    setState(() {
      this.currentTeams.add(teamsInputController.text);
      this.teamsScores[teamsInputController.text] = 4;
      teamsInputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TextField(
          controller: this.teamsInputController,
          decoration: InputDecoration(
              labelText: "Enter team name:",
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: this.addTeam,
              )),
        ),
        TextButton(
            onPressed: () => navigateToNextScreen(context),
            child: Text("START", style: TextStyle(fontSize: 21))),
        Column(
            children: this
                .currentTeams
                .map((item) => new Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(item, style: TextStyle(fontSize: 23))))
                .toList())
      ],
    );
  }
}

class GameScreen extends StatefulWidget {
  final List<String> teams;
  final Map<String, int> teamsScores;

  const GameScreen({Key? key, required this.teams, required this.teamsScores})
      : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int roundTime = 1;
  Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {});
  bool timerStarted = false;
  int answersNeeded = 1;

  String currentTerm = "";
  String currentTeam = "";

  var termsList = [
    'novac',
    'priroda',
    'računalo',
    'kugla',
    'struk',
    'tenk',
    'čelo',
    'umiroviti se',
    'češljanje',
    'prati zube',
    'plašt',
    'gnijezdo',
    'program',
    'Schauma',
    'Milka',
    'Jack Daniels',
    'Coca-cola',
    'Sprite',
    'Monopoly',
    'rukomet',
    'palac',
    'crna rupa',
    'prijestolje',
    'dvotočka',
    'subjekt',
    'Severina',
    'Justin Bieber',
    'Neymar',
    'povlačenje konopa',
    'bacanje koplja',
    'munja',
    'Potraga za Nemom',
    'Real Madrid',
    'Chicago Bulls',
    'London',
    'Jackie Chan',
    'kino',
    'pauza',
    'Devito',
    'Call of Duty',
    'novčanice',
    'ljenčarenje',
    'pljeskavica',
    'Margot Robbie',
    'Napoleon',
    'Ivo Sanader',
    'otpad',
    'New York',
    'Ana Karenjina',
    'Harry Potter',
    'rosa',
    'crtati',
    'jahanje',
    'planinariti',
    'ronjenje',
    'užina',
    'rotkvica',
    'Kleopatra',
    'Diego Maradona',
    'Titanic',
    'Gospodar prstenova',
    'Kralj lavova',
    'ljestvica',
    'kontekst',
    'Batman',
    'Spiderman',
    'Kapetan Amerika',
    'Thor',
    'podmornica',
    'sadržaj',
    'uzorak',
    'vilica',
    'viljuškar',
    'Shrek',
    'Brzi i žestoki',
    'Brad Pitt',
    'Leonardo DiCaprio',
    'Ikea',
    'Red Bull',
    'Ford',
    'Opel',
    'Mercedes',
    'Nikola Tesla',
    'Microsoft',
    'operacijski sustav',
    'procesor',
    'grafička kartica',
    'Facebook',
    'Elon Musk',
    'Hugo Boss',
    'Versace',
    'ljepota',
    'ozlijeda',
    'ključna kost',
    'noćna mora',
    'škampi',
    'grašak',
    'robot',
    'kašljati',
    'hrast',
    'lupati',
    'lutati',
    'vikati',
    'maskota',
    'Chelsea',
    'Kina',
    'Španjolska',
    'Italija',
    'Meksiko',
    'preljev',
    'spajalica',
    'Matrix',
    'džungla',
    'Indiana Jones',
    'Baka Prase',
    'osam',
    'završiti',
    'pidžama',
    'lista',
    'pista',
    'rub',
    'vodena para',
    'Angelina Jolie',
    'Kim Kardashian',
    'Breaking bad',
    'Igra prijestolja',
    'Kako sam upoznao vašu majku',
    'Mr. Bean',
    'Snjeguljica',
    'sladoled',
    'šlag',
    'ulje',
    'sintagma',
    'oluja',
    'gumb',
    'navigacija',
    'ekran',
    'krađa',
    'plus',
    'sunčane naočale',
    'zora',
    'lanac',
    'francuski ključ',
    'Britney Spears',
    'sezam',
    'vanlija',
    'maslac',
    'Despacito',
    'Gangnam Style',
    'Parni valjak',
    'Prljavo kazalište',
    'katedrala',
    'vjetrenjača',
    'dnevna soba',
    'daska za peglanje',
    'pegla za kosu',
    'Old Spice',
    'kora od banane',
    'atmosfera',
    'istosmjerna struja',
    'Albert Einstein',
    'Luka Modrić',
    'Will Smith',
    'Shakira',
    'Burj Khalifa',
    'Buba Corelli',
    'Samsung',
    'adapter',
    'društvena igra',
    'Bob Graditelj',
    'potreba',
    'idiot',
    'opekline od sunca',
    'sunčanica',
    'saonice',
    'sauna',
    'sok od jabuke',
    'gin tonic',
    'nanogice',
    'paket',
    'pjenušavo piće',
    'domet',
    'strelice za pikado',
    'bilijarski štap',
    'Zabranjeno pušenje',
    'komandna linija',
    'televizijski dnevnik',
    'vijesti u podne',
    'puni mjesec',
    'zvjezdano nebo',
    'Mliječna staza',
    'Jupiter',
    'Zeus',
    'Olimpijske igre',
    'zlatna medalja',
    'drvena medalja',
    'obrano mlijeko',
    'sol',
    'žongleri',
    'Maja Šuput',
    'Hajduk',
    'Cedevita',
    'vlažne maramice',
    'Heroj ulice',
    'James Bond',
    'martini',
    'mojito',
    'Sex on the beach',
    'Azra',
    'Nirvana',
    'Fortnite',
    'engleski jezik',
    'Tokio',
    'Antarktika',
    'pingvin',
    'Modra lasta',
    'vratar',
    'supstanca',
    'kalcij',
    'sumpor',
    'dušik',
    'aluminij',
    'atomska bomba',
    'nuklearna elektrana',
    'programski jezik',
    'crni oblaci',
    'dama tref',
    'poker',
    'propast',
    'Vesna Pisarović',
    'Jadransko more',
    'Crno more',
    'Maroko',
    'vrtlog',
    'lukavstvo',
    'zahtjev',
    'Toyota',
    'Starbucks',
    'Roger Federer',
    'Serena Williams',
    'Ivica Kostelić',
    'borilački sportovi',
    'veslanje',
    'prijenosno računalo',
    'Naša mala klinika',
    'Eurovizija',
    'perilica za suđe',
    'sušilo za kosu',
    'vrba',
    'burek od sira',
    'lisnato tijesto',
    'prhko tijesto',
    'koš za smeće',
    'nagradna igra',
    'plahta',
    'zubalo',
    'nožni prst',
    'zjenica',
    'ograda',
    'koza',
    'igrati prljavo',
    'general',
    'bijelo vino',
    'bilježnica',
    'papir',
    'utičnica',
    'valuta',
    'burza',
    'škare',
    'požar',
    'potres',
    'Snapchat',
    'svemirski brod',
    'djetelina',
    'kemijska olovka',
    'Igre gladi',
    'poruka',
    'skica',
    'željezo',
    'minus',
    'Kineski zid',
    'Transformeri',
    'narkoman',
    'katastrofa',
    'plahost',
    'uskličnik',
    'ugurati',
    'visibaba',
    'prapovijest',
    'slomiti ruku',
    'poštenje',
    'agresivan',
    'biće',
    'rum',
    'poziv',
    'čekanje',
    'pouzdano',
    'praktično',
    'izbor',
    'probušena guma',
    'naglasak',
    'prisiljavati',
    'potaknuti',
    'spajalica',
    'hitna pomoć',
    'vatrogasac',
    'vokalna izvedba',
    'solistica',
    'smatrati',
    'ukrcavanje',
    'uglate zagrade',
    'pokrenuti',
    'alternativna medicina',
    'abecedni red',
    'izravan let',
    'laka lova',
    'Bitange i princeze',
    'Rene Bitorajac',
    'preljev od čokolade',
    'kornet',
    'flauta',
    'violončelo',
    'kontrabas',
    'harfa',
    'električna gitara',
    'naslovna stranica',
    'visoki standardi',
    'unutarnji organi',
    'pandemija',
    'virus',
    'jež',
    'glavno jelo',
    'desert',
    'mađarica',
    'Kinder jaje',
    'zemlja podrijetla',
    'sjećanje',
    'kladionica',
    'najbolji strijelac',
    'čizma'
  ];

  void navigateToLeaderboardScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LeaderboardScreen(
            teams: widget.teams, teamsScores: widget.teamsScores)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void correctAnswer() {
    setState(() {
      answersNeeded -= 1;
      changeCurrentTerm();
    });
  }

  void wrongAnswer() {
    setState(() {
      answersNeeded += 1;
      changeCurrentTerm();
    });
  }

  void changeCurrentTerm() {
    setState(() {
      if (timerStarted == false) {
        startTimer();
        timerStarted = true;
      }
      final _random = new Random();

      var newTerm = termsList[_random.nextInt(termsList.length)];
      while (newTerm == this.currentTerm) {
        newTerm = termsList[_random.nextInt(termsList.length)];
      }
      this.currentTerm = newTerm;

      if (this.answersNeeded == 0 || this.currentTeam == "") {
        int newTeamIdx = -1;
        if (currentTeam == "") {
          newTeamIdx = _random.nextInt(widget.teams.length);
        } else {
          int currentTeamIdx = widget.teams.indexOf(this.currentTeam);
          if (currentTeamIdx == widget.teams.length - 1) {
            currentTeamIdx = -1;
          }
          newTeamIdx = currentTeamIdx + 1;
        }

        this.currentTeam = widget.teams[newTeamIdx];
        this.answersNeeded = 1;
      }
    });
  }

  void startTimer() {
    roundTime = widget.teamsScores.length * 25 + Random().nextInt(20);

    timer.cancel();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (roundTime > 0) {
          roundTime -= 1;
        } else {
          timer.cancel();
          timerStarted = false;
          this.currentTerm = "";
          int? currentTeamResult = widget.teamsScores[this.currentTeam];
          widget.teamsScores[this.currentTeam] = (currentTeamResult! - 1);
          navigateToLeaderboardScreen(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text(
                this.currentTeam,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.deepOrange),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Text(
                this.currentTerm,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50),
              ),
            ),
            (this.timerStarted
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Expanded(
                            child: Container(
                                color: Colors.green,
                                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: IconButton(
                                    onPressed: () => correctAnswer(),
                                    icon: const Icon(Icons.check)))),
                        Expanded(
                            child: Container(
                                color: Colors.red,
                                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: IconButton(
                                    onPressed: () => wrongAnswer(),
                                    icon: const Icon(Icons.block)))),
                      ])
                : TextButton(
                    onPressed: changeCurrentTerm, child: Text("START"))),
            Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Potrebni odgovori: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    Expanded(
                        child: Text(
                      this.answersNeeded.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40, color: Colors.deepOrange),
                    )),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderboardScreen extends StatelessWidget {
  final List<String> teams;
  final Map<String, int> teamsScores;

  const LeaderboardScreen(
      {Key? key, required this.teams, required this.teamsScores})
      : super(key: key);

  void navigateToGameScreen(BuildContext context) {
    for (var team in this.teamsScores.keys) {
      if (this.teamsScores[team] == 0) {
        this.teamsScores.remove(team);
        this.teams.remove(team);
      }
    }

    if (this.teamsScores.length > 1) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              GameScreen(teams: this.teams, teamsScores: this.teamsScores)));
    } else if (this.teamsScores.length == 1) {
      navigateToEndScreen(context);
    }
  }

  void navigateToEndScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            EndScreen(winner: this.teamsScores.keys.elementAt(0))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    for (var team in this.teams)
                      TableRow(
                        children: <Widget>[
                          TableCell(
                              child: Container(
                            height: 64,
                            color: Colors.green,
                            child: Text(
                              team,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24),
                            ),
                          )),
                          TableCell(
                            child: Container(
                              height: 64,
                              color: Colors.red,
                              child: Text(
                                this.teamsScores[team].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: TextButton(
                  child: Text(
                    "Dalje",
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () => navigateToGameScreen(context),
                ),
              )
            ],
          ),
        )
      ],
    )));
  }
}

class EndScreen extends StatelessWidget {
  final String winner;

  const EndScreen({Key? key, required this.winner}) : super(key: key);

  void navigateToLobbyScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
              child: Text(
                "POBJEDNIK:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
              child: Text(
                this.winner,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, color: Colors.deepOrange),
              ),
            ),
            Container(
              color: Colors.green,
              child: TextButton(
                child: Text(
                  "NOVA IGRA",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => navigateToLobbyScreen(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
