create database GenEsT;
use GenEsT;

CREATE TABLE Usuario (
    email VARCHAR(100) PRIMARY KEY,
    senha VARCHAR(100) NOT NULL,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Discente (
    email VARCHAR(100) PRIMARY KEY REFERENCES Usuario(email),
    RG VARCHAR(20) NOT NULL,
    CPF VARCHAR(14) NOT NULL,
    nomeCurso VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    CEP VARCHAR(10) NOT NULL
);

CREATE TABLE Supervisor (
    email VARCHAR(100) PRIMARY KEY REFERENCES Usuario(email),
    funcao VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    formacao VARCHAR(100) NOT NULL
);

CREATE TABLE Docente (
    email VARCHAR(100) PRIMARY KEY REFERENCES Usuario(email),
    SIAPE VARCHAR(20) NOT NULL,
    eComissao BIT NOT NULL -- valor Booleano
);
-- INT == INTEGER
CREATE TABLE PedidoEstagio (
    dataPE DATE NOT NULL, -- Tipo date: 'YYYY-MM-DD'
    emailDiscente VARCHAR(100) NOT NULL,
    resumoEstagio TEXT NOT NULL, -- Tipo TEXT: valor que pode exceder um tamanho limitado
    motivo TEXT NOT NULL,
    modalidade VARCHAR(100) NOT NULL,
    valorBolsa DECIMAL(10, 2) NOT NULL, -- Tipo DECIMAL(p, s):  onde p é o numero total de digitos e s é o numero de digitos depois do ponto decimal
    auxilioTransp DECIMAL(10, 2) NOT NULL,
    valorSeguro DECIMAL(10, 2) NOT NULL,
    duracao INTEGER NOT NULL,
    emailOrientador VARCHAR(100) REFERENCES Docente(email),
    emailSupervisor VARCHAR(100) REFERENCES Supervisor(email),
    PRIMARY KEY (dataPE, emailDiscente),
    FOREIGN KEY (emailDiscente) REFERENCES Discente(email)
);

CREATE TABLE Renovacao (
    dataR DATE,
    emailDiscente VARCHAR(100) REFERENCES Discente(email),
    dataPedidoAnt DATE,
    emailDiscentePedidoAnt VARCHAR(100) REFERENCES Discente(email),
    PRIMARY KEY (dataR, emailDiscente),
    FOREIGN KEY (dataPedidoAnt, emailDiscentePedidoAnt) REFERENCES PedidoEstagio(dataPE, emailDiscente)
);

CREATE TABLE Grade (
    ano INTEGER,
    semestre INTEGER,
    PRIMARY KEY (ano, semestre)
);

CREATE TABLE Alocacao (
    diaSemana INTEGER,
    horaInicio TIME, -- Tipo TIME: 'HH:MM:SS'
    horaFim TIME,
    ano INTEGER,
    semestre INTEGER,
    PRIMARY KEY (diaSemana, horaInicio, horaFim),
    FOREIGN KEY (ano, semestre) REFERENCES Grade(ano, semestre)
);
CREATE TABLE Empresa (
    nome VARCHAR(100) PRIMARY KEY,
    endereco VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Atividade (
    diaSemana INTEGER,
    horaInicio TIME,
    horaFim TIME,
    descricao TEXT NOT NULL,
    nomeEmpresa VARCHAR(100) REFERENCES Empresa(nome),
    PRIMARY KEY (diaSemana, horaInicio, horaFim),
    FOREIGN KEY (diaSemana, horaInicio, horaFim) REFERENCES Alocacao(diaSemana, horaInicio, horaFim)
);

CREATE TABLE Disciplina (
    codigo INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE AlocacaoDisciplina (
    diaSemana INTEGER,
    horaInicio TIME,
    horaFim TIME,
    aprovado BIT NOT NULL,
    CH INTEGER NOT NULL,
    CRA DECIMAL(5, 2) NOT NULL,
    codigoDisciplina INTEGER REFERENCES Disciplina(codigo),
    PRIMARY KEY (diaSemana, horaInicio, horaFim),
    FOREIGN KEY (diaSemana, horaInicio, horaFim) REFERENCES Alocacao(diaSemana, horaInicio, horaFim)
);

CREATE TABLE GradePedido (
    dataGP DATE,
    emailDiscente VARCHAR(100) REFERENCES Discente(email),
    ano INTEGER,
    semestre INTEGER,
    PRIMARY KEY (dataGP, emailDiscente, ano, semestre),
    FOREIGN KEY (dataGP, emailDiscente) REFERENCES PedidoEstagio(dataPE, emailDiscente),
    FOREIGN KEY (ano, semestre) REFERENCES Grade(ano, semestre)
);

INSERT INTO Usuario (email, senha, nome)
VALUES
    ('adria@gmail.com', 'adria123', 'Adria'),
    ('biazinha@gmail.com', 'bia123', 'Bianca'),
    ('braida@gmail.com', 'braida123', 'Braida'),
    ('bruno@gmail.com', 'bruno123', 'Bruno'),
    ('duarte@gmail.com', 'duarte123', 'Duarte'),
    ('freitas@gmail.com', 'frets123', 'Freitas'),
    ('gemeio@gmail.com', 'gemeio123', 'Gemeio'),
    ('guanis@gmail.com', 'guanis123', 'Guanabara'),
    ('hugo@gmail.com', 'hugo123', 'Hugo'),
    ('igor@gmail.com', 'igor123', 'Igor'),
    ('izi@gmail.com', 'lacerda123', 'Izi'),
    ('ligia@gmail.com', 'ligia123', 'Ligia'),
    ('louzada@gmail.com', 'lou123', 'Louzada'),
    ('macedil@gmail.com', 'macedo123', 'Macedo'),
    ('wilson@gmail.com', 'wil123', 'Wilson');
	

INSERT INTO Discente (email, RG, CPF, nomeCurso, telefone, rua, bairro, cidade, CEP)
VALUES
    ('biazinha@gmail.com', '12345678', '123.456.789-00', 'Curso 1', '123456789', 'Rua A', 'Bairro X', 'Cidade Y', '12345-678'),
    ('gemeio@gmail.com', '13345678', '123.456.789-00', 'Curso 1', '123456789', 'Rua A', 'Bairro X', 'Cidade Y', '13345-678'),
    ('hugo@gmail.com', '14345678', '123.456.789-00', 'Curso 1', '123456789', 'Rua A', 'Bairro X', 'Cidade Y', '14345-678'),
    ('izi@gmail.com', '16345678', '123.456.789-00', 'Curso 1', '123456789', 'Rua A', 'Bairro X', 'Cidade Y', '16345-678'),
    ('macedil@gmail.com', '15345678', '123.456.789-00', 'Curso 1', '123456789', 'Rua A', 'Bairro X', 'Cidade Y', '15345-678');

INSERT INTO Supervisor (email, funcao, telefone, formacao)
VALUES
    ('freitas@gmail.com', 'Supervisor 1', '11111111', 'Formacao 1'),
    ('guanis@gmail.com', 'Supervisor 2', '22222111', 'Formacao 2'),
    ('igor@gmail.com', 'Supervisor 3', '11111111', 'Formacao 3'),
    ('louzada@gmail.com', 'Supervisor 4', '11111111', 'Formacao 2'),
    ('wilson@gmail.com', 'Supervisor 5', '11111111', 'Formacao 1');


INSERT INTO Docente (email, SIAPE, eComissao)
VALUES
    ('adria@gmail.com', '11111', 1),
    ('braida@gmail.com', '23451', 1),
    ('bruno@gmail.com', '33333', 0),
    ('duarte@gmail.com', '44444', 0),
    ('ligia@gmail.com', '88888', 1);

INSERT INTO PedidoEstagio (
    dataPE,
    emailDiscente,
    resumoEstagio,
    motivo,
    modalidade,
    valorBolsa,
    auxilioTransp,
    valorSeguro,
    duracao,
    emailOrientador,
    emailSupervisor
)
VALUES
    ('2023-07-21', 'gemeio@gmail.com', 'Resumo Estágio 4', 'Motivo 4', 'Modalidade 5', 1400.50, 150.75, 50.20, 6, 'ligia@gmail.com', 'igor@gmail.com'),
    ('2023-07-24', 'hugo@gmail.com', 'Resumo Estágio 5', 'Motivo 5', 'Modalidade 5', 1400.50, 150.75, 50.20, 6, 'adria@gmail.com', 'wilson@gmail.com'),
    ('2023-07-24', 'izi@gmail.com', 'Resumo Estágio 3', 'Motivo 3', 'Modalidade 3', 1400.50, 150.75, 50.20, 6, 'braida@gmail.com', 'freitas@gmail.com'),
    ('2023-07-28', 'macedil@gmail.com', 'Resumo Estágio 2', 'Motivo 2', 'Modalidade 2', 1300.50, 150.75, 50.20, 6, 'braida@gmail.com', 'guanis@gmail.com'),
    ('2023-07-29', 'biazinha@gmail.com', 'Resumo Estágio 1', 'Motivo 1', 'Modalidade 1', 1000.50, 150.75, 50.20, 6, 'adria@gmail.com', 'louzada@gmail.com');

INSERT INTO Renovacao (dataR, emailDiscente, dataPedidoAnt, emailDiscentePedidoAnt)
VALUES ('2023-08-01', 'biazinha@gmail.com', '2023-07-29', 'biazinha@gmail.com');

INSERT INTO Grade (ano, semestre)
VALUES
    (2023, 1),
    (2023, 2);

INSERT INTO Alocacao (diaSemana, horaInicio, horaFim, ano, semestre)
VALUES
    (1, '08:00:00', '12:00:00', 2023, 1),
    (2, '09:00:00', '13:00:00', 2023, 2),
    (3, '05:00:00', '14:00:00', 2023, 1),
    (4, '03:00:00', '15:00:00', 2023, 2),
    (5, '01:00:00', '11:00:00', 2023, 1);

INSERT INTO Empresa (nome, endereco, telefone, email)
VALUES
    ('Google', 'Rua ABC', '11111111', 'google@gmail.com'),
    ('Microsoft', 'Rua ABC', '44411111', 'microsoft@gmail.com'),
    ('Stark', 'Rua ABC', '22211111', 'stark@gmail.com'),
    ('Supervia', 'Rua ABC', '33311111', 'supervia@gmail.com'),
    ('Wayne', 'Rua ABC', '55511111', 'wayne@gmail.com');

INSERT INTO Atividade (diaSemana, horaInicio, horaFim, descricao, nomeEmpresa)
VALUES
    (1, '08:00:00', '12:00:00', 'Descrição Atividade 1', 'Google'),
    (2, '09:00:00', '13:00:00', 'Descrição Atividade 2', 'Stark'),
    (3, '05:00:00', '14:00:00', 'Descrição Atividade 3', 'Supervia');

INSERT INTO Disciplina (codigo, nome)
VALUES
    (101, 'Disciplina 1'),
    (102, 'Disciplina 2'),
    (103, 'Disciplina 3'),
    (104, 'Disciplina 4'),
    (105, 'Disciplina 5');

INSERT INTO AlocacaoDisciplina (diaSemana, horaInicio, horaFim, aprovado, CH, CRA, codigoDisciplina)
VALUES
    (1, '08:00:00', '12:00:00', 1, 60, 8.50, 101),
    (2, '09:00:00', '13:00:00', 0, 45, 7.20, 102),
    (3, '05:00:00', '14:00:00', 1, 60, 8.50, 103),
    (4, '03:00:00', '15:00:00', 0, 45, 7.20, 104),
    (5, '01:00:00', '11:00:00', 1, 60, 8.50, 105);

INSERT INTO GradePedido (dataGP, emailDiscente, ano, semestre) VALUES
('2023-07-21', 'gemeio@gmail.com', 2023, 1),
('2023-07-24', 'hugo@gmail.com', 2023, 2),
('2023-07-24', 'izi@gmail.com', 2023, 1),
('2023-07-28', 'macedil@gmail.com', 2023, 2),
('2023-07-29', 'biazinha@gmail.com', 2023, 1);
