import 'package:flutter/material.dart';

class AcercaDeScreen extends StatefulWidget {
  const AcercaDeScreen({super.key});

  @override
  State<AcercaDeScreen> createState() => _AcercaDeScreenState();
}

class _AcercaDeScreenState extends State<AcercaDeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 120, 46, 1),
      body: Column(
        children: [
          SizedBox(height: 100),
          Center(
            child: Container(
              alignment: Alignment.center,
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black, spreadRadius: 2, blurRadius: 10, blurStyle: BlurStyle.solid),
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              margin: EdgeInsets.only(bottom: 70),
              child: Text(
                "Acerca De",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            height: 500,
            width: 330,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoContainer("Primer Desarrollador", "Yohary Nuñez / 2021-2353" "    yohary_antonio29@hotmail.com"),
                _buildInfoContainer("Segundo Desarrollador", "Jesus Dominguez / 2022-0067" "    jesusd.jr45@gmail.com"),
                _buildInfoContainer("Tercer Desarrollador", "Xavier Peña / 2021-2136" "    xavierpna@gmail.com"),
                _buildInfoContainer("Cuarto Desarrollador", "Gexiel Moises / 2021-2287" "    gex.moises@gmail.com"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoContainer(String title, String subtitle) {
    return Container(
      height: 90,
      width: 300,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
