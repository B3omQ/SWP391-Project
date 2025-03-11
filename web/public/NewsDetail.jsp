<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/template/header.jsp" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>${article.title} | SmartBanking</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet">
</head>
<body>
    <div class="content-wrapper" style="padding: 60px 20px;">
        <div class="news-container" style="max-width: 800px; margin: 0 auto;">
            <h2 class="mb-4" style="color: #d41c1c; font-weight: 700;">${article.title}</h2>
            <div class="news-date" style="color: #777; margin-bottom: 20px;">
                <fmt:formatDate value="${article.publishDate}" pattern="dd/MM/yyyy" />
            </div>
            <c:if test="${not empty article.imageUrl && article.imageUrl != ''}">
                <img src="${pageContext.request.contextPath}${article.imageUrl}" alt="News Image" style="width: 100%; max-width: 400px; margin-bottom: 20px;">
            </c:if>
            <div style="font-size: 16px; line-height: 1.6; color: #333;">${article.description}</div>
        </div>
    </div>

    <%@ include file="/template/footer.jsp" %>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>