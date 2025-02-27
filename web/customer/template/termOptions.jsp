<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.Customer" %>
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


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chọn phương án gửi tiền</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
<body class="bg-light">
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

    <script>
        function selectOption(optionBox) {
            document.querySelectorAll('.option-box').forEach(box => box.classList.remove('selected'));
            optionBox.classList.add('selected');
            optionBox.querySelector('input').checked = true;
        }
    </script>
</body>
</html>