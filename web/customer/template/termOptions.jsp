<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    int term = Integer.parseInt(request.getParameter("selectedTerm"));
    LocalDate today = LocalDate.now();
    LocalDate dueDate = today.plusMonths(term);
    String formattedDate = dueDate.format(DateTimeFormatter.ofPattern("dd MMMM yyyy"));
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lựa chọn khi kỳ hạn kết thúc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .option-box {
            border: 2px solid #ddd;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .option-box:hover {
            background: #e9ecef;
            border-color: #007bff;
        }
        .option-box input {
            margin-right: 10px;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>

<div class="container">
    <h3 class="text-center">Bạn muốn làm gì khi kỳ hạn gửi tiền kết thúc?</h3>
    <p class="text-center text-muted">Vào <strong><%= formattedDate %></strong></p>

    <div class="option-box" onclick="selectOption('renewAll')">
        <input type="radio" name="action" value="renewAll" id="renewAll">
        <label for="renewAll"><strong>Gửi tiếp cả tiền gốc và lãi</strong></label>
        <p class="text-muted">Tự động gửi tiếp cả gốc và lãi với kỳ hạn tương đương.</p>
    </div>

    <div class="option-box" onclick="selectOption('withdrawInterest')">
        <input type="radio" name="action" value="withdrawInterest" id="withdrawInterest">
        <label for="withdrawInterest"><strong>Rút tiền lãi và gửi tiếp gốc</strong></label>
        <p class="text-muted">Tiền gốc sẽ tự động gửi tiếp. Lãi sẽ được chuyển vào tài khoản thanh toán.</p>
    </div>

    <div class="option-box" onclick="selectOption('withdrawAll')">
        <input type="radio" name="action" value="withdrawAll" id="withdrawAll">
        <label for="withdrawAll"><strong>Rút toàn bộ cả tiền gốc và lãi</strong></label>
        <p class="text-muted">Tự động chuyển tiền gốc và lãi vào tài khoản thanh toán.</p>
    </div>

    <div class="btn-group mt-3">
        <button class="btn btn-outline-secondary" onclick="goBack()">Quay lại</button>
        <button class="btn btn-primary" onclick="submitChoice()">Tiếp tục</button>
    </div>
</div>

<script>
    function selectOption(value) {
        document.getElementById(value).checked = true;
    }

    function submitChoice() {
        let choice = document.querySelector('input[name="action"]:checked');
        if (choice) {
            window.location.href = "confirm.jsp?term=" + <%= term %> + "&action=" + choice.value;
        } else {
            alert("Vui lòng chọn một tùy chọn.");
        }
    }

    function goBack() {
        window.history.back();
    }
