package viser.web.board;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import viser.dao.board.BoardDAO;
import viser.domain.board.Board;

@WebServlet("/board/createBoard")
public class CreateBoardServlet extends HttpServlet {
  public static Logger logger = LoggerFactory.getLogger(CreateBoardServlet.class);

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    Board board = new Board();
    BoardDAO boardDAO = new BoardDAO();

    HttpSession session = request.getSession();

    String projectName = (String) session.getAttribute("projectName");
    String boardName = request.getParameter("boardName");

    board.setProjectName(projectName);
    board.setBoardName(boardName);

    projectName = URLEncoder.encode(projectName, "UTF-8");

    try {
      boardDAO.addBoard(board);
      response.sendRedirect("/board/boardlist?projectName=" + projectName);

    } catch (Exception e) {
      logger.debug("Board create fail : " + e);
    }

  }
}
