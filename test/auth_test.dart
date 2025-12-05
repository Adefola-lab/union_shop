import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/auth_service.dart';

void main() {
  setUp(() async {
    await AuthService().init();
    await AuthService().signOut();
  });

  tearDown(() async {
    await AuthService().signOut();
  });

  group('AuthService Tests', () {
    test('Initial state should be unauthenticated', () {
      expect(AuthService().isAuthenticated, false);
      expect(AuthService().currentUser, null);
    });

    test('Sign up with email should work', () async {
      final result = await AuthService().signUpWithEmail(
        'test@example.com',
        'password123',
        'Test User',
      );

      expect(result.success, true);
      expect(AuthService().isAuthenticated, true);
      expect(AuthService().currentUser?.email, 'test@example.com');
      // Note: User class doesn't have name getter, it's stored internally
    });

    test('Sign in with email should work', () async {
      // First sign up
      await AuthService().signUpWithEmail(
        'test@example.com',
        'password123',
        'Test User',
      );

      // Sign out
      await AuthService().signOut();
      expect(AuthService().isAuthenticated, false);

      // Sign in
      final result = await AuthService().signInWithEmail(
        'test@example.com',
        'password123',
      );

      expect(result.success, true);
      expect(AuthService().isAuthenticated, true);
    });

    test('Sign in with wrong password should fail', () async {
      await AuthService().signUpWithEmail(
        'test@example.com',
        'password123',
        'Test User',
      );

      await AuthService().signOut();

      final result = await AuthService().signInWithEmail(
        'test@example.com',
        'wrongpassword',
      );

      expect(result.success, false);
      expect(result.message.toLowerCase().contains('password'), true);
    });

    test('Sign in with non-existent email should fail', () async {
      final result = await AuthService().signInWithEmail(
        'nonexistent@example.com',
        'password123',
      );

      expect(result.success, false);
      expect(result.message.toLowerCase().contains('not found'), true);
    });

    test('Sign up with existing email should fail', () async {
      await AuthService().signUpWithEmail(
        'test@example.com',
        'password123',
        'Test User',
      );

      await AuthService().signOut();

      final result = await AuthService().signUpWithEmail(
        'test@example.com',
        'newpassword',
        'Another User',
      );

      expect(result.success, false);
      expect(result.message.toLowerCase().contains('already exists'), true);
    });

    test('Sign in with Google should work', () async {
      final result = await AuthService().signInWithGoogle();

      expect(result.success, true);
      expect(AuthService().isAuthenticated, true);
      expect(AuthService().currentUser?.email.contains('gmail.com'), true);
    });

    test('Sign in with Facebook should work', () async {
      final result = await AuthService().signInWithFacebook();

      expect(result.success, true);
      expect(AuthService().isAuthenticated, true);
      expect(AuthService().currentUser?.email.contains('facebook.com'), true);
    });

    test('Sign out should clear user', () async {
      await AuthService().signInWithGoogle();
      expect(AuthService().isAuthenticated, true);

      await AuthService().signOut();

      expect(AuthService().isAuthenticated, false);
      expect(AuthService().currentUser, null);
    });

    test('Update profile should work', () async {
      await AuthService().signUpWithEmail(
        'test@example.com',
        'password123',
        'Test User',
      );

      // updateProfile returns void, so we just call it
      await AuthService().updateProfile('Updated Name');

      // Verify the profile was updated by checking the displayName
      expect(AuthService().currentUser?.displayName, 'Updated Name');
      expect(AuthService().isAuthenticated, true);
    });

    test('isLoading should be false initially', () {
      expect(AuthService().isLoading, false);
    });
  });
}