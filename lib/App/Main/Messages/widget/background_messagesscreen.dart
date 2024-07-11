part of message;

class _BackgroundImageMessage extends StatelessWidget {
  const _BackgroundImageMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            color: AppColors.FillWhiteOnboarding,
          ),
          Image.asset(
            'assets/images/DotGridMessage.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ],
      ),
    );
  }
}
