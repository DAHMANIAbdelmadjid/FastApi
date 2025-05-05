# Patient Registration Implementation Plan

## Overview
Implement a two-step registration process:
1. Basic user registration (existing signup flow)
2. Patient information collection (new flow)

## Architecture

### Data Layer

#### Models

```dart
// Patient Request Model
class PatientRequest {
  final String fullName;
  final int gender;
  final String birthDate;
  final String phoneNumber;
  final String email;
  final String userId;
  
  // Constructor and toJson
}

// Patient Response Model
class PatientResponse {
  final String id;
  final String fullName;
  final int gender;
  final String birthDate;
  final String phoneNumber;
  final String email;
  final String userId;
  
  // Constructor and fromJson
}
```

#### API

```dart
// In AppApi
@POST("/api/patients")
Future<ApiResponse<PatientResponse>> createPatient(@Body() PatientRequest request);
```

### Domain Layer

#### Models

```dart
enum Gender {
  male(1),
  female(2);
  
  final int value;
  const Gender(this.value);
}

class Patient {
  final String id;
  final String fullName;
  final Gender gender;
  final DateTime birthDate;
  final String phoneNumber;
  final String email;
  final String userId;
}
```

### Provider Layer

```dart
class PatientProvider extends ChangeNotifier {
  final Repository _repository;
  PatientState _state = PatientState.initial();
  
  Future<void> createPatient(PatientRequest request);
}

class PatientState {
  final bool isLoading;
  final String? error;
  final Patient? patient;
}
```

### UI Layer

#### Flow Updates
1. After successful signup, get userId from response
2. Navigate to PatientRegistrationScreen with userId
3. Collect patient details
4. Submit to create patient
5. Navigate to login/home on success

#### Screens

PatientRegistrationScreen:
- Form fields:
  - Full Name (pre-filled from signup)
  - Gender (Radio buttons)
  - Birth Date (Date picker)
  - Phone Number (with validation)
  - Email (pre-filled from signup)
- Form validation
- Loading state handling
- Error handling
- Success navigation

## Implementation Steps

1. Create data layer models (PatientRequest, PatientResponse)
2. Add API endpoint to AppApi
3. Create domain layer models (Patient, Gender enum)
4. Implement PatientProvider for state management
5. Create PatientRegistrationScreen with form
6. Update signup flow to navigate to patient registration
7. Add validation and error handling
8. Test the complete flow

## Technical Considerations

- Form Validation:
  - Email format
  - Phone number format
  - Required fields
  - Age restrictions (if any)
- Error Handling:
  - Network errors
  - Validation errors
  - Server errors
- State Management:
  - Loading states
  - Success/error states
  - Form state