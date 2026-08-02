
USE TMS_DB_Test
GO

/*
 =========================================================
 Trigger Name: TR_Payments_Validation

 Purpose:
     Validates payment records before they are saved.

 Business Rules:
     1. Payment date cannot be earlier than the related
        invoice date.

     2. Prevents invalid payment transactions from being
        inserted or updated.

 Table:
     Payments

 Related Table:
     Invoices

 Trigger Event:
     AFTER INSERT, UPDATE

 Action:
     If validation fails:
        - Raise an error message
        - Roll back the transaction

 Example:
     Invoice Date: 2024-01-03
     Payment Date: 2024-01-02
     Result: Rejected

 =========================================================
 */

CREATE TRIGGER TR_Payments_Validation
ON Payments
AFTER INSERT, UPDATE
AS
BEGIN

    IF EXISTS
    (
        SELECT 1
        FROM inserted p
        JOIN Invoices i
        ON p.InvoiceID = i.InvoiceID
        WHERE p.PaymentDate < i.InvoiceDate
           OR p.Amount > i.TotalAmount
    )
    BEGIN
        RAISERROR
        (
        'Invalid payment: Date cannot be before invoice date and amount cannot exceed invoice total',
        16,
        1
        );

        ROLLBACK TRANSACTION;
    END

END;


/*
=========================================================
Trigger Name: TR_Payments_TotalAmount_Check

Purpose:
    Prevents total payments for an invoice from exceeding
    the invoice's TotalAmount.

Business Rule:
    The combined amount of all payments linked to an invoice
    cannot be greater than the invoice balance.

Example:
    Invoice Total: $1,000
    Payments:
        Payment 1: $600
        Payment 2: $400
    Allowed: Total Paid = $1,000

    Payment 3: $100
    Not Allowed: Total Paid = $1,100

Applies To:
    Payments table

Runs On:
    INSERT and UPDATE operations

Created By:
    TMS Database Project
=========================================================
*/

CREATE TRIGGER TR_Payments_TotalAmount_Check
ON Payments
AFTER INSERT, UPDATE
AS
BEGIN

    IF EXISTS
    (
        SELECT
            p.InvoiceID
        FROM Payments p
        JOIN Invoices i
            ON p.InvoiceID = i.InvoiceID
        GROUP BY
            p.InvoiceID,
            i.TotalAmount
        HAVING SUM(p.Amount) > i.TotalAmount
    )
    BEGIN
        RAISERROR
        (
            'Total payments cannot exceed invoice amount',
            16,
            1
        );

        ROLLBACK TRANSACTION;
    END

END;