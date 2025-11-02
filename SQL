-- Criação do banco de dados
CREATE DATABASE doe_livros_db;
USE doe_livros_db;

-- Tabela de usuários
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cidade VARCHAR(80),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de livros
CREATE TABLE livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100),
    genero VARCHAR(50),
    condicao ENUM('Novo', 'Usado - Bom estado', 'Usado - Desgastado') NOT NULL,
    disponivel BOOLEAN DEFAULT TRUE,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Inserindo registros na tabela de usuários
INSERT INTO usuarios (nome, email, cidade) VALUES
('Ana Pereira', 'ana.pereira@email.com', 'Campo Grande'),
('Lucas Silva', 'lucas.silva@email.com', 'Dourados'),
('Marina Costa', 'marina.costa@email.com', 'Três Lagoas');

-- Inserindo registros na tabela de livros
INSERT INTO livros (titulo, autor, genero, condicao, usuario_id) VALUES
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Infantil', 'Usado - Bom estado', 1),
('Dom Casmurro', 'Machado de Assis', 'Romance', 'Novo', 2),
('A Revolução dos Bichos', 'George Orwell', 'Ficção', 'Usado - Desgastado', 3);
