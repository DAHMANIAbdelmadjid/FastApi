# Appointment Booking Integration Plan

## Current System Analysis

### API Endpoints
- POST /api/Appointment - Create appointment
- PUT /api/Appointment - Update appointment
- GET /api/Appointment/{workScheduleId} - Get appointments by schedule
- PATCH /api/Appointment/confirm/{id} - Confirm appointment
- PATCH /api/Appointment/cancel/{id} - Cancel appointment

### WorkSchedule Integration
- GET /api/work-schedule - Get available schedules
- POST /api/work-schedule - Create work schedule

## Implementation Plan

### 1. Data Model Updates

Current API expects:
```json
{
  "number": "int",
  "patientId": "UUID",
  "workScheduleId": "UUID"
}
```

Required changes:
- Update AppointmentRequest class to match API schema
- Remove startTime/endTime from request
- Add appointment number generation logic

### 2. Workflow Improvements

#### User Flow
1. Select Doctor
2. Load Work Schedule
3. Show Available Slots
4. Select Time Slot
5. Create Appointment
6. Show Confirmation
7. Proceed to Payment

#### Implementation Details

a) API Integration Layer
- Update AppointmentRequest model
- Add appointment confirmation endpoint
- Add appointment cancellation endpoint
- Implement work schedule fetching
- Add proper error handling

b) State Management
- Add WorkScheduleProvider for managing schedules
- Update AppointmentProvider
  - Add confirmation handling
  - Add cancellation handling
  - Add proper error states
  - Add loading states

c) UI Improvements
- Update appointment booking screen
  - Load actual available slots from work schedule
  - Add confirmation dialog
  - Add cancellation option
  - Show proper error messages
  - Display loading states
- Add appointment confirmation screen
- Update payment flow integration

### 3. Security & Validation

#### Authentication
- Ensure proper auth token handling
- Add proper patient ID retrieval from auth context

#### Validation
- Add input validation
- Add appointment conflict checking
- Add proper error handling and user feedback

### 4. Error Handling

#### Types of Errors
- Network errors
- Validation errors
- Conflict errors
- Server errors

#### Error Handling Strategy
- Show user-friendly error messages
- Provide retry options where applicable
- Log errors for debugging
- Handle edge cases gracefully

## Implementation Phases

### Phase 1: Core Functionality
- Update data models
- Implement basic appointment creation flow
- Add work schedule integration

### Phase 2: Enhanced Features
- Add confirmation/cancellation
- Improve error handling
- Add validation

### Phase 3: UI/UX Improvements
- Add loading states
- Improve error messages
- Add confirmation dialogs
- Enhance visual feedback

## Testing Strategy

### Unit Tests
- Test appointment creation
- Test validation logic
- Test error handling

### Integration Tests
- Test API integration
- Test workflow steps
- Test state management

### UI Tests
- Test user flows
- Test error states
- Test loading states

## Notes

- Keep API endpoint documentation updated
- Follow existing code style and patterns
- Maintain proper error logging
- Document all new features and changes