import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/cat.dart';
import 'cat_description_state.dart';

class CatDetailsCubit extends Cubit<CatDetailsState> {
  CatDetailsCubit(this.cat) : super(CatDetailsInitial());
  final Cat cat;

  void loadCat() {
    emit(CatDetailsLoaded(cat));
  }
}
