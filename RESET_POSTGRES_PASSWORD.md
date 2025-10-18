# Reset da Senha PostgreSQL no Windows

## 🎯 Método 1: Usando pg_hba.conf (Recomendado)

### 1️⃣ **Localizar arquivo pg_hba.conf:**
```
C:\Program Files\PostgreSQL\16\data\pg_hba.conf
```

### 2️⃣ **Fazer backup do arquivo:**
```bash
copy "C:\Program Files\PostgreSQL\16\data\pg_hba.conf" "C:\Program Files\PostgreSQL\16\data\pg_hba.conf.backup"
```

### 3️⃣ **Editar pg_hba.conf:**
Abra o arquivo como Administrador e altere a linha:
```
# ANTES:
local   all             postgres                                md5

# DEPOIS:
local   all             postgres                                trust
```

### 4️⃣ **Reiniciar serviço PostgreSQL:**
```bash
# Parar serviço
sc stop postgresql-x64-16

# Iniciar serviço
sc start postgresql-x64-16
```

### 5️⃣ **Conectar sem senha e alterar:**
```bash
psql -U postgres

# Dentro do psql:
ALTER USER postgres PASSWORD 'nova_senha';
```

### 6️⃣ **Restaurar pg_hba.conf:**
Desfazer a alteração (voltar para md5) e reiniciar o serviço.

---

## 🎯 Método 2: Criar novo superusuário

### 1️⃣ **Se conseguir conectar com postgres:**
```sql
CREATE USER admin WITH PASSWORD 'admin' SUPERUSER;
```

### 2️⃣ **Criar banco com novo usuário:**
```sql
CREATE DATABASE mstechdb WITH OWNER admin;
GRANT ALL PRIVILEGES ON DATABASE mstechdb TO admin;
```

---

## 🎯 Método 3: Via Services Windows

### 1️⃣ **Parar serviço PostgreSQL:**
```bash
sc stop postgresql-x64-16
```

### 2️⃣ **Iniciar PostgreSQL em modo single-user:**
```bash
cd "C:\Program Files\PostgreSQL\16\bin"
postgres --single -D "C:\Program Files\PostgreSQL\16\data" postgres
```

### 3️⃣ **Resetar senha (no modo single):**
```sql
ALTER USER postgres PASSWORD 'admin';
```

---

## 🚀 Solução Rápida: Usar Docker

Se nada funcionar, use PostgreSQL no Docker:

```bash
# Parar PostgreSQL local
sc stop postgresql-x64-16

# Usar Docker com credenciais conhecidas
docker run --name postgres-local -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=mstechdb -p 5432:5432 -d postgres:15
```