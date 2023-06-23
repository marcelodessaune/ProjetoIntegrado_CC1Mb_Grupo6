--Comando de criação das tabelas e colunas
CREATE TABLE coordenadores (
                coordenador_id VARCHAR     NOT NULL,
                nome           VARCHAR(50) NOT NULL,
                CONSTRAINT coordenadores_pk PRIMARY KEY (coordenador_id)
);

--Comando de criação de comentários de tabelas e colunas
COMMENT ON TABLE  coordenadores                IS 'Tabela com os dados dos coordenadores';
COMMENT ON COLUMN coordenadores.coordenador_id IS 'Id de identificação dos coordenadores';
COMMENT ON COLUMN coordenadores.nome           IS 'Nome dos coordenadores';


CREATE TABLE alunos (
                matricula NUMERIC(15) NOT NULL,
                nome      VARCHAR(50) NOT NULL,
                data_nasc DATE        NOT NULL,
                foto      BYTEA,
                CONSTRAINT alunos_pk PRIMARY KEY (matricula)
);
COMMENT ON TABLE  alunos           IS 'Tabela com dados dos alunos';
COMMENT ON COLUMN alunos.matricula IS 'Matrícula dos alunos que fazem parte do curso';
COMMENT ON COLUMN alunos.nome      IS 'Nome dos alunos';
COMMENT ON COLUMN alunos.data_nasc IS 'Data de nascimento dos alunos';
COMMENT ON COLUMN alunos.foto      IS 'Foto dos alunos, para realizar o login e para fácil identificação';


CREATE TABLE certificados (
                certificados_id     VARCHAR      NOT NULL,
                coordenador_id      VARCHAR      NOT NULL,
                matricula           NUMERIC(15)  NOT NULL,
                titulo              VARCHAR(25)  NOT NULL,
                tipo_atividade      VARCHAR      NOT NULL,
                certificado_arquivo VARCHAR(512) NOT NULL,
                carga_horaria       NUMERIC      NOT NULL,
                desc_atividade      VARCHAR(250),
                status              VARCHAR(15)  NOT NULL,
                pontuacao           NUMERIC      NOT NULL,
                data_envio          DATE         NOT NULL,
                data_correcao       DATE         NOT NULL,
                CONSTRAINT certificados_pk PRIMARY KEY (certificados_id, coordenador_id, matricula)
);
COMMENT ON TABLE  certificados                     IS 'Tabela com os dados dos certificados';
COMMENT ON COLUMN certificados.certificados_id     IS 'Id de identificação dos certificados';
COMMENT ON COLUMN certificados.coordenador_id      IS 'Id de identificação dos coordenadores';
COMMENT ON COLUMN certificados.matricula           IS 'Matrícula dos alunos que fazem parte do curso';
COMMENT ON COLUMN certificados.titulo              IS 'Título dos certificados';
COMMENT ON COLUMN certificados.tipo_atividade      IS 'Tipo de atividade referente a cada certificado';
COMMENT ON COLUMN certificados.certificado_arquivo IS 'Arquivo do certificado que foi enviado';
COMMENT ON COLUMN certificados.carga_horaria       IS 'Carga horária de cada certificado referente a sua atividade';
COMMENT ON COLUMN certificados.desc_atividade      IS 'Descrição de cada atividade';
COMMENT ON COLUMN certificados.status              IS 'Status dos certificados, podendo estar em Aprovado, Reprovado ou Pendente';
COMMENT ON COLUMN certificados.pontuacao           IS 'Pontuação dos certificados que foram avaliados pelos coordenadores';
COMMENT ON COLUMN certificados.data_envio          IS 'Data que o aluno enviou o certificado';
COMMENT ON COLUMN certificados.data_correcao       IS 'Data que o coordenador realizou a correção do certificado';


CREATE TABLE alunos_telefones (
                telefone  NUMERIC(9)  NOT NULL,
                matricula NUMERIC(15) NOT NULL,
                ddd       NUMERIC(3)  NOT NULL,
                CONSTRAINT alunos_telefones_pk PRIMARY KEY (telefone, matricula)
);
COMMENT ON TABLE  alunos_telefones           IS 'Tabela com os dados dos telefones dos alunos';
COMMENT ON COLUMN alunos_telefones.telefone  IS 'Telefones de contatos dos alunos';
COMMENT ON COLUMN alunos_telefones.matricula IS 'Matrícula dos alunos que fazem parte do curso';
COMMENT ON COLUMN alunos_telefones.ddd       IS 'DDD (DISCAGEM DIRETA A DISTÂNCIA) dos telefones dos alunos';


CREATE TABLE alunos_emails (
                email     VARCHAR     NOT NULL,
                matricula NUMERIC(15) NOT NULL,
                CONSTRAINT alunos_emails_pk PRIMARY KEY (email, matricula)
);
COMMENT ON TABLE  alunos_emails           IS 'Tabela com dados dos emails dos alunos';
COMMENT ON COLUMN alunos_emails.email     IS 'Email dos alunos';
COMMENT ON COLUMN alunos_emails.matricula IS 'Matrícula dos alunos que fazem parte do curso';


CREATE TABLE alunos_endereco (
                endereco_id VARCHAR     NOT NULL,
                matricula   NUMERIC(15) NOT NULL,
                cep         NUMERIC     NOT NULL,
                numero      NUMERIC     NOT NULL,
                complemento VARCHAR(25),
                CONSTRAINT alunos_endereco_pk PRIMARY KEY (endereco_id, matricula)
);
COMMENT ON TABLE  alunos_endereco             IS 'Tabela com os dados dos endereços dos alunos';
COMMENT ON COLUMN alunos_endereco.endereco_id IS 'Id de identificação dos endereços';
COMMENT ON COLUMN alunos_endereco.matricula   IS 'Matrícula dos alunos que fazem parte do curso';
COMMENT ON COLUMN alunos_endereco.cep         IS 'CEP (CÓDIGO DE ENDEREÇAMENTO POSTAL) dos alunos';
COMMENT ON COLUMN alunos_endereco.numero      IS 'Número do endereço do aluno';
COMMENT ON COLUMN alunos_endereco.complemento IS 'Complemento dos endereços';

--Comando para a criação das PK de cada tabela, e os relacionamentos entre elas
ALTER TABLE certificados ADD CONSTRAINT coordenadores_certificados_fk
FOREIGN KEY (coordenador_id)
REFERENCES coordenadores (coordenador_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE alunos_endereco ADD CONSTRAINT alunos_alunos_endereco_fk
FOREIGN KEY (matricula)
REFERENCES alunos (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE alunos_emails ADD CONSTRAINT alunos_alunos_emails_fk
FOREIGN KEY (matricula)
REFERENCES alunos (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE alunos_telefones ADD CONSTRAINT alunos_alunos_telefones_fk
FOREIGN KEY (matricula)
REFERENCES alunos (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE certificados ADD CONSTRAINT alunos_certificados_fk
FOREIGN KEY (matricula)
REFERENCES alunos (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Comando para a criação de restrições de checagem
ALTER TABLE certificados ADD CONSTRAINT check_certificados_status
CHECK (status in('APROVADO', 'REPROVADO', 'PENDENTE'));
