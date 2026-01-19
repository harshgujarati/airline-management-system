# ✈️ Airline Management System

A relational database system for managing airline operations built with MySQL.

## 📋 Overview

This project implements a comprehensive database system for an airline, handling travelers, flights, reservations, crew management, payments, and luggage tracking.

## 🗂️ Database Schema

The system consists of **10 normalized tables**:

| Table | Description |
|-------|-------------|
| `Traveller` | Stores passenger information |
| `Operation_Manager` | Airline administrators/supervisors |
| `Fleet_Aircraft` | Aircraft details and capacity |
| `Air_Journey` | Flight schedules and status |
| `Reservation` | Booking records |
| `Boarding_Pass` | Ticket and seat information |
| `Crew_Member` | Crew staff details |
| `Crew_Assignment` | Crew-to-flight assignments |
| `Payment` | Payment transactions |
| `Luggage` | Baggage tracking |

## ⚙️ Features

### Views
- **Passenger_Reservations_View** - Displays passenger booking history
- **Journey_Schedule_View** - Shows scheduled and completed flights

### Stored Procedures
- **AddReservationWithPayment** - Creates reservation and processes payment in one transaction
- **GetPassengerLuggage** - Retrieves luggage details for a specific passenger

### Triggers
- **AutoCancelOnPaymentFail** - Automatically cancels reservation if payment fails
- **LogLuggageInsert** - Logs all luggage additions for audit tracking

### User-Defined Functions
- **CalculateTotalLuggageWeight()** - Calculates total luggage weight per reservation
- **CalculateJourneyRevenue()** - Computes total revenue for a specific flight

## 🛠️ Technologies Used

- MySQL
- SQL (DDL, DML, Views, Stored Procedures, Triggers, Functions)

## 📊 ER Diagram

![ER Diagram](Airplane%20model%20Diagram.drawio%20(1).png)
## 🚀 How to Use

1. Clone this repository
```bash
git clone https://github.com/harshgujarati/airline-management-system.git
```

2. Import the SQL file into MySQL
```bash
mysql -u your_username -p < airline-management-system.sql
```

3. Run queries and explore the database

## 📁 Project Structure

```
├── airline-management-system.sql    # Main SQL file with schema, data, and logic
├── er-diagram.png                   # Entity-Relationship Diagram
└── README.md                        # Project documentation
```

## 👤 Author

**Harsh Gujarati**
- GitHub: [@harshgujarati](https://github.com/harshgujarati)
- LinkedIn: [harshgujarati](https://linkedin.com/in/harshgujarati)
