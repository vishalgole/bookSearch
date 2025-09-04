import 'package:booksearch/presentation/bloc/device_bloc.dart';
import 'package:booksearch/presentation/bloc/device_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../bloc/device_state.dart';

class DeviceDashboard extends StatefulWidget {
  const DeviceDashboard({super.key});
  @override
  State<DeviceDashboard> createState() => _DeviceDashboardState();
}

class _DeviceDashboardState extends State<DeviceDashboard> {
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DeviceBloc>().add(LoadDeviceDashboard());
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Dashboard'),
      ),
      body: BlocBuilder<DeviceBloc, DeviceState>(
        builder: (context, state) {
          if (state.loading) {
            return Center(
              child: Lottie.asset('assets/lottie/loading.json', width: 300, height: 300),
            );
          } else if (state.error != null) {   
            return Center(child: Text('Error: ${state.error}'));
          } else  {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 2,
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _tile('Battery',state.batteryLevel == -1 ? 'Unknown' : '${state.batteryLevel}%', Icons.battery_full),
                    const Divider(),
                    _tile('Device Name', state.deviceName, Icons.phone_android),
                    const Divider(),
                    _tile('OS Version', state.deviceOSVersion, Icons.system_update),  
                  ],
                ),
              )
            );
          }
        },
      ),
    );
  }

  Widget _tile(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, size: 40),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 16)),
    );
  }
}