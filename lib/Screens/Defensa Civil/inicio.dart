import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen>
    with SingleTickerProviderStateMixin {
  int isSelect = 0;
  List<String> imageUrls = [
    'assets/inicio/1.png',
    'assets/inicio/2.png',
    'assets/inicio/3.png',
    'assets/inicio/4.png',
    'assets/inicio/5.png',
    'assets/inicio/6.png',
    'assets/inicio/7.png',
  ];
  int currentIndex = 0;
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  late AnimationController _animationController;
  double _currentPosition = 0.0;
  double _totalDuration = 1.0;
  late List<Map<String, dynamic>> _data = [];
  late List<Map<String, dynamic>> _miembros;

  @override
  void initState() {
    super.initState();
    _miembros = [];
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    audioPlayer = AudioPlayer();
    audioPlayer.onPositionChanged.listen((Duration duration) {
      _updateAudioPosition(duration);
    });

    // Obtiene la duración total del audio una vez que se carga
    audioPlayer.onDurationChanged.listen((Duration duration) {
      _updateAudioDuration(duration);
    });
    fetchData();
    _fetchDataMiembros();
  }

  void _updateAudioPosition(Duration duration) {
    if (mounted) {
      setState(() {
        _currentPosition = duration.inSeconds.toDouble();
      });
    }
  }

  void _updateAudioDuration(Duration duration) {
    if (mounted) {
      setState(() {
        _totalDuration = duration.inSeconds.toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 370,
              width: double.infinity,
              //margin: EdgeInsets.symmetric(horizontal: 9),
              decoration: BoxDecoration(
                color: Color(0xffEE782E),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff0a4271),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                              color: isSelect == 0
                                  ? Color(0xff0a4271)
                                  : Color(0xffEE782E),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: Offset(0, 7))
                              ]),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isSelect = 0;
                                });
                              },
                              child: Text(
                                'Inicio',
                                style: GoogleFonts.inter(
                                    color: isSelect == 0
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                              color: isSelect == 1
                                  ? Color(0xff0a4271)
                                  : Color(0xffEE782E),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: Offset(0, 7))
                              ]),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isSelect = 1;
                                });
                              },
                              child: Text(
                                'Historia',
                                style: GoogleFonts.inter(
                                    color: isSelect == 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                              color: isSelect == 2
                                  ? Color(0xff0a4271)
                                  : Color(0xffEE782E),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: Offset(0, 7))
                              ]),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isSelect = 2;
                                });
                              },
                              child: Text(
                                'Servicios',
                                style: GoogleFonts.inter(
                                    color: isSelect == 2
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                              color: isSelect == 3
                                  ? Color(0xff0a4271)
                                  : Color(0xffEE782E),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: Offset(0, 7))
                              ]),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  isSelect = 3;
                                });
                              },
                              child: Text(
                                'Miembros',
                                style: GoogleFonts.inter(
                                    color: isSelect == 3
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 10),
          Expanded(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder(
                future: Future.delayed(
                    Duration(milliseconds: 900)), // Agregar un pequeño retraso
                builder: (context, snapshot) {
                  return isSelect == 0
                      ? _buildIinicio()
                      : isSelect == 1
                          ? _buildHistoria()
                          : isSelect == 2
                              ? _buildServicios()
                              : _buildMiembros();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIinicio() {
    return Column(
      children: [
        Text(
          'Acciones de la Defensa Civil',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: Image.asset(imageUrls[currentIndex]).image,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        // Slider para cambiar las imágenes
        Slider(
          value: currentIndex.toDouble(),
          min: 0,
          max: imageUrls.length.toDouble() - 1,
          onChanged: (value) {
            setState(() {
              currentIndex = value.round();
            });
          },
        ),
      ],
    );
  }

  Widget _buildHistoria() {
    return Column(
      children: [
        Container(
          height: 400,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    '¿Cómo nace la Defensa Civil en el Mundo?',
                    style: GoogleFonts.inter(
                        fontSize: 19, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Luego de la primera guerra mundial, los gobiernos de los países europeos tuvieron que establecer sistemas de protección para los habitantes de grandes concentraciones urbanas en previsión de algún nuevo conflicto bélico.',
                    style: GoogleFonts.inter(
                        fontSize: 17, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    '¿Cómo se fue ampliando este concepto?',
                    style: GoogleFonts.inter(
                        fontSize: 19, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Pasaron las décadas y se pensó en ampliar la estructura de Defensa Civil para la protección de la comunidad ante terremotos, huracanes, inundaciones, aluviones, erupciones volcánicas y todo tipo de desastre natural que amenazaba la población.',
                    style: GoogleFonts.inter(
                        fontSize: 17, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 10.0),
                  Text.rich(
                    TextSpan(
                      text:
                          'El desarrollo industrial trajo aparejado graves problemas, entre ellos la posibilidad de causar accidentes tecnológicos, lo que permitió poner a prueba este sistema de protección civil para dar respuesta a nuevas situaciones de riesgo. ',
                      style: GoogleFonts.inter(
                          fontSize: 17, fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                          text: 'Leer más',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Origen y Evolución de la Defensa Civil'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // Aquí puedes agregar el resto del texto
                                            'Origen y Evolución de la Defensa Civil\n\n'
                                            '¿Cuándo comienza la Defensa Civil en nuestro país?\n\n'
                                            'En julio de 1939, con la creación del Comando de Defensa Antiaérea del Ejército, pasando por distintas etapas hasta la actualidad.\n\n'
                                            'Desde 1939 hasta 1959 pertenece al Ejército en una división llamada "Defensa Pasiva".\n\n'
                                            'Desde 1960 hasta 1968, por decreto pasa a depender de la Aeronáutica y se la denomina "Defensa Antiaérea Pasiva".\n\n'
                                            'Desde 1969 hasta 1977 adopta el nombre de "Defensa Civil" y depende del Ministerio de Defensa de la Nación.\n\n'
                                            'En 1978 se crea la "Dirección Nacional de Defensa Civil", dependiente del Ministerio de Defensa.\n\n'
                                            'En 1996 la Dirección Nacional de Defensa Civil pasa a depender del Ministerio del Interior como Dirección Nacional de Protección Civil, reemplazándose "Defensa" por "Protección" que alude a la protección de la comunidad, dejando de lado el término castrense que se asimila con un vocablo bélico acorde a la moderna legislación internacional.\n\n'
                                            'Algunas provincias argentinas han adoptado para sus Direcciones, la nueva denominación de "Protección Civil", en tanto que otras (como Formosa) siguen conservando el nombre original de "Defensa Civil".\n\n'
                                            '¿Qué se conmemora el 23 de Noviembre?\n\n'
                                            'En noviembre de 1977 hubo un violento sismo en la ciudad de Caucete en la provincia de San Juan y por primera vez en la historia se reunió la "Junta Nacional de Defensa Civil" y actúo ante una catástrofe de origen natural. Es por esta razón que el 23 de Noviembre se conmemora el DÍA DE LA DEFENSA CIVIL.\n\n'
                                            'Defensa civil en Formosa\n\n'
                                            'La Dirección de Defensa Civil de Formosa se crea en diciembre de 1969 ante la necesidad de contar con un organismo específico que pueda desarrollar las acciones de Defensa Civil en el ámbito de la provincia, compatible con el Régimen Federal de Gobierno.\n\n'
                                            'En 1969 también se crea la Junta Provincial de Defensa Civil que determina los objetivos, relaciones de autoridad y organización que se pondrán en vigencia para proteger a la población y sus bienes ante una emergencia.\n\n'
                                            'En 1975 se sanciona la Ley Nº 079 y al año siguiente el Decreto Reglamentario Nº 168 de la Ley; por los cuales se establecen las misiones y funciones que competen a la Dirección.\n\n'
                                            'La Dirección de Defensa Civil es de existencia permanente y trabaja no solo ante situaciones de emergencia, sino en todo momento; desarrollando tareas comunitarias y de prevención.\n\n'
                                            'La Junta Provincial de Defensa Civil se constituye en forma momentánea ante catástrofe de gran magnitud en que es necesario movilizar la totalidad de los recursos (humanos y materiales) con los que cuenta el Estado.\n\n'
                                            'Desde el año 2004 la Dirección de Defensa Civil integra el Consejo Provincial de Complementación para la Seguridad Interior\n',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (isPlaying) {
                  _pauseAudio();
                } else {
                  _playAudio();
                }
                setState(() {
                  isPlaying = !isPlaying;
                  isPlaying
                      ? _animationController.forward()
                      : _animationController.reverse();
                });
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: _animationController,
                size: 50.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              _formatDuration(_currentPosition.toInt()),
              style: TextStyle(fontSize: 16.0),
            ),
            Slider(
              value: _currentPosition,
              min: 0.0,
              max: _totalDuration,
              onChanged: (value) {
                audioPlayer.seek(Duration(seconds: value.toInt()));
              },
              onChangeEnd: (value) {
                audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
            Text(
              _formatDuration(_totalDuration.toInt()),
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServicios() {
    return ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(_data[index]['nombre']),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _data[index]['descripcion'],
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Image(image: NetworkImage(_data[index]['foto'])),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xffEE782E),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: Offset(0, 7),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(_data[index]['nombre']),
                subtitle: Text(
                    _data[index]['descripcion'].toString().substring(0, 50) +
                        '...'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_data[index]['foto']),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        });
  }

  Widget _buildMiembros() {
    return Container(
      color: Colors.white,
      //padding: const EdgeInsets.all(35),
      child: ListView.builder(
        itemCount: _miembros.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(255, 121, 46, 1),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(_miembros[index]['foto']),
                  radius: 30,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _truncateText(_miembros[index]['nombre'], 24),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _truncateText(_miembros[index]['cargo'], 24),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _truncateText(String text, int maxLength) {
    return (text.length <= maxLength)
        ? text
        : '${text.substring(0, maxLength)}...';
  }

  Future<void> _playAudio() async {
    if (mounted) {
      try {
        await audioPlayer.play(AssetSource('narrador.mp3'));
      } catch (e) {
        print('Error al reproducir audio: $e');
      }
    }
  }

  void _pauseAudio() {
    if (mounted) {
      audioPlayer.pause();
    }
  }

  String _formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    if (duration.inSeconds.isFinite) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String minutes = twoDigits(duration.inMinutes.remainder(60));
      String seconds = twoDigits(duration.inSeconds.remainder(60));
      return '$minutes:$seconds';
    } else {
      return '00:00';
    }
  }

  void fetchData() async {
    Dio dio = Dio();

    try {
      Response response =
          await dio.get('https://adamix.net/defensa_civil/def/servicios.php');
      if (response.statusCode == 200) {
        List<dynamic> datos = response.data['datos'];
        setState(() {
          _data = datos.cast<Map<String, dynamic>>();
        });
      } else {
        print('Error en la solicitud HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchDataMiembros() async {
    Dio dio = Dio();
    try {
      Response response =
          await dio.get('https://adamix.net/defensa_civil/def/miembros.php');
      if (response.statusCode == 200) {
        final jsonData = response.data;
        setState(() {
          _miembros = List<Map<String, dynamic>>.from(jsonData['datos']);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  void dispose() {
    _pauseAudio(); 
    _animationController.dispose(); 
    audioPlayer.dispose(); 
    super.dispose();
  }
}
