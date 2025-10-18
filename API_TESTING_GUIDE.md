# 🚀 API Funcionando - Dados de Teste Criados!

## ✅ Status do Banco de Dados

### 📊 **Tabelas criadas automaticamente:**
- ✅ `produtos` - Para gerenciar produtos
- ✅ `usuarios` - Para autenticação

### 👥 **Usuários de teste criados:**
| ID | Username | Senha |
|----|----------|-------|
| 1  | admin    | admin |
| 2  | marcelo  | senha123 |

### 📦 **Produtos de teste criados:**
| ID | Nome | Preço |
|----|------|-------|
| 1  | Smartphone Galaxy S24 | R$ 1.299,99 |
| 2  | Notebook Dell | R$ 2.500,00 |
| 3  | Mouse Gamer | R$ 89,90 |
| 4  | Teclado Mecânico | R$ 199,99 |
| 5  | Monitor 24 polegadas | R$ 599,90 |

## 🧪 Como Testar a API

### 1️⃣ **Fazer Login (obter JWT)**
```bash
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "admin"
  }'
```

**Resposta esperada:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTYzOTc..."
}
```

### 2️⃣ **Listar todos os produtos**
```bash
curl -X GET http://localhost:8080/api/produtos \
  -H "Authorization: Bearer SEU_TOKEN_JWT"
```

### 3️⃣ **Buscar produto por ID**
```bash
curl -X GET http://localhost:8080/api/produtos/1 \
  -H "Authorization: Bearer SEU_TOKEN_JWT"
```

### 4️⃣ **Criar novo produto**
```bash
curl -X POST http://localhost:8080/api/produtos \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SEU_TOKEN_JWT" \
  -d '{
    "nome": "Fone Bluetooth",
    "preco": 149.99
  }'
```

### 5️⃣ **Deletar produto**
```bash
curl -X DELETE http://localhost:8080/api/produtos/3 \
  -H "Authorization: Bearer SEU_TOKEN_JWT"
```

### 6️⃣ **Registrar novo usuário**
```bash
curl -X POST http://localhost:8080/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "novouser",
    "password": "senha456"
  }'
```

### 7️⃣ **Obter mensagem do sistema**
```bash
curl -X GET http://localhost:8080/api/mensagem \
  -H "Authorization: Bearer SEU_TOKEN_JWT"
```

## 🔧 **Verificações no Banco**

### Ver dados atuais:
```sql
-- Conectar no banco
psql -U admin -d mstechdb

-- Ver usuários
SELECT * FROM usuarios;

-- Ver produtos
SELECT * FROM produtos;

-- Ver estrutura das tabelas
\d produtos
\d usuarios
```

## 🎯 **Endpoints Disponíveis**

### 🔓 **Públicos (sem autenticação):**
- `POST /auth/register` - Registrar usuário
- `POST /auth/login` - Fazer login

### 🔒 **Protegidos (precisam JWT):**
- `GET /api/produtos` - Listar produtos
- `GET /api/produtos/{id}` - Buscar produto
- `POST /api/produtos` - Criar produto
- `DELETE /api/produtos/{id}` - Deletar produto
- `GET /api/mensagem` - Mensagem do sistema

## ✨ **Próximos passos:**
1. ✅ Aplicação funcionando
2. ✅ Banco configurado
3. ✅ Dados de teste criados
4. 🔄 **Agora é só testar!**

**Aplicação rodando em:** `http://localhost:8080` 🚀