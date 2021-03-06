package viser.web.card;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import viser.dao.card.CardDAO;

@WebServlet("/cards/removecard")
public class DeleteCardServlet extends HttpServlet {
  private static final Logger logger = LoggerFactory.getLogger(DeleteCardServlet.class);

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    int num = Integer.parseInt(request.getParameter("num"));
    int listNum = Integer.parseInt(request.getParameter("listNum"));
    int cardOrder = Integer.parseInt(request.getParameter("cardOrder"));

    HttpSession session = request.getSession();
    CardDAO cardDAO = new CardDAO();

    try {
      cardDAO.removeCard(num, listNum, cardOrder);
      response.sendRedirect("/lists/cardlist?boardNum=" + (int) session.getAttribute("boardNum"));
    } catch (Exception e) {
      logger.debug("RemovecardServlet error" + e);
    }

  }
}
