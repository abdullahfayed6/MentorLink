# Advanced Software Testing & Quality Assurance

## Table of Contents
- [Introduction](#introduction)
- [Test-Driven Development](#test-driven-development)
- [Advanced Testing Patterns](#advanced-testing-patterns)
- [Property-Based Testing](#property-based-testing)
- [Mutation Testing](#mutation-testing)
- [Performance Testing](#performance-testing)
- [Security Testing](#security-testing)
- [Test Automation Frameworks](#test-automation-frameworks)

## Introduction

Advanced software testing encompasses sophisticated testing methodologies, automation frameworks, and quality assurance practices that ensure robust, reliable software systems.

## Test-Driven Development

### TDD Implementation Patterns
```python
import pytest
from unittest.mock import Mock, patch
from datetime import datetime, timedelta

# Example: Banking system with TDD approach

class InsufficientFundsError(Exception):
    pass

class Account:
    def __init__(self, initial_balance=0):
        self._balance = initial_balance
        self._transactions = []
    
    @property
    def balance(self):
        return self._balance
    
    def deposit(self, amount):
        if amount <= 0:
            raise ValueError("Deposit amount must be positive")
        self._balance += amount
        self._transactions.append(('deposit', amount, datetime.now()))
        return self._balance
    
    def withdraw(self, amount):
        if amount <= 0:
            raise ValueError("Withdrawal amount must be positive")
        if amount > self._balance:
            raise InsufficientFundsError("Insufficient funds")
        self._balance -= amount
        self._transactions.append(('withdrawal', amount, datetime.now()))
        return self._balance
    
    def get_statement(self, days=30):
        cutoff_date = datetime.now() - timedelta(days=days)
        return [t for t in self._transactions if t[2] >= cutoff_date]

class TestAccount:
    def test_account_starts_with_zero_balance(self):
        account = Account()
        assert account.balance == 0
    
    def test_account_can_be_created_with_initial_balance(self):
        account = Account(initial_balance=100)
        assert account.balance == 100
    
    def test_deposit_increases_balance(self):
        account = Account()
        new_balance = account.deposit(50)
        assert account.balance == 50
        assert new_balance == 50
    
    def test_deposit_negative_amount_raises_error(self):
        account = Account()
        with pytest.raises(ValueError, match="Deposit amount must be positive"):
            account.deposit(-10)
    
    def test_withdraw_decreases_balance(self):
        account = Account(initial_balance=100)
        new_balance = account.withdraw(30)
        assert account.balance == 70
        assert new_balance == 70
    
    def test_withdraw_more_than_balance_raises_error(self):
        account = Account(initial_balance=50)
        with pytest.raises(InsufficientFundsError, match="Insufficient funds"):
            account.withdraw(100)
    
    @patch('builtins.datetime')
    def test_transactions_are_recorded_with_timestamp(self, mock_datetime):
        mock_now = datetime(2024, 1, 15, 10, 30, 0)
        mock_datetime.now.return_value = mock_now
        
        account = Account()
        account.deposit(100)
        
        transactions = account.get_statement()
        assert len(transactions) == 1
        assert transactions[0] == ('deposit', 100, mock_now)
```

### BDD with Gherkin
```python
from behave import given, when, then
import pytest

# Feature file: account.feature
"""
Feature: Bank Account Management
    As a bank customer
    I want to manage my account balance
    So that I can track my finances

    Scenario: Successful deposit
        Given I have an account with balance 100
        When I deposit 50
        Then my account balance should be 150

    Scenario: Insufficient funds withdrawal
        Given I have an account with balance 30
        When I try to withdraw 50
        Then I should get an insufficient funds error
        And my account balance should remain 30
"""

# Step implementations
@given('I have an account with balance {balance:d}')
def step_given_account_with_balance(context, balance):
    context.account = Account(initial_balance=balance)

@when('I deposit {amount:d}')
def step_when_deposit(context, amount):
    context.account.deposit(amount)

@when('I try to withdraw {amount:d}')
def step_when_try_withdraw(context, amount):
    try:
        context.account.withdraw(amount)
    except InsufficientFundsError as e:
        context.error = e

@then('my account balance should be {expected_balance:d}')
def step_then_balance_should_be(context, expected_balance):
    assert context.account.balance == expected_balance

@then('I should get an insufficient funds error')
def step_then_insufficient_funds_error(context):
    assert hasattr(context, 'error')
    assert isinstance(context.error, InsufficientFundsError)

@then('my account balance should remain {balance:d}')
def step_then_balance_should_remain(context, balance):
    assert context.account.balance == balance
```

## Advanced Testing Patterns

### Test Doubles and Mocking
```python
from unittest.mock import Mock, MagicMock, patch, call
import requests

class WeatherService:
    def __init__(self, api_client):
        self.api_client = api_client
    
    def get_temperature(self, city):
        response = self.api_client.get(f"/weather?city={city}")
        if response.status_code == 200:
            return response.json()['temperature']
        else:
            raise Exception("Weather service unavailable")
    
    def get_forecast(self, city, days=5):
        forecasts = []
        for day in range(days):
            try:
                temp = self.get_temperature(city)
                forecasts.append(temp)
            except Exception:
                forecasts.append(None)
        return forecasts

class TestWeatherService:
    def test_get_temperature_success(self):
        # Mock API client
        mock_client = Mock()
        mock_response = Mock()
        mock_response.status_code = 200
        mock_response.json.return_value = {'temperature': 25.5}
        mock_client.get.return_value = mock_response
        
        service = WeatherService(mock_client)
        temperature = service.get_temperature("London")
        
        assert temperature == 25.5
        mock_client.get.assert_called_once_with("/weather?city=London")
    
    def test_get_temperature_api_error(self):
        mock_client = Mock()
        mock_response = Mock()
        mock_response.status_code = 500
        mock_client.get.return_value = mock_response
        
        service = WeatherService(mock_client)
        
        with pytest.raises(Exception, match="Weather service unavailable"):
            service.get_temperature("London")
    
    @patch.object(WeatherService, 'get_temperature')
    def test_get_forecast_with_partial_failures(self, mock_get_temp):
        # Simulate some successful calls and some failures
        mock_get_temp.side_effect = [20.0, Exception(), 22.0, 21.5, Exception()]
        
        service = WeatherService(Mock())
        forecast = service.get_forecast("Paris", days=5)
        
        expected_forecast = [20.0, None, 22.0, 21.5, None]
        assert forecast == expected_forecast
        assert mock_get_temp.call_count == 5

class TestDataBuilder:
    """Builder pattern for test data creation"""
    
    class UserBuilder:
        def __init__(self):
            self.reset()
        
        def reset(self):
            self._user = {
                'id': 1,
                'name': 'John Doe',
                'email': 'john@example.com',
                'age': 30,
                'is_active': True
            }
            return self
        
        def with_id(self, user_id):
            self._user['id'] = user_id
            return self
        
        def with_name(self, name):
            self._user['name'] = name
            return self
        
        def with_email(self, email):
            self._user['email'] = email
            return self
        
        def inactive(self):
            self._user['is_active'] = False
            return self
        
        def build(self):
            return self._user.copy()
    
    def test_user_validation_with_builder(self):
        builder = self.UserBuilder()
        
        # Test with valid user
        valid_user = builder.with_name("Alice").with_email("alice@test.com").build()
        assert validate_user(valid_user) == True
        
        # Test with invalid email
        invalid_user = builder.reset().with_email("invalid-email").build()
        assert validate_user(invalid_user) == False
        
        # Test with inactive user
        inactive_user = builder.reset().inactive().build()
        assert can_login(inactive_user) == False
```

## Property-Based Testing

### Hypothesis Framework
```python
from hypothesis import given, strategies as st, assume, example
import hypothesis.strategies as st
from hypothesis.stateful import RuleBasedStateMachine, rule, Bundle

# Property-based testing for sorting function
@given(st.lists(st.integers()))
def test_sorting_properties(input_list):
    sorted_list = sorted(input_list)
    
    # Property 1: Result has same length
    assert len(sorted_list) == len(input_list)
    
    # Property 2: Result is sorted
    for i in range(len(sorted_list) - 1):
        assert sorted_list[i] <= sorted_list[i + 1]
    
    # Property 3: Result contains same elements
    assert sorted(input_list) == sorted_list

# Testing string reversal
@given(st.text())
def test_string_reversal_properties(s):
    reversed_s = s[::-1]
    
    # Property 1: Double reversal returns original
    assert s == reversed_s[::-1]
    
    # Property 2: Length is preserved
    assert len(s) == len(reversed_s)
    
    # Property 3: Reversing empty string returns empty string
    if len(s) == 0:
        assert reversed_s == ""

# Complex property testing for a calculator
class Calculator:
    def add(self, a, b):
        return a + b
    
    def multiply(self, a, b):
        return a * b
    
    def divide(self, a, b):
        if b == 0:
            raise ZeroDivisionError()
        return a / b

@given(st.floats(allow_nan=False, allow_infinity=False),
       st.floats(allow_nan=False, allow_infinity=False))
def test_calculator_properties(a, b):
    calc = Calculator()
    
    # Commutativity of addition
    assert calc.add(a, b) == calc.add(b, a)
    
    # Commutativity of multiplication
    assert calc.multiply(a, b) == calc.multiply(b, a)
    
    # Identity properties
    assert calc.add(a, 0) == a
    assert calc.multiply(a, 1) == a

@given(st.floats(allow_nan=False, allow_infinity=False),
       st.floats(allow_nan=False, allow_infinity=False, min_value=0.001))
def test_division_properties(a, b):
    assume(b != 0)  # Precondition
    
    calc = Calculator()
    result = calc.divide(a, b)
    
    # Division and multiplication are inverse operations
    assert abs(calc.multiply(result, b) - a) < 1e-10

# Stateful testing with state machine
class BankAccountStateMachine(RuleBasedStateMachine):
    def __init__(self):
        super().__init__()
        self.account = Account()
    
    @rule(amount=st.floats(min_value=0.01, max_value=1000))
    def deposit(self, amount):
        old_balance = self.account.balance
        self.account.deposit(amount)
        assert self.account.balance == old_balance + amount
    
    @rule(amount=st.floats(min_value=0.01, max_value=1000))
    def withdraw(self, amount):
        assume(amount <= self.account.balance)
        old_balance = self.account.balance
        self.account.withdraw(amount)
        assert self.account.balance == old_balance - amount
    
    @rule()
    def check_balance_non_negative(self):
        assert self.account.balance >= 0

TestBankAccount = BankAccountStateMachine.TestCase
```

## Mutation Testing

### Mutation Testing with mutmut
```python
# Original function to be tested
def calculate_discount(price, discount_percent, is_member=False):
    if price <= 0:
        raise ValueError("Price must be positive")
    
    if discount_percent < 0 or discount_percent > 100:
        raise ValueError("Discount must be between 0 and 100")
    
    base_discount = price * (discount_percent / 100)
    
    if is_member:
        member_bonus = base_discount * 0.1  # Additional 10% for members
        total_discount = base_discount + member_bonus
    else:
        total_discount = base_discount
    
    final_price = price - total_discount
    return max(0, final_price)  # Price cannot be negative

# Comprehensive test suite to survive mutation testing
class TestCalculateDiscount:
    def test_zero_discount(self):
        assert calculate_discount(100, 0) == 100
    
    def test_full_discount(self):
        assert calculate_discount(100, 100) == 0
    
    def test_partial_discount(self):
        assert calculate_discount(100, 20) == 80
    
    def test_member_bonus(self):
        # Regular: 100 - (100 * 0.2) = 80
        # Member: 100 - (20 + 2) = 78
        assert calculate_discount(100, 20, is_member=True) == 78
    
    def test_member_vs_non_member(self):
        regular_price = calculate_discount(200, 15, is_member=False)
        member_price = calculate_discount(200, 15, is_member=True)
        assert member_price < regular_price
    
    def test_negative_price_error(self):
        with pytest.raises(ValueError, match="Price must be positive"):
            calculate_discount(-10, 20)
    
    def test_zero_price_error(self):
        with pytest.raises(ValueError, match="Price must be positive"):
            calculate_discount(0, 20)
    
    def test_invalid_discount_negative(self):
        with pytest.raises(ValueError, match="Discount must be between 0 and 100"):
            calculate_discount(100, -5)
    
    def test_invalid_discount_too_high(self):
        with pytest.raises(ValueError, match="Discount must be between 0 and 100"):
            calculate_discount(100, 105)
    
    def test_boundary_values(self):
        # Test boundary conditions
        assert calculate_discount(100, 1) == 99
        assert calculate_discount(100, 99) == 1
        assert calculate_discount(0.01, 50) == 0.005
    
    def test_large_discount_with_member_bonus(self):
        # Edge case where discount could exceed price
        result = calculate_discount(50, 90, is_member=True)
        assert result == 0  # Should not go below 0
```

## Performance Testing

### Load Testing Framework
```python
import asyncio
import aiohttp
import time
from concurrent.futures import ThreadPoolExecutor
from dataclasses import dataclass
from typing import List, Dict, Any
import statistics

@dataclass
class LoadTestResult:
    total_requests: int
    successful_requests: int
    failed_requests: int
    avg_response_time: float
    median_response_time: float
    p95_response_time: float
    p99_response_time: float
    requests_per_second: float
    errors: List[str]

class LoadTester:
    def __init__(self, base_url: str, max_concurrent: int = 100):
        self.base_url = base_url
        self.max_concurrent = max_concurrent
        self.session = None
    
    async def __aenter__(self):
        connector = aiohttp.TCPConnector(limit=self.max_concurrent)
        self.session = aiohttp.ClientSession(connector=connector)
        return self
    
    async def __aexit__(self, exc_type, exc_val, exc_tb):
        if self.session:
            await self.session.close()
    
    async def single_request(self, endpoint: str, method: str = 'GET', 
                           data: Dict = None) -> Dict[str, Any]:
        start_time = time.time()
        
        try:
            async with self.session.request(method, f"{self.base_url}{endpoint}", 
                                          json=data) as response:
                end_time = time.time()
                response_time = (end_time - start_time) * 1000  # milliseconds
                
                return {
                    'success': response.status < 400,
                    'status_code': response.status,
                    'response_time': response_time,
                    'error': None
                }
        except Exception as e:
            end_time = time.time()
            response_time = (end_time - start_time) * 1000
            
            return {
                'success': False,
                'status_code': None,
                'response_time': response_time,
                'error': str(e)
            }
    
    async def run_load_test(self, endpoint: str, num_requests: int, 
                          method: str = 'GET', data: Dict = None) -> LoadTestResult:
        semaphore = asyncio.Semaphore(self.max_concurrent)
        
        async def bounded_request():
            async with semaphore:
                return await self.single_request(endpoint, method, data)
        
        start_time = time.time()
        
        # Execute all requests concurrently
        tasks = [bounded_request() for _ in range(num_requests)]
        results = await asyncio.gather(*tasks)
        
        end_time = time.time()
        total_time = end_time - start_time
        
        # Analyze results
        successful = [r for r in results if r['success']]
        failed = [r for r in results if not r['success']]
        
        response_times = [r['response_time'] for r in results]
        
        return LoadTestResult(
            total_requests=num_requests,
            successful_requests=len(successful),
            failed_requests=len(failed),
            avg_response_time=statistics.mean(response_times),
            median_response_time=statistics.median(response_times),
            p95_response_time=statistics.quantiles(response_times, n=20)[18] if response_times else 0,
            p99_response_time=statistics.quantiles(response_times, n=100)[98] if response_times else 0,
            requests_per_second=num_requests / total_time,
            errors=[r['error'] for r in failed if r['error']]
        )

# Performance test example
async def test_api_performance():
    async with LoadTester("http://localhost:8000", max_concurrent=50) as tester:
        # Test different endpoints
        results = {}
        
        # Test GET endpoint
        results['get_users'] = await tester.run_load_test("/api/users", 1000)
        
        # Test POST endpoint
        test_data = {"name": "Test User", "email": "test@example.com"}
        results['create_user'] = await tester.run_load_test(
            "/api/users", 500, method='POST', data=test_data
        )
        
        # Assert performance requirements
        assert results['get_users'].avg_response_time < 100  # < 100ms average
        assert results['get_users'].p95_response_time < 200  # < 200ms 95th percentile
        assert results['get_users'].requests_per_second > 100  # > 100 RPS
        assert results['get_users'].failed_requests == 0  # No failures
        
        return results
```

---

*This guide covers advanced software testing techniques including TDD, property-based testing, mutation testing, and performance testing methodologies.*
