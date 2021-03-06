package viser.web.card;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;

import viser.dao.card.CardDAO;
import viser.domain.card.Card;

@WebServlet("/cards/viewcard")
public class ReadCardServlet extends HttpServlet {
  private static final Logger logger = LoggerFactory.getLogger(ReadCardServlet.class);

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    PrintWriter out = response.getWriter();
    HttpSession session = request.getSession();
    String userId = (String) session.getAttribute("userId");

    CardDAO cardDAO = new CardDAO();
    Card card = new Card();

    int cardNum = Integer.parseInt(request.getParameter("cardNum"));

    try {
      card = cardDAO.viewCard(cardNum);

      if (card == null) {
        logger.debug("card View null");
      }

      Gson gson = new Gson();
      String jsonData = gson.toJson(card);
      logger.debug("jsonData:" + jsonData.toString());
      out.print(jsonData);
    } catch (Exception e) {
      logger.debug("cardviewServlet error : " + e);
    } finally {
      out.close();
    }
  }

}
