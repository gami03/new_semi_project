package com.user.action;

import java.util.Random;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;
import com.user.model.UserDTO;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PwdFindAction implements Action {

  


@Override
public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
	request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html charset=utf-8");

    String userId = request.getParameter("paramId");
    String userName = request.getParameter("paramName");
    String userEmail = request.getParameter("paramEmail");

    int result = 0;
    // 먼저 아이디로 회원정보를 받아오고 가져온 데이터에서 email값을 비교하여 존재하지 않으면 인증메일 보내지 못함
    /*
     * Member m = new MemberService().memberLogin(memberId); if(m==null ||
     * !m.getEmail().equals(email)) {
     * 
     * req.setAttribute("msg", "아이디나 이메일 정보가 맞지 않습니다"); req.setAttribute("loc",
     * "/member/searchPw");
     * req.getRequestDispatcher("/views/common/msg.jsp").forward(req, resp);
     * 
     * return; }
     */

    UserDAO dao = UserDAO.getInstance();

    UserDTO dto = new UserDTO();

    dto = dao.UserFindPwd(userId,userName,userEmail);
    
    System.out.println("userId: " + userId);
    System.out.println("userName: " + userName);
    System.out.println("userEmail: " + userEmail);
    
    System.out.println("PwdFindAction ID : " + dto.getUser_id());
    System.out.println("PwdFindAction NAME : " + userName);
    System.out.println("PwdFindAction EMAIL : " + userEmail);

    if (dto.getUser_id().equals("없음") || !dto.getUser_name().equals(userName)
          || !dto.getUser_email().equals(userEmail)) {

       result = -1;

    } else {

       result = 1;

       // mail server 설정
       String host = "smtp.gmail.com";
       String user = "majesticdevel@gmail.com"; // 자신의 구글 계정
       String password = "csjqupuxiukvesny";// 자신의 구글 패스워드

       // 메일 받을 주소
       /* String to_email = m.getEmail(); */
       String to_email = userEmail;

       // SMTP 서버 정보를 설정한다.
       Properties prop = new Properties();

       prop.put("mail.smtp.host", host);
       prop.put("mail.smtp.port", 465);
       prop.put("mail.smtp.auth", "true");
       prop.put("mail.smtp.ssl.enable", "true");
       prop.put("mail.smtp.ssl.trust", host);

       // 인증 번호 생성기
       StringBuffer temp = new StringBuffer();
       Random rnd = new Random();
       for (int i = 0; i < 10; i++) {
          int rIndex = rnd.nextInt(3);
          switch (rIndex) {
          case 0:
             // a-z
             temp.append((char) ((int) (rnd.nextInt(26)) + 97));
             break;
          case 1:
             // A-Z
             temp.append((char) ((int) (rnd.nextInt(26)) + 65));
             break;
          case 2:
             // 0-9
             temp.append((rnd.nextInt(10)));
             break;
          }
       }

       String AuthenticationKey = temp.toString();

       System.out.println(AuthenticationKey);

       dao.TempPwdUpdate(dto.getUser_no(), AuthenticationKey);

       Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
          protected PasswordAuthentication getPasswordAuthentication() {
             return new PasswordAuthentication(user, password);
          }
       });

       // email 전송
       try {
          MimeMessage msg = new MimeMessage(session);
          msg.setFrom(new InternetAddress(user, "Galic Auction"));
          msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));

          // 메일 제목
          msg.setSubject("[Galic Auction] 임시 비밀번호 안내");

          // 메일 내용
          msg.setContent("<h1>임시 비밀번호 안내</h1>" + "<br>" + "<br>" + "<p>안녕하세요,</p>" + "<br>"
                + "<p>고객님의 계정에 대한 비밀번호 초기화 요청을 받았습니다. 이에 따라 임시 비밀번호를 발급해드립니다.</p>" + "<br>"
                + String.format("<p>임시 비밀번호: <b>%s</b></p>", temp) + "<br>"
                + "<p>위 임시 비밀번호를 사용하여 로그인하신 후, 마이 페이지에서 새로운 비밀번호를 설정해주시기 바랍니다.</p>" + "<br>" + "<p>감사합니다.</p>"
                + "<br>" + "<p>[Galic Auction]</p>", "text/html; charset=UTF-8");

          Transport.send(msg);

          System.out.println("이메일 전송");

       } catch (Exception e) {
          e.printStackTrace();// TODO: handle exception
       }
       HttpSession saveKey = request.getSession();
       saveKey.setAttribute("AuthenticationKey", AuthenticationKey);
       // 패스워드 바꿀때 뭘 바꿀지 조건에 들어가는 id
       /*
        * req.setAttribute("id", memberId);
        * req.getRequestDispatcher("/views/login_myPage/searchPasswordEnd.jsp").forward
        * (req, resp);
        */

    }

    PrintWriter out = response.getWriter();
    out.println(result + "");

    return null;
 }
}
