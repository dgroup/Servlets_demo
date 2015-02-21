<!DOCTYPE html>
<html lang="en">
<head>
    <title>Demo Project</title>
    <meta   charset = "utf-8">
    <meta   name    = "viewport"
            content = "width=device-width, initial-scale=1">
    <link   rel     = "stylesheet"
            href    = "css/bootstrap.min.css">
    <script src     = "js/jquery-1.11.1.min.js"></script>
    <script src     = "js/bootstrap.min.js"></script>
</head>
<body>

    <div class="container">
        <div class="jumbotron">
            <h1>Welcome to the Demo Project</h1>
            <p>This is simple example of Java web application</p>
        </div>

        <div class="row">

            <div class="col-sm-4">
                <h3>Servlets</h3>
                <p>A Java servlet is a Java programming language program that extends the capabilities of a server. Although servlets can respond to any types of requests, they most commonly implement applications hosted on Web servers.</p>
                <a href="https://en.wikipedia.org/wiki/Java_servlet">
                    <i class="fa fa-external-link">More</i>
                </a>
            </div>

            <div class="col-sm-4">
                <h3>JSP</h3>
                <p>JavaServer Pages (JSP) is a technology that helps software developers create dynamically generated web pages based on HTML, XML, or other document types. Released in 1999 by Sun Microsystems, JSP is similar to PHP, but it uses the Java programming language.</p>
                <a href="https://en.wikipedia.org/wiki/JavaServer_Pages">
                    <i class="fa fa-external-link">More</i>
                </a>
            </div>

            <div class="col-sm-4">
                <h3>Let's try</h3>
                <a href="/Servlets_demo/Blog?action=toCommentsPage" >
                    <button type="button" class="btn btn-success">Push Me</button>
                </a>
            </div>
        </div>
    </div>

</body>
</html>