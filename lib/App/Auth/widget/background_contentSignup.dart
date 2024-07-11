part of Signup;

class _BackgroundContentSignup extends StatelessWidget {
  const _BackgroundContentSignup({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * 0.9;
    return Container(
      width: width,
      height: height,
      child: child,
      decoration: BoxDecoration(
          color: FillWhiteOnboarding,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
    );
  }
}
