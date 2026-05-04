CREATE DATABASE db_firemanager;
USE db_firemanager;

CREATE TABLE tb_tipo_usuarios(
id BIGINT PRIMARY KEY AUTO_INCREMENT,
cargo VARCHAR(25) NOT NULL UNIQUE
);

CREATE TABLE tb_condominios(
id BIGINT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL,
cidade VARCHAR(60) NOT NULL,
bairro VARCHAR(60) NOT NULL,
rua VARCHAR(60) NOT NULL,
numero VARCHAR(5) NOT NULL
);

CREATE TABLE tb_usuarios(
id BIGINT PRIMARY KEY AUTO_INCREMENT,
fk_tipo_usuario BIGINT NOT NULL,
nome VARCHAR(60) NOT NULL UNIQUE,
email VARCHAR(60) NOT NULL UNIQUE,
telefone CHAR(11) NOT NULL UNIQUE,
senha VARCHAR(255) NOT NULL,
fk_condominio BIGINT,
criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT chk_email CHECK (email LIKE '%@%'),
CONSTRAINT fk_tipo_usuario FOREIGN KEY (fk_tipo_usuario) REFERENCES tb_tipo_usuarios(id),
CONSTRAINT fk_condominio_usuario FOREIGN KEY (fk_condominio) REFERENCES tb_condominios(id)
);

CREATE TABLE tb_permissoes(
id bigint PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE tb_acessos(
id_usuario BIGINT NOT NULL,
id_permissao BIGINT NOT NULL,
data_acesso DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_composta_usuario_permissao PRIMARY KEY (id_usuario, id_permissao),
CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuarios(id),
CONSTRAINT fk_permissao FOREIGN KEY (id_permissao) REFERENCES tb_permissoes(id)
);

CREATE TABLE tb_servicos(
id bigint PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL UNIQUE,
ativo BOOLEAN NOT NULL
);

CREATE TABLE tb_saldo_servicos(
id BIGINT PRIMARY KEY AUTO_INCREMENT,
fk_servico BIGINT NOT NULL,
fk_usuario BIGINT NOT NULL,
quantidade INT NOT NULL,
CONSTRAINT fk_servico_saldo FOREIGN KEY (fk_servico) REFERENCES tb_servicos(id),
CONSTRAINT fk_servico_usuario FOREIGN KEY (fk_usuario) REFERENCES tb_usuarios(id)
);

CREATE TABLE tb_agendamentos (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    fk_aluno BIGINT NOT NULL,
    fk_professor BIGINT NOT NULL,
    fk_auxiliar BIGINT,
    fk_servico BIGINT NOT NULL,
    fk_condominio BIGINT NOT NULL,
    data_agendamento DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    observacao VARCHAR(255),
    status ENUM('pendente', 'confirmado', 'cancelado', 'finalizado') DEFAULT 'pendente',
    criado_em datetime DEFAULT CURRENT_TIMESTAMP,
    atualizado_em datetime DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_agendamento_aluno FOREIGN KEY (fk_aluno) REFERENCES tb_usuarios(id),
    CONSTRAINT fk_agendamento_professor FOREIGN KEY (fk_professor) REFERENCES tb_usuarios(id),
    CONSTRAINT fk_agendamento_auxiliar FOREIGN KEY (fk_auxiliar) REFERENCES tb_usuarios(id),
    CONSTRAINT fk_agendamento_servico FOREIGN KEY (fk_servico) REFERENCES tb_servicos(id),
    CONSTRAINT fk_agendamento_condominio FOREIGN KEY (fk_condominio) REFERENCES tb_condominios(id)
);

INSERT INTO tb_tipo_usuarios (cargo) VALUES
('root'),
('Administracao'),
('Professor'),
('Aluno');

INSERT INTO tb_servicos (nome, ativo) VALUES
('Tênis', true),
('Funcional', true),
('Beach Tennis', false);

INSERT INTO tb_condominios (nome, cidade, bairro, rua, numero) VALUES
('Condomínio LIV', 'São Paulo', 'São Miguel Paulista', 'Rua Santo Antônio', '517');

select * from tb_usuarios;
select * from tb_condominios;
select * from tb_servicos;
select * from tb_saldo_servicos;
select * from tb_agendamentos;
select * from tb_tipo_usuarios;