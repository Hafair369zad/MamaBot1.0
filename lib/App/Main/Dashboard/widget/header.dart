part of dashboard;

class _Header extends StatefulWidget {
  final FirebaseAuthService _authService;
  final FirestoreService _firestoreService;
  final bool isLoading;
  final String profilePictureUrl;

  _Header({
    Key? key,
    required FirebaseAuthService authService,
    required FirestoreService firestoreService,
    required bool isLoading,
    required this.profilePictureUrl,
  })  : _authService = authService,
        _firestoreService = firestoreService,
        this.isLoading = isLoading,
        super(key: key);

  @override
  __HeaderState createState() => __HeaderState();
}

class __HeaderState extends State<_Header> {
  String _photoURL = '';
  TextEditingController _usernameController = TextEditingController();

  Future<void> _loadUserData() async {
    User? user = widget._authService.getCurrentUser();
    if (user != null) {
      await user.reload();
      user = widget._authService.getCurrentUser();

      if (mounted) {
        setState(() {
          _usernameController.text = user?.displayName ?? '';
          _photoURL = user?.photoURL ?? '';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

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
                    child: widget.isLoading
                        ? SkeletonAnimation(
                            child: Container(
                              width: 100,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )
                        : _title(),
                  ),
                ],
              ),
              widget.isLoading
                  ? SkeletonAnimation(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : _menuButton(),
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

  Widget _menuButton() {
    User? user = widget._authService.getCurrentUser();
    return StreamBuilder<DocumentSnapshot>(
      stream: widget._firestoreService.getUserDocumentStream(user?.uid ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            margin: EdgeInsets.only(top: 0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          // Check for the existence of data before accessing it
          Map<String, dynamic>? userData =
              snapshot.data!.data() as Map<String, dynamic>?;
          if (userData != null && userData.containsKey('photoURL')) {
            _photoURL = userData['photoURL'] ?? '';
          }
          // Display profile photo using updated _photoURL
          ImageProvider<Object>? imageProvider = _photoURL.isNotEmpty
              ? NetworkImage(_photoURL) as ImageProvider<Object>?
              : AssetImage('assets/default_profile.png')
                  as ImageProvider<Object>?;
          return Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: FillWhiteOnboarding, width: 1),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: imageProvider,
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.only(top: 0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/default_profile.png'),
              radius: 20,
              backgroundColor: Colors.grey[300],
            ),
          );
        }
      },
    );
  }
}
