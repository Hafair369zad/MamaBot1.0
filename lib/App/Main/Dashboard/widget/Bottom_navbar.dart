part of dashboard;

class _BottomNavbar extends StatelessWidget {
  _BottomNavbar({Key? key}) : super(key: key);

  final _index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _customBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: BottomNavigationBar(
              currentIndex: _index.value,
              onTap: (value) {
                _index.value = value;
                _handleNavigation(value, context);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: SizedBox.shrink(), // Kosong
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: "Profil",
                ),
              ],
              backgroundColor: Color.fromARGB(0, 0, 0, 0),
              elevation: 0,
              iconSize: 28,
              selectedItemColor: Color.fromARGB(255, 83, 179, 227),
              unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        Positioned(
          bottom: 4, // Adjust the position as needed
          child: _buildCommentIcon(context),
        ),
      ],
    );
  }

  void _handleNavigation(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          _createFadeRoute(DashboardScreen()),
        );
        break;
      case 1:
        // Kosong
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          _createFadeRoute(ProfileScreen()),
        );
        break;
      default:
        break;
    }
  }

  Route _createFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  Widget _customBackground({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0),
        borderRadius: BorderRadius.circular(37),
      ),
      child: child,
    );
  }

  Widget _buildCommentIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _handleAddChat(context);
      },
      child: Container(
        width: 84,
        height: 84,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 83, 179, 227),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add_comment_rounded,
          color: Colors.white,
          size: 31,
        ),
      ),
    );
  }

  void _handleAddChat(BuildContext context) {
    String newIsField = DateTime.now().millisecondsSinceEpoch.toString();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MessagesScreen(messages: [], isField: newIsField),
      ),
    );
  }
}
