<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="cadastroee.model.Produto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CadastroEE - Lista de Produtos</title>
    <!-- CSS do Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">

    <div class="row">
        <div class="col-md-12">
            <h2>Cadastro de Produtos</h2>
            <hr/>
            
            <% if (request.getAttribute("erro") != null) { %>
                <div class="alert alert-danger">
                    Erro: <%= request.getAttribute("erro") %>
                </div>
            <% } %>
            
            <p>
                <a href="ServletProdutoFC?acao=formIncluir" class="btn btn-success">
                    + Incluir Novo
                </a>
            </p>
            
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Qtd</th>
                        <th>Preco</th>
                        <th>Acoes</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Produto> lista = (List<Produto>) request.getAttribute("produtos");
                        if (lista != null && lista.size() > 0) {
                            for (Produto p : lista) {
                    %>
                                <tr>
                                    <td><%= p.getIdProduto() %></td>
                                    <td><%= p.getNome() %></td>
                                    <td><%= p.getQuantidade() %></td>
                                    <td>R$ <%= p.getPrecoVenda() %></td>
                                    <td>
                                        <a href="ServletProdutoFC?acao=formAlterar&id=<%= p.getIdProduto() %>" class="btn btn-warning btn-sm">Alterar</a>
                                        <a href="ServletProdutoFC?acao=excluir&id=<%= p.getIdProduto() %>" class="btn btn-danger btn-sm" onclick="return confirm('Quer mesmo excluir?');">Excluir</a>
                                    </td>
                                </tr>
                    <% 
                            }
                        } else {
                    %>
                            <tr>
                                <td colspan="5" class="text-center">Nenhum produto cadastrado no banco.</td>
                            </tr>
                    <% 
                        } 
                    %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
