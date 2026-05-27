USE BI_Sales_Project;
GO

-- Vista dimensione Clienti
CREATE VIEW vw_DimClienti
AS
SELECT 
   ClienteID,
   CodiceCliente AS [Codice Cliente], 
   NomeAzienda AS [Azienda],
   Citta AS [Città],
   Regione,
   Nazione,
   Segmento
FROM DimCLienti
GO


-- Vista dimensione Prodotti
CREATE VIEW vw_DimProdotti
AS
SELECT 
    ProdottoID,
    CodiceProdotto AS [Codice Prodotto],
    NomeProdotto AS [Prodotto],
    Categoria,
    SottoCategoria AS [Sotto-Categoria],
    PrezzoListino AS [Prezzo Listino],
    CostoUnitario AS [Costo Unitario]
FROM DimProdotti;
GO

CREATE VIEW vw_DimCalendario
AS
SELECT
    Data as 'Data',
    YEAR(Data) as 'Anno',
    MONTH(Data) as [Mese in numero],
    CHOOSE(MONTH(Data), 'Gennaio','Febbraio','Marzo','Aprile','Maggio','Giugno','Luglio','Agosto','Settembre','Ottobre','Novembre','Dicembre') as [Mese in Lettere],
    CHOOSE(MONTH(Data), 'Gen','Feb','Mar','Apr','Mag','Giu','Lug','Ago','Set','Ott','Nov','Dic') as 'Mese in Lettere SIGLE',
    'Q' + CAST(DATEPART(quarter, Data) AS VARCHAR(1)) AS [Trimestre],
    DATEPART(week, Data) AS [Settimana Numero],
    ((DATEPART(dw, Data) + @@DATEFIRST - 2) % 7) + 1 AS [Giorno Settimana Num],
    CHOOSE(((DATEPART(dw, Data) + @@DATEFIRST - 2) % 7) + 1, 'Lunedì','Martedì','Mercoledì','Giovedì','Venerdì','Sabato','Domenica') AS [Giorno Settimana Nome],
    CAST(YEAR(Data) AS VARCHAR(4)) + '-' + RIGHT('0' + CAST(MONTH(Data) AS VARCHAR(2)), 2) AS [Anno Mese]
FROM BaseCalendario;
GO

-- Vista Fatti Vendite (Business logic integrata)
CREATE VIEW vw_FattiVendite
AS
SELECT 
    f.VenditaID,
    f.NumeroOrdine AS [Numero Ordine],
    f.DataOrdine AS [Data Ordine],
    f.ClienteID,
    f.ProdottoID,
    f.Quantita AS [Quantità],
    f.PrezzoApplicato AS [Prezzo Unitario Applicato],
    f.Sconto AS [% Sconto],
    
    -- Misure finanziarie pre-calcolate
    (f.Quantita * f.PrezzoApplicato) AS [Ricavo Lordo],
    ((f.Quantita * f.PrezzoApplicato) * f.Sconto) AS [Importo Sconto],
    ((f.Quantita * f.PrezzoApplicato) * (1 - f.Sconto)) AS [Ricavo Netto],
    (f.Quantita * p.CostoUnitario) AS [Costo Totale],
    (((f.Quantita * f.PrezzoApplicato) * (1 - f.Sconto)) - (f.Quantita * p.CostoUnitario)) AS [Margine Guadagno]
FROM FattiVendite f
INNER JOIN DimProdotti p
    ON f.ProdottoID = p.ProdottoID
GO