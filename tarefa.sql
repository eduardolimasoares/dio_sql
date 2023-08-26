CREATE TABLE Cliente (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Email VARCHAR(100),
    Tipo VARCHAR(2)
);

CREATE TABLE Pedido (
    ID INT PRIMARY KEY,
    ClienteID INT,
    Data DATE,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ID)
);

CREATE TABLE Produto (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Preco DECIMAL(10, 2)
);

CREATE TABLE PedidoItem (
    ID INT PRIMARY KEY,
    PedidoID INT,
    ProdutoID INT,
    Quantidade INT,
    FOREIGN KEY (PedidoID) REFERENCES Pedido(ID),
    FOREIGN KEY (ProdutoID) REFERENCES Produto(ID)
);

CREATE TABLE Fornecedor (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100)
);

CREATE TABLE Estoque (
    ProdutoID INT,
    FornecedorID INT,
    Quantidade INT,
    FOREIGN KEY (ProdutoID) REFERENCES Produto(ID),
    FOREIGN KEY (FornecedorID) REFERENCES Fornecedor(ID)
);

CREATE TABLE FormaPagamento (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100)
);

CREATE TABLE Pagamento (
    ID INT PRIMARY KEY,
    PedidoID INT,
    FormaPagamentoID INT,
    Valor DECIMAL(10, 2),
    FOREIGN KEY (PedidoID) REFERENCES Pedido(ID),
    FOREIGN KEY (FormaPagamentoID) REFERENCES FormaPagamento(ID)
);

CREATE TABLE Entrega (
    ID INT PRIMARY KEY,
    PedidoID INT,
    Status VARCHAR(50),
    CodigoRastreio VARCHAR(100),
    FOREIGN KEY (PedidoID) REFERENCES Pedido(ID)
);

SELECT c.Nome, COUNT(p.ID) AS TotalPedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.ID = p.ClienteID
GROUP BY c.Nome;

SELECT DISTINCT f.Nome
FROM Fornecedor f
JOIN Estoque e ON f.ID = e.FornecedorID
JOIN Produto p ON e.ProdutoID = p.ID
JOIN PedidoItem pi ON p.ID = pi.ProdutoID
JOIN Pedido pd ON pi.PedidoID = pd.ID
JOIN Cliente c ON pd.ClienteID = c.ID
WHERE c.Tipo = 'Vendedor';

SELECT p.Nome AS Produto, f.Nome AS Fornecedor, e.Quantidade AS Estoque
FROM Produto p
JOIN Estoque e ON p.ID = e.ProdutoID
JOIN Fornecedor f ON e.FornecedorID = f.ID;

SELECT f.Nome AS Fornecedor, GROUP_CONCAT(p.Nome) AS Produtos
FROM Fornecedor f
JOIN Estoque e ON f.ID = e.FornecedorID
JOIN Produto p ON e.ProdutoID = p.ID
GROUP BY f.Nome;

SELECT fp.Nome AS FormaPagamento, COUNT(p.ID) AS TotalPagamentos
FROM FormaPagamento fp
LEFT JOIN Pagamento p ON fp.ID = p.FormaPagamentoID
GROUP BY fp.Nome;





