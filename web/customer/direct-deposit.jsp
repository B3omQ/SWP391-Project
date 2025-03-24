<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="deposit-container" style="border: 2px solid #e63946; padding: 2rem; border-radius: 10px; background: #fff; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 600px; margin: 0 auto;">
            <div class="deposit-header" style="color: #e63946; font-weight: bold; font-size: 1.8rem; text-align: center; margin-bottom: 1.5rem; text-transform: uppercase;">
                Nạp Tiền Trực Tiếp Tại Quầy
            </div>
            <form action="${pageContext.request.contextPath}/DirectDepositServlet" method="post" id="depositForm" onsubmit="prepareForm()">
                <!-- Nhập số tiền -->
                <div class="mb-4">
                    <label for="amountDisplay" class="form-label" style="font-weight: 600; color: #333;">Số tiền cần nạp (VNĐ):</label>
                    <input type="text" class="form-control" id="amountDisplay" oninput="formatNumber(this)" required
                           style="border: 1px solid #e63946; border-radius: 8px; padding: 0.75rem; font-size: 1rem; transition: border-color 0.3s ease;">
                    <input type="hidden" id="amount" name="amount">
                    <small class="form-text text-muted">Tối thiểu: 10,000 VNĐ - Hỗ trợ nạp số lượng lớn</small>
                </div>

                <!-- Ghi chú -->
                <div class="mb-4">
                    <label for="note" class="form-label" style="font-weight: 600; color: #333;">Ghi chú (nếu có):</label>
                    <input type="text" class="form-control" id="note" name="note"
                           style="border: 1px solid #e63946; border-radius: 8px; padding: 0.75rem; font-size: 1rem; transition: border-color 0.3s ease;">
                </div>

                <!-- Thông tin bổ sung -->
                <div class="mb-4" style="background: #f8f9fa; padding: 1rem; border-radius: 8px;">
                    <ul style="list-style: none; padding: 0; margin: 0; color: #555; font-size: 0.9rem;">
                        <li style="margin-bottom: 0.5rem;"><i class="fas fa-money-bill-wave" style="color: #e63946; margin-right: 8px;"></i>Có thể nạp tiền mặt với số lượng lớn</li>
                        <li style="margin-bottom: 0.5rem;"><i class="fas fa-receipt" style="color: #e63946; margin-right: 8px;"></i>Nhận biên lai giao dịch để đối chiếu</li>
                        <li><i class="fas fa-user-check" style="color: #e63946; margin-right: 8px;"></i>Hỗ trợ trực tiếp từ nhân viên ngân hàng</li>
                    </ul>
                </div>

                <!-- Nút tạo phiếu và xem phiếu -->
                <div class="text-center">
                    <button type="submit" class="btn btn-deposit"
                            style="background-color: #e63946; color: white; border: none; padding: 0.75rem 2rem; border-radius: 8px; font-weight: 600; transition: background-color 0.3s ease;">
                        Tạo Phiếu Yêu Cầu
                    </button>
                    <a href="${pageContext.request.contextPath}/DirectDepositListServlet" class="btn btn-outline-deposit"
                       style="padding: 0.75rem 2rem; border: 1px solid #e63946; color: #e63946; border-radius: 8px; font-weight: 600; margin-left: 10px; transition: all 0.3s ease;">
                        Xem phiếu của tôi
                    </a>
                </div>
            </form>

            <!-- Hiển thị thông báo -->
            <% 
                String message = (String) session.getAttribute("message");
                String requestId = (String) session.getAttribute("requestId");
                if (message != null) {
                    out.println("<div class='alert alert-" + (message.contains("thành công") ? "success" : "danger") + " mt-4' style='border-radius: 8px;'>");
                    out.println("<i class='fas fa-" + (message.contains("thành công") ? "check-circle" : "exclamation-circle") + " me-2'></i>");
                    out.println(message);
                    if (requestId != null) {
                        out.println(" Mã phiếu: <strong>" + requestId + "</strong>. Vui lòng đến quầy giao dịch để hoàn tất.");
                    }
                    out.println("</div>");
                    session.removeAttribute("message");
                    session.removeAttribute("requestId");
                }
            %>
        </div>
    </div>
</div>

<!-- JavaScript để định dạng số tiền -->
<script>
    function formatNumber(input) {
        let value = input.value.replace(/[^0-9]/g, '');
        if (value) {
            input.value = parseInt(value).toLocaleString('vi-VN');
            document.getElementById("amount").value = value;
        } else {
            input.value = '';
            document.getElementById("amount").value = '';
        }
    }

    function prepareForm() {
        let displayInput = document.getElementById("amountDisplay");
        let hiddenInput = document.getElementById("amount");
        let value = displayInput.value.replace(/[^0-9]/g, '');
        hiddenInput.value = value;
    }
</script>

<!-- Thêm Font Awesome để hiển thị icon -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<%@ include file="template/footer.jsp" %>