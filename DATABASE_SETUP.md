# Configuração do Banco PostgreSQL - mstechdb

## 🎯 Objetivo
Criar banco `mstechdb` com usuário `admin` e senha `admin` no PostgreSQL local.

## 📋 Passo a Passo

### 1️⃣ **Abrir pgAdmin ou psql**

**Opção A - pgAdmin (Interface gráfica):**
1. Abra o pgAdmin
2. Conecte no servidor PostgreSQL
3. Clique com botão direito em "Databases"
4. Execute os comandos SQL do arquivo `create_database.sql`

**Opção B - Linha de comando:**
```bash
# Conectar como postgres (será solicitada a senha)
psql -U postgres

# Depois execute os comandos um por um:
```

### 2️⃣ **Comandos SQL para executar:**

```sql
-- Criar usuário admin
CREATE USER admin WITH PASSWORD 'admin';

-- Criar banco mstechdb
CREATE DATABASE mstechdb WITH OWNER admin;

-- Conceder privilégios
GRANT ALL PRIVILEGES ON DATABASE mstechdb TO admin;

-- Conectar no novo banco
\c mstechdb;

-- Conceder privilégios no schema
GRANT ALL ON SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin;
```

### 3️⃣ **Verificar se foi criado:**

```sql
-- Listar bancos
\l

-- Listar usuários
\du

-- Testar conexão
\c mstechdb admin;
```

### 4️⃣ **Testar conexão:**

```bash
# Testar conexão com novo usuário
psql -U admin -d mstechdb -h localhost
```

## ✅ **Configuração já atualizada**

O arquivo `application.properties` já foi atualizado com:

```properties
spring.datasource.username=admin
spring.datasource.password=admin
spring.datasource.url=jdbc:postgresql://localhost:5432/mstechdb
```

## 🚀 **Após criar o banco:**

```bash
# Executar a aplicação
./mvnw.cmd spring-boot:run
```

A aplicação irá:
- Conectar no banco `mstechdb`
- Criar as tabelas automaticamente (hibernate.ddl-auto=update)
- Mostrar os SQLs executados (show-sql=true)

## 🔧 **Resolução de problemas:**

### Se der erro de autenticação:
1. Verifique se o usuário `admin` foi criado
2. Teste a conexão manual: `psql -U admin -d mstechdb`
3. Verifique se a senha está correta

### Se der erro de conexão:
1. Verifique se o PostgreSQL está rodando: `sc query postgresql-x64-16`
2. Verifique se a porta 5432 está aberta: `netstat -an | findstr :5432`

## 📝 **Próximos passos:**
1. Execute os comandos SQL
2. Teste a conexão
3. Execute a aplicação Spring Boot
4. Teste os endpoints da API