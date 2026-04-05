enum UserRole { mediator, participant, unknown }

class AppUser {
  const AppUser({
    required this.auth0Id,
    required this.email,
    required this.name,
    required this.role,
    this.picture,
  });

  final String auth0Id;
  final String email;
  final String name;
  final UserRole role;
  final String? picture;

  bool get isMediator => role == UserRole.mediator;
}
