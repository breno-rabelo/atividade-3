```sql
autor VARCHAR(150),
ano INT,
genero VARCHAR(80),
condicao ENUM('Novo','Bom','Regular','Ruim') DEFAULT 'Bom',
disponivel BOOLEAN DEFAULT TRUE,
usuario_id INT,
CONSTRAINT fk_livro_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL
);


-- Tabela transacoes
CREATE TABLE IF NOT EXISTS transacoes (
id INT AUTO_INCREMENT PRIMARY KEY,
livro_id INT NOT NULL,
tipo ENUM('Doacao','Troca','Reserva') NOT NULL,
data_operacao DATETIME DEFAULT CURRENT_TIMESTAMP,
usuario_origem_id INT,
usuario_destino_id INT,
status ENUM('Pendente','Concluida','Cancelada') DEFAULT 'Pendente',
CONSTRAINT fk_transacao_livro FOREIGN KEY (livro_id) REFERENCES livros(id) ON DELETE CASCADE,
CONSTRAINT fk_transacao_origem FOREIGN KEY (usuario_origem_id) REFERENCES usuarios(id) ON DELETE SET NULL,
CONSTRAINT fk_transacao_destino FOREIGN KEY (usuario_destino_id) REFERENCES usuarios(id) ON DELETE SET NULL
);


-- INSERÇÕES (exemplos)
INSERT INTO usuarios (nome, email, telefone, cidade) VALUES
('Ana Pereira','ana.pereira@email.com','(67)99999-0001','Campo Grande'),
('Lucas Silva','lucas.silva@email.com','(67)99999-0002','Dourados'),
('Marina Costa','marina.costa@email.com','(67)99999-0003','Tres Lagoas');


INSERT INTO livros (titulo, autor, ano, genero, condicao, disponivel, usuario_id) VALUES
('O Pequeno Príncipe','Antoine de Saint-Exupery',1943,'Infantil','Bom',TRUE,1),
('Dom Casmurro','Machado de Assis',1899,'Romance','Novo',TRUE,2),
('A Revolucao dos Bichos','George Orwell',1945,'Ficcao','Regular',TRUE,3);


-- Criando algumas transações
INSERT INTO transacoes (livro_id, tipo, usuario_origem_id, usuario_destino_id, status) VALUES
(1,'Doacao',1,NULL,'Concluida'),
(2,'Reserva',2,3,'Pendente'),
(3,'Troca',3,1,'Pendente');


-- EXEMPLOS DE CONSULTAS
-- 1. Listar livros com seus proprietários
SELECT l.id, l.titulo, l.autor, u.nome AS proprietario, l.disponivel
FROM livros l
LEFT JOIN usuarios u ON l.usuario_id = u.id;


-- 2. Histórico de transações de um livro
SELECT t.id, t.tipo, t.data_operacao, t.status, uo.nome AS origem, ud.nome AS destino
FROM transacoes t
LEFT JOIN usuarios uo ON t.usuario_origem_id = uo.id
LEFT JOIN usuarios ud ON t.usuario_destino_id = ud.id
WHERE t.livro_id = 2;


-- 3. Atualizar disponibilidade do livro
UPDATE livros SET disponivel = FALSE WHERE id = 2;


-- 4. Remover um usuário (e observar ON DELETE)
DELETE FROM usuarios WHERE id = 3;
