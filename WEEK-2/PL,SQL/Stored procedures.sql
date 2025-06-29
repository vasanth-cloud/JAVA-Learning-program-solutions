BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE SavingsAccounts';
  EXECUTE IMMEDIATE 'DROP TABLE Employees';
  EXECUTE IMMEDIATE 'DROP TABLE Accounts';
EXCEPTION
  WHEN OTHERS THEN
    NULL; 
END;
/



-- Savings Accounts
CREATE TABLE SavingsAccounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    Balance NUMBER
);

-- Employees
CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Department VARCHAR2(50),
    Salary NUMBER
);

-- General Accounts for Transfers
CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    Balance NUMBER
);


-- Savings Accounts
INSERT INTO SavingsAccounts VALUES (101, 1, 10000);
INSERT INTO SavingsAccounts VALUES (102, 2, 20000);

-- Employees
INSERT INTO Employees VALUES (1, 'HR', 50000);
INSERT INTO Employees VALUES (2, 'IT', 60000);
INSERT INTO Employees VALUES (3, 'HR', 45000);

-- Accounts
INSERT INTO Accounts VALUES (201, 1, 30000);
INSERT INTO Accounts VALUES (202, 1, 15000);

-- Stored Procedure 1 – Process Monthly Interest

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
  FOR acc IN (SELECT AccountID, Balance FROM SavingsAccounts) LOOP
    UPDATE SavingsAccounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountID = acc.AccountID;
  END LOOP;
END;
/

--  Stored Procedure 2 – Update Employee Bonus

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
  dept_name IN VARCHAR2,
  bonus_pct IN NUMBER
) AS
BEGIN
  FOR emp IN (SELECT EmployeeID, Salary FROM Employees WHERE Department = dept_name) LOOP
    UPDATE Employees
    SET Salary = Salary + (Salary * bonus_pct / 100)
    WHERE EmployeeID = emp.EmployeeID;
  END LOOP;
END;
/

-- Stored Procedure 3 – Transfer Funds

CREATE OR REPLACE PROCEDURE TransferFunds (
  source_account IN NUMBER,
  target_account IN NUMBER,
  amount IN NUMBER
) AS
  src_balance NUMBER;
BEGIN
  SELECT Balance INTO src_balance FROM Accounts WHERE AccountID = source_account;

  IF src_balance < amount THEN
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in source account');
  ELSE
    UPDATE Accounts
    SET Balance = Balance - amount
    WHERE AccountID = source_account;

    UPDATE Accounts
    SET Balance = Balance + amount
    WHERE AccountID = target_account;
  END IF;
END;
/


BEGIN
  ProcessMonthlyInterest;
END;
/

BEGIN
  UpdateEmployeeBonus('HR', 10);
END;
/

BEGIN
  TransferFunds(201, 202, 5000);
END;
/


SELECT * FROM SavingsAccounts;


SELECT * FROM Employees;

SELECT * FROM Accounts;
