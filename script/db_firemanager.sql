CREATE DATABASE db_firemanager;
USE db_firemanager;

CREATE TABLE tb_tipo_usuarios(
id bigint PRIMARY KEY AUTO_INCREMENT,
cargo VARCHAR(25) NOT NULL UNIQUE
);

CREATE TABLE tb_condominios(
id bigint PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL,
cidade VARCHAR(60) NOT NULL,
bairro VARCHAR(60) NOT NULL,
rua VARCHAR(60) NOT NULL,
numero VARCHAR(5) NOT NULL
);

CREATE TABLE tb_usuarios(
id bigint PRIMARY KEY AUTO_INCREMENT,
fk_tipo_usuario bigint NOT NULL,
nome VARCHAR(60) NOT NULL UNIQUE,
email VARCHAR(60) NOT NULL UNIQUE,
telefone CHAR(11) NOT NULL UNIQUE,
senha VARCHAR(255) NOT NULL,
fk_condominio bigint,
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
id_usuario bigint NOT NULL,
id_permissao bigint NOT NULL,
data_acesso DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_composta_usuario_permissao PRIMARY KEY (id_usuario, id_permissao),
CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES tb_usuarios(id),
CONSTRAINT fk_permissao FOREIGN KEY (id_permissao) REFERENCES tb_permissoes(id)
);

CREATE TABLE tb_servicos(
id bigint PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE tb_saldo_servicos(
id bigint PRIMARY KEY AUTO_INCREMENT,
fk_servico bigint NOT NULL,
fk_usuario bigint NOT NULL,
quantidade int not null,
CONSTRAINT fk_servico_saldo FOREIGN KEY (fk_servico) REFERENCES tb_servicos(id),
CONSTRAINT fk_servico_usuario FOREIGN KEY (fk_usuario) REFERENCES tb_usuarios(id)
);


CREATE TABLE tb_agendamentos(
id bigint PRIMARY KEY AUTO_INCREMENT,
fk_aluno bigint not null,
fk_professor bigint not null,
fk_auxiliar bigint,
fk_servico bigint not null,
fk_condominio bigint not null,
data_agendamento date not null,
hora_inicio time not null,
observacao varchar(255),
status enum('pendente', 'confirmado', 'cancelado', 'finalizado') default 'pendente',
criado_em datetime default current_timestamp,
atualizado_em datetime default current_timestamp,
constraint fk_agendamento_aluno foreign key (fk_aluno) references tb_usuarios(id),
constraint fk_agendamento_professor foreign key (fk_professor) references tb_usuarios(id),
constraint fk_agendamento_auxiliar foreign key (fk_auxiliar) references tb_usuarios(id),
constraint fk_agendamento_servico foreign key (fk_servico) references tb_servicos(id),
constraint fk_agendamwnto_condominio foreign key (fk_condominio) references tb_condominios(id)
);

show tables;


INSERT INTO tb_tipo_usuarios (cargo) VALUES
('root'),
('administracao'),
('professor'),
('aluno');

select * from tb_usuarios;