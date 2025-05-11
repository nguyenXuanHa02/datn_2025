import 'dart:async';

import 'package:kichikichi/core/imports/imports.dart';

class LoopingImageSlider extends StatefulWidget {
  final List<String> assetImagePaths;

  const LoopingImageSlider({super.key, required this.assetImagePaths});

  @override
  State<LoopingImageSlider> createState() => _LoopingImageSliderState();
}

class _LoopingImageSliderState extends State<LoopingImageSlider> {
  late final PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (widget.assetImagePaths.isEmpty) return;

      _currentPage = (_currentPage + 1) % widget.assetImagePaths.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.assetImagePaths.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(widget.assetImagePaths[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.assetImagePaths.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? Colors.blue : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }
}

class BaseBanner extends StatelessWidget {
  const BaseBanner({super.key, required this.data});
  final Map data;
  @override
  Widget build(BuildContext context) {
    return AppSize.radiusSmall.roundedAll(
      const LoopingImageSlider(
        assetImagePaths: [
          'assets/svg/kichi1.png',
          'assets/svg/kichi2.jpg',
          'assets/svg/kichi3.jpg'
        ],
      ),
    );
  }
}
