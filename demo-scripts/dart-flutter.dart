import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _theme(),
      home: MyHomePage(
        title: 'Pitaya Smoothie Demo App',
      ),
    );
  }

  ThemeData _theme() {
    return ThemeData(
      primaryColor: PitayaStyle.PitayaKeyword,
      accentColor: PitayaStyle.PitayaOther,
      appBarTheme: PitayaStyle.pitayaAppBarStyle,
      floatingActionButtonTheme: PitayaStyle.fabTheme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  //
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
  Color _background = PitayaStyle.PitayaBackground;
  Color _textColor = PitayaStyle.PitayaForeground;
  bool _isBoxVisible = false;
  Random _random = Random();

  // Image paths
  String logo = 'assets/images/logo.png';
  String pitaya = 'assets/images/pitaya.png';
  String sprocket = 'assets/images/settings.png';
  String unicorn = 'assets/images/unicorn.png';

  List<Color> _lightColors = [
    PitayaStyle.PitayaForeground,
    PitayaStyle.PitayaBuiltinConstant,
    PitayaStyle.PitayaOther,
    PitayaStyle.PitayaChanged,
  ];

  AnimationController unicornController;
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation nodAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  void _addPitaya() {
    setState(() {
      _counter++;
    });
  }

  void _mixItUp() {
    setState(() {
      this._isBoxVisible = true;
      this._textColor = PitayaStyle.fetchNewColor(this._counter);
    });
  }

  void _party() {
    setState(() {
      int randomNum = this._random.nextInt(PitayaStyle.colorList.length);
      int index = randomNum;

      this._isBoxVisible = false;
      this._background = PitayaStyle.colorList[index];

      while (randomNum == index) {
        randomNum = this._random.nextInt(PitayaStyle.colorList.length);
      }

      this._textColor = PitayaStyle.colorList[randomNum];
    });
  }

  void _refresh() {
    setState(() {
      this._counter = 0;
      this._isBoxVisible = false;
      this._background = PitayaStyle.PitayaBackground;
      this._textColor = PitayaStyle.PitayaForeground;
    });
  }

  Future<void> _showInfoDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sample a Pitaya Smoothie'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Image.asset(pitaya),
                  title: Text('Add pitaya to select a color'),
                  subtitle: Text('Each pitaya you add will change the color'),
                ),
                ListTile(
                  leading: Image.asset(sprocket),
                  title: Text('Mix it up to view the color'),
                  subtitle: Text('The new color and ARGB code will appear'),
                ),
                ListTile(
                  leading: Image.asset(unicorn),
                  title: Text('Hit the party button!'),
                  subtitle: Text(
                    'Not enough color? Mix and match the Pitaya Smoothie pallette for unique combinations',
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.replay),
                  title: Text('Start over'),
                  subtitle: Text('Hit refresh to build a brand new smoothie'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Got it!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // Unicorn button animation controller
    unicornController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));

    nodAnimation = Tween(begin: 360.0, end: 300.0).animate(
        CurvedAnimation(parent: unicornController, curve: Curves.linear));

    unicornController.addListener(() {
      setState(() {});
    });

    unicornController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        unicornController.reverse();
      }
    });

    // Mix it button animation controller
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));

    rotationAnimation = Tween(begin: 360.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Image.asset(pitaya),
        actions: [
          IconButton(
            icon: Icon(Icons.replay),
            onPressed: this._refresh,
          ),
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: this._showInfoDialog,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(logo),
            Text(
              'How many pitayas would you like in your smoothie?',
              style: PitayaStyle.bodyTextStyle(
                  this._textColor == PitayaStyle.PitayaBackground
                      ? PitayaStyle.PitayaForeground
                      : this._textColor),
            ),
            Text(
              '$_counter',
              style: PitayaStyle.bodyTextStyle(
                  this._textColor == PitayaStyle.PitayaBackground
                      ? PitayaStyle.PitayaForeground
                      : this._textColor),
            ),
            Visibility(
              visible: this._isBoxVisible,
              child: Container(
                width: 250.0,
                height: 250.0,
                decoration: BoxDecoration(
                  color: this._textColor,
                  border: Border.all(
                    color: this._textColor == PitayaStyle.PitayaForeground
                        ? Colors.transparent
                        : Colors.white,
                    width: 5,
                  ),
                ),
                child: Center(
                  child: Text(
                    this._textColor.toString(),
                    style: TextStyle(
                      color: this._lightColors.contains(this._textColor)
                          ? PitayaStyle.PitayaBackground
                          : Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: this._background,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Party Button
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(nodAnimation.value)),
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    onPressed: () {
                      unicornController.forward();
                      _party();
                    },
                    tooltip: 'Party!',
                    child: Image.asset(unicorn),
                    heroTag: null,
                  ),
                ),
              ],
            ),
          ),
          // Mix it Button
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Transform(
                  transform: Matrix4.rotationZ(
                      getRadiansFromDegree(rotationAnimation.value)),
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    onPressed: () {
                      if (animationController.isCompleted) {
                        animationController.reverse();
                      } else {
                        animationController.forward();
                      }
                      _mixItUp();
                    },
                    tooltip: 'Mix it!',
                    child: Image.asset(sprocket),
                    heroTag: null,
                  ),
                ),
              ],
            ),
          ),
          // Pitaya Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: _addPitaya,
                tooltip: 'Add Pitaya!',
                child: Image.asset(pitaya),
                heroTag: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PitayaStyle {
  //
  PitayaStyle._();

  static const double LargeTextSize = 26.0;
  static const double MediumTextSize = 20.0;

  // Colors from Pitaya Smoothie Theme
  // https://github.com/trallard/pitaya_smoothie
  static const Color PitayaBackground = Color(0xFF181036);
  static const Color PitayaForeground = Color(0xFFFEFEFF);
  static const Color PitayaComment = Color(0xFF5C588A);
  static const Color PitayaKeyword = Color(0xFFF26196);
  static const Color PitayaString = Color(0xFF7998F2);
  static const Color PitayaNumber = Color(0xFFF3907E);
  static const Color PitayaBuiltinConstant = Color(0xFFCAF884);
  static const Color PitayaConstant = Color(0xFFA267F5);
  static const Color PitayaOther = Color(0xFF66E9EC);
  static const Color PitayaDeleted = Color(0xFFFF6E9C);
  static const Color PitayaInserted = Color(0xFF18C1C4);
  static const Color PitayaChanged = Color(0xFFFFE46B);

  static List<Color> colorList = [
    PitayaBackground,
    PitayaForeground,
    PitayaComment,
    PitayaKeyword,
    PitayaString,
    PitayaNumber,
    PitayaBuiltinConstant,
    PitayaConstant,
    PitayaOther,
    PitayaDeleted,
    PitayaInserted,
    PitayaChanged
  ];

  static Color fetchNewColor(int i) {
    if (i < colorList.length) {
      return colorList[i];
    } else {
      return colorList[i % colorList.length];
    }
  }

  static final TextStyle appBarTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: LargeTextSize,
    fontStyle: FontStyle.italic,
    color: PitayaForeground,
  );

  static final FloatingActionButtonThemeData fabTheme =
      FloatingActionButtonThemeData(
    elevation: 0,
    backgroundColor: Colors.transparent,
  );

  static TextStyle bodyTextStyle([Color textColor = PitayaForeground]) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: LargeTextSize,
      color: textColor,
    );
  }

  static final AppBarTheme pitayaAppBarStyle = AppBarTheme(
    textTheme: TextTheme(headline6: appBarTextStyle),
    color: Colors.white.withOpacity(0.11),
  );
}
