# Script de Teste da API Spring Boot - Produtos
# Executa testes automatizados da API

Write-Host "===========================================" -ForegroundColor Green
Write-Host "    TESTE DA API SPRING BOOT - PRODUTOS" -ForegroundColor Green  
Write-Host "===========================================" -ForegroundColor Green
Write-Host ""

# Teste 1: Login para obter JWT
Write-Host "1. Fazendo login para obter token JWT..." -ForegroundColor Yellow
$loginBody = @{
    username = "admin"
    password = "admin"
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri "http://localhost:8080/auth/login" -Method POST -Body $loginBody -ContentType "application/json"
    $token = $loginResponse.token
    Write-Host "✅ Login realizado com sucesso!" -ForegroundColor Green
    Write-Host "Token obtido: $($token.Substring(0,50))..." -ForegroundColor Cyan
    Write-Host ""
} catch {
    Write-Host "❌ Erro no login: $($_.Exception.Message)" -ForegroundColor Red
    exit
}

# Teste 2: Listar produtos
Write-Host "2. Testando listagem de produtos..." -ForegroundColor Yellow
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

try {
    $produtos = Invoke-RestMethod -Uri "http://localhost:8080/api/produtos" -Method GET -Headers $headers
    Write-Host "✅ Listagem de produtos realizada com sucesso!" -ForegroundColor Green
    Write-Host "Produtos encontrados: $($produtos.Count)" -ForegroundColor Cyan
    
    Write-Host "`n--- PRODUTOS CADASTRADOS ---" -ForegroundColor White
    foreach ($produto in $produtos) {
        Write-Host "ID: $($produto.id) | Nome: $($produto.nome) | Preço: R$ $($produto.preco)" -ForegroundColor Gray
    }
    Write-Host ""
} catch {
    Write-Host "❌ Erro na listagem: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 3: Criar novo produto
Write-Host "3. Testando criação de novo produto..." -ForegroundColor Yellow
$novoProduto = @{
    nome = "Produto Teste PowerShell"
    preco = 99.99
} | ConvertTo-Json

try {
    $produtoCriado = Invoke-RestMethod -Uri "http://localhost:8080/api/produtos" -Method POST -Body $novoProduto -Headers $headers
    Write-Host "✅ Produto criado com sucesso!" -ForegroundColor Green
    Write-Host "ID do produto: $($produtoCriado.id)" -ForegroundColor Cyan
    Write-Host ""
} catch {
    Write-Host "❌ Erro na criação: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 4: Buscar produto específico
if ($produtos -and $produtos.Count -gt 0) {
    $primeiroId = $produtos[0].id
    Write-Host "4. Testando busca de produto por ID ($primeiroId)..." -ForegroundColor Yellow
    
    try {
        $produto = Invoke-RestMethod -Uri "http://localhost:8080/api/produtos/$primeiroId" -Method GET -Headers $headers
        Write-Host "✅ Produto encontrado com sucesso!" -ForegroundColor Green
        Write-Host "Nome: $($produto.nome) | Preço: R$ $($produto.preco)" -ForegroundColor Cyan
        Write-Host ""
    } catch {
        Write-Host "❌ Erro na busca: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Salvar resultados em arquivo
$resultados = @{
    timestamp = Get-Date
    login = "SUCCESS"
    listagem = if ($produtos) { "SUCCESS - $($produtos.Count) produtos" } else { "FAILED" }
    criacao = if ($produtoCriado) { "SUCCESS - ID $($produtoCriado.id)" } else { "FAILED" }
    busca = if ($produto) { "SUCCESS" } else { "FAILED" }
} | ConvertTo-Json

$resultados | Out-File -FilePath "teste_resultados.json" -Encoding UTF8

Write-Host "===========================================" -ForegroundColor Green
Write-Host "         TESTES CONCLUÍDOS" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green
Write-Host "Resultados salvos em: teste_resultados.json" -ForegroundColor Gray
Write-Host ""