<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.io.UnsupportedEncodingException,java.net.URLEncoder,java.util.HashSet,java.util.Locale,java.util.Set,java.util.regex.Matcher,java.util.regex.Pattern" %>
<%!
    private String encodeParameter(String value) throws UnsupportedEncodingException {
        return URLEncoder.encode(value, "UTF-8");
    }
%>
<%
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.sendRedirect("test.html");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String summary = request.getParameter("summary");
    name = name == null ? "" : name.trim();
    email = email == null ? "" : email.trim();
    summary = summary == null ? "" : summary.trim();

    String nameError = "Enter a name start with Capital letter length <=10";
    String emailError = "Enter correct email";
    String summaryError = "Include more Hibernate keywords in your summary.";
    Set<String> errors = new java.util.LinkedHashSet<String>();

    if (name.length() != 10 || !Character.isUpperCase(name.charAt(0))) {
        errors.add(nameError);
    }
    if (!email.matches("[A-Za-z0-9._%+-]+@gmail\\.com")) {
        errors.add(emailError);
    }

    String[] keywords = {
        "hibernate", "orm", "entity", "session", "transaction",
        "hql", "mapping", "persistence", "dialect", "cache"
    };
    Set<String> summaryWords = new HashSet<String>();
    Matcher wordMatcher = Pattern.compile("[\\p{L}\\p{N}]+").matcher(summary.toLowerCase(Locale.ROOT));
    int wordCount = 0;
    while (wordMatcher.find()) {
        summaryWords.add(wordMatcher.group());
        wordCount++;
    }

    int matchedKeywords = 0;
    for (String keyword : keywords) {
        if (summaryWords.contains(keyword)) {
            matchedKeywords++;
        }
    }
    double matchPercentage = (matchedKeywords * 100.0) / keywords.length;
    int score = 0;
    if (wordCount > 100 && matchPercentage >= 100.0) {
        score = 10;
    } else if (wordCount > 90 && matchPercentage >= 90.0) {
        score = 9;
    } else if (wordCount > 70 && matchPercentage >= 80.0) {
        score = 8;
    } else if (wordCount > 50 && matchPercentage >= 70.0) {
        score = 7;
    }

    if (matchedKeywords < 7) {
        errors.add(summaryError);
    }

    if (!errors.isEmpty()) {
        StringBuilder redirect = new StringBuilder("test.html?");
        boolean first = true;
        for (String error : errors) {
            if (!first) {
                redirect.append('&');
            }
            redirect.append("error=").append(encodeParameter(error));
            first = false;
        }
        response.sendRedirect(redirect.toString());
        return;
    }

    String resultUrl = "result.html?name=" + encodeParameter(name)
        + "&email=" + encodeParameter(email)
        + "&score=" + score;
    response.sendRedirect(resultUrl);
%>
