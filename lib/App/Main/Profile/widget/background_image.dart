part of profile;

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: -160,
            left: -149,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                color: CirleBLurBlue,
                shape: BoxShape.circle,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
