# Cinema Home — Database & Backend Guide


---

## How the Database Works

The database is a **SQLite** file (`cinema_home.db`) managed by Python.
It has **11 tables** that cover every part of the cinema booking flow.

### Tables Overview

| Table | What it stores |
|---|---|
| `users` | Registered accounts (username, email, hashed password) |
| `password_reset_tokens` | Temporary tokens for forgot-password flow |
| `movies` | Movie catalog (title, genre, duration, status) |
| `theaters` | Theater locations |
| `screens` | Screens inside each theater (e.g. Screen 1) |
| `seats` | Individual seats per screen (A1, A2 … J12) |
| `showtimes` | Movie screenings (movie + screen + time + price) |
| `bookings` | A user's booking for a showtime |
| `booking_seats` | Which exact seats belong to a booking |
| `payments` | Payment records for each booking |
| `newsletter_subscribers` | Emails from the newsletter form |

### Data Flow (what happens when a user books)

```
User signs up → users table
User logs in  → JWT token returned (no DB write)
User opens seat map → API reads seats + booking_seats for that showtime
User confirms seats → bookings row created + booking_seats rows created (in one transaction)
Double-booking protection → UNIQUE(showtime_id, seat_id) constraint on booking_seats
```

### Password Security

Passwords are **never stored in plain text**.  
They are hashed with **PBKDF2-SHA256** (390,000 iterations) before saving to `users.password_hash`.

### Auto-Seeded Data

On first startup, the API automatically adds:
- 3 movies (Barbie, Oppenheimer, Spider-Man)
- 1 theater → 1 screen
- 120 seats (rows A–J, columns 1–12)
- 3 showtimes (one per movie)

---

## How to Run

### 1. Create a virtual environment

```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 2. Install dependencies

```bash
pip install -r requirements.txt
```


### 2. Create the database (first time only)

```bash
python db_setup.py
```

> The database is also c~reated automatically when the API starts, so this step is optional.

### 3. Start the API server

```bash
python -m uvicorn api:app --host 127.0.0.1 --port 8000
```

The API will be available at: `http://127.0.0.1:8000`

Interactive API docs (auto-generated): `http://127.0.0.1:8000/docs`

### 4. Open the app

Open any `.html` file in your browser (e.g. `login.html`).  
Make sure the API server is running before using signup, login, or seat booking.

---

## API Endpoints

| Method | URL | Description | Auth required |
|---|---|---|---|
| POST | `/auth/signup` | Create a new account | No |
| POST | `/auth/login` | Login and get JWT token | No |
| POST | `/auth/forgot-password` | Request a password reset | No |
| GET | `/movies` | List all movies | No |
| GET | `/showtimes` | List all showtimes (filter by `?movie_id=`) | No |
| GET | `/showtimes/{id}/seats` | Get available and booked seats | No |
| POST | `/bookings` | Create a booking | Yes |
| GET | `/bookings/{id}` | Get a booking's details | Yes |
| POST | `/payments/initiate` | Start a payment for a booking | Yes |
| POST | `/payments/confirm` | Mark a payment as paid | Yes |

---

## Stopping the Server

Press `Ctrl + C` in the terminal where uvicorn is running.

---

## Notes

- The database file `cinema_home.db` is created in the same folder as the scripts.
- To reset all data, delete `cinema_home.db` and restart the API — it will recreate everything.
- `JWT_SECRET` in `api.py` should be changed to a long random string before deploying to a real server.
