CREATE TABLE Customers (
    CustomerID NUMBER,
    Age NUMBER,
    LoanInterestRate NUMBER,
    Balance NUMBER,
    IsVIP VARCHAR2(5)
);

CREATE TABLE Loans (
    LoanID NUMBER,
    CustomerID NUMBER,
    DueDate DATE
);

INSERT INTO Customers VALUES (1, 65, 10.5, 12000, 'FALSE');
INSERT INTO Customers VALUES (2, 45, 9.8, 8000, 'FALSE');
INSERT INTO Customers VALUES (3, 70, 11.0, 9000, 'FALSE');

INSERT INTO Loans VALUES (101, 1, SYSDATE + 10);  -- due soon
INSERT INTO Loans VALUES (102, 2, SYSDATE + 40);  -- not due soon
INSERT INTO Loans VALUES (103, 3, SYSDATE + 25);  -- due soon

--  Scenario 1 – Apply 1% interest discount for age > 60
BEGIN
  FOR cust IN (SELECT CustomerID, Age, LoanInterestRate FROM Customers) LOOP
    IF cust.Age > 60 THEN
      UPDATE Customers
      SET LoanInterestRate = LoanInterestRate - 1
      WHERE CustomerID = cust.CustomerID;
    END IF;
  END LOOP;
END;
/

--  Scenario 2 – Set IsVIP = TRUE if balance > 10,000
BEGIN
  FOR cust IN (SELECT CustomerID, Balance FROM Customers) LOOP
    IF cust.Balance > 10000 THEN
      UPDATE Customers
      SET IsVIP = 'TRUE'
      WHERE CustomerID = cust.CustomerID;
    END IF;
  END LOOP;
END;
/

-- Scenario 3 – Print reminders for loans due in 30 days
BEGIN
  FOR loan IN (
    SELECT LoanID, CustomerID, DueDate
    FROM Loans
    WHERE DueDate <= SYSDATE + 30
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || loan.LoanID ||
                         ' for Customer ID ' || loan.CustomerID ||
                         ' is due on ' || TO_CHAR(loan.DueDate, 'DD-MON-YYYY'));
  END LOOP;
END;
/

SELECT * FROM Customers;
