<%@ page import="sumy.javacourse.webdemo.Comment" %>
<%@ page import="sumy.javacourse.webdemo.Main" %>
<%@ page import="java.util.Collection" %>
<%@ page import="static org.apache.commons.collections.CollectionUtils.isNotEmpty" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Demo Project</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <div class="jumbotron">
    <h2>Are the Servlet & JSP simple technologies?</h2>

    <%
      int agreeAmount = Integer.valueOf( request.getSession().getAttribute(Main.AGREE).toString() );
      int disagreeAmount = Integer.valueOf( request.getSession().getAttribute(Main.DISAGREE).toString() );
      int tentativeAmount = Integer.valueOf( request.getSession().getAttribute(Main.TENTATIVE).toString() );
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
        <th>Vote</th>
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
        <td>Total</td>
        <td><%=total%></td>
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
      <%
        Collection<Comment> comments = (Collection<Comment>) request.getSession().getAttribute("comments");
        if (isNotEmpty(comments)){
          for(Comment c : comments){
      %>
      <h3><%=c.getAuthor() %></h3>
      <p><%=c.getText() %></p>
      <br/>
      <%
          }
        }
      %>
    </div>

  </div>
</div>

</body>
</html>