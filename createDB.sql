-- Create the database
CREATE DATABASE IF NOT EXISTS mentorship_platform;

-- Use the newly created database
USE mentorship_platform;

-- Drop existing tables if they exist (for testing purposes)
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Session;
DROP TABLE IF EXISTS Request;
DROP TABLE IF EXISTS Mentoree;
DROP TABLE IF EXISTS Mentor;

-- Create the Mentor table
CREATE TABLE Mentor (
    mentorID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for mentor
    name VARCHAR(100) NOT NULL,               -- Mentor's name
    email VARCHAR(100) NOT NULL UNIQUE,       -- Mentor's email (unique)
    bio TEXT,                                 -- Mentor's biography
    expertise VARCHAR(255),                   -- Mentor's field of expertise
    availability VARCHAR(100),                -- Availability information (e.g., "Weekends")
    rating FLOAT DEFAULT 0,                   -- Average rating based on feedback
    pricePerSession FLOAT,                    -- Price per mentorship session
    googleID VARCHAR(255) UNIQUE,             -- Google ID for Google sign-in
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date when the mentor was created
);

-- Create the Mentoree table
CREATE TABLE Mentoree (
    mentoreeID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for mentoree
    name VARCHAR(100) NOT NULL,                -- Mentoree's name
    email VARCHAR(100) NOT NULL UNIQUE,        -- Mentoree's email (unique)
    goals TEXT,                                -- Mentoree's goals
    preferredExpertise VARCHAR(255),           -- Mentoree's preferred field of expertise
    rating FLOAT DEFAULT 0,                    -- Average rating based on feedback
    subscriptionPlan VARCHAR(100),             -- Mentoree's subscription plan
    paymentDetails VARCHAR(255),               -- Payment information for subscription
    googleID VARCHAR(255) UNIQUE,              -- Google ID for Google sign-in
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date when the mentoree was created
);

-- Create the Session table
CREATE TABLE Session (
    sessionID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for session
    mentorID INT,                            -- Foreign key to Mentor
    mentoreeID INT,                          -- Foreign key to Mentoree
    date DATETIME NOT NULL,                  -- Date and time of the session
    time VARCHAR(100),                       -- Session time
    status VARCHAR(50) DEFAULT 'pending',    -- Status of the session (e.g., pending, completed)
    sessionFee FLOAT,                        -- Fee for the session
    FOREIGN KEY (mentorID) REFERENCES Mentor(mentorID),  -- Relationship to Mentor
    FOREIGN KEY (mentoreeID) REFERENCES Mentoree(mentoreeID), -- Relationship to Mentoree
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date when the session was created
);

-- Create the Request table
CREATE TABLE Request (
    requestID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for request
    mentorID INT,                            -- Foreign key to Mentor
    mentoreeID INT,                          -- Foreign key to Mentoree
    status VARCHAR(50) DEFAULT 'pending',    -- Status of the request (e.g., pending, accepted, declined)
    FOREIGN KEY (mentorID) REFERENCES Mentor(mentorID), -- Relationship to Mentor
    FOREIGN KEY (mentoreeID) REFERENCES Mentoree(mentoreeID), -- Relationship to Mentoree
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date when the request was created
);

-- Create the Payment table
CREATE TABLE Payment (
    paymentID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for payment
    mentoreeID INT,                          -- Foreign key to Mentoree
    mentorID INT,                            -- Foreign key to Mentor
    amount FLOAT NOT NULL,                   -- Payment amount
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Date when the payment was made
    status VARCHAR(50) DEFAULT 'completed',  -- Status of the payment (e.g., completed)
    FOREIGN KEY (mentoreeID) REFERENCES Mentoree(mentoreeID), -- Relationship to Mentoree
    FOREIGN KEY (mentorID) REFERENCES Mentor(mentorID) -- Relationship to Mentor
);

