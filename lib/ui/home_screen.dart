import 'package:flutter/material.dart';
import 'package:scenario_maker_app/ui/screens/saved_scenarios/saved_scenarios_screen.dart';
import 'package:scenario_maker_app/ui/screens/scenario_generation/platform_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late final PageController _pageController;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  final List<Widget> _screens = [
    const PlatformSelectionScreen(),
    const SavedScenariosScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    // Запустим первую анимацию при загрузке
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    _animationController
      ..reset()
      ..forward();

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children:
            _screens.map((screen) {
              return FadeTransition(opacity: _fadeAnimation, child: screen);
            }).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              _buildAnimatedNavBarItem(Icons.home, 'Главная', 0),
              _buildAnimatedNavBarItem(Icons.bookmark, 'Сохраненные', 1),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue[600],
            unselectedItemColor: Colors.grey[400],
            iconSize: 28,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildAnimatedNavBarItem(
    IconData icon,
    String label,
    int index,
  ) {
    final isSelected = index == _selectedIndex;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(isSelected ? 1.2 : 1.0),
        transformAlignment: Alignment.center,
        child: AnimatedIconColor(
          icon: icon,
          isSelected: isSelected,
          selectedColor: Colors.blue[600]!,
          unselectedColor: Colors.grey[400]!,
        ),
      ),
      label: label,
    );
  }
}

class AnimatedIconColor extends ImplicitlyAnimatedWidget {
  final IconData icon;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;

  const AnimatedIconColor({
    Key? key,
    required this.icon,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
  }) : super(key: key, duration: const Duration(milliseconds: 300));

  @override
  _AnimatedIconColorState createState() => _AnimatedIconColorState();
}

class _AnimatedIconColorState
    extends AnimatedWidgetBaseState<AnimatedIconColor> {
  ColorTween? _colorTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _colorTween =
        visitor(
              _colorTween,
              widget.isSelected ? widget.selectedColor : widget.unselectedColor,
              (dynamic value) => ColorTween(
                begin: value as Color,
                end:
                    widget.isSelected
                        ? widget.selectedColor
                        : widget.unselectedColor,
              ),
            )
            as ColorTween?;
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorTween?.evaluate(animation) ?? widget.unselectedColor;
    return Icon(widget.icon, color: color);
  }
}
