package sumy.javacourse.webdemo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class Main extends HttpServlet {
    private static final Logger LOG = LoggerFactory.getLogger(Main.class);
    private static Integer requestCounter = 0;


    @Override
    public void init() throws ServletException {
        LOG.info("I have started.");
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LOG.info("I'm working now... Request id is {}. ", ++requestCounter);
    }

    @Override
    public void destroy() {
        LOG.info("I'm going to sleep.");
    }
}