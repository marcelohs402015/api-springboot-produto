# 🧪 Teste de Integração - API REST Produtos

## 📋 Cenário de Teste

**Objetivo:** Testar o fluxo completo da API:
1. ✅ Fazer login com usuário do banco
2. ✅ Obter token JWT
3. ✅ Listar produtos usando o token
4. ✅ Validar resposta da API

## 🔑 Dados de Teste

**Usuário para login:**
- **Username:** `admin`
- **Password:** `admin`

**Produtos esperados no banco:**
- ID 1: Smartphone Galaxy S24 - R$ 1.299,99
- ID 2: Notebook Dell - R$ 2.500,00
- ID 3: Mouse Gamer - R$ 89,90
- ID 4: Teclado Mecânico - R$ 199,99
- ID 5: Monitor 24 polegadas - R$ 599,90

## 🧪 Comandos de Teste

### 1️⃣ **Login - Obter Token JWT**
```bash
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"username\": \"admin\", \"password\": \"admin\"}"
```

**Resposta esperada:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTYzOTc..."
}
```

### 2️⃣ **Listar Produtos - Usando Token**
```bash
curl -X GET http://localhost:8080/api/produtos \
  -H "Authorization: Bearer SEU_TOKEN_AQUI"
```

**Resposta esperada:**
```json
[
  {
    "id": 1,
    "nome": "Smartphone Galaxy S24",
    "preco": 1299.99
  },
  {
    "id": 2,
    "nome": "Notebook Dell",
    "preco": 2500.0
  },
  {
    "id": 3,
    "nome": "Mouse Gamer",
    "preco": 89.9
  },
  {
    "id": 4,
    "nome": "Teclado Mecânico",
    "preco": 199.99
  },
  {
    "id": 5,
    "nome": "Monitor 24 polegadas",
    "preco": 599.9
  }
]
```

## ✅ Validações do Teste

### Login (POST /auth/login):
- [ ] Status Code: 200 OK
- [ ] Response contém field "token"
- [ ] Token é uma string JWT válida
- [ ] Token não está vazio

### Listar Produtos (GET /api/produtos):
- [ ] Status Code: 200 OK
- [ ] Response é um array JSON
- [ ] Array contém 5 produtos
- [ ] Cada produto tem: id, nome, preco
- [ ] Dados correspondem aos inseridos no banco

### Segurança:
- [ ] Endpoint /api/produtos rejeita requisições sem token (401)
- [ ] Token JWT é validado corretamente
- [ ] Autenticação funciona com dados do PostgreSQL

## 🔧 Troubleshooting

### Se der erro 401 (Unauthorized):
- Verificar se o token está sendo enviado corretamente
- Validar se o token não expirou
- Confirmar formato: `Authorization: Bearer TOKEN`

### Se der erro 500 (Internal Server Error):
- Verificar se PostgreSQL está rodando
- Confirmar se banco `mstechdb` existe
- Validar se usuário `admin` existe no banco

### Se der erro de conexão:
- Verificar se aplicação está rodando na porta 8080
- Confirmar se Spring Boot subiu completamente
- Testar: `curl http://localhost:8080/auth/login`

## 📊 Resultados Esperados

**✅ Teste APROVADO se:**
- Login retorna token JWT válido
- API lista os 5 produtos corretamente
- Autenticação funciona com dados do banco
- Resposta JSON está bem formatada

**❌ Teste FALHOU se:**
- Erro 401/403 em endpoints protegidos
- Produtos não são retornados
- Dados inconsistentes com o banco
- Erros de conexão ou formato

---

**Próximo passo:** Executar os comandos acima e documentar os resultados! 🚀