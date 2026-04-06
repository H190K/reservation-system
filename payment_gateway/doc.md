# Payment Gateway Integration

Author: h190K Hassan Al-Bahadli for SWE332 Course

## Overview

This repo uses a local Stripe-style sandbox payment flow for movie reservations. The gateway logic lives under `payment_gateway/`, while `api.py` acts as the HTTP layer that wires the frontend into the booking, payment, and reservation state machine.

The flow is intentionally test-only: users can choose preset Visa or MasterCard sandbox cards, simulate success or failure, and confirm that reservation state updates correctly in the database.

## Architecture

- `payment_gateway/sandbox.py` contains the sandbox payment engine, the test-card definitions, and the booking/payout state helpers.
- `payment_gateway/__init__.py` exports the gateway functions used by `api.py`.
- `api.py` exposes the public endpoints for bookings and payments, then delegates all payment and reservation transitions into `payment_gateway/`.
- `db_setup.py` defines the SQLite schema used for users, bookings, booking seats, and payments.
- `script.js`, `seats.html`, and `seats.css` implement the checkout UI and call the API.

## Backend Flow

1. Seat selection posts to `POST /bookings`.
2. The booking is created with `status = pending`.
3. The frontend calls `POST /payments/initiate` to create a payment session.
4. The user submits a sandbox card to `POST /payments/confirm`.
5. On success, the payment is marked paid and the booking becomes `confirmed`.
6. On failure, the payment is marked failed, the booking becomes `canceled`, and the reserved seats are released so they can be selected again.

## Frontend Flow

The seat page now includes a sandbox checkout panel. After seats are chosen, the UI:

- creates the pending reservation
- opens the payment panel
- shows four test-card shortcuts
- autofills the selected test card
- submits the payment request
- shows either a confirmed reservation state or a failed transaction state

The application is served on `http://127.0.0.1:3000`, while the FastAPI backend runs on `http://127.0.0.1:8000`.

## Test Cards

The sandbox includes four presets:

- Visa success
- Visa failure
- MasterCard success
- MasterCard failure

These cards are exposed by the gateway and mirrored in the UI so you can quickly test both approval and decline behavior.

## Run Instructions

Use the included launchers:

- `run_app.bat` for Windows
- `run_app.sh` for shell environments

They start the backend API on port `8000` and a static frontend server on port `3000`, which is enough to preview the full booking and payment flow locally.

## Verification Summary

The integrated flow was smoke-tested successfully:

- frontend returned `200`
- API returned `200`
- pending booking creation worked
- a successful payment confirmed the booking
- a failed payment canceled the booking and released the seat

