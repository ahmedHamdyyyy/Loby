import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../../../core/services/cach_services.dart';
import '../../../../locator.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../models/property_model.dart';
import '../data/repository.dart';

part 'state.dart';

class PropertiesCubit extends Cubit<PropertiesState> {
  PropertiesCubit(this._propertiesRespository, this._cacheService) : super(const PropertiesState());
  final PropertiesRespository _propertiesRespository;
  final CacheService _cacheService;

  void getProperties() async {
    emit(state.copyWith(getStatus: Status.loading));
    try {
      final userId = _cacheService.storage.getString(AppConst.id);
      debugPrint("userId: $userId");
      final allProperties = await _propertiesRespository.getProperties();
      final userProperties = allProperties.where((property) => property.vendorId == userId).toList();
      debugPrint("userProperties: $userProperties");
   
   
      emit(state.copyWith(getStatus: Status.success, properties: userProperties));
    } catch (e) {
      emit(state.copyWith(getStatus: Status.error, msg: e.toString()));
    }
  }

  void createProperty(PropertyModel property) async {
    emit(state.copyWith(createStatus: Status.loading));
    try {
      final createdProperty = await _propertiesRespository.createProperty(property);
      emit(
        state.copyWith(
          createStatus: Status.success,
          property: createdProperty,
          properties: [...state.properties, CustomPropertyModel.fromProperty(createdProperty)],
        ),
      );
    } catch (e) {
      emit(state.copyWith(createStatus: Status.error, msg: e.toString()));
    }
  }

  void updateProperty(PropertyModel property) async {
    emit(state.copyWith(updateStatus: Status.loading));
    try {
      await _propertiesRespository.updateProperty(property);
      emit(
        state.copyWith(
          updateStatus: Status.success,
          property: property,
          properties: [...state.properties.map((p) => p.id == property.id ? CustomPropertyModel.fromProperty(property) : p)],
        ),
      );
    } catch (e) {
      emit(state.copyWith(updateStatus: Status.error, msg: e.toString()));
    }
  }

  void deleteProperty(String id) async {
    emit(state.copyWith(updateStatus: Status.loading));
    try {
      await _propertiesRespository.deleteProperty(id);
      emit(
        state.copyWith(
          updateStatus: Status.success,
          properties: [...state.properties.where((property) => property.id != id)],
          property: PropertyModel.non,
        ),
      );
      print("deleted property++++++++++++++++++++++++++++++");
    } catch (e) {
      emit(state.copyWith(updateStatus: Status.error, msg: e.toString()));
    }
  }

  void getProperty(String id) async {
    emit(state.copyWith(getPropertyStatus: Status.loading));
    try {
      final property = await _propertiesRespository.getProperty(id);
      emit(state.copyWith(getPropertyStatus: Status.success, property: property));
    } catch (e) {
      emit(state.copyWith(getPropertyStatus: Status.error, msg: e.toString()));
    }
  }
}
