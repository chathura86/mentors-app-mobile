// TODO: Replace these with your actual Auth0 application credentials.
// Found in Auth0 Dashboard → Applications → your app.
class Auth0Config {
  static const domain =
      'mediator-app.us.auth0.com'; // e.g. 'dev-abc123.us.auth0.com'
  static const clientId = '9M8xTJ8E111JTKFfA4ALNTjX0D02vbsE';

  // Must match the callback/logout URLs registered in Auth0 Dashboard.
  // Android: com.example.mediator_chat://YOUR_AUTH0_DOMAIN/android/com.example.mediator_chat/callback
  // iOS:     com.example.mediator_chat://YOUR_AUTH0_DOMAIN/ios/com.example.mediator_chat/callback
  static const scheme = 'com.example.mediator_chat';

  // Custom claim namespace — set in Auth0 Action (post-login).
  static const roleClaimKey = 'https://mediatorapp.com/role';
}
