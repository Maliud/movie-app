import 'package:bloc/bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, DarkModeState> {
  ThemeBloc() : super(DarkModeState(AppTheme.dark)) {
    on<ToggleDarkMode>((event, emit) {
      emit(DarkModeState(
        state.theme == AppTheme.light ? AppTheme.dark : AppTheme.light,
      ));
    });
  }
}


