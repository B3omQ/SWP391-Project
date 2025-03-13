<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>


<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="container mt-5" style="max-width: 600px;">
            <h3 class="text-center">Bạn muốn làm gì khi kỳ hạn gửi tiền kết thúc?</h3>
<p class="text-center text-muted">Vào <strong><%= session.getAttribute("maturityDate") %></strong></p>
            <form action="${pageContext.request.contextPath}/ProcessTermOptions" method="POST">
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

                <div class="btn-group mt-3 d-flex justify-content-between">
                    <a href="chooseTerm.jsp" class="btn btn-outline-danger">Quay lại</a>
                    <button type="submit" class="btn btn-danger">Tiếp tục</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>

<script>
    function selectOption(optionBox) {
        document.querySelectorAll('.option-box').forEach(box => box.classList.remove('selected'));
        optionBox.classList.add('selected');
        optionBox.querySelector('input').checked = true;
    }
</script>