package viser.web.project;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import viser.dao.project.ProjectDAO;

@WebServlet("/projects/inviteUser")
public class CreateProjectMemberServlet extends HttpServlet {
  public static Logger logger = LoggerFactory.getLogger(CreateProjectMemberServlet.class);

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();

    String projectName = (String) session.getAttribute("projectName");
    String userId = request.getParameter("userId");
    final int power = 0;

    logger.debug("프로젝트 명 : " + projectName + "\n초대할 유저명 : " + userId);

    ProjectDAO projectDAO = new ProjectDAO();

    try {
      projectDAO.InviteUser(userId, projectName, power);

      response.sendRedirect("/lists/cardlist?boardNum=" + session.getAttribute("boardNum"));
    } catch (Exception e) {
      logger.debug("Search fail : " + e);
    }
  }
}
