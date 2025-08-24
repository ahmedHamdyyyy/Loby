import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/constance.dart';
import '../../../models/property.dart';
import 'repository.dart';

part 'state.dart';

class PropertiesCubit extends Cubit<PropertiesState> {
  PropertiesCubit(this._propertiesRespository) : super(const PropertiesState());
  final PropertiesRepository _propertiesRespository;

  void getProperties() async {
    emit(state.copyWith(getStatus: Status.loading));
    try {
      final allProperties = await _propertiesRespository.getProperties();
      emit(state.copyWith(getStatus: Status.success, properties: allProperties));
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
    } finally {
      emit(state.copyWith(createStatus: Status.initial));
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
    } finally {
      emit(state.copyWith(updateStatus: Status.initial));
    }
  }

  void deleteProperty(String id) async {
    emit(state.copyWith(deleteStatus: Status.loading));
    try {
      await _propertiesRespository.deleteProperty(id);
      emit(
        state.copyWith(
          deleteStatus: Status.success,
          properties: [...state.properties.where((property) => property.id != id)],
          property: PropertyModel.initial,
        ),
      );
    } catch (e) {
      emit(state.copyWith(deleteStatus: Status.error, msg: e.toString()));
    } finally {
      emit(state.copyWith(deleteStatus: Status.initial));
    }
  }

  void getProperty(String id) async {
    emit(state.copyWith(getPropertyStatus: Status.loading));
    try {
      final property = await _propertiesRespository.getProperty(id);
      emit(state.copyWith(getPropertyStatus: Status.success, property: property));
    } catch (e) {
      emit(state.copyWith(getPropertyStatus: Status.error, msg: e.toString(), property: PropertyModel.initial));
    } finally {
      emit(state.copyWith(getPropertyStatus: Status.initial));
    }
  }

  void setProperty(PropertyModel property) => emit(state.copyWith(property: property));

  void init() => emit(
    state.copyWith(
      property: PropertyModel.initial,
      getPropertyStatus: Status.initial,
      createStatus: Status.initial,
      updateStatus: Status.initial,
      deleteStatus: Status.initial,
    ),
  );
}
