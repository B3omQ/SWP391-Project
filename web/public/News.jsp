<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/template/header.jsp" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Thông tin mới | SmartBanking</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .content-wrapper {
            flex: 1 0 auto;
            padding-top: 120px; /* Tăng padding-top để tạo khoảng cách lớn hơn giữa header và nội dung */
            padding-bottom: 60px;
        }
        .news-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .news-item {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-decoration: none;
            color: #333;
        }
        .news-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .news-item img {
            width: 200px;
            height: 130px;
            object-fit: cover;
            margin-right: 20px;
            border-radius: 6px;
            background-color: #ddd;
        }
        .news-content {
            flex: 1;
        }
        .news-title {
            font-size: 20px;
            font-weight: 600;
            color: #d41c1c;
            margin-bottom: 10px;
            line-height: 1.2;
        }
        .news-date {
            font-size: 14px;
            color: #777;
            margin-bottom: 10px;
        }
        .news-desc {
            font-size: 15px;
            color: #555;
            line-height: 1.6;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            max-height: 72px;
            white-space: pre-wrap;
            word-wrap: break-word;
        }
        .news-link {
            font-size: 14px;
            color: #d41c1c;
            text-decoration: none;
            font-weight: 500;
            display: inline-block;
            margin-top: 10px;
        }
        .news-link:hover {
            text-decoration: underline;
        }
        .filter-section {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .filter-section .form-control {
            margin-right: 10px;
        }

        @media (max-width: 768px) {
            .content-wrapper {
                padding-top: 100px; /* Giảm padding-top trên thiết bị di động để không quá trống */
            }
            .news-item {
                flex-direction: column;
                align-items: flex-start;
            }
            .news-item img {
                width: 100%;
                height: auto;
                margin-bottom: 15px;
            }
            .news-title {
                font-size: 18px;
            }
            .news-desc {
                -webkit-line-clamp: 2;
                max-height: 48px;
            }
            .filter-section .form-control {
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="content-wrapper">
        <div class="news-container">
            <h2 class="text-center mb-4" style="color: #d41c1c; font-weight: 700;">Thông Tin Mới</h2>

            <!-- Filter Section -->
            <div class="filter-section">
                <form method="get" action="${pageContext.request.contextPath}/NewsServlet" class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="search" placeholder="Tìm kiếm theo tiêu đề..." value="${param.search}">
                    </div>
                    <div class="col-md-2">
                        <select class="form-control" name="categoryFilter">
                            <option value="">Tất cả thể loại</option>
                            <option value="vay" ${param.categoryFilter == 'vay' ? 'selected' : ''}>Vay</option>
                            <option value="tin tức" ${param.categoryFilter == 'tin tức' ? 'selected' : ''}>Tin tức</option>
                            <option value="khác" ${param.categoryFilter == 'khác' ? 'selected' : ''}>Khác</option>
                            <option value="kinh nghiệm" ${param.categoryFilter == 'kinh nghiệm' ? 'selected' : ''}>Kinh nghiệm</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-control" name="sortBy">
                            <option value="publishDate_desc" ${param.sortBy == 'publishDate_desc' ? 'selected' : ''}>Mới nhất trước</option>
                            <option value="publishDate_asc" ${param.sortBy == 'publishDate_asc' ? 'selected' : ''}>Cũ nhất trước</option>
                            <option value="title_asc" ${param.sortBy == 'title_asc' ? 'selected' : ''}>Tiêu đề (A-Z)</option>
                            <option value="title_desc" ${param.sortBy == 'title_desc' ? 'selected' : ''}>Tiêu đề (Z-A)</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-control" name="recordsPerPage" onchange="this.form.submit()">
                            <option value="5" ${recordsPerPage == 5 ? 'selected' : ''}>5 bài viết</option>
                            <option value="10" ${recordsPerPage == 10 ? 'selected' : ''}>10 bài viết</option>
                            <option value="20" ${recordsPerPage == 20 ? 'selected' : ''}>20 bài viết</option>
                            <option value="50" ${recordsPerPage == 50 ? 'selected' : ''}>50 bài viết</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">Lọc</button>
                    </div>
                    <input type="hidden" name="page" value="1">
                </form>
            </div>

            <!-- News List -->
            <c:choose>
                <c:when test="${not empty newsList}">
                    <c:forEach var="news" items="${newsList}" varStatus="loop">
                        <a href="${pageContext.request.contextPath}/NewsDetailServlet?id=${news.id}" class="news-item">
                            <c:choose>
                                <c:when test="${not empty news.imageUrl && news.imageUrl != ''}">
                                    <img src="${pageContext.request.contextPath}${news.imageUrl}" alt="News Image">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/images/default-image.jpg" alt="Default Image">
                                </c:otherwise>
                            </c:choose>
                            <div class="news-content">
                                <div class="news-title">${fn:escapeXml(news.title)}</div>
                                <div class="news-date">
                                    <fmt:formatDate value="${news.publishDate}" pattern="dd/MM/yyyy" />
                                </div>
                                <div class="news-desc">${fn:escapeXml(news.description)}</div>
                                <div class="news-link">Xem chi tiết <i class="bi bi-arrow-right"></i></div>
                            </div>
                        </a>
                    </c:forEach>

                    <!-- Phân trang -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center mt-4">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/NewsServlet?page=${currentPage - 1}&search=${param.search}&categoryFilter=${param.categoryFilter}&sortBy=${param.sortBy}&recordsPerPage=${recordsPerPage}" aria-label="Previous">
                                        <span aria-hidden="true">«</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/NewsServlet?page=${i}&search=${param.search}&categoryFilter=${param.categoryFilter}&sortBy=${param.sortBy}&recordsPerPage=${recordsPerPage}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/NewsServlet?page=${currentPage + 1}&search=${param.search}&categoryFilter=${param.categoryFilter}&sortBy=${param.sortBy}&recordsPerPage=${recordsPerPage}" aria-label="Next">
                                        <span aria-hidden="true">»</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:when>
                <c:otherwise>
                    <p class="text-center" style="color: #777;">Không có bài viết nào để hiển thị.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%@ include file="/template/footer.jsp" %>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>