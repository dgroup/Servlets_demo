package sumy.javacourse.webdemo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import static org.apache.commons.collections.CollectionUtils.isEmpty;
import static org.apache.commons.lang3.StringUtils.isNotBlank;


public class Main extends HttpServlet {
    private static final Logger LOG = LoggerFactory.getLogger(Main.class);

    public static final String AGREE       = "agree";
    public static final String DISAGREE    = "disagree";
    public static final String TENTATIVE   = "tentative";

    private static Integer requestCounter = 0;

    private static final Collection<Comment> COMMENTS = new ArrayList<>();
    private static Integer agreeAmount = 30;
    private static Integer disagreeAmount = 20;
    private static Integer tentativeAmount = 50;

    @Override
    public void init() throws ServletException {
        LOG.info("I have started.");
    }

    @Override
    public void destroy() {
        LOG.info("I'm going to sleep.");
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LOG.info("I'm working now... Request id is {}. ", ++requestCounter);

        String resultURL = performYourLogic(req);
        LOG.debug("Result of your operation is {}", resultURL);

        RequestDispatcher dispatcher = req.getRequestDispatcher(resultURL);
        dispatcher.forward(req, resp);
    }



    /**
     * Bottleneck! Please do not use this approach in your labs/applications.
     * For labs please use "Action servlet" paradigm instead of it.
     *      http://reflection-note.blogspot.com/2008/06/blog-post_10.html
     *
     * Spring MWC/JSF/etc frameworks are deprecated for education process.
     */
    private String performYourLogic(HttpServletRequest req) {
        String action = req.getParameter("action");
        LOG.debug("Action is {}.", action);

        if (isNotBlank(action)){
            switch (action){
                case "toCommentsPage"   : return showCommentsPage(req);
                case "saveComment"      : return saveComment(req);
                case "saveVote"         : return saveVote(req);
                default                 : return indexURL();
            }
        }
        return indexURL();
    }

    private String saveVote(HttpServletRequest req) {
        switch (getParameterAsString(req, "voteType")){
            case AGREE     : agreeAmount++;      break;
            case DISAGREE  : disagreeAmount++;   break;
            case TENTATIVE : tentativeAmount++;  break;
            default: throw new UnsupportedOperationException("It never gonna happen.");
        }
        LOG.debug("Agree {}, Disagree {}, Tentative {}", agreeAmount, disagreeAmount, tentativeAmount);

        req.getSession().setAttribute(AGREE, agreeAmount);
        req.getSession().setAttribute(DISAGREE, disagreeAmount);
        req.getSession().setAttribute(TENTATIVE, tentativeAmount);

        return commentsURL();
    }

    @SuppressWarnings("unchecked")
    private String showCommentsPage(HttpServletRequest req) {
        Collection<Comment> commments = (Collection<Comment>) req.getSession().getAttribute("comments");
        Integer agree       = (Integer) req.getSession().getAttribute(AGREE);
        Integer tentative   = (Integer) req.getSession().getAttribute(TENTATIVE);
        Integer disagree    = (Integer) req.getSession().getAttribute(DISAGREE);


        { // When it will be executed? Why?
            if (isEmpty(commments)) {
                COMMENTS.add(new Comment("Tolian", "haha@yandex.ru", "What? Everybody must die..."));
                COMMENTS.add(new Comment("Hank", "omg@google.com", "From my point of view it's very simple."));
                COMMENTS.add(new Comment("xxxx", "xxx@xxxx.ua", " Stupid question at all... O_o"));
                req.getSession().setAttribute("comments", COMMENTS);
            }

            if (agree == null || agree < 0) {
                req.getSession().setAttribute(AGREE, agreeAmount);
            }

            if (tentative == null || tentative < 0) {
                req.getSession().setAttribute(TENTATIVE, tentativeAmount);
            }

            if (disagree == null || disagree < 0) {
                req.getSession().setAttribute(DISAGREE, disagreeAmount);
            }
        }

        return commentsURL();
    }

    private String saveComment(HttpServletRequest req) {
        String author = getParameterAsString(req, "author");
        String email  = getParameterAsString(req, "email");
        String commnt = getParameterAsString(req, "comment");

        COMMENTS.add( new Comment(author, email, commnt) );

        return commentsURL();
    }


    private static String indexURL(){
        return "/jsp/index.jsp";
    }
    private static String commentsURL(){
        return "/jsp/comments.jsp";
    }
    private static String getParameterAsString(HttpServletRequest req, String parameterName){
        Object parameter = req.getParameter( parameterName );
        return parameter == null? "" : parameter.toString();
    }
}