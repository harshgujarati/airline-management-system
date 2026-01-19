**-- Traveller Table
CREATE TABLE Traveller (
    traveller_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    contact_number VARCHAR(20) UNIQUE,
    email_address VARCHAR(100) UNIQUE,
    identity_number VARCHAR(25) UNIQUE
);

-- Operation_Manager Table
CREATE TABLE Operation_Manager (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE
);

-- Fleet_Aircraft Table
CREATE TABLE Fleet_Aircraft (
    aircraft_id INT AUTO_INCREMENT PRIMARY KEY,
    aircraft_name VARCHAR(100) NOT NULL,
    aircraft_model VARCHAR(100) NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0)
);

-- Air_Journey Table
CREATE TABLE Air_Journey (
    journey_id INT AUTO_INCREMENT PRIMARY KEY,
    aircraft_id INT NOT NULL,
    supervisor_id INT,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    journey_status ENUM('Scheduled', 'Delayed', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    origin VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    FOREIGN KEY (aircraft_id) REFERENCES Fleet_Aircraft(aircraft_id),
    FOREIGN KEY (supervisor_id) REFERENCES Operation_Manager(admin_id)
);

-- Reservation Table
CREATE TABLE Reservation (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    traveller_id INT NOT NULL,
    reservation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10, 2),
    reservation_status ENUM('Confirmed', 'Cancelled', 'Pending') DEFAULT 'Confirmed',
    FOREIGN KEY (traveller_id) REFERENCES Traveller(traveller_id)
);

-- Boarding_Pass Table
CREATE TABLE Boarding_Pass (
    pass_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    journey_id INT NOT NULL,
    seat_allocation_code VARCHAR(10),
    ticket_price DECIMAL(10, 2),
    service_tier ENUM('Economy', 'Business', 'First') DEFAULT 'Economy',
    FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id),
    FOREIGN KEY (journey_id) REFERENCES Air_Journey(journey_id)
);

-- Crew_Member Table
CREATE TABLE Crew_Member (
    crew_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    date_of_birth DATE,
    contact_number VARCHAR(20) UNIQUE,
    email_address VARCHAR(100) UNIQUE,
    home_address TEXT
);

-- Crew_Assignment Table
CREATE TABLE Crew_Assignment (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    crew_id INT NOT NULL,
    journey_id INT NOT NULL,
    assigned_on DATE NOT NULL,
    FOREIGN KEY (crew_id) REFERENCES Crew_Member(crew_id),
    FOREIGN KEY (journey_id) REFERENCES Air_Journey(journey_id)
);

-- Payment Table
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'Cash') NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('Success', 'Failed', 'Pending') DEFAULT 'Success',
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    transaction_reference VARCHAR(100) UNIQUE,
    FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id)
);

-- Luggage Table
CREATE TABLE Luggage (
    luggage_id INT AUTO_INCREMENT PRIMARY KEY,
    pass_id INT NOT NULL,
    weight DECIMAL(5, 2) NOT NULL CHECK (weight >= 0),
    luggage_type ENUM('Checked', 'Carry-On') DEFAULT 'Checked',
    is_fragile BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (pass_id) REFERENCES Boarding_Pass(pass_id)
);

---------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Traveller (first_name, last_name, date_of_birth, contact_number, email_address, identity_number) VALUES
('Megan', 'Chang', '1982-12-05', '4876475938', 'donald19@archer-patel.org', 'ID61706749'),
('Rachel', 'Collins', '2003-12-22', '578-156-5938', 'qgrimes@gmail.com', 'ID66448162'),
('Linda', 'Dunn', '1955-04-07', '609-753-5139', 'lindathomas@west.net', 'ID15433721'),
('Whitney', 'Burns', '1974-10-27', '+1-418-583-9894', 'carlsonpaul@hotmail.com', 'ID44751217'),
('John', 'White', '1967-01-06', '9471122018', 'aimee33@hotmail.com', 'ID78622131'),
('Brittany', 'Herring', '1993-10-03', '775-159-1795x330', 'thorntonnathan@gmail.com', 'ID75220111'),
('Marvin', 'Cabrera', '1961-02-25', '(309)891-0139', 'hdavis@jacobs.com', 'ID64349339');

-- SELECT * FROM traveller;

INSERT INTO Operation_Manager (first_name, last_name, email, phone_number) VALUES
('Samantha', 'Cole', 'samantha.cole@skyops.org', '9876543211'),
('James', 'Turner', 'jturner@airadmin.com', '9834567892'),
('Olivia', 'Morgan', 'omorgan@flightcontrol.org', '9756432183'),
('Ethan', 'Hughes', 'ethan.hughes@aviationco.com', '9123456790'),
('Isabella', 'Rogers', 'irogers@airstream.com', '9612345799'),
('Liam', 'Morris', 'lmorris@flynow.net', '9898765433'),
('Emma', 'Brooks', 'emma.brooks@controlhub.io', '9900123457');

-- SELECT * FROM operation_manager;

INSERT INTO Fleet_Aircraft (aircraft_name, aircraft_model, capacity) VALUES
('SkyLiner 1000', 'Boeing 737-800', 180),
('AeroStar A200', 'Airbus A320', 160),
('JetMax Pro', 'Boeing 777-300ER', 396),
('CloudCruiser 900', 'Airbus A350-900', 325),
('Falcon Flyer', 'Embraer E195', 120),
('Nimbus NX', 'Bombardier CRJ900', 90),
('EagleJet Elite', 'Boeing 787-9 Dreamliner', 296);

-- SELECT * FROM Fleet_Aircraft;

INSERT INTO Air_Journey (
    aircraft_id, supervisor_id, departure_time, arrival_time,
    journey_status, origin, destination
) VALUES
(1, 1, '2025-05-01 08:00:00', '2025-05-01 11:30:00', 'Scheduled', 'New York', 'Chicago'),
(2, 2, '2025-05-02 10:00:00', '2025-05-02 14:00:00', 'Delayed', 'Los Angeles', 'Houston'),
(3, 3, '2025-05-03 09:00:00', '2025-05-03 13:30:00', 'Completed', 'San Francisco', 'Seattle'),
(4, 4, '2025-05-04 15:00:00', '2025-05-04 18:00:00', 'Scheduled', 'Miami', 'Atlanta'),
(5, 5, '2025-05-05 06:30:00', '2025-05-05 09:45:00', 'Cancelled', 'Dallas', 'Denver'),
(6, 6, '2025-05-06 07:15:00', '2025-05-06 10:00:00', 'Completed', 'Phoenix', 'Las Vegas'),
(7, 7, '2025-06-09 06:30:00', '2025-06-09 09:45:00', 'Completed', 'Mumbai', 'Delhi');

-- SELECT * FROM Air_Journey;

INSERT INTO Reservation (traveller_id, reservation_date, total_price, reservation_status) VALUES
(1, '2025-04-20 10:15:00', 250.00, 'Confirmed'),
(2, '2025-04-21 11:45:00', 310.50, 'Pending'),
(3, '2025-04-22 09:30:00', 150.75, 'Cancelled'),
(4, '2025-04-23 13:20:00', 420.00, 'Confirmed'),
(5, '2025-04-24 16:00:00', 385.25, 'Confirmed'),
(6, '2025-04-25 18:40:00', 298.10, 'Pending'),
(7, '2025-04-26 07:50:00', 199.99, 'Confirmed');

-- SELECT * FROM Reservation;

INSERT INTO Boarding_Pass (
    reservation_id, journey_id, seat_allocation_code, ticket_price, service_tier
) VALUES
(1, 1, '12A', 250.00, 'Economy'),
(2, 2, '6B', 310.50, 'Business'),
(3, 3, '14C', 150.75, 'Economy'),
(4, 4, '1A', 420.00, 'First'),
(5, 5, '22F', 385.25, 'Economy'),
(6, 6, '3C', 298.10, 'Business'),
(7, 7, '4A', 500.00, 'First');

-- SELECT * FROM Boarding_Pass;

INSERT INTO Crew_Member (
    first_name, last_name, gender, date_of_birth,
    contact_number, email_address, home_address
) VALUES
('Ava', 'Wilson', 'Female', '1987-03-12', '9001112233', 'ava.wilson@crewmail.com', '123 Skyview Rd, Seattle, WA'),
('Liam', 'Bennett', 'Male', '1985-07-21', '9002223344', 'liam.bennett@crewmail.com', '456 Ocean St, Miami, FL'),
('Sophia', 'Patel', 'Female', '1990-11-30', '9003334455', 'sophia.patel@crewmail.com', '789 Sunset Blvd, Los Angeles, CA'),
('Noah', 'Reed', 'Male', '1982-01-14', '9004445566', 'noah.reed@crewmail.com', '101 Mountain Dr, Denver, CO'),
('Mia', 'Gomez', 'Female', '1994-05-23', '9005556677', 'mia.gomez@crewmail.com', '202 Maple St, Boston, MA'),
('Ethan', 'Chow', 'Male', '1989-10-10', '9006667788', 'ethan.chow@crewmail.com', '303 Elm Rd, Chicago, IL'),
('Zoe', 'Nguyen', 'Female', '1991-08-16', '9007778899', 'zoe.nguyen@crewmail.com', '404 Pine Ave, San Francisco, CA');

-- SELECT * FROM Crew_Member;

INSERT INTO Crew_Assignment (
    crew_id, journey_id, assigned_on
) VALUES
(1, 1, '2025-04-25'),
(2, 2, '2025-04-26'),
(3, 3, '2025-04-27'),
(4, 4, '2025-04-28'),
(5, 5, '2025-04-29'),
(6, 6, '2025-04-30'),
(7, 7, '2025-07-11');

-- SELECT * FROM Staff_Assignment;

INSERT INTO Payment (
    reservation_id, payment_method, amount_paid, payment_status, transaction_reference
) VALUES
(1, 'Credit Card', 250.00, 'Success', 'TXN10001'),
(2, 'UPI', 310.50, 'Success', 'TXN10002'),
(3, 'Net Banking', 150.75, 'Failed', 'TXN10003'),
(4, 'Credit Card', 420.00, 'Success', 'TXN10004'),
(5, 'Debit Card', 385.25, 'Success', 'TXN10005'),
(6, 'Credit Card', 298.10, 'Pending', 'TXN10006'),
(7, 'Cash', 199.99, 'Success', 'TXN10007');

-- SELECT * FROM Payment;

INSERT INTO Luggage (
    pass_id, weight, luggage_type, is_fragile
) VALUES
(1, 18.5, 'Checked', FALSE),
(2, 7.0, 'Carry-On', FALSE),
(3, 23.0, 'Checked', TRUE),
(4, 20.0, 'Checked', FALSE),
(5, 10.0, 'Carry-On', TRUE),
(6, 25.0, 'Checked', FALSE),
(7, 22.0, 'Checked', FALSE);
-- (8, 5.5, 'Carry-On', FALSE);

-- SELECT * FROM Luggage;
-------------------------------------------------------------------------------------------------------------------------------------------

-- Views 

CREATE VIEW Passenger_Reservations_View AS
SELECT 
    t.traveller_id,
    CONCAT(t.first_name, ' ', t.last_name) AS full_name,
    r.reservation_id,
    r.reservation_date,
    r.total_price,
    r.reservation_status
FROM Traveller t
JOIN Reservation r ON t.traveller_id = r.traveller_id;

-- select * FROM Passenger_Reservations_View;

-- views 
CREATE VIEW Journey_Schedule_View AS
SELECT 
    aj.journey_id,
    fa.aircraft_name,
    fa.aircraft_model,
    om.first_name AS supervisor_first_name,
    aj.departure_time,
    aj.arrival_time,
    aj.origin,
    aj.destination,
    aj.journey_status
FROM Air_Journey aj
JOIN Fleet_Aircraft fa ON aj.aircraft_id = fa.aircraft_id
LEFT JOIN Operation_Manager om ON aj.supervisor_id = om.admin_id
WHERE aj.journey_status IN ('Scheduled', 'Completed');

-- select * FROM Journey_Schedule_View;

-------------------------------------------------------------------------------------------------------

-- Stored Procedures

DELIMITER //

CREATE PROCEDURE AddReservationWithPayment (
    IN p_traveller_id INT,
    IN p_price DECIMAL(10,2),
    IN p_payment_method ENUM('Credit Card', 'Debit Card', 'UPI', 'Net Banking', 'Cash'),
    IN p_transaction_reference VARCHAR(100)
)
BEGIN
    DECLARE res_id INT;
    
    INSERT INTO Reservation (traveller_id, total_price)
    VALUES (p_traveller_id, p_price);
    
    SET res_id = LAST_INSERT_ID();
    
    INSERT INTO Payment (reservation_id, payment_method, amount_paid, transaction_reference)
    VALUES (res_id, p_payment_method, p_price, p_transaction_reference);
END //

DELIMITER ;

CALL AddReservationWithPayment(1, 450.00, 'Credit Card', 'TXN90123');

-- Check the reservation added
SELECT * FROM Reservation ORDER BY reservation_id DESC LIMIT 1;

-- Check the corresponding payment
SELECT * FROM Payment ORDER BY payment_id DESC LIMIT 1;

-------------------------------------------------------------------------------------------------
-- Stored Procedures

DELIMITER //

CREATE PROCEDURE GetPassengerLuggage (
    IN p_traveller_id INT
)
BEGIN
    SELECT 
        bp.pass_id,
        l.weight,
        l.luggage_type,
        l.is_fragile
    FROM Traveller t
    JOIN Reservation r ON t.traveller_id = r.traveller_id
    JOIN Boarding_Pass bp ON r.reservation_id = bp.reservation_id
    JOIN Luggage l ON bp.pass_id = l.pass_id
    WHERE t.traveller_id = p_traveller_id;
END //

DELIMITER ;

CALL GetPassengerLuggage(1);

--------------------------------------------------------------------------------------------------

-- Triggers
-- 1. Auto-cancel Reservation if Payment Fails

DELIMITER //

CREATE TRIGGER AutoCancelOnPaymentFail
AFTER INSERT ON Payment
FOR EACH ROW
BEGIN
    IF NEW.payment_status = 'Failed' THEN
        UPDATE Reservation
        SET reservation_status = 'Cancelled'
        WHERE reservation_id = NEW.reservation_id;
    END IF;
END //

DELIMITER ;

INSERT INTO Reservation (traveller_id, total_price, reservation_status)
VALUES (1, 1000.00, 'Confirmed');

INSERT INTO Payment (reservation_id, payment_method, amount_paid, transaction_reference, payment_status)
VALUES (6, 'Credit Card', 1000.00, 'TXN123FAIL', 'Failed');

SELECT reservation_id, reservation_status
FROM Reservation
WHERE reservation_id = 6;

--------------------------------------------------------------------------------------------------------------------
	-- 2. Log Luggage Addition

	CREATE TABLE Luggage_Log (
		log_id INT AUTO_INCREMENT PRIMARY KEY,
		luggage_id INT,
		added_on DATETIME DEFAULT CURRENT_TIMESTAMP
	);

	DELIMITER //

	CREATE TRIGGER LogLuggageInsert
	AFTER INSERT ON Luggage
	FOR EACH ROW
	BEGIN
		INSERT INTO Luggage_Log (luggage_id)
		VALUES (NEW.luggage_id);
	END //

	DELIMITER ;

	SELECT pass_id FROM Boarding_Pass;

	INSERT INTO Luggage (pass_id, weight, luggage_type, is_fragile)
	VALUES (7, 23.5, 'Checked', TRUE);

	SELECT * FROM Luggage_Log ORDER BY log_id DESC;
    
    -----------------------------------------------------------------------------------------------------------------------
    
    -- User Define Functions
    
    -- calculates the total luggage weight for a given passenger's reservatio
    DELIMITER //
CREATE FUNCTION CalculateTotalLuggageWeight(p_reservation_id INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_weight DECIMAL(10, 2);
    
    SELECT COALESCE(SUM(L.weight), 0) INTO total_weight
    FROM Luggage L
    JOIN Boarding_Pass BP ON L.pass_id = BP.pass_id
    WHERE BP.reservation_id = p_reservation_id;
    
    RETURN total_weight;
END //

DELIMITER ;
    
    SELECT 
    R.reservation_id,
    CONCAT(T.first_name, ' ', T.last_name) AS passenger_name,
    R.total_price AS ticket_price,
    CalculateTotalLuggageWeight(R.reservation_id) AS total_luggage_weight
FROM 
    Reservation R
JOIN 
    Traveller T ON R.traveller_id = T.traveller_id;
    
    -------------------------------------------------------------------------------------------------------------------------
    
    -- calculates the revenue from a specific flight journey
    DELIMITER //
CREATE FUNCTION CalculateJourneyRevenue(p_journey_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_revenue DECIMAL(10, 2);
    
    -- Calculate total revenue from all boarding passes for this journey
    SELECT COALESCE(SUM(BP.ticket_price), 0) INTO total_revenue
    FROM Boarding_Pass BP
    WHERE BP.journey_id = p_journey_id
    AND EXISTS (
        SELECT 1 FROM Reservation R 
        WHERE R.reservation_id = BP.reservation_id
        AND R.reservation_status = 'Confirmed'
    );
    
    RETURN total_revenue;
END //

DELIMITER ;
    
    SELECT 
    journey_id,
    origin,
    destination,
    departure_time,
    CalculateJourneyRevenue(journey_id) AS total_revenue
FROM 
    Air_Journey
WHERE 
    journey_id = 5;
    
    -------------------------------------------------------------------------------------------------------------------------
-- Scenarios

-- One Booking, Multiple Tickets

INSERT INTO Traveller (first_name, last_name, date_of_birth, contact_number, email_address, identity_number)
VALUES ('Riya', 'Shah', '1998-06-15', '9876543210', 'riya.shah@email.com', 'ID123RIYA');

INSERT INTO Reservation (traveller_id, total_price)
VALUES (LAST_INSERT_ID(), 1200.00);

-- SELECT LAST_INSERT_ID() AS new_reservation_id;

INSERT INTO Boarding_Pass (reservation_id, journey_id, seat_allocation_code, ticket_price, service_tier)
VALUES 
(3, 5, '12A', 400.00, 'Economy'),
(3, 5, '12B', 400.00, 'Economy'),
(3, 5, '12C', 400.00, 'Economy');


-- SELECT * FROM Boarding_Pass;
