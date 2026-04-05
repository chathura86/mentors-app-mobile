// Values are injected at build time via --dart-define-from-file=env/<env>.json
// Never hard-code these here.
class Auth0Config {
  static const domain = String.fromEnvironment('AUTH0_DOMAIN');
  static const clientId = String.fromEnvironment('AUTH0_CLIENT_ID');
  static const scheme = String.fromEnvironment('AUTH0_SCHEME');
  static const roleClaimNamespace =
      String.fromEnvironment('AUTH0_ROLE_CLAIM_NAMESPACE');

  static String get roleClaimKey => '$roleClaimNamespace/role';
}

class AppConfig {
  static const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
}
