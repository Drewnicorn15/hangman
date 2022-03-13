import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hangman/painters.dart';
import "dart:math";

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Pic()),
    ], child: MyApp()),
  );
}

class Pic with ChangeNotifier {
  int _stage = 0;
  int get stage => _stage;
  void increasestage() {
    _stage++;
    if (_stage == 8) {
      _lettersfound = "game over";
    }
    notifyListeners();
  }

  void setupword() {
    _word = randomWord();
    _lettersfound = "";
    _usedletters = [];
    _stage = 0;
    for (int i = 0; i < _word.length; i++) {
      _lettersfound += "_";
    }
    _playorreset = "Reset";
    notifyListeners();
  }

  CustomPainter getpaint(stagenum) {
    switch (stagenum) {
      case 2:
        {
          return Paintpt2();
        }
      case 3:
        {
          return Paintpt3();
        }
      case 4:
        {
          return Paintpt4();
        }
      case 5:
        {
          return Paintpt5();
        }
      case 6:
        {
          return Paintpt6();
        }
      case 7:
        return Paintpt7();
      case 1:
        {
          return Paintstart();
        }
      default:
        {
          return Paintblank();
        }
    }
  }

  String randomWord() {
    final random = new Random();
    List<String> contents = [
      "pancake",
      "sulky",
      "complain",
      "imported",
      "death",
      "bruise",
      "eager",
      "bed",
      "rotten",
      "soggy",
      "selective",
      "rush",
      "hat",
      "inform",
      "hard",
      "window",
      "pie",
      "voracious",
      "tense",
      "vivacious",
      "knotty",
      "grin",
      "brief",
      "fire",
      "natural",
      "agonizing",
      "search",
      "freezing",
      "peep",
      "stingy",
      "grape",
      "unequaled",
      "ripe",
      "tacit",
      "devilish",
      "macho",
      "food",
      "continue",
      "plucky",
      "toothbrush",
      "undesirable",
      "blood",
      "ceaseless",
      "remain",
      "frail",
      "same",
      "nerve",
      "spotty",
      "new",
      "screw",
      "functional",
      "unarmed",
      "thirsty",
      "language",
      "oceanic",
      "normal",
      "didactic",
      "picture",
      "debt",
      "needle",
      "untidy",
      "many",
      "rare",
      "garrulous",
      "childlike",
      "cherries",
      "animated",
      "adjoining",
      "zipper",
      "grade",
      "ladybug",
      "brawny",
      "miniature",
      "busy",
      "note",
      "clever",
      "homeless",
      "halting",
      "duck",
      "disappear",
      "best",
      "succeed",
      "bloody",
      "faulty",
      "room",
      "gentle",
      "tin",
      "view",
      "hug",
      "sparkle",
      "unnatural",
      "apparatus",
      "cemetery",
      "leg",
      "elfin",
      "steam",
      "miscreant",
      "afterthought",
      "good",
      "suggestion",
      "wary",
      "funny",
      "agree",
      "attach",
      "slimy",
      "rainy",
      "tight",
      "girl",
      "impolite",
      "wooden",
      "learned",
      "jumbled",
      "poke",
      "sticky",
      "camera",
      "example",
      "donkey",
      "condition",
      "uttermost",
      "charge"
    ];
    return contents[random.nextInt(contents.length)];
  }

  List<String> _usedletters = [];
  String _word = "";
  String _lettersfound = "";
  String _playorreset = "Play";
  String get word => _word;
  String get lettersfound => _lettersfound;
  String get playorreset => _playorreset;
  void inputletter(String letter, {int indextostart = 0}) {
    if (_word.contains(letter)) {
      int index = _word.indexOf(letter, indextostart);
      if (index != -1 && _word.indexOf(letter, index + 1) == -1 ||
          _lettersfound[index] == "_") {
        if (index == _word.length - 1) {
          _lettersfound = _lettersfound.substring(0, (index)) + letter;
        } else if (index == 0) {
          _lettersfound = letter + _lettersfound.substring(index + 1);
        } else {
          _lettersfound = _lettersfound.substring(0, (index)) +
              letter +
              _lettersfound.substring(index + 1);
        }
      } else {
        inputletter(letter, indextostart: index + 1);
      }
      notifyListeners();
    } else {
      increasestage();
    }
    if (_word == _lettersfound) {
      _lettersfound = "You Win";
    }
    _usedletters.add(letter);
    if (_word.substring(indextostart).contains(letter)) {
      inputletter(letter, indextostart: indextostart + 1);
    }
  }

  bool ifused(String letter) {
    return (_usedletters.contains(letter));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hangman"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.red,
              width: 300,
              height: 300,
              child: CustomPaint(
                foregroundPainter:
                    context.read<Pic>().getpaint(context.watch<Pic>().stage),
              ),
            ),
            Text("${context.watch<Pic>().lettersfound}",
                style: TextStyle(fontSize: 25)),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("q")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("q"),
                  child: Text(
                    "q",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("w")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("w"),
                  child: Text(
                    "w",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("e")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("e"),
                  child: Text(
                    "e",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("r")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("r"),
                  child: Text(
                    "r",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("t")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("t"),
                  child: Text(
                    "t",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("y")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("y"),
                  child: Text(
                    "y",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("u")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => {context.read<Pic>().inputletter("u")},
                  child: Text(
                    "u",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("i")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("i"),
                  child: Text(
                    "i",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("o")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("o"),
                  child: Text(
                    "o",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("p")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("p"),
                  child: Text(
                    "p",
                  ))
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => context.read<Pic>().ifused("a")
                                ? Colors.black12
                                : Colors.lightGreen)),
                    onPressed: () => context.read<Pic>().inputletter("a"),
                    child: Text(
                      "a",
                    )),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => context.read<Pic>().ifused("s")
                                ? Colors.black12
                                : Colors.lightGreen)),
                    onPressed: () => context.read<Pic>().inputletter("s"),
                    child: Text(
                      "s",
                    )),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => context.read<Pic>().ifused("d")
                                ? Colors.black12
                                : Colors.lightGreen)),
                    onPressed: () => context.read<Pic>().inputletter("d"),
                    child: Text(
                      "d",
                    )),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => context.read<Pic>().ifused("f")
                                ? Colors.black12
                                : Colors.lightGreen)),
                    onPressed: () => context.read<Pic>().inputletter("f"),
                    child: Text(
                      "f",
                    )),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => context.read<Pic>().ifused("g")
                                ? Colors.black12
                                : Colors.lightGreen)),
                    onPressed: () => context.read<Pic>().inputletter("g"),
                    child: Text(
                      "g",
                    )),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => context.read<Pic>().ifused("h")
                                ? Colors.black12
                                : Colors.lightGreen)),
                    onPressed: () => context.read<Pic>().inputletter("h"),
                    child: Text(
                      "h",
                    )),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => context.read<Pic>().ifused("j")
                                ? Colors.black12
                                : Colors.lightGreen)),
                    onPressed: () => context.read<Pic>().inputletter("j"),
                    child: Text(
                      "j",
                    )),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => context.read<Pic>().ifused("k")
                                ? Colors.black12
                                : Colors.lightGreen)),
                    onPressed: () => context.read<Pic>().inputletter("k"),
                    child: Text(
                      "k",
                    )),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => context.read<Pic>().ifused("l")
                                ? Colors.black12
                                : Colors.lightGreen)),
                    onPressed: () => context.read<Pic>().inputletter("l"),
                    child: Text(
                      "l",
                    )),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("z")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("z"),
                  child: Text(
                    "z",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("x")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("x"),
                  child: Text(
                    "x",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("c")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("c"),
                  child: Text(
                    "c",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("v")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("v"),
                  child: Text(
                    "v",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("b")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("b"),
                  child: Text(
                    "b",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("n")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("n"),
                  child: Text(
                    "n",
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => context.read<Pic>().ifused("m")
                              ? Colors.black12
                              : Colors.lightGreen)),
                  onPressed: () => context.read<Pic>().inputletter("m"),
                  child: Text(
                    "m",
                  ))
            ]),
            TextButton(
                onPressed: () => context.read<Pic>().setupword(),
                child: Text("${context.read<Pic>().playorreset}"))
          ],
        ),
      ),
    );
  }
}
