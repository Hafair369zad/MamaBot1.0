part of profile;

class _Header extends StatelessWidget {
  _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: _title(),
                  ),
                ],
              ),
              _buttonLogout(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Row(
      children: [
        Image.asset(
          'assets/images/logoWhite.png',
          height: 30.0,
          width: 30.0,
        ),
        SizedBox(width: 1.0),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Mama',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              TextSpan(
                text: 'Bot',
                style: TextStyle(
                  color: Color(0xFF53B3E3),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttonLogout(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLogoutDialog(context);
      },
      child: Icon(
        Icons.logout,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to sign out?"),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/splashLoginSignUp",
                  (Route<dynamic> route) => false,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Successfully signed out"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
