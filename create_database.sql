-- Script para criar banco mstechdb com usuário admin
-- Execute estes comandos no pgAdmin ou psql

-- 1. Criar usuário admin
CREATE USER admin WITH PASSWORD 'admin';

-- 2. Criar banco de dados mstechdb
CREATE DATABASE mstechdb WITH OWNER admin;

-- 3. Conceder privilégios ao usuário admin
GRANT ALL PRIVILEGES ON DATABASE mstechdb TO admin;

-- 4. Conectar no banco mstechdb e conceder privilégios no schema public
\c mstechdb;
GRANT ALL ON SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin;

-- 5. Verificar se tudo foi criado corretamente
\l
\du