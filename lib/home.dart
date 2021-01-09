import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:video_player/video_player.dart';



Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}

class ThirdRoute extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();

  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  loadModel() async {
    String res;
    switch (_model) {


      case mobilenet:
        res = await Tflite.loadModel(
            model: "assets/graph.tflite",
            labels: "assets/labels.txt");
        break;

      case posenet:
        res = await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
        break;


      default:
        res = await Tflite.loadModel(
            model: "assets/graph.tflite",
            labels: "assets/labels.txt");
    }
    print(res);
  }

  onSelect(model) {
    _model = model;

    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    _recognitions = recognitions;
    _imageHeight = imageHeight;
    _imageWidth = imageWidth;
  }

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = new FlutterTts();
    flutterTts.speak("Welcome Back. Are you ready for your session?");
    return Scaffold(
        backgroundColor: Color(0xff7F84BE),
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text(
                "Welcome Back",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    fontFamily: "Arial"),
              ),
              Image.asset(
                'assets/lola.gif',
              ),

              ButtonTheme(
                  minWidth: 180.0,
                  height: 50.0,
                  child: RaisedButton(
                      child: const Text("Begin"),
                      color: Colors.deepPurpleAccent,
                      onPressed: () => onSelect(posenet))),

              SizedBox(height: 10),
              ButtonTheme(
                minWidth: 180.0,
                height: 50.0,
                child: RaisedButton(
                    child: const Text("Enroll"),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      //I integrated 2 text to speech engines
                      FlutterTts flutterTts = new FlutterTts();
                      flutterTts.speak("Hello World");

                      VoiceController controller =
                          FlutterTextToSpeech.instance.voiceController();
                      controller.init().then((_) {
                        controller.speak("testing audio output",
                            VoiceControllerOptions(delay: 5));
                      });
                      showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                              backgroundColor: Color(0xff7F84BE),
                              title: new Text("Monthly Fee: 100 USD"),
                              content: new Container(
                                  width: 300.0,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/lola.gif',
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'Card #'),
                                        ),
                                        TextFormField(
                                          decoration:
                                              InputDecoration(labelText: 'CVC'),
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'MM/YY'),
                                        ),
                                        RaisedButton(
                                            child: const Text("Enroll"),
                                            color: Colors.deepPurpleAccent,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            })
                                      ]))));
                      //  Navigator.pop(context);
                    }),
              ),
            ])));
  }
}

class SecondRoute extends StatelessWidget {
  @override




  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("POSTURE INFO"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Expanded(
                child: ButtonTheme(
                  minWidth: 360.0,
                  child: RaisedButton(
                      child: const Text("Plank"),
                      color: Colors.red,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlankRoute()),
                      )),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  minWidth: 360.0,
                  child: RaisedButton(
                      child: const Text("plank video"),
                      color: Colors.red,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => plank()),
                      )),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  minWidth: 360.0,
                  child: RaisedButton(
                      child: const Text("Mountain"),
                      color: Colors.deepPurpleAccent,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MountainRoute()),
                      )
                  ),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  minWidth: 360.0,
                  child: RaisedButton(
                      child: const Text("mountain video"),
                      color: Colors.deepPurpleAccent,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => mountain()),
                      )),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  minWidth: 360.0,
                  child: RaisedButton(
                      child: const Text("Tree"),
                      color: Colors.yellow,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TreeRoute()),
                      )),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  minWidth: 360.0,
                  child: RaisedButton(
                      child: const Text("tree video"),
                      color: Colors.yellow,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => myv()),
                      )),
                ),
              ),

              Expanded(
                child: ButtonTheme(
                  minWidth: 360.0,
                  child: RaisedButton(
                      child: const Text("warrior 1"),
                      color: Colors.lightBlue,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => W1Route()),
                      )
                  ),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  minWidth: 360.0,
                  child: RaisedButton(
                      child: const Text("warrior 1 video"),
                      color: Colors.lightBlue,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => myv1()),
                      )),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  minWidth: 360.0,
                  child: RaisedButton(
                      child: const Text("warrior 2"),
                      color: Colors.green,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => W2Route()),
                      )
                  ),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  minWidth: 360.0,
                  child: RaisedButton(
                      child: const Text("warrior 2 video"),
                      color: Colors.green,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => w2()),
                      )),
                ),
              ),
            ]),
      ),
    );
  }
}
//////////////////////////////

class w2 extends StatefulWidget {
  final _callback; // callback reference holder
  //you will pass the callback here in constructor
  w2( {@required void toggleCoinCallback() } ) :
        _callback = toggleCoinCallback;
  @override
  _w2State createState() => _w2State();
}



class _w2State extends State<w2>{




  VideoPlayerController _controller;
  bool _isPlaying=false;


  @override
  void initState(){
    super.initState();
    _controller = VideoPlayerController.asset('assets/How to Do a Warrior Two - Yoga.mp4')
      ..addListener((){
        final bool isPlaying = _controller.value.isPlaying;
        if(isPlaying != _isPlaying){
          setState((){
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_){

        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title:'video player',
        home:Scaffold(
          backgroundColor: Colors.black,
          body:Center(
            child: _controller.value.initialized
                ?AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                :Container(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _controller.value.isPlaying
                ?_controller.pause
                :_controller.play,
            child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          ),
        ));

  }
}



//////////////////////////////
class mountain extends StatefulWidget {
  final _callback; // callback reference holder
  //you will pass the callback here in constructor
  mountain( {@required void toggleCoinCallback() } ) :
        _callback = toggleCoinCallback;
  @override
  _MountState createState() => _MountState();
}



class _MountState extends State<mountain>{




  VideoPlayerController _controller;
  bool _isPlaying=false;


  @override
  void initState(){
    super.initState();
    _controller = VideoPlayerController.asset('assets/videoplayback1.mp4')
      ..addListener((){
        final bool isPlaying = _controller.value.isPlaying;
        if(isPlaying != _isPlaying){
          setState((){
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_){

        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title:'video player',
        home:Scaffold(
          backgroundColor: Colors.black,
          body:Center(
            child: _controller.value.initialized
                ?AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                :Container(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _controller.value.isPlaying
                ?_controller.pause
                :_controller.play,
            child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          ),
        ));

  }
}
//////////////////////////////////////////////////////

class plank extends StatefulWidget {
  final _callback; // callback reference holder
  //you will pass the callback here in constructor
  plank( {@required void toggleCoinCallback() } ) :
        _callback = toggleCoinCallback;
  @override
  _plankState createState() => _plankState();
}



class _plankState extends State<plank>{




  VideoPlayerController _controller;
  bool _isPlaying=false;


  @override
  void initState(){
    super.initState();
    _controller = VideoPlayerController.asset('assets/Beginners Yoga- How to do Plank.mp4')
      ..addListener((){
        final bool isPlaying = _controller.value.isPlaying;
        if(isPlaying != _isPlaying){
          setState((){
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_){

        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title:'video player',
        home:Scaffold(
          backgroundColor: Colors.black,
          body:Center(
            child: _controller.value.initialized
                ?AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                :Container(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _controller.value.isPlaying
                ?_controller.pause
                :_controller.play,
            child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          ),
        ));

  }
}


//////////////////////////////////////////////////////

class myv extends StatefulWidget {
  final _callback; // callback reference holder
  //you will pass the callback here in constructor
  myv( {@required void toggleCoinCallback() } ) :
        _callback = toggleCoinCallback;
  @override
  _MyppState createState() => _MyppState();
}



class _MyppState extends State<myv>{




  VideoPlayerController _controller;
  bool _isPlaying=false;


  @override
  void initState(){
    super.initState();
    _controller = VideoPlayerController.asset('assets/How to Do a Tree Pose (Vrksasana) - Yoga.mp4')
      ..addListener((){
        final bool isPlaying = _controller.value.isPlaying;
        if(isPlaying != _isPlaying){
          setState((){
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_){

        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title:'video player',
        home:Scaffold(
          backgroundColor: Colors.black,
          body:Center(
            child: _controller.value.initialized
                ?AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                :Container(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _controller.value.isPlaying
                ?_controller.pause
                :_controller.play,
            child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          ),
        ));

  }
}


//////////////////////////////////////////////////////
class myv1 extends StatefulWidget {
final _callback; // callback reference holder
//you will pass the callback here in constructor
myv1( {@required void toggleCoinCallback() } ) :
_callback = toggleCoinCallback;
@override
_MyppState2 createState() => _MyppState2();
}



class _MyppState2 extends State<myv1>{




  VideoPlayerController _controller;
  bool _isPlaying=false;


  @override
  void initState(){
    super.initState();
    _controller = VideoPlayerController.asset('assets/How to Do a Warrior One - Yoga.mp4')
      ..addListener((){
        final bool isPlaying = _controller.value.isPlaying;
        if(isPlaying != _isPlaying){
          setState((){
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_){

        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title:'video player',
        home:Scaffold(
          backgroundColor: Colors.black,
          body:Center(
            child: _controller.value.initialized
                ?AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                :Container(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _controller.value.isPlaying
                ?_controller.pause
                :_controller.play,
            child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          ),
        ));

  }
}

//////////////////////////////
class PlankRoute extends StatelessWidget {
  @override

  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("yoga info"),
      ),
      body: Center(
        child:Image(
            image:
            NetworkImage('https://i0.wp.com/www.yogabasics.com/yogabasics2017/wp-content/uploads/2013/11/Plank_9660.jpg?w=700&ssl=1')),

      ),

    );
  }
}
///////////////////////////
class W2Route extends StatelessWidget {
  @override

  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("yoga info"),
      ),
      body: Center(
        child:Image(
            image:
            NetworkImage('https://i1.wp.com/www.yogabasics.com/yogabasics2017/wp-content/uploads/2013/12/warrior2_9422.jpg?w=700&ssl=1')),

      ),

    );
  }
}


//////////////////////////

class W1Route extends StatelessWidget {
  @override

  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("yoga info"),
      ),
      body: Center(
        child:Image(
            image:
            NetworkImage('https://i0.wp.com/www.yogabasics.com/yogabasics2017/wp-content/uploads/2013/12/warrior1_9429.jpg?w=700&ssl=1')),

      ),

    );
  }
}

//////////////////////////

class MountainRoute extends StatelessWidget {
  @override

  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("yoga info"),
      ),
      body: Center(
        child:Image(
            image:
            NetworkImage('https://i2.wp.com/www.yogabasics.com/yogabasics2017/wp-content/uploads/2013/11/Tadasana_2270.jpg?w=700&ssl=1')),

      ),

    );
  }
}


////////////////////////////
class TreeRoute extends StatelessWidget {
  @override

  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("yoga info"),
      ),
      body: Center(
        child:Image(
            image:
            NetworkImage('https://i1.wp.com/www.yogabasics.com/yogabasics2017/wp-content/uploads/2013/12/tree_9454.jpg?w=700&ssl=1')),

      ),

    );
  }
}
////////////////////////////////






class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => new _HomePageState();

}


class _HomePageState extends State<HomePage> {

  FlutterTts flutterTts = new FlutterTts();
  double ttsSpeechRate = 0.5;

 // flutterTts.speak("Welcome Back. Are you ready for your session? Begin in Mountain Pose (Tadasana), standing with your feet hip-distance apart and your arms at your sides. Let your thoughts settle. Focus on the present moment. Breathe deeply and evenly, calming your mind. Draw your awareness inward. Turn to the left. Exhale as you step your feet wide apart, about 4 to 5 feet. Turn your right foot out 90 degrees, so your toes are pointing to the top of the mat.Pivot your left foot inwards at a 45-degree angle Align your front heel with the arch of your back foot. Keep your pelvis turned toward the front of your mat.Press your weight through your left heel. Then, exhale as you bend your right knee over your right ankle. Your shin should be perpendicular to the floor. Lift through the arches of your feet, while rooting down through your ankles.Reach up strongly through your arms. Broaden across your belly, lengthen the sides of your waist, and lift through your chest. Keep your palms and fingers active and reaching.Gently tilt your head back and gaze up at your thumbs. Keep your shoulders dropped away from your ears. Feel your shoulder blades pressing firmly inward.Press down through the outer edge of your back foot, keeping your back leg straight.Hold for a minute To release the pose, press your weight through your back heel and straighten your front leg. Lower your arms. Turn to the left, reversing the position of your feet, and repeat for the same length of time on the opposite side.");


  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();
  }

  loadModel() async {
    String res;
    switch (_model) {
      case mobilenet:
        res = await Tflite.loadModel(
            model: "assets/graph.tflite",
            labels: "assets/labels.txt");
        break;

      case posenet:
        res = await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
        break;

        default:
        res = await Tflite.loadModel(
            model: "assets/graph.tflite",
            labels: "assets/labels.txt");
    }
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xff7F84BE),
      body: _model == ""
          ? Center(
              child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/lola.gif',
                    ),
                    Text(
                      "Welcome User",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                          fontFamily: "Arial"),
                    ),

                    SizedBox(height: 10),
                    ButtonTheme(
                      minWidth: 180.0,
                      height: 50.0,
                      child: RaisedButton(
                          child: const Text("Posture Detection"),
                          color: Colors.deepPurpleAccent,
                          onPressed: () {
                            onSelect(mobilenet);
                          }
                          ),

                    ),
                    SizedBox(height: 10),
                    ButtonTheme(
                      minWidth: 180.0,
                      height: 50.0,
                      child: RaisedButton(
                          child: const Text("Yoga Posture info"),
                          color: Colors.deepPurpleAccent,
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondRoute()),
                              )
                      ),
                    ),

                    RaisedButton(
                      child: const Text('tree'),
                        onPressed: () {
                          onSelect(posenet);
                          flutterTts.setSpeechRate(0.8);
                          flutterTts.speak(" hi everyone lets start our yoga lesson of tree From Mountain pose, bend the right knee shifting all the weight into the left leg. Turn the right knee to the right wall resting the heel against the left leg.next Look down at the floor and stare at one point. Slowly slide the right foot up the left leg, only as high up as you can maintain your balance. When you are balanced here, slowly bring the palms together, prayer position in front of the heart.third step Keep staring at your focal point on the floor. Keep the left leg strong pressing the foot into the floor. Keep the right knee bent 90 degrees towards the side wall. The shoulders are down and back and the chest is pressing forward.next If you are very balanced here, try the next stage by inhaling the arms over the head. The arms are in an H position, or the palms are together with the thumbs crossed, or the fingers are interlaced with the index finger pointed up. The fingers are reaching up and the shoulders are down and back.then Breathe and hold for 4-8 breath To release: slowly exhale the arms down and then release the legs back into mountain.Repeat on the other side.");
                        }

                    ),
                    RaisedButton(
                      child: const Text('mountain'),
                        onPressed: () {
                          onSelect(posenet);
                          flutterTts.setSpeechRate(0.8);
                          flutterTts.speak(" hi everyone lets start our yoga lesson of mountain From a standing position, bring the feet together or hip width apart, parallel. Lift up the toes, spread them wide and place them back on the floor. Feel your weight evenly balanced through the bottom of each foot, not leaning forward or back.next Pull up the knee caps, squeeze the thighs and tuck the tailbone slightly under.  Feel the hips aligned directly over the ankles. The legs are straight, but the knees are not locked back.then Inhale and lift out of the waist, pressing the crown of the head up towards the ceiling, feeling the spine long and straight.now Exhale and drop the shoulders down and back as you reach the fingertips towards the floor. Gently press the chest / sternum towards the front of the room..next Continuing to reach out through the fingers, inhale the arms up, turning the palms shoulder height, bringing the arms into a H position. then Exhale relax the shoulders down from the ears while still reaching the crown and fingers up. .next Breathe and hold for 4-8 breaths.To release: exhale the arms down to your sides or bring the palms together in front of your chest. ");
                        }
                    ),
                    RaisedButton(
                      child: const Text('warrior 1'),
                        onPressed: () {
                          onSelect(posenet);
                          flutterTts.speak(" hi everyone lets start our yoga lesson of warrior 1 From High Lunge pose with the right knee bent, engage the legs to ground down through the feet, and inhale the hands up to the bent knee. Use the arms to draw the torso back slightly. Make sure the right knee is directly over the right ankle.then Bring the hands to the hips and square the hips and the shoulders to the front wall. Relax the shoulders down and draw the shoulderblades towards the spine to open the chest.then Inhale the arms over the head in a H position with the palms facing each other, or bring the palms together crossing the thumbs, or interlace the fingers together and point the index finger up. Keep the shoulders relaxed and the chest lifted.next To go deeper, bring the palms together and carefully arch back and look up towards the ceiling.now Inhale deeply into the belly and chest, exhale press into the feet, fingers and crown, feeling your body expanding out in 5 directions.Keep breathing and hold for 3-6 breaths.finally To release, exhale and lower the hands down to the floor.");
                          flutterTts.setSpeechRate(0.8);
                        }
                    ),
                    RaisedButton(
                      child: const Text('warrior 2'),
                        onPressed: () {
                          onSelect(posenet);
                          flutterTts.setSpeechRate(0.8);
                          flutterTts.speak(" hi everyone lets start our yoga lesson of warrior 2 From Five Pointed Star,  turn the right toes to the right wall and bend the right knee directly over the right ankle.next  Turn the hips and the shoulders towards the front and reach out through the finger tips, reaching towards the side walls. Turn and look at the right middle finger.then Press into the feet, keeping the legs strong. Sink the hips down towards the floor, and reach the crown of the head up to lengthen the spine. Relax the shoulders down and back, pressing the chest forward.now Breathe and hold for 3-6 breaths.then To release: straighten the legs and turn the feet forward coming back into 5 pointed star.");
                        }
                    ),

                  ],
                ),
              ],
            ))
          : Stack(
              children: [
                Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                BndBox(
                    _recognitions == null ? [] : _recognitions,
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.height,
                    screen.width,
                    _model),
              ],
            ),
    );
  }
}
