part of dashboard;

class _updateFiture extends StatelessWidget {
  final String _username;
  final bool isLoading;

  _updateFiture({
    Key? key,
    required String username,
    required bool isLoading,
  })  : _username = username,
        this.isLoading = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 650,
          height: 250,
          // padding: const EdgeInsets.only(right: 25.0, left: 15.0, top: 0),
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.only(right: 25.0, left: 25.0, top: 40),
                child: Image.asset(
                  'assets/images/updateBar(3).png',
                  alignment: Alignment.center,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 45.0, right: 45.0, top: 60.0),
                    child: _HaloUser(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45.0, top: 30.0),
                    child: _userInfo(),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: -6,
                width: 163,
                height: 190,
                child: Image.asset('assets/images/2NewRobotMamabot.png'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _HaloUser() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text:
                'Halo,                                                                                ', // jangan dihapus
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              fontFamily: 'Poppins',
            ),
          ),
          TextSpan(
            text: _username,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
      maxLines: 2,
    );
  }

  Widget _userInfo() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null
        ? FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('Users')
                .doc(user.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _skeletonCard();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data!.exists) {
                var userData = snapshot.data!.data() as Map<String, dynamic>;
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: emailBgDashboard,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${userData['email']}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                );
              } else {
                return Text('No profile data');
              }
            },
          )
        : Text('User not logged in');
  }

  Widget _skeletonCard() {
    return SkeletonAnimation(
      child: Container(
        width: 250,
        height: 40,
        padding: const EdgeInsets.only(left: 40.0, top: 30.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
