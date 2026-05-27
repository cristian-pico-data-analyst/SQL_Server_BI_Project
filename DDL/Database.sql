-- Creazione del Database
CREATE DATABASE BI_Sales_Project;
GO

USE BI_Sales_Project;
GO

-- Tabella dimensione: Clienti
CREATE TABLE DimClienti (
    ClienteID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    CodiceCliente VARCHAR(20) NOT NULL,
    NomeAzienda VARCHAR(100) NOT NULL,
    Citta VARCHAR(50),
    Regione VARCHAR(50),
    Nazione VARCHAR(50),
    Segmento VARCHAR(50) -- Premium, Standard, VIP
);

-- Tabella dimensione: Prodotti
CREATE TABLE DimProdotti (
    ProdottoID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    CodiceProdotto VARCHAR(20) NOT NULL,
    NomeProdotto VARCHAR(100) NOT NULL,
    Categoria VARCHAR(50),
    SottoCategoria VARCHAR(50),
    PrezzoListino DECIMAL(18,2) NOT NULL,
    CostoUnitario DECIMAL(18,2) NOT NULL
);

-- Tabella fisica: Calendario Base
CREATE TABLE BaseCalendario (
    Data DATE PRIMARY KEY
);

-- Tabella fatti: Vendite
CREATE TABLE FattiVendite (
    VenditaID INT IDENTITY(1,1) PRIMARY KEY,
    NumeroOrdine VARCHAR(20) NOT NULL,
    DataOrdine DATE NOT NULL,
    ClienteID INT FOREIGN KEY REFERENCES DimClienti(ClienteID),
    ProdottoID INT FOREIGN KEY REFERENCES DimProdotti(ProdottoID),
    Quantita INT NOT NULL CHECK (Quantita > 0),
    PrezzoApplicato DECIMAL(18,2) NOT NULL,
    Sconto DECIMAL(5,2) DEFAULT 0.00 -- Es. 0.10 equivale al 10% di sconto
);
GO