CREATE DATABASE db_firemanager;
USE db_firemanager;

CREATE TABLE tb_tipo_usuarios(
id INT PRIMARY KEY AUTO_INCREMENT,
cargo VARCHAR(25) NOT NULL UNIQUE
);

CREATE TABLE tb_condominios(
id INT PRIMARY KEY AUTO_INCREMENT,
cidade VARCHAR(60) NOT NULL,
bairro VARCHAR(60) NOT NULL,
rua VARCHAR(60) NOT NULL,
numero VARCHAR(5) NOT NULL
);

CREATE TABLE tb_usuarios(
id INT PRIMARY KEY AUTO_INCREMENT,
fk_tipo_usuario INT NOT NULL,
nome VARCHAR(60) NOT NULL UNIQUE,
email VARCHAR(60) NOT NULL UNIQUE,
telefone CHAR(11) NOT NULL UNIQUE,
senha VARCHAR(30) NOT NULL,
fk_condominio INT,
CONSTRAINT chk_email CHECK (email LIKE '%@%'),
CONSTRAINT fk_tipo_usuario FOREIGN KEY (fk_tipo_usuario) REFERENCES tb_tipo_usuarios(id),
CONSTRAINT fk_condominio_usuario FOREIGN KEY (fk_condominio) REFERENCES tb_condominios(id)
);

CREATE TABLE tb_permissoes(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE tb_acessos(
id_usuario INT NOT NULL,
id_permissao INT NOT NULL,
data_acesso DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_composta_usuario_permissao PRIMARY KEY (id_usuario, id_permissao),
CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuarios(id),
CONSTRAINT fk_permissao FOREIGN KEY (id_permissao) REFERENCES tb_permissoes(id)
);

CREATE TABLE tb_servicos(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE tb_saldo_servicos(
id INT PRIMARY KEY AUTO_INCREMENT,
fk_servico INT NOT NULL,
fk_usuario INT NOT NULL,
status_saldo ENUM('valido', 'pendente', 'expirado') NOT NULL,
data_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
data_validade DATE NOT NULL,
CONSTRAINT fk_servico_saldo FOREIGN KEY (fk_servico) REFERENCES tb_servicos(id),
CONSTRAINT fk_servico_usuario FOREIGN KEY (fk_usuario) REFERENCES tb_usuarios(id)
);

CREATE TABLE tb_agendamentos(
id INT PRIMARY KEY AUTO_INCREMENT,
fk_usuario INT NOT NULL,
dados_agendamento JSON NOT NULL,
data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
data_update DATETIME,
CONSTRAINT fk_usuario_agendamento FOREIGN KEY (fk_usuario) REFERENCES tb_usuarios(id)
);

show tables;

INSERT INTO tb_tipo_usuarios (cargo) VALUES
('root'),
('administracao'),
('professor'),
('aluno');