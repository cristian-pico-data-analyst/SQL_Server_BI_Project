USE BI_Sales_Project;
GO

-- 1. Popolamento Clienti
INSERT INTO DimClienti (CodiceCliente, NomeAzienda, Citta, Regione, Nazione, Segmento) VALUES
('CLI001', 'Tech Milano Srl', 'Milano', 'Lombardia', 'Italia', 'Premium'),
('CLI002', 'Roma Logistica Spa', 'Roma', 'Lazio', 'Italia', 'Standard'),
('CLI003', 'Bologna Food', 'Bologna', 'Emilia-Romagna', 'Italia', 'VIP'),
('CLI004', 'Paris Fashion Ltd', 'Parigi', 'Île-de-France', 'Francia', 'Premium'),
('CLI005', 'Berlin Auto Gmbh', 'Berlino', 'Brandeburgo', 'Germania', 'Standard');

-- 2. Popolamento Prodotti
INSERT INTO DimProdotti (CodiceProdotto, NomeProdotto, Categoria, SottoCategoria, PrezzoListino, CostoUnitario) VALUES
('PROD001', 'Laptop Pro 15', 'Elettronica', 'Computer', 1200.00, 750.00),
('PROD002', 'Monitor 4K 27', 'Elettronica', 'Schermi', 400.00, 220.00),
('PROD003', 'Scrivania Elettrica', 'Arredamento', 'Ufficio', 550.00, 300.00),
('PROD004', 'Sedia Ergonomica', 'Arredamento', 'Ufficio', 250.00, 120.00),
('PROD005', 'Smartphone X', 'Elettronica', 'Telefonia', 800.00, 450.00);

-- 3. Generazione Calendario (2024 - 2027)
DECLARE @DataInizio DATE = '2024-01-01';
DECLARE @DataFine DATE = '2027-12-31';

WHILE @DataInizio <= @DataFine
BEGIN
    INSERT INTO BaseCalendario (Data) VALUES (@DataInizio);
    SET @DataInizio = DATEADD(day, 1, @DataInizio);
END;

-- 4. Popolamento Vendite
INSERT INTO FattiVendite (NumeroOrdine, DataOrdine, ClienteID, ProdottoID, Quantita, PrezzoApplicato, Sconto) VALUES
('ORD-2025-001', '2025-03-10', 1, 1, 5, 1200.00, 0.05),
('ORD-2025-002', '2025-06-12', 2, 2, 10, 380.00, 0.00),
('ORD-2025-003', '2025-09-15', 3, 4, 15, 250.00, 0.10),
('ORD-2025-004', '2025-12-02', 4, 1, 2, 1200.00, 0.00),
('ORD-2026-001', '2026-01-15', 5, 3, 4, 550.00, 0.00),
('ORD-2026-002', '2026-02-20', 1, 5, 8, 800.00, 0.15),
('ORD-2026-003', '2026-03-12', 3, 2, 3, 400.00, 0.00),
('ORD-2026-004', '2026-04-18', 2, 3, 6, 550.00, 0.05),
('ORD-2026-005', '2026-05-02', 4, 4, 20, 240.00, 0.10),
('ORD-2026-006', '2026-05-25', 5, 5, 3, 800.00, 0.00);
GO