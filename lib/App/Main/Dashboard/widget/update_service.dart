part of dashboard;

class _updateService extends StatelessWidget {
  const _updateService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              // onTap: () => _navigateToPage(context, 'Page 1'),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19.0),
                ),
                child: Container(
                  height: 130,
                  width: 105,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.computer,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'Penggunaan Teknologi Terbaru',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              // onTap: () => _navigateToPage(context, 'Page 1'),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19.0),
                ),
                child: Container(
                  height: 130,
                  width: 105,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.baby_changing_station,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'Tumbuh Kembang Anak',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19.0),
                ),
                child: Container(
                  height: 130,
                  width: 105,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.book,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'Buku KIA & SDIDTK',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
