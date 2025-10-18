# API REST - Gerenciamento de Produtos 🛒

Uma API REST robusta desenvolvida em **Java 21** com **Spring Boot 3.4.3** para gerenciamento completo de produtos, incluindo sistema de autenticação JWT e operações CRUD.

**Desenvolvido por:** [Marcelo Hernandes](https://github.com/marcelohs402015)

## 🎯 Objetivo do Projeto

Esta API foi desenvolvida para fornecer uma solução completa de **gerenciamento de produtos** com funcionalidades de:

- **Autenticação segura** de usuários com JWT
- **CRUD completo** de produtos (criar, listar, buscar, deletar)
- **Persistência de dados** com PostgreSQL
- **Arquitetura em camadas** seguindo boas práticas
- **Tratamento de exceções** centralizado
- **Segurança de endpoints** com Spring Security

## 🚀 Tecnologias Utilizadas

| Tecnologia | Versão | Descrição |
|------------|--------|-----------|
| **Java** | 21 (LTS) | Linguagem de programação principal |
| **Spring Boot** | 3.4.3 | Framework para desenvolvimento de aplicações |
| **Spring Security** | 6.x | Segurança e autenticação |
| **Spring Data JPA** | 3.x | Persistência e mapeamento objeto-relacional |
| **PostgreSQL** | Latest | Banco de dados relacional |
| **JWT** | 0.11.5 | Tokens de autenticação |
| **Maven** | 3.x | Gerenciamento de dependências |

## 📋 Funcionalidades da API

### 🔐 **Autenticação**
- **Registro de usuários**: Cadastro de novos usuários no sistema
- **Login com JWT**: Autenticação gerando tokens seguros
- **Proteção de rotas**: Endpoints protegidos por autenticação

### 📦 **Gerenciamento de Produtos**
- **Listagem**: Visualizar todos os produtos cadastrados
- **Busca individual**: Encontrar produto específico por ID
- **Cadastro**: Criar novos produtos no sistema
- **Exclusão**: Remover produtos existentes

### 💬 **Sistema de Mensagens**
- **Mensagens do sistema**: Endpoint para comunicação com usuários

## 📡 Endpoints da API

### Autenticação (Público)
```http
POST /auth/register    # Registrar novo usuário
POST /auth/login       # Fazer login e obter JWT
```

### Produtos (Protegido)
```http
GET    /api/produtos      # Listar todos os produtos
GET    /api/produtos/{id} # Buscar produto por ID
POST   /api/produtos      # Criar novo produto
DELETE /api/produtos/{id} # Deletar produto
```

### Sistema (Protegido)
```http
GET /api/mensagem         # Obter mensagem do sistema
```

## 🛠️ Como Executar

### Pré-requisitos
- **Java 21 JDK** instalado
- **PostgreSQL 16** configurado e rodando
- **Maven** (ou usar o wrapper incluído)

### 1️⃣ Clone o repositório
```bash
git clone git@github.com:marcelohs402015/api-springboot-produto.git
cd api-springboot-produto
```

### 2️⃣ Configure o banco de dados PostgreSQL

#### Conectar como superuser e criar o banco:
```sql
-- Conectar no PostgreSQL como postgres
psql -U postgres

-- Criar banco de dados
CREATE DATABASE mstechdb;

-- Criar usuário admin
CREATE USER admin WITH PASSWORD 'admin';

-- Conceder privilégios
GRANT ALL PRIVILEGES ON DATABASE mstechdb TO admin;
GRANT ALL ON SCHEMA public TO admin;
```

#### Configuração da aplicação:
O projeto está configurado para usar PostgreSQL local com:
- **Banco:** `mstechdb`
- **Usuário:** `admin`
- **Senha:** `admin`
- **Porta:** `5432`

**Configuração no `application.properties`:**
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/mstechdb
spring.datasource.username=admin
spring.datasource.password=admin
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

### 3️⃣ Execute a aplicação
```bash
# Windows
mvnw.cmd spring-boot:run

# Linux/macOS
./mvnw spring-boot:run
```

🌐 **Aplicação disponível em:** `http://localhost:8080`

### 4️⃣ Teste a API

#### Teste Automático:
```bash
# Execute o script de teste (Windows)
test_api.bat
```

#### Teste Manual:
1. **Fazer login:**
```bash
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin"}'
```

2. **Listar produtos (use o token obtido):**
```bash
curl -X GET http://localhost:8080/api/produtos \
  -H "Authorization: Bearer [SEU_TOKEN_JWT]"
```

📊 **[Ver Resultados Completos dos Testes de Integração](TESTE_RESULTADOS.md)** 

### ✅ Status dos Testes
- ✅ **Aplicação:** Spring Boot 3.4.3 + Java 21
- ✅ **Banco:** PostgreSQL 16 integrado
- ✅ **Autenticação:** JWT funcionando
- ✅ **CRUD:** Produtos testado e validado
- ✅ **Performance:** Tempo de resposta < 200ms

## 📖 Exemplos de Uso

### Registrar usuário
```bash
curl -X POST http://localhost:8080/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "usuario",
    "password": "senha123"
  }'
```

### Fazer login
```bash
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "usuario",
    "password": "senha123"
  }'
```

### Criar produto
```bash
curl -X POST http://localhost:8080/api/produtos \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SEU_TOKEN_JWT" \
  -d '{
    "nome": "Smartphone Galaxy",
    "preco": 1299.99,
    "descricao": "Smartphone Android com 128GB"
  }'
```

### Listar produtos
```bash
curl -X GET http://localhost:8080/api/produtos \
  -H "Authorization: Bearer SEU_TOKEN_JWT"
```

## 🏗️ Arquitetura do Projeto

```
src/main/java/com/example/meu_primeiro_springboot/
├── 📁 controller/          # Camada de apresentação (REST Controllers)
│   ├── AuthController.java       # Autenticação de usuários
│   ├── ProdutoController.java     # Operações de produtos
│   └── MensagemController.java    # Sistema de mensagens
│
├── 📁 model/               # Camada de modelo (Entidades JPA)
│   ├── Produto.java              # Entidade Produto
│   └── Usuario.java              # Entidade Usuário
│
├── 📁 repository/          # Camada de dados (Repositórios)
│   ├── ProdutoRepository.java     # Repositório de produtos
│   ├── UsuarioRepository.java     # Repositório de usuários
│   └── MensagemRepository.java    # Repositório de mensagens
│
├── 📁 service/             # Camada de negócio (Serviços)
│   ├── ProdutoService.java        # Lógica de produtos
│   ├── UsuarioService.java        # Lógica de usuários
│   ├── UsuarioDetailsService.java # Detalhes para autenticação
│   └── MensagemService.java       # Lógica de mensagens
│
├── 📁 security/            # Configurações de segurança
│   ├── SecurityConfig.java       # Configuração geral de segurança
│   ├── JwtUtil.java              # Utilitários JWT
│   └── JwtAuthFilter.java        # Filtro de autenticação JWT
│
└── 📁 exceptions/          # Tratamento de exceções
    ├── GlobalExceptionHandler.java      # Handler global
    └── RecursoNaoEncontradoException.java # Exceção customizada
```

## 🔒 Segurança

- **Autenticação JWT**: Tokens seguros para acesso à API
- **Proteção de endpoints**: Rotas `/api/**` protegidas
- **Endpoints públicos**: Apenas `/auth/**` acessível sem token
- **Headers de segurança**: Configurações de CORS e headers HTTP

## 🎯 Casos de Uso

### E-commerce
- Gerenciar catálogo de produtos
- Controlar acesso de administradores
- Sistema de autenticação para vendedores

### Inventário
- Controle de estoque
- Cadastro de produtos
- Relatórios de produtos

### Marketplace
- API para múltiplos vendedores
- Gestão centralizada de produtos
- Sistema de autenticação unificado

## 🚀 Próximas Melhorias

- [ ] **Paginação** para listagem de produtos
- [ ] **Filtros e busca** avançada
- [ ] **Upload de imagens** para produtos
- [ ] **Categorias** de produtos
- [ ] **Roles e permissões** diferenciadas
- [ ] **Documentação OpenAPI/Swagger**
- [ ] **Testes automatizados**
- [ ] **Containerização Docker**
- [ ] **Monitoramento com Actuator**

## 🤝 Contribuições

Contribuições são sempre bem-vindas! Para contribuir:

1. **Fork** o projeto
2. Crie uma **branch** para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. **Commit** suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. **Push** para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um **Pull Request**

## 📄 Licença

Este projeto está sob a licença **MIT**. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.

---

<div align="center">
  <strong>Desenvolvido com ❤️ usando Spring Boot 3.4.3 e Java 21</strong>
  <br>
  <sub>API REST para gerenciamento de produtos</sub>
  <br><br>
  <strong>👨‍💻 Desenvolvido por <a href="https://github.com/marcelohs402015">Marcelo Hernandes</a></strong>
</div>

