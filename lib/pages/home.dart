import "package:flutter/material.dart";
import "package:get_storage/get_storage.dart";
import "package:travel_app/data/tourism_place.dart";
import "package:travel_app/pages/login.dart";
import "package:url_launcher/url_launcher_string.dart";

const oceanBlue = Color.fromARGB(255, 0, 103, 165);
const pacificBlue = Color.fromARGB(255, 0, 145, 182);
const ceruleanBlue = Color.fromARGB(255, 1, 171, 206);
const dune = Color.fromARGB(255, 51, 51, 51);
const lightGrey = Color.fromARGB(255, 217, 217, 217);
const paleSky = Color.fromARGB(255, 107, 116, 123);

class Home extends StatelessWidget {
  const Home(this.username, {super.key});

  final String username;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_header(context), _gridList(context)],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 64,
      decoration: BoxDecoration(
        color: oceanBlue,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Explore Places',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              _showUserMenu(context);
            },
            child: const Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showUserMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(username),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  GetStorage().remove("username");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _gridList(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: tourismPlaceList.length,
          itemBuilder: (BuildContext context, int index) {
            return _travelCardItem(context, index);
          },
        ),
      ),
    );
  }

  Widget _travelCardItem(BuildContext context, int index) {
    return Card(
      child: SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6.0),
                topRight: Radius.circular(6.0),
              ),
              child: GestureDetector(
                onTap: () async {
                  launchUrlString(tourismPlaceList[index].imageUrls[0]);
                },
                child: Image(
                  image: NetworkImage(tourismPlaceList[index].imageUrls[0]),
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: 80,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 2,
              ),
              child: Text(
                tourismPlaceList[index].name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: dune,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              padding: const EdgeInsets.only(left: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 16,
                  ),
                  Text(
                    tourismPlaceList[index].location,
                    style: const TextStyle(
                        fontSize: 8, color: dune, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              padding: const EdgeInsets.only(left: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    tourismPlaceList[index].openDays,
                    style: const TextStyle(fontSize: 8, color: dune),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              padding: const EdgeInsets.only(left: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    IconData(0xee2d, fontFamily: 'MaterialIcons'),
                    size: 16,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    tourismPlaceList[index].openTime,
                    style: const TextStyle(fontSize: 8, color: dune),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.money_rounded,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    tourismPlaceList[index].ticketPrice,
                    style: const TextStyle(fontSize: 8, color: dune),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
