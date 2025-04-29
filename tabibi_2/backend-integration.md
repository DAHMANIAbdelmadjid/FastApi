# Tabibi Backend Integration Guide

## Overview

Tabibi is a medical management system built with .NET using Domain-Driven Design principles. This guide provides information needed to integrate the frontend with the backend API.

## Base URL & CORS

- Base URL: `/api`
- CORS: Enabled for all origins, headers, and methods

## Role-Based Access Control

The API uses role-based authentication with the following roles:
- `Patient`: Access to medical records and appointment management
- `Doctor`: Access to clinic management and scheduling
- `Admin`: System administration and user management

Each endpoint is protected based on role requirements. Roles are assigned during user registration and included in the JWT token.
## Authentication

Authentication is JWT-based with the following endpoints:

```http
POST /api/authenfication/signin
POST /api/authenfication/signup
PUT /api/authenfication/confirm-email
PUT /api/authenfication/send-reset-password-code
PUT /api/authenfication/reset-password
```

All authenticated requests should include the JWT token in the Authorization header:
```
Authorization: Bearer {token}
```

## Core Domain Models

### Clinic
```typescript
interface Clinic {
  id: string;
  name: string;
  minDescription?: string;
  specialization: Specialization;
  phoneNumber: string;
  secondPhoneNumber?: string;
  email: string;
  address: Address;
  photoUrl?: string;
  doctorId: string;
  userId: string;
  jobTimes: JobTime[];
}

interface Address {
  street: string;
  city: string;
  state: string;
  postalCode: string;
}
```

### Patient
```typescript
interface Patient {
  id: string;
  fullName: string;
  gender: Gender;
  birthDate: string; // ISO date string
  state?: string;
  city?: string;
  phoneNumber?: string;
  email?: string;
  isOwner: boolean;
  familyLink?: FamilyLink;
  userId: string;
}

enum FamilyLink {
  Father,
  Mother,
  Sister,
  Brother,
  Son,
  Daughter,
  Uncle,
  Aunt,
  Cousin,
  GrandFather,
  GrandMother,
  Other
}
```
### Appointment
```typescript
interface Appointment {
  id: string;
  workScheduleId: string;
  patientId: string;
  startTime: string;      // ISO datetime string
  endTime: string;        // ISO datetime string
  status: AppointmentStatus;
  notes?: string;
}

enum AppointmentStatus {
  Pending,
  Confirmed,
  Cancelled,
  Completed
### Work Schedules
Requires `Doctor` role.
```http
GET /api/work-schedule           # Get doctor's work schedules
POST /api/work-schedule          # Create work schedule
PUT /api/work-schedule/{id}     # Update work schedule
DELETE /api/work-schedule/{id}  # Delete work schedule
```

### Job Times
Requires `Doctor` role.
```http
GET /api/job-time               # Get all job times
POST /api/job-time              # Create new job time
PUT /api/job-time               # Update job time
DELETE /api/job-time/{id}       # Delete job time
```
}
```

## Key Features

### Medical Records
The system supports tracking various medical records:
- Blood Pressure
- Blood Sugar
- Height/Weight
- Temperature
- Medical History (Allergies, Chronic Diseases, etc.)

### Appointments
- Scheduling appointments with doctors
- Managing clinic work schedules
- Job time management for medical staff

## API Endpoints

### Clinics
```http
GET /api/clinics
POST /api/clinics
PUT /api/clinics/{id}
GET /api/clinics/{id}
```

### Doctors
```http
GET /api/doctors
POST /api/doctors
PUT /api/doctors/{id}
GET /api/doctors/{id}
```

### Patients
```http
GET /api/patients
POST /api/patients
PUT /api/patients/{id}
GET /api/patients/{id}
POST /api/patients/relatives
```
### Appointments
All appointment endpoints require authentication.

```http
POST /api/appointment               # Create new appointment
PUT /api/appointment               # Update appointment
DELETE /api/appointment/{id}       # Delete appointment
GET /api/appointment/{workScheduleId} # Get appointments by schedule
PATCH /api/appointment/confirm/{id} # Confirm appointment
PATCH /api/appointment/cancel/{id} # Cancel appointment
```

### Medical Records
All medical record endpoints require the `Patient` role.

#### Blood Pressure
```http
GET /api/patients/blood-pressures/{patientId}  # Get all blood pressure records
POST /api/patients/blood-pressures             # Add new blood pressure record
PUT /api/patients/blood-pressures              # Update blood pressure record
DELETE /api/patients/blood-pressures/{id}      # Delete blood pressure record
```

#### Blood Sugar
```http
GET /api/patients/blood-sugars/{patientId}     # Get all blood sugar records
POST /api/patients/blood-sugars                # Add new blood sugar record
PUT /api/patients/blood-sugars                 # Update blood sugar record
DELETE /api/patients/blood-sugars/{id}         # Delete blood sugar record
```

Similar endpoints exist for other medical record types:
- Height measurements
- Weight measurements
- Temperature readings
- Medical history (allergies, chronic diseases, etc.)

Each type follows the same REST pattern with GET/POST/PUT/DELETE operations.

## Error Handling

The API uses standard HTTP status codes and returns error responses in the following format:

```json
{
  "message": "Error description",
  "errors": {
    "field1": ["Error message 1", "Error message 2"],
    "field2": ["Error message"]
  }
}
```

Common status codes:
- 400: Bad Request (validation errors)
- 401: Unauthorized
- 403: Forbidden
- 404: Not Found
- 500: Internal Server Error

## Frontend Integration Steps

1. **Authentication Setup**
   - Implement JWT token storage and management
   - Add authentication interceptor for API requests
   - Handle token refresh and expiration

2. **API Client Setup**
   - Create API client with base URL configuration
   - Implement error handling middleware
   - Set up response data transformation

3. **State Management**
   - Store authentication state
   - Cache frequently accessed data
   - Implement optimistic updates for better UX

4. **Form Handling**
   - Implement validation matching backend requirements
   - Handle file uploads for photos/documents
   - Show appropriate error messages from API responses

## Security Considerations

1. Always use HTTPS for API requests
2. Store JWT tokens securely (e.g., HttpOnly cookies)
3. Implement CSRF protection if needed
4. Sanitize all user input before sending to API
5. Handle sensitive data according to medical data privacy requirements

## Development Tools

- API Documentation: OpenAPI/Swagger available in development environment
- Health Check: `/health` endpoint for monitoring API status
- Error Tracking: Structured error responses for debugging