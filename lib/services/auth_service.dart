import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    // Initialize auth service
    _isLoading = false;
    notifyListeners();
  }

  Future<AuthResult> signInWithEmail(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    // Simple validation
    if (email.isEmpty || password.isEmpty) {
      _isLoading = false;
      notifyListeners();
      return AuthResult(success: false, message: 'Email and password are required');
    }

    if (!email.contains('@')) {
      _isLoading = false;
      notifyListeners();
      return AuthResult(success: false, message: 'Invalid email format');
    }

    if (password.length < 6) {
      _isLoading = false;
      notifyListeners();
      return AuthResult(success: false, message: 'Password must be at least 6 characters');
    }

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      displayName: email.split('@')[0],
      provider: 'email',
    );

    _currentUser = user;
    _isLoading = false;
    notifyListeners();

    return AuthResult(success: true, message: 'Signed in successfully');
  }

  Future<AuthResult> signUpWithEmail(String email, String password, String name) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      _isLoading = false;
      notifyListeners();
      return AuthResult(success: false, message: 'All fields are required');
    }

    if (!email.contains('@')) {
      _isLoading = false;
      notifyListeners();
      return AuthResult(success: false, message: 'Invalid email format');
    }

    if (password.length < 6) {
      _isLoading = false;
      notifyListeners();
      return AuthResult(success: false, message: 'Password must be at least 6 characters');
    }

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      displayName: name,
      provider: 'email',
    );

    _currentUser = user;
    _isLoading = false;
    notifyListeners();

    return AuthResult(success: true, message: 'Account created successfully');
  }

  Future<AuthResult> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: 'google.user@gmail.com',
      displayName: 'Google User',
      provider: 'google',
      photoUrl: 'https://via.placeholder.com/150',
    );

    _currentUser = user;
    _isLoading = false;
    notifyListeners();

    return AuthResult(success: true, message: 'Signed in with Google');
  }

  Future<AuthResult> signInWithFacebook() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: 'facebook.user@facebook.com',
      displayName: 'Facebook User',
      provider: 'facebook',
      photoUrl: 'https://via.placeholder.com/150',
    );

    _currentUser = user;
    _isLoading = false;
    notifyListeners();

    return AuthResult(success: true, message: 'Signed in with Facebook');
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    _currentUser = null;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(String displayName) async {
    if (_currentUser == null) return;

    _currentUser = User(
      id: _currentUser!.id,
      email: _currentUser!.email,
      displayName: displayName,
      provider: _currentUser!.provider,
      photoUrl: _currentUser!.photoUrl,
    );

    notifyListeners();
  }
}

class User {
  final String id;
  final String email;
  final String displayName;
  final String provider;
  final String? photoUrl;

  User({
    required this.id,
    required this.email,
    required this.displayName,
    required this.provider,
    this.photoUrl,
  });
}

class AuthResult {
  final bool success;
  final String message;

  AuthResult({required this.success, required this.message});
}