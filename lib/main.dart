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
    'ra??unalo',
    'kugla',
    'struk',
    'tenk',
    '??elo',
    'umiroviti se',
    '??e??ljanje',
    'prati zube',
    'pla??t',
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
    'dvoto??ka',
    'subjekt',
    'Severina',
    'Justin Bieber',
    'Neymar',
    'povla??enje konopa',
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
    'nov??anice',
    'ljen??arenje',
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
    'u??ina',
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
    'sadr??aj',
    'uzorak',
    'vilica',
    'vilju??kar',
    'Shrek',
    'Brzi i ??estoki',
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
    'grafi??ka kartica',
    'Facebook',
    'Elon Musk',
    'Hugo Boss',
    'Versace',
    'ljepota',
    'ozlijeda',
    'klju??na kost',
    'no??na mora',
    '??kampi',
    'gra??ak',
    'robot',
    'ka??ljati',
    'hrast',
    'lupati',
    'lutati',
    'vikati',
    'maskota',
    'Chelsea',
    'Kina',
    '??panjolska',
    'Italija',
    'Meksiko',
    'preljev',
    'spajalica',
    'Matrix',
    'd??ungla',
    'Indiana Jones',
    'Baka Prase',
    'osam',
    'zavr??iti',
    'pid??ama',
    'lista',
    'pista',
    'rub',
    'vodena para',
    'Angelina Jolie',
    'Kim Kardashian',
    'Breaking bad',
    'Igra prijestolja',
    'Kako sam upoznao va??u majku',
    'Mr. Bean',
    'Snjeguljica',
    'sladoled',
    '??lag',
    'ulje',
    'sintagma',
    'oluja',
    'gumb',
    'navigacija',
    'ekran',
    'kra??a',
    'plus',
    'sun??ane nao??ale',
    'zora',
    'lanac',
    'francuski klju??',
    'Britney Spears',
    'sezam',
    'vanlija',
    'maslac',
    'Despacito',
    'Gangnam Style',
    'Parni valjak',
    'Prljavo kazali??te',
    'katedrala',
    'vjetrenja??a',
    'dnevna soba',
    'daska za peglanje',
    'pegla za kosu',
    'Old Spice',
    'kora od banane',
    'atmosfera',
    'istosmjerna struja',
    'Albert Einstein',
    'Luka Modri??',
    'Will Smith',
    'Shakira',
    'Burj Khalifa',
    'Buba Corelli',
    'Samsung',
    'adapter',
    'dru??tvena igra',
    'Bob Graditelj',
    'potreba',
    'idiot',
    'opekline od sunca',
    'sun??anica',
    'saonice',
    'sauna',
    'sok od jabuke',
    'gin tonic',
    'nanogice',
    'paket',
    'pjenu??avo pi??e',
    'domet',
    'strelice za pikado',
    'bilijarski ??tap',
    'Zabranjeno pu??enje',
    'komandna linija',
    'televizijski dnevnik',
    'vijesti u podne',
    'puni mjesec',
    'zvjezdano nebo',
    'Mlije??na staza',
    'Jupiter',
    'Zeus',
    'Olimpijske igre',
    'zlatna medalja',
    'drvena medalja',
    'obrano mlijeko',
    'sol',
    '??ongleri',
    'Maja ??uput',
    'Hajduk',
    'Cedevita',
    'vla??ne maramice',
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
    'du??ik',
    'aluminij',
    'atomska bomba',
    'nuklearna elektrana',
    'programski jezik',
    'crni oblaci',
    'dama tref',
    'poker',
    'propast',
    'Vesna Pisarovi??',
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
    'Ivica Kosteli??',
    'borila??ki sportovi',
    'veslanje',
    'prijenosno ra??unalo',
    'Na??a mala klinika',
    'Eurovizija',
    'perilica za su??e',
    'su??ilo za kosu',
    'vrba',
    'burek od sira',
    'lisnato tijesto',
    'prhko tijesto',
    'ko?? za sme??e',
    'nagradna igra',
    'plahta',
    'zubalo',
    'no??ni prst',
    'zjenica',
    'ograda',
    'koza',
    'igrati prljavo',
    'general',
    'bijelo vino',
    'bilje??nica',
    'papir',
    'uti??nica',
    'valuta',
    'burza',
    '??kare',
    'po??ar',
    'potres',
    'Snapchat',
    'svemirski brod',
    'djetelina',
    'kemijska olovka',
    'Igre gladi',
    'poruka',
    'skica',
    '??eljezo',
    'minus',
    'Kineski zid',
    'Transformeri',
    'narkoman',
    'katastrofa',
    'plahost',
    'uskli??nik',
    'ugurati',
    'visibaba',
    'prapovijest',
    'slomiti ruku',
    'po??tenje',
    'agresivan',
    'bi??e',
    'rum',
    'poziv',
    '??ekanje',
    'pouzdano',
    'prakti??no',
    'izbor',
    'probu??ena guma',
    'naglasak',
    'prisiljavati',
    'potaknuti',
    'spajalica',
    'hitna pomo??',
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
    'preljev od ??okolade',
    'kornet',
    'flauta',
    'violon??elo',
    'kontrabas',
    'harfa',
    'elektri??na gitara',
    'naslovna stranica',
    'visoki standardi',
    'unutarnji organi',
    'pandemija',
    'virus',
    'je??',
    'glavno jelo',
    'desert',
    'ma??arica',
    'Kinder jaje',
    'zemlja podrijetla',
    'sje??anje',
    'kladionica',
    'najbolji strijelac',
    '??izma'
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
