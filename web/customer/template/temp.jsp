<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn Kỳ Hạn Gửi Tiết Kiệm</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        .term-box {
            border: 2px solid #ddd;
            padding: 15px;
            text-align: center;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .term-box:hover, .term-box.selected {
            border-color: #d70000;
            background-color: #f8d7da;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Chọn Kỳ Hạn Gửi Tiết Kiệm</h2>
        <div class="row mt-4">
            <%-- Kỳ hạn gửi tiết kiệm --%>
            <c:set var="terms" value="1,2,3,4,5,6,7,8,9,10,11,12,24,36" />
            <c:forEach var="term" items="${terms.split(',')}">
                <div class="col-md-6 mb-3">
                    <div class="term-box" onclick="selectTerm(${term})">
                        <h4>${term} tháng</h4>
                        <p>Số tiền lãi: <strong>VND ${term * 2000}</strong></p>
                        <p>Lãi suất: <strong>${3 + term * 0.1}%/năm</strong></p>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="text-center mt-4">
            <button class="btn btn-dark px-4 py-2" id="continueBtn" disabled onclick="goToNextStep()">
                Tiếp tục
            </button>
        </div>
    </div>
    <script>
        let selectedTerm = null;
        function selectTerm(term) {
            document.querySelectorAll('.term-box').forEach(box => box.classList.remove('selected'));
            event.currentTarget.classList.add('selected');
            selectedTerm = term;
            document.getElementById('continueBtn').disabled = false;
        }
        function goToNextStep() {
            if (selectedTerm) {
                window.location.href = 'confirmSaving.jsp?term=' + selectedTerm;
            }
        }
    </script>
</body>
</html>
