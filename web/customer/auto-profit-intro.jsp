<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dal.CustomerDAO" %>
<%@ page import="model.Customer" %>
<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<% 
    CustomerDAO customerDAO = new CustomerDAO();
    int customerId = (session.getAttribute("account") != null) ? ((Customer) session.getAttribute("account")).getId() : 0;
    Customer customer = customerDAO.getCustomerById(customerId);
    pageContext.setAttribute("customerFromDB", customer);
%>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="card shadow-sm border-0 p-4" style="border-radius: 15px; background: #fff;">
                    <div class="text-center">
                        <!-- Tiêu đề -->
                        <h2 class="fs-3 fw-bold mb-3" style="color: #ff4d4f;">
                            <i class="fas fa-seedling me-2"></i> Sinh lời tự động
                        </h2>

                        <!-- Mô tả -->
                        <p class="text-muted mb-4">
                            Số dư trong ví của bạn sẽ được sinh lời hàng ngày theo lãi kép.<br>
                            Lãi suất hiện tại là 5% mỗi năm, được tính và cộng vào ví mỗi ngày.
                        </p>

                        <!-- Trạng thái -->
                        <div class="mb-4">
                            <c:choose>
                                <c:when test="${customerFromDB != null and customerFromDB.isAutoProfitEnabled}">
                                    <div class="d-flex justify-content-center align-items-center mb-2">
                                        <span class="badge bg-success fs-5 px-3 py-2 me-2">
                                            <i class="fas fa-check-circle me-1"></i> Đang bật
                                        </span>
                                    </div>
                                    <p class="text-muted">Chức năng sinh lời tự động đang hoạt động.</p>
                                </c:when>
                                <c:otherwise>
                                    <div class="d-flex justify-content-center align-items-center mb-2">
                                        <span class="badge bg-secondary fs-5 px-3 py-2 me-2">
                                            <i class="fas fa-times-circle me-1"></i> Đang tắt
                                        </span>
                                    </div>
                                    <p class="text-muted">Chức năng sinh lời tự động chưa được kích hoạt.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Nút bật/tắt -->
                        <div class="d-flex justify-content-center gap-3">
                            <c:choose>
                                <c:when test="${customerFromDB != null and customerFromDB.isAutoProfitEnabled}">
                                    <!-- Nếu đang bật, chỉ hiển thị nút tắt -->
                                    <form method="POST" action="${pageContext.request.contextPath}/AutoProfitServlet">
                                        <input type="hidden" name="confirm" value="no">
                                        <button type="submit" class="btn btn-danger px-4 py-2" style="border-radius: 10px;" onclick="return confirm('Bạn có muốn tắt chức năng sinh lời tự động không?')">
                                            <i class="fas fa-power-off me-2"></i> Tắt chức năng
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <!-- Nếu đang tắt, chỉ hiển thị nút bật -->
                                    <form method="POST" action="${pageContext.request.contextPath}/AutoProfitServlet">
                                        <input type="hidden" name="confirm" value="yes">
                                        <button type="submit" class="btn btn-success px-4 py-2" style="border-radius: 10px;" onclick="return confirm('Bạn có muốn bật chức năng sinh lời tự động không?')">
                                            <i class="fas fa-play me-2"></i> Bật chức năng
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .card {
        border-radius: 15px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
    }
    .btn-success, .btn-danger {
        font-weight: 500;
        transition: transform 0.2s ease, background-color 0.3s ease;
    }
    .btn-success:hover {
        background-color: #28a745;
        transform: scale(1.05);
    }
    .btn-danger:hover {
        background-color: #dc3545;
        transform: scale(1.05);
    }
    .badge {
        border-radius: 20px;
    }
</style>

<%@ include file="template/footer.jsp" %>