<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<jsp:include page="template/header.jsp" />
<jsp:include page="template/sidebar.jsp" />

<div class="container-fluid">
    <div class="layout-specing">
        <div class="deposit-container" style="border: 2px solid #dc3545; padding: 1rem; border-radius: 5px;">
            <div class="deposit-header" style="color: #dc3545; font-weight: bold; font-size: 1.5rem; margin-bottom: 1rem;">
                Nạp Tiền Trực Tiếp Tại Quầy
            </div>
            <form action="${pageContext.request.contextPath}/DirectDepositServlet" method="post" id="depositForm" onsubmit="prepareForm()">
                <!-- Nhập số tiền -->
                <div class="mb-3">
                    <label for="amountDisplay" class="form-label">Số tiền cần nạp (VNĐ):</label>
                    <input type="text" class="form-control" id="amountDisplay" oninput="formatNumber(this)" required
                           style="border: 1px solid #dc3545;">
                    <input type="hidden" id="amount" name="amount">
                    <small class="form-text text-muted">Tối thiểu: 10,000 VNĐ</small>
                </div>

                <!-- Ghi chú -->
                <div class="mb-3">
                    <label for="note" class="form-label">Ghi chú (nếu có):</label>
                    <input type="text" class="form-control" id="note" name="note"
                           style="border: 1px solid #dc3545;">
                </div>

                <!-- Nút tạo phiếu và xem phiếu -->
                <div>
                    <button type="submit" class="btn btn-deposit"
                            style="background-color: #dc3545; color: white; border: none; padding: 0.5rem 1rem; margin-right: 10px;">
                        Tạo Phiếu Yêu Cầu
                    </button>
                    <a href="${pageContext.request.contextPath}/DirectDepositListServlet" class="btn btn-secondary"
                       style="padding: 0.5rem 1rem; border: 1px solid #dc3545; color: #dc3545;">
                        Xem phiếu của tôi
                    </a>
                </div>
            </form>

            <!-- Hiển thị thông báo -->
            <% 
                String message = (String) session.getAttribute("message");
                String requestId = (String) session.getAttribute("requestId");
                if (message != null) {
                    out.println("<div class='alert alert-" + (message.contains("thành công") ? "success" : "danger") + " mt-3'>");
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
            document.getElementById("amount").value = value; // Lưu giá trị sạch vào hidden input
        } else {
            input.value = '';
            document.getElementById("amount").value = '';
        }
    }

    function prepareForm() {
        let displayInput = document.getElementById("amountDisplay");
        let hiddenInput = document.getElementById("amount");
        let value = displayInput.value.replace(/[^0-9]/g, '');
        hiddenInput.value = value; // Đảm bảo giá trị gửi đi là số nguyên thuần
    }
</script>

<jsp:include page="template/footer.jsp" />