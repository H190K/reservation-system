# Cinema Online Reservation System - Architecture Document

## 1. Scope
The purpose of this project is to develop a web-based system that simplifies ticket booking, reduces physical queues, and provides management tools for cinema administrators.

## 2. Software Architecture
The system follows a *Client-Server Architecture* to decouple the User Interface from the core business logic.

## 3. Architectural Goals & Constraints
* *Goals:* High performance (under 1s), security (credential management), and high usability (booking under 3 minutes).
* *Constraints:* Must use Python for Backend, HTML/CSS/JS for Frontend, and integrate with an external Payment Gateway API.
