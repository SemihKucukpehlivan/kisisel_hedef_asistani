import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final Widget nextPage;
  final String imagePath;

  const CardWidget({
    Key? key,
    required this.title,
    required this.nextPage,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => nextPage)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.green,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          shadowColor: Colors.white,
          semanticContainer: false,
          elevation: 70.0,
          surfaceTintColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
