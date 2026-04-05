import 'dart:convert';

import 'package:auth0_flutter/auth0_flutter.dart';

import 'app_user.dart';
import 'auth0_config.dart';

class AuthService {
  AuthService() : _auth0 = Auth0(Auth0Config.domain, Auth0Config.clientId);

  final Auth0 _auth0;

  Future<AppUser> login() async {
    final credentials = await _auth0
        .webAuthentication(scheme: Auth0Config.scheme)
        .login(scopes: {'openid', 'profile', 'email', 'offline_access'});
    return _toAppUser(credentials);
  }

  Future<void> logout() async {
    await _auth0.webAuthentication(scheme: Auth0Config.scheme).logout();
  }

  /// Returns the stored user if a valid session exists, null otherwise.
  Future<AppUser?> getStoredUser() async {
    final hasSession =
        await _auth0.credentialsManager.hasValidCredentials();
    if (!hasSession) return null;
    final credentials = await _auth0.credentialsManager.credentials();
    return _toAppUser(credentials);
  }

  /// Returns a fresh access token, transparently refreshing if needed.
  Future<String?> getAccessToken() async {
    final hasSession =
        await _auth0.credentialsManager.hasValidCredentials();
    if (!hasSession) return null;
    final credentials = await _auth0.credentialsManager.credentials();
    return credentials.accessToken;
  }

  AppUser _toAppUser(Credentials credentials) {
    final role = _extractRole(credentials.accessToken);
    final profile = credentials.user;
    return AppUser(
      auth0Id: profile.sub,
      email: profile.email ?? '',
      name: profile.name ?? profile.email ?? '',
      picture: profile.pictureUrl?.toString(),
      role: role,
    );
  }

  UserRole _extractRole(String accessToken) {
    try {
      final parts = accessToken.split('.');
      if (parts.length != 3) return UserRole.unknown;
      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final claims = jsonDecode(payload) as Map<String, dynamic>;
      final raw = claims[Auth0Config.roleClaimKey] as String?;
      return switch (raw) {
        'mediator' => UserRole.mediator,
        'participant' => UserRole.participant,
        _ => UserRole.unknown,
      };
    } catch (_) {
      return UserRole.unknown;
    }
  }
}
