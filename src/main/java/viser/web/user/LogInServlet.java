package viser.web.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import viser.dao.user.UserDAO;
import viser.domain.user.PasswordMismatchException;
import viser.domain.user.User;
import viser.domain.user.UserNotFoundException;

@WebServlet("/users/login")
public class LogInServlet extends HttpServlet {
  public static final String SESSION_USER_ID = "userId";
  private static final Logger logger = LoggerFactory.getLogger(LogInServlet.class);

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    UserDAO userDAO = new UserDAO();

    String userId = request.getParameter(SESSION_USER_ID);
    String password = request.getParameter("password");

    try {
      logger.debug("로그인 서블릿");
      User.login(userId, password);
      HttpSession session = request.getSession();
      session.setAttribute(SESSION_USER_ID, userId);
      logger.debug("로그인 처리성공");

      User user = userDAO.getByUserId(userId);
      session.setAttribute("userId", user.getUserId());
      session.setAttribute("isUpdate", true);
      session.setAttribute("user", user);

      response.sendRedirect("/project/projectlist");
    } catch (UserNotFoundException e) {
      errorForward(request, response, "존재하지 않는 사용자 입니다. 다시 로그인하세요.");
    } catch (PasswordMismatchException e) {
      errorForward(request, response, "비밀번호가 일치 하지 않습니다.");
    } catch (Exception e) {
    }
  }

  private void errorForward(HttpServletRequest request, HttpServletResponse response, String errorMessage) throws ServletException, IOException {
    request.setAttribute("errorMessage", errorMessage);
    RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/index.jsp");
    rd.forward(request, response);
  }

}
