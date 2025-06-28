import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/repositories/main_repository.dart';
import 'package:kiwi/kiwi.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final MainRepository mainRepository = KiwiContainer().resolve<MainRepository>();
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingInitEvent>(onOnboardingInitEvent);
  }

  Future<void> onOnboardingInitEvent(
    OnboardingInitEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    await mainRepository.loadInitialData();
    emit(OnboardingInitial());
  }
}
