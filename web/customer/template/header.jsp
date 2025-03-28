<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="model.Customer" %>
<%@ page import="model.Notification" %>
<%@ page import="dal.NotifyDAO" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>SmartBanking</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="${pageContext.request.contextPath}/index.jsp" />
        <meta name="Version" content="v1.2.0" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <!-- simplebar -->
        <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- SLIDER -->
        <link href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="${pageContext.request.contextPath}/assets/css/deposit.css" rel="stylesheet" type="text/css" />
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
        <style>
            .btn-custom {
                border: 2px solid #ff0000;
                background-color: #ff0000; /* Đổi nền thành đỏ */
                color: #fff; /* Giữ chữ trắng để tương phản */
                font-weight: bold;
                border-radius: 8px;
                padding: 10px 20px;
            }
            .btn-custom:hover {
                background-color: #cc0000; /* Đổi sang đỏ đậm hơn khi hover */
                color: #fff; /* Giữ chữ trắng */
            }
            .feature-box {
                background-color: #fff0f0; /* Màu nền nhạt đỏ */
                padding: 20px;
                border-radius: 10px;
                text-align: center;
            }
            .icon-large {
                font-size: 2rem;
                color: #ff0000; /* Màu đỏ cho icon */
            }
            .term-box {
                border: 2px solid #ddd;
                padding: 15px;
                text-align: center;
                border-radius: 10px;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .term-box:hover, .term-box.selected {
                border-color: #ff0000; /* Đường viền đỏ khi hover hoặc selected */
                background-color: #ffe6e6; /* Màu nền nhạt đỏ */
            }
            .option-box {
                border: 2px solid #ddd;
                border-radius: 10px;
                padding: 15px;
                margin-bottom: 10px;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .option-box:hover, .option-box.selected {
                border-color: #ff0000; /* Đường viền đỏ */
                background-color: #ffe6e6; /* Màu nền nhạt đỏ */
            }
            .option-box input {
                display: none;
            }
            .btn-group {
                display: flex;
                justify-content: space-between;
            }
            .card {
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .success-card {
                background-color: #fff;
                border-radius: 15px;
                box-shadow: 0 8px 16px rgba(255, 0, 0, 0.2); /* Hiệu ứng bóng đỏ */
                padding: 20px;
                border: 2px solid #ff0000; /* Đường viền đỏ */
                animation: fadeIn 1s ease-in;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .success-icon {
                font-size: 60px;
                color: #ff0000; /* Icon đỏ */
                margin-bottom: 20px;
            }
            .success-title {
                color: #ff0000; /* Tiêu đề đỏ */
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 20px;
                text-transform: uppercase;
            }
            .success-message {
                color: #333;
                font-size: 18px;
                margin-bottom: 25px;
            }
            .info-section {
                background-color: #fff0f0; /* Màu nền nhạt đỏ */
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            .amount {
                font-size: 24px;
                font-weight: bold;
                color: #ff0000; /* Số tiền màu đỏ */
            }
            .balance {
                font-size: 20px;
                font-weight: bold;
                color: #ff4444; /* Số dư màu đỏ nhạt */
            }
            .btn-home {
                background-color: #ff0000; /* Nút home màu đỏ */
                color: #fff;
                padding: 12px 40px;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                border: none;
                transition: background-color 0.3s ease;
            }
            .btn-home:hover {
                background-color: #cc0000; /* Màu đỏ đậm hơn khi hover */
                color: #fff;
                text-decoration: none;
            }
            .btn-deposit {
                background-color: #ff0000; /* Nút deposit màu đỏ */
                color: #fff;
                padding: 10px 20px;
                border-radius: 5px;
                border: none;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }
            .btn-deposit:hover {
                background-color: #cc0000; /* Màu đỏ đậm hơn khi hover */
            }
        </style>
    </head>
    <body>
        <%
            HttpSession sessionObj = request.getSession(false);
            Customer account = (sessionObj != null) ? (Customer) sessionObj.getAttribute("account") : null;

            if (account == null) {
                response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
                return;
            }

            String imagePath;
            if (account.getImage() != null && !account.getImage().isEmpty()) {
                imagePath = request.getContextPath() + "/uploads/" + account.getImage();
            } else {
                imagePath = request.getContextPath() + "/assets/images/default-avatar.jpg";
            }

            pageContext.setAttribute("account", account);
            NotifyDAO ndao = new NotifyDAO();
            List<Notification> notifyList = ndao.getAllNotificationByCusIdNotRead(account.getId(), false);
            if (notifyList == null) {
                notifyList = new ArrayList<>();
            }
            int count = ndao.countNotificationNotReadByCusId(account.getId(), false);
            pageContext.setAttribute("count", count);
            pageContext.setAttribute("notifyList", notifyList);
        %>
        <div class="page-wrapper doctris-theme toggled">
            <main class="page-content bg-light">
                <div class="top-header">
                    <div class="header-bar d-flex justify-content-between border-bottom">
                        <div class="d-flex align-items-center">
                            <a href="home.jsp" class="logo-icon">
                                <img src="${pageContext.request.contextPath}/assets/images/logo-icon2.png" height="30" class="small" alt="">
                                <span class="big">
                                    <img src="${pageContext.request.contextPath}/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                    <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                                </span>
                            </a>
                            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="home.jsp">
                                <i class="uil uil-bars"></i>
                            </a>
                            <div class="search-bar p-0 d-none d-md-block ms-2">
                                
                            </div>
                        </div>
                        <ul class="list-unstyled mb-0">                            
                            <li class="list-inline-item mb-0 ms-1">
                                <div class="dropdown dropdown-primary">
                                    <button type="button"
                                            class="btn btn-icon btn-pills btn-soft-primary dropdown-toggle p-0"
                                            data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i
                                            data-feather="mail" class="fea icon-sm"></i></button>
                                    <span
                                        class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">${count}
                                        <span class="visually-hidden">unread mail</span></span>

                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow rounded border-0 mt-3 px-2 py-2"
                                         data-simplebar style="height: auto; width: 300px;">
                                        <c:choose>
                                            <c:when test="${empty notifyList}">
                                                <div class="text-dark mb-0 d-block text-truncat ms-3">Danh sách thông báo trống</div>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="notify" items="${notifyList}">
                                                    <div class="d-flex bubble align-items-center justify-content-between py-2 notify-item" 
                                                         data-id="${notify.id}">                                                         
                                                        <div class="d-inline-flex position-relative overflow-hidden">
                                                            <img src="<%= request.getContextPath() %>/assets/images/logo-icon2.png"
                                                                 class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <small class="text-dark mb-0 d-block ms-3">
                                                                ${notify.description} 
                                                                <small class="text-muted fw-normal d-inline-block">${notify.createTime}</small>
                                                            </small>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                        <script>
                                            document.addEventListener("DOMContentLoaded", function () {
                                                document.querySelectorAll(".notify-item").forEach(item => {
                                                    item.addEventListener("click", function () {
                                                        let notifyId = this.getAttribute("data-id");

                                                        // Tạo form ẩn để gửi dữ liệu bằng POST
                                                        let form = document.createElement("form");
                                                        form.method = "POST";
                                                        form.action = "${pageContext.request.contextPath}/Notify-Url"; 

                                                        let input = document.createElement("input");
                                                        input.type = "hidden";
                                                        input.name = "notifyId";
                                                        input.value = notifyId;

                                                        form.appendChild(input);
                                                        document.body.appendChild(form);
                                                        form.submit();
                                                    });
                                                });
                                            });
                                        </script>
                                    </div>
                                </div>
                            </li>
                            <li class="list-inline-item mb-0 ms-1">
                                <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                    <div class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="settings" class="fea icon-sm"></i></div>
                                </a>
                            </li>
                            <li class="list-inline-item mb-0 ms-1">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <img src="<%= imagePath %>" class="avatar avatar-ex-small rounded-circle" alt="">
                                    </button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                        <a class="dropdown-item d-flex align-items-center text-dark" href="https://shreethemes.in/doctris/layouts/admin/profile.html">
                                            <img src="<%= imagePath %>" class="avatar avatar-md-sm rounded-circle border shadow" alt="Avatar">
                                            <div class="flex-1 ms-2">
                                                <span class="d-block mb-1">${account.firstname} ${account.lastname}</span>
                                                <small class="text-muted">Khách Hàng</small>
                                            </div>
                                        </a>
                                        <a class="dropdown-item text-dark" href="customer/Customer.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                        <a class="dropdown-item text-dark" href="customer/account-profile.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="${pageContext.request.contextPath}/AuthServlet?action=logout">
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout
                                        </a>
                                    </div>
                                </div>
                            </li>
                        </ul>


                    </div>
                </div>
