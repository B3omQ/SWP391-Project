<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    Object rawDepositAmount = session.getAttribute("depositAmount");
    Object rawSelectedTerm = session.getAttribute("selectedTerm");
    Object rawInterest = session.getAttribute("calculatedInterest");
    Object rawSavingRate = session.getAttribute("savingRate");
    Object rawMaturityDate = session.getAttribute("maturityDate");

    if (rawDepositAmount == null || rawSelectedTerm == null || rawInterest == null || 
        rawSavingRate == null || rawMaturityDate == null) {
        response.sendRedirect("chooseTerm.jsp?error=missing_data");
        return;
    }

    BigDecimal depositAmount = (BigDecimal) rawDepositAmount;
    int selectedTerm = (Integer) rawSelectedTerm;
    BigDecimal interestAmount = (BigDecimal) rawInterest;
    BigDecimal savingRate = (BigDecimal) rawSavingRate;
    String maturityDate = (String) rawMaturityDate;

    String selectedAction = (String) session.getAttribute("selectedAction");
    selectedAction = (selectedAction != null) ? selectedAction : "withdrawAll";

    // Lấy ngày hiện tại và định dạng
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    String effectiveDate = LocalDateTime.now().format(dateFormatter);

    DecimalFormat currencyFormat = new DecimalFormat("#,###");
%>

<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card p-4">
                        <h2 class="text-center">Xác nhận gửi tiết kiệm</h2>
                        <p class="text-center text-muted">Vào Tiền gửi Phát Lộc Online</p>
                        <hr>
                        <div class="row mb-3">
                            <div class="col-6">Số tiền gửi:</div>
                            <div class="col-6 text-end fw-bold">VND <%= currencyFormat.format(depositAmount) %></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">Lãi suất:</div>
                            <div class="col-6 text-end fw-bold"><%= savingRate %> %/năm</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">Ngày hiệu lực:</div>
                            <div class="col-6 text-end fw-bold"><%= effectiveDate %></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">Kỳ hạn:</div>
                            <div class="col-6 text-end fw-bold"><%= selectedTerm %> tháng</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">Số tiền lãi:</div>
                            <div class="col-6 text-end fw-bold">VND <%= currencyFormat.format(interestAmount) %></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">Ngày đến hạn:</div>
                            <div class="col-6 text-end fw-bold"><%= maturityDate %></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">Phương thức đáo hạn:</div>
                            <div class="col-6 text-end fw-bold">
                                <% 
                                    String maturityActionDisplay = (String) session.getAttribute("maturityActionDisplay");
                                    out.print(maturityActionDisplay != null ? maturityActionDisplay : "Rút toàn bộ gốc và lãi");
                                %>
                            </div>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between">
                            <a href="chooseTerm.jsp" class="btn btn-outline-secondary">Quay lại</a>
                            <form action="${pageContext.request.contextPath}/ConfirmDepositServlet" method="post">
                                <input type="hidden" name="depositAmount" value="<%= depositAmount %>">
                                <input type="hidden" name="selectedTerm" value="<%= selectedTerm %>">
                                <button type="submit" class="btn btn-custom">Xác nhận</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>