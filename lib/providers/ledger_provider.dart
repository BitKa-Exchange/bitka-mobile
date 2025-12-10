import 'package:bitka/services/ledger_service.dart';
import 'package:flutter/material.dart';

class LedgerProvider with ChangeNotifier {
  final LedgerService _ledgerService = LedgerService();
  
  bool _isLoading = false;
  String? _errorMessage;
  List<dynamic> _accounts = [];
  List<dynamic> _transactions = [];
  Map<String, dynamic>? _currentAccount;
  Map<String, dynamic>? _currentTransaction;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<dynamic> get accounts => _accounts;
  List<dynamic> get transactions => _transactions;
  Map<String, dynamic>? get currentAccount => _currentAccount;
  Map<String, dynamic>? get currentTransaction => _currentTransaction;

  // Fetch accounts
  Future<bool> fetchAccounts({
    int page = 1,
    int perPage = 25,
    String? userId,
    String? asset,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _ledgerService.getAccounts(
      page: page,
      perPage: perPage,
      userId: userId,
      asset: asset,
    );
    
    _isLoading = false;
    
    if (result['success']) {
      _accounts = result['data']['items'] ?? [];
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  // Fetch account by ID
  Future<bool> fetchAccountById(String accountId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _ledgerService.getAccountById(accountId);
    
    _isLoading = false;
    
    if (result['success']) {
      _currentAccount = result['data'];
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  // Fetch transactions
  Future<bool> fetchTransactions({
    int page = 1,
    int perPage = 25,
    String? accountId,
    String? asset,
    String? status,
    DateTime? from,
    DateTime? to,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _ledgerService.getTransactions(
      page: page,
      perPage: perPage,
      accountId: accountId,
      asset: asset,
      status: status,
      from: from,
      to: to,
    );
    
    _isLoading = false;
    
    if (result['success']) {
      _transactions = result['data']['items'] ?? [];
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  // Create transaction
  Future<bool> createTransaction({
    required Map<String, dynamic> transactionData,
    String? idempotencyKey,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _ledgerService.createTransaction(
      transactionData: transactionData,
      idempotencyKey: idempotencyKey,
    );
    
    _isLoading = false;
    
    if (result['success']) {
      _currentTransaction = result['data'];
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  // Fetch transaction by ID
  Future<bool> fetchTransactionById(String transactionId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _ledgerService.getTransactionById(transactionId);
    
    _isLoading = false;
    
    if (result['success']) {
      _currentTransaction = result['data'];
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result['message'];
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearCurrentAccount() {
    _currentAccount = null;
    notifyListeners();
  }

  void clearCurrentTransaction() {
    _currentTransaction = null;
    notifyListeners();
  }
}