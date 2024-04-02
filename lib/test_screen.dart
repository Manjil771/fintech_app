import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _currentPageIndex = 0; // Start with the first page

  final PageController _pageController =
      PageController(initialPage: 0); // Controller for the PageView

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the page controller when not needed
    super.dispose();
  }

  void _changePage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                    _changePage(0);
                  },
                  child: const Text('Page 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                    _changePage(1);
                  },
                  child: const Text('Page 2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _pageController.animateToPage(2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                    _changePage(2);
                  },
                  child: const Text('Page 3'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Scrollable(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              viewportBuilder: (context, position) => Container(
                // height: 1500,
                child: Scaffold(
                  body: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (index) {
                      _changePage(index);
                    },
                    children: [
                      Page1(controller: controller),
                      Page2(),
                      Page3(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  final ScrollController controller;

  const Page1({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          height: 500,
          color: Colors.blue,
          child: const Center(
            child: Text('Page 1', style: TextStyle(color: Colors.white)),
          ),
        ),
        Container(
          height: 500,
          color: Colors.red,
          child: const Center(
            child: Text('Page 1', style: TextStyle(color: Colors.white)),
          ),
        ),
        Container(
          height: 500,
          color: Colors.yellow,
          child: const Center(
            child: Text('Page 1', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1500,
      color: Colors.green,
      child: const Center(
        child: Text('Page 2', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.orange,
      child: const Center(
        child: Text('Page 3', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
