import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jesper_task/bloc/common_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String formatTime(String time) {
    final DateFormat format = DateFormat('h:mm a');
    final DateTime dateTime = DateTime.parse("2020-01-01 $time");
    return format.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Foodie Finder",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white54,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: Colors.indigo[900],
        elevation: 10.0,
        centerTitle: true,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      backgroundColor: Colors.grey[50],
      body: BlocConsumer<CommonBloc, CommonState>(
        listener: (context, state) {
          if (state is CommonError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CommonInitial || state is CommonLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CommonLoaded) {
            return ListView.builder(
              itemCount: state.loadedData.length,
              itemBuilder: (context, index) {
                final loadedData = state.loadedData[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              loadedData.branchImage,
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            loadedData.branchName,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loadedData.locationName,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 24,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${loadedData.averageRating} (${loadedData.totalRatingCount} reviews)',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Text(
                            "Opening Hours",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Morning: ${formatTime(loadedData.openingFromTime1)} - ${formatTime(loadedData.openingToTime1)}",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            "Afternoon: ${formatTime(loadedData.openingFromTime2)} - ${formatTime(loadedData.openingToTime2)}",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            "Evening: ${formatTime(loadedData.openingFromTime3)} - ${formatTime(loadedData.openingToTime3)}",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Branch Details",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Branch Code: ${loadedData.branchCode}",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            "Organization: ${loadedData.organizationName}",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            "Minimum Order Value: ${loadedData.minimumOrderValue}",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.green,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  final latitude =
                                      double.tryParse(loadedData.latitude) ??
                                          00;
                                  final longitude =
                                      double.tryParse(loadedData.longitude) ??
                                          00;
                                  _launchMap(latitude, longitude);
                                },
                                child: Text(
                                  loadedData.mapLocation,
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.green,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () =>
                                    _launchPhoneDialer(loadedData.mobileNumber),
                                child: Text(
                                  loadedData.mobileNumber,
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }

  Future<void> _launchPhoneDialer(String phoneNumber) async {
    final url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch dialer for $phoneNumber');
    }
  }

  Future<void> _launchMap(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not open map for location $latitude, $longitude');
    }
  }
}
