import 'package:flutter/material.dart';

class DealOfTheDay extends StatelessWidget {
  const DealOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 16, bottom: 6),
            child: const Text(
              "Deal Of the Day",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Image.network(
            "https://cdn.pixabay.com/photo/2020/06/26/12/21/macbook-pro-5342546_1280.png",
            height: 235,
            fit: BoxFit.fitHeight,
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 16),
            child: const Text(
              "\$888.44",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 16, top: 6, right: 14),
            child: const Text(
              "Ibrahim",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  "https://cdn.pixabay.com/photo/2020/06/26/12/21/macbook-pro-5342546_1280.png",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://cdn.pixabay.com/photo/2020/06/26/12/21/macbook-pro-5342546_1280.png",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://cdn.pixabay.com/photo/2020/06/26/12/21/macbook-pro-5342546_1280.png",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://cdn.pixabay.com/photo/2020/06/26/12/21/macbook-pro-5342546_1280.png",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  "https://cdn.pixabay.com/photo/2020/06/26/12/21/macbook-pro-5342546_1280.png",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
            alignment: Alignment.topLeft,
            child: Text(
              "See all deals",
              style: TextStyle(
                color: Colors.cyan[800],
              ),
            ),
          )
        ],
      ),
    );
  }
}
