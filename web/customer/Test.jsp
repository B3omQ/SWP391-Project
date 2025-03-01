<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.Customer" %>
<%@ page import="java.util.List" %>
<%@ page import="model.TermInfo" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>SmartBanking - Term Selection</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="../../../index.jsp" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- simplebar -->
    <link href="<%= request.getContextPath() %>/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
    <!-- Select2 -->
    <link href="<%= request.getContextPath() %>/assets/css/select2.min.css" rel="stylesheet" />
    <!-- Icons -->
    <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- SLIDER -->
    <link href="<%= request.getContextPath() %>/assets/css/tiny-slider.css" rel="stylesheet" />
    <!-- Css -->
    <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <link href="<%= request.getContextPath() %>/assets/css/deposit.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
<%
    HttpSession sessionObj = request.getSession();
    Integer term = (Integer) sessionObj.getAttribute("selectedTerm");

    if (term == null) {
        term = 1; // Giá trị mặc định, ví dụ 1 tháng
    }

    LocalDate today = LocalDate.now(); // Thêm lại dòng này
    int days = term * 30; // Tính theo 360 ngày/năm
    LocalDate dueDate = today.plusDays(days);

    String formattedDate = dueDate.format(DateTimeFormatter.ofPattern("dd MMMM yyyy"));
%>
    <style>
           .container {
            max-width: 600px;
            margin: auto;
            padding-top: 30px;
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
            border-color: #dc3545;
            background-color: #f8d7da;
        }
        .option-box input {
            display: none;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
           <%
   // Ki?m tra session
   if (session.getAttribute("account") == null) {
       response.sendRedirect(request.getContextPath() + "/auth/template/login.jsp");
       return; 
   }

   Customer account = (Customer) session.getAttribute("account");
   String imagePath;

   if (account != null && account.getImage() != null && !account.getImage().isEmpty()) {
       imagePath = request.getContextPath() + "/uploads/" + account.getImage();
   } else {
       imagePath = request.getContextPath() + "/assets/images/default-avatar.jpg";
   }
    %>
    <div class="page-wrapper doctris-theme toggled">
        <!-- Sidebar -->
        <jsp:include page="template/sidebar.jsp" />

        <!-- Main Content -->
        <main class="page-content bg-light">
            <!-- Header -->
            <jsp:include page="template/header.jsp" />

            <!-- Nội dung chính -->
            <div class="container-fluid">
                <div class="layout-specing">
               <div class="container">
        <h3 class="text-center">Bạn muốn làm gì khi kỳ hạn gửi tiền kết thúc?</h3>
        <p class="text-center text-muted">Vào <strong><%= formattedDate %> </strong></p>

        <form action="<%= request.getContextPath() %>/ProcessTermOptions" method="POST">
            <div class="option-box" onclick="selectOption(this)">
                <input type="radio" name="action" value="renewAll" id="renewAll" required>
                <label for="renewAll"><strong>Gửi tiếp cả tiền gốc và lãi</strong></label>
                <p class="text-muted">Tự động gửi tiếp cả gốc và lãi với kỳ hạn tương đương.</p>
            </div>

            <div class="option-box" onclick="selectOption(this)">
                <input type="radio" name="action" value="withdrawInterest" id="withdrawInterest" required>
                <label for="withdrawInterest"><strong>Rút tiền lãi và gửi tiếp gốc</strong></label>
                <p class="text-muted">Tiền gốc sẽ tự động gửi tiếp. Lãi sẽ được chuyển vào tài khoản thanh toán.</p>
            </div>

            <div class="option-box" onclick="selectOption(this)">
                <input type="radio" name="action" value="withdrawAll" id="withdrawAll" required>
                <label for="withdrawAll"><strong>Rút toàn bộ cả tiền gốc và lãi</strong></label>
                <p class="text-muted">Tự động chuyển tiền gốc và lãi vào tài khoản thanh toán.</p>
            </div>

            <div class="btn-group mt-3">
                <a href="chooseTerm.jsp" class="btn btn-outline-danger">Quay lại</a>
                <button type="submit" class="btn btn-danger">Tiếp tục</button>
            </div>
        </form>
    </div>
            </div>

            <!-- Footer -->
            <jsp:include page="template/footer.jsp" />
        </main>
    </div>

    <!-- Javascript -->
    <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/simplebar.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/apexcharts.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/columnchart.init.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
    <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
<script>
        function selectOption(optionBox) {
            document.querySelectorAll('.option-box').forEach(box => box.classList.remove('selected'));
            optionBox.classList.add('selected');
            optionBox.querySelector('input').checked = true;
        }
    </script>
</body>
</html>