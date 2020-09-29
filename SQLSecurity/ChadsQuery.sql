/*
SET SHOWPLAN_XML ON;

SET SHOWPLAN_XML OFF;
*/
/* querying the tables */
SELECT p.PurchaseOrderID,
    p.OrderDate,
    s.SupplierName,
    pc.FullName,
    pc.PreferredName
FROM Purchasing.PurchaseOrders p
JOIN Purchasing.Suppliers s
    ON p.SupplierID = s.SupplierID
JOIN Application.People AS pc
    ON pc.PersonID = s.PrimaryContactPersonID
WHERE p.OrderDate >= '2010-01-01'
    AND p.OrderDate < '2014-01-01'
ORDER BY p.OrderDate DESC;

/* running a stored procedure */
EXEC Integration.GetOrderUpdates @LastCutoff = '2010-01-01',
                                @NewCutoff = '2014-01-01';
