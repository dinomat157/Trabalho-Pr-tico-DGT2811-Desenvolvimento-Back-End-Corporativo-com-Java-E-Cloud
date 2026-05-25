<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cadastroee.model.Produto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CadastroEE - Formulario</title>
    <!-- CSS do Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">

    <%
        Produto p = (Produto) request.getAttribute("produto");
        String acao = "incluir";
        String titulo = "Cadastrar Novo Produto";
        
        if (p != null) {
            acao = "alterar";
            titulo = "Editar Produto: " + p.getNome();
        }
    %>

    <div class="row justify-content-center">
        <div class="col-md-6">
            <h3><%= titulo %></h3>
            <hr/>
            
            <form action="ServletProdutoFC" method="POST">
                
                <!-- campos escondidos pro servlet saber o que fazer -->
                <input type="hidden" name="acao" value="<%= acao %>">
                <% if (p != null) { %>
                    <input type="hidden" name="id" value="<%= p.getIdProduto() %>">
                <% } %>
                
                <div class="mb-3">
                    <label class="form-label">Nome do Produto</label>
                    <input type="text" class="form-control" name="nome" value="<%= p != null ? p.getNome() : "" %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Quantidade</label>
                    <input type="number" class="form-control" name="quantidade" value="<%= p != null ? p.getQuantidade() : "" %>" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Preço de Venda</label>
                    <input type="number" step="0.01" class="form-control" name="precoVenda" value="<%= p != null ? p.getPrecoVenda() : "" %>" required>
                </div>
                
                <p>
                    <button type="submit" class="btn btn-primary">Salvar</button>
                    <a href="ServletProdutoFC?acao=listar" class="btn btn-secondary">Voltar</a>
                </p>
                
            </form>
        </div>
    </div>

</body>
</html>
