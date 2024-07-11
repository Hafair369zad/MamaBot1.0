part of message;

class _AppBarMessage extends StatefulWidget {
  final VoidCallback increaseTextSize;
  final VoidCallback decreaseTextSize;
  final double textSize;

  const _AppBarMessage({
    Key? key,
    required this.increaseTextSize,
    required this.decreaseTextSize,
    required this.textSize,
  }) : super(key: key);

  @override
  State<_AppBarMessage> createState() => _AppBarMessageState();
}

class _AppBarMessageState extends State<_AppBarMessage> {
  // String? _selectedChat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 28.0, left: 28.0, top: 30.0, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // tombol back arrow
          CircleAvatar(
            backgroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                );
              },
            ),
          ),
          // tombol back arrow

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              width: 133,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.BlueButtonOnboardingBG,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    color: AppColors.BlueButtonOnboarding, width: 1.0),
              ),
              child: Center(
                child: Text(
                  'Chat Baru...',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ),
          // menu pengaturan chat
          CircleAvatar(
            backgroundColor: Colors.black,
            child: PopupMenuButton<int>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 25,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    enabled: false,
                    child: Text(
                      'Ubah Ukuran Chat',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.black),
                              onPressed: () {
                                widget.increaseTextSize();
                                setState(() {});
                              },
                            ),
                            Text(
                              '${widget.textSize.toInt()}',
                              style: TextStyle(color: Colors.black),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.black),
                              onPressed: () {
                                widget.decreaseTextSize();
                                setState(() {});
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ];
              },
            ),
          ),
          // menu pengaturan chat
        ],
      ),
    );
  }
}
