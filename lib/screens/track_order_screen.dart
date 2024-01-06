import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habibi_kitchen/common_methods/build_drawer.dart';
import 'package:habibi_kitchen/provider/order_provider/order_provider.dart';
import 'package:habibi_kitchen/provider/user_auth/user_auth_provider.dart';
import 'package:habibi_kitchen/widgets/orderItem_widget.dart';
import 'package:provider/provider.dart';
import 'my_cart_screen.dart';

class OrderTrackingWidget extends StatefulWidget {
  const OrderTrackingWidget({super.key});

  @override
  State<OrderTrackingWidget> createState() => _OrderTrackingWidgetState();
}

class _OrderTrackingWidgetState extends State<OrderTrackingWidget> {
  SelectedOrderListEnum selectedOrderListEnum =
      SelectedOrderListEnum.InProgress;
  OrderProvider? orderProvider;
  @override
  void didChangeDependencies() async {
    orderProvider ??= Provider.of<OrderProvider>(context);
    await orderProvider!.loadOrders();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("order no in progress: ${orderProvider!.inProgressOrders.length}");
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      drawer: buildDrawer(
        context,
        Provider.of<MyFirebaseAuthProvider>(context),
      ),
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text("Order History",
            style: getTextStyle(
              // color: const Color(0xffc24a01),
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xff212435),
            size: 24,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Container(
          //   height: 1,
          //   width: double.maxFinite,
          //   color: Colors.black,
          // ),
          Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
            width: double.maxFinite,
            // color: Colors.black,

            child: Text(
              'Overview',
              style: getTextStyle(
                  // color: const Color(0xffc24a01),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  child: Card(
                    margin: const EdgeInsets.all(4.0),
                    // color: const Color(0xffe0e0e0),
                    color: const Color(0xffc24a01),
                    shadowColor: const Color(0xff000000),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side:
                          const BorderSide(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        // backgroundColor: const Color(0xffc24a01),
                        // backgroundColor: const Color.fromARGB(255, 1, 14, 194),
                        backgroundColor: Colors.white,
                        // backgroundColor: const Color(0xffe0e0e0),
                        radius: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text(
                                orderProvider?.inProgressOrders.length
                                        .toString() ??
                                    '0',
                                style: const TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xffc24a01),
                                  color: Color(0xffc24a01),
                                ),
                              ),
                            ),
                            Text(
                              "Pending",
                              style: getTextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (selectedOrderListEnum ==
                        SelectedOrderListEnum.InProgress) {
                      return;
                    } else {
                      setState(
                        () {
                          selectedOrderListEnum =
                              SelectedOrderListEnum.InProgress;
                        },
                      );
                    }
                  },
                ),
                InkWell(
                  child: Card(
                    margin: const EdgeInsets.all(4.0),
                    // color: const Color(0xffe0e0e0),
                    color: const Color(0xffc24a01),
                    shadowColor: const Color(0xff000000),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(
                        color: Color(0x4d9e9e9e),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        // backgroundColor: const Color(0xffc24a01),
                        // backgroundColor: const Color.fromARGB(255, 1, 14, 194),
                        backgroundColor: Colors.white,
                        // backgroundColor: const Color(0xffe0e0e0),
                        radius: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text(
                                orderProvider?.completedOrders.length
                                        .toString() ??
                                    '0',
                                style: const TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  // color: Color(0xffc24a01),
                                  color: Color(0xffc24a01),
                                ),
                              ),
                            ),
                            Text(
                              "Completed",
                              style: getTextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (selectedOrderListEnum ==
                        SelectedOrderListEnum.Completed) {
                      return;
                    } else {
                      setState(
                        () {
                          selectedOrderListEnum =
                              SelectedOrderListEnum.Completed;
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: double.maxFinite,
            color: Colors.black,
          ),
          (orderProvider!.inProgressOrders.isEmpty &&
                  orderProvider!.completedOrders.isEmpty)
              ? Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white.withOpacity(0.1),
                    child: const Text(
                        "You don't have any pending or completed orders"),
                  ),
                )
              : Expanded(
                  child: selectedOrderListEnum ==
                          SelectedOrderListEnum.InProgress
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: Text(
                                "Pending Orders",
                                textAlign: TextAlign.left,
                                style: getTextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            orderProvider!.inProgressOrders.isEmpty
                                ? const Center(
                                    child: Text("No Pending Orders Found"),
                                  )
                                : Expanded(
                                    child: Consumer<OrderProvider>(
                                      builder: (context, value, child) {
                                        return ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: orderProvider!
                                              .inProgressOrders.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              child: OrderItemView(
                                                index: index,
                                                order: orderProvider!
                                                    .inProgressOrders[index],
                                              ),
                                              onTap: () {
                                                // Navigator.of(context).pop();
                                                Navigator.pushNamed(
                                                  context,
                                                  '/orderDescriptionScreen',
                                                  arguments: orderProvider!
                                                      .inProgressOrders[index],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text(
                                "Completed Orders",
                                style: getTextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            orderProvider!.completedOrders.isEmpty
                                ? const Center(
                                    child: Text("No Completed Orders Found"),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      itemCount:
                                          orderProvider!.completedOrders.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          child: OrderItemView(
                                            index: index,
                                            order: orderProvider!
                                                .completedOrders[index],
                                          ),
                                          onTap: () {
                                            // Navigator.of(context).pop();
                                            Navigator.pushNamed(context,
                                                '/orderDescriptionScreen',
                                                arguments: orderProvider!
                                                    .completedOrders[index]);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                ),
        ],
      ),
    );
  }
}

String calculateTimeDifference(
    Timestamp currentTimestamp, Timestamp oldTimestamp) {
  DateTime currentDateTime = currentTimestamp.toDate();
  DateTime oldDateTime = oldTimestamp.toDate();

  Duration difference = currentDateTime.difference(oldDateTime);

  int hours = difference.inHours;
  int minutes = difference.inMinutes.remainder(60);

  String formattedDifference = ' $hours Hours $minutes Minutes';

  return formattedDifference;
}

enum SelectedOrderListEnum { InProgress, Completed }
