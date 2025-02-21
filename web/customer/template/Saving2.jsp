<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tiền Gửi Có Kỳ Hạn</title>
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
        .feature-box {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }
        .icon-large {
            font-size: 2rem;
            color: #d70000;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="text-center">
            <h2><i class="fas fa-piggy-bank"></i> Tiền gửi có kỳ hạn</h2>
            <p>Giữ tiền an toàn, sinh lời hấp dẫn với lãi suất lên đến 5%/năm.</p>
        </div>
        <div class="row text-center mt-4">
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-shield-alt icon-large"></i>
                    <p>An toàn và bảo mật tuyệt đối</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-percentage icon-large"></i>
                    <p>Nhận lãi suất đến 5%/năm</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-box">
                    <i class="fas fa-wallet icon-large"></i>
                    <p>Rút tiền linh hoạt theo nhu cầu</p>
                </div>
            </div>
        </div>
        <div class="text-center mt-4">
            <button class="btn btn-dark px-4 py-2" onclick="startSaving()"><i class="fas fa-play"></i> Bắt đầu ngay</button>
        </div>
    </div>

    <script>
        function startSaving() {
            window.location.href = 'savemoney.jsp';
        }
    </script>
</body>
</html>
