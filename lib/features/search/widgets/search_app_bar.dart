import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  final void Function(String) onFieldSubmitted;

  const SearchAppBar({super.key, required this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4),
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 50, bottom: 12, top: 6),
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    elevation: 2,
                    child: TextFormField(
                      onFieldSubmitted: onFieldSubmitted,
                      decoration: InputDecoration(
                        hintText: "Search Amazon.in",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        prefixIcon: InkWell(
                          onTap: () {
                            debugPrint("SearchIcon Clicked");
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: IconButton(
                  onPressed: () {
                    debugPrint("Mic Clicked");
                  },
                  icon: const Icon(
                    Icons.mic,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const AddressBox(),
        ],
      ),
    );
  }
}
