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
import viser.domain.card.Card;

@WebServlet("/cards/updatecard")
public class UpdateCardServlet extends HttpServlet {
  private static final Logger logger = LoggerFactory.getLogger(UpdateCardServlet.class);

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int cardNum = Integer.parseInt(request.getParameter("num"));
    String subject = request.getParameter("subject");
    String content = request.getParameter("content");

    Card card = new Card();
    card.setCardNum(cardNum);
    card.setSubject(subject);
    card.setContent(content);

    CardDAO cardDAO = new CardDAO();
    try {
      logger.debug("테스트 : " + card);
      cardDAO.updateCard(card);
    } catch (Exception e) {
      logger.debug("updatecard Servlet error" + e);
    }
    HttpSession session = request.getSession();
    response.sendRedirect("/lists/cardlist?boardNum=" + (int) session.getAttribute("boardNum"));
  }
}
