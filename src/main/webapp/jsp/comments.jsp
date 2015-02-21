<%@ page import="sumy.javacourse.webdemo.Comment" %>
<%@ page import="sumy.javacourse.webdemo.Main" %>
<%@ page import="static sumy.javacourse.webdemo.DBStub.comments" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!--
  This is obsolete technology.
  Current approach implemented for example of pure Servlet/JSP technologies.
-->

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Demo Project</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="/js/core.js"></script>
</head>
<body>

<div class="container">
  <div class="jumbotron">
    <h2>Are the Servlet & JSP simple technologies?</h2>

    <%
      // Simple usage of HttpSession. Please do not use it in real applications/labs.
      int agreeAmount = Integer.valueOf( session.getAttribute(Main.AGREE).toString() );
      int disagreeAmount = Integer.valueOf( session.getAttribute(Main.DISAGREE).toString() );
      int tentativeAmount = Integer.valueOf( session.getAttribute(Main.TENTATIVE).toString() );
      int total = agreeAmount + disagreeAmount + tentativeAmount;

      /* This is incorrect algorithm for percent calculation. It just for example of scriplets .*/
      float agreePercent = agreeAmount * total / 100;
      float disagreePercent = disagreeAmount * (total-agreePercent) / 100;
      float tentativePercent = 100 - agreePercent - disagreePercent;
    %>

    <div class="progress">
      <div class="progress-bar progress-bar-success" role="progressbar" style="width: <%= agreePercent %>%">
        Agree
      </div>
      <div class="progress-bar progress-bar-danger" role="progressbar" style="width:  <%= disagreePercent %>%">
        Disagree
      </div>
      <div class="progress-bar progress-bar-warning" role="progressbar" style="width: <%= tentativePercent %>%">
        Tentative
      </div>
    </div>
    <table class="table">
      <thead>
      <tr>
        <th style="width: 30px">Vote</th>
        <th>Percent</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td>Agree</td>
        <td><%= agreePercent %></td>
      </tr>
      <tr>
        <td>Disagree</td>
        <td><%=disagreePercent%></td>
      </tr>
      <tr>
        <td>Tentative</td>
        <td><%=tentativePercent%></td>
      </tr>
      <tr>
        <th>Total</th>
        <th><%=total%></th>
      </tr>
      </tbody>
    </table>

    <form role="form" action="/Servlets_demo/Blog">
      <div class="radio">
        <label><input type="radio" name="voteType" value="agree" checked="checked">Agree</label>
      </div>
      <div class="radio">
        <label><input type="radio" name="voteType" value="disagree">Disagree</label>
      </div>
      <div class="radio">
        <label><input type="radio" name="voteType" value="tentative">Tentative</label>
      </div>
      <input type="hidden" name="action" value="saveVote">
      <button type="submit" class="btn btn-success">Save</button>
    </form>

  </div>

  <div class="row">
    <div class="col-sm-3 col-md-6 col-lg-4">
      <form role="form" action="/Servlets_demo/Blog">

        <div class="form-group">
          <label for="author">Author:</label>
          <input type="text" class="form-control" id="author" name="author" required="true">
        </div>

        <div class="form-group">
          <label for="email">Email:</label>
          <input type="text" class="form-control" id="email" name="email" required="true" pattern="[^@]+@[^@]+\.[a-zA-Z]{2,6}">
        </div>

        <div class="form-group">
          <label for="comment">Comment:</label>
          <textarea class="form-control" rows="5" id="comment" name="comment" required="true"></textarea>
        </div>

        <input type="hidden" name="action" value="saveComment">
        <button type="submit" class="btn btn-success">Send</button>
      </form>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-3 col-md-6 col-lg-4">
      <%
        for(Comment comment : comments()) {
      %>
          <h3><%=comment.getAuthor()%></h3>
          <p><%=comment.getText() %></p>
          <br/>
      <%
        }
      %>
    </div>
  </div>
</div>

</body>
</html>