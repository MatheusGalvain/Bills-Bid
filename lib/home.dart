import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/mini-logo.png",
                      width: 30,
                      height: 30,
                    ),
                    Text(
                      "BILLS ",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "BID",
                      style: TextStyle(color: Color(0xFF7BC144)),
                    )
                  ],
                ),
              ),
            )),
        body: Center(
          child: Carousel(),
        ));
  }
}

class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;

  List<String> imagesC = [
    "images/teste1.png",
    "images/teste2.png",
    "images/teste3.png"
  ];

  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: PageView.builder(
            itemCount: imagesC.length,
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
              });
            },
            itemBuilder: (context, pagePosition) {
              bool active = pagePosition == activePage;
              return slider(imagesC, pagePosition, active);
            },
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(imagesC.length, activePage))
      ],
    );
  }
}

AnimatedContainer slider(imagesC, pagePosition, active) {
  double margin = active ? 10 : 20;

  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    decoration: new BoxDecoration(
        image:
            new DecorationImage(image: ExactAssetImage(imagesC[pagePosition]))),
  );
  if (pagePosition == 1) {
    const Text("texto1");
  }
}

imageAnimation(PageController animation, imagesC, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      print(pagePosition);

      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: EdgeInsets.all(10),
      child: Image.network(imagesC[pagePosition]),
    ),
  );
}

List<Widget> indicators(imagesCLenght, currentIndex) {
  return List<Widget>.generate(imagesCLenght, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}