<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập Số Tiền Gửi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js" crossorigin="anonymous"></script>
    <style>
        .btn-custom {
            border: 2px solid #d70000;
            color: #d70000;
            font-weight: bold;
        }
        .btn-custom:hover {
            background-color: #d70000;
            color: white;
        }
        .amount-box {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
        }
        .quick-amount {
            background-color: #fff;
            border: 1px solid #d70000;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
        }
        .quick-amount:hover {
            background-color: #d70000;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center text-danger"><i class="fas fa-piggy-bank"></i> Nhập Số Tiền Gửi</h2>
        <form action="DepositValidationServlet" method="post">
            <h5>Từ tài khoản</h5>
            <div class="d-flex justify-content-between align-items-center p-3 border rounded">
                <span><i class="fas fa-wallet"></i> Tài khoản thanh toán</span>
                <span>VND 4,482,639</span>
            </div>
            <h5 class="mt-3">Số tiền gửi</h5>
            <input type="number" id="depositAmount" name="depositAmount" class="form-control" placeholder="Nhập số tiền" required>

            <div class="d-flex justify-content-around mt-3">
                <span class="quick-amount" onclick="setAmount(1000000)">1,000,000</span>
                <span class="quick-amount" onclick="setAmount(10000000)">10,000,000</span>
                <span class="quick-amount" onclick="setAmount(100000000)">100,000,000</span>
            </div>
            
            <div class="text-center mt-4">
                <button type="submit" id="continueBtn" class="btn btn-dark px-4 py-2">
                    <i class="fas fa-arrow-right"></i> Tiếp tục
                </button>
            </div>
        </form>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger mt-3">${sessionScope.error}</div>
            <% session.removeAttribute("error"); %>
        </c:if>
    </div>

    <script>
        function setAmount(amount) {
            document.getElementById('depositAmount').value = amount;
        }
    </script>
</body>
</html>
