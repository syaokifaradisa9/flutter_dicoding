part of '../pages.dart';

class MainRoute extends StatefulWidget {
  const MainRoute({Key? key}) : super(key: key);

  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  final AdvancedDrawerController _advancedDrawerController = AdvancedDrawerController();
  int currentPageIndex = 0;

  List<Widget> pages = [
    const CashierPage(),
    const HistoryPage(),
    const ProductPage(),
    const CategoryPage()
  ];

  List<String> pageTitles = [
    "Kasir",
    "Riwayat Transaksi",
    "Produk",
    "Kategori"
  ];

  void changePageIndex(int pageIndex){
    currentPageIndex = pageIndex;
    _advancedDrawerController.hideDrawer();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        controller: _advancedDrawerController,
        backdropColor: Colors.blueGrey,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        drawer: SafeArea(
          child: Container(
              child: ListTileTheme(
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/illustrations/profile.png',
                              )
                            ),
                            const SizedBox(height: 14),
                            FutureBuilder<String>(
                                future: UserService.getNameFromLocal(),
                                builder: (context, snapshot) => Text(
                                    snapshot.data!,
                                    style: GoogleFonts.rubik(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white
                                    )
                                )
                            ),
                            const SizedBox(height: 20),
                            ListTile(
                                onTap: () {
                                  changePageIndex(0);
                                },
                                leading: const Icon(
                                    FontAwesomeIcons.cashRegister,
                                    size: 24
                                ),
                                title: const TextLabel(
                                  value: "Kasir",
                                  color: Colors.white,
                                )
                            ),
                            ListTile(
                                onTap: () {
                                  changePageIndex(1);
                                },
                                leading: const Icon(
                                  Icons.history_outlined,
                                  size: 24,
                                ),
                                title: const TextLabel(
                                  value: "Riwayat Transaksi",
                                  color: Colors.white,
                                )
                            ),
                            ListTile(
                                onTap: () {
                                  changePageIndex(2);
                                },
                                leading: const Icon(
                                    FontAwesomeIcons.productHunt,
                                    size: 24
                                ),
                                title: const TextLabel(
                                  value: "Produk",
                                  color: Colors.white,
                                )
                            ),
                            ListTile(
                                onTap: () {
                                  changePageIndex(3);
                                },
                                leading: const Icon(
                                    Icons.category,
                                    size: 24
                                ),
                                title: const TextLabel(
                                  value: "Kategori",
                                  color: Colors.white,
                                )
                            ),
                            ListTile(
                                onTap: () async{
                                  bool res = await showConfirmationAlert(
                                    context: context,
                                    question: "Yakin ingin logout? semua transaksi yang disimpan akan dihapus jika logout"
                                  );

                                  if(res){
                                    await AuthService.signOut();
                                  }
                                },
                                leading: const Icon(
                                    Icons.logout,
                                    color: Colors.red
                                ),
                                title: const TextLabel(
                                    value: "Logout",
                                    color: Colors.red
                                )
                            )
                          ]
                      )
                  )
              )
          )
        ),
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: primaryColor,
                  title: Text(
                      pageTitles[currentPageIndex],
                      style: formLabelTextStyle
                  ),
                  leading: GestureDetector(
                      onTap: (){
                        _advancedDrawerController.showDrawer();
                      },
                      child: const Icon(
                          FontAwesomeIcons.bars,
                          color: primaryTextColor,
                          size: 16
                      )
                  )
              ),
              body: pages[currentPageIndex]
          )
        )
    );
  }
}
