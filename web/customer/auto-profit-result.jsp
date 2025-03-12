<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="card shadow-sm border-0 p-4" style="border-radius: 15px; background: #fff;">
                    <div class="text-center">
                        <h2 class="fs-3 fw-bold mb-4 text-primary">
                            <i class="fas fa-check-circle me-2"></i> Kết quả kích hoạt sinh lời tự động
                        </h2>
                        
                        <% if (request.getAttribute("message") != null) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <%= request.getAttribute("message") %>
                            </div>
                        <% } %>
                        
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <%= request.getAttribute("error") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        <% } %>
                        
                        <a href="${pageContext.request.contextPath}/AutoProfitServlet" class="btn btn-outline-primary mt-3" style="border-radius: 10px;">
                            <i class="fas fa-arrow-left me-2"></i> Quay lại
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
    }
    .btn-outline-primary:hover {
        transform: scale(1.05);
        transition: transform 0.2s ease;
    }
</style>

<%@ include file="template/footer.jsp" %>