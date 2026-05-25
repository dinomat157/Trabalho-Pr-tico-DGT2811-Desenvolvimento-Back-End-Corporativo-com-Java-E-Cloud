package cadastroee.servlets;

import cadastroee.controller.ProdutoFacadeLocal;
import cadastroee.model.Produto;
import java.io.IOException;
import java.util.List;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletProdutoFC", urlPatterns = {"/ServletProdutoFC"})
public class ServletProdutoFC extends HttpServlet {

    @EJB
    private ProdutoFacadeLocal facade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String acao = request.getParameter("acao");
        if (acao == null) {
            acao = "listar";
        }
        
        String destino = "ProdutoLista.jsp";
        
        try {
            // acao de listar tudo
            if (acao.equals("listar")) {
                List<Produto> lista = facade.findAll();
                request.setAttribute("produtos", lista);
                destino = "ProdutoLista.jsp";
            } 
            // abre form de incluir vazio
            else if (acao.equals("formIncluir")) {
                request.setAttribute("produto", null);
                destino = "ProdutoDados.jsp";
            } 
            // abre form de editar preenchido
            else if (acao.equals("formAlterar")) {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    Integer id = Integer.parseInt(idStr);
                    Produto p = facade.find(id);
                    request.setAttribute("produto", p);
                }
                destino = "ProdutoDados.jsp";
            } 
            // exclui o produto
            else if (acao.equals("excluir")) {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    Integer id = Integer.parseInt(idStr);
                    Produto p = facade.find(id);
                    if (p != null) {
                        facade.remove(p);
                    }
                }
                // atualiza a lista
                List<Produto> lista = facade.findAll();
                request.setAttribute("produtos", lista);
                destino = "ProdutoLista.jsp";
            } 
            // salva a alteracao
            else if (acao.equals("alterar")) {
                String idStr = request.getParameter("id");
                String nome = request.getParameter("nome");
                String qtdStr = request.getParameter("quantidade");
                String precoStr = request.getParameter("precoVenda");
                
                if (idStr != null) {
                    Integer id = Integer.parseInt(idStr);
                    Produto p = facade.find(id);
                    if (p != null) {
                        p.setNome(nome);
                        p.setQuantidade(Integer.parseInt(qtdStr));
                        p.setPrecoVenda(Float.parseFloat(precoStr));
                        facade.edit(p);
                    }
                }
                
                // atualiza a lista
                List<Produto> lista = facade.findAll();
                request.setAttribute("produtos", lista);
                destino = "ProdutoLista.jsp";
            } 
            // salva novo produto
            else if (acao.equals("incluir")) {
                String nome = request.getParameter("nome");
                String qtdStr = request.getParameter("quantidade");
                String precoStr = request.getParameter("precoVenda");
                
                Produto p = new Produto();
                p.setNome(nome);
                p.setQuantidade(Integer.parseInt(qtdStr));
                p.setPrecoVenda(Float.parseFloat(precoStr));
                
                facade.create(p);
                
                // atualiza a lista
                List<Produto> lista = facade.findAll();
                request.setAttribute("produtos", lista);
                destino = "ProdutoLista.jsp";
            }
        } catch (Exception e) {
            // se der algum erro
            request.setAttribute("erro", e.getMessage());
            List<Produto> lista = facade.findAll();
            request.setAttribute("produtos", lista);
            destino = "ProdutoLista.jsp";
        }
        
        // redireciona
        RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
