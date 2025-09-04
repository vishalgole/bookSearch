import 'package:booksearch/presentation/bloc/sensor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../bloc/sensor_event.dart';
import '../bloc/sensor_state.dart';

class SensorPage extends StatefulWidget{
  const SensorPage({super.key});

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SensorBloc>().add(LoadFlashAvailability());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Information'),
      ),
      body: BlocBuilder<SensorBloc, SensorState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(state.flashon ? Icons.flash_on : Icons.flash_off, size: 100, color: state.flashAvailable ? Colors.amber : Colors.grey),
                  SizedBox(height: 200,
                  child: Lottie.asset(state.flashon ? 'assets/lottie/Torch-on.json' : 'assets/lottie/Torch-off.json'),
                  ),
                  
                  const SizedBox(height: 20),
                  ElevatedButton.icon(onPressed: (){
                    context.read<SensorBloc>().add(ToggleFlashPressed(!state.flashon));
                  },
                  icon: Icon(state.flashon ? Icons.flash_on : Icons.flash_off),
                  label: Text(state.flashon ? 'Turn Flash On' : 'Turn Flash Off'),
                ),
                const SizedBox(height: 20),
                Switch(value: state.flashon, onChanged: (value) {
                  context.read<SensorBloc>().add(ToggleFlashPressed(value));
                })
              ],
            ),
          );
        }
        },
      ),
    );
  }
}