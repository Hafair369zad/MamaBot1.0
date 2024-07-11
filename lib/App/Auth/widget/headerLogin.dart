part of Login;

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(
                  left: 30, right: 30, top: 65, bottom: 65),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Mama',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        height: 1.1,
                        wordSpacing: 1.1,
                      ),
                    ),
                    TextSpan(
                      text: 'Bot',
                      style: TextStyle(
                        color: BlueButtonOnboarding,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        height: 1.1,
                        wordSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
