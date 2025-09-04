import 'package:equatable/equatable.dart';

abstract class DeviceEvent extends Equatable {
  @override
  List<Object?> get props => [];
} 

class LoadDeviceDashboard extends DeviceEvent {}