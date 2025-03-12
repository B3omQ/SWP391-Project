<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="template/header.jsp" %>
<%@ include file="template/sidebar.jsp" %>

<div class="container-fluid">
    <div class="layout-specing">
        <div class="row justify-content-center">
            <div class="col-12 mb-3">
                <button class="btn btn-custom w-100 py-3 text-start d-flex flex-column" onclick="location.href='Termsavings.jsp'">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-piggy-bank fa-2x me-3"></i>
                        <span class="fs-5 fw-bold">Tiền gửi có kỳ hạn</span>
                    </div>
                    <small class="text-muted mt-1 ms-5">
                        Lãi suất hấp dẫn, bảo đảm an toàn, kỳ hạn linh hoạt.
                    </small>
                </button>
            </div>
            <div class="col-12">
                <button class="btn btn-custom w-100 py-3 text-start d-flex flex-column" onclick="location.href='auto-profit-intro.jsp'">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-seedling fa-2x me-3"></i>
                        <span class="fs-5 fw-bold">Sinh lời tự động</span>
                    </div>
                    <small class="text-muted mt-1 ms-5">
                        Tự động tái tục, tối ưu hóa lợi nhuận với lãi suất cao.
                    </small>
                </button>
            </div>
        </div>
    </div>
</div>

<%@ include file="template/footer.jsp" %>