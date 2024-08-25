import 'package:flutter/material.dart';

class CostCalculation extends StatefulWidget {
  const CostCalculation({super.key});

  @override
  State<CostCalculation> createState() => _CostCalculationState();
}

class _CostCalculationState extends State<CostCalculation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageScreen()));
            },
            icon: const Icon(Icons.home, color: Colors.black,),
          ),
          const SizedBox(width: 10,),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Bg2.png"),
              fit: BoxFit.cover,
            )
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
