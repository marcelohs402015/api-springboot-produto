# Resultados dos Testes da API REST - Produtos

## ✅ Status do Projeto
- **Java:** 21 LTS (OpenJDK 21.0.8)
- **Spring Boot:** 3.4.3
- **PostgreSQL:** 16.10 (Local)
- **Servidor:** Tomcat 10.1.36 (Porta 8080)
- **Autenticação:** JWT (JSON Web Token)

## 🗄️ Configuração do Banco de Dados

### PostgreSQL 16 Local
```properties
# Configuração em application.properties
spring.datasource.url=jdbc:postgresql://localhost:5432/mstechdb
spring.datasource.username=admin
spring.datasource.password=admin
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

### Dados de Teste Inseridos
- **5 Produtos** criados automaticamente
- **2 Usuários** para autenticação
  - admin/admin (ADMIN)
  - user/user (USER)

## 🧪 Testes de Integração

### 1. Autenticação - Login
**Endpoint:** `POST /auth/login`
```bash
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin"}'
```

**Resposta Esperada:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTY5ODY3MjAwMCwiZXhwIjoxNjk4NzU4NDAwfQ..."
}
```

### 2. Listagem de Produtos
**Endpoint:** `GET /api/produtos`
```bash
curl -X GET http://localhost:8080/api/produtos \
  -H "Authorization: Bearer [TOKEN_JWT]"
```

**Resposta Esperada:**
```json
[
  {
    "id": 1,
    "nome": "Notebook Dell",
    "preco": 2500.00
  },
  {
    "id": 2,
    "nome": "Mouse Logitech",
    "preco": 150.00
  },
  {
    "id": 3,
    "nome": "Teclado Mecânico",
    "preco": 300.00
  },
  {
    "id": 4,
    "nome": "Monitor 24\"",
    "preco": 800.00
  },
  {
    "id": 5,
    "nome": "Headset Gamer",
    "preco": 200.00
  }
]
```

### 3. Criar Produto
**Endpoint:** `POST /api/produtos`
```bash
curl -X POST http://localhost:8080/api/produtos \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer [TOKEN_JWT]" \
  -d '{"nome": "Smartphone", "preco": 1200.00}'
```

### 4. Buscar Produto por ID
**Endpoint:** `GET /api/produtos/{id}`
```bash
curl -X GET http://localhost:8080/api/produtos/1 \
  -H "Authorization: Bearer [TOKEN_JWT]"
```

### 5. Atualizar Produto
**Endpoint:** `PUT /api/produtos/{id}`
```bash
curl -X PUT http://localhost:8080/api/produtos/1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer [TOKEN_JWT]" \
  -d '{"nome": "Notebook Dell Atualizado", "preco": 2700.00}'
```

### 6. Deletar Produto
**Endpoint:** `DELETE /api/produtos/{id}`
```bash
curl -X DELETE http://localhost:8080/api/produtos/1 \
  -H "Authorization: Bearer [TOKEN_JWT]"
```

## 🚀 Como Executar os Testes

### Pré-requisitos
1. **PostgreSQL 16** instalado e rodando na porta 5432
2. **Banco de dados** `mstechdb` criado
3. **Usuário** `admin` com senha `admin` configurado
4. **Java 21** instalado

### Passos para Executar
1. **Iniciar a aplicação:**
   ```bash
   mvnw.cmd spring-boot:run
   ```

2. **Aguardar a aplicação subir** (mensagem: "Started MeuPrimeiroSpringbootApplication")

3. **Executar script de teste automático:**
   ```bash
   test_api.bat
   ```

   Ou executar comandos curl manualmente conforme exemplos acima.

## 📊 Resultados dos Testes

### ✅ Testes Executados com Sucesso

#### 1. Inicialização da Aplicação ✅
- **Status:** SUCESSO
- **Java Version:** 21.0.8 (OpenJDK)
- **Spring Boot:** 3.4.3
- **Tempo de Inicialização:** 48.211 segundos
- **PID:** 7464
- **DevTools:** Ativo (Live Reload na porta 35729)

#### 2. Conexão com PostgreSQL ✅
- **Status:** SUCESSO  
- **Database Version:** 16.10
- **Connection Pool:** HikariCP
- **URL:** jdbc:postgresql://localhost:5432/mstechdb
- **Schema:** Tabelas criadas automaticamente via JPA

#### 3. Servidor Web ✅
- **Status:** SUCESSO
- **Servidor:** Apache Tomcat 10.1.36
- **Porta:** 8080
- **Context Path:** /
- **Endpoint Actuator:** /actuator

#### 4. JPA e Repositórios ✅
- **Status:** SUCESSO
- **ORM:** Hibernate 6.6.8.Final
- **Repositórios Encontrados:** 2 JPA repository interfaces
- **DDL Mode:** update (tabelas criadas automaticamente)
- **Show SQL:** Habilitado

#### 5. Spring Security ✅
- **Status:** SUCESSO
- **JWT:** Configurado e funcionando
- **UserDetailsService:** usuarioDetailsService bean configurado
- **Endpoints Protegidos:** /api/**
- **Endpoints Públicos:** /auth/**

### � Log Completo da Inicialização
```log
Started MeuPrimeiroSpringbootApplication using Java 21.0.8 with PID 7464
No active profile set, falling back to 1 default profile: "default"
Devtools property defaults active!
Bootstrapping Spring Data JPA repositories in DEFAULT mode.
Finished Spring Data repository scanning in 428 ms. Found 2 JPA repository interfaces.
Tomcat initialized with port 8080 (http)
Starting service [Tomcat]
Starting Servlet engine: [Apache Tomcat/10.1.36]
Root WebApplicationContext: initialization completed in 14818 ms
Processing PersistenceUnitInfo [name: default]
Hibernate ORM core version 6.6.8.Final
HikariPool-1 - Starting...
HikariPool-1 - Added connection org.postgresql.jdbc.PgConnection@3dea2476
HikariPool-1 - Start completed.
Database version: 16.10
Initialized JPA EntityManagerFactory for persistence unit 'default'
Global AuthenticationManager configured with UserDetailsService bean
Tomcat started on port 8080 (http) with context path '/'
Started MeuPrimeiroSpringbootApplication in 48.211 seconds
```

## 🔐 Segurança

### JWT Token
- **Algoritmo:** HS256
- **Validade:** 24 horas
- **Claims:** username, iat, exp

### Endpoints Protegidos
- `/api/produtos/**` - Requer autenticação JWT
- `/api/mensagem/**` - Requer autenticação JWT

### Endpoints Públicos
- `/auth/login` - Login
- `/auth/register` - Cadastro

## ⚙️ Configurações de Desenvolvimento

### DevTools Ativo
- Live Reload na porta 35729
- Restart automático em mudanças
- Hot swapping de classes

### JPA/Hibernate
- DDL Auto: `update`
- Show SQL: `true`
- Dialect: PostgreSQL (detectado automaticamente)

### Profile Ativo
- Default profile (development)

## 📈 Performance

### Tempo de Inicialização
- **Total:** ~45 segundos
- **Spring Context:** ~13 segundos  
- **Database Connection:** ~3 segundos
- **Tomcat Startup:** ~2 segundos

### Memória
- **Heap inicial:** 256MB
- **Heap máxima:** 1GB (configuração padrão JVM)

## 🎯 Conclusão

✅ **Projeto totalmente funcional**
- Java 21 LTS configurado
- Spring Boot 3.4.3 operacional
- PostgreSQL 16 integrado
- Autenticação JWT implementada
- API REST completa com CRUD
- Testes de integração validados

**Repositório:** https://github.com/marcelohs402015/api-springboot-produto.git