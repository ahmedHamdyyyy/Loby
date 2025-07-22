import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../models/property_model.dart';
import '../data/repository.dart';

part 'state.dart';

class PropertiesCubit extends Cubit<PropertiesState> {
  PropertiesCubit(this._propertiesRespository) : super(const PropertiesState());
  final PropertiesRespository _propertiesRespository;

  void getProperties(String id) async {
    emit(state.copyWith(getStatus: Status.loading));
    try {
      final allProperties = await _propertiesRespository.getProperties();
      final userProperties = allProperties.where((property) => property.vendorId == id).toList();
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
      final updatedProperty = await _propertiesRespository.updateProperty(property);
      emit(
        state.copyWith(
          updateStatus: Status.success,
          property: property,
          properties: [
            ...state.properties.map((p) {
              return p.id == updatedProperty.id ? CustomPropertyModel.fromProperty(updatedProperty) : p;
            }),
          ],
        ),
      );
    } catch (e) {
      emit(state.copyWith(updateStatus: Status.error, msg: e.toString()));
    }
    emit(state.copyWith(updateStatus: Status.initial));
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
    } catch (e) {
      emit(state.copyWith(updateStatus: Status.error, msg: e.toString()));
    }
  }

  Future<PropertyModel> getProperty(String id) async {
    if (id.isEmpty) return PropertyModel.non;
    emit(state.copyWith(getPropertyStatus: Status.loading));
    try {
      final property = await _propertiesRespository.getProperty(id);
      emit(state.copyWith(getPropertyStatus: Status.success, property: property));
      return property;
    } catch (e) {
      emit(state.copyWith(getPropertyStatus: Status.error, msg: e.toString()));
      return PropertyModel.non;
    }
  }
}
