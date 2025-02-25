// ignore_for_file: public_member_api_docs

part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.selectedInstitution,
    this.firstBiometric = true,
    this.legalNotificationModal = false,
    this.mustShowQualtrics,
  });

  final String? selectedInstitution;
  final bool legalNotificationModal;
  final bool firstBiometric;
  final bool? mustShowQualtrics;

  @override
  List<Object?> get props => [
        firstBiometric,
        selectedInstitution,
        legalNotificationModal,
        mustShowQualtrics,
      ];

  AppState copyWith({
    bool? firstBiometric,
    String? selectedInstitution,
    bool? legalNotificationModal,
    bool? mustShowQualtrics,
  }) {
    return AppState(
      firstBiometric: firstBiometric ?? this.firstBiometric,
      selectedInstitution: selectedInstitution ?? this.selectedInstitution,
      legalNotificationModal: legalNotificationModal ?? this.legalNotificationModal,
      mustShowQualtrics: mustShowQualtrics ?? this.mustShowQualtrics,
    );
  }
}
