# Wedding Planner Platform Architecture

## Overview
The Wedding Planner Platform is a comprehensive event booking system designed for scalability and modularity. It consists of a shared backend, a user-facing web application, an admin dashboard, and a mobile application for users.

## Monorepo Structure
The project uses a Monorepo structure managed by `npm workspaces` (or TurboRepo in the future) to share code and configuration.

```
/
  /apps
    /api          # NestJS Backend (REST API)
    /web-user     # Next.js User Web App (Client)
    /web-admin    # Next.js Admin Dashboard (Admin)
    /mobile-user  # Android App (Kotlin + Jetpack Compose)
  /packages
    /database     # Prisma Schema & Client (Shared)
    /ui           # Shared React UI Components (Tailwind)
    /shared       # Shared Types & Utilities (TS)
```

## Backend (NestJS)
- **Framework**: NestJS (Modular, TypeScript)
- **Database**: PostgreSQL (Relational Data)
- **ORM**: Prisma (Type-safe database access)
- **Auth**: JWT-based authentication with Role-Based Access Control (RBAC).
- **Modules**:
    - `AuthModule`: Handles Login, Register, JWT generation.
    - `UsersModule`: Manages user profiles.
    - `EventsModule`: CRUD for events.
    - `BookingsModule`: Manages booking workflow.

## Frontend (Next.js)
- **Framework**: Next.js 14 (App Router)
- **Styling**: Tailwind CSS
- **UI Library**: Custom shared components in `@repo/ui`.
- **Apps**:
    - `web-user`: Public facing, SEO optimized.
    - `web-admin`: Private, Dashboard analytics.

## Mobile (Android)
- **Language**: Kotlin
- **UI Toolkit**: Jetpack Compose
- **Architecture**: MVVM (Model-View-ViewModel) pattern recommended.
- **Navigation**: Jetpack Navigation Compose.

## Database Schema
- **User**: Stores user credentials and roles.
- **Event**: Represents an event created by a user.
- **Service**: Represents a service offered by a vendor.
- **Booking**: Links a User, Event, and Service.

## Future Improvements
- **Redis**: Implement caching for frequently accessed data (e.g., Service listings).
- **Payment Gateway**: Integrate Stripe or Razorpay.
- **Vendor Portal**: Create a dedicated portal for vendors to manage services.
